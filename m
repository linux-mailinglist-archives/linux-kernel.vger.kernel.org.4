Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B428F700D4F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 18:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237237AbjELQsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 12:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjELQsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 12:48:13 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3797D9EC1;
        Fri, 12 May 2023 09:48:12 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f00d41df22so54326507e87.1;
        Fri, 12 May 2023 09:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683910090; x=1686502090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PsIlGh6Gxn6SeZwH4Pv85L0XJVmMF+nUTEldqUDjbVE=;
        b=T+0IfXbNbBr/WFqBn4xICXEJyBKjnSP9NtApQs0wDKEMpkj+bJIKhRyaTVx4RvazyA
         o0Lk5UQuOc8x97YYZMEyokfa+RJN0XYWGO4RnP1FNHkAHQsJD1Wl/dnYSX5GzCTDzeyv
         0MTgnwXupCfRDkNbQgLmsvTP12I4J1e3bH7/pJ4Vhu9Puhow4Eoe57MS0jr2apxsqIK5
         mT75owCVe/MRBCSl/opavb9jbIWikTciDuJ9AVWQ9iAfQe/xRvb3HxTYIUN8jIZopbkE
         i1A7rY3QfO1oSV7UmZx96D83FLO9lu1WFzQt/nm7jFo33FTgp+R5Ln4zs7tyh+6cRGXH
         oxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683910090; x=1686502090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PsIlGh6Gxn6SeZwH4Pv85L0XJVmMF+nUTEldqUDjbVE=;
        b=EHUzQAmmdebHkdbcbl26ZrCruxwnt08fI73rBvrP+uSY2gdLPcr7uGDcbWUFLYScZ/
         ChSnZu+vt7NunrlhBmXDkVJnlgbcrRoU2oNb45ak22fao+hcyyS5AwzLj31jTVdJND/f
         H9/3y6kwFR4M9Ef46XNuIXM9t0pbpErdLeP1StxVdP8PdITV8ny9kTMdwzIc04ESw1m9
         RraayMCL1CTjBxvvrmjCjvH6MWRmPjAWEX31qjXnneFdycZo1xIAeHqd21Jp7lMeUKtX
         fPQNRqRrRg/iAMMrfTITRdxoEk8i1SCXpps4Cfj9NjuhC7eUmJnW7EWgwc08V31EVV4Z
         SAJQ==
X-Gm-Message-State: AC+VfDwMcFDW3p/XA7be/YbfHBMwsCz5kb+m3tJigzQSbtD8UtWTn/yS
        lB5YK51haaLQn6Q7ThpTnlu62U2LWAY=
X-Google-Smtp-Source: ACHHUZ7lZ6Zddjpe+mywjBnjMyNxaHzCP8b07KD+Ykq2U0BqBuWX3Or+YB1w6vAo8rL94HZdHgPyuA==
X-Received: by 2002:ac2:5ed0:0:b0:4f0:1a45:2b10 with SMTP id d16-20020ac25ed0000000b004f01a452b10mr4390431lfq.10.1683910089855;
        Fri, 12 May 2023 09:48:09 -0700 (PDT)
Received: from localhost.localdomain ([37.130.110.122])
        by smtp.gmail.com with ESMTPSA id r27-20020ac24d1b000000b004eee27b293bsm1522404lfi.298.2023.05.12.09.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 09:48:09 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        stable@vger.kernel.org
Subject: [PATCH] xtensa: fix signal delivery to FDPIC process
Date:   Fri, 12 May 2023 09:47:12 -0700
Message-Id: <20230512164712.2150755-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fetch function descriptor pointed to by the signal handler pointer from
userspace on signal delivery and function pointer pointed to by the
sa_restorer on return from the signal handler.

Cc: stable@vger.kernel.org
Fixes: e3ddb8bbe0f8 ("xtensa: add FDPIC and static PIE support for noMMU")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/signal.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/arch/xtensa/kernel/signal.c b/arch/xtensa/kernel/signal.c
index 876d5df157ed..5c01d7e70d90 100644
--- a/arch/xtensa/kernel/signal.c
+++ b/arch/xtensa/kernel/signal.c
@@ -343,7 +343,19 @@ static int setup_frame(struct ksignal *ksig, sigset_t *set,
 	struct rt_sigframe *frame;
 	int err = 0, sig = ksig->sig;
 	unsigned long sp, ra, tp, ps;
+	unsigned long handler = (unsigned long)ksig->ka.sa.sa_handler;
+	unsigned long handler_fdpic_GOT = 0;
 	unsigned int base;
+	bool fdpic = IS_ENABLED(CONFIG_BINFMT_ELF_FDPIC) &&
+		(current->personality & FDPIC_FUNCPTRS);
+
+	if (fdpic) {
+		unsigned long __user *fdpic_func_desc =
+			(unsigned long __user *)handler;
+		if (__get_user(handler, &fdpic_func_desc[0]) ||
+		    __get_user(handler_fdpic_GOT, &fdpic_func_desc[1]))
+			return -EFAULT;
+	}
 
 	sp = regs->areg[1];
 
@@ -373,20 +385,26 @@ static int setup_frame(struct ksignal *ksig, sigset_t *set,
 	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
 
 	if (ksig->ka.sa.sa_flags & SA_RESTORER) {
-		ra = (unsigned long)ksig->ka.sa.sa_restorer;
+		if (fdpic) {
+			unsigned long __user *fdpic_func_desc =
+				(unsigned long __user *)ksig->ka.sa.sa_restorer;
+
+			err |= __get_user(ra, fdpic_func_desc);
+		} else {
+			ra = (unsigned long)ksig->ka.sa.sa_restorer;
+		}
 	} else {
 
 		/* Create sys_rt_sigreturn syscall in stack frame */
 
 		err |= gen_return_code(frame->retcode);
-
-		if (err) {
-			return -EFAULT;
-		}
 		ra = (unsigned long) frame->retcode;
 	}
 
-	/* 
+	if (err)
+		return -EFAULT;
+
+	/*
 	 * Create signal handler execution context.
 	 * Return context not modified until this point.
 	 */
@@ -394,8 +412,7 @@ static int setup_frame(struct ksignal *ksig, sigset_t *set,
 	/* Set up registers for signal handler; preserve the threadptr */
 	tp = regs->threadptr;
 	ps = regs->ps;
-	start_thread(regs, (unsigned long) ksig->ka.sa.sa_handler,
-		     (unsigned long) frame);
+	start_thread(regs, handler, (unsigned long)frame);
 
 	/* Set up a stack frame for a call4 if userspace uses windowed ABI */
 	if (ps & PS_WOE_MASK) {
@@ -413,6 +430,8 @@ static int setup_frame(struct ksignal *ksig, sigset_t *set,
 	regs->areg[base + 4] = (unsigned long) &frame->uc;
 	regs->threadptr = tp;
 	regs->ps = ps;
+	if (fdpic)
+		regs->areg[base + 11] = handler_fdpic_GOT;
 
 	pr_debug("SIG rt deliver (%s:%d): signal=%d sp=%p pc=%08lx\n",
 		 current->comm, current->pid, sig, frame, regs->pc);
-- 
2.30.2

