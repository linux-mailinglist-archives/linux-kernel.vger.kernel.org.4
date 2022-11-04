Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C143661A57F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 00:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiKDXNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 19:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiKDXNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 19:13:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFE05F56;
        Fri,  4 Nov 2022 16:13:32 -0700 (PDT)
Date:   Fri, 04 Nov 2022 23:13:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667603611;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=SqkAnomT/JrLiYy2TS/nUGgJrLXjfy6GyuJiR/AKF0s=;
        b=dd+MNtJIpvG7DzaCGu4MnZPdBlFmkwbpnJ/nlVlXO8B3LsfBKhdDg2b/xabS8qIudmw2c2
        EBKJ88NCrYbx2NTakWwx4qA89DIPotEgO9t91mjQ6wHR15HvRaYf5tLjz4aOhBlZA5tjh5
        BhSWYozuklyyN2LiLZU/kKCo0lnPDY4dbYmyRVMHoGSf+WDTs71QqXYmOPThHr/fEi985o
        HjScjYEI/KeTqMRKW1PJoXo8Y5rdSvDuwfcmtqaMMrXSb2dMpJ/saPept0yqi8nFyjN2I6
        OfsUIPv5ts63SzmfQqQYaXDvjnBtiB7xyPmGD/xAQ7ijRDc8Vt+XGyJ05JDcMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667603611;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=SqkAnomT/JrLiYy2TS/nUGgJrLXjfy6GyuJiR/AKF0s=;
        b=Fzzr9p/XSUCwJOckgc8/hXPHHc5B9oE/xBffBIGWKAz8cg8E6vkDJKEdd0vBtzaRjnIUep
        OBNosd8GJG3rDcBQ==
From:   "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Allow enclaves to use Asynchrounous Exit Notification
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Haitao Huang <haitao.huang@intel.com>,
        Kai Huang <kai.huang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166760360934.4906.2427175408052308969.tip-bot2@tip-bot2>
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

Commit-ID:     370839c241f7b98c66063c2892795a37ee3d2771
Gitweb:        https://git.kernel.org/tip/370839c241f7b98c66063c2892795a37ee3d2771
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Wed, 20 Jul 2022 12:13:47 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 04 Nov 2022 15:33:30 -07:00

x86/sgx: Allow enclaves to use Asynchrounous Exit Notification

Short Version:

Allow enclaves to use the new Asynchronous EXit (AEX)
notification mechanism.  This mechanism lets enclaves run a
handler after an AEX event.  These handlers can run mitigations
for things like SGX-Step[1].

AEX Notify will be made available both on upcoming processors and
on some older processors through microcode updates.

Long Version:

== SGX Attribute Background ==

The SGX architecture includes a list of SGX "attributes".  These
attributes ensure consistency and transparency around specific
enclave features.

As a simple example, the "DEBUG" attribute allows an enclave to
be debugged, but also destroys virtually all of SGX security.
Using attributes, enclaves can know that they are being debugged.
Attributes also affect enclave attestation so an enclave can, for
instance, be denied access to secrets while it is being debugged.

The kernel keeps a list of known attributes and will only
initialize enclaves that use a known set of attributes.  This
kernel policy eliminates the chance that a new SGX attribute
could cause undesired effects.

For example, imagine a new attribute was added called
"PROVISIONKEY2" that provided similar functionality to
"PROVISIIONKEY".  A kernel policy that allowed indiscriminate use
of unknown attributes and thus PROVISIONKEY2 would undermine the
existing kernel policy which limits use of PROVISIONKEY enclaves.

== AEX Notify Background ==

"Intel Architecture Instruction Set Extensions and Future
Features - Version 45" is out[2].  There is a new chapter:

	Asynchronous Enclave Exit Notify and the EDECCSSA User Leaf Function.

Enclaves exit can be either synchronous and consensual (EEXIT for
instance) or asynchronous (on an interrupt or fault).  The
asynchronous ones can evidently be exploited to single step
enclaves[1], on top of which other naughty things can be built.

AEX Notify will be made available both on upcoming processors and
on some older processors through microcode updates.

== The Problem ==

These attacks are currently entirely opaque to the enclave since
the hardware does the save/restore under the covers. The
Asynchronous Enclave Exit Notify (AEX Notify) mechanism provides
enclaves an ability to detect and mitigate potential exposure to
these kinds of attacks.

== The Solution ==

Define the new attribute value for AEX Notification.  Ensure the
attribute is cleared from the list reserved attributes.  Instead
of adding to the open-coded lists of individual attributes,
add named lists of privileged (disallowed by default) and
unprivileged (allowed by default) attributes.  Add the AEX notify
attribute as an unprivileged attribute, which will keep the kernel
from rejecting enclaves with it set.

1. https://github.com/jovanbulck/sgx-step
2. https://cdrdv2.intel.com/v1/dl/getContent/671368?explicitVersion=true

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Haitao Huang <haitao.huang@intel.com>
Tested-by: Kai Huang <kai.huang@intel.com>
Link: https://lore.kernel.org/all/20220720191347.1343986-1-dave.hansen%40linux.intel.com
---
 arch/x86/include/asm/sgx.h      | 33 +++++++++++++++++++++++++-------
 arch/x86/kernel/cpu/sgx/ioctl.c |  2 +-
 arch/x86/kvm/cpuid.c            |  4 +---
 3 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
index eae20fa..6a00697 100644
--- a/arch/x86/include/asm/sgx.h
+++ b/arch/x86/include/asm/sgx.h
@@ -115,17 +115,36 @@ enum sgx_miscselect {
  * %SGX_ATTR_EINITTOKENKEY:	Allow to use token signing key that is used to
  *				sign cryptographic tokens that can be passed to
  *				EINIT as an authorization to run an enclave.
+ * %SGX_ATTR_ASYNC_EXIT_NOTIFY:	Allow enclaves to be notified after an
+ *				asynchronous exit has occurred.
  */
 enum sgx_attribute {
-	SGX_ATTR_INIT		= BIT(0),
-	SGX_ATTR_DEBUG		= BIT(1),
-	SGX_ATTR_MODE64BIT	= BIT(2),
-	SGX_ATTR_PROVISIONKEY	= BIT(4),
-	SGX_ATTR_EINITTOKENKEY	= BIT(5),
-	SGX_ATTR_KSS		= BIT(7),
+	SGX_ATTR_INIT		   = BIT(0),
+	SGX_ATTR_DEBUG		   = BIT(1),
+	SGX_ATTR_MODE64BIT	   = BIT(2),
+				  /* BIT(3) is reserved */
+	SGX_ATTR_PROVISIONKEY	   = BIT(4),
+	SGX_ATTR_EINITTOKENKEY	   = BIT(5),
+				  /* BIT(6) is for CET */
+	SGX_ATTR_KSS		   = BIT(7),
+				  /* BIT(8) is reserved */
+				  /* BIT(9) is reserved */
+	SGX_ATTR_ASYNC_EXIT_NOTIFY = BIT(10),
 };
 
-#define SGX_ATTR_RESERVED_MASK	(BIT_ULL(3) | BIT_ULL(6) | GENMASK_ULL(63, 8))
+#define SGX_ATTR_RESERVED_MASK	(BIT_ULL(3) | \
+				 BIT_ULL(6) | \
+				 BIT_ULL(8) | \
+				 BIT_ULL(9) | \
+				 GENMASK_ULL(63, 11))
+
+#define SGX_ATTR_UNPRIV_MASK	(SGX_ATTR_DEBUG	    | \
+				 SGX_ATTR_MODE64BIT | \
+				 SGX_ATTR_KSS	    | \
+				 SGX_ATTR_ASYNC_EXIT_NOTIFY)
+
+#define SGX_ATTR_PRIV_MASK	(SGX_ATTR_PROVISIONKEY	| \
+				 SGX_ATTR_EINITTOKENKEY)
 
 /**
  * struct sgx_secs - SGX Enclave Control Structure (SECS)
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index ebe79d6..ef87482 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -111,7 +111,7 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
 	encl->base = secs->base;
 	encl->size = secs->size;
 	encl->attributes = secs->attributes;
-	encl->attributes_mask = SGX_ATTR_DEBUG | SGX_ATTR_MODE64BIT | SGX_ATTR_KSS;
+	encl->attributes_mask = SGX_ATTR_UNPRIV_MASK;
 
 	/* Set only after completion, as encl->lock has not been taken. */
 	set_bit(SGX_ENCL_CREATED, &encl->flags);
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 7065462..7345bec 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1047,9 +1047,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		 * userspace.  ATTRIBUTES.XFRM is not adjusted as userspace is
 		 * expected to derive it from supported XCR0.
 		 */
-		entry->eax &= SGX_ATTR_DEBUG | SGX_ATTR_MODE64BIT |
-			      SGX_ATTR_PROVISIONKEY | SGX_ATTR_EINITTOKENKEY |
-			      SGX_ATTR_KSS;
+		entry->eax &= SGX_ATTR_PRIV_MASK | SGX_ATTR_UNPRIV_MASK;
 		entry->ebx &= 0;
 		break;
 	/* Intel PT */
