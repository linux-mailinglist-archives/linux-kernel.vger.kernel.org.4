Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE99D6011FC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbiJQO5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbiJQOzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:55:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4E5140CB;
        Mon, 17 Oct 2022 07:54:31 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:54:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018456;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AGBbysbjzr0E0QlYL0vl/pFA9H8n7vXtJQU/qlUzwUU=;
        b=zsSY7CJRcq3oh5QaIQp4hFBkflR4dPVatIKIcXr/p6HegLTThT0la0ZcM9lpqRMSNssc+y
        DzjIaE/LWDapCZrv/XHlCBAW4NRgrWC1bOhIWInRsXim2n3oCpEiH3oW+q21E6lxqbalBt
        61DtgEFG/Ux+MKy93EaZdCkYtypa9HdzNzRPErEeNWQVEVxr73MI1suovDjTtVA0O3KvS7
        N2HFdl0yYnG8t6RZ+0PEKWJeQDUsfB6D+adnd4tRqssNyEEISCYc9Irm6v5f3Z//x8hHoO
        aoB1s/D4qXyMXddAS8tBb1ibGfg6lFc6r72cKCRRrPruiTrkcePz1FpY3dtvDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018456;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AGBbysbjzr0E0QlYL0vl/pFA9H8n7vXtJQU/qlUzwUU=;
        b=zUpKeebgdekieh4sCVlFLuk3PQrc4ipRxB7M49wwwJHcl60iM7eVuvIwSTt6KiVReCIdiK
        Ou5MVVm8m4ZjUyCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] crypto: x86/sha1: Remove custom alignments
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111144.662580589@infradead.org>
References: <20220915111144.662580589@infradead.org>
MIME-Version: 1.0
Message-ID: <166601845501.401.10686948861052189481.tip-bot2@tip-bot2>
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

Commit-ID:     c2a3ce6fdb122b12bc4cfffd28ecf8a9fb0d6736
Gitweb:        https://git.kernel.org/tip/c2a3ce6fdb122b12bc4cfffd28ecf8a9fb0d6736
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Sep 2022 13:10:56 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:01 +02:00

crypto: x86/sha1: Remove custom alignments

SYM_FUNC_START*() and friends already imply alignment, remove custom
alignment hacks to make code consistent. This prepares for future
function call ABI changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111144.662580589@infradead.org
---
 arch/x86/crypto/sha1_ni_asm.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/crypto/sha1_ni_asm.S b/arch/x86/crypto/sha1_ni_asm.S
index 2f94ec0..cd943b2 100644
--- a/arch/x86/crypto/sha1_ni_asm.S
+++ b/arch/x86/crypto/sha1_ni_asm.S
@@ -92,7 +92,6 @@
  * numBlocks: Number of blocks to process
  */
 .text
-.align 32
 SYM_FUNC_START(sha1_ni_transform)
 	push		%rbp
 	mov		%rsp, %rbp
