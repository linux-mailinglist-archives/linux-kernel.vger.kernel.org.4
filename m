Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53C6693005
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 11:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjBKKbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 05:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjBKKa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 05:30:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0092196B;
        Sat, 11 Feb 2023 02:30:57 -0800 (PST)
Date:   Sat, 11 Feb 2023 10:30:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676111456;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hXcZZ5hsC9y8UQ1Anqw7othkmDAXfhQSpnq9+McYXIw=;
        b=JQ/6IHRThN4JNSuB8J2lfHOqDeB7XBejj//x7+n9DwCFN7DNeSafIquU70NKC//Rn2T0E+
        6Z4po34/kyxEPgrejUcDbShb3Dswp9bWwlGfNd8+IxfcQ7RDvXFYIQKble54OGRsAB9ZFM
        yTLI2pM6yqNmrgrWpqZHsUsAwhsvnLMeUnnsh75pQIs30dX3aVzKKKhSNhBFrTFcHho6DX
        lb0HGilthfcbXNzWGkCTTMUuNj1nttZc96/BBpjIoW4PrrrFOB3I/B7LlNoOPRMntuo/SM
        l8HQmouRJB8imrkz4gPUyRMBldZTVHws/+u44wr5OWfEmhUAPcG4dcLlE8jKWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676111456;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hXcZZ5hsC9y8UQ1Anqw7othkmDAXfhQSpnq9+McYXIw=;
        b=Kn2kBZy6spTXzjPGY2MHcM4cir5iZgBKLwDp2J96mfzxMtvjnvpqwLMKSt+CufaX6BLwuX
        1VHM2BPBSttsdcDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] objtool: mem*() are not uaccess safe
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230126182302.GA687063@paulmck-ThinkPad-P17-Gen-1>
References: <20230126182302.GA687063@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Message-ID: <167611145523.4906.11994571404061961204.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     443ed4c302fff6a26af980300463343a7adc9ee8
Gitweb:        https://git.kernel.org/tip/443ed4c302fff6a26af980300463343a7adc9ee8
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 30 Jan 2023 15:21:02 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 11 Feb 2023 11:18:08 +01:00

objtool: mem*() are not uaccess safe

For mysterious raisins I listed the new __asan_mem*() functions as
being uaccess safe, this is giving objtool fails on KASAN builds
because these functions call out to the actual __mem*() functions
which are not marked uaccess safe.

Removing it doesn't make the robots unhappy.

Fixes: 69d4c0d32186 ("entry, kasan, x86: Disallow overriding mem*() functions")
Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
Bisected-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230126182302.GA687063@paulmck-ThinkPad-P17-Gen-1
---
 tools/objtool/check.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 10b5bb4..b118f58 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1083,9 +1083,6 @@ static const char *uaccess_safe_builtin[] = {
 	"__asan_store16_noabort",
 	"__kasan_check_read",
 	"__kasan_check_write",
-	"__asan_memset",
-	"__asan_memmove",
-	"__asan_memcpy",
 	/* KASAN in-line */
 	"__asan_report_load_n_noabort",
 	"__asan_report_load1_noabort",
