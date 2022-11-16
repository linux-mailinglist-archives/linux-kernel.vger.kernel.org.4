Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95A162B627
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbiKPJOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiKPJOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:14:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0AE62C1;
        Wed, 16 Nov 2022 01:14:29 -0800 (PST)
Date:   Wed, 16 Nov 2022 09:14:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668590068;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ntXmTzcMVrQc++9yhCFjiIC9jVlTb71PBDC8seZSSSU=;
        b=zIEwQAiuscQ6JqTADM0FtvuJjHb+dJznnXpqivThgP05jflGCzFDBNZEwuQWmraB6tR7MI
        7z9cg0+NUCwkzR7C+bZtggiJ4QebTUYdFi5GdgobWfe4eOR0sY/NGyIJ4BYM/1KtGiDVXY
        PyA8bG2bFdmqpymMW00132iAKtKmb8Ies6216bWZNo2io+SgJ2zPxKmO7NiNTa5KHB+m0J
        DcUodSRYbEgmxEH67BYmK9DU0s2Uh0kemlGRSPI61KgCVL4QTm6ap8gzaHC9B4ppw85i7R
        h2fnWi+0RGE4m8YVOLWZG9BFfqUagZEgrIItjsGthLI28l7/jYOIDAFr9b71DQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668590068;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ntXmTzcMVrQc++9yhCFjiIC9jVlTb71PBDC8seZSSSU=;
        b=ePhxbwo+I+MjhTdlse1fz4nuGKZtn8ZrUCV3o2F1dsZSQOSuSshh11EktvKe5aSoO1KMQL
        s5en9am3v3phQDAw==
From:   "tip-bot2 for Gaosheng Cui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Fix IS_ERR() vs NULL check in inherit_event()
Cc:     Gaosheng Cui <cuigaosheng1@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221114091833.1492575-1-cuigaosheng1@huawei.com>
References: <20221114091833.1492575-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Message-ID: <166859006717.4906.1082358264373442577.tip-bot2@tip-bot2>
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

Commit-ID:     c55bfbb3ebce4e0956972f02b82673950ad1a2d2
Gitweb:        https://git.kernel.org/tip/c55bfbb3ebce4e0956972f02b82673950ad1a2d2
Author:        Gaosheng Cui <cuigaosheng1@huawei.com>
AuthorDate:    Mon, 14 Nov 2022 17:18:33 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Nov 2022 22:30:11 +01:00

perf: Fix IS_ERR() vs NULL check in inherit_event()

The find_get_pmu_context() returns an ERR_PTR() on failure, we should use
IS_ERR() to check the return value.

Fixes: bd2756811766 ("perf: Rewrite core context handling")
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221114091833.1492575-1-cuigaosheng1@huawei.com
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index baa2997..baa6edf 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13171,7 +13171,7 @@ inherit_event(struct perf_event *parent_event,
 		return child_event;
 
 	pmu_ctx = find_get_pmu_context(child_event->pmu, child_ctx, child_event);
-	if (!pmu_ctx) {
+	if (IS_ERR(pmu_ctx)) {
 		free_event(child_event);
 		return NULL;
 	}
