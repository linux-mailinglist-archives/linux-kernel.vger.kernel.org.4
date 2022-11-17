Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003F662DEA9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 15:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbiKQOtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 09:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbiKQOtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:49:33 -0500
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 592392496F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 06:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=dVUyL
        PAb6gzI8XbCZsHtM1m990u4NxC9ACv5+48r8FU=; b=Ct4hvXR/oo0bZSsxDB+t2
        OUtTr36iUqj0hh52f0U52lPXwRnfMSqhKhaDQsgZVaINWQG5Ur+NtOoQCwH4NU72
        0t38f8JxFKvug94ZTGSG00FirHqscYajbnuj9tdLkbGj3wIp11ngv07igHv9EcuU
        PwoCc7hQpma/iGDgnH0TVk=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by smtp4 (Coremail) with SMTP id HNxpCgD3PX7cSXZjBWjisg--.23803S2;
        Thu, 17 Nov 2022 22:49:00 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     gregkh@linuxfoundation.org
Cc:     zhengyejian1@huawei.com, dimitri.sivanich@hpe.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        alex000young@gmail.com, security@kernel.org, sivanich@hpe.com,
        lkp@intel.com, Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH v10 RESEND] misc: sgi-gru: fix use-after-free error in  gru_set_context_option, gru_fault and gru_handle_user_call_os
Date:   Thu, 17 Nov 2022 22:48:59 +0800
Message-Id: <20221117144859.4710-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgD3PX7cSXZjBWjisg--.23803S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKryxXr13Xr47uryDZw1DZFb_yoW7ZrWkpa
        1jg34F9rW3JF4avrsrta18XFW3CFykJFW5Gr9rKw1rur4rAFs8GryDtas8tr4DZrW0qF42
        yF4rtFnI93Z0vaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziaZXrUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiXBy8U1Xl40225gAAsh
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some bad situation, the gts may be freed gru_check_chiplet_assignment.
The call chain can be gru_unload_context->gru_free_gru_context->gts_drop
and kfree finally. However, the caller didn't know if the gts is freed
or not and use it afterwards. This will trigger a Use after Free bug.

Fix it by introducing a return value to see if it's in error path or not.
Free the gts in caller if gru_check_chiplet_assignment check failed.

Fixes: 55484c45dbec ("gru: allow users to specify gru chiplet 2")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
Acked-by: Dimitri Sivanich <sivanich@hpe.com>
---
v10:
- try again in gru_handle_user_call_osif gru_check_chiplet_assignment failed,
  return success in gru_set_context_optionif we have unloaded gts, change the
  comment, all suggested by Dimitri Sivanich.

v9:
- rewrite changelog and add comment in the code to make it more clear

v8:
- remove tested-by tag suggested by Greg

v7:
- fix some spelling problems suggested by Greg, change kernel test robot from reported-by tag to tested-by tag

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
 drivers/misc/sgi-gru/grufault.c  | 15 ++++++++++++---
 drivers/misc/sgi-gru/grumain.c   | 22 ++++++++++++++++++----
 drivers/misc/sgi-gru/grutables.h |  2 +-
 3 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
index d7ef61e602ed..ff2970fbd644 100644
--- a/drivers/misc/sgi-gru/grufault.c
+++ b/drivers/misc/sgi-gru/grufault.c
@@ -647,7 +647,8 @@ int gru_handle_user_call_os(unsigned long cb)
 	ucbnum = get_cb_number((void *)cb);
 	if ((cb & (GRU_HANDLE_STRIDE - 1)) || ucbnum >= GRU_NUM_CB)
 		return -EINVAL;
-
+
+again:
 	gts = gru_find_lock_gts(cb);
 	if (!gts)
 		return -EINVAL;
@@ -656,7 +657,11 @@ int gru_handle_user_call_os(unsigned long cb)
 	if (ucbnum >= gts->ts_cbr_au_count * GRU_CBR_AU_SIZE)
 		goto exit;
 
-	gru_check_context_placement(gts);
+	if (gru_check_context_placement(gts)) {
+		gru_unlock_gts(gts);
+		gru_unload_context(gts, 1);
+		goto again;
+	}
 
 	/*
 	 * CCH may contain stale data if ts_force_cch_reload is set.
@@ -874,7 +879,11 @@ int gru_set_context_option(unsigned long arg)
 		} else {
 			gts->ts_user_blade_id = req.val1;
 			gts->ts_user_chiplet_id = req.val0;
-			gru_check_context_placement(gts);
+			if (gru_check_context_placement(gts)) {
+				gru_unlock_gts(gts);
+				gru_unload_context(gts, 1);
+				return ret;
+			}
 		}
 		break;
 	case sco_gseg_owner:
diff --git a/drivers/misc/sgi-gru/grumain.c b/drivers/misc/sgi-gru/grumain.c
index 6706ef3c5977..5e5862e6ee6e 100644
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
@@ -726,15 +727,23 @@ void gru_check_context_placement(struct gru_thread_state *gts)
 	 * references. Pthread apps use non-owner references to the CBRs.
 	 */
 	gru = gts->ts_gru;
+	/*
+	 * If gru or gts->ts_tgid_owner isn't initialized properly, return
+	 * success to indicate that the caller does not need to unload the
+	 * gru context.The caller is responsible for their inspection and
+	 * reinitialization if needed.
+	 */
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
 
 
@@ -934,7 +943,12 @@ vm_fault_t gru_fault(struct vm_fault *vmf)
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
index 8c52776db234..640daf1994df 100644
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

