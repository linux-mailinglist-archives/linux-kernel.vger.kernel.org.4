Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D296BBE68
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 22:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbjCOVDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 17:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjCOVDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:03:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270BAA2190;
        Wed, 15 Mar 2023 14:02:38 -0700 (PDT)
Date:   Wed, 15 Mar 2023 21:01:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678914086;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=71uf0twxIMoqwqtLUEmZzM355KQciyEwRI2nRq0btRY=;
        b=ukGxmmB3IGjZy8KmJzRkubz5kfADH3JWY6KiuNcQcsWjadX8DtETwPFu7AYYQoPS98pVXq
        Virhik4YOzav2DyAxLd7EtyYqQEkEOpDsP+L+pVU4Mrb/vIhIVNox21erYp8lrTd9IiabE
        IqtMWJ4pySKqj53nohOZAzsSAzr7ZMH+vm1AJC3hSbC32WpHtVU1MJQqnTLEFHdtYiUGsq
        f24Gi2llLRx8G8qhlJjsWX7hcUvu9UOJ8dzwuKVtQE8nckmaYv3HuvaCl2sqgBpEX2/mrn
        Q2Uexqsi4I+nSjd9+z2H9hfnUIicsBNkmAoXTjznl961sY6/dk6+DUHRS9gfCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678914086;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=71uf0twxIMoqwqtLUEmZzM355KQciyEwRI2nRq0btRY=;
        b=MZO3K2GlygWrxqhuyTXyniVXw6OCQcNqAupgOq6CfZEy/XppEwq/68FYJxYRDTNV8FSsBu
        DqYWlcsICgGShkDw==
From:   "tip-bot2 for Song Liu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: fix perf_event_context->time
Cc:     Song Liu <song@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230313171608.298734-1-song@kernel.org>
References: <20230313171608.298734-1-song@kernel.org>
MIME-Version: 1.0
Message-ID: <167891408537.5837.6805754856506702274.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     baf1b12a67f5b24f395baca03e442ce27cab0c18
Gitweb:        https://git.kernel.org/tip/baf1b12a67f5b24f395baca03e442ce27cab0c18
Author:        Song Liu <song@kernel.org>
AuthorDate:    Mon, 13 Mar 2023 10:16:08 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Mar 2023 21:49:46 +01:00

perf: fix perf_event_context->time

Time readers rely on perf_event_context->[time|timestamp|timeoffset] to get
accurate time_enabled and time_running for an event. The difference between
ctx->timestamp and ctx->time is the among of time when the context is not
enabled. __update_context_time(ctx, false) is used to increase timestamp,
but not time. Therefore, it should only be called in ctx_sched_in() when
EVENT_TIME was not enabled.

Fixes: 09f5e7dc7ad7 ("perf: Fix perf_event_read_local() time")
Signed-off-by: Song Liu <song@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/r/20230313171608.298734-1-song@kernel.org
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 296617e..52b4aa0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3872,7 +3872,7 @@ ctx_sched_in(struct perf_event_context *ctx, enum event_type_t event_type)
 	if (likely(!ctx->nr_events))
 		return;
 
-	if (is_active ^ EVENT_TIME) {
+	if (!(is_active & EVENT_TIME)) {
 		/* start ctx time */
 		__update_context_time(ctx, false);
 		perf_cgroup_set_timestamp(cpuctx);
