Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1177F5E9876
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 06:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbiIZEhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 00:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbiIZEhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 00:37:00 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8A8023162
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 21:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=upktR
        5lgfIuLOHJPkkkdFm6RUFNixxRyonGuz72UZ2c=; b=mJJtnKOBeJeZVRVOuIUnV
        vnOwn4/ZyPHM4ncZrUdGT9frAENhzLo2qliz2ZK+SCqfNKNlodlloEf9SFbnCXrF
        pEGOT9XmfcdwSbNjYLF4VIcUoHUV51NIWRe7EEuUGR2bcPnLMi+Tbn8EYDbZ91Z/
        HQidZiqm17u8tjvuFc+6f0=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by smtp3 (Coremail) with SMTP id G9xpCgB3hWhDLDFjxP8ngg--.49616S2;
        Mon, 26 Sep 2022 12:36:19 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     dimitri.sivanich@hpe.com
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        alex000young@gmail.com, security@kernel.org,
        Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH] misc: sgi-gru: fix use-after-free error in  gru_set_context_option, gru_fault and gru_handle_user_call_os
Date:   Mon, 26 Sep 2022 12:36:18 +0800
Message-Id: <20220926043618.566326-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgB3hWhDLDFjxP8ngg--.49616S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr4xtF4UKw1fZr4DuFyfWFg_yoWrCF45pa
        12g348ArW3XF4rurs7ta1kWFW3Ca48JFW5Cr9rtwnY9w4FyFs8GryDJas0qr4DurW0qr4a
        yF45tFnI9an0gaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zROtxDUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiXAOIU1Xl4SnSDwAAsh
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

Reported-by: Zheng Wang <hackerzheng666@gmail.com>

Signed-off-by: Zheng Wang <zyytlz.wz@163.com>

---
 drivers/misc/sgi-gru/grufault.c  | 14 ++++++++++++--
 drivers/misc/sgi-gru/grumain.c   | 17 +++++++++++++----
 drivers/misc/sgi-gru/grutables.h |  2 +-
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
index d7ef61e602ed..2b5b049fbd38 100644
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
@@ -874,7 +880,7 @@ int gru_set_context_option(unsigned long arg)
 		} else {
 			gts->ts_user_blade_id = req.val1;
 			gts->ts_user_chiplet_id = req.val0;
-			gru_check_context_placement(gts);
+			ret = gru_check_context_placement(gts);
 		}
 		break;
 	case sco_gseg_owner:
@@ -889,6 +895,10 @@ int gru_set_context_option(unsigned long arg)
 		ret = -EINVAL;
 	}
 	gru_unlock_gts(gts);
+	if (ret) {
+		gru_unload_context(gts, 1);
+		ret = -EINVAL;
+	}
 
 	return ret;
 }
diff --git a/drivers/misc/sgi-gru/grumain.c b/drivers/misc/sgi-gru/grumain.c
index 9afda47efbf2..79903cf7e706 100644
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
 
 
@@ -919,6 +922,7 @@ vm_fault_t gru_fault(struct vm_fault *vmf)
 	struct gru_thread_state *gts;
 	unsigned long paddr, vaddr;
 	unsigned long expires;
+	int ret;
 
 	vaddr = vmf->address;
 	gru_dbg(grudev, "vma %p, vaddr 0x%lx (0x%lx)\n",
@@ -934,7 +938,12 @@ vm_fault_t gru_fault(struct vm_fault *vmf)
 	mutex_lock(&gts->ts_ctxlock);
 	preempt_disable();
 
-	gru_check_context_placement(gts);
+	ret = gru_check_context_placement(gts);
+	if (ret) {
+		mutex_unlock(&gts->ts_ctxlock);
+		gru_unload_context(gts, 1);
+		return ret;
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


