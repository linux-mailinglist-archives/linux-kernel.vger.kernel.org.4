Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBECA62B629
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbiKPJOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbiKPJOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:14:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7CE5F41;
        Wed, 16 Nov 2022 01:14:32 -0800 (PST)
Date:   Wed, 16 Nov 2022 09:14:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668590070;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f5LJJJLKCH1DAYq6JhwQ5TabipDFex5oP5iOp++77Wg=;
        b=LOq1ykHU2aK9dW4KGfxhSNbmg67N+WuNLvKqZC87sqMUTMjP3twQzKrLQGQBeAV2P7qQ6L
        qL9oErMNBYZ7CnyRTojR0scFjhSdtw0Pp9ajQM/vY3BvvKZ8DRq1SQahKFHO+FmW33LTce
        +ukCPZL9IU3XSJ7aIFq288w7tfcJUWQy+RGUIV8Vhl2AJL6VonwI3F6gsoB1JBm5MBLLOy
        C/tB3OsksvHTttFbE8CiyvyvNs41tPa4CoYOHZZa+cZTmTH6DHBOymCBb6FWV4YJQi98ue
        w1QbILb/L5k/XRjRt3kohfQ5i6zHV1hp3x+21ZWMOrO966PZd6UToVZV6H7R6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668590070;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f5LJJJLKCH1DAYq6JhwQ5TabipDFex5oP5iOp++77Wg=;
        b=FebQKjwMFME4ZFxdepCvPeRbtYQuKBfj3wjj918hQnCZQO4vvm+T+6l0FKGHi2v8aywsTS
        qoxHmmz2AMGryYDg==
From:   "tip-bot2 for Rafael Mendonca" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Remove unused variable 'cpu_type'
Cc:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221028203006.976831-1-rafaelmendsr@gmail.com>
References: <20221028203006.976831-1-rafaelmendsr@gmail.com>
MIME-Version: 1.0
Message-ID: <166859006941.4906.6854286305825561239.tip-bot2@tip-bot2>
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

Commit-ID:     8e356858be2989355aafcc96af541fedf9fb486f
Gitweb:        https://git.kernel.org/tip/8e356858be2989355aafcc96af541fedf9fb486f
Author:        Rafael Mendonca <rafaelmendsr@gmail.com>
AuthorDate:    Fri, 28 Oct 2022 17:30:05 -03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Nov 2022 22:30:11 +01:00

perf/x86: Remove unused variable 'cpu_type'

Since the removal of function x86_pmu_update_cpu_context() by commit
983bd8543b5a ("perf: Rewrite core context handling"), there is no need to
query the type of the hybrid CPU inside function init_hw_perf_events().

Fixes: 983bd8543b5a ("perf: Rewrite core context handling")
Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221028203006.976831-1-rafaelmendsr@gmail.com
---
 arch/x86/events/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 337a99a..85a63a4 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2161,13 +2161,9 @@ static int __init init_hw_perf_events(void)
 		if (err)
 			goto out2;
 	} else {
-		u8 cpu_type = get_this_hybrid_cpu_type();
 		struct x86_hybrid_pmu *hybrid_pmu;
 		int i, j;
 
-		if (!cpu_type && x86_pmu.get_hybrid_cpu_type)
-			cpu_type = x86_pmu.get_hybrid_cpu_type();
-
 		for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
 			hybrid_pmu = &x86_pmu.hybrid_pmu[i];
 
