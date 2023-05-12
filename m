Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4DD70046F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 11:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240013AbjELJ62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 05:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240591AbjELJ6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 05:58:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED11811626;
        Fri, 12 May 2023 02:58:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23F401063;
        Fri, 12 May 2023 02:58:45 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.22.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C9C1C3F5A1;
        Fri, 12 May 2023 02:57:57 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, Pierre.Gondois@arm.com,
        ionela.voinescu@arm.com, rostedt@goodmis.org, mhiramat@kernel.org
Subject: [PATCH v2 01/17] PM: EM: Refactor em_cpufreq_update_efficiencies() arguments
Date:   Fri, 12 May 2023 10:57:27 +0100
Message-Id: <20230512095743.3393563-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230512095743.3393563-1-lukasz.luba@arm.com>
References: <20230512095743.3393563-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to prepare the code for the modifiable EM perf_state table,
refactor existing function em_cpufreq_update_efficiencies().

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/power/energy_model.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 7b44f5b89fa1..0d037f3c4e58 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -237,10 +237,10 @@ static int em_create_pd(struct device *dev, int nr_states,
 	return 0;
 }
 
-static void em_cpufreq_update_efficiencies(struct device *dev)
+static void
+em_cpufreq_update_efficiencies(struct device *dev, struct em_perf_state *table)
 {
 	struct em_perf_domain *pd = dev->em_pd;
-	struct em_perf_state *table;
 	struct cpufreq_policy *policy;
 	int found = 0;
 	int i;
@@ -254,8 +254,6 @@ static void em_cpufreq_update_efficiencies(struct device *dev)
 		return;
 	}
 
-	table = pd->table;
-
 	for (i = 0; i < pd->nr_perf_states; i++) {
 		if (!(table[i].flags & EM_PERF_STATE_INEFFICIENT))
 			continue;
@@ -397,7 +395,7 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 
 	dev->em_pd->flags |= flags;
 
-	em_cpufreq_update_efficiencies(dev);
+	em_cpufreq_update_efficiencies(dev, dev->em_pd->table);
 
 	em_debug_create_pd(dev);
 	dev_info(dev, "EM: created perf domain\n");
-- 
2.25.1

