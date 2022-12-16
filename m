Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBF864E74A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 07:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiLPGYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 01:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiLPGY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 01:24:29 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F9B654EE
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 22:24:28 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so5057569pjr.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 22:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEBn3rIORKhKVuqIN/cMMOVkHVPj5Ym5EqGWb/wIQVk=;
        b=Ypv/XyC62kjv9HAqqcaPhJIxQx9wsgVqq+EI46a3l1IPfn4ashDi1YifxmVQ9zyaVC
         eBEhkkfSiP8xNDVkbyUl3xH1CVEX52HhFHVd4G7xLceGkNjgFcCaXQWHwKCM3zBwsIUi
         25xJqTAxwVt9ldwxBU+/D5pDGqu+ChU2VKqsX153LKLtbJWRn7DBxXxWZ9hIqnKQgXci
         f6Ux1Ik5ExddTVYC2P9rIb1U/xqR/h6z9WzbCRlj6TiHa61/dgMSifzrF7E3QUO/C9CF
         yTlM/2U3oP5rqQZGkg3kywwY12EduCyBixeyp+wa88kSG40utoaAdeIJVNkrCGVhWhcW
         DQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEBn3rIORKhKVuqIN/cMMOVkHVPj5Ym5EqGWb/wIQVk=;
        b=WJZpGZHEOrRTolN9Tvvvd8IvQko0WLVSHEellmueZt454ssu2JL5TKJ58dWe+BEGHB
         5j3+0Dv6ECMOHnCGYHCgBSfmOxwTmr5MGLsG54rX5vA7w2MXhXdukbrHdTv+U3ycBBMS
         AtRWCS2zBTvbUpyoCWzxWe1cZJML60w5dUAh7vZ7G03L0r4a64e7mwDmD+bPGlIvZjNp
         tneJoDBpp5HdIIvbFSlRTBrOaNiA89H4f3ZOutMqsxLRjn3SSBjEP+7Kzi1fIXdRm3iC
         8kUu0RsQHfCrOxvba85G4PWyM3RLRU1Q3LFPjAjyxE5+tdYYosJrBOSdeYgKyCCWSLKP
         l/Hg==
X-Gm-Message-State: ANoB5plffaC/hhex7/PlA0jzlglX2vMFUJ1m3rFm8ppax66ZQtJWtlrE
        ts3v1rqOjwZ8vTYD7BEYKW+ajQ==
X-Google-Smtp-Source: AA0mqf5wlP+Gvt2w6tilzZkoq5h6kKmOhFRYD6ToakZFodgniQUZHwDcph6UOsmhbEZSoiuFxVMkEA==
X-Received: by 2002:a05:6a20:bf17:b0:ac:6543:d515 with SMTP id gc23-20020a056a20bf1700b000ac6543d515mr34111225pzb.42.1671171868243;
        Thu, 15 Dec 2022 22:24:28 -0800 (PST)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id s5-20020a656445000000b0046feca0883fsm681819pgv.64.2022.12.15.22.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 22:24:27 -0800 (PST)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH v3 1/2] sched/numa: Stop an exhastive search if an idle core is found
Date:   Fri, 16 Dec 2022 14:24:05 +0800
Message-Id: <20221216062406.7812-2-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20221216062406.7812-1-jiahao.os@bytedance.com>
References: <20221216062406.7812-1-jiahao.os@bytedance.com>
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
preferably an idle core. we can stop looking for the next idle core
or idle cpu after finding an idle core. But we can't stop the
whole loop of scanning the CPU, because we need to calculate
approximate NUMA stats at a point in time. For example,
the src and dst nr_running is needed by task_numa_find_cpu().

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c36aa54ae071..643cbcb61b49 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1804,7 +1804,7 @@ static void update_numa_stats(struct task_numa_env *env,
 		ns->nr_running += rq->cfs.h_nr_running;
 		ns->compute_capacity += capacity_of(cpu);
 
-		if (find_idle && !rq->nr_running && idle_cpu(cpu)) {
+		if (find_idle && idle_core < 0 && !rq->nr_running && idle_cpu(cpu)) {
 			if (READ_ONCE(rq->numa_migrate_on) ||
 			    !cpumask_test_cpu(cpu, env->p->cpus_ptr))
 				continue;
-- 
2.37.0

