Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D00D74CF9B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbjGJINy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbjGJINZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:13:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E36CE7;
        Mon, 10 Jul 2023 01:13:24 -0700 (PDT)
Date:   Mon, 10 Jul 2023 08:13:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688976802;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QmxEJkHfTKInkH+veC+TMsvNnEkLPnoWkAzHDAyTGxE=;
        b=46UHh6y3XrPRrKJ3SjGN0YUZY/84V1itqZ5EnhjPTfpHvW70onGukErJ7ewIKM5+w+a2WO
        z5YN1tKYAT7qWqoehvLfaZxAyQMrualGzO8cUK3QLkN23TMXFrSUFtc+OT8Cu1ocMg1EsR
        3nHn7w3EvLG7c6yB+5L/0VBlwFo5LK4/9YDCRgkHCfXmpLDmozJ7JuwZpWoVb2p/SD6GBI
        m7BoqpGv1cMiwjFmdK8LUv1YZhqMXV3xFAHUhfwJnkcipaKevJoE9Yym6pLbml8O62UZNl
        DmmAF/x0NKHRj4wjKGvYRH6UnAVajYiNEesR8i5SKig4Uz0IyWH9rJtffzyy6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688976802;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QmxEJkHfTKInkH+veC+TMsvNnEkLPnoWkAzHDAyTGxE=;
        b=0elY/nPtYviK9iAC+zRpm07pnu1+pEsxn8qE+5ZGzxFuFPjHqmPIeC9RgdbFntCMETSL+/
        JJJMQfO4iuaX+RBg==
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86: Fix lockdep warning in
 for_each_sibling_event() on SPR
Cc:     Greg Thelen <gthelen@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        stable@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230704181516.3293665-1-namhyung@kernel.org>
References: <20230704181516.3293665-1-namhyung@kernel.org>
MIME-Version: 1.0
Message-ID: <168897680188.404.3122821140126581927.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     27c68c216ee1f1b086e789a64486e6511e380b8a
Gitweb:        https://git.kernel.org/tip/27c68c216ee1f1b086e789a64486e6511e380b8a
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Tue, 04 Jul 2023 11:15:15 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 10 Jul 2023 09:52:20 +02:00

perf/x86: Fix lockdep warning in for_each_sibling_event() on SPR

On SPR, the load latency event needs an auxiliary event in the same
group to work properly.  There's a check in intel_pmu_hw_config()
for this to iterate sibling events and find a mem-loads-aux event.

The for_each_sibling_event() has a lockdep assert to make sure if it
disabled hardirq or hold leader->ctx->mutex.  This works well if the
given event has a separate leader event since perf_try_init_event()
grabs the leader->ctx->mutex to protect the sibling list.  But it can
cause a problem when the event itself is a leader since the event is
not initialized yet and there's no ctx for the event.

Actually I got a lockdep warning when I run the below command on SPR,
but I guess it could be a NULL pointer dereference.

  $ perf record -d -e cpu/mem-loads/uP true

The code path to the warning is:

  sys_perf_event_open()
    perf_event_alloc()
      perf_init_event()
        perf_try_init_event()
          x86_pmu_event_init()
            hsw_hw_config()
              intel_pmu_hw_config()
                for_each_sibling_event()
                  lockdep_assert_event_ctx()

We don't need for_each_sibling_event() when it's a standalone event.
Let's return the error code directly.

Fixes: f3c0eba28704 ("perf: Add a few assertions")
Reported-by: Greg Thelen <gthelen@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20230704181516.3293665-1-namhyung@kernel.org
---
 arch/x86/events/intel/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index a149faf..2a284ba 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3993,6 +3993,13 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		struct perf_event *leader = event->group_leader;
 		struct perf_event *sibling = NULL;
 
+		/*
+		 * When this memload event is also the first event (no group
+		 * exists yet), then there is no aux event before it.
+		 */
+		if (leader == event)
+			return -ENODATA;
+
 		if (!is_mem_loads_aux_event(leader)) {
 			for_each_sibling_event(sibling, leader) {
 				if (is_mem_loads_aux_event(sibling))
