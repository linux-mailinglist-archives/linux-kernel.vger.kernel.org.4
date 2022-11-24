Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85E063756A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiKXJnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiKXJnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:43:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3DDD22A2;
        Thu, 24 Nov 2022 01:43:05 -0800 (PST)
Date:   Thu, 24 Nov 2022 09:43:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669282984;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3QBRCQ+BHT2z0qtsJ++jNMKm5qLGoOdudDBsHBJOE78=;
        b=NKvUw7oGOkJrmwWdlBtiOmXpOSp0RmdIsmmU8jkx1nFZnI2nI6jTzLWoC5JQTRRhziWIUQ
        y/dAnb/F+ZW56WWLraSkrzlvQAlcc5+0K6R5BJCUA22VhIfxGRIefdwieXTlyMPF2RW5nT
        RYtox3p1H1KzMUY1OpnCxTluA6RgxbqxI0O2bwhfj/HDCbSNyGoSbJZzgA52xpFAE4+VB/
        Vvg2SL5hAbNfb2trAPly6vFseopmnlK8XbkhpdQduWioum2jnxgmMqEkgkAEh7Y+z5LzPK
        0ipcID4gcz0C/vMTgUFbolpSTBVMWggKGVl5DnE4cRm0qrmI5zlGoeRjTHfHhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669282984;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3QBRCQ+BHT2z0qtsJ++jNMKm5qLGoOdudDBsHBJOE78=;
        b=Z1YL6gq1rY5mU0MQ8Jsm3k7gWHs7aSE3zEQArJsflOPTzfa1ycalc3tOw7mP72dElNPn4t
        4Ihq5B5qaKmXOgBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Consider OS filter fail
Cc:     Pengfei Xu <pengfei.xu@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marco Elver <elver@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Y3hDYiXwRnJr8RYG@xpf.sh.intel.com>
References: <Y3hDYiXwRnJr8RYG@xpf.sh.intel.com>
MIME-Version: 1.0
Message-ID: <166928298250.4906.513715216575584648.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     030a976efae83f7b6593afb11a8254d42f9290fe
Gitweb:        https://git.kernel.org/tip/030a976efae83f7b6593afb11a8254d42f9290fe
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 19 Nov 2022 10:45:54 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 24 Nov 2022 10:12:23 +01:00

perf: Consider OS filter fail

Some PMUs (notably the traditional hardware kind) have boundary issues
with the OS filter. Specifically, it is possible for
perf_event_attr::exclude_kernel=1 events to trigger in-kernel due to
SKID or errata.

This can upset the sigtrap logic some and trigger the WARN.

However, if this invalid sample is the first we must not loose the
SIGTRAP, OTOH if it is the second, it must not override the
pending_addr with a (possibly) invalid one.

Fixes: ca6c21327c6a ("perf: Fix missing SIGTRAPs")
Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Marco Elver <elver@google.com>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Link: https://lkml.kernel.org/r/Y3hDYiXwRnJr8RYG@xpf.sh.intel.com
---
 kernel/events/core.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f2bb27e..9d15d2d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9273,6 +9273,19 @@ int perf_event_account_interrupt(struct perf_event *event)
 	return __perf_event_account_interrupt(event, 1);
 }
 
+static inline bool sample_is_allowed(struct perf_event *event, struct pt_regs *regs)
+{
+	/*
+	 * Due to interrupt latency (AKA "skid"), we may enter the
+	 * kernel before taking an overflow, even if the PMU is only
+	 * counting user events.
+	 */
+	if (event->attr.exclude_kernel && !user_mode(regs))
+		return false;
+
+	return true;
+}
+
 /*
  * Generic event overflow handling, sampling.
  */
@@ -9306,6 +9319,13 @@ static int __perf_event_overflow(struct perf_event *event,
 	}
 
 	if (event->attr.sigtrap) {
+		/*
+		 * The desired behaviour of sigtrap vs invalid samples is a bit
+		 * tricky; on the one hand, one should not loose the SIGTRAP if
+		 * it is the first event, on the other hand, we should also not
+		 * trigger the WARN or override the data address.
+		 */
+		bool valid_sample = sample_is_allowed(event, regs);
 		unsigned int pending_id = 1;
 
 		if (regs)
@@ -9313,7 +9333,7 @@ static int __perf_event_overflow(struct perf_event *event,
 		if (!event->pending_sigtrap) {
 			event->pending_sigtrap = pending_id;
 			local_inc(&event->ctx->nr_pending);
-		} else if (event->attr.exclude_kernel) {
+		} else if (event->attr.exclude_kernel && valid_sample) {
 			/*
 			 * Should not be able to return to user space without
 			 * consuming pending_sigtrap; with exceptions:
@@ -9330,7 +9350,7 @@ static int __perf_event_overflow(struct perf_event *event,
 		}
 
 		event->pending_addr = 0;
-		if (data->sample_flags & PERF_SAMPLE_ADDR)
+		if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
 			event->pending_addr = data->addr;
 		irq_work_queue(&event->pending_irq);
 	}
