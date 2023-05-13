Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C177016CF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 15:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238623AbjEMNEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 09:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbjEMNDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 09:03:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D2D3C1E;
        Sat, 13 May 2023 06:03:50 -0700 (PDT)
Date:   Sat, 13 May 2023 13:03:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683983029;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=06cgyC4tpqJVQwWefSxRaQJ43JciCACo/Dm4GRiLBBM=;
        b=GBnjNQg78aZtx2XPFOMF1E9PB2jZUkpnmnQyazwl685BiweNh/hpfRx9f1ehvJGLGTIjqX
        yr23pk84p3+Gpcvgdr7Bc7MLPN4Hk8KLErs36Z+DIh4D/RTG8ZV5ERDS84HsIPeqM1Bk7J
        GKO9DgRjKSf6uqK0aM+A4o+Ief6InyGzx98xSRLFYRDd7s8BC2x4uKEJtNRYxLHKYAfsX/
        ydBfLuu35TDMXB/roeHyTedbIri7GShP5ytlTg/OGyzgCRsL+W+Ug8oR5yg4Qo9e0xyH1r
        KnDc8p4pth9vG+AnS6hSQN1AQsuGiGP1FYmRibnRGvDcBO80YWhvLLw2etrSzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683983029;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=06cgyC4tpqJVQwWefSxRaQJ43JciCACo/Dm4GRiLBBM=;
        b=lwhBENOxTnM+78Hzi0AGpNEX7Rf5LxTIA1UJwq7L/TQfEs9cC9Xr9glnu/7y5/On7ZsSg0
        HyPVMhmbdoOsYaBg==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/lib/memmove: Decouple ERMS from FSRM
Cc:     Daniel Verkamp <dverkamp@chromium.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <yK0dyzI0MMdTie@zn.tnic>
References: <yK0dyzI0MMdTie@zn.tnic>
MIME-Version: 1.0
Message-ID: <168398302855.404.16319361795751047208.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     14e4ec9c3e9164c6719f98d8a3065c487be2aaa5
Gitweb:        https://git.kernel.org/tip/14e4ec9c3e9164c6719f98d8a3065c487be2aaa5
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Sun, 26 Feb 2023 21:04:26 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 10 May 2023 14:51:56 +02:00

x86/lib/memmove: Decouple ERMS from FSRM

Up until now it was perceived that FSRM is an improvement to ERMS and
thus it was made dependent on latter.

However, there are AMD BIOSes out there which allow for disabling of
either features and thus preventing kernels from booting due to the CMP
disappearing and thus breaking the logic in the memmove() function.

Similar observation happens on some VM migration scenarios.

Patch the proper sequences depending on which feature is enabled.

Reported-by: Daniel Verkamp <dverkamp@chromium.org>
Reported-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/Y/yK0dyzI0MMdTie@zn.tnic
---
 arch/x86/lib/memmove_64.S | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
index 0266186..0559b20 100644
--- a/arch/x86/lib/memmove_64.S
+++ b/arch/x86/lib/memmove_64.S
@@ -38,10 +38,12 @@ SYM_FUNC_START(__memmove)
 	cmp %rdi, %r8
 	jg 2f
 
-	/* FSRM implies ERMS => no length checks, do the copy directly */
+#define CHECK_LEN	cmp $0x20, %rdx; jb 1f
+#define MEMMOVE_BYTES	movq %rdx, %rcx; rep movsb; RET
 .Lmemmove_begin_forward:
-	ALTERNATIVE "cmp $0x20, %rdx; jb 1f", "", X86_FEATURE_FSRM
-	ALTERNATIVE "", "jmp .Lmemmove_erms", X86_FEATURE_ERMS
+	ALTERNATIVE_2 __stringify(CHECK_LEN), \
+		      __stringify(CHECK_LEN; MEMMOVE_BYTES), X86_FEATURE_ERMS, \
+		      __stringify(MEMMOVE_BYTES), X86_FEATURE_FSRM
 
 	/*
 	 * movsq instruction have many startup latency
@@ -207,11 +209,6 @@ SYM_FUNC_START(__memmove)
 	movb %r11b, (%rdi)
 13:
 	RET
-
-.Lmemmove_erms:
-	movq %rdx, %rcx
-	rep movsb
-	RET
 SYM_FUNC_END(__memmove)
 EXPORT_SYMBOL(__memmove)
 
