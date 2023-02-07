Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7F368DDAF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjBGQNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjBGQND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:13:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED98DBEF;
        Tue,  7 Feb 2023 08:13:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECA1060F16;
        Tue,  7 Feb 2023 16:13:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A13AC433D2;
        Tue,  7 Feb 2023 16:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675786380;
        bh=cC2tkzskefDBrZsRvMNSczr6SitbzsKg7wGCqoUStHs=;
        h=From:To:Cc:Subject:Date:From;
        b=f6UuGFSLOAa3/jEqTL8xCu752LB/v8U3T4/n7H7TP+DnA7MHVJ5Vo5N6wy95yp83P
         3RzDdYgxP0osFCxQoOpBVQ6QBH2x9upd1ijSxseNfiXM2jyY23tInRrYN/inEEjIEG
         GPvz+k1Z1MlR7IVEt67M5aTJrybyZw5jDsUOkUFymVJjX/SlCwn7n24j6Vx5Dctp4F
         YNCXUtoEGBQ1XJt914hG+MgsBiPcZ5bSnpnmdS6Gtknc5EOYbsBxUAljNC75gS2rh8
         CMmRnOw9YU/dCZC6ACchSa1JcLgx1HKsBsJwkEtVF8w3aPEVcwndJ12mLguLm7M7wO
         ZuWqcudZxdoyQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Huang Rui <ray.huang@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Wyes Karny <wyes.karny@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Mario Limonciello <Mario.Limonciello@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Perry Yuan <perry.yuan@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>, Meng Li <li.meng@amd.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: amd-pstate: avoid uninitialized variable use
Date:   Tue,  7 Feb 2023 17:12:51 +0100
Message-Id: <20230207161256.271613-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The new epp support causes warnings about three separate
but related bugs:

1) failing before allocation should just return an error:

drivers/cpufreq/amd-pstate.c:951:6: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
        if (!dev)
            ^~~~
drivers/cpufreq/amd-pstate.c:1018:9: note: uninitialized use occurs here
        return ret;
               ^~~

2) wrong variable to store return code:

drivers/cpufreq/amd-pstate.c:963:6: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
        if (rc)
            ^~
drivers/cpufreq/amd-pstate.c:1019:9: note: uninitialized use occurs here
        return ret;
               ^~~
drivers/cpufreq/amd-pstate.c:963:2: note: remove the 'if' if its condition is always false
        if (rc)
        ^~~~~~~

3) calling amd_pstate_set_epp() in cleanup path after determining
that it should not be called:

drivers/cpufreq/amd-pstate.c:1055:6: error: variable 'epp' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
        if (cpudata->epp_policy == cpudata->policy)
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/cpufreq/amd-pstate.c:1080:30: note: uninitialized use occurs here
        amd_pstate_set_epp(cpudata, epp);
                                    ^~~

All three are trivial to fix, but most likely there are additional bugs
in this function when the error handling was not really tested.

Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cpufreq/amd-pstate.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 168a28bed6ee..847f5f31396d 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -940,7 +940,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
 	struct amd_cpudata *cpudata;
 	struct device *dev;
-	int rc;
 	u64 value;
 
 	/*
@@ -950,7 +949,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	amd_perf_ctl_reset(policy->cpu);
 	dev = get_cpu_device(policy->cpu);
 	if (!dev)
-		goto free_cpudata1;
+		return -ENODEV;
 
 	cpudata = kzalloc(sizeof(*cpudata), GFP_KERNEL);
 	if (!cpudata)
@@ -959,8 +958,8 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	cpudata->cpu = policy->cpu;
 	cpudata->epp_policy = 0;
 
-	rc = amd_pstate_init_perf(cpudata);
-	if (rc)
+	ret = amd_pstate_init_perf(cpudata);
+	if (ret)
 		goto free_cpudata1;
 
 	min_freq = amd_get_min_freq(cpudata);
@@ -1076,9 +1075,9 @@ static void amd_pstate_epp_init(unsigned int cpu)
 		value |= (u64)epp << 24;
 	}
 
+	amd_pstate_set_epp(cpudata, epp);
 skip_epp:
 	WRITE_ONCE(cpudata->cppc_req_cached, value);
-	amd_pstate_set_epp(cpudata, epp);
 	cpufreq_cpu_put(policy);
 }
 
-- 
2.39.1

