Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF40615F94
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiKBJXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiKBJVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:21:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B5965FB;
        Wed,  2 Nov 2022 02:20:11 -0700 (PDT)
Date:   Wed, 02 Nov 2022 09:20:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667380810;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gekW2k4HioQEvgXlGpgUbXsFnaC1UdihEoBTHF91PPQ=;
        b=QotaKAXMjo/QCPjtlD2sqG1wVxSq8Sd0mN55mFCsZ/MXAxzvDpSlec9oT9bTFdq4dnVMGg
        4NFTg7zo2BdU6Vffn72YtUSSRzFfHyl5i16ypllZ0EczSWUSDsJiz4Wvngvqcjf4Pa21a5
        FIwe8SqbjQRqEktj7KUO+OgkHYQhEUCmTmK1RrbMQD3tyfvLiHV/x/M2z5L+lJoFIAVASG
        P/EQpPpx7is9otfafkmBiMxBAFG5fj8gQzwi/07RKcv0muUBwGpSyEdiPCA6/BvxLYOJuG
        FyNKbBi98WTfXa3IEJcxQanTLi43Ud7VRfZSU0Qur9io0f0YQjJ2ApN+YQiJ3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667380810;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gekW2k4HioQEvgXlGpgUbXsFnaC1UdihEoBTHF91PPQ=;
        b=EUEpKhXzTtazEZ/EfzvuZsU4SEV0H9rWi5kPGRFQUP9aju7ZATf0HSr60CbV/oPlEmhfYI
        pabq2po6YJDSWdBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86: Unconfuse CONFIG_ and X86_FEATURE_ namespaces
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Y1+fL4qQEIGZEEKB@hirez.programming.kicks-ass.net>
References: <Y1+fL4qQEIGZEEKB@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <166738080914.7716.7783697764206767069.tip-bot2@tip-bot2>
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

Commit-ID:     b1f37ef655cf372f96015bf54abdb76a91aff27e
Gitweb:        https://git.kernel.org/tip/b1f37ef655cf372f96015bf54abdb76a91aff27e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 31 Oct 2022 11:10:56 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Nov 2022 13:44:07 +01:00

x86: Unconfuse CONFIG_ and X86_FEATURE_ namespaces

Lukas reported someone fat fingered the CONFIG_ symbol; fix er up.

Fixes: 5d8213864ade ("x86/retbleed: Add SKL return thunk")
Reported-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/Y1+fL4qQEIGZEEKB@hirez.programming.kicks-ass.net
---
 arch/x86/include/asm/nospec-branch.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 82580ad..3ab90f2 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -285,7 +285,7 @@
  */
 .macro UNTRAIN_RET
 #if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_IBPB_ENTRY) || \
-	defined(CONFIG_X86_FEATURE_CALL_DEPTH)
+	defined(CONFIG_CALL_DEPTH_TRACKING)
 	ANNOTATE_UNRET_END
 	ALTERNATIVE_3 "",						\
 		      CALL_ZEN_UNTRAIN_RET, X86_FEATURE_UNRET,		\
@@ -296,7 +296,7 @@
 
 .macro UNTRAIN_RET_FROM_CALL
 #if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_IBPB_ENTRY) || \
-	defined(CONFIG_X86_FEATURE_CALL_DEPTH)
+	defined(CONFIG_CALL_DEPTH_TRACKING)
 	ANNOTATE_UNRET_END
 	ALTERNATIVE_3 "",						\
 		      CALL_ZEN_UNTRAIN_RET, X86_FEATURE_UNRET,		\
