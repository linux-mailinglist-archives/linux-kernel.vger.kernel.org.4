Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C938A606FE7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 08:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJUGQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 02:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiJUGQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 02:16:20 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA7D237960
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 23:16:19 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id g8-20020a17090a128800b0020c79f987ceso5711938pja.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 23:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i19y5QR9mtVVOPA0wEofADzlXW2aN27SSyV8zYQJio8=;
        b=u1ImNYfdUbWLriSGwT46wNN9Zle5dKFToW2gR/VcF1g2jLV1fk/3baGCIQJH1A/qHW
         1JTbFXqdbvsDobztBPBy4yKK94U7TPmgYBPa1J+PTLkBOGD/KGHvzoQjyViTsLqPNBIM
         cC6L3nXkvhkY/jfftsf1rvrJoUGSg1MKMfmLEF5Lz1Kvn7o/h9VICAGgRrgUQ1uZTdIO
         Zce3wdZYmxrSGz4IC9ZI9BVPfk+gcnA7Wv0C+tH+zctYJ3FYSkc/qK/uTqve9BR6qLtb
         mnSIxAin35S7/lAr565wadFXn88M9dJqvIshpGqhVrBI/QSgp2Xw8VQBHZ4TDEnm9buC
         dQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i19y5QR9mtVVOPA0wEofADzlXW2aN27SSyV8zYQJio8=;
        b=qSKgqhBxPSF9LxS4/GKgIN8T/WvbJrh6uqkQRW+4MRaPf4CnFsdXRMzirPJjtSOftl
         tGgrR8/yVLl0TsLZgjLKp/j3Ig3bScNr7i7XCu9cMezHqOMDiQkHgFS+NyhIdjUIliK7
         wcIO5jDKpZYfLgXjlzdCWuQeFuTh6pnNSrGmeZFo5fv/VHsk365VixH3xvwOix35ihuk
         uT6VymAC4aUw8GYwlpBRCnP9tqNvhVwaeOL3ysdkOjZg9XsCHhlHZGvmuf3y2H1xVUvb
         Cox/wp9AbT6wkqe3Sjp9boClnlXhzj84pfEI2o5Tis2kKFCFq1W3EHMfPEw8QwN96trg
         1A/A==
X-Gm-Message-State: ACrzQf1aoFa2sSAgtEETnshYDvQYI/O4pVg+48YGTlyps74g7aBurJW7
        5dBvEk/Thg7f+BOl6NjoeqD4m+Cu21pAJmGD
X-Google-Smtp-Source: AMsMyM4791DaaKg+BR7bqqxJtvSx8xckqfaU41OSGiuSieA451ZMhUkaqgXx8Fg+en9CVPHumhfjNQ==
X-Received: by 2002:a17:90b:384e:b0:20d:4b52:ddf0 with SMTP id nl14-20020a17090b384e00b0020d4b52ddf0mr20742540pjb.113.1666332978010;
        Thu, 20 Oct 2022 23:16:18 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id o11-20020a17090a4b4b00b0020d45a155d9sm327532pjl.35.2022.10.20.23.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 23:16:17 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH 1/2] sched/numa: Stop an exhastive search if an idle core is found
Date:   Fri, 21 Oct 2022 14:15:57 +0800
Message-Id: <20221021061558.34767-2-jiahao.os@bytedance.com>
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

In update_numa_stats() we try to find an idle cpu on the NUMA node,
preferably an idle core. When we find an idle core,
we can stop searching.

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
---
 kernel/sched/fair.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e4a0b8bd941c..b7cbec539c77 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1792,7 +1792,7 @@ static void update_numa_stats(struct task_numa_env *env,
 		ns->nr_running += rq->cfs.h_nr_running;
 		ns->compute_capacity += capacity_of(cpu);
 
-		if (find_idle && !rq->nr_running && idle_cpu(cpu)) {
+		if (find_idle && idle_core < 0 && !rq->nr_running && idle_cpu(cpu)) {
 			if (READ_ONCE(rq->numa_migrate_on) ||
 			    !cpumask_test_cpu(cpu, env->p->cpus_ptr))
 				continue;
@@ -1801,6 +1801,9 @@ static void update_numa_stats(struct task_numa_env *env,
 				ns->idle_cpu = cpu;
 
 			idle_core = numa_idle_core(idle_core, cpu);
+			/* If we find an idle core, stop searching. */
+			if (idle_core >= 0)
+				ns->idle_cpu = idle_core;
 		}
 	}
 	rcu_read_unlock();
@@ -1808,9 +1811,6 @@ static void update_numa_stats(struct task_numa_env *env,
 	ns->weight = cpumask_weight(cpumask_of_node(nid));
 
 	ns->node_type = numa_classify(env->imbalance_pct, ns);
-
-	if (idle_core >= 0)
-		ns->idle_cpu = idle_core;
 }
 
 static void task_numa_assign(struct task_numa_env *env,
-- 
2.37.0

