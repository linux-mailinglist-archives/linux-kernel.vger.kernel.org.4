Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBA674CFAB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbjGJIPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjGJIN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:13:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBD7E8;
        Mon, 10 Jul 2023 01:13:56 -0700 (PDT)
Date:   Mon, 10 Jul 2023 08:13:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688976835;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cgIfuLHvepzq9VhUs97s3Fny+OkENVlJAw90urJEAJ0=;
        b=aSrCs42FDprIx3vZ2sSDzCWVsCcVm/tjYkgDYmKMuhlY6hcbpXLdh5kxjx4rAthtoBHDOM
        FMcVqnG2MDeEou29UY411oGxwLQiNAboVPT0sE5FPiCZoj4EL8mZbEtwQgDlSsmVYuVrOw
        YkbJw7mf6/ZzNPzCTuW0RfOVpOymM+6hvMrnwDYhrA+znfXz6ZWgI6UOxHOz1bFPIX95aN
        znBPp8P9Zs/OXl8oNsl8DI7R0v+0UsP77nRN8AE4wuwCsvY6xWLmPFpVimyNRUJ0otw9GG
        TRi4Vz4cqQhs6a6Wvw3QVL81eM6NfakEHVNpocX/EDPotQkN9BW2oBeTuGrxIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688976835;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cgIfuLHvepzq9VhUs97s3Fny+OkENVlJAw90urJEAJ0=;
        b=VgNkuDfDrqiUOTgOrBSNU6I/oh7veNxTmTtlngxDY0i8Tu9gGpTqnNqj4WMdbRDNhDaoML
        NUTeyM3qikc1OaAA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/fineibt: Poison ENDBR at +0
Cc:     "Milburn, Alyssa" <alyssa.milburn@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230615193722.194131053@infradead.org>
References: <20230615193722.194131053@infradead.org>
MIME-Version: 1.0
Message-ID: <168897683510.404.15529620600902653917.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     04505bbbbb15da950ea0239e328a76a3ad2376e0
Gitweb:        https://git.kernel.org/tip/04505bbbbb15da950ea0239e328a76a3ad2376e0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 15 Jun 2023 21:35:48 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 10 Jul 2023 09:52:25 +02:00

x86/fineibt: Poison ENDBR at +0

Alyssa noticed that when building the kernel with CFI_CLANG+IBT and
booting on IBT enabled hardware to obtain FineIBT, the indirect
functions look like:

  __cfi_foo:
	endbr64
	subl	$hash, %r10d
	jz	1f
	ud2
	nop
  1:
  foo:
	endbr64

This is because the compiler generates code for kCFI+IBT. In that case
the caller does the hash check and will jump to +0, so there must be
an ENDBR there. The compiler doesn't know about FineIBT at all; also
it is possible to actually use kCFI+IBT when booting with 'cfi=kcfi'
on IBT enabled hardware.

Having this second ENDBR however makes it possible to elide the CFI
check. Therefore, we should poison this second ENDBR when switching to
FineIBT mode.

Fixes: 931ab63664f0 ("x86/ibt: Implement FineIBT")
Reported-by: "Milburn, Alyssa" <alyssa.milburn@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Link: https://lore.kernel.org/r/20230615193722.194131053@infradead.org
---
 arch/x86/kernel/alternative.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 04b25a2..d77aaab 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1068,6 +1068,17 @@ static int cfi_rewrite_preamble(s32 *start, s32 *end)
 	return 0;
 }
 
+static void cfi_rewrite_endbr(s32 *start, s32 *end)
+{
+	s32 *s;
+
+	for (s = start; s < end; s++) {
+		void *addr = (void *)s + *s;
+
+		poison_endbr(addr+16, false);
+	}
+}
+
 /* .retpoline_sites */
 static int cfi_rand_callers(s32 *start, s32 *end)
 {
@@ -1162,14 +1173,19 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
 		return;
 
 	case CFI_FINEIBT:
+		/* place the FineIBT preamble at func()-16 */
 		ret = cfi_rewrite_preamble(start_cfi, end_cfi);
 		if (ret)
 			goto err;
 
+		/* rewrite the callers to target func()-16 */
 		ret = cfi_rewrite_callers(start_retpoline, end_retpoline);
 		if (ret)
 			goto err;
 
+		/* now that nobody targets func()+0, remove ENDBR there */
+		cfi_rewrite_endbr(start_cfi, end_cfi);
+
 		if (builtin)
 			pr_info("Using FineIBT CFI\n");
 		return;
