Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E2D6AFC81
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 02:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjCHBnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 20:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCHBnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 20:43:01 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B591813D7E;
        Tue,  7 Mar 2023 17:42:58 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PWZnn2g9nz4f3l6y;
        Wed,  8 Mar 2023 09:42:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgC3YiAd6Adk67MfEg--.37952S4;
        Wed, 08 Mar 2023 09:42:55 +0800 (CST)
From:   Zhong Jinghua <zhongjinghua@huaweicloud.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongjinghua@huaweicloud.com, yi.zhang@huawei.com,
        yukuai3@huawei.com, houtao1@huawei.com
Subject: [PATCH-next v3] scsi: fix use-after-free problem in scsi_remove_target
Date:   Wed,  8 Mar 2023 10:06:05 +0800
Message-Id: <20230308020605.192257-1-zhongjinghua@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgC3YiAd6Adk67MfEg--.37952S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAryDZrW5ZF13CF4xtr47Arb_yoW5Xr47pF
        WrGw1Y9r4UJ3yv9w4rXa15Xry5Aa15KryYkFyxG3WfX3W5J34ayw1Ikr9rWF90yFWqga45
        GFs8Gw18tr4DCr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
        xKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
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
Signed-off-by: Zhong Jinghua <zhongjinghua@huaweicloud.com>
---
 v2: commit message: starget->reaf-> starget->reap_ref
 v3: modify comment

 drivers/scsi/scsi_sysfs.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index e7893835b99a..641ab71ca2a8 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1561,7 +1561,16 @@ void scsi_remove_target(struct device *dev)
 		    starget->state == STARGET_CREATED_REMOVE)
 			continue;
 		if (starget->dev.parent == dev || &starget->dev == dev) {
-			kref_get(&starget->reap_ref);
+			/*
+			 * If the reference count is already zero, skip
+			 * this target. Calling kref_get_unless_zero() if
+			 * the reference count is zero is safe because
+			 * scsi_target_destroy() will wait until the host
+			 * lock has been released before freeing starget.
+			 */
+			if (!kref_get_unless_zero(&starget->reap_ref))
+				continue;
+
 			if (starget->state == STARGET_CREATED)
 				starget->state = STARGET_CREATED_REMOVE;
 			else
-- 
2.31.1

