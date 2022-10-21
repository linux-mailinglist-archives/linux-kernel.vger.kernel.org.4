Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B09606FE9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 08:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiJUGQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 02:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiJUGQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 02:16:27 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802F4102DF6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 23:16:26 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id f8-20020a17090a664800b00212464cd49fso1883435pjm.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 23:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVI308eXyS8Lbu1XFDgJY09yiy/y64U8mWrCVAZtfNM=;
        b=ApOsebNMMrUy1nIx9uaw7MCe9ozsGFebYEhBLz0bsBGKXFN129y/H60GbCNJZsA9iX
         hwsUE9Z2hqIjcaf8wEsh4qz6GtRIbp6UK2WD0PeZ0gnEFZojbgAsAjRGBYeBsZzQY/rk
         mdA+TPES9mVRCvQ3uBb77fJAq7rfD5iqvrmB9GZUcsTkC2nlJcJ6NWenQDAvFktb/zA9
         4iS7qgImoGOZcEdP5Q/t0LgUISEoSSXgvwjpuch/meb4HXpzSM8/75GBDzTBZQrl9DLu
         gecBtwLI7dxO/7Wzp7s43WQYUw17KPE68jK2Fd/D+9UR7Adf5blpFf/TixbL/cY1yPPl
         enWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVI308eXyS8Lbu1XFDgJY09yiy/y64U8mWrCVAZtfNM=;
        b=jyZRBLjOEW9oeQPIgm41VZUxlY3Jsobhetfp8SnQZbiL6Y9Ij8IOWE2iY5NrEUaHPa
         JZyECnKB6jFODJJsCTqAFLTUg738jTIilxhf+3rqeYpZN3hYasNvLg0SjH3H5HKBYhYx
         MGDd14zXLF7U2qRvbJvShJ/vua9711sLpO8T95qVqj8PvFd4ZhSBx94njU/G2v1RssMu
         5QtAJcr1VxMaXoViI4rSd1hSimvOumDtZrQ6z4FrH58tsjSPDw0+8k0AXqYPaZSQHlFg
         UA8FsWUrJKmsb7m4cRJf/BjktFTRlHqE9lw7TQTltDn8n9u6gZ3G+R9nssF05BAF6YfT
         flZw==
X-Gm-Message-State: ACrzQf0eBY91qTJmm/YCUUrVWhdHj+bL6k1HoQIPViC7ic5MIorwsmwR
        82qlA2gg1+KrL5iebALnLvlp+Q==
X-Google-Smtp-Source: AMsMyM6DxwLTzE9ETzTH1ou+CRSd18+kc0m8Tvrp6rLi1Ure9JvkMSuTkm9C9fMGW45Hswz0GBWmwQ==
X-Received: by 2002:a17:90b:1b0b:b0:20d:7c31:e75d with SMTP id nu11-20020a17090b1b0b00b0020d7c31e75dmr19924620pjb.101.1666332985621;
        Thu, 20 Oct 2022 23:16:25 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id o11-20020a17090a4b4b00b0020d45a155d9sm327532pjl.35.2022.10.20.23.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 23:16:24 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH 2/2] sched/core: Optimize the order of scanning CPU
Date:   Fri, 21 Oct 2022 14:15:58 +0800
Message-Id: <20221021061558.34767-3-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20221021061558.34767-1-jiahao.os@bytedance.com>
References: <20221021061558.34767-1-jiahao.os@bytedance.com>
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
So, we finally try the target CPU. Similarly for task_numa_assign(),
we have just checked numa_migrate_on of dst_cpu, so start from the
next CPU. This also works for steal_cookie_task(), the first scan
must fail and start directly from the next one.

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
---
 kernel/sched/core.c | 2 +-
 kernel/sched/fair.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5800b0623ff3..f6ad68714546 100644
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
index b7cbec539c77..d95ee285734e 100644
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

