Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6676A601204
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiJQO5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbiJQO4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:56:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E60DE030;
        Mon, 17 Oct 2022 07:54:27 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:54:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018453;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qexTjwvBEMZP3z/N2D4PV3dqZ72QFc/eVHvg4RVB0lU=;
        b=X13Ka9YHlYi0a5YS6YKQvzlzsMsCz+p+UfRuwvFjy9SKiU//ZccxgOMwmQLnQnpHGSqENR
        Pky9kd/eSJRyZ0cRgTuHm8D/OqHfgv3ZehfFeoSd1cY9iVn1AFkAafVY4uMqHGNrADtEn9
        Z6B7jDVmTRacM680TXIjJJyr3YDVLSPuJzqlbJDEdfe7Qwe/qaLHJvd7EDxdCpT2NA7u5Z
        TBTXeC+g8GI8NkZMzv4EA7GgToVAa9lWAQyaAubru8M0+7K+xZmQhoH22S2Hc8ZbK0tZ+N
        CpqXpfMIBv2u2c72N3rlxKNzyoCi0yMIn2aeV2/Apu7Y/iEA47tcvYxJ8X5yhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018453;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qexTjwvBEMZP3z/N2D4PV3dqZ72QFc/eVHvg4RVB0lU=;
        b=Ej7EikASQj1eurdgHsMj4LYGFVtTgm2KdVKbzcpTXqAvA9W9eKUHq3tlWnaXm8KkQWmYWk
        xoMkVETYIaqDzcAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] crypto: twofish: Remove redundant alignments
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111144.971229477@infradead.org>
References: <20220915111144.971229477@infradead.org>
MIME-Version: 1.0
Message-ID: <166601845185.401.1186833296589564467.tip-bot2@tip-bot2>
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

Commit-ID:     e2c9475e88f70820270ca5cc81a1ae2fda262278
Gitweb:        https://git.kernel.org/tip/e2c9475e88f70820270ca5cc81a1ae2fda262278
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Sep 2022 13:10:59 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:03 +02:00

crypto: twofish: Remove redundant alignments

SYM_FUNC_START*() and friends already imply alignment, remove custom
alignment hacks to make code consistent. This prepares for future
function call ABI changes.

Also, with having pushed the function alignment to 16 bytes, this
custom alignment is completely superfluous.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111144.971229477@infradead.org
---
 arch/x86/crypto/twofish-avx-x86_64-asm_64.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/crypto/twofish-avx-x86_64-asm_64.S b/arch/x86/crypto/twofish-avx-x86_64-asm_64.S
index 31f9b2e..12fde27 100644
--- a/arch/x86/crypto/twofish-avx-x86_64-asm_64.S
+++ b/arch/x86/crypto/twofish-avx-x86_64-asm_64.S
@@ -228,7 +228,6 @@
 	vpxor		x2, wkey, x2; \
 	vpxor		x3, wkey, x3;
 
-.align 8
 SYM_FUNC_START_LOCAL(__twofish_enc_blk8)
 	/* input:
 	 *	%rdi: ctx, CTX
@@ -270,7 +269,6 @@ SYM_FUNC_START_LOCAL(__twofish_enc_blk8)
 	RET;
 SYM_FUNC_END(__twofish_enc_blk8)
 
-.align 8
 SYM_FUNC_START_LOCAL(__twofish_dec_blk8)
 	/* input:
 	 *	%rdi: ctx, CTX
