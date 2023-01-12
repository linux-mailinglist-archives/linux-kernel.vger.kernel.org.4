Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BD96671EC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbjALMRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbjALMQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:16:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A52B178BD;
        Thu, 12 Jan 2023 04:16:35 -0800 (PST)
Date:   Thu, 12 Jan 2023 12:16:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673525793;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bi+ExeYkOPbHhIAX1f7wJ9qfV6qFZ9z26zQbrh429vo=;
        b=Q1jlED7T0yntfen4zoO85B6YaBj0s7p8F0AcGDbTJQm/3QNL7xmX3MkO52uZPnI3HR2dkT
        qJP+BDGXOQJrIR3kl3LPU9icLQBvqgi3bcGoQLuQ7PajWWQVJpReDbKH4EHCTHcr5nSTkz
        8y9G5qYAC5EFXeGWFiH0YTsPNfTulgwz1jsqoQnItzGND8cOSDZJV6Bx5zzOm958GSwUo0
        6KO9iHFXrPahdNIcrJtUMQkgtR+c41lCKAKMsVzfleqjGJfKg8U79HSTevgjfm1V3wuakB
        FaVZAlPRnJ5sgMgjr+IgUUGRu4nSg+EgEuX8Nfme/lpRMwUvcOTMoHuXQoMhgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673525793;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bi+ExeYkOPbHhIAX1f7wJ9qfV6qFZ9z26zQbrh429vo=;
        b=bWnrcEeWnYOKYdsCjwAYL8nfUyE4P6yehJyC0bCTgDulU70c9Jfoti2BOrBuS2blvtgoZD
        GmD/BpNv5jkQwkAw==
From:   "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpufeature: Add the CPU feature bit for LKGS
Cc:     "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        Xin Li <xin3.li@intel.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230112072032.35626-2-xin3.li@intel.com>
References: <20230112072032.35626-2-xin3.li@intel.com>
MIME-Version: 1.0
Message-ID: <167352579328.4906.12902713679275801421.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     660569472dd7ac64571375b6727c3f2c1d70ba40
Gitweb:        https://git.kernel.org/tip/660569472dd7ac64571375b6727c3f2c1d7=
0ba40
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Wed, 11 Jan 2023 23:20:28 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 12 Jan 2023 13:06:20 +01:00

x86/cpufeature: Add the CPU feature bit for LKGS

Add the CPU feature bit for LKGS (Load "Kernel" GS).

LKGS instruction is introduced with Intel FRED (flexible return and
event delivery) specification. Search for the latest FRED spec in most
search engines with this search pattern:

  site:intel.com FRED (flexible return and event delivery) specification

LKGS behaves like the MOV to GS instruction except that it loads
the base address into the IA32_KERNEL_GS_BASE MSR instead of the
GS segment=E2=80=99s descriptor cache, which is exactly what Linux kernel
does to load a user level GS base.  Thus, with LKGS, there is no
need to SWAPGS away from the kernel GS base.

[ mingo: Minor tweaks to the description. ]

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230112072032.35626-2-xin3.li@intel.com
---
 arch/x86/include/asm/cpufeatures.h       | 1 +
 tools/arch/x86/include/asm/cpufeatures.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufea=
tures.h
index 6101247..b70111a 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -312,6 +312,7 @@
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions =
*/
 #define X86_FEATURE_CMPCCXADD           (12*32+ 7) /* "" CMPccXADD instructi=
ons */
+#define X86_FEATURE_LKGS		(12*32+18) /* "" Load "kernel" (userspace) GS */
 #define X86_FEATURE_AMX_FP16		(12*32+21) /* "" AMX fp16 Support */
 #define X86_FEATURE_AVX_IFMA            (12*32+23) /* "" Support for VPMADD5=
2[H,L]UQ */
=20
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/includ=
e/asm/cpufeatures.h
index 6101247..b70111a 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -312,6 +312,7 @@
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions =
*/
 #define X86_FEATURE_CMPCCXADD           (12*32+ 7) /* "" CMPccXADD instructi=
ons */
+#define X86_FEATURE_LKGS		(12*32+18) /* "" Load "kernel" (userspace) GS */
 #define X86_FEATURE_AMX_FP16		(12*32+21) /* "" AMX fp16 Support */
 #define X86_FEATURE_AVX_IFMA            (12*32+23) /* "" Support for VPMADD5=
2[H,L]UQ */
=20
