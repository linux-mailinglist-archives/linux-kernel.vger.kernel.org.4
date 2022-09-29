Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3F25F012F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 01:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiI2XDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 19:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiI2XDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 19:03:43 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48D41319AB
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 16:03:39 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id g1-20020a17090a708100b00203c1c66ae3so2691417pjk.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 16:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=1pCEg+AQdJmg+hQRK/9i+vPqdM2uLqq+eT6iuFqflGM=;
        b=HBHlUUpmZFZLo3vFY5IaRxONiYmLUKtzabxoIVc6WqNWVFRK0D49LmlfMrCboHByIA
         W2ZK4+/6tp2OfsH+Xkp8g7+SuoG+W+80jfnI6BrWJbnXUbcyPgYxgq3Nv3emXclJijfU
         R3d7HtZWw3uOkHnS0FjwMi9LHsRkzpbelbFrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=1pCEg+AQdJmg+hQRK/9i+vPqdM2uLqq+eT6iuFqflGM=;
        b=xHNz9I7EeJ56KneqyolOTvDWR1ks6Qpu6xK6uxjpu79G1vXbmHnrMbv6XVEhIqr467
         dNhv9GZkBTEZfqkSHXOwPY4eF4WV8KbiAB3h2BL0IPeufC4VYF3q1DyPrkmibq6MF/e0
         D77SVq5lYCTBtqMoYWGCdA/rM09OXil3z/gt5z1j+zsoSEj9YO0kK1fefv6sM1DoBDhs
         TaQoPWzPLFKRGxdfBCcO6NVmzuXSPzRH60gyiGSb39uU0THBcfPV0LYD3ndbBdOLJ+8e
         bIBJ5CLHhFxUq9XT8nlfJzUDWEPZJ/BePOoRwG8Pw9nJ6zTBuvsSL3XnheWpj5bniYSi
         +jeA==
X-Gm-Message-State: ACrzQf3rJBCJ+TyROGaBXKNjDAwnpx5+L3CkJvIypQGgEYpooOeDzY0Z
        6xLEizBI5+dlo4FTS4/mCA1MlA==
X-Google-Smtp-Source: AMsMyM5BCGspxGDfJifasmZ2iqJznBwh3vh/3pYb3HgrkHyeySCRh1v1habSjn6ILgJV7ejG9XxO9g==
X-Received: by 2002:a17:902:f54e:b0:178:a207:a58d with SMTP id h14-20020a170902f54e00b00178a207a58dmr5835944plf.92.1664492619156;
        Thu, 29 Sep 2022 16:03:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i20-20020a63e914000000b00434760ee36asm441254pgh.16.2022.09.29.16.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 16:03:38 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        llvm@lists.linux.dev, linux-scsi@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] scsi: bfa: Avoid clashing function prototypes
Date:   Thu, 29 Sep 2022 16:03:34 -0700
Message-Id: <20220929230334.2109344-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=28275; h=from:subject; bh=OrOMD+dxXQHttaMo0zwqV62stVW+KSRbccRJsdHsO3I=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjNiRGg7P5Hfmd1QCUq3PqCxl/ffpQV3pmIUp+KsfL +MVQYN6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYzYkRgAKCRCJcvTf3G3AJhNlD/ 9GDCbL2YqfiKTwSVAi7f8noAuc8prcdSqXtf6Y6FYz4WN6zFYKbqER8mmmiECKUKsNBHVLG6HtLInK 76pkijjHgUYm8/IHqg5Xbmi/lntxPxwEsBsspFoum1PWN0ju+mvqVQIUCWdoVMzykoj0FFWdLbzldX jilJxMkrJpj+J9GKGhwZrxWHpAZZmrPXmoytl0C2Y2RiKvYHNFsI0e1HDxRZmGFSSbuBX411NEHbIy LWJjS6Uh8k6uc/zeNK4CLqfEUrmPVSmx0z0BA2BXTtdOXG+Oya/sO0tOEVUGRphGvA+xuMKRhxZ3Yt x9UsCUPySQ/bGTmcQp4O7lwmAKZXhWexu0TKFlGJ56YRKFP/gHEGIsiEbnNrdJi1ZiCjP/2vo5abdj RSPRrngOHhu3tpKUqsTrFCrZU8MMR0bR+2yY+Ta5emI/8X7arRTEY8ldCR9sWt+ltAj3LhMFpvU2j6 mzNVUfuLCaiyBEI34RSOfo0QhOU2DFnO2xLPbVQd+iSnMhcfl2MsTsQBoqFeoo71Qb7GL+98//iGWl c9W98CCbYwpGluvLwywvnocWFb5JL4txJFQJX+WSpu8yRMKomOupEDYJ0kSoIezcLB9BQlkBIFPM/H nbYPKFVA0VaHzkv2XZKgDq3vBfVT+eeA8Ij416GH6hDhI8PdR6Ez0ylE1mSg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When built with Control Flow Integrity, function prototypes between
caller and function declaration must match. These mismatches are visible
at compile time with the new -Wcast-function-type-strict in Clang[1].
Of the 1549 warnings found, 1187 come from bfa alone. For example:

drivers/scsi/bfa/bfad.c:169:3: warning: cast from 'void (*)(struct bfad_s *, enum bfad_sm_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Wcast-function-type-strict]
                bfa_sm_set_state(bfad, bfad_sm_created);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The bfa state machine code heavily overloads its state machine functions,
so these have been separated into their own sets of structs, enums,
typedefs, and helper functions. There are almost zero binary code changes,
all seem to be related to header file line numbers changing, or the
addition of the new stats helper.

This patch is a cleanup based on Brad Spengler/PaX Team's modifications
to the bfa driver in their last public patch of grsecurity/PaX based
on my understanding of the code. Changes or omissions from the original
code are mine and don't reflect the original grsecurity/PaX code.

[1] https://reviews.llvm.org/D134831

Cc: Anil Gurumurthy <anil.gurumurthy@qlogic.com>
Cc: Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: llvm@lists.linux.dev
Cc: linux-scsi@vger.kernel.org
Reported-by: Sami Tolvanen <samitolvanen@google.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1724
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/scsi/bfa/bfa.h           |  4 ++-
 drivers/scsi/bfa/bfa_core.c      |  5 ++-
 drivers/scsi/bfa/bfa_cs.h        | 62 +++++++++++++++++++-------------
 drivers/scsi/bfa/bfa_fcpim.h     | 12 +++++--
 drivers/scsi/bfa/bfa_fcs.h       | 34 ++++++++++++------
 drivers/scsi/bfa/bfa_fcs_fcpim.c |  6 ++--
 drivers/scsi/bfa/bfa_fcs_lport.c |  4 +--
 drivers/scsi/bfa/bfa_fcs_rport.c |  4 +--
 drivers/scsi/bfa/bfa_ioc.c       |  8 ++---
 drivers/scsi/bfa/bfa_ioc.h       | 12 +++++--
 drivers/scsi/bfa/bfa_svc.c       | 12 +++----
 drivers/scsi/bfa/bfa_svc.h       | 20 ++++++++---
 drivers/scsi/bfa/bfad.c          | 10 ++++++
 drivers/scsi/bfa/bfad_bsg.c      |  8 ++---
 drivers/scsi/bfa/bfad_drv.h      |  5 ++-
 15 files changed, 134 insertions(+), 72 deletions(-)

diff --git a/drivers/scsi/bfa/bfa.h b/drivers/scsi/bfa/bfa.h
index 7bd2ba1ad4d1..04fddc479ec5 100644
--- a/drivers/scsi/bfa/bfa.h
+++ b/drivers/scsi/bfa/bfa.h
@@ -216,8 +216,10 @@ struct bfa_faa_args_s {
 	bfa_boolean_t		busy;
 };
 
+enum iocfc_event;
+
 struct bfa_iocfc_s {
-	bfa_fsm_t		fsm;
+	void (*fsm)(struct bfa_iocfc_s *s, enum iocfc_event e);
 	struct bfa_s		*bfa;
 	struct bfa_iocfc_cfg_s	cfg;
 	u32		req_cq_pi[BFI_IOC_MAX_CQS];
diff --git a/drivers/scsi/bfa/bfa_core.c b/drivers/scsi/bfa/bfa_core.c
index 6846ca8f7313..444197c62fe7 100644
--- a/drivers/scsi/bfa/bfa_core.c
+++ b/drivers/scsi/bfa/bfa_core.c
@@ -1907,15 +1907,14 @@ bfa_comp_process(struct bfa_s *bfa, struct list_head *comp_q)
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
+			hcb_qe->cbfn(hcb_qe->cbarg, hcb_qe->fw_status == BFA_STATUS_OK ?
+				     BFA_FALSE : BFA_TRUE);
 		} else
 			hcb_qe->cbfn(hcb_qe->cbarg, BFA_TRUE);
 	}
diff --git a/drivers/scsi/bfa/bfa_cs.h b/drivers/scsi/bfa/bfa_cs.h
index 6b606bf589b4..e3c1c9c47796 100644
--- a/drivers/scsi/bfa/bfa_cs.h
+++ b/drivers/scsi/bfa/bfa_cs.h
@@ -176,8 +176,6 @@ bfa_q_is_on_q_func(struct list_head *q, struct list_head *qe)
  * @ BFA state machine interfaces
  */
 
-typedef void (*bfa_sm_t)(void *sm, int event);
-
 /*
  * oc - object class eg. bfa_ioc
  * st - state, eg. reset
@@ -187,20 +185,45 @@ typedef void (*bfa_sm_t)(void *sm, int event);
 #define bfa_sm_state_decl(oc, st, otype, etype)		\
 	static void oc ## _sm_ ## st(otype * fsm, etype event)
 
-#define bfa_sm_set_state(_sm, _state)	((_sm)->sm = (bfa_sm_t)(_state))
+#define bfa_sm_set_state(_sm, _state)	((_sm)->sm = (_state))
 #define bfa_sm_send_event(_sm, _event)	((_sm)->sm((_sm), (_event)))
 #define bfa_sm_get_state(_sm)		((_sm)->sm)
-#define bfa_sm_cmp_state(_sm, _state)	((_sm)->sm == (bfa_sm_t)(_state))
+#define bfa_sm_cmp_state(_sm, _state)	((_sm)->sm == (_state))
 
 /*
  * For converting from state machine function to state encoding.
  */
-struct bfa_sm_table_s {
-	bfa_sm_t	sm;	/*  state machine function	*/
-	int		state;	/*  state machine encoding	*/
-	char		*name;	/*  state name for display	*/
-};
-#define BFA_SM(_sm)	((bfa_sm_t)(_sm))
+#define BFA_SM_TABLE(n, s, e, t)				\
+struct s;							\
+enum e;								\
+typedef void (*t)(struct s *, enum e);				\
+								\
+struct n ## _sm_table_s {					\
+	t		sm;	/* state machine function */	\
+	int		state;	/* state machine encoding */	\
+	char		*name;	/* state name for display */	\
+};								\
+								\
+static inline int						\
+n ## _sm_to_state(struct n ## _sm_table_s *smt, t sm)		\
+{								\
+	int	i = 0;						\
+								\
+	while (smt[i].sm && smt[i].sm != sm)			\
+		i++;						\
+	return smt[i].state;					\
+}
+
+BFA_SM_TABLE(iocpf,  bfa_iocpf_s,     iocpf_event,	   bfa_fsm_iocpf_t)
+BFA_SM_TABLE(ioc,    bfa_ioc_s,	      ioc_event,	   bfa_fsm_ioc_t)
+BFA_SM_TABLE(rport,  bfa_fcs_rport_s, rport_event,	   bfa_fcs_rport_t)
+BFA_SM_TABLE(vport,  bfa_fcs_vport_s, bfa_fcs_vport_event, bfa_fcs_vport_t)
+BFA_SM_TABLE(itnim,  bfa_fcs_itnim_s, bfa_fcs_itnim_event, bfa_fcs_itnim_t)
+BFA_SM_TABLE(fcport, bfa_fcport_s,    bfa_fcport_sm_event, bfa_fcport_t)
+
+#undef BFA_SM_TABLE
+
+#define BFA_SM(_sm)	(_sm)
 
 /*
  * State machine with entry actions.
@@ -214,28 +237,17 @@ typedef void (*bfa_fsm_t)(void *fsm, int event);
  * etype - object type, eg. enum ioc_event
  */
 #define bfa_fsm_state_decl(oc, st, otype, etype)		\
-	static void oc ## _sm_ ## st(otype * fsm, etype event);      \
+	static void oc ## _sm_ ## st(otype * fsm, etype event);	\
 	static void oc ## _sm_ ## st ## _entry(otype * fsm)
 
 #define bfa_fsm_set_state(_fsm, _state) do {	\
-	(_fsm)->fsm = (bfa_fsm_t)(_state);      \
-	_state ## _entry(_fsm);      \
+	(_fsm)->fsm = (_state);			\
+	_state ## _entry(_fsm);			\
 } while (0)
 
 #define bfa_fsm_send_event(_fsm, _event)	((_fsm)->fsm((_fsm), (_event)))
 #define bfa_fsm_get_state(_fsm)			((_fsm)->fsm)
-#define bfa_fsm_cmp_state(_fsm, _state)		\
-	((_fsm)->fsm == (bfa_fsm_t)(_state))
-
-static inline int
-bfa_sm_to_state(struct bfa_sm_table_s *smt, bfa_sm_t sm)
-{
-	int	i = 0;
-
-	while (smt[i].sm && smt[i].sm != sm)
-		i++;
-	return smt[i].state;
-}
+#define bfa_fsm_cmp_state(_fsm, _state)		((_fsm)->fsm == (_state))
 
 /*
  * @ Generic wait counter.
diff --git a/drivers/scsi/bfa/bfa_fcpim.h b/drivers/scsi/bfa/bfa_fcpim.h
index 8bf09433549b..459bd2308bcf 100644
--- a/drivers/scsi/bfa/bfa_fcpim.h
+++ b/drivers/scsi/bfa/bfa_fcpim.h
@@ -157,9 +157,11 @@ struct bfa_fcp_mod_s {
 /*
  * BFA IO (initiator mode)
  */
+enum bfa_ioim_event;
+
 struct bfa_ioim_s {
 	struct list_head	qe;		/*  queue elememt	*/
-	bfa_sm_t		sm;		/*  BFA ioim state machine */
+	void (*sm)(struct bfa_ioim_s *s, enum bfa_ioim_event e);/*  BFA ioim state machine */
 	struct bfa_s		*bfa;		/*  BFA module	*/
 	struct bfa_fcpim_s	*fcpim;		/*  parent fcpim module */
 	struct bfa_itnim_s	*itnim;		/*  i-t-n nexus for this IO  */
@@ -189,9 +191,11 @@ struct bfa_ioim_sp_s {
 /*
  * BFA Task management command (initiator mode)
  */
+enum bfa_tskim_event;
+
 struct bfa_tskim_s {
 	struct list_head	qe;
-	bfa_sm_t		sm;
+	void (*sm)(struct bfa_tskim_s *s, enum bfa_tskim_event e);
 	struct bfa_s		*bfa;	/*  BFA module  */
 	struct bfa_fcpim_s	*fcpim;	/*  parent fcpim module	*/
 	struct bfa_itnim_s	*itnim;	/*  i-t-n nexus for this IO  */
@@ -211,9 +215,11 @@ struct bfa_tskim_s {
 /*
  * BFA i-t-n (initiator mode)
  */
+enum bfa_itnim_event;
+
 struct bfa_itnim_s {
 	struct list_head	qe;	/*  queue element	*/
-	bfa_sm_t		sm;	/*  i-t-n im BFA state machine  */
+	void (*sm)(struct bfa_itnim_s *s, enum bfa_itnim_event e);/*  i-t-n im BFA state machine  */
 	struct bfa_s		*bfa;	/*  bfa instance	*/
 	struct bfa_rport_s	*rport;	/*  bfa rport	*/
 	void			*ditn;	/*  driver i-t-n structure	*/
diff --git a/drivers/scsi/bfa/bfa_fcs.h b/drivers/scsi/bfa/bfa_fcs.h
index c1baf5cd0d3e..8ae591dcfdfc 100644
--- a/drivers/scsi/bfa/bfa_fcs.h
+++ b/drivers/scsi/bfa/bfa_fcs.h
@@ -59,8 +59,10 @@ struct bfa_fcs_s;
 #define BFA_FCS_PID_IS_WKA(pid)  ((bfa_ntoh3b(pid) > 0xFFF000) ?  1 : 0)
 #define BFA_FCS_MAX_RPORT_LOGINS 1024
 
+enum vport_ns_event;
+
 struct bfa_fcs_lport_ns_s {
-	bfa_sm_t        sm;		/*  state machine */
+	void (*sm)(struct bfa_fcs_lport_ns_s *s, enum vport_ns_event e);/* state machine */
 	struct bfa_timer_s timer;
 	struct bfa_fcs_lport_s *port;	/*  parent port */
 	struct bfa_fcxp_s *fcxp;
@@ -69,18 +71,20 @@ struct bfa_fcs_lport_ns_s {
 	u8	num_rsnn_nn_retries;
 };
 
+enum port_scn_event;
 
 struct bfa_fcs_lport_scn_s {
-	bfa_sm_t        sm;		/*  state machine */
+	void (*sm)(struct bfa_fcs_lport_scn_s *s, enum port_scn_event e);/* state machine */
 	struct bfa_timer_s timer;
 	struct bfa_fcs_lport_s *port;	/*  parent port */
 	struct bfa_fcxp_s *fcxp;
 	struct bfa_fcxp_wqe_s fcxp_wqe;
 };
 
+enum port_fdmi_event;
 
 struct bfa_fcs_lport_fdmi_s {
-	bfa_sm_t        sm;		/*  state machine */
+	void (*sm)(struct bfa_fcs_lport_fdmi_s *s, enum port_fdmi_event e);/* state machine */
 	struct bfa_timer_s timer;
 	struct bfa_fcs_lport_ms_s *ms;	/*  parent ms */
 	struct bfa_fcxp_s *fcxp;
@@ -89,9 +93,10 @@ struct bfa_fcs_lport_fdmi_s {
 	u8	rsvd[3];
 };
 
+enum port_ms_event;
 
 struct bfa_fcs_lport_ms_s {
-	bfa_sm_t        sm;		/*  state machine */
+	void (*sm)(struct bfa_fcs_lport_ms_s *s, enum port_ms_event e);/*  state machine */
 	struct bfa_timer_s timer;
 	struct bfa_fcs_lport_s *port;	/*  parent port */
 	struct bfa_fcxp_s *fcxp;
@@ -131,10 +136,11 @@ union bfa_fcs_lport_topo_u {
 	struct bfa_fcs_lport_n2n_s pn2n;
 };
 
+enum bfa_fcs_lport_event;
 
 struct bfa_fcs_lport_s {
 	struct list_head         qe;	/*  used by port/vport */
-	bfa_sm_t               sm;	/*  state machine */
+	void (*sm)(struct bfa_fcs_lport_s *s, enum bfa_fcs_lport_event e); /* state machine */
 	struct bfa_fcs_fabric_s *fabric;	/*  parent fabric */
 	struct bfa_lport_cfg_s  port_cfg;	/*  port configuration */
 	struct bfa_timer_s link_timer;	/*  timer for link offline */
@@ -171,10 +177,11 @@ enum bfa_fcs_fabric_type {
 	BFA_FCS_FABRIC_LOOP = 3,
 };
 
+enum bfa_fcs_fabric_event;
 
 struct bfa_fcs_fabric_s {
 	struct list_head   qe;		/*  queue element */
-	bfa_sm_t	 sm;		/*  state machine */
+	void (*sm)(struct bfa_fcs_fabric_s *s, enum bfa_fcs_fabric_event e); /* state machine */
 	struct bfa_fcs_s *fcs;		/*  FCS instance */
 	struct bfa_fcs_lport_s  bport;	/*  base logical port */
 	enum bfa_fcs_fabric_type fab_type; /*  fabric type */
@@ -344,9 +351,11 @@ void            bfa_fcs_lport_scn_process_rscn(struct bfa_fcs_lport_s *port,
 					      struct fchs_s *rx_frame, u32 len);
 void		bfa_fcs_lport_lip_scn_online(bfa_fcs_lport_t *port);
 
+enum bfa_fcs_vport_event;
+
 struct bfa_fcs_vport_s {
 	struct list_head		qe;		/*  queue elem	*/
-	bfa_sm_t		sm;		/*  state machine	*/
+	void (*sm)(struct bfa_fcs_vport_s *s, enum bfa_fcs_vport_event e);/* state machine */
 	bfa_fcs_lport_t		lport;		/*  logical port	*/
 	struct bfa_timer_s	timer;
 	struct bfad_vport_s	*vport_drv;	/*  Driver private	*/
@@ -398,8 +407,10 @@ struct bfa_fcs_tin_s;
 struct bfa_fcs_iprp_s;
 
 /* Rport Features (RPF) */
+enum rpf_event;
+
 struct bfa_fcs_rpf_s {
-	bfa_sm_t	sm;	/*  state machine */
+	void (*sm)(struct bfa_fcs_rpf_s *s, enum rpf_event e); /* state machine */
 	struct bfa_fcs_rport_s *rport;	/*  parent rport */
 	struct bfa_timer_s	timer;	/*  general purpose timer */
 	struct bfa_fcxp_s	*fcxp;	/*  FCXP needed for discarding */
@@ -414,6 +425,8 @@ struct bfa_fcs_rpf_s {
 	 */
 };
 
+enum rport_event;
+
 struct bfa_fcs_rport_s {
 	struct list_head	qe;	/*  used by port/vport */
 	struct bfa_fcs_lport_s *port;	/*  parent FCS port */
@@ -430,7 +443,7 @@ struct bfa_fcs_rport_s {
 	wwn_t	pwwn;	/*  port wwn of rport */
 	wwn_t	nwwn;	/*  node wwn of rport */
 	struct bfa_rport_symname_s psym_name; /*  port symbolic name  */
-	bfa_sm_t	sm;		/*  state machine */
+	void (*sm)(struct bfa_fcs_rport_s *s, enum rport_event e); /* state machine */
 	struct bfa_timer_s timer;	/*  general purpose timer */
 	struct bfa_fcs_itnim_s *itnim;	/*  ITN initiator mode role */
 	struct bfa_fcs_tin_s *tin;	/*  ITN initiator mode role */
@@ -491,9 +504,10 @@ void  bfa_fcs_rpf_rport_offline(struct bfa_fcs_rport_s *rport);
  * forward declarations
  */
 struct bfad_itnim_s;
+enum bfa_fcs_itnim_event;
 
 struct bfa_fcs_itnim_s {
-	bfa_sm_t		sm;		/*  state machine */
+	void (*sm)(struct bfa_fcs_itnim_s *s, enum bfa_fcs_itnim_event e);/*  state machine */
 	struct bfa_fcs_rport_s	*rport;		/*  parent remote rport  */
 	struct bfad_itnim_s	*itnim_drv;	/*  driver peer instance */
 	struct bfa_fcs_s	*fcs;		/*  fcs instance	*/
diff --git a/drivers/scsi/bfa/bfa_fcs_fcpim.c b/drivers/scsi/bfa/bfa_fcs_fcpim.c
index c7de62baeec9..27ccaf6a4786 100644
--- a/drivers/scsi/bfa/bfa_fcs_fcpim.c
+++ b/drivers/scsi/bfa/bfa_fcs_fcpim.c
@@ -52,7 +52,7 @@ static void	bfa_fcs_itnim_sm_hcb_offline(struct bfa_fcs_itnim_s *itnim,
 static void	bfa_fcs_itnim_sm_initiator(struct bfa_fcs_itnim_s *itnim,
 					   enum bfa_fcs_itnim_event event);
 
-static struct bfa_sm_table_s itnim_sm_table[] = {
+static struct itnim_sm_table_s itnim_sm_table[] = {
 	{BFA_SM(bfa_fcs_itnim_sm_offline), BFA_ITNIM_OFFLINE},
 	{BFA_SM(bfa_fcs_itnim_sm_prli_send), BFA_ITNIM_PRLI_SEND},
 	{BFA_SM(bfa_fcs_itnim_sm_prli), BFA_ITNIM_PRLI_SENT},
@@ -665,7 +665,7 @@ bfa_status_t
 bfa_fcs_itnim_get_online_state(struct bfa_fcs_itnim_s *itnim)
 {
 	bfa_trc(itnim->fcs, itnim->rport->pid);
-	switch (bfa_sm_to_state(itnim_sm_table, itnim->sm)) {
+	switch (itnim_sm_to_state(itnim_sm_table, itnim->sm)) {
 	case BFA_ITNIM_ONLINE:
 	case BFA_ITNIM_INITIATIOR:
 		return BFA_STATUS_OK;
@@ -765,7 +765,7 @@ bfa_fcs_itnim_attr_get(struct bfa_fcs_lport_s *port, wwn_t rpwwn,
 	if (itnim == NULL)
 		return BFA_STATUS_NO_FCPIM_NEXUS;
 
-	attr->state	    = bfa_sm_to_state(itnim_sm_table, itnim->sm);
+	attr->state	    = itnim_sm_to_state(itnim_sm_table, itnim->sm);
 	attr->retry	    = itnim->seq_rec;
 	attr->rec_support   = itnim->rec_support;
 	attr->conf_comp	    = itnim->conf_comp;
diff --git a/drivers/scsi/bfa/bfa_fcs_lport.c b/drivers/scsi/bfa/bfa_fcs_lport.c
index b12afcc4b189..c84c526f85f5 100644
--- a/drivers/scsi/bfa/bfa_fcs_lport.c
+++ b/drivers/scsi/bfa/bfa_fcs_lport.c
@@ -6037,7 +6037,7 @@ static void	bfa_fcs_vport_sm_stopping(struct bfa_fcs_vport_s *vport,
 static void	bfa_fcs_vport_sm_logo_for_stop(struct bfa_fcs_vport_s *vport,
 					enum bfa_fcs_vport_event event);
 
-static struct bfa_sm_table_s  vport_sm_table[] = {
+static struct vport_sm_table_s vport_sm_table[] = {
 	{BFA_SM(bfa_fcs_vport_sm_uninit), BFA_FCS_VPORT_UNINIT},
 	{BFA_SM(bfa_fcs_vport_sm_created), BFA_FCS_VPORT_CREATED},
 	{BFA_SM(bfa_fcs_vport_sm_offline), BFA_FCS_VPORT_OFFLINE},
@@ -6864,7 +6864,7 @@ bfa_fcs_vport_get_attr(struct bfa_fcs_vport_s *vport,
 	memset(attr, 0, sizeof(struct bfa_vport_attr_s));
 
 	bfa_fcs_lport_get_attr(&vport->lport, &attr->port_attr);
-	attr->vport_state = bfa_sm_to_state(vport_sm_table, vport->sm);
+	attr->vport_state = vport_sm_to_state(vport_sm_table, vport->sm);
 }
 
 
diff --git a/drivers/scsi/bfa/bfa_fcs_rport.c b/drivers/scsi/bfa/bfa_fcs_rport.c
index c21aa37b8adb..6db306c600e5 100644
--- a/drivers/scsi/bfa/bfa_fcs_rport.c
+++ b/drivers/scsi/bfa/bfa_fcs_rport.c
@@ -136,7 +136,7 @@ static void	bfa_fcs_rport_sm_fc4_off_delete(struct bfa_fcs_rport_s *rport,
 static void	bfa_fcs_rport_sm_delete_pending(struct bfa_fcs_rport_s *rport,
 						enum rport_event event);
 
-static struct bfa_sm_table_s rport_sm_table[] = {
+static struct rport_sm_table_s rport_sm_table[] = {
 	{BFA_SM(bfa_fcs_rport_sm_uninit), BFA_RPORT_UNINIT},
 	{BFA_SM(bfa_fcs_rport_sm_plogi_sending), BFA_RPORT_PLOGI},
 	{BFA_SM(bfa_fcs_rport_sm_plogiacc_sending), BFA_RPORT_ONLINE},
@@ -2964,7 +2964,7 @@ bfa_fcs_rport_send_ls_rjt(struct bfa_fcs_rport_s *rport, struct fchs_s *rx_fchs,
 int
 bfa_fcs_rport_get_state(struct bfa_fcs_rport_s *rport)
 {
-	return bfa_sm_to_state(rport_sm_table, rport->sm);
+	return rport_sm_to_state(rport_sm_table, rport->sm);
 }
 
 
diff --git a/drivers/scsi/bfa/bfa_ioc.c b/drivers/scsi/bfa/bfa_ioc.c
index 5740302d83ac..9e19e4f5f6bc 100644
--- a/drivers/scsi/bfa/bfa_ioc.c
+++ b/drivers/scsi/bfa/bfa_ioc.c
@@ -140,7 +140,7 @@ bfa_fsm_state_decl(bfa_ioc, disabling, struct bfa_ioc_s, enum ioc_event);
 bfa_fsm_state_decl(bfa_ioc, disabled, struct bfa_ioc_s, enum ioc_event);
 bfa_fsm_state_decl(bfa_ioc, hwfail, struct bfa_ioc_s, enum ioc_event);
 
-static struct bfa_sm_table_s ioc_sm_table[] = {
+static struct ioc_sm_table_s ioc_sm_table[] = {
 	{BFA_SM(bfa_ioc_sm_uninit), BFA_IOC_UNINIT},
 	{BFA_SM(bfa_ioc_sm_reset), BFA_IOC_RESET},
 	{BFA_SM(bfa_ioc_sm_enabling), BFA_IOC_ENABLING},
@@ -228,7 +228,7 @@ bfa_fsm_state_decl(bfa_iocpf, disabling_sync, struct bfa_iocpf_s,
 						enum iocpf_event);
 bfa_fsm_state_decl(bfa_iocpf, disabled, struct bfa_iocpf_s, enum iocpf_event);
 
-static struct bfa_sm_table_s iocpf_sm_table[] = {
+static struct iocpf_sm_table_s iocpf_sm_table[] = {
 	{BFA_SM(bfa_iocpf_sm_reset), BFA_IOCPF_RESET},
 	{BFA_SM(bfa_iocpf_sm_fwcheck), BFA_IOCPF_FWMISMATCH},
 	{BFA_SM(bfa_iocpf_sm_mismatch), BFA_IOCPF_FWMISMATCH},
@@ -2815,12 +2815,12 @@ enum bfa_ioc_state
 bfa_ioc_get_state(struct bfa_ioc_s *ioc)
 {
 	enum bfa_iocpf_state iocpf_st;
-	enum bfa_ioc_state ioc_st = bfa_sm_to_state(ioc_sm_table, ioc->fsm);
+	enum bfa_ioc_state ioc_st = ioc_sm_to_state(ioc_sm_table, ioc->fsm);
 
 	if (ioc_st == BFA_IOC_ENABLING ||
 		ioc_st == BFA_IOC_FAIL || ioc_st == BFA_IOC_INITFAIL) {
 
-		iocpf_st = bfa_sm_to_state(iocpf_sm_table, ioc->iocpf.fsm);
+		iocpf_st = iocpf_sm_to_state(iocpf_sm_table, ioc->iocpf.fsm);
 
 		switch (iocpf_st) {
 		case BFA_IOCPF_SEMWAIT:
diff --git a/drivers/scsi/bfa/bfa_ioc.h b/drivers/scsi/bfa/bfa_ioc.h
index 933a1c3890ff..ea6546458547 100644
--- a/drivers/scsi/bfa/bfa_ioc.h
+++ b/drivers/scsi/bfa/bfa_ioc.h
@@ -282,16 +282,20 @@ struct bfa_ioc_notify_s {
 	(__notify)->cbarg = (__cbarg);      \
 } while (0)
 
+enum iocpf_event;
+
 struct bfa_iocpf_s {
-	bfa_fsm_t		fsm;
+	void (*fsm)(struct bfa_iocpf_s *s, enum iocpf_event e);
 	struct bfa_ioc_s	*ioc;
 	bfa_boolean_t		fw_mismatch_notified;
 	bfa_boolean_t		auto_recover;
 	u32			poll_time;
 };
 
+enum ioc_event;
+
 struct bfa_ioc_s {
-	bfa_fsm_t		fsm;
+	void (*fsm)(struct bfa_ioc_s *s, enum ioc_event e);
 	struct bfa_s		*bfa;
 	struct bfa_pcidev_s	pcidev;
 	struct bfa_timer_mod_s	*timer_mod;
@@ -775,8 +779,10 @@ struct bfa_dconf_s {
 };
 #pragma pack()
 
+enum bfa_dconf_event;
+
 struct bfa_dconf_mod_s {
-	bfa_sm_t		sm;
+	void (*sm)(struct bfa_dconf_mod_s *s, enum bfa_dconf_event e);
 	u8			instance;
 	bfa_boolean_t		read_data_valid;
 	bfa_boolean_t		min_cfg;
diff --git a/drivers/scsi/bfa/bfa_svc.c b/drivers/scsi/bfa/bfa_svc.c
index 4e3cef02f10f..6aad7ddcd628 100644
--- a/drivers/scsi/bfa/bfa_svc.c
+++ b/drivers/scsi/bfa/bfa_svc.c
@@ -201,7 +201,7 @@ static void     bfa_fcport_ln_sm_up_dn_nf(struct bfa_fcport_ln_s *ln,
 static void     bfa_fcport_ln_sm_up_dn_up_nf(struct bfa_fcport_ln_s *ln,
 					enum bfa_fcport_ln_sm_event event);
 
-static struct bfa_sm_table_s hal_port_sm_table[] = {
+static struct fcport_sm_table_s hal_port_sm_table[] = {
 	{BFA_SM(bfa_fcport_sm_uninit), BFA_PORT_ST_UNINIT},
 	{BFA_SM(bfa_fcport_sm_enabling_qwait), BFA_PORT_ST_ENABLING_QWAIT},
 	{BFA_SM(bfa_fcport_sm_enabling), BFA_PORT_ST_ENABLING},
@@ -3545,7 +3545,7 @@ bfa_fcport_isr(struct bfa_s *bfa, struct bfi_msg_s *msg)
 	fcport->event_arg.i2hmsg = i2hmsg;
 
 	bfa_trc(bfa, msg->mhdr.msg_id);
-	bfa_trc(bfa, bfa_sm_to_state(hal_port_sm_table, fcport->sm));
+	bfa_trc(bfa, fcport_sm_to_state(hal_port_sm_table, fcport->sm));
 
 	switch (msg->mhdr.msg_id) {
 	case BFI_FCPORT_I2H_ENABLE_RSP:
@@ -3980,7 +3980,7 @@ bfa_fcport_get_attr(struct bfa_s *bfa, struct bfa_port_attr_s *attr)
 
 	attr->pport_cfg.path_tov  = bfa_fcpim_path_tov_get(bfa);
 	attr->pport_cfg.q_depth  = bfa_fcpim_qdepth_get(bfa);
-	attr->port_state = bfa_sm_to_state(hal_port_sm_table, fcport->sm);
+	attr->port_state = fcport_sm_to_state(hal_port_sm_table, fcport->sm);
 
 	attr->fec_state = fcport->fec_state;
 
@@ -4062,7 +4062,7 @@ bfa_fcport_is_disabled(struct bfa_s *bfa)
 {
 	struct bfa_fcport_s *fcport = BFA_FCPORT_MOD(bfa);
 
-	return bfa_sm_to_state(hal_port_sm_table, fcport->sm) ==
+	return fcport_sm_to_state(hal_port_sm_table, fcport->sm) ==
 		BFA_PORT_ST_DISABLED;
 
 }
@@ -4072,7 +4072,7 @@ bfa_fcport_is_dport(struct bfa_s *bfa)
 {
 	struct bfa_fcport_s *fcport = BFA_FCPORT_MOD(bfa);
 
-	return (bfa_sm_to_state(hal_port_sm_table, fcport->sm) ==
+	return (fcport_sm_to_state(hal_port_sm_table, fcport->sm) ==
 		BFA_PORT_ST_DPORT);
 }
 
@@ -4081,7 +4081,7 @@ bfa_fcport_is_ddport(struct bfa_s *bfa)
 {
 	struct bfa_fcport_s *fcport = BFA_FCPORT_MOD(bfa);
 
-	return (bfa_sm_to_state(hal_port_sm_table, fcport->sm) ==
+	return (fcport_sm_to_state(hal_port_sm_table, fcport->sm) ==
 		BFA_PORT_ST_DDPORT);
 }
 
diff --git a/drivers/scsi/bfa/bfa_svc.h b/drivers/scsi/bfa/bfa_svc.h
index 9c83109574e9..0100700c85cc 100644
--- a/drivers/scsi/bfa/bfa_svc.h
+++ b/drivers/scsi/bfa/bfa_svc.h
@@ -152,6 +152,8 @@ struct bfa_fcxp_rsp_info_s {
 	u32	rsp_maxlen;	/*  max response length expected */
 };
 
+typedef void (*bfa_sm_t)(void *sm, int event);
+
 struct bfa_fcxp_s {
 	struct list_head	qe;		/*  fcxp queue element */
 	bfa_sm_t	sm;		/*  state machine */
@@ -287,9 +289,11 @@ struct bfa_rport_info_s {
 /*
  * BFA rport data structure
  */
+enum bfa_rport_event;
+
 struct bfa_rport_s {
 	struct list_head	qe;	/*  queue element		    */
-	bfa_sm_t	sm;		/*  state machine		    */
+	void (*sm)(struct bfa_rport_s *s, enum bfa_rport_event e);/*  state machine    */
 	struct bfa_s	*bfa;		/*  backpointer to BFA		    */
 	void		*rport_drv;	/*  fcs/driver rport object	    */
 	u16	fw_handle;	/*  firmware rport handle	    */
@@ -380,10 +384,12 @@ void	bfa_uf_res_recfg(struct bfa_s *bfa, u16 num_uf_fw);
 /*
  * LPS - bfa lport login/logout service interface
  */
+enum bfa_lps_event;
+
 struct bfa_lps_s {
 	struct list_head	qe;	/*  queue element		*/
 	struct bfa_s	*bfa;		/*  parent bfa instance	*/
-	bfa_sm_t	sm;		/*  finite state machine	*/
+	void (*sm)(struct bfa_lps_s *s, enum bfa_lps_event e);/*  finite state machine */
 	u8		bfa_tag;	/*  lport tag		*/
 	u8		fw_tag;		/*  lport fw tag                */
 	u8		reqq;		/*  lport request queue	*/
@@ -442,9 +448,11 @@ void	bfa_lps_isr(struct bfa_s *bfa, struct bfi_msg_s *msg);
 /*
  * Link notification data structure
  */
+enum bfa_fcport_ln_sm_event;
+
 struct bfa_fcport_ln_s {
 	struct bfa_fcport_s	*fcport;
-	bfa_sm_t		sm;
+	void (*sm)(struct bfa_fcport_ln_s *s, enum bfa_fcport_ln_sm_event e);
 	struct bfa_cb_qe_s	ln_qe;	/*  BFA callback queue elem for ln */
 	enum bfa_port_linkstate ln_event; /*  ln event for callback */
 };
@@ -458,7 +466,7 @@ struct bfa_fcport_trunk_s {
  */
 struct bfa_fcport_s {
 	struct bfa_s		*bfa;	/*  parent BFA instance */
-	bfa_sm_t		sm;	/*  port state machine */
+	void (*sm)(struct bfa_fcport_s *s, enum bfa_fcport_sm_event e);	/*  port state machine */
 	wwn_t			nwwn;	/*  node wwn of physical port */
 	wwn_t			pwwn;	/*  port wwn of physical oprt */
 	enum bfa_port_speed speed_sup;
@@ -706,9 +714,11 @@ struct bfa_fcdiag_lb_s {
 	u32        status;
 };
 
+enum bfa_dport_sm_event;
+
 struct bfa_dport_s {
 	struct bfa_s	*bfa;		/* Back pointer to BFA	*/
-	bfa_sm_t	sm;		/* finite state machine */
+	void (*sm)(struct bfa_dport_s *s, enum bfa_dport_sm_event e);/* finite state machine */
 	struct bfa_reqq_wait_s reqq_wait;
 	bfa_cb_diag_t	cbfn;
 	void		*cbarg;
diff --git a/drivers/scsi/bfa/bfad.c b/drivers/scsi/bfa/bfad.c
index e5aa982ffedc..ba40eb9c0229 100644
--- a/drivers/scsi/bfa/bfad.c
+++ b/drivers/scsi/bfa/bfad.c
@@ -400,6 +400,16 @@ bfad_hcb_comp(void *arg, bfa_status_t status)
 	complete(&fcomp->comp);
 }
 
+void
+bfad_stats_comp(void *arg, bfa_boolean_t _status)
+{
+	struct bfad_hal_comp *fcomp = (struct bfad_hal_comp *)arg;
+	bfa_status_t status = (bfa_status_t)_status;
+
+	fcomp->status = status;
+	complete(&fcomp->comp);
+}
+
 /*
  * bfa_init callback
  */
diff --git a/drivers/scsi/bfa/bfad_bsg.c b/drivers/scsi/bfa/bfad_bsg.c
index be8dfbe13e90..aea3dbbfe668 100644
--- a/drivers/scsi/bfa/bfad_bsg.c
+++ b/drivers/scsi/bfa/bfad_bsg.c
@@ -2135,7 +2135,7 @@ bfad_iocmd_fcport_get_stats(struct bfad_s *bfad, void *cmd)
 	struct bfa_cb_pending_q_s cb_qe;
 
 	init_completion(&fcomp.comp);
-	bfa_pending_q_init(&cb_qe, (bfa_cb_cbfn_t)bfad_hcb_comp,
+	bfa_pending_q_init(&cb_qe, bfad_stats_comp,
 			   &fcomp, &iocmd->stats);
 	spin_lock_irqsave(&bfad->bfad_lock, flags);
 	iocmd->status = bfa_fcport_get_stats(&bfad->bfa, &cb_qe);
@@ -2159,7 +2159,7 @@ bfad_iocmd_fcport_reset_stats(struct bfad_s *bfad, void *cmd)
 	struct bfa_cb_pending_q_s cb_qe;
 
 	init_completion(&fcomp.comp);
-	bfa_pending_q_init(&cb_qe, (bfa_cb_cbfn_t)bfad_hcb_comp, &fcomp, NULL);
+	bfa_pending_q_init(&cb_qe, bfad_stats_comp, &fcomp, NULL);
 
 	spin_lock_irqsave(&bfad->bfad_lock, flags);
 	iocmd->status = bfa_fcport_clear_stats(&bfad->bfa, &cb_qe);
@@ -2443,7 +2443,7 @@ bfad_iocmd_qos_get_stats(struct bfad_s *bfad, void *cmd)
 	struct bfa_fcport_s *fcport = BFA_FCPORT_MOD(&bfad->bfa);
 
 	init_completion(&fcomp.comp);
-	bfa_pending_q_init(&cb_qe, (bfa_cb_cbfn_t)bfad_hcb_comp,
+	bfa_pending_q_init(&cb_qe, bfad_stats_comp,
 			   &fcomp, &iocmd->stats);
 
 	spin_lock_irqsave(&bfad->bfad_lock, flags);
@@ -2474,7 +2474,7 @@ bfad_iocmd_qos_reset_stats(struct bfad_s *bfad, void *cmd)
 	struct bfa_fcport_s *fcport = BFA_FCPORT_MOD(&bfad->bfa);
 
 	init_completion(&fcomp.comp);
-	bfa_pending_q_init(&cb_qe, (bfa_cb_cbfn_t)bfad_hcb_comp,
+	bfa_pending_q_init(&cb_qe, bfad_stats_comp,
 			   &fcomp, NULL);
 
 	spin_lock_irqsave(&bfad->bfad_lock, flags);
diff --git a/drivers/scsi/bfa/bfad_drv.h b/drivers/scsi/bfa/bfad_drv.h
index eaee7c8bc2d2..acb2d8e0781e 100644
--- a/drivers/scsi/bfa/bfad_drv.h
+++ b/drivers/scsi/bfa/bfad_drv.h
@@ -179,8 +179,10 @@ union bfad_tmp_buf {
 /*
  * BFAD (PCI function) data structure
  */
+enum bfad_sm_event;
+
 struct bfad_s {
-	bfa_sm_t	sm;	/* state machine */
+	void (*sm)(struct bfad_s *s, enum bfad_sm_event e); /* state machine */
 	struct list_head list_entry;
 	struct bfa_s	bfa;
 	struct bfa_fcs_s bfa_fcs;
@@ -301,6 +303,7 @@ void		bfad_fcs_stop(struct bfad_s *bfad);
 void		bfad_remove_intr(struct bfad_s *bfad);
 void		bfad_hal_mem_release(struct bfad_s *bfad);
 void		bfad_hcb_comp(void *arg, bfa_status_t status);
+void		bfad_stats_comp(void *arg, bfa_boolean_t _status);
 
 int		bfad_setup_intr(struct bfad_s *bfad);
 void		bfad_remove_intr(struct bfad_s *bfad);
-- 
2.34.1

