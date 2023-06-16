Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F17732B49
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245443AbjFPJWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbjFPJWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:22:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71798191;
        Fri, 16 Jun 2023 02:22:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BEFA61011;
        Fri, 16 Jun 2023 09:22:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BB9C433C0;
        Fri, 16 Jun 2023 09:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686907360;
        bh=Cr7VVccB8uslD6H1Rks/FobCq/NyeYEEWyypGmgKkiA=;
        h=From:To:Cc:Subject:Date:From;
        b=dTvM44ZXNSDFZVjiYgwjfbRy6+GClxKKzlxx1FBu02t+iOmlQ7e2ISPmW1iSVfpmX
         +Ayx7iH/zbCv3VOBRBi8VMAf20lpzSH2x8UkSSAu5wadLTisVTw+GsJYyv6/WXytIh
         z1D8iydKNBYM+MkkEGK+oOdDec0ZDaZrdq4nQlbPf+r2PQK+3F7I4EeM0bCzcMwd2f
         ZRHON5Y6cj3qyye0ixyVs4ykwgdY5mcyiy+PgIoinCS4FCjFWYVkTFCBBnwIKRvfzR
         xak12VDCWVECi/HWWmNG10zyF84XvGhsb8Cr3Y5qRuAWePN1Ls+kdw23ZuP4aT3CwA
         NBIR3IV3BrcKw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Kees Cook <keescook@chromium.org>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Krishna Gudipati <kgudipat@brocade.com>,
        James Bottomley <JBottomley@Parallels.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH 1/2] scsi: bfa: fix function pointer type mismatch for hcb_qe->cbfn
Date:   Fri, 16 Jun 2023 11:22:09 +0200
Message-Id: <20230616092233.3229414-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Some callback functions used here take a boolean argument, others
take a status argument. This breaks KCFI type checking, so clang
now warns about the function pointer cast:

drivers/scsi/bfa/bfad_bsg.c:2138:29: error: cast from 'void (*)(void *, enum bfa_status)' to 'bfa_cb_cbfn_t' (aka 'void (*)(void *, enum bfa_boolean)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]

Assuming the code is actually correct here and the callers always match
the argument types of the callee, rework this to replace the explicit
cast with a union of the two pointer types. This does not change the
behavior of the code, so if something is actually broken here, a larger
rework may be necessary.

Fixes: 37ea0558b87ab ("[SCSI] bfa: Added support to collect and reset fcport stats")
Fixes: 3ec4f2c8bff25 ("[SCSI] bfa: Added support to configure QOS and collect stats.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/bfa/bfa.h      |  9 ++++++++-
 drivers/scsi/bfa/bfa_core.c |  4 +---
 drivers/scsi/bfa/bfa_ioc.h  |  8 ++++++--
 drivers/scsi/bfa/bfad_bsg.c | 11 ++++-------
 4 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/bfa/bfa.h b/drivers/scsi/bfa/bfa.h
index 7bd2ba1ad4d11..f30fe324e6ecc 100644
--- a/drivers/scsi/bfa/bfa.h
+++ b/drivers/scsi/bfa/bfa.h
@@ -20,7 +20,6 @@
 struct bfa_s;
 
 typedef void (*bfa_isr_func_t) (struct bfa_s *bfa, struct bfi_msg_s *m);
-typedef void (*bfa_cb_cbfn_status_t) (void *cbarg, bfa_status_t status);
 
 /*
  * Interrupt message handlers
@@ -437,4 +436,12 @@ struct bfa_cb_pending_q_s {
 	(__qe)->data = (__data);				\
 } while (0)
 
+#define bfa_pending_q_init_status(__qe, __cbfn, __cbarg, __data) do {	\
+	bfa_q_qe_init(&((__qe)->hcb_qe.qe));			\
+	(__qe)->hcb_qe.cbfn_status = (__cbfn);			\
+	(__qe)->hcb_qe.cbarg = (__cbarg);			\
+	(__qe)->hcb_qe.pre_rmv = BFA_TRUE;			\
+	(__qe)->data = (__data);				\
+} while (0)
+
 #endif /* __BFA_H__ */
diff --git a/drivers/scsi/bfa/bfa_core.c b/drivers/scsi/bfa/bfa_core.c
index 6846ca8f7313c..3438d0b8ba062 100644
--- a/drivers/scsi/bfa/bfa_core.c
+++ b/drivers/scsi/bfa/bfa_core.c
@@ -1907,15 +1907,13 @@ bfa_comp_process(struct bfa_s *bfa, struct list_head *comp_q)
 	struct list_head		*qe;
 	struct list_head		*qen;
 	struct bfa_cb_qe_s	*hcb_qe;
-	bfa_cb_cbfn_status_t	cbfn;
 
 	list_for_each_safe(qe, qen, comp_q) {
 		hcb_qe = (struct bfa_cb_qe_s *) qe;
 		if (hcb_qe->pre_rmv) {
 			/* qe is invalid after return, dequeue before cbfn() */
 			list_del(qe);
-			cbfn = (bfa_cb_cbfn_status_t)(hcb_qe->cbfn);
-			cbfn(hcb_qe->cbarg, hcb_qe->fw_status);
+			hcb_qe->cbfn_status(hcb_qe->cbarg, hcb_qe->fw_status);
 		} else
 			hcb_qe->cbfn(hcb_qe->cbarg, BFA_TRUE);
 	}
diff --git a/drivers/scsi/bfa/bfa_ioc.h b/drivers/scsi/bfa/bfa_ioc.h
index 933a1c3890ff5..5e568d6d7b261 100644
--- a/drivers/scsi/bfa/bfa_ioc.h
+++ b/drivers/scsi/bfa/bfa_ioc.h
@@ -361,14 +361,18 @@ struct bfa_reqq_wait_s {
 	void	*cbarg;
 };
 
-typedef void	(*bfa_cb_cbfn_t) (void *cbarg, bfa_boolean_t complete);
+typedef void (*bfa_cb_cbfn_t) (void *cbarg, bfa_boolean_t complete);
+typedef void (*bfa_cb_cbfn_status_t) (void *cbarg, bfa_status_t status);
 
 /*
  * Generic BFA callback element.
  */
 struct bfa_cb_qe_s {
 	struct list_head	qe;
-	bfa_cb_cbfn_t	cbfn;
+	union {
+		bfa_cb_cbfn_status_t	cbfn_status;
+		bfa_cb_cbfn_t		cbfn;
+	};
 	bfa_boolean_t	once;
 	bfa_boolean_t	pre_rmv;	/* set for stack based qe(s) */
 	bfa_status_t	fw_status;	/* to access fw status in comp proc */
diff --git a/drivers/scsi/bfa/bfad_bsg.c b/drivers/scsi/bfa/bfad_bsg.c
index 520f9152f3bf2..c4b78ffb723bd 100644
--- a/drivers/scsi/bfa/bfad_bsg.c
+++ b/drivers/scsi/bfa/bfad_bsg.c
@@ -2135,8 +2135,7 @@ bfad_iocmd_fcport_get_stats(struct bfad_s *bfad, void *cmd)
 	struct bfa_cb_pending_q_s cb_qe;
 
 	init_completion(&fcomp.comp);
-	bfa_pending_q_init(&cb_qe, (bfa_cb_cbfn_t)bfad_hcb_comp,
-			   &fcomp, &iocmd->stats);
+	bfa_pending_q_init_status(&cb_qe, bfad_hcb_comp, &fcomp, &iocmd->stats);
 	spin_lock_irqsave(&bfad->bfad_lock, flags);
 	iocmd->status = bfa_fcport_get_stats(&bfad->bfa, &cb_qe);
 	spin_unlock_irqrestore(&bfad->bfad_lock, flags);
@@ -2159,7 +2158,7 @@ bfad_iocmd_fcport_reset_stats(struct bfad_s *bfad, void *cmd)
 	struct bfa_cb_pending_q_s cb_qe;
 
 	init_completion(&fcomp.comp);
-	bfa_pending_q_init(&cb_qe, (bfa_cb_cbfn_t)bfad_hcb_comp, &fcomp, NULL);
+	bfa_pending_q_init_status(&cb_qe, bfad_hcb_comp, &fcomp, NULL);
 
 	spin_lock_irqsave(&bfad->bfad_lock, flags);
 	iocmd->status = bfa_fcport_clear_stats(&bfad->bfa, &cb_qe);
@@ -2443,8 +2442,7 @@ bfad_iocmd_qos_get_stats(struct bfad_s *bfad, void *cmd)
 	struct bfa_fcport_s *fcport = BFA_FCPORT_MOD(&bfad->bfa);
 
 	init_completion(&fcomp.comp);
-	bfa_pending_q_init(&cb_qe, (bfa_cb_cbfn_t)bfad_hcb_comp,
-			   &fcomp, &iocmd->stats);
+	bfa_pending_q_init_status(&cb_qe, bfad_hcb_comp, &fcomp, &iocmd->stats);
 
 	spin_lock_irqsave(&bfad->bfad_lock, flags);
 	WARN_ON(!bfa_ioc_get_fcmode(&bfad->bfa.ioc));
@@ -2474,8 +2472,7 @@ bfad_iocmd_qos_reset_stats(struct bfad_s *bfad, void *cmd)
 	struct bfa_fcport_s *fcport = BFA_FCPORT_MOD(&bfad->bfa);
 
 	init_completion(&fcomp.comp);
-	bfa_pending_q_init(&cb_qe, (bfa_cb_cbfn_t)bfad_hcb_comp,
-			   &fcomp, NULL);
+	bfa_pending_q_init_status(&cb_qe, bfad_hcb_comp, &fcomp, NULL);
 
 	spin_lock_irqsave(&bfad->bfad_lock, flags);
 	WARN_ON(!bfa_ioc_get_fcmode(&bfad->bfa.ioc));
-- 
2.39.2

