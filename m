Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C906504AA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 21:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiLRUxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 15:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLRUxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 15:53:40 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AF2B1FF
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 12:53:38 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1F6CE1EC058A;
        Sun, 18 Dec 2022 21:53:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1671396817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=EXFCNNlpJezbQHAX7KkO9d4XUv9kiX1NDPUmXFyc624=;
        b=YKj90guWFdH35JwqgMtCkX0RWlEELOrlB9LHhN07RNwpwss9/sAtIPQ0l2TKL5goIaxu6O
        xAPZmy1eF05XOZf7h0Hjdk9u25sS2vsWfRT6Go4h64mM00fDD0amoKh6TLFqv1caiK835a
        wCS2mIEwKPV6Xg+bWVm2cKECKAe4YOY=
Date:   Sun, 18 Dec 2022 21:53:36 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] x86/tsc: Do feature check as the very first thing
Message-ID: <Y5990CUCuWd5jfBH@zn.tnic>
References: <20221217170511.21872-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221217170511.21872-1-bp@alien8.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Do the feature check as the very first thing in the function. Everything
else comes after that and is meaningless work if the TSC CPUID bit is
not even set.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/tsc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index eaeffef93a12..1d509c8b3556 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1509,6 +1509,11 @@ void __init tsc_early_init(void)
 
 void __init tsc_init(void)
 {
+	if (!boot_cpu_has(X86_FEATURE_TSC)) {
+		setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
+		return;
+	}
+
 	/*
 	 * native_calibrate_cpu_early can only calibrate using methods that are
 	 * available early in boot.
@@ -1516,11 +1521,6 @@ void __init tsc_init(void)
 	if (x86_platform.calibrate_cpu == native_calibrate_cpu_early)
 		x86_platform.calibrate_cpu = native_calibrate_cpu;
 
-	if (!boot_cpu_has(X86_FEATURE_TSC)) {
-		setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
-		return;
-	}
-
 	if (!tsc_khz) {
 		/* We failed to determine frequencies earlier, try again */
 		if (!determine_cpu_tsc_frequencies(false)) {
-- 
2.35.1


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
