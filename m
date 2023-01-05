Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C5865E219
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjAEAzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjAEAyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:54:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D054D730;
        Wed,  4 Jan 2023 16:51:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F2DCB81983;
        Thu,  5 Jan 2023 00:51:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B930C433F2;
        Thu,  5 Jan 2023 00:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672879887;
        bh=a9j2iXVLoC1TD3lQ/10Gw2Pvt/B4K6hHFOFLrRwW1Dc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XzYY8NJbzzoB8B0ZzIvvzNz+KpyoRzc2GqLb2niUTABfa/LQsT+r65gP22WcxsbGM
         z8gt+860oprHMixmLDBNlW+qYTVAW6ITC0ZMfGzAd5KAfxXjQQKTG2bIGpdBgWRn/+
         UjTzjWOR/SntEOgajwvN+hmAaBXIVPZtW03pxWPgAwZJnq8hQ5+mFc89geOGyHYEHm
         yG9heL833MlrxE3ACZ8eKlGEufE34O2MQXGifrm4yFdNE7Ou1cYSnfVyaCslke8Bn0
         SQqM7rO5DpVcFG2IzevyK2SVx2H2X1KuQPrH8yMkeU07PDcCs/0IcZr0gFsTWpfyQK
         hTaJXjLr9mkhQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 513905C086D; Wed,  4 Jan 2023 16:51:27 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Zhen Lei <thunder.leizhen@huawei.com>,
        Josh Don <joshdon@google.com>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/6] sched: Add helper kstat_cpu_softirqs_sum()
Date:   Wed,  4 Jan 2023 16:51:22 -0800
Message-Id: <20230105005126.1772294-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105005105.GA1772125@paulmck-ThinkPad-P17-Gen-1>
References: <20230105005105.GA1772125@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

Add a kstat_cpu_softirqs_sum() function that is similar to
kstat_cpu_irqs_sum(), but which counts software interrupts since boot
on the specified CPU.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Josh Don <joshdon@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/kernel_stat.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 90e2fdc17d79f..898076e173a92 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -67,6 +67,17 @@ static inline unsigned int kstat_softirqs_cpu(unsigned int irq, int cpu)
        return kstat_cpu(cpu).softirqs[irq];
 }
 
+static inline unsigned int kstat_cpu_softirqs_sum(int cpu)
+{
+	int i;
+	unsigned int sum = 0;
+
+	for (i = 0; i < NR_SOFTIRQS; i++)
+		sum += kstat_softirqs_cpu(i, cpu);
+
+	return sum;
+}
+
 /*
  * Number of interrupts per specific IRQ source, since bootup
  */
-- 
2.31.1.189.g2e36527f23

