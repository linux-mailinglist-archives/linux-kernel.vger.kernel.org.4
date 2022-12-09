Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC3A648A6A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 22:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiLIVy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 16:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiLIVyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 16:54:22 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEFB275D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 13:54:20 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id x28so4689861qtv.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 13:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtMrmlc95PnCcPVYPyv6AphCDyoFhdBGfMeU1wU5s+s=;
        b=dnPGm+Ea6IJzbYga/myO6yYgHn0eOdbGEIM4N0FIXXIKzApv8en5HLVSziFmlqe5oy
         xNmzQAxW83hQ10+srOm/83LgF0a1KiWagRfyCSNMTzTW+RSj0QfowpqSgYOyS1Obk+mM
         1+9buMHZE1n+k+XCUbCf2holRLYGfGLZsl7jxPLKUi8GVtg2OCZDn4Y3KbKN3Y1zroBg
         yhLHIg55cDs7zQ120c7WTKI3jaVfhciCTZNfPlJZnfMernXFwerbeOI2Fg7wVOpE6uWx
         UhQ600Ii8hzrRwVgvsVHTHlKnVvLdkmaX5rbt4dkrFrIGWwCEsg2/F75X8l5s56zeWaw
         ydkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FtMrmlc95PnCcPVYPyv6AphCDyoFhdBGfMeU1wU5s+s=;
        b=3ZDRzkujORXROJyYHSEs4JICACbkVXcFPQO8CDOWz18i2M/ChOFxzQ0jIPNnxXboL2
         k09j8yY8uwbNhnCuRv0k7ItodN/eLHbKkKuZjaqd9TJVdHUtl53aYjVwmOPnDZa8+Edz
         78RuVAHiWUdCEnfhaLo9lx4hanzbkw8nCkQQnAax7wdf5uPcVdzLf6IxdMpDOsI0A128
         5TIgTeVqa2e5yAXAHau235juWtW2GFmS1O9ubZ5oZsSUxCqKCOYkzfiunWvJe7YV+WPL
         bYunoWVmAVb5y4PU377lXIEmKSL9IpQATg6Z5R1Wtm9XIvk5affBdr+PdfvCLnjOtuc+
         jlrQ==
X-Gm-Message-State: ANoB5pmznbo4xREPI+O4ZstVcgLTkEzl3FqryCqsqQsD1vpveLCZ1XbI
        VRhcXC0Vlho6DREGFOzZxgI=
X-Google-Smtp-Source: AA0mqf5yU1rF1S/0Ku2uEBfm3PaqSjKArEAu/l8197FIy40qUKmMLAMi4jAE6ymNd0Kmmm/MAJ6aHA==
X-Received: by 2002:a05:622a:488c:b0:3a7:ed31:a618 with SMTP id fc12-20020a05622a488c00b003a7ed31a618mr11349946qtb.7.1670622859382;
        Fri, 09 Dec 2022 13:54:19 -0800 (PST)
Received: from Dell-Inspiron-15.. ([2601:18c:8380:74b0:e8e5:f40c:d741:8f07])
        by smtp.gmail.com with ESMTPSA id p16-20020a05620a057000b006fee9a70343sm712718qkp.14.2022.12.09.13.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 13:54:18 -0800 (PST)
From:   Ben Wolsieffer <benwolsieffer@gmail.com>
To:     linux-stm32@st-md-mailman.stormreply.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Ben Wolsieffer <benwolsieffer@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 2/2] ARM: v7m: support undefined instruction hooks
Date:   Fri,  9 Dec 2022 16:48:13 -0500
Message-Id: <20221209214824.3444954-3-benwolsieffer@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221209214824.3444954-1-benwolsieffer@gmail.com>
References: <20221209214824.3444954-1-benwolsieffer@gmail.com>
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
2.38.1

