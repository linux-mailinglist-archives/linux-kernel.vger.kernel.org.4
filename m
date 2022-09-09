Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56F95B32AE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbiIIJB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiIIJAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:00:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5559B9C1E5;
        Fri,  9 Sep 2022 02:00:32 -0700 (PDT)
Date:   Fri, 09 Sep 2022 09:00:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662714030;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WtBZmUlJ1zGyVnUzqaSse8f7Z2iX+tQdKbkOtsz7jV4=;
        b=ZvaTfgX+MdLNEuPGApVRlI3b/E+WysomnAGrrXwy+1PWhq6AEejp7GUCg5c8a76DFOC1kt
        NGJk0oq/9Cc/+sGGF8uvP2SybdCdk++TuXwHwqTTrKSOPQ5Xo73CENZnF3uOA4cGJHGOKr
        eBS11ZGWqInEJSV+Ez2qxeRhVm64+VP9DUhLY24JZgVp4ERG5hMv+NWEs3GpJ/o4T/0wyD
        hpscHc2esQ0CGK6SnNtFPpOFsOFlGEnBaoO/ilItJGPfnaLuJ562IW4xkYjPCwPPuEkdEq
        epBAXkfkqF0RfVN+T+BvSTQJxI6okzRoTXdV3juMzKxHUWukP1UIQuuET4t3Pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662714030;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WtBZmUlJ1zGyVnUzqaSse8f7Z2iX+tQdKbkOtsz7jV4=;
        b=ZH93cRG+c4xwGwXugxCehWdOWESNXnLlb/10YuxGSCtOCLkRszd/jxHxfRnbgEeqGrdbwE
        Z3kRDJQmvjNbWICg==
From:   "tip-bot2 for Abel Wu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Remove useless check in select_idle_core()
Cc:     Abel Wu <wuyun.abel@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220907112000.1854-4-wuyun.abel@bytedance.com>
References: <20220907112000.1854-4-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Message-ID: <166271402944.401.1372807563306162963.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8eeeed9c4a791f0d1f2ea830eb75a4246c117ae2
Gitweb:        https://git.kernel.org/tip/8eeeed9c4a791f0d1f2ea830eb75a4246c117ae2
Author:        Abel Wu <wuyun.abel@bytedance.com>
AuthorDate:    Wed, 07 Sep 2022 19:19:58 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Sep 2022 21:53:46 +02:00

sched/fair: Remove useless check in select_idle_core()

The function select_idle_core() only gets called when has_idle_cores
is true which can be possible only when sched_smt_present is enabled.

This change also aligns select_idle_core() with select_idle_smt() in
the way that the caller do the check if necessary.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Link: https://lore.kernel.org/r/20220907112000.1854-4-wuyun.abel@bytedance.com
---
 kernel/sched/fair.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1ad79aa..03ce650 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6321,9 +6321,6 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 	bool idle = true;
 	int cpu;
 
-	if (!static_branch_likely(&sched_smt_present))
-		return __select_idle_cpu(core, p);
-
 	for_each_cpu(cpu, cpu_smt_mask(core)) {
 		if (!available_idle_cpu(cpu)) {
 			idle = false;
