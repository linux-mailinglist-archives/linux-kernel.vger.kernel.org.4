Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7FC6FB229
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbjEHOEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbjEHOEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:04:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1C836562;
        Mon,  8 May 2023 07:04:37 -0700 (PDT)
Date:   Mon, 08 May 2023 14:04:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683554675;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=31tKUF0XOqo9VkRjDJPUdomXdb9oKFooHh4XcuaTp98=;
        b=gYmjyMigisB6tExIqYnIkmqzmnR9xy23FHymUGUXsWegGW0I0ci94YBMFL4BwE56ZFex88
        NSJ7NBeXvEbZFVtc0wTM8zeqLNWDibu/TSNyvTKPPMCKy+RV+jodBecKaLOLtUa39tMuDD
        1A4U2i9Sky0IZ0Le964CrhqVoH4dSjjCRYaqr22NU8obOy6L869mCfWjBX5eqs4suCh2jH
        wA/gw44Z8rDE5i1b9Izb70FTSMt02A7/vJONj0372KxJrxAh86/W3pmv8ZgZL0284OQUsZ
        r6mCZMrLLSUlxJd+4tymRPJ92Ct+ItvKoNPaO8kVprglA98ZO06uEqCKqor9BQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683554675;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=31tKUF0XOqo9VkRjDJPUdomXdb9oKFooHh4XcuaTp98=;
        b=W/CfOTMjvtQHE6JeSd3BBpvPynHLBAMrJk3mTDtP/Hx0foC62dehi3xBUE83w3ElYZHz3e
        W6MOHwiE68AEfJAg==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] tools/x86/kcpuid: Dump the correct CPUID function in error
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230426094107.27348-1-bp@alien8.de>
References: <20230426094107.27348-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <168355467536.404.8937977023899677332.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     0150d1bfbedf29d7473ae458815781488f62d11d
Gitweb:        https://git.kernel.org/tip/0150d1bfbedf29d7473ae458815781488f62d11d
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 26 Apr 2023 11:41:07 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 08 May 2023 15:50:27 +02:00

tools/x86/kcpuid: Dump the correct CPUID function in error

The tool uses the 16 least significant bits of the CPUID leaf as an
index into its array of CPUID function field descriptions.

However, when that index is non-existent, it uses the same, truncated
index to report it, which is wrong:

$ kcpuid -l 0x80000034
  ERR: invalid input index (0x34)

Use the original index number in the error message.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230426094107.27348-1-bp@alien8.de
---
 tools/arch/x86/kcpuid/kcpuid.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 416f5b3..24b7d01 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -517,15 +517,16 @@ static void show_range(struct cpuid_range *range)
 static inline struct cpuid_func *index_to_func(u32 index)
 {
 	struct cpuid_range *range;
+	u32 func_idx;
 
 	range = (index & 0x80000000) ? leafs_ext : leafs_basic;
-	index &= 0x7FFFFFFF;
+	func_idx = index & 0xffff;
 
-	if (((index & 0xFFFF) + 1) > (u32)range->nr) {
+	if ((func_idx + 1) > (u32)range->nr) {
 		printf("ERR: invalid input index (0x%x)\n", index);
 		return NULL;
 	}
-	return &range->funcs[index];
+	return &range->funcs[func_idx];
 }
 
 static void show_info(void)
