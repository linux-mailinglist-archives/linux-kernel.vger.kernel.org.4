Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDED35F07A3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiI3Jbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiI3JbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:31:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2593C9029;
        Fri, 30 Sep 2022 02:31:04 -0700 (PDT)
Date:   Fri, 30 Sep 2022 09:31:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664530261;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V0RBOS3LPNPYjkJcDgSN1iH8TSNOzEVheKPACTKqzPk=;
        b=RID6fCDhtR7DRXiK91CzpWv0VO1/f+GqoDA0RWI6N6Gurl61/lT3kphW7cdjguF78gBH1P
        YLWhsFFwSU3EK3tGEL7NIa5OgYRNtO6TGHP4OzBsL8xYClo27VboNWeTlomjV+0uCxzCYW
        gYxI7lgSbrOjyKZbDTRUQW0qE6YPgZ8MgKMPzPAiHm1lrk0D0SUyHnGi4h1tmNxN9bjTYu
        fGVMXVdI6QUS0ssxq6KxqwwWn6LlaFrCv9QkL8RB8oE9/yZKZNadP1o4quFOpJW+O/RCsz
        QSxSdcDOBIxybnOnXgLVYtgaMMQcZR6D9LqsLKpLBv6kSDCh6kscKB2+JbPJLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664530261;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V0RBOS3LPNPYjkJcDgSN1iH8TSNOzEVheKPACTKqzPk=;
        b=FKYmAf4b+BBKzhtHEbuo/uuhDIXaZ6Z9jo/q+RWpCy6zr55ChqsHDuZmEKPGFCWfvMs3b+
        7Tuj7JL70qqCGzDw==
From:   "tip-bot2 for Stephane Eranian" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd/lbr: Adjust LBR regardless of filtering
Cc:     Stephane Eranian <eranian@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sandipan Das <sandipan.das@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220928184043.408364-3-eranian@google.com>
References: <20220928184043.408364-3-eranian@google.com>
MIME-Version: 1.0
Message-ID: <166453026009.401.14008407416230539420.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3f9a1b3591003b122a6ea2d69f89a0fd96ec58b9
Gitweb:        https://git.kernel.org/tip/3f9a1b3591003b122a6ea2d69f89a0fd96ec58b9
Author:        Stephane Eranian <eranian@google.com>
AuthorDate:    Wed, 28 Sep 2022 11:40:43 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 29 Sep 2022 12:20:57 +02:00

perf/x86/amd/lbr: Adjust LBR regardless of filtering

In case of fused compare and taken branch instructions, the AMD LBR points to
the compare instruction instead of the branch. Users of LBR usually expects
the from address to point to a branch instruction. The kernel has code to
adjust the from address via get_branch_type_fused(). However this correction
is only applied when a branch filter is applied. That means that if no
filter is present, the quality of the data is lower.

Fix the problem by applying the adjustment regardless of the filter setting,
bringing the AMD LBR to the same level as other LBR implementations.

Fixes: 245268c19f70 ("perf/x86/amd/lbr: Use fusion-aware branch classifier")
Signed-off-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Sandipan Das <sandipan.das@amd.com>
Link: https://lore.kernel.org/r/20220928184043.408364-3-eranian@google.com
---
 arch/x86/events/amd/lbr.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 2e1c157..38a7521 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -99,12 +99,13 @@ static void amd_pmu_lbr_filter(void)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	int br_sel = cpuc->br_sel, offset, type, i, j;
 	bool compress = false;
+	bool fused_only = false;
 	u64 from, to;
 
 	/* If sampling all branches, there is nothing to filter */
 	if (((br_sel & X86_BR_ALL) == X86_BR_ALL) &&
 	    ((br_sel & X86_BR_TYPE_SAVE) != X86_BR_TYPE_SAVE))
-		return;
+		fused_only = true;
 
 	for (i = 0; i < cpuc->lbr_stack.nr; i++) {
 		from = cpuc->lbr_entries[i].from;
@@ -116,8 +117,11 @@ static void amd_pmu_lbr_filter(void)
 		 * fusion where it points to an instruction preceding the
 		 * actual branch
 		 */
-		if (offset)
+		if (offset) {
 			cpuc->lbr_entries[i].from += offset;
+			if (fused_only)
+				continue;
+		}
 
 		/* If type does not correspond, then discard */
 		if (type == X86_BR_NONE || (br_sel & type) != type) {
