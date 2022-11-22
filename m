Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C44C63433C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 19:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbiKVSFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 13:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234112AbiKVSEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 13:04:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBE869DFC;
        Tue, 22 Nov 2022 10:04:52 -0800 (PST)
Date:   Tue, 22 Nov 2022 18:04:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669140291;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iGdsqCOwnGEZlC9+sno+kd261SceMOT/kVpnaYNTnSA=;
        b=U419Zewqp0pz8L1+p6vV5arNwk3J4uIsC1N4yyyXyFuWgQifuLQ/z6sHcj3u2qD/AlKuGm
        KtNq02DQHT+WsfS+SH7z7SVhYrv8PW+tJfQIafcn4h1pHazKp2z+gk5rFMS/NXQyZUxWVu
        9Iw6QVWUi+ABWf3Ql35lY95qJo1Smlarm/stV2PhJLSnZUyhIm6wmn33xUwHKeQQlIXeY0
        EiZJAkyMiJHNGXrrx4sEfrJUbWnbw9kL2KWEwbSgSh9P5m53Cgw1O0URMELUnwopddgdhM
        vnnSLavF06S1Q6NT1YiRFcFJet8TSmrc0WnS1OhrubRyrAqo8r2P9UEqG9ouFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669140291;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iGdsqCOwnGEZlC9+sno+kd261SceMOT/kVpnaYNTnSA=;
        b=VYor3tld8xeU4WAqxgJK9xlpI0YoPLtAr0RPOwItiom+u5boEknTPJHxkOWfbu9p4cI3Yd
        X6xGp7AvQnrbvLBA==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Remove unneeded 64-bit dependency in
 arch_enter_from_user_mode()
Cc:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221104072701.20283-3-jgross@suse.com>
References: <20221104072701.20283-3-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <166914029025.4906.10157484903409499772.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     0bafc51babe2344e9b0ff6629a4f044727728349
Gitweb:        https://git.kernel.org/tip/0bafc51babe2344e9b0ff6629a4f044727728349
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Fri, 04 Nov 2022 08:26:58 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 22 Nov 2022 16:11:57 +01:00

x86/cpu: Remove unneeded 64-bit dependency in arch_enter_from_user_mode()

The check for 64-bit mode when testing X86_FEATURE_XENPV isn't needed,
as Xen PV guests are no longer supported in 32-bit mode, see

  a13f2ef168cb ("x86/xen: remove 32-bit Xen PV guest support").

While at it switch from boot_cpu_has() to cpu_feature_enabled().

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20221104072701.20283-3-jgross@suse.com
---
 arch/x86/include/asm/entry-common.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index 674ed46..1179038 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -24,8 +24,8 @@ static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs)
 		/*
 		 * For !SMAP hardware we patch out CLAC on entry.
 		 */
-		if (boot_cpu_has(X86_FEATURE_SMAP) ||
-		    (IS_ENABLED(CONFIG_64BIT) && boot_cpu_has(X86_FEATURE_XENPV)))
+		if (cpu_feature_enabled(X86_FEATURE_SMAP) ||
+		    cpu_feature_enabled(X86_FEATURE_XENPV))
 			mask |= X86_EFLAGS_AC;
 
 		WARN_ON_ONCE(flags & mask);
