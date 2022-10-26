Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B023360DB87
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 08:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbiJZGnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 02:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbiJZGna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 02:43:30 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AE5AD99C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 23:43:24 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y13so9841496pfp.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 23:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fjwpVVv8NNDnWDvTOJej+inL4k7BmCXyJpK0M4DMs4=;
        b=k7ku7Elr6sQpsfdbeabwVWXePRIEmsJH2g8MvGOJVv9XSTu83/tFBtHYnmFjlwovxG
         lomJjjQJtTvCcozuz907T/VmwAhTYpQxwvKLIaS9xFP8li3tBVTTMCq+EMZ2OuEEKa3c
         aoPmgWkPbGH1FcCYlYbFlEsvBLqEmvJ3PfDcvfc/rTEpe0yCU2IF7Ogolz99HHYmr2U/
         SyNvCtGCp0rwdKhXA8AsaryifFskUXcAiSqgcFhZTgvDAmlTZOsCoze9tRR9tmBn2D5q
         YSRBHIvEF6MZkXmZg8RytyDGfD1WOyqfFJZYdkqHpJurWvvb29jv3vj5nZfEUa/mLggG
         9tNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2fjwpVVv8NNDnWDvTOJej+inL4k7BmCXyJpK0M4DMs4=;
        b=l0VJwg34JkoKDVMjWVxLR/7lwlM2K4kzdOVf4YKTQN33+q5YU6Y7ns9pX/lhRkSsld
         /PiHYUQ72MERwn4Gcp7eA90yhw6qUvlwJGa/JFlk9VegIUb2BOFR87Zn0n1ZqxecA+fa
         3gBJD6pxArWe83HCc06PFS5gRYCzLaWqD4vcrPh2X9ISD4hEUVmBamkPrtVdNK0qH3OJ
         cJZOvfHd8XOEA1vlasz1X+Axtoa52OejE03lYCxzpfY89vBzgeHfoUUGZu6tFSVchtGe
         7eB/te7SALNFHoVbrGi7BNzcMFMJqDxKy7KLvLjpXsiYLHOaberp7Ipy+yNrR14s4/YW
         d7Nw==
X-Gm-Message-State: ACrzQf0XZp2loBfZJKDCgz5s8SYW8Ah6XLCZPCug6EtRWAEZ8DmRcdmV
        DcSCZUZ9b6c27GaG4Aqb55dF5g==
X-Google-Smtp-Source: AMsMyM7djfSzM0A2uMLdFh/ASshpO8dgn1T4G58rQ1o5RqYl1YjDyWjuQjvX7E+PCyvagU/mu0ePtA==
X-Received: by 2002:a65:6bc7:0:b0:44a:dcee:18a5 with SMTP id e7-20020a656bc7000000b0044adcee18a5mr35855576pgw.413.1666766604344;
        Tue, 25 Oct 2022 23:43:24 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id b62-20020a621b41000000b0056b932f3280sm2363187pfb.103.2022.10.25.23.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 23:43:23 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH v2 2/2] sched/core: Adjusting the order of scanning CPU
Date:   Wed, 26 Oct 2022 14:43:00 +0800
Message-Id: <20221026064300.78869-3-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20221026064300.78869-1-jiahao.os@bytedance.com>
References: <20221026064300.78869-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When select_idle_capacity() starts scanning for an idle CPU, it starts
with target CPU that has already been checked in select_idle_sibling().
So we start checking from the next CPU and try the target CPU at the end.
Similarly for task_numa_assign(), we have just checked numa_migrate_on
of dst_cpu, so start from the next CPU. This also works for
steal_cookie_task(), the first scan must fail and start directly
from the next one.

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
---
 kernel/sched/core.c | 2 +-
 kernel/sched/fair.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cb2aa2b54c7a..5c3c539e1712 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6154,7 +6154,7 @@ static bool steal_cookie_task(int cpu, struct sched_domain *sd)
 {
 	int i;
 
-	for_each_cpu_wrap(i, sched_domain_span(sd), cpu) {
+	for_each_cpu_wrap(i, sched_domain_span(sd), cpu + 1) {
 		if (i == cpu)
 			continue;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index dfcb620bfe50..ba91d4478260 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1824,7 +1824,7 @@ static void task_numa_assign(struct task_numa_env *env,
 		int start = env->dst_cpu;
 
 		/* Find alternative idle CPU. */
-		for_each_cpu_wrap(cpu, cpumask_of_node(env->dst_nid), start) {
+		for_each_cpu_wrap(cpu, cpumask_of_node(env->dst_nid), start + 1) {
 			if (cpu == env->best_cpu || !idle_cpu(cpu) ||
 			    !cpumask_test_cpu(cpu, env->p->cpus_ptr)) {
 				continue;
@@ -6663,7 +6663,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 
 	task_util = uclamp_task_util(p);
 
-	for_each_cpu_wrap(cpu, cpus, target) {
+	for_each_cpu_wrap(cpu, cpus, target + 1) {
 		unsigned long cpu_cap = capacity_of(cpu);
 
 		if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu))
-- 
2.37.0

