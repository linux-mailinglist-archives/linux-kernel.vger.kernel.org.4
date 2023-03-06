Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3674A6ABE48
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjCFLgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjCFLfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:35:54 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6C925BAE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 03:35:30 -0800 (PST)
Received: from kwepemm600002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PVbzG1DFtznWDW;
        Mon,  6 Mar 2023 19:32:42 +0800 (CST)
Received: from localhost.localdomain (10.175.127.227) by
 kwepemm600002.china.huawei.com (7.193.23.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 19:35:27 +0800
From:   Zhong Jinghua <zhongjinghua@huawei.com>
To:     <dennis@kernel.org>, <tj@kernel.org>, <cl@linux.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <zhongjinghua@huawei.com>, <yi.zhang@huawei.com>,
        <yukuai3@huawei.com>, <chengzhihao1@huawei.com>
Subject: [PATCH-next v2] scsi: fix use-after-free problem in scsi_remove_target
Date:   Mon, 6 Mar 2023 19:58:40 +0800
Message-ID: <20230306115840.3156157-1-zhongjinghua@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600002.china.huawei.com (7.193.23.29)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A use-after-free problem like below:

BUG: KASAN: use-after-free in scsi_target_reap+0x6c/0x70

Workqueue: scsi_wq_1 __iscsi_unbind_session [scsi_transport_iscsi]
Call trace:
 dump_backtrace+0x0/0x320
 show_stack+0x24/0x30
 dump_stack+0xdc/0x128
 print_address_description+0x68/0x278
 kasan_report+0x1e4/0x308
 __asan_report_load4_noabort+0x30/0x40
 scsi_target_reap+0x6c/0x70
 scsi_remove_target+0x430/0x640
 __iscsi_unbind_session+0x164/0x268 [scsi_transport_iscsi]
 process_one_work+0x67c/0x1350
 worker_thread+0x370/0xf90
 kthread+0x2a4/0x320
 ret_from_fork+0x10/0x18

The problem is caused by a concurrency scenario:

T0: delete target
// echo 1 > /sys/devices/platform/host1/session1/target1:0:0/1:0:0:1/delete
T1: logout
// iscsiadm -m node --logout

T0							T1
 sdev_store_delete
  scsi_remove_device
   device_remove_file
    __scsi_remove_device
        					__iscsi_unbind_session
        					 scsi_remove_target
						  spin_lock_irqsave
        					  list_for_each_entry
     scsi_target_reap
     // starget->reap_ref 1 -> 0
     						  kref_get(&starget->reap_ref);
						  // warn use-after-free.
						  spin_unlock_irqrestore
      scsi_target_reap_ref_release
	scsi_target_destroy
	... // delete starget
						  scsi_target_reap
						  // UAF

When T0 reduces the reference count to 0, but has not been released,
T1 can still enter list_for_each_entry, and then kref_get reports UAF.

Fix it by using kref_get_unless_zero() to check for a reference count of
0.

Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>
---
 v2: commit message: "starget->reaf" -> "starget->reap_ref"
 comment: "If it is reduced to 0, it means that other processes are releasing it and there is no need to delete it again"
 ->
 "If the reference count is already zero, skip this target is safe  because scsi_target_destroy() will wait until the 
 host lock has been released before freeing starget."

 drivers/scsi/scsi_sysfs.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index e7893835b99a..12e8ed6d55cb 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1561,7 +1561,16 @@ void scsi_remove_target(struct device *dev)
 		    starget->state == STARGET_CREATED_REMOVE)
 			continue;
 		if (starget->dev.parent == dev || &starget->dev == dev) {
-			kref_get(&starget->reap_ref);
+
+			/*
+			 * If the reference count is already zero, skip this
+			 * target is safe  because scsi_target_destroy()
+			 * will wait until the host lock has been released
+			 * before freeing starget.
+			 */
+			if (!kref_get_unless_zero(&starget->reap_ref))
+				continue;
+
 			if (starget->state == STARGET_CREATED)
 				starget->state = STARGET_CREATED_REMOVE;
 			else
-- 
2.31.1

