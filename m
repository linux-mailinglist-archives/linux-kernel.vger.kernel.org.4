Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A952F688C05
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 01:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjBCAj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 19:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbjBCAjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 19:39:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F191A1423B;
        Thu,  2 Feb 2023 16:39:23 -0800 (PST)
Date:   Fri, 03 Feb 2023 00:39:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675384761;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2UdHPobREA1OAJD9vo+OWOWGgv3mCV9UwYQX2CtLC9M=;
        b=QPt/lvBAUAQ/jq8686FO+v3koeEV49op2bbqphUuOSWeUa/ve5aqchDUY/U2Ao4FHMxltg
        5P86M9JvkbMzpTOb4jj5G8sYvfE5ZK5Zbi3zmqprCGOAVGE35Dqa7j9VOldb2xzV657Bnu
        /71aOdZZ7VKEv+jGm0YaKwhj15jFbAal97UDV/Wn/2EV+UdUprFYIYOAOl+fW/cjDvTR5+
        clrbbvkff3TEW7/nZL5O2WvBf1J53JMT3KzFlstYwM/dq9xnqDhg612a0qysnLzNbcxdwG
        1MygfsHy2SAq+0VUZuV5uUXMKPq8Em3yn0+6p1YJIED1/RT7eI1XBwkm4KlF9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675384761;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2UdHPobREA1OAJD9vo+OWOWGgv3mCV9UwYQX2CtLC9M=;
        b=by1IKmjHXmrYGjgaN2sy7KkHTe6dvr2h6Mt+W5ZftUpzlcIwFdpRNzOsk03N/n19XSR+fX
        yhjw2N/E9l84p7BQ==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Do not corrupt frame-pointer in __tdx_hypercall()
Cc:     kernel test robot <lkp@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <202301290255.buUBs99R-lkp@intel.com>
References: <202301290255.buUBs99R-lkp@intel.com>
MIME-Version: 1.0
Message-ID: <167538476065.4906.7314136322537199231.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     1e70c680375aa33cca97bff0bca68c0f82f5023c
Gitweb:        https://git.kernel.org/tip/1e70c680375aa33cca97bff0bca68c0f82f5023c
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Mon, 30 Jan 2023 16:53:54 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 02 Feb 2023 16:31:25 -08:00

x86/tdx: Do not corrupt frame-pointer in __tdx_hypercall()

If compiled with CONFIG_FRAME_POINTER=y, objtool is not happy that
__tdx_hypercall() messes up RBP:

  objtool: __tdx_hypercall+0x7f: return with modified stack frame

Rework the function to store TDX_HCALL_ flags on stack instead of RBP.

[ dhansen: minor changelog tweaks ]

Fixes: c30c4b2555ba ("x86/tdx: Refactor __tdx_hypercall() to allow pass down more arguments")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/202301290255.buUBs99R-lkp@intel.com
Link: https://lore.kernel.org/all/20230130135354.27674-1-kirill.shutemov%40linux.intel.com
---
 arch/x86/coco/tdx/tdcall.S | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
index 5da06d1..2bd436a 100644
--- a/arch/x86/coco/tdx/tdcall.S
+++ b/arch/x86/coco/tdx/tdcall.S
@@ -131,11 +131,10 @@ SYM_FUNC_START(__tdx_hypercall)
 	push %r13
 	push %r12
 	push %rbx
-	push %rbp
 
 	/* Free RDI and RSI to be used as TDVMCALL arguments */
 	movq %rdi, %rax
-	movq %rsi, %rbp
+	push %rsi
 
 	/* Copy hypercall registers from arg struct: */
 	movq TDX_HYPERCALL_r8(%rax),  %r8
@@ -168,7 +167,7 @@ SYM_FUNC_START(__tdx_hypercall)
 	 * HLT operation indefinitely. Since this is the not the desired
 	 * result, conditionally call STI before TDCALL.
 	 */
-	testq $TDX_HCALL_ISSUE_STI, %rbp
+	testq $TDX_HCALL_ISSUE_STI, 8(%rsp)
 	jz .Lskip_sti
 	sti
 .Lskip_sti:
@@ -188,7 +187,7 @@ SYM_FUNC_START(__tdx_hypercall)
 	pop %rax
 
 	/* Copy hypercall result registers to arg struct if needed */
-	testq $TDX_HCALL_HAS_OUTPUT, %rbp
+	testq $TDX_HCALL_HAS_OUTPUT, (%rsp)
 	jz .Lout
 
 	movq %r8,  TDX_HYPERCALL_r8(%rax)
@@ -218,11 +217,12 @@ SYM_FUNC_START(__tdx_hypercall)
 	xor %r10d, %r10d
 	xor %r11d, %r11d
 	xor %rdi,  %rdi
-	xor %rsi,  %rsi
 	xor %rdx,  %rdx
 
+	/* Remove TDX_HCALL_* flags from the stack */
+	pop %rsi
+
 	/* Restore callee-saved GPRs as mandated by the x86_64 ABI */
-	pop %rbp
 	pop %rbx
 	pop %r12
 	pop %r13
