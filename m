Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73697692FDB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 11:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjBKKBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 05:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBKKBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 05:01:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4095D423D;
        Sat, 11 Feb 2023 02:01:46 -0800 (PST)
Date:   Sat, 11 Feb 2023 10:01:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676109704;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zq0W49xjiWEhrGmA3lwDNpXez4TTunGW1uDmfF3FaxM=;
        b=BGsTdDVTtr33JbyiTKpYkdt+KtLWSKHkVka2d0Lj+j1X1iQLgT51htC2B7Hm7G1Zb6xFKj
        aEUI0YaUhjMfS94VUb4PLX/rulI/lB5nIWfMLzwOxggZZe5gtTVkyWzBc06IztD2iEwRp/
        xpfEBrkvYPcHN1I06Ce72sJHUYnMPOGHd4+p1m8GNWCGv2FaS0QtbUKgVOQ9GUkQWO1ims
        kGPfD+rfZz14uQysl1rRoHglFxe1tFIBZQIBN6AbTiDuXiRsPV6R7qTU7GOCyi1Vk9fvBV
        WCCODTtywk5dT8Ix2YqFWZ0fl682EdwVwIuDKspz9PhOHF6bg2HwT1mOf/poJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676109704;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zq0W49xjiWEhrGmA3lwDNpXez4TTunGW1uDmfF3FaxM=;
        b=rrflQDCKBbkHiBbiWKgw1rgcttF/0yJc9mEku0jaLhlL0OVl6d2bbDmd0+0mQ61hxsE0lb
        qEsU3sk6iROM/LAw==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/tsc: Do feature check as the very first thing
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Y5990CUCuWd5jfBH@zn.tnic>
References: <Y5990CUCuWd5jfBH@zn.tnic>
MIME-Version: 1.0
Message-ID: <167610970410.4906.1786175221838742413.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     6b8d5dde5b6903baf82fc7400e0b3376b10805b4
Gitweb:        https://git.kernel.org/tip/6b8d5dde5b6903baf82fc7400e0b3376b10805b4
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Sun, 18 Dec 2022 21:53:36 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 11 Feb 2023 10:44:07 +01:00

x86/tsc: Do feature check as the very first thing

Do the feature check as the very first thing in the function. Everything
else comes after that and is meaningless work if the TSC CPUID bit is
not even set. Switch to cpu_feature_enabled() too, while at it.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/Y5990CUCuWd5jfBH@zn.tnic
---
 arch/x86/kernel/tsc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index eaeffef..aff1d79 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1509,6 +1509,11 @@ void __init tsc_early_init(void)
 
 void __init tsc_init(void)
 {
+	if (!cpu_feature_enabled(X86_FEATURE_TSC)) {
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
