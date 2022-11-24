Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2374637878
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiKXMEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiKXMDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:03:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1375B61BBD;
        Thu, 24 Nov 2022 04:03:06 -0800 (PST)
Date:   Thu, 24 Nov 2022 12:03:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669291384;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rv0mZQl/P64/r08zZSGxtVX7fiVPil8Ys96KQM96r0k=;
        b=1Dy8HVsniLtkdRD+pe2jg9l8gN6jbf+uWF1lJSLq/ougiAEh/MYuOLprmNtaoNgGhTHEn0
        Lvps/zbkvFGIbqpTDILEvOAKXOgclbV8bJI6A4nJ39LcrOI5inn1Wb79j9uRiKAepqdnAB
        f16RAD5m3sPS7WiXxY0JK9Jr6vGO+9bVHGXoeu3+1xvaMDNk10HDObUmaBRC1szXdXY7py
        uX6FfLqLrkBpIegoBVHyphlNKA9Bjzuldnz5xJ0rRYdgnIyoEV9F02AUp2ikvBsXXohPcU
        xKAgyXmx1rvvcI0Qic26MTCAtKhJd6b+R+HxKrDfUxj3WScvBj0xrElO3yq7kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669291384;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rv0mZQl/P64/r08zZSGxtVX7fiVPil8Ys96KQM96r0k=;
        b=0nH57gNjIAj+nBzzXyCaBO9fi2W4EKoavSpBnOwRhshIeatDZ8UvQyRE53mTkYh370poT7
        Omy96xdZmOXmr1Dg==
From:   "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/amd/ibs: Make IBS a core pmu
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221115093904.1799-1-ravi.bangoria@amd.com>
References: <20221115093904.1799-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Message-ID: <166929138346.4906.10749574210524260976.tip-bot2@tip-bot2>
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

Commit-ID:     30093056f7b2f759ff180d3a86d29f68315e469b
Gitweb:        https://git.kernel.org/tip/30093056f7b2f759ff180d3a86d29f68315e469b
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Tue, 15 Nov 2022 15:09:04 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 24 Nov 2022 11:09:19 +01:00

perf/amd/ibs: Make IBS a core pmu

So far, only one pmu was allowed to be registered as core pmu and thus
IBS pmus were being registered as uncore. However, with the event context
rewrite, that limitation no longer exists and thus IBS pmus can also be
registered as core pmu. This makes IBS much more usable, for ex, user
will be able to do per-process precise monitoring on AMD:

Before patch:
  $ sudo perf record -e cycles:pp ls
  Error:
  Invalid event (cycles:pp) in per-thread mode, enable system wide with '-a'

After patch:
  $ sudo perf record -e cycles:pp ls
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.017 MB perf.data (33 samples) ]

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Ian Rogers <irogers@google.com>
Link: https://lkml.kernel.org/r/20221115093904.1799-1-ravi.bangoria@amd.com
---
 arch/x86/events/amd/ibs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 3271735..fbc2ce8 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -631,7 +631,7 @@ static const struct attribute_group *op_attr_update[] = {
 
 static struct perf_ibs perf_ibs_fetch = {
 	.pmu = {
-		.task_ctx_nr	= perf_invalid_context,
+		.task_ctx_nr	= perf_hw_context,
 
 		.event_init	= perf_ibs_init,
 		.add		= perf_ibs_add,
@@ -655,7 +655,7 @@ static struct perf_ibs perf_ibs_fetch = {
 
 static struct perf_ibs perf_ibs_op = {
 	.pmu = {
-		.task_ctx_nr	= perf_invalid_context,
+		.task_ctx_nr	= perf_hw_context,
 
 		.event_init	= perf_ibs_init,
 		.add		= perf_ibs_add,
