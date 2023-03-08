Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8B86B0CB4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjCHPaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjCHPaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:30:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B294D78CA5;
        Wed,  8 Mar 2023 07:30:19 -0800 (PST)
Date:   Wed, 08 Mar 2023 15:30:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678289417;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zGW8aFTFNGDqKmYCa2z7txb9ZVvxIQE52D2ea4toxro=;
        b=XDwpXfLVC5aqiCCHhwKwUXONQvHq3fFQz0y1Wcsx6IekfkaYzh18M8QSyLNeKls0xVZ7LY
        hDc3v4LtXr6MN2II55Sy9yEWDg9pQ4mBXz7gR8K78XEDYJyyxgo9RLekiJWp/lEnOw8ZIG
        aq15d0xTIX3k+H8njzDZnCncRL9W+i2P09lo0Lh9FfNlvEGSuwAH/BJIw5qaLjMZpRW7Uq
        OzZi2XekLbq/ARCmucLTsLb2JUvKmusyJPNVroGkrC4xf4qg7FUhQYPcD3yedREjL772j3
        O1FxibEucP1puLIb7MU4neAJ2o6/gZy9L6xkjlZAINw1CBdHRYlcW6MbzV2FRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678289417;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zGW8aFTFNGDqKmYCa2z7txb9ZVvxIQE52D2ea4toxro=;
        b=HdE/heKF14OWpJQ8hqVDlkUfPI9+Uf/tHyaxo8jp78egNDL1gXOjgChwaW11XLzcoh7EPR
        euvZ+rV74FiCIlBA==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Always inline old MCA stubs
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230222191054.4701-1-bp@alien8.de>
References: <20230222191054.4701-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <167828941626.5837.14183438952531828162.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     554eec0b4a29d0dfe59065e2cf1d2568c7b4d5f0
Gitweb:        https://git.kernel.org/tip/554eec0b4a29d0dfe59065e2cf1d2568c7b4d5f0
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 22 Feb 2023 20:10:54 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 08 Mar 2023 13:50:07 +01:00

x86/mce: Always inline old MCA stubs

The stubs for the ancient MCA support (CONFIG_X86_ANCIENT_MCE) are
normally optimized away on 64-bit builds. However, an allmodconfig one
causes the compiler to add sanitizer calls gunk into them and they exist
as constprop calls. Which objtool then complains about:

  vmlinux.o: warning: objtool: do_machine_check+0xad8: call to \
    pentium_machine_check.constprop.0() leaves .noinstr.text section

due to them missing noinstr. One could tag them "noinstr" but what
should really happen is, they should be forcefully inlined so that all
that gunk gets optimized away and the warning doesn't even have a chance
to fire.

Do so.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230222191054.4701-1-bp@alien8.de
---
 arch/x86/kernel/cpu/mce/internal.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 91a4155..d2412ce 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -244,11 +244,11 @@ noinstr void pentium_machine_check(struct pt_regs *regs);
 noinstr void winchip_machine_check(struct pt_regs *regs);
 static inline void enable_p5_mce(void) { mce_p5_enabled = 1; }
 #else
-static inline void intel_p5_mcheck_init(struct cpuinfo_x86 *c) {}
-static inline void winchip_mcheck_init(struct cpuinfo_x86 *c) {}
-static inline void enable_p5_mce(void) {}
-static inline void pentium_machine_check(struct pt_regs *regs) {}
-static inline void winchip_machine_check(struct pt_regs *regs) {}
+static __always_inline void intel_p5_mcheck_init(struct cpuinfo_x86 *c) {}
+static __always_inline void winchip_mcheck_init(struct cpuinfo_x86 *c) {}
+static __always_inline void enable_p5_mce(void) {}
+static __always_inline void pentium_machine_check(struct pt_regs *regs) {}
+static __always_inline void winchip_machine_check(struct pt_regs *regs) {}
 #endif
 
 noinstr u64 mce_rdmsrl(u32 msr);
