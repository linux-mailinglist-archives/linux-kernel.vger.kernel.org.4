Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6705BB606
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 06:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiIQEPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 00:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiIQEP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 00:15:27 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079E9642CB
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 21:15:26 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id u28so14221917qku.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 21:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=J9IDrASWL6XfzCGUWjpJfQp+QteSTZebaCfrkgU/MBo=;
        b=NmfNXI7vO45IX2DR1X5O5UAY+GIJpb5suAaPAPVXsSdZTTqfIv4mNtsP29mZHB4giT
         yPekvWyLfBBRnIQ+bXjLwiDNamR2gpGv9woWQzCNj/i4H0cmsIGiQhagvs4e3IR6Esx1
         WXNVVsNDVa5r/LZu7ZfH+DjqMqtwyv4ZgK4XUGTY4bbkz/wA/Z8gyYr6YuODBqVuQQvN
         hBEK9zT7qV2dw0MITShlrndihWJq/+RL+ErPXeoTmCZjIIm+KR841MnCKsh8i/PvsF/X
         SnKsEJdxeOOiIQYHyEDwxsAifRDTUNeyRtbqh8TVDneLMGqYgssIVt9sLjLfDhRiCzAg
         mPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=J9IDrASWL6XfzCGUWjpJfQp+QteSTZebaCfrkgU/MBo=;
        b=Voezg22YoJRCSY4Dx+/wBe6cs/42sWoXj2yuPoW0rhv7rbJlCtzvpreDORESAVoW6L
         Nln/JWN13G3ran+6JJ4wd7myzXf8yK7fTvyZnkMIH5xRAjXMhVW2jK6hZGuH9MBlNvOT
         14VbqXRdLnftejLDD+lsD4ez7bYhmABoIWuqX9CL3AHXYJui2dLzRsdZ4K/hLPGApvff
         YkKvJNnt3wSrDMidS/S0lSMtZ/XLjAG/FsBzUXt85nrWLCXMOQ8ht4ZnJCKZ/kofoY1l
         ZOwwLVlyUeqcN42Nv7daimNRphVuk6aKWrcxIMRlxzgGU2PSr/ZOgiSA+0yIY5zfYhF5
         UTdQ==
X-Gm-Message-State: ACrzQf2l9jD1rPrxUzBLDY8MD7Uwg0/qBKg80RxqiO2Zn+SkR90fSGhc
        09MAFvuokGuFQOUmiGk1XIw=
X-Google-Smtp-Source: AMsMyM4iLzmyYxh9KU2yhGJhKxnSOqLKhhZhOSlCbCYAT/sYUSqfUYF7YWgtvj9e42nzbGOB20+/uw==
X-Received: by 2002:a05:620a:271b:b0:6cd:fd1f:7472 with SMTP id b27-20020a05620a271b00b006cdfd1f7472mr6377012qkp.142.1663388125071;
        Fri, 16 Sep 2022 21:15:25 -0700 (PDT)
Received: from Dell-Inspiron-15.. (c-73-149-35-171.hsd1.ma.comcast.net. [73.149.35.171])
        by smtp.gmail.com with ESMTPSA id do11-20020a05620a2b0b00b006bbb07ebd83sm7345206qkb.108.2022.09.16.21.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 21:15:24 -0700 (PDT)
From:   Ben Wolsieffer <benwolsieffer@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Ben Wolsieffer <benwolsieffer@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 2/2] ARM: v7m: support undefined instruction hooks
Date:   Sat, 17 Sep 2022 00:13:52 -0400
Message-Id: <20220917041403.4191780-3-benwolsieffer@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220917041403.4191780-1-benwolsieffer@gmail.com>
References: <20220917041403.4191780-1-benwolsieffer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call the common ARM undefined instruction handler, which handles running
hooks to enable ptrace breakpoints and other features.

Signed-off-by: Ben Wolsieffer <benwolsieffer@gmail.com>
---
 arch/arm/include/asm/traps.h | 2 ++
 arch/arm/kernel/traps-v7m.c  | 8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/traps.h b/arch/arm/include/asm/traps.h
index 987fefb0a4db..e4253f4a86e1 100644
--- a/arch/arm/include/asm/traps.h
+++ b/arch/arm/include/asm/traps.h
@@ -19,6 +19,8 @@ struct undef_hook {
 void register_undef_hook(struct undef_hook *hook);
 void unregister_undef_hook(struct undef_hook *hook);
 
+void do_undefinstr(struct pt_regs *regs);
+
 static inline int __in_irqentry_text(unsigned long ptr)
 {
 	extern char __irqentry_text_start[];
diff --git a/arch/arm/kernel/traps-v7m.c b/arch/arm/kernel/traps-v7m.c
index 5fd9943448e9..b324499e1010 100644
--- a/arch/arm/kernel/traps-v7m.c
+++ b/arch/arm/kernel/traps-v7m.c
@@ -20,6 +20,7 @@
 #include <asm/linkage.h>
 #include <asm/ptrace.h>
 #include <asm/system_misc.h>
+#include <asm/traps.h>
 #include <asm/v7m.h>
 
 enum fault {
@@ -49,7 +50,6 @@ static const struct exception exceptions[] = {
 	{"no coprocessor",			FAULT_USAGEFAULT,	V7M_SCB_CFSR_NOCP,		SIGILL,		ILL_COPROC,	UDBG_UNDEFINED},
 	{"return to invalid PC",		FAULT_USAGEFAULT,	V7M_SCB_CFSR_INVPC,		SIGSEGV,	SEGV_MAPERR,	UDBG_SEGV},
 	{"invalid ISA state",			FAULT_USAGEFAULT,	V7M_SCB_CFSR_INVSTATE,		SIGSEGV,	SEGV_MAPERR,	UDBG_SEGV},
-	{"undefined instruction",		FAULT_USAGEFAULT,	V7M_SCB_CFSR_UNDEFINSTR,	SIGILL,		ILL_ILLOPC,	UDBG_UNDEFINED},
 	{"floating point state error",		FAULT_BUSFAULT,		V7M_SCB_CFSR_LSPERR,		SIGBUS,		BUS_ADRERR,	UDBG_BUS},
 	{"exception stack push error",		FAULT_BUSFAULT,		V7M_SCB_CFSR_STKERR,		SIGBUS,		BUS_ADRERR,	UDBG_BUS},
 	{"exception stack pop error",		FAULT_BUSFAULT,		V7M_SCB_CFSR_UNSTKERR,		SIGBUS,		BUS_ADRERR,	UDBG_BUS},
@@ -95,6 +95,12 @@ static void traps_v7m_common(struct pt_regs *regs, int fault)
 	writel(hstatus, BASEADDR_V7M_SCB + V7M_SCB_HFSR);
 	writel(cstatus, BASEADDR_V7M_SCB + V7M_SCB_CFSR);
 
+	if (fault == FAULT_USAGEFAULT && cstatus & V7M_SCB_CFSR_UNDEFINSTR) {
+		/* Handle undefined instruction hooks */
+		do_undefinstr(regs);
+		return;
+	}
+
 	for (i = 0; exceptions[i].name != NULL; ++i) {
 		if (fault != exceptions[i].fault)
 			continue;
-- 
2.37.2

