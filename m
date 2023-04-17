Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849766E4597
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 12:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjDQKtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 06:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjDQKsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:48:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CF549DD;
        Mon, 17 Apr 2023 03:47:55 -0700 (PDT)
Date:   Mon, 17 Apr 2023 10:46:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681728383;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5eA6cpMlDoXM/feBsjdSQtbytvZF3ftPkyQkd1ItisU=;
        b=vnXatkmDsKi49XwemwtPCuOFA92Lmem0/U9//fHK7cWF9RCnLg3mMSKgo9gVNpxy5IjOFq
        4IMfzdk+NXu75tTPG9yOT1z9wpJ6GLqLUC9YzOgPXV8od/laxtOBa2rQGoIEONALuVW7Za
        aBCzT/DixB2Jp7yRHd7VMLxunwDNMoLeTjobu5Ga1P6VNaMYptFhdrGo4U6VdLO+IchuFW
        mNlz1nERhsZhwX9Kr0ITFkLlrZwTq9wSRgQoBcQ+XLZcg0ar22nlM/y+w//XYQtRdduvMw
        nSEP2fTZ0U+SPZP3vccGI6GdB71COLleLkbSjGOI8/JBtio90GZB/dZWFVGb/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681728383;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5eA6cpMlDoXM/feBsjdSQtbytvZF3ftPkyQkd1ItisU=;
        b=utQHqfLhtTxFz7VuYZzcoY3xrqbpC0GoGeR2APIb14dxHfhTnltGqgFSLVz5ShDuYNW/2X
        ejqu5l+RX0LeBfCw==
From:   "tip-bot2 for Yang Jihong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Fix hardlockup failure caused by perf throttle
Cc:     Yang Jihong <yangjihong1@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230227023508.102230-1-yangjihong1@huawei.com>
References: <20230227023508.102230-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Message-ID: <168172838267.404.2145343215039139861.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     15def34e2635ab7e0e96f1bc32e1b69609f14942
Gitweb:        https://git.kernel.org/tip/15def34e2635ab7e0e96f1bc32e1b69609f14942
Author:        Yang Jihong <yangjihong1@huawei.com>
AuthorDate:    Mon, 27 Feb 2023 10:35:08 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Apr 2023 16:08:22 +02:00

perf/core: Fix hardlockup failure caused by perf throttle

commit e050e3f0a71bf ("perf: Fix broken interrupt rate throttling")
introduces a change in throttling threshold judgment. Before this,
compare hwc->interrupts and max_samples_per_tick, then increase
hwc->interrupts by 1, but this commit reverses order of these two
behaviors, causing the semantics of max_samples_per_tick to change.
In literal sense of "max_samples_per_tick", if hwc->interrupts ==
max_samples_per_tick, it should not be throttled, therefore, the judgment
condition should be changed to "hwc->interrupts > max_samples_per_tick".

In fact, this may cause the hardlockup to fail, The minimum value of
max_samples_per_tick may be 1, in this case, the return value of
__perf_event_account_interrupt function is 1.
As a result, nmi_watchdog gets throttled, which would stop PMU (Use x86
architecture as an example, see x86_pmu_handle_irq).

Fixes: e050e3f0a71b ("perf: Fix broken interrupt rate throttling")
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230227023508.102230-1-yangjihong1@huawei.com
---
 kernel/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index fb3e436..82b95b8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9433,8 +9433,8 @@ __perf_event_account_interrupt(struct perf_event *event, int throttle)
 		hwc->interrupts = 1;
 	} else {
 		hwc->interrupts++;
-		if (unlikely(throttle
-			     && hwc->interrupts >= max_samples_per_tick)) {
+		if (unlikely(throttle &&
+			     hwc->interrupts > max_samples_per_tick)) {
 			__this_cpu_inc(perf_throttled_count);
 			tick_dep_set_cpu(smp_processor_id(), TICK_DEP_BIT_PERF_EVENTS);
 			hwc->interrupts = MAX_INTERRUPTS;
