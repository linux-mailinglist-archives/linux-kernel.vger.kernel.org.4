Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CB16011FF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbiJQO5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiJQO4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:56:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39C217891;
        Mon, 17 Oct 2022 07:54:32 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:54:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018457;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1sfzRz4opPhORO9puPX2ktK3rriuKzKuWqkUMoDztAI=;
        b=NZV/JOJz0AfDtIHR6V2NobeVFGET9MjOcEXRmns05mHy2hlyjTPbhkzRu6NKsa4nNczKKR
        iEe7K673jgUDuO6t/ksRKvzUjvLKyq5gom7DVDUcY3ZOIDL4tgjX0Hr9q8S1Ly8+VmqRBP
        ARjCA6ndLSyzuYQ3X5GO/JmUtq7ZKvd44NaPHC2KlkNymxFu5zkM+U43nQNDE8hhvNtIv9
        SmfePCI+y+ntldxglGasb5qdY3ZHGXqjDVyicobBZlatFYYDiIMAAyrGOiAQRUacoy/74C
        FAQBSKT61AGwVLdnPgEW4GTde2SpxAbMOM/5h1x9PoLViSH+D3QKNcwsry2Ddg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018457;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1sfzRz4opPhORO9puPX2ktK3rriuKzKuWqkUMoDztAI=;
        b=nITvcMEAJ9aM4vuF+FkK1BN0bBhFPunlhOjPBYPsjJrHVyUmp8+rFqeaXdUyMGes50bxIk
        luPSMXWPNdwCRXBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] crypto: x86/serpent: Remove redundant alignments
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111144.558544791@infradead.org>
References: <20220915111144.558544791@infradead.org>
MIME-Version: 1.0
Message-ID: <166601845607.401.14987443239536693764.tip-bot2@tip-bot2>
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

Commit-ID:     8b44221671ec45d725a4558ff7aa5ea90ecfc885
Gitweb:        https://git.kernel.org/tip/8b44221671ec45d725a4558ff7aa5ea90ecfc885
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Sep 2022 13:10:55 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:01 +02:00

crypto: x86/serpent: Remove redundant alignments

SYM_FUNC_START*() and friends already imply alignment, remove custom
alignment hacks to make code consistent. This prepares for future
function call ABI changes.

Also, with having pushed the function alignment to 16 bytes, this
custom alignment is completely superfluous.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111144.558544791@infradead.org
---
 arch/x86/crypto/serpent-avx-x86_64-asm_64.S | 2 --
 arch/x86/crypto/serpent-avx2-asm_64.S       | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/x86/crypto/serpent-avx-x86_64-asm_64.S b/arch/x86/crypto/serpent-avx-x86_64-asm_64.S
index 82f2313..97e2836 100644
--- a/arch/x86/crypto/serpent-avx-x86_64-asm_64.S
+++ b/arch/x86/crypto/serpent-avx-x86_64-asm_64.S
@@ -550,7 +550,6 @@
 #define write_blocks(x0, x1, x2, x3, t0, t1, t2) \
 	transpose_4x4(x0, x1, x2, x3, t0, t1, t2)
 
-.align 8
 SYM_FUNC_START_LOCAL(__serpent_enc_blk8_avx)
 	/* input:
 	 *	%rdi: ctx, CTX
@@ -604,7 +603,6 @@ SYM_FUNC_START_LOCAL(__serpent_enc_blk8_avx)
 	RET;
 SYM_FUNC_END(__serpent_enc_blk8_avx)
 
-.align 8
 SYM_FUNC_START_LOCAL(__serpent_dec_blk8_avx)
 	/* input:
 	 *	%rdi: ctx, CTX
diff --git a/arch/x86/crypto/serpent-avx2-asm_64.S b/arch/x86/crypto/serpent-avx2-asm_64.S
index 8ea34c9..6d60c50 100644
--- a/arch/x86/crypto/serpent-avx2-asm_64.S
+++ b/arch/x86/crypto/serpent-avx2-asm_64.S
@@ -550,7 +550,6 @@
 #define write_blocks(x0, x1, x2, x3, t0, t1, t2) \
 	transpose_4x4(x0, x1, x2, x3, t0, t1, t2)
 
-.align 8
 SYM_FUNC_START_LOCAL(__serpent_enc_blk16)
 	/* input:
 	 *	%rdi: ctx, CTX
@@ -604,7 +603,6 @@ SYM_FUNC_START_LOCAL(__serpent_enc_blk16)
 	RET;
 SYM_FUNC_END(__serpent_enc_blk16)
 
-.align 8
 SYM_FUNC_START_LOCAL(__serpent_dec_blk16)
 	/* input:
 	 *	%rdi: ctx, CTX
