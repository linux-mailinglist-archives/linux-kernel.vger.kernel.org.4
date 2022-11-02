Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A6E6170A1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 23:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbiKBWXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 18:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbiKBWXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 18:23:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED7A5FDD;
        Wed,  2 Nov 2022 15:23:11 -0700 (PDT)
Date:   Wed, 02 Nov 2022 22:23:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667427790;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1+R7xQ8RtTS9a9/douIT3hpjJzZ5GXp4iqAZ9Ds+ke4=;
        b=0BDe881xgYQS58dZsjPGWychrR8INfWa9kJ+vkzO9ROwGalky1tNoG4CrOtn4y717/138g
        4AX7he95JBXJ02Buhg7tJdLgzFJRH0XF/2ztbZMvC1jFLwfqwlBPoeoJ6yZtUbbFaERTzR
        wmhbY80mzI6nwN7yAPMdCinK2VqZY533nS9XybN/824S7uQjlaXCCdCGP0mxZPWiyTaWGY
        Lim0boFwUfIkbmrMYODUahjZpWUAPvDoL4EFOJ86SS6/K6E4s7sGd1WNY4TNzv7Jnj0Gn5
        3nJqWye0uzXHkZ/BPYdsFaOn078S2H//H9Mo2zELKOCWo0ja5JNNoHtBiWFlhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667427790;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1+R7xQ8RtTS9a9/douIT3hpjJzZ5GXp4iqAZ9Ds+ke4=;
        b=3hYmvUt6DWuVgi0kMkvYBfgjlWDBliNEq49+8EuClxLLweGqPRTQW2g9c0TxPaCAKzDgUl
        VET7D3hlzMrG7kBw==
From:   "tip-bot2 for David Gow" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/hw_breakpoint: test: Skip the test if
 dependencies unmet
Cc:     David Gow <davidgow@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Latypov <dlatypov@google.com>,
        Marco Elver <elver@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221026141040.1609203-1-davidgow@google.com>
References: <20221026141040.1609203-1-davidgow@google.com>
MIME-Version: 1.0
Message-ID: <166742778877.6127.16460958693964479938.tip-bot2@tip-bot2>
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

Commit-ID:     4b18cb3f74dcfc183c2434e17bfce09ce6302e37
Gitweb:        https://git.kernel.org/tip/4b18cb3f74dcfc183c2434e17bfce09ce6302e37
Author:        David Gow <davidgow@google.com>
AuthorDate:    Wed, 26 Oct 2022 22:10:40 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 02 Nov 2022 12:22:05 +01:00

perf/hw_breakpoint: test: Skip the test if dependencies unmet

Running the test currently fails on non-SMP systems, despite being
enabled by default. This means that running the test with:

 ./tools/testing/kunit/kunit.py run --arch x86_64 hw_breakpoint

results in every hw_breakpoint test failing with:

 # test_one_cpu: failed to initialize: -22
 not ok 1 - test_one_cpu

Instead, use kunit_skip(), which will mark the test as skipped, and give
a more comprehensible message:

 ok 1 - test_one_cpu # SKIP not enough cpus

This makes it more obvious that the test is not suited to the test
environment, and so wasn't run, rather than having run and failed.

Signed-off-by: David Gow <davidgow@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Daniel Latypov <dlatypov@google.com>
Acked-by: Marco Elver <elver@google.com>
Link: https://lore.kernel.org/r/20221026141040.1609203-1-davidgow@google.com
---
 kernel/events/hw_breakpoint_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/hw_breakpoint_test.c b/kernel/events/hw_breakpoint_test.c
index 5ced822..c57610f 100644
--- a/kernel/events/hw_breakpoint_test.c
+++ b/kernel/events/hw_breakpoint_test.c
@@ -295,11 +295,11 @@ static int test_init(struct kunit *test)
 {
 	/* Most test cases want 2 distinct CPUs. */
 	if (num_online_cpus() < 2)
-		return -EINVAL;
+		kunit_skip(test, "not enough cpus");
 
 	/* Want the system to not use breakpoints elsewhere. */
 	if (hw_breakpoint_is_used())
-		return -EBUSY;
+		kunit_skip(test, "hw breakpoint already in use");
 
 	return 0;
 }
