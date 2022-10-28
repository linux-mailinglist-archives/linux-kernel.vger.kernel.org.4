Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D70A610A7F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJ1Gm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiJ1GmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:42:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5822B58B7A;
        Thu, 27 Oct 2022 23:42:00 -0700 (PDT)
Date:   Fri, 28 Oct 2022 06:41:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666939318;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C39ifa/sE4bg8/kwimkxG6gMln4PD6f9CsViDbJiJkM=;
        b=Q1qeib1exL1x3G3McBqGvEJK8ChQCANtAWvXeCiBb7Vwxlf2LHoqQo64LkWhJ9mEvbML9C
        2HlMwPiB1xmU7JnGNtgvYu+klbQVIQR3Jf5kfHi+G8pp2Ce9bnavWq2akIIJhQe50d7IDr
        Oh/ommoO4sTR8F15g91C8Sq2IcdmLLksB04ybIk06YNVCvBlzvvyY+9OB8SFJhK3271XIU
        by4sd47xJRktL/vuYnVEFIWIOjeekpmS5mm9cXe7lWodDGEXFuKk5nM7qkt+12g6YanmbB
        IWr7HwE2TQMvUVajHJ6B5pYUpXFNJ+zbETw2tbagT0Cm/neaX0a018Fk7/gzkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666939318;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C39ifa/sE4bg8/kwimkxG6gMln4PD6f9CsViDbJiJkM=;
        b=0yLPjJ1VRxfMFQn35dRXgZN4IAvFQSu2tNFIvvaAJqOx/M//XtK0+HxHVssFfujOcYjkk1
        0/chkJJDRhD1FZCA==
From:   "tip-bot2 for James Clark" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Fix missing raw data on tracepoint events
Cc:     James Clark <james.clark@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        SeongJae Park <sj@kernel.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221012143857.48198-1-james.clark@arm.com>
References: <20221012143857.48198-1-james.clark@arm.com>
MIME-Version: 1.0
Message-ID: <166693931760.29415.616914088747555584.tip-bot2@tip-bot2>
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

Commit-ID:     4b66ff46f2e18b1d32e18c881799ef911606f3be
Gitweb:        https://git.kernel.org/tip/4b66ff46f2e18b1d32e18c881799ef911606f3be
Author:        James Clark <james.clark@arm.com>
AuthorDate:    Wed, 12 Oct 2022 15:38:57 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 27 Oct 2022 10:27:30 +02:00

perf: Fix missing raw data on tracepoint events

Since commit 838d9bb62d13 ("perf: Use sample_flags for raw_data")
raw data is not being output on tracepoints due to the PERF_SAMPLE_RAW
field not being set. Fix this by setting it for tracepoint events.

This fixes the following test failure:

  perf test "sched_switch" -vvv

   35: Track with sched_switch
  --- start ---
  test child forked, pid 1828
  ...
  Using CPUID 0x00000000410fd400
  sched_switch: cpu: 2 prev_tid -14687 next_tid 0
  sched_switch: cpu: 2 prev_tid -14687 next_tid 0
  Missing sched_switch events
  4613 events recorded
  test child finished with -1
  ---- end ----
  Track with sched_switch: FAILED!

Fixes: 838d9bb62d13 ("perf: Use sample_flags for raw_data")
Signed-off-by: James Clark <james.clark@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: SeongJae Park <sj@kernel.org>
Tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Link: https://lore.kernel.org/r/20221012143857.48198-1-james.clark@arm.com
---
 kernel/events/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 01933db..4ec3717 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9846,6 +9846,7 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 
 	perf_sample_data_init(&data, 0, 0);
 	data.raw = &raw;
+	data.sample_flags |= PERF_SAMPLE_RAW;
 
 	perf_trace_buf_update(record, event_type);
 
