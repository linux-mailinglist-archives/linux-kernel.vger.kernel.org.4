Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558906ABECD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjCFLxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjCFLxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:53:34 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A52193D8;
        Mon,  6 Mar 2023 03:53:26 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PVcR451pVz4f3m6t;
        Mon,  6 Mar 2023 19:53:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgA35CEx1AVkJf_CEQ--.64549S4;
        Mon, 06 Mar 2023 19:53:22 +0800 (CST)
From:   Zhong Jinghua <zhongjinghua@huaweicloud.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongjinghua@huaweicloude.com, yi.zhang@huawei.com,
        yukuai3@huawei.com
Subject: [PATCH-next v2 Resend] scsi: fix use-after-free problem in scsi_remove_target
Date:   Mon,  6 Mar 2023 20:16:36 +0800
Message-Id: <20230306121636.3183761-1-zhongjinghua@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgA35CEx1AVkJf_CEQ--.64549S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAryDZrW5ZF13CF4xtr47Arb_yoW5WFyfpF
        WrGw4a9r45JrZY9ws8XF45XFy5Aa1YgryYkFyxG3WfX3W5JryYyw1SkF9ruFyqyFWqga45
        GFs5C3W8tr4DGrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
        c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
        CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
        MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Gr0_Zr
        1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnI
        WIevJa73UjIFyTuYvjxUOyCJDUUUU
X-CM-SenderInfo: x2kr0wpmlqwxtxd6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhong Jinghua <zhongjinghua@huawei.com>

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

 Resend: use .huaweicloud mailbox to send 

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

