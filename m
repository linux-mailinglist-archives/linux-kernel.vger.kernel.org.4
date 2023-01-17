Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB7F66D4C5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbjAQCzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235783AbjAQCzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:55:11 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E208E22DF0;
        Mon, 16 Jan 2023 18:52:57 -0800 (PST)
Received: from kwepemm600002.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NwtKG4p9qz16Mq8;
        Tue, 17 Jan 2023 10:35:14 +0800 (CST)
Received: from localhost.localdomain (10.175.127.227) by
 kwepemm600002.china.huawei.com (7.193.23.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 17 Jan 2023 10:36:55 +0800
From:   Zhong Jinghua <zhongjinghua@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <bvanassche@acm.org>, <emilne@redhat.com>, <hare@suse.de>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhongjinghua@huawei.com>, <yi.zhang@huawei.com>,
        <yukuai3@huawei.com>, <houtao1@huawei.com>
Subject: [PATCH] scsi: fix iscsi rescan fails to create block
Date:   Tue, 17 Jan 2023 11:01:14 +0800
Message-ID: <20230117030114.2131734-1-zhongjinghua@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600002.china.huawei.com (7.193.23.29)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the three iscsi operations delete, logout, and rescan are concurrent
at the same time, there is a probability of failure to add disk through
device_add_disk(). The concurrent process is as follows:

T0: scan host // echo 1 > /sys/devices/platform/host1/scsi_host/host1/scan
T1: delete target // echo 1 > /sys/devices/platform/host1/session1/target1:0:0/1:0:0:1/delete
T2: logout // iscsiadm -m node --login
T3: T2 scsi_queue_work
T4: T0 bus_probe_device

T0                          T1                     T2                     T3
scsi_scan_target
 mutex_lock(&shost->scan_mutex);
  __scsi_scan_target
   scsi_report_lun_scan
    scsi_add_lun
     scsi_sysfs_add_sdev
      device_add
       kobject_add
       //create session1/target1:0:0/1:0:0:1/
       ...
       bus_probe_device
       // Create block asynchronously
 mutex_unlock(&shost->scan_mutex);
                       sdev_store_delete
                        scsi_remove_device
                         device_remove_file
                          mutex_lock(scan_mutex)
                           __scsi_remove_device
                            res = scsi_device_set_state(sdev, SDEV_CANCEL)
                                             iscsi_if_recv_msg
                                              scsi_queue_work
                                                                 __iscsi_unbind_session
                                                                 session->target_id = ISCSI_MAX_TARGET
                                                                   __scsi_remove_target
                                                                   sdev->sdev_state == SDEV_CANCEL
                                                                   continue;
                                                                   // end, No delete kobject 1:0:0:1
                                             iscsi_if_recv_msg
                                              transport->destroy_session(session)
                                               __iscsi_destroy_session
                                               iscsi_session_teardown
                                                iscsi_remove_session
                                                 __iscsi_unbind_session
                                                  iscsi_session_event
                                                 device_del
                                                 // delete session
T4:
// create the block, its parent is 1:0:0:1
// If kobject 1:0:0:1 does not exist, it won't go down
__device_attach_async_helper
 device_lock
 ...
 __device_attach_driver
  driver_probe_device
   really_probe
    sd_probe
     device_add_disk
      register_disk
       device_add
      // error

The block is created after the seesion is deleted.
When T2 deletes the session, it will mark block'parent 1:0:01 as unusable:
T2
device_del
 kobject_del
  sysfs_remove_dir
   __kernfs_remove
   // Mark the children under the session as unusable
    while ((pos = kernfs_next_descendant_post(pos, kn)))
		if (kernfs_active(pos))
			atomic_add(KN_DEACTIVATED_BIAS, &pos->active);

Then, create the block:
T4
device_add
 kobject_add
  kobject_add_varg
   kobject_add_internal
    create_dir
     sysfs_create_dir_ns
      kernfs_create_dir_ns
       kernfs_add_one
        if ((parent->flags & KERNFS_ACTIVATED) && !kernfs_active(parent))
		goto out_unlock;
		// return error

This error will cause a warning:
kobject_add_internal failed for block (error: -2 parent: 1:0:0:1).
In the lower version (such as 5.10), there is no corresponding error handling, continuing
to go down will trigger a kernel panic, so cc stable.

Therefore, creating the block should not be done after deleting the session.
More practically, we should ensure that the target under the session is deleted first,
and then the session is deleted. In this way, there are two possibilities:

1) if the process(T1) of deleting the target execute first, it will grab the device_lock(),
and the process(T4) of creating the block will wait for the deletion to complete.
Then, block's parent 1:0:0:1 has been deleted, it won't go down.

2) if the process(T4) of creating block execute first, it will grab the device_lock(),
and the process(T1) of deleting the target will wait for the creation block to complete.
Then, the process(T2) of deleting the session should need wait for the deletion to complete.

Fix it by removing the judgment of state equal to SDEV_CANCEL in
__scsi_remove_target() to ensure the order of deletion. Then, it will wait for
T1's mutex_lock(scan_mutex) and device_del() in __scsi_remove_device() will wait for
T4's device_lock(dev).
But we found that such a fix would cause the previous problem:
commit 81b6c9998979 ("scsi: core: check for device state in __scsi_remove_target()").
So we use scsi_device_try_get() instead of get_devcie() to fix the previous problem.

Fixes: 81b6c9998979 ("scsi: core: check for device state in __scsi_remove_target()")
Cc: <stable@vger.kernel.org>
Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>
---
 drivers/scsi/scsi_sysfs.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 42db9c52208e..e7893835b99a 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1503,6 +1503,13 @@ void scsi_remove_device(struct scsi_device *sdev)
 }
 EXPORT_SYMBOL(scsi_remove_device);
 
+static int scsi_device_try_get(struct scsi_device *sdev)
+{
+	if (!kobject_get_unless_zero(&sdev->sdev_gendev.kobj))
+		return -ENXIO;
+	return 0;
+}
+
 static void __scsi_remove_target(struct scsi_target *starget)
 {
 	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
@@ -1521,9 +1528,7 @@ static void __scsi_remove_target(struct scsi_target *starget)
 		if (sdev->channel != starget->channel ||
 		    sdev->id != starget->id)
 			continue;
-		if (sdev->sdev_state == SDEV_DEL ||
-		    sdev->sdev_state == SDEV_CANCEL ||
-		    !get_device(&sdev->sdev_gendev))
+		if (scsi_device_try_get(sdev))
 			continue;
 		spin_unlock_irqrestore(shost->host_lock, flags);
 		scsi_remove_device(sdev);
-- 
2.31.1

