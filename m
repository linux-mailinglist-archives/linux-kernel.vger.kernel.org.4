Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F875F534F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 13:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiJEL0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 07:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiJEL0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 07:26:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24045E308;
        Wed,  5 Oct 2022 04:26:44 -0700 (PDT)
Date:   Wed, 05 Oct 2022 11:26:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664969203;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WomdJPUvbKBPjysQiIAIqcIpo2IO19V9fupvEU1iA5A=;
        b=kOjx2w7aKEOaW7HjrZhhFRny5Mj+zdt6xlqjiWgSgSy1ujk2TsyjdpZjmdkLlOg+WViD/H
        owGD3fpjqb/PUPOOEloNfD7vHZ8LiPHG1AmS4Db1DRIa9j0EOULlmnDTbJ+CEWGbqRgdUw
        ChP5TvDyJ0+KwlXXDJY9Zhb99B/FUhTReXvcteYaa7WsNZZa8mWb8OHva9asHbDJORo22c
        FZmbgeV4Swq7nnd7Hxr9WeVkMcHMuw6F8nsE/totP3UGUhUaQiFSGd8m0XRMO3L/kOCTz9
        6sdh6OZN+0IG1lv396dF+JkHM78PTdEj12zs4ZaHmYX68R/Md2UiFuqOpA2pEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664969203;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WomdJPUvbKBPjysQiIAIqcIpo2IO19V9fupvEU1iA5A=;
        b=FxrvUWCOzxFjrspfHUPTcNqwDi/5bdUZ8mxDme7V1BVA2+Ox3nXG9Q06hmGGs11VGwNrzh
        S6qVtJ9LPcbQZqBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Fix pmu_filter_match()
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <7eFVcnNy@FVFF77S0Q05N>
References: <7eFVcnNy@FVFF77S0Q05N>
MIME-Version: 1.0
Message-ID: <166496920167.401.7879085320473775333.tip-bot2@tip-bot2>
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

Commit-ID:     7be51cc1c68dfa180ef84e71bcb4204237bb5620
Gitweb:        https://git.kernel.org/tip/7be51cc1c68dfa180ef84e71bcb4204237bb5620
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 04 Oct 2022 11:03:47 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 04 Oct 2022 13:32:09 +02:00

perf: Fix pmu_filter_match()

Mark reported that the new for_each_sibling_event() assertion triggers
in pmu_filter_match() -- which isn't always called with IRQs disabled
or ctx->mutex held.

Fixes: f3c0eba28704 ("perf: Add a few assertions")
Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/YvvJq2f/7eFVcnNy@FVFF77S0Q05N
---
 kernel/events/core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 49bc3b5..b981b87 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2226,16 +2226,22 @@ static inline int __pmu_filter_match(struct perf_event *event)
 static inline int pmu_filter_match(struct perf_event *event)
 {
 	struct perf_event *sibling;
+	unsigned long flags;
+	int ret = 1;
 
 	if (!__pmu_filter_match(event))
 		return 0;
 
+	local_irq_save(flags);
 	for_each_sibling_event(sibling, event) {
-		if (!__pmu_filter_match(sibling))
-			return 0;
+		if (!__pmu_filter_match(sibling)) {
+			ret = 0;
+			break;
+		}
 	}
+	local_irq_restore(flags);
 
-	return 1;
+	return ret;
 }
 
 static inline int
