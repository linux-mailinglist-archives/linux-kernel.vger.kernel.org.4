Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DDB60F106
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 09:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbiJ0HQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 03:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbiJ0HQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 03:16:05 -0400
Received: from mail-m975.mail.163.com (mail-m975.mail.163.com [123.126.97.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A73560681
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 00:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=OlIU5
        fJc8pMUTQC7qCFfxYrM3xqK66SMjS4S4frZ4EY=; b=OLqY1RUg+saqQsi0AMRO/
        asnarZZKIZ9O2KmWunFCzyIWusie/Fe/TXsShU/jckvkznON/4/nd2uNqxVudMrr
        tuzqNbtLXYGuSioEJaVSeI6XHuI9JPocCVjN3nGog9aIvQlgmHSazuClEILURg6x
        yzFA4Y3pYBwbw0cogsdVi8=
Received: from localhost.localdomain (unknown [111.206.145.21])
        by smtp5 (Coremail) with SMTP id HdxpCgBXXkrvL1pj_A6Bnw--.29726S2;
        Thu, 27 Oct 2022 15:14:55 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     gregkh@linuxfoundation.org
Cc:     zhengyejian1@huawei.com, dimitri.sivanich@hpe.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        alex000young@gmail.com, security@kernel.org, sivanich@hpe.com,
        lkp@intel.com, Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH v6] misc: sgi-gru: fix use-after-free error in  gru_set_context_option, gru_fault and gru_handle_user_call_os
Date:   Thu, 27 Oct 2022 15:14:53 +0800
Message-Id: <20221027071453.118394-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HdxpCgBXXkrvL1pj_A6Bnw--.29726S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr4xtF4UKF43Gr4kCw1UGFg_yoWrtr17pa
        1jg348urW3JF4Y9Fsrta1kXFW3Ca4kJFW5Gr9rt34ruw4rAFs8G34Dtas0qr4DurW8tF4a
        yr4rtFnI93Z0ga7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi-6pkUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiGg+nU1aEDQYWswAAsd
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gts may be freed in gru_check_chiplet_assignment.
The caller still use it after that, UAF happens.

Fix it by introducing a return value to see if it's in error path or not.
Free the gts in caller if gru_check_chiplet_assignment check failed.

Fixes: 55484c45dbec ("gru: allow users to specify gru chiplet 2")
Reported-by: Zheng Wang <hackerzheng666@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>

Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
---
v6:
- remove unused var checked by kernel test robot

v5:
- fix logical issue and remove unnecessary variable suggested by Dimitri Sivanich

v4:
- use VM_FAULT_NOPAGE as failure code in gru_fault and -EINVAL in other functions suggested by Yejian

v3:
- add preempt_enable and use VM_FAULT_NOPAGE as failure code suggested by Yejian

v2:
- commit message changes suggested by Greg

v1: https://lore.kernel.org/lkml/CAJedcCzY72jqgF-pCPtx66vXXwdPn-KMagZnqrxcpWw1NxTLaA@mail.gmail.com/
---
 drivers/misc/sgi-gru/grufault.c  | 14 ++++++++++++--
 drivers/misc/sgi-gru/grumain.c   | 16 ++++++++++++----
 drivers/misc/sgi-gru/grutables.h |  2 +-
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
index d7ef61e602ed..bdd515d33225 100644
--- a/drivers/misc/sgi-gru/grufault.c
+++ b/drivers/misc/sgi-gru/grufault.c
@@ -656,7 +656,9 @@ int gru_handle_user_call_os(unsigned long cb)
 	if (ucbnum >= gts->ts_cbr_au_count * GRU_CBR_AU_SIZE)
 		goto exit;
 
-	gru_check_context_placement(gts);
+	ret = gru_check_context_placement(gts);
+	if (ret)
+		goto err;
 
 	/*
 	 * CCH may contain stale data if ts_force_cch_reload is set.
@@ -677,6 +679,10 @@ int gru_handle_user_call_os(unsigned long cb)
 exit:
 	gru_unlock_gts(gts);
 	return ret;
+err:
+	gru_unlock_gts(gts);
+	gru_unload_context(gts, 1);
+	return -EINVAL;
 }
 
 /*
@@ -874,7 +880,11 @@ int gru_set_context_option(unsigned long arg)
 		} else {
 			gts->ts_user_blade_id = req.val1;
 			gts->ts_user_chiplet_id = req.val0;
-			gru_check_context_placement(gts);
+			if (gru_check_context_placement(gts)) {
+				gru_unlock_gts(gts);
+				gru_unload_context(gts, 1);
+				return -EINVAL;
+			}
 		}
 		break;
 	case sco_gseg_owner:
diff --git a/drivers/misc/sgi-gru/grumain.c b/drivers/misc/sgi-gru/grumain.c
index 9afda47efbf2..beba69fc3cd7 100644
--- a/drivers/misc/sgi-gru/grumain.c
+++ b/drivers/misc/sgi-gru/grumain.c
@@ -716,9 +716,10 @@ static int gru_check_chiplet_assignment(struct gru_state *gru,
  * chiplet. Misassignment can occur if the process migrates to a different
  * blade or if the user changes the selected blade/chiplet.
  */
-void gru_check_context_placement(struct gru_thread_state *gts)
+int gru_check_context_placement(struct gru_thread_state *gts)
 {
 	struct gru_state *gru;
+	int ret = 0;
 
 	/*
 	 * If the current task is the context owner, verify that the
@@ -727,14 +728,16 @@ void gru_check_context_placement(struct gru_thread_state *gts)
 	 */
 	gru = gts->ts_gru;
 	if (!gru || gts->ts_tgid_owner != current->tgid)
-		return;
+		return ret;
 
 	if (!gru_check_chiplet_assignment(gru, gts)) {
 		STAT(check_context_unload);
-		gru_unload_context(gts, 1);
+		ret = -EINVAL;
 	} else if (gru_retarget_intr(gts)) {
 		STAT(check_context_retarget_intr);
 	}
+
+	return ret;
 }
 
 
@@ -934,7 +937,12 @@ vm_fault_t gru_fault(struct vm_fault *vmf)
 	mutex_lock(&gts->ts_ctxlock);
 	preempt_disable();
 
-	gru_check_context_placement(gts);
+	if (gru_check_context_placement(gts)) {
+		preempt_enable();
+		mutex_unlock(&gts->ts_ctxlock);
+		gru_unload_context(gts, 1);
+		return VM_FAULT_NOPAGE;
+	}
 
 	if (!gts->ts_gru) {
 		STAT(load_user_context);
diff --git a/drivers/misc/sgi-gru/grutables.h b/drivers/misc/sgi-gru/grutables.h
index 5efc869fe59a..f4a5a787685f 100644
--- a/drivers/misc/sgi-gru/grutables.h
+++ b/drivers/misc/sgi-gru/grutables.h
@@ -632,7 +632,7 @@ extern int gru_user_flush_tlb(unsigned long arg);
 extern int gru_user_unload_context(unsigned long arg);
 extern int gru_get_exception_detail(unsigned long arg);
 extern int gru_set_context_option(unsigned long address);
-extern void gru_check_context_placement(struct gru_thread_state *gts);
+extern int gru_check_context_placement(struct gru_thread_state *gts);
 extern int gru_cpu_fault_map_id(void);
 extern struct vm_area_struct *gru_find_vma(unsigned long vaddr);
 extern void gru_flush_all_tlb(struct gru_state *gru);
-- 
2.25.1

