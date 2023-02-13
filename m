Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17592693CD9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 04:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjBMDTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 22:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBMDTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 22:19:43 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0C79EFC;
        Sun, 12 Feb 2023 19:19:42 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PFV216Ngcz4f3m7B;
        Mon, 13 Feb 2023 11:19:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgBH9CFKrOljm6DaDA--.29473S4;
        Mon, 13 Feb 2023 11:19:39 +0800 (CST)
From:   Zhong Jinghua <zhongjinghua@huaweicloud.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongjinghua@huawei.com, yi.zhang@huawei.com, yukuai3@huawei.com
Subject: [PATCH-next] scsi: fix use-after-free problem in scsi_remove_target
Date:   Mon, 13 Feb 2023 11:43:21 +0800
Message-Id: <20230213034321.3261114-1-zhongjinghua@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgBH9CFKrOljm6DaDA--.29473S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WFW8Gw4UCFy7tw1Utr1DKFg_yoW5JF1fpF
        WrG34Y9r4UG39Y9ws5XF4rXFy5Aa1agry5uFyxW3WfXa45J34avw1SkF9ruas0yFWqga4U
        GF4kAF18tF4DCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
        c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
        CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
        MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr
        1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
        vfC2KfnxnUUI43ZEXa7IU8UfHUUUUUU==
X-CM-SenderInfo: x2kr0wpmlqwxtxd6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
     scsi_target_reap // starget->reaf 1 -> 0
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
 drivers/scsi/scsi_sysfs.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index e7893835b99a..0ad357ff4c59 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1561,7 +1561,17 @@ void scsi_remove_target(struct device *dev)
 		    starget->state == STARGET_CREATED_REMOVE)
 			continue;
 		if (starget->dev.parent == dev || &starget->dev == dev) {
-			kref_get(&starget->reap_ref);
+
+			/*
+			 * If starget->reap_ref is reduced to 0, it means
+			 * that other processes are releasing it and
+			 * there is no need to delete it again
+			 */
+			if (!kref_get_unless_zero(&starget->reap_ref)) {
+				spin_unlock_irqrestore(shost->host_lock, flags);
+				goto restart;
+			}
+
 			if (starget->state == STARGET_CREATED)
 				starget->state = STARGET_CREATED_REMOVE;
 			else
-- 
2.31.1

