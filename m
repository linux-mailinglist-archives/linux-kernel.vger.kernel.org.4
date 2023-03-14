Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D8A6B9035
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjCNKgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjCNKgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:36:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9512830B20;
        Tue, 14 Mar 2023 03:35:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C119169E;
        Tue, 14 Mar 2023 03:35:19 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.19.101])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C03C63F71A;
        Tue, 14 Mar 2023 03:34:32 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, Pierre.Gondois@arm.com,
        ionela.voinescu@arm.com, rostedt@goodmis.org, mhiramat@kernel.org
Subject: [PATCH 07/17] PM: EM: Check if the get_cost() callback is present in em_compute_costs()
Date:   Tue, 14 Mar 2023 10:33:47 +0000
Message-Id: <20230314103357.26010-8-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230314103357.26010-1-lukasz.luba@arm.com>
References: <20230314103357.26010-1-lukasz.luba@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The em_compute_cost() is going to be re-used in runtime modified EM
code path. Thus, make sure that this common code is safe and won't
try to use the NULL pointer. The former em_compute_cost() didn't have to
care about runtime modification code path. The upcoming changes introduce
such option, but with different callback. Those two paths which use
get_cost() (during first EM registration) or update_power() (during
runtime modification) need to be safely handled in em_compute_costs().

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/power/energy_model.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 3b778743ba89..230310709e2a 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -122,7 +122,7 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
 	for (i = nr_states - 1; i >= 0; i--) {
 		unsigned long power_res, cost;
 
-		if (flags & EM_PERF_DOMAIN_ARTIFICIAL) {
+		if (flags & EM_PERF_DOMAIN_ARTIFICIAL && cb->get_cost) {
 			ret = cb->get_cost(dev, table[i].frequency, &cost);
 			if (ret || !cost || cost > EM_MAX_POWER) {
 				dev_err(dev, "EM: invalid cost %lu %d\n",
-- 
2.17.1

