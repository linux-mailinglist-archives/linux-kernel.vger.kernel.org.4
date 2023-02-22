Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C50669FBC3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 20:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjBVTLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 14:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjBVTLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 14:11:06 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8962A99E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 11:11:03 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 42ECA1EC0688;
        Wed, 22 Feb 2023 20:11:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1677093062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=iMJjMd+hswT3hOigJvQ7teRpwWHUSDtS9HLQuxEDxjs=;
        b=MMSQPCahpS0D1bVt/mq+6wal33RtHXxzi2fjFr+5DuyM4D3OtEKDH+RIdRKHLPOZKg43G6
        DnxznJJ1yGbJOqZjkaFuagjOf4b3R/+SMlHoxpjfGTWzVlvDwUhiDcU4bKZp8QE6PcWApX
        gnRRGL9+tJlxmcPWF3srNoLxboFeF+g=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/mce: Always inline old MCA stubs
Date:   Wed, 22 Feb 2023 20:10:54 +0100
Message-Id: <20230222191054.4701-1-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

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
---
 arch/x86/kernel/cpu/mce/internal.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 91a415553c27..d2412ce2d312 100644
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
-- 
2.35.1

