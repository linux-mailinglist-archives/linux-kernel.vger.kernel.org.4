Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE7B601202
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbiJQO54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbiJQO4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:56:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877483ECC2;
        Mon, 17 Oct 2022 07:54:46 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:54:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018455;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FLezqtQQ5iVLmev/xqoYlFOq3mXpnUE8ge4MbonOoyE=;
        b=SlnrdDUEgoYbiIVpD7DewCPwjNZhebB45DIgkm2LdkrnxOrVyIwXif3+VFENcx/AC0A6T7
        qN9wGeIaraoq1kHNdTDhkPw9Rb8yu4aixAJcNdSq4ozhULfyFE9MLND8Wp5k9pn7zphQ9z
        jSSXcPCrbh24QxRmagsIISoALNIfz5YJ+dsC1Gs3cBJ0j0KhG3aNp4MdEX3XV1CmgILPhG
        0kZ0PdrRAqb1e/vnqQMhEWF5EuQqzfCH/zCXsFumjzGQK7vPtUPUYhK0QorAEqiNsoAB0i
        M1anwyw1ckfzDPXuirchrQahMJavrgHQJAKXIBv1Qs6hcJTs5KR+AcbtdurLZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018455;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FLezqtQQ5iVLmev/xqoYlFOq3mXpnUE8ge4MbonOoyE=;
        b=yXMXVGLzBs6Agt6PYI+PhbVd4eBybcihsh5GY/ai2V3/xurfMcYTD33d3WCkpSNfp4UfPQ
        kMyBzQC9QuOKQiBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] crypto: x86/sha256: Remove custom alignments
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111144.766564176@infradead.org>
References: <20220915111144.766564176@infradead.org>
MIME-Version: 1.0
Message-ID: <166601845398.401.7795468916886779977.tip-bot2@tip-bot2>
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

Commit-ID:     3ba56d0b87113785413dfc5b9910d45001cc4eeb
Gitweb:        https://git.kernel.org/tip/3ba56d0b87113785413dfc5b9910d45001cc4eeb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Sep 2022 13:10:57 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:02 +02:00

crypto: x86/sha256: Remove custom alignments

SYM_FUNC_START*() and friends already imply alignment, remove custom
alignment hacks to make code consistent. This prepares for future
function call ABI changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111144.766564176@infradead.org
---
 arch/x86/crypto/sha256-avx-asm.S   | 1 -
 arch/x86/crypto/sha256-avx2-asm.S  | 1 -
 arch/x86/crypto/sha256-ssse3-asm.S | 1 -
 arch/x86/crypto/sha256_ni_asm.S    | 1 -
 4 files changed, 4 deletions(-)

diff --git a/arch/x86/crypto/sha256-avx-asm.S b/arch/x86/crypto/sha256-avx-asm.S
index 3baa1ec..3649370 100644
--- a/arch/x86/crypto/sha256-avx-asm.S
+++ b/arch/x86/crypto/sha256-avx-asm.S
@@ -347,7 +347,6 @@ a = TMP_
 ########################################################################
 .text
 SYM_FUNC_START(sha256_transform_avx)
-.align 32
 	pushq   %rbx
 	pushq   %r12
 	pushq   %r13
diff --git a/arch/x86/crypto/sha256-avx2-asm.S b/arch/x86/crypto/sha256-avx2-asm.S
index 9bcdbc4..c4c1dc5 100644
--- a/arch/x86/crypto/sha256-avx2-asm.S
+++ b/arch/x86/crypto/sha256-avx2-asm.S
@@ -524,7 +524,6 @@ STACK_SIZE	= _CTX      + _CTX_SIZE
 ########################################################################
 .text
 SYM_FUNC_START(sha256_transform_rorx)
-.align 32
 	pushq	%rbx
 	pushq	%r12
 	pushq	%r13
diff --git a/arch/x86/crypto/sha256-ssse3-asm.S b/arch/x86/crypto/sha256-ssse3-asm.S
index c4a5db6..96b7dcd 100644
--- a/arch/x86/crypto/sha256-ssse3-asm.S
+++ b/arch/x86/crypto/sha256-ssse3-asm.S
@@ -356,7 +356,6 @@ a = TMP_
 ########################################################################
 .text
 SYM_FUNC_START(sha256_transform_ssse3)
-.align 32
 	pushq   %rbx
 	pushq   %r12
 	pushq   %r13
diff --git a/arch/x86/crypto/sha256_ni_asm.S b/arch/x86/crypto/sha256_ni_asm.S
index 94d50dd..b3f1a1a 100644
--- a/arch/x86/crypto/sha256_ni_asm.S
+++ b/arch/x86/crypto/sha256_ni_asm.S
@@ -96,7 +96,6 @@
  */
 
 .text
-.align 32
 SYM_FUNC_START(sha256_ni_transform)
 
 	shl		$6, NUM_BLKS		/*  convert to bytes */
