Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABBD6200E8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbiKGVS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbiKGVSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:18:15 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2909326C7
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 13:15:18 -0800 (PST)
Received: from zn.tnic (p200300ea9733e764329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e764:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 509E71EC059D;
        Mon,  7 Nov 2022 22:15:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667855717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=rbOTxD9ZKYlilVo5kI9gEidbFcfzuiyGtj4TcpECXu8=;
        b=DDfYNpFeTRMchdM0zB46lZpL48UYZdZzPzivVPw4P3pVwGaS3U8nPQgcgud1I4aocQ9CVV
        bAh2I6THf6v173aVuwdcmsXeaMGL5e5d9Qum20MRkjY+D0ba2ogrT9DGkSZm+gork34ZpF
        iszaL1Q3Tbr4CPSeLcOVoXoi3tkL1KU=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/cpu: Start documenting what the X86_FEATURE_ flag testing macros do
Date:   Mon,  7 Nov 2022 22:15:05 +0100
Message-Id: <20221107211505.8572-1-bp@alien8.de>
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

From: Borislav Petkov <bp@suse.de>

... and how and when they should be used.

This keeps popping up everytime people start poking at the CPU features
testing machinery - which has admittedly grown some warts and would need
cleaning up - or when they are wondering what function/macro to use.

Start documenting it first. Proper cleanup will follow once all the
functionality has been agreed upon.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220718141123.136106-3-mlevitsk@redhat.com
---
 arch/x86/include/asm/cpufeature.h | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 1a85e1fb0922..47ff025e7387 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -131,12 +131,13 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 		(unsigned long __percpu *)&cpu_info.x86_capability))
 
 /*
- * This macro is for detection of features which need kernel
- * infrastructure to be used.  It may *not* directly test the CPU
- * itself.  Use the cpu_has() family if you want true runtime
- * testing of CPU features, like in hypervisor code where you are
- * supporting a possible guest feature where host support for it
- * is not relevant.
+ * This is the preferred macro to use when testing X86_FEATURE_ bits
+ * support without the need to test on a particular CPU but rather
+ * system-wide. It takes into account build-time disabled feature
+ * support too. All those macros mirror the kernel's idea of enabled
+ * CPU features and not necessarily what real, hardware CPUID bits are
+ * set or clear. For that use tools/arch/x86/kcpuid/ and/or potentially
+ * extend if it's feature list is lacking.
  */
 #define cpu_feature_enabled(bit)	\
 	(__builtin_constant_p(bit) && DISABLED_MASK_BIT_SET(bit) ? 0 : static_cpu_has(bit))
@@ -145,9 +146,15 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 
 #define set_cpu_cap(c, bit)	set_bit(bit, (unsigned long *)((c)->x86_capability))
 
-extern void setup_clear_cpu_cap(unsigned int bit);
 extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
 
+/*
+ * The setup_* prefixed variants enable/disable feature bits on all
+ * CPUs in the system and are used to replicate those settings before
+ * apply_forced_caps() has synthesized enabled and disabled bits across
+ * every CPU.
+ */
+extern void setup_clear_cpu_cap(unsigned int bit);
 #define setup_force_cpu_cap(bit) do { \
 	set_cpu_cap(&boot_cpu_data, bit);	\
 	set_bit(bit, (unsigned long *)cpu_caps_set);	\
-- 
2.35.1

