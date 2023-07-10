Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB18574D01B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjGJIiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjGJIhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:37:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE36C3;
        Mon, 10 Jul 2023 01:37:54 -0700 (PDT)
Date:   Mon, 10 Jul 2023 08:37:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688978272;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=inEIYZM4ngXU1qpHljVWGzk0u0iImhhisq+ZMRicFjs=;
        b=4ooMdzzaeIPJeWZIW8lHX/3N9bEQ+EWPcxfX8mh2lc2BKQqvFkfNGAAs6yl1E3DfmVzKrL
        1PivHvSMQPT1fus1EzBT8evocRvBKXwFZ90Gr8FMBkO/aWX7ZP6bc6AyTeQVhEFPRRI11Z
        E03sQx/hiiNUtcjAXdQqhJThPzvJjkJIZXmcCSUeUE1Mod8F94dBE4Ke8FqASMTLFmgCmX
        qu4d5vn7ivBqkA+XDUqpIDBFqJbD4AD/zFplhMlakStIr7guvrjpME0dzyLKTSPammhjdw
        /AxdBteGRwzcuHzy/6707gka0fjB2bBmQ07ptKYBQi278i1JU4cs77/0eSNU6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688978272;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=inEIYZM4ngXU1qpHljVWGzk0u0iImhhisq+ZMRicFjs=;
        b=J3H11gUWaFyWJFSX/dOz1Vx4sme/9mnf7DPiS2ObKfxxsI0u9wE4DI4unnvYH6TeoyzVZX
        uVIMKUiKHeTpWzCw==
From:   "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/amd: Prevent grouping of IBS events
Cc:     Sandipan Das <sandipan.das@amd.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230620091603.269-1-ravi.bangoria@amd.com>
References: <20230620091603.269-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Message-ID: <168897827224.404.17660481467586350717.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     7c2128235eff99b448af8f4b5b2933495bf1a440
Gitweb:        https://git.kernel.org/tip/7c2128235eff99b448af8f4b5b2933495bf1a440
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Tue, 20 Jun 2023 14:46:03 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 10 Jul 2023 09:52:34 +02:00

perf/amd: Prevent grouping of IBS events

IBS PMUs can have only one event active at any point in time. Restrict
grouping of multiple IBS events.

Reported-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230620091603.269-1-ravi.bangoria@amd.com
---
 arch/x86/events/amd/ibs.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 3710148..74e6642 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -247,11 +247,33 @@ int forward_event_to_ibs(struct perf_event *event)
 	return -ENOENT;
 }
 
+/*
+ * Grouping of IBS events is not possible since IBS can have only
+ * one event active at any point in time.
+ */
+static int validate_group(struct perf_event *event)
+{
+	struct perf_event *sibling;
+
+	if (event->group_leader == event)
+		return 0;
+
+	if (event->group_leader->pmu == event->pmu)
+		return -EINVAL;
+
+	for_each_sibling_event(sibling, event->group_leader) {
+		if (sibling->pmu == event->pmu)
+			return -EINVAL;
+	}
+	return 0;
+}
+
 static int perf_ibs_init(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	struct perf_ibs *perf_ibs;
 	u64 max_cnt, config;
+	int ret;
 
 	perf_ibs = get_ibs_pmu(event->attr.type);
 	if (!perf_ibs)
@@ -265,6 +287,10 @@ static int perf_ibs_init(struct perf_event *event)
 	if (config & ~perf_ibs->config_mask)
 		return -EINVAL;
 
+	ret = validate_group(event);
+	if (ret)
+		return ret;
+
 	if (hwc->sample_period) {
 		if (config & perf_ibs->cnt_mask)
 			/* raw max_cnt may not be set */
