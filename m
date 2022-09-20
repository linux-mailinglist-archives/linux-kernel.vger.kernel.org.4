Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C665BE935
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiITOm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiITOmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:42:53 -0400
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9502152FDA;
        Tue, 20 Sep 2022 07:42:51 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [10.162.98.155])
        by mail-app4 (Coremail) with SMTP id cS_KCgAXjk1F0SljDTRgBg--.31525S2;
        Tue, 20 Sep 2022 22:42:22 +0800 (CST)
From:   Duoming Zhou <duoming@zju.edu.cn>
To:     linux-kernel@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, kuba@kernel.org, john.garry@huawei.com,
        gregkh@linuxfoundation.org, davem@davemloft.net,
        Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH] scsi: libsas: fix use-after-free bug in smp_execute_task_sg
Date:   Tue, 20 Sep 2022 22:42:13 +0800
Message-Id: <20220920144213.10536-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cS_KCgAXjk1F0SljDTRgBg--.31525S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJrWDZw1kGFykKrWUCw4Uurg_yoW8GFWkpF
        WkGF1jkFs5t3y8Ka1DWw4DWFy5Xa97AFyUCF45KayI9as3Xa43XFs5K3yftF48Ja40qF9x
        trs5ArykKF15JrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUka1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v
        1sIEY20_GFWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgUTAVZdtbjOIABDs+
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When executing SMP task failed, the smp_execute_task_sg()
calls del_timer() to delete the "slow_task->timer". However,
if the timer handler sas_task_internal_timedout() is running,
the del_timer() in smp_execute_task_sg() will not stop it
and the UAF bug will happen. The process is shown below:

      (thread 1)               |        (thread 2)
smp_execute_task_sg()          | sas_task_internal_timedout()
 ...                           |
 del_timer()                   |
 ...                           |  ...
 sas_free_task(task)           |
  kfree(task->slow_task) //FREE|
                               |  task->slow_task->... //USE

Fix by calling del_timer_sync() in smp_execute_task_sg(),
which makes sure the timer handler have finished before
the "task->slow_task" is deallocated.

Fixes: 2908d778ab3e ("[SCSI] aic94xx: new driver")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 drivers/scsi/libsas/sas_expander.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index fa2209080cc..5ce25183010 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -67,7 +67,7 @@ static int smp_execute_task_sg(struct domain_device *dev,
 		res = i->dft->lldd_execute_task(task, GFP_KERNEL);
 
 		if (res) {
-			del_timer(&task->slow_task->timer);
+			del_timer_sync(&task->slow_task->timer);
 			pr_notice("executing SMP task failed:%d\n", res);
 			break;
 		}
-- 
2.17.1

