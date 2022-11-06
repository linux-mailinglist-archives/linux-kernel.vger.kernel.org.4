Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4359661E125
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 10:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiKFJFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 04:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiKFJFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 04:05:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A6355B0;
        Sun,  6 Nov 2022 01:05:10 -0800 (PST)
Date:   Sun, 06 Nov 2022 09:05:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667725508;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=89gCVDJVAOWy3TSZEo3iFfGJsyh+x/Z/Kw/KHr7+1G4=;
        b=K0Z7rtmpD1pSUjLm7CbE8heLq7Vnpq4ww8AwA/7Z1euaOKZr9xO6mhNP2ILcOoCKELb1VM
        sXWQbaftIxGmqv+3fkIm1o44Fn8WXWXe0cX8byoakqbWaaeA73NZpfAGmHBHifIRenPr9Y
        yJ1NSQVwdBSvirl4niZg2ZZHCOkzVFU+KX5OLCcCd4h4333brHzJCQymKXxG82ufHWPy03
        x8qBJ0P/SVCirrpa/iSQZb1LnTxHFDRlfhWsPSEybvRyYnejvlc9l94CHJIpaxRlxtW8v+
        xZlDtOjTJjAZFhHt0waBgLCQcyDx0KCdmTan8sVE4Miq6701CXBsV4wriJDXnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667725508;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=89gCVDJVAOWy3TSZEo3iFfGJsyh+x/Z/Kw/KHr7+1G4=;
        b=EBX8rKjEXGPoJqRNsDF8f07P7YU2voxjRGh7vU0vuZQ7sn+s5aPLkVnHY+yeIJuQDRo/+3
        1TbiaLSWIEwYiUCQ==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cpufeatures: Move X86_FEATURE_CALL_DEPTH from bit
 18 to bit 19 of word 11, to leave space for WIP X86_FEATURE_SGX_EDECCSSA bit
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
MIME-Version: 1.0
Message-ID: <166772550650.4906.6007680313066821301.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     b1599915f09157e98f59556e1b2eafe473603347
Gitweb:        https://git.kernel.org/tip/b1599915f09157e98f59556e1b2eafe473603347
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Sun, 06 Nov 2022 09:55:56 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 06 Nov 2022 09:58:36 +01:00

x86/cpufeatures: Move X86_FEATURE_CALL_DEPTH from bit 18 to bit 19 of word 11, to leave space for WIP X86_FEATURE_SGX_EDECCSSA bit

Reallocate a soft-cpufeatures bit allocated for call-depth tracking
code, which clashes with this recent KVM/SGX patch being worked on:

        KVM/VMX: Allow exposing EDECCSSA user leaf function to KVM guest

Instead of reallocating cpufeatures bits in evil merges, make the
allocation explicit.

Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/cpufeatures.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index aefd081..864c9b0 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -304,7 +304,8 @@
 #define X86_FEATURE_UNRET		(11*32+15) /* "" AMD BTB untrain return */
 #define X86_FEATURE_USE_IBPB_FW		(11*32+16) /* "" Use IBPB during runtime firmware calls */
 #define X86_FEATURE_RSB_VMEXIT_LITE	(11*32+17) /* "" Fill RSB on VM exit when EIBRS is enabled */
-#define X86_FEATURE_CALL_DEPTH		(11*32+18) /* "" Call depth tracking for RSB stuffing */
+						   /* Hole left for X86_FEATURE_SGX_EDECCSSA */
+#define X86_FEATURE_CALL_DEPTH		(11*32+19) /* "" Call depth tracking for RSB stuffing */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
