Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788B7741709
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 19:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjF1RN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 13:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjF1RNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:13:23 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1834D1BF2;
        Wed, 28 Jun 2023 10:13:22 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fba64e4fbcso1795085e9.3;
        Wed, 28 Jun 2023 10:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687972400; x=1690564400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yVNlrr/14l8NEMMiJ6PCzhb8xYGWCKsqMfnP53EwrxI=;
        b=PTWv1QJKU2HRW4HCoHyv6rd4D4hXN598rahNdQPquM5ji6Bkm9Z/ypvIgMvS8KsXjE
         MtrtV+FzG244FE6BuydJ+L9jR6HLhH91KH0yJYCrThPJZrKS9q7lvxhE5NoaodotKIyF
         /l8otIrOCsVZM60J8SavRQ+CH6MmiihHcjEyF7u/LOef9Ihf6dviGD+KtYhYPkCgxCND
         nuacdgjPYq8yn1Bi56wPbeh+1ODJM/xLoFUBFkHCA67ayM22+3qV29cBx0nIfuXczqEu
         xSqxxo6KoGpOGlCK7XYC2mRzR5mm7gvRkB9vIt1sJbEzdzw26+Pk48qX9kXKqMMgiRd4
         MViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687972400; x=1690564400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yVNlrr/14l8NEMMiJ6PCzhb8xYGWCKsqMfnP53EwrxI=;
        b=Q1FERfxpgsPxPMd2AgVDgBkStmAg7PxgI9P4UxjeayfdFAhQ5ZSf3uvjbHlgZ3XtYq
         INqxkJlYJq2L/XTnvIuOYi8d2LAC+t/75vN5UXQHNQgiNAQUCaxG5pn7XulS6bgqzCK8
         Vus6ckJhX0hjLgnQQJIpJbOvKG1iCDYCH2fuFFv1N9xePI22esv/15cJZ7nLD/umyfEI
         P+vR3Lakzi5JmFlIiHa1Tyo/vH8AQrREBshs+wIyKo76wLgmXHY7LFi+ClO/Jo94GbKi
         aaI5ty4hiDZoKZRSYqYMJvRuiwNAfbYnQWep8VUjqyrMQuY5YXt2oI6K1gtTlbX1TGhU
         lcIw==
X-Gm-Message-State: AC+VfDywYerXFCn3711oNPJ89Q7w8U+hqiq0DVRWPyvPJpSck1zf8u9h
        Qozek8wc4g5QT4wO/f7wpjKYhWxV0ow=
X-Google-Smtp-Source: ACHHUZ7dVigy2lf91RsYZ+bLiC1c/DqqIASkzZJj/XuAJFyHaJEmS6DUAxcrijGjBVAOS4RqpOy5Kg==
X-Received: by 2002:a7b:c451:0:b0:3fa:9850:8b1d with SMTP id l17-20020a7bc451000000b003fa98508b1dmr6727023wmi.30.1687972399849;
        Wed, 28 Jun 2023 10:13:19 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id z24-20020a05600c221800b003fa96fe2bd9sm9379883wml.22.2023.06.28.10.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 10:13:19 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Rich Felker <dalias@libc.org>, Stafford Horne <shorne@gmail.com>,
        Szabolcs Nagy <nsz@port70.net>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        linux-openrisc@vger.kernel.org
Subject: [PATCH] openrisc: Revert adding fpcsr to sigcontext to unbreak userspace ABI
Date:   Wed, 28 Jun 2023 18:13:04 +0100
Message-Id: <20230628171306.2608480-1-shorne@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit 27267655c531 ("openrisc: Support floating point user api") I
inproperly added an entry to the struct sigcontext which caused an
unwanted to chagne to the userspace ABI.

Revert this change to restore the ABI back to the pre kernel v6.4 ABI.

This means that fpcsr will not be accessible in signal handlers, but
that should be fine.

Fixes: 27267655c531 ("openrisc: Support floating point user api")
Reported-by: Szabolcs Nagy <nsz@port70.net>
Closes: https://lore.kernel.org/openrisc/20230626213840.GA1236108@port70.net/
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/uapi/asm/sigcontext.h | 1 -
 arch/openrisc/kernel/signal.c               | 2 --
 2 files changed, 3 deletions(-)

diff --git a/arch/openrisc/include/uapi/asm/sigcontext.h b/arch/openrisc/include/uapi/asm/sigcontext.h
index ca585e4af6b8..8ab775fc3450 100644
--- a/arch/openrisc/include/uapi/asm/sigcontext.h
+++ b/arch/openrisc/include/uapi/asm/sigcontext.h
@@ -28,7 +28,6 @@
 
 struct sigcontext {
 	struct user_regs_struct regs;  /* needs to be first */
-	struct __or1k_fpu_state fpu;
 	unsigned long oldmask;
 };
 
diff --git a/arch/openrisc/kernel/signal.c b/arch/openrisc/kernel/signal.c
index 4664a18f0787..80f69740c731 100644
--- a/arch/openrisc/kernel/signal.c
+++ b/arch/openrisc/kernel/signal.c
@@ -50,7 +50,6 @@ static int restore_sigcontext(struct pt_regs *regs,
 	err |= __copy_from_user(regs, sc->regs.gpr, 32 * sizeof(unsigned long));
 	err |= __copy_from_user(&regs->pc, &sc->regs.pc, sizeof(unsigned long));
 	err |= __copy_from_user(&regs->sr, &sc->regs.sr, sizeof(unsigned long));
-	err |= __copy_from_user(&regs->fpcsr, &sc->fpu.fpcsr, sizeof(unsigned long));
 
 	/* make sure the SM-bit is cleared so user-mode cannot fool us */
 	regs->sr &= ~SPR_SR_SM;
@@ -113,7 +112,6 @@ static int setup_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
 	err |= __copy_to_user(sc->regs.gpr, regs, 32 * sizeof(unsigned long));
 	err |= __copy_to_user(&sc->regs.pc, &regs->pc, sizeof(unsigned long));
 	err |= __copy_to_user(&sc->regs.sr, &regs->sr, sizeof(unsigned long));
-	err |= __copy_to_user(&sc->fpu.fpcsr, &regs->fpcsr, sizeof(unsigned long));
 
 	return err;
 }
-- 
2.39.1

