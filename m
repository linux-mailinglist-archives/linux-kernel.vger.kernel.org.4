Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A096FF88F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 19:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238976AbjEKRex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 13:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238964AbjEKRes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 13:34:48 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896FE59E1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:34:15 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f14468ef54so10163355e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683826453; x=1686418453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3/ujT6jnA5oRzJ9JskN5r6uCjmFXgOFd2DIRefml7o8=;
        b=LAVNsqv1Aze3d/dQSl9R9cYk9Bbvtr2rGzKHOyJO3d0/M4I5vUi2SMgmXw34JRFjYl
         AdlAUY1KxPuvHg0vF5szhY3kMSuPgZfSKCe0wsnR7DIKXuYNhDrbQBAlzjAriSa1gFfe
         0jrNPA3LPzf/J/WJi/cor3rMn/j2T9b7UhcZI6jhc6uYWskYRSB8o2OFVnbFUSzgAaXm
         4n++YCZcveM/k0yWa8YsSvtRzPjFDwUarXs810THzteneZEsQHUz19tRauOr0iUjKpW3
         VNwFw7rhMxcMjWongu5AUAkj+H6aX3QazVQZmE4P7+NWeaVl+bza9HflSEplaVi8k40s
         TZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683826453; x=1686418453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3/ujT6jnA5oRzJ9JskN5r6uCjmFXgOFd2DIRefml7o8=;
        b=RQ6UvZsNV+YaxE7d/OVOEwvKg/hrbtp57zmKYzDEqBA5QeQ2Wojpzt8dkn/5tuEFTG
         ajoai9/pfHp3BAfAlOnjZJ+T2U+JdtOqiZPFkPcYQ4rYP7+Km3C6I5RkLvLuwxAVGrIy
         enoEWS/snGy4igfkcTBOO4e8mD0AG7mrs9LwrW02/xOoQRQlL/jsBR6xtrj/WGNoadWH
         pvsXreC9BPskwBbVY/QFSWhsd8iF4rpa9szkWr3Wezta16awWbGl/3BClUGDyxCQYmTj
         kf4Kh2xLbu6wpfdDpf4l2hSg5xJbAVkdnDb8kalJBjiWF+ZWUu3JDd6a43rCtGHbhU4t
         FeFg==
X-Gm-Message-State: AC+VfDwMyxT7vRSsW13ttHnhlutjbRyMyCkF8KDT9ydkiTjzgkDj2bSd
        si/3dHS4o/ldNIMUyW7mzJOO92I6/XY=
X-Google-Smtp-Source: ACHHUZ7/QmhMqp0+mUryx2vQHo4zKlh9dLXgT/+fIm732mC0GMsmc8pBdqVK/AqICLh9b4k04HbF3Q==
X-Received: by 2002:a05:6512:963:b0:4f2:4bc2:fc35 with SMTP id v3-20020a056512096300b004f24bc2fc35mr3066181lft.53.1683826452941;
        Thu, 11 May 2023 10:34:12 -0700 (PDT)
Received: from localhost.localdomain ([37.130.110.122])
        by smtp.gmail.com with ESMTPSA id a15-20020a056512020f00b004ecad67a925sm1204613lfo.66.2023.05.11.10.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 10:34:12 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: fix signal delivery to FDPIC process
Date:   Thu, 11 May 2023 10:33:10 -0700
Message-Id: <20230511173310.1757206-1-jcmvbkbc@gmail.com>
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

