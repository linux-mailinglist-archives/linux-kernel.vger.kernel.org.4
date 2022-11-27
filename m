Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41874639B51
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 15:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiK0OSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 09:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiK0OSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 09:18:03 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26A3D2CE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 06:18:02 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id x17so13092417wrn.6
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 06:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkAjMv32NBv57ip/jp/OcgWLx4nOD1X2Vve6sHHv9TI=;
        b=wJlclZrhZWJJLY4gKqU4fQES98mqQVQVDUvCpoKE/Gxf7/HXho4CZNyqW4HxaSaA8A
         c4Rjl2N+yZDHwIz+TAKQHxMqUl+6iz1cx7iGstjJmiuD05BD7sCFybcXGkR9d0ny+yOK
         oBI9Db0+HQLdyQEvb2TKypAG3NuYTaMHOr0n8Taxd1S1qcrD8epAUsRBTxFnX8FXmZr4
         Jx85SCM6w8UUOtYtI6O0RQ4QKnK30quLo6pY9yXuC96P5PcAq/sfrmUvfOke+4yWCGYj
         CRmQyr1HTCipxjci3vu5VuqXHFsqJ/5DDx6F2y0Oa/6P+h5DcAMu8eo7y35OSd5E31y7
         +XvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jkAjMv32NBv57ip/jp/OcgWLx4nOD1X2Vve6sHHv9TI=;
        b=KtHjj0J4rSF/n9+6eZ6EwgX983/ekLVaccZKKliDsqBHfF80wXxk1NhWHUYIbcQ/yZ
         3e0+QBn1h9KuqLgBbuOqvDD3JIu/lMo6MPWeYa5wKsioQanWkKWBZ//5E0iKXJah+6zy
         rIs6PE90OtmBYEsXIUMq+6toUO0E2i2PC7r5fHLAFiXDoIF1wibN2CD8IwgagwI0wv+0
         UQcfrZRNKJjwxIzlaxD5Fn2VWI0qnDiFJyyC0uqwqeBRLZWBlcFoNs9igRH0X3VULwPs
         LIuh82bVjlSFtr1NeYV3WwmLEYWcVGchucbiC1x/tMOrPlwCqSxAKpKethik9Zs7ActJ
         LeBw==
X-Gm-Message-State: ANoB5pn4ZYZhaJ/ZWAEjIus/QkOxv5yn7ceGFDFRR8120YMSAwFMybnc
        D9Es0jub1P5cr3rMDIz55HsrCg==
X-Google-Smtp-Source: AA0mqf4EfcqefMk4H0mjiFRUaLNNXts5OdAKrB9ADHLirI79hJGFJ4cAba3xzfc8lcqsNc3nB0pcRg==
X-Received: by 2002:a5d:4149:0:b0:242:149c:5690 with SMTP id c9-20020a5d4149000000b00242149c5690mr1303871wrq.491.1669558681519;
        Sun, 27 Nov 2022 06:18:01 -0800 (PST)
Received: from localhost.localdomain (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id l1-20020a05600c4f0100b003c6f3f6675bsm17109757wmq.26.2022.11.27.06.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 06:18:01 -0800 (PST)
From:   Qais Yousef <qyousef@layalina.io>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Qais Yousef <qyousef@layalina.io>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH 1/3] sched/uclamp: Fix a uninitialized variable warnings
Date:   Sun, 27 Nov 2022 14:17:40 +0000
Message-Id: <20221127141742.1644023-2-qyousef@layalina.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221127141742.1644023-1-qyousef@layalina.io>
References: <20221127141742.1644023-1-qyousef@layalina.io>
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

Addresses the following warnings:

> config: riscv-randconfig-m031-20221111
> compiler: riscv64-linux-gcc (GCC) 12.1.0
>
> smatch warnings:
> kernel/sched/fair.c:7263 find_energy_efficient_cpu() error: uninitialized symbol 'util_min'.
> kernel/sched/fair.c:7263 find_energy_efficient_cpu() error: uninitialized symbol 'util_max'.

Fixes: 244226035a1f ("sched/uclamp: Fix fits_capacity() check in feec()")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 kernel/sched/fair.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4cc56c91e06e..89dadaafc1ec 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7217,10 +7217,10 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	eenv_task_busy_time(&eenv, p, prev_cpu);
 
 	for (; pd; pd = pd->next) {
+		unsigned long util_min = p_util_min, util_max = p_util_max;
 		unsigned long cpu_cap, cpu_thermal_cap, util;
 		unsigned long cur_delta, max_spare_cap = 0;
 		unsigned long rq_util_min, rq_util_max;
-		unsigned long util_min, util_max;
 		unsigned long prev_spare_cap = 0;
 		int max_spare_cap_cpu = -1;
 		unsigned long base_energy;
@@ -7258,10 +7258,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			 * aligned with sched_cpu_util().
 			 */
 			if (uclamp_is_used()) {
-				if (uclamp_rq_is_idle(cpu_rq(cpu))) {
-					util_min = p_util_min;
-					util_max = p_util_max;
-				} else {
+				if (!uclamp_rq_is_idle(cpu_rq(cpu))) {
 					/*
 					 * Open code uclamp_rq_util_with() except for
 					 * the clamp() part. Ie: apply max aggregation
-- 
2.25.1

