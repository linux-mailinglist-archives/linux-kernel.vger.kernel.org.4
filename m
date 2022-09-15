Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023B25B9CC1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 16:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiIOOQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 10:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiIOOQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:16:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7669F87698;
        Thu, 15 Sep 2022 07:16:42 -0700 (PDT)
Date:   Thu, 15 Sep 2022 14:16:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663251400;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jhzu1+v7uFVsKXwmhR6tjPzO3KtJ3NcI1K7SlbCVxsA=;
        b=LV539zP4+IjA0y/AHME63ScYMfhQ0jpF02FFeNyCQuh9HIccThLjAHjuz/Ck7KwqitKjwK
        T+2JPtgc3/UNmnkc3JCGXzQ1Aig0wkjEypa6UKUuQzbU75g18F9hqekhypdgvy3TGqD7qC
        Dfdki14LAY75EvoVlJaFIAaPTViX9UpaeZoyeOIZPLwplC8T63jzUIyNStpsp4uX05P45O
        rotcvWa7jVRfsSr0BkUTaH8dh4Hv/CCyak8J3Qih544aZUMyzhiym8amZeELQX/bVFvM9e
        Y8y7dOoOMsbTYNG9f7uiiaLwKsbZpnrJC+fKWK93CwfTjZ/K0mIDeD+wFVh14Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663251400;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jhzu1+v7uFVsKXwmhR6tjPzO3KtJ3NcI1K7SlbCVxsA=;
        b=KO7XcvONVteC9DLws+HzN2mRr7Fq6JULRFse/RfrfVvHVjw8Xn9JsIho4rxTjFovBHBGga
        +KIqt4DnOmLmwvBw==
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Use sample_flags for callchain
Cc:     Namhyung Kim <namhyung@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220908214104.3851807-1-namhyung@kernel.org>
References: <20220908214104.3851807-1-namhyung@kernel.org>
MIME-Version: 1.0
Message-ID: <166325139947.401.10004497239790476169.tip-bot2@tip-bot2>
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

Commit-ID:     3749d33e510c3dc695b3a5886b706310890d7ebd
Gitweb:        https://git.kernel.org/tip/3749d33e510c3dc695b3a5886b706310890d7ebd
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Thu, 08 Sep 2022 14:41:02 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 13 Sep 2022 15:03:22 +02:00

perf: Use sample_flags for callchain

So that it can call perf_callchain() only if needed.  Historically it used
__PERF_SAMPLE_CALLCHAIN_EARLY but we can do that with sample_flags in the
struct perf_sample_data.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220908214104.3851807-1-namhyung@kernel.org
---
 arch/x86/events/amd/ibs.c  | 4 +++-
 arch/x86/events/intel/ds.c | 8 ++++++--
 kernel/events/core.c       | 2 +-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index c251bc4..dab0941 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -798,8 +798,10 @@ fail:
 	 * recorded as part of interrupt regs. Thus we need to use rip from
 	 * interrupt regs while unwinding call stack.
 	 */
-	if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
+	if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) {
 		data.callchain = perf_callchain(event, iregs);
+		data.sample_flags |= PERF_SAMPLE_CALLCHAIN;
+	}
 
 	throttle = perf_event_overflow(event, &data, &regs);
 out:
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index a5275c2..4ba6ab6 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1546,8 +1546,10 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 	 * previous PMI context or an (I)RET happened between the record and
 	 * PMI.
 	 */
-	if (sample_type & PERF_SAMPLE_CALLCHAIN)
+	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
 		data->callchain = perf_callchain(event, iregs);
+		data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
+	}
 
 	/*
 	 * We use the interrupt regs as a base because the PEBS record does not
@@ -1719,8 +1721,10 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 	 * previous PMI context or an (I)RET happened between the record and
 	 * PMI.
 	 */
-	if (sample_type & PERF_SAMPLE_CALLCHAIN)
+	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
 		data->callchain = perf_callchain(event, iregs);
+		data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
+	}
 
 	*regs = *iregs;
 	/* The ip in basic is EventingIP */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3e90e45..c98ecf3 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7320,7 +7320,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
 		int size = 1;
 
-		if (!(sample_type & __PERF_SAMPLE_CALLCHAIN_EARLY))
+		if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN)
 			data->callchain = perf_callchain(event, regs);
 
 		size += data->callchain->nr;
