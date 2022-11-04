Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637D061A580
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 00:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiKDXNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 19:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKDXNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 19:13:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF9D5F4E;
        Fri,  4 Nov 2022 16:13:32 -0700 (PDT)
Date:   Fri, 04 Nov 2022 23:13:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667603610;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8oav//qRrb9yy+JSjLzHd0ymehB7QTQkYUzcq8adcJk=;
        b=Hy4AyyFtZoDOsSYY4KpnZT7aZj/KEAfFLRna679vS3svViZ2Kq8opCUbNfzlWm9UNw1qFq
        eyrVqDcWE+maoWm3roSQ92MJwvGivFA2dBmLYF0WTrs6Vdprgzn83ESAfivg3kuJsxN2we
        0W9PNVZcJBMKQHVyServeG98pC8JCoBJ8NR4rOKR35036D6zgAioQ9fKumTHlqPbNwRBG/
        Llw3JDx0YnBtmi5L15/XeS4SjjXZJ9jfvAcQQG6EgevSJlNS50uN/REWSQ4Od9seG7KvWN
        FFxPtwjX0Bbo5CHbVHc9SGVITMUEvtmvKyGU1dEO8F2X3S7636TCb8Wv31YDlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667603610;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8oav//qRrb9yy+JSjLzHd0ymehB7QTQkYUzcq8adcJk=;
        b=sgJNEXzoYu90VEavbgzqmcFqvszmyQ/+sunY1T0ahe6HxErhNKVNObfz9BIFBIW0tyKAZk
        Rd3uKVm9GwfegACg==
From:   "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] KVM/VMX: Allow exposing EDECCSSA user leaf function to
 KVM guest
Cc:     Kai Huang <kai.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166760360549.4906.809756297092548496.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     16a7fe3728a8b832ef0d1add66875a666b1f24fc
Gitweb:        https://git.kernel.org/tip/16a7fe3728a8b832ef0d1add66875a666b1f24fc
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Tue, 01 Nov 2022 15:24:22 +13:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 04 Nov 2022 15:33:56 -07:00

KVM/VMX: Allow exposing EDECCSSA user leaf function to KVM guest

The new Asynchronous Exit (AEX) notification mechanism (AEX-notify)
allows one enclave to receive a notification in the ERESUME after the
enclave exit due to an AEX.  EDECCSSA is a new SGX user leaf function
(ENCLU[EDECCSSA]) to facilitate the AEX notification handling.  The new
EDECCSSA is enumerated via CPUID(EAX=0x12,ECX=0x0):EAX[11].

Besides Allowing reporting the new AEX-notify attribute to KVM guests,
also allow reporting the new EDECCSSA user leaf function to KVM guests
so the guest can fully utilize the AEX-notify mechanism.

Similar to existing X86_FEATURE_SGX1 and X86_FEATURE_SGX2, introduce a
new scattered X86_FEATURE_SGX_EDECCSSA bit for the new EDECCSSA, and
report it in KVM's supported CPUIDs.

Note, no additional KVM enabling is required to allow the guest to use
EDECCSSA.  It's impossible to trap ENCLU (without completely preventing
the guest from using SGX).  Advertise EDECCSSA as supported purely so
that userspace doesn't need to special case EDECCSSA, i.e. doesn't need
to manually check host CPUID.

The inability to trap ENCLU also means that KVM can't prevent the guest
from using EDECCSSA, but that virtualization hole is benign as far as
KVM is concerned.  EDECCSSA is simply a fancy way to modify internal
enclave state.

More background about how do AEX-notify and EDECCSSA work:

SGX maintains a Current State Save Area Frame (CSSA) for each enclave
thread.  When AEX happens, the enclave thread context is saved to the
CSSA and the CSSA is increased by 1.  For a normal ERESUME which doesn't
deliver AEX notification, it restores the saved thread context from the
previously saved SSA and decreases the CSSA.  If AEX-notify is enabled
for one enclave, the ERESUME acts differently.  Instead of restoring the
saved thread context and decreasing the CSSA, it acts like EENTER which
doesn't decrease the CSSA but establishes a clean slate thread context
using the CSSA for the enclave to handle the notification.  After some
handling, the enclave must discard the "new-established" SSA and switch
back to the previously saved SSA (upon AEX).  Otherwise, the enclave
will run out of SSA space upon further AEXs and eventually fail to run.

To solve this problem, the new EDECCSSA essentially decreases the CSSA.
It can be used by the enclave notification handler to switch back to the
previous saved SSA when needed, i.e. after it handles the notification.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Sean Christopherson <seanjc@google.com>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lore.kernel.org/all/20221101022422.858944-1-kai.huang%40intel.com
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/cpuid-deps.c   | 1 +
 arch/x86/kernel/cpu/scattered.c    | 1 +
 arch/x86/kvm/cpuid.c               | 2 +-
 arch/x86/kvm/reverse_cpuid.h       | 3 +++
 5 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index b71f4f2..d0d7edd 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -304,6 +304,7 @@
 #define X86_FEATURE_UNRET		(11*32+15) /* "" AMD BTB untrain return */
 #define X86_FEATURE_USE_IBPB_FW		(11*32+16) /* "" Use IBPB during runtime firmware calls */
 #define X86_FEATURE_RSB_VMEXIT_LITE	(11*32+17) /* "" Fill RSB on VM exit when EIBRS is enabled */
+#define X86_FEATURE_SGX_EDECCSSA	(11*32+18) /* "" SGX EDECCSSA user leaf function */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index c881bca..d952211 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -75,6 +75,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_SGX_LC,			X86_FEATURE_SGX	      },
 	{ X86_FEATURE_SGX1,			X86_FEATURE_SGX       },
 	{ X86_FEATURE_SGX2,			X86_FEATURE_SGX1      },
+	{ X86_FEATURE_SGX_EDECCSSA,		X86_FEATURE_SGX1      },
 	{ X86_FEATURE_XFD,			X86_FEATURE_XSAVES    },
 	{ X86_FEATURE_XFD,			X86_FEATURE_XGETBV1   },
 	{ X86_FEATURE_AMX_TILE,			X86_FEATURE_XFD       },
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index fc01f81..f53944f 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -40,6 +40,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_PER_THREAD_MBA,	CPUID_ECX,  0, 0x00000010, 3 },
 	{ X86_FEATURE_SGX1,		CPUID_EAX,  0, 0x00000012, 0 },
 	{ X86_FEATURE_SGX2,		CPUID_EAX,  1, 0x00000012, 0 },
+	{ X86_FEATURE_SGX_EDECCSSA,	CPUID_EAX, 11, 0x00000012, 0 },
 	{ X86_FEATURE_HW_PSTATE,	CPUID_EDX,  7, 0x80000007, 0 },
 	{ X86_FEATURE_CPB,		CPUID_EDX,  9, 0x80000007, 0 },
 	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 7345bec..44151d2 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -665,7 +665,7 @@ void kvm_set_cpu_caps(void)
 	);
 
 	kvm_cpu_cap_init_scattered(CPUID_12_EAX,
-		SF(SGX1) | SF(SGX2)
+		SF(SGX1) | SF(SGX2) | SF(SGX_EDECCSSA)
 	);
 
 	kvm_cpu_cap_mask(CPUID_8000_0001_ECX,
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index a19d473..4e5b844 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -23,6 +23,7 @@ enum kvm_only_cpuid_leafs {
 /* Intel-defined SGX sub-features, CPUID level 0x12 (EAX). */
 #define KVM_X86_FEATURE_SGX1		KVM_X86_FEATURE(CPUID_12_EAX, 0)
 #define KVM_X86_FEATURE_SGX2		KVM_X86_FEATURE(CPUID_12_EAX, 1)
+#define KVM_X86_FEATURE_SGX_EDECCSSA	KVM_X86_FEATURE(CPUID_12_EAX, 11)
 
 struct cpuid_reg {
 	u32 function;
@@ -78,6 +79,8 @@ static __always_inline u32 __feature_translate(int x86_feature)
 		return KVM_X86_FEATURE_SGX1;
 	else if (x86_feature == X86_FEATURE_SGX2)
 		return KVM_X86_FEATURE_SGX2;
+	else if (x86_feature == X86_FEATURE_SGX_EDECCSSA)
+		return KVM_X86_FEATURE_SGX_EDECCSSA;
 
 	return x86_feature;
 }
