Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BB162B61E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiKPJM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbiKPJMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:12:41 -0500
X-Greylist: delayed 122 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Nov 2022 01:12:39 PST
Received: from mx6.didiglobal.com (mx6.didiglobal.com [111.202.70.123])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 96FE32B2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:12:39 -0800 (PST)
Received: from mail.didiglobal.com (unknown [10.79.64.13])
        by mx6.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id 3DB59110243202;
        Wed, 16 Nov 2022 17:10:35 +0800 (CST)
Received: from localhost.localdomain (10.79.64.101) by
 ZJY01-ACTMBX-03.didichuxing.com (10.79.64.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 16 Nov 2022 17:10:34 +0800
X-MD-Sfrom: wanghonglei@didiglobal.com
X-MD-SrcIP: 10.79.64.13
From:   Honglei Wang <wanghonglei@didiglobal.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     Honglei Wang <wanghonglei@didiglobal.com>
Subject: [PATCH] sched/core: use correct cpu_capacity in wake_affine_weight()
Date:   Wed, 16 Nov 2022 17:10:27 +0800
Message-ID: <20221116091027.78906-1-wanghonglei@didiglobal.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.79.64.101]
X-ClientProxiedBy: ZJY03-PUBMBX-01.didichuxing.com (10.79.71.12) To
 ZJY01-ACTMBX-03.didichuxing.com (10.79.64.13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems make more sense to do the load weight calculation with
respective cpu_capacity.

Signed-off-by: Honglei Wang <wanghonglei@didiglobal.com>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e4a0b8bd941c..a9f75040969b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6262,13 +6262,13 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 	this_eff_load += task_load;
 	if (sched_feat(WA_BIAS))
 		this_eff_load *= 100;
-	this_eff_load *= capacity_of(prev_cpu);
+	this_eff_load *= capacity_of(this_cpu);
 
 	prev_eff_load = cpu_load(cpu_rq(prev_cpu));
 	prev_eff_load -= task_load;
 	if (sched_feat(WA_BIAS))
 		prev_eff_load *= 100 + (sd->imbalance_pct - 100) / 2;
-	prev_eff_load *= capacity_of(this_cpu);
+	prev_eff_load *= capacity_of(prev_cpu);
 
 	/*
 	 * If sync, adjust the weight of prev_eff_load such that if
-- 
2.14.1

