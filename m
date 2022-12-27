Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FBC656A0F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 12:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiL0Lvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 06:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiL0Lv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 06:51:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5B92AFD;
        Tue, 27 Dec 2022 03:51:26 -0800 (PST)
Date:   Tue, 27 Dec 2022 11:51:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672141884;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vJgqvjBUVpAl3bu0X2ULzpwem/o6JtVGRnHADAjYrt0=;
        b=uio+AincxcXagNrUiPFNh4CGHo4TEex2KGtEH1gO7Ix0xgbk+eb0VYMqo6GyIKE1IGau/S
        uqcGAvY59m10ImpBdFGq+G77cOhuOC6sc9+2jjQ0OR2X8AAd4NRKmUY8cNivGQdHCF9lRX
        82l0q1ERtbzvQ+hmRsMYNBiUF7KOU1g12ewlmZUsFtmDDfXlgm1ohgzUWaVbnxyyJx/4Y1
        Gdzgt4Z3pSxO93p2++AZ0By8MeGqy8+86aUNNJZnA2AImSGvIJbPEJmRXgCzpf8zh8zjmN
        LJN8V2/uefMUUvxGJy1TEnHpm6/2LRSJt6VXi9MEXUELTeE2w4/6xsT22Ym8LA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672141884;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vJgqvjBUVpAl3bu0X2ULzpwem/o6JtVGRnHADAjYrt0=;
        b=ozKaF1oQb03KX0qMhR4pjk6k/z6x+CDwKeq5S6TwItPAk01hyBiryHK5giF2M2QJygt+DB
        4hruCSTg8PwzvpCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Fix use-after-free in error path
Cc:     syzbot+b8e8c01c8ade4fe6e48f@syzkaller.appspotmail.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chengming Zhou <zhouchengming@bytedance.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Y6B3xEgkbmFUCeni@hirez.programming.kicks-ass.net>
References: <Y6B3xEgkbmFUCeni@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <167214188359.4906.13483243274583965054.tip-bot2@tip-bot2>
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

Commit-ID:     a551844e345ba2a1c533dee4b55cb0efddb1bcda
Gitweb:        https://git.kernel.org/tip/a551844e345ba2a1c533dee4b55cb0efddb1bcda
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 19 Dec 2022 15:40:04 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 27 Dec 2022 12:44:01 +01:00

perf: Fix use-after-free in error path

The syscall error path has a use-after-free; put_pmu_ctx() will
reference ctx, therefore we must ensure ctx is destroyed after pmu_ctx
is.

Fixes: bd2756811766 ("perf: Rewrite core context handling")
Reported-by: syzbot+b8e8c01c8ade4fe6e48f@syzkaller.appspotmail.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
Link: https://lkml.kernel.org/r/Y6B3xEgkbmFUCeni@hirez.programming.kicks-ass.net
---
 kernel/events/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 37c0f04..63d674c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12671,7 +12671,8 @@ SYSCALL_DEFINE5(perf_event_open,
 	return event_fd;
 
 err_context:
-	/* event->pmu_ctx freed by free_event() */
+	put_pmu_ctx(event->pmu_ctx);
+	event->pmu_ctx = NULL; /* _free_event() */
 err_locked:
 	mutex_unlock(&ctx->mutex);
 	perf_unpin_context(ctx);
@@ -12784,6 +12785,7 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr, int cpu,
 
 err_pmu_ctx:
 	put_pmu_ctx(pmu_ctx);
+	event->pmu_ctx = NULL; /* _free_event() */
 err_unlock:
 	mutex_unlock(&ctx->mutex);
 	perf_unpin_context(ctx);
