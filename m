Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA80160120B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiJQO6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiJQO47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:56:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF1968CC7;
        Mon, 17 Oct 2022 07:54:56 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:54:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018459;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yTqVaPAAkW+FpvPt5Mcc3q5ZeCCWwl1w0D7+Tfj2JlM=;
        b=E4K/q6hXiW2Qak214A7ljT6a86H305d8fRby1Yk0h6PumwrKjmXbk6+MscqSqKYafro5B+
        QvKvU9ynjuwjlyET5L5KYq683Oa8CgFDFirMsUXNsPQ+VyV53WJbQj6it8TBvXWFUA4kS4
        n1TErjvrc8SEUWTh13TPmUjNIS1CiV9sYhFpIjxv66aH+A+rkLw4K2zG1dP7BdkVVTgUKJ
        40lAzunHkv6lXLF3AeM9QX+vu05v4JZI4gBPhrOPZ49QSUcyBBudBFj5q+x84iSRIHbQgH
        duXdsv392smv/b1JYaPzIZJXB7WrgpY0u8lscQAT4hBVaJpZtzhNwGlLQHIQCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018459;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yTqVaPAAkW+FpvPt5Mcc3q5ZeCCWwl1w0D7+Tfj2JlM=;
        b=J2eSzWLVGXTBWtOMAmH24tYNx6g40j2YKbp3kMlP57211z3WZxHhsvqe9Kwk9uhAeNG2Qt
        UjcxSZdyZ86tx9Dw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] crypto: x86/cast5: Remove redundant alignments
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111144.353555711@infradead.org>
References: <20220915111144.353555711@infradead.org>
MIME-Version: 1.0
Message-ID: <166601845819.401.13306100807926675529.tip-bot2@tip-bot2>
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

Commit-ID:     88cdf02551f9aef9284d778ecd375c400555d900
Gitweb:        https://git.kernel.org/tip/88cdf02551f9aef9284d778ecd375c400555d900
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Sep 2022 13:10:53 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:00 +02:00

crypto: x86/cast5: Remove redundant alignments

SYM_FUNC_START*() and friends already imply alignment, remove custom
alignment hacks to make code consistent. This prepares for future
function call ABI changes.

Also, with having pushed the function alignment to 16 bytes, this
custom alignment is completely superfluous.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111144.353555711@infradead.org
---
 arch/x86/crypto/cast5-avx-x86_64-asm_64.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/crypto/cast5-avx-x86_64-asm_64.S b/arch/x86/crypto/cast5-avx-x86_64-asm_64.S
index b258af4..0326a01 100644
--- a/arch/x86/crypto/cast5-avx-x86_64-asm_64.S
+++ b/arch/x86/crypto/cast5-avx-x86_64-asm_64.S
@@ -208,7 +208,6 @@
 
 .text
 
-.align 16
 SYM_FUNC_START_LOCAL(__cast5_enc_blk16)
 	/* input:
 	 *	%rdi: ctx
@@ -282,7 +281,6 @@ SYM_FUNC_START_LOCAL(__cast5_enc_blk16)
 	RET;
 SYM_FUNC_END(__cast5_enc_blk16)
 
-.align 16
 SYM_FUNC_START_LOCAL(__cast5_dec_blk16)
 	/* input:
 	 *	%rdi: ctx
