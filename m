Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F845F873F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 21:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJHTwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 15:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJHTw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 15:52:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0302362E0;
        Sat,  8 Oct 2022 12:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665258748; x=1696794748;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x0t3mgqFmD0TBYTipEEEJTaiO743Vf6OovrpWoPE5XA=;
  b=PcGycwpMSsQNFHUceMYjuDD4xo9yrCklNdO8waYCCQh9j53jmgiULIM8
   Z9oUIwb2UZzqOwX4s/cdFWoKY5RuXeKDmPuX9bKcSj0hJFPrLBju4qqUr
   B/pQVhvgUowXj1O5Evn6UXjBl/mlRaVhsFZTNNeDiTZFxbX/IMmHg5kRN
   BEbenUvt+1XJZgq6oZyp3Zv+a90y3Vdx5+2zuDhDB56Be0wcYZiVKSdIJ
   83mCmRW1Cr/pv4hrL9ipSm6nsaKjZNzisaNOsVM0830qTRUTI0rmGtY6h
   FHDeFl33a0eqCUnVEo/GZndl8xM2gb6b/zd80d7TMVlz0ohYNxrobvCCT
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10494"; a="302703669"
X-IronPort-AV: E=Sophos;i="5.95,170,1661842800"; 
   d="scan'208";a="302703669"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2022 12:52:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10494"; a="658721264"
X-IronPort-AV: E=Sophos;i="5.95,170,1661842800"; 
   d="scan'208";a="658721264"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 08 Oct 2022 12:52:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CF2E5D0; Sat,  8 Oct 2022 22:52:45 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH v1 1/1] cpufreq: ACPI: Use str_enabled_disabled() helper
Date:   Sat,  8 Oct 2022 22:52:44 +0300
Message-Id: <20221008195244.53813-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use str_enabled_disabled() helper instead of open coding the same.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 1bb2b90ebb21..8597ab0a84b5 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -19,6 +19,7 @@
 #include <linux/compiler.h>
 #include <linux/dmi.h>
 #include <linux/slab.h>
+#include <linux/string_helpers.h>
 
 #include <linux/acpi.h>
 #include <linux/io.h>
@@ -135,8 +136,8 @@ static int set_boost(struct cpufreq_policy *policy, int val)
 {
 	on_each_cpu_mask(policy->cpus, boost_set_msr_each,
 			 (void *)(long)val, 1);
-	pr_debug("CPU %*pbl: Core Boosting %sabled.\n",
-		 cpumask_pr_args(policy->cpus), val ? "en" : "dis");
+	pr_debug("CPU %*pbl: Core Boosting %s.\n",
+		 cpumask_pr_args(policy->cpus), str_enabled_disabled(val));
 
 	return 0;
 }
-- 
2.35.1

