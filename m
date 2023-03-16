Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39CB6BD41C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjCPPlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjCPPlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:41:12 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CABE1924;
        Thu, 16 Mar 2023 08:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678981232; x=1710517232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a5MNbpYbKfb3nVRQzqabf7Y+DsBQlBga7mJL/qjGgpg=;
  b=CbzBLRk84kM6nTeUFanvGHU7pI9Fw7/ULYjsBf2aSPA+yorIAKh0jd3x
   aly//T0BQErvMyggk9NJWQMNLSqbcWdhYdrAVQMHJhwfrCtHSk16b6mCJ
   Vhb7r27yv3niStH9daExTFqZx1vZ5Q2yC1Cc9g8cbevgYE9ZRWvJ9qfxl
   dpagcfcCXilAVwTLlttTCZjtV2B0evcQRHztjQY47f1QkpIaNaj1IDSbN
   +6q44qCGPh4syEkPEYUvICaYNTMFsXjOVZIERKfG9w63NFuYT8e5zWiJo
   gyw7ykdtSRSuKhFESHp2E7R8Kkia009CQNYcRJJiGP6hgjbDe6haYNZqC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="339570953"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="339570953"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 08:38:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="1009266968"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="1009266968"
Received: from feiwang3-mobl2.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.249.170.93])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 08:38:52 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, srinivas.pandruvada@intel.com
Subject: [PATCH 02/15] powercap/intel_rapl: Allow probing without CPUID match
Date:   Thu, 16 Mar 2023 23:38:28 +0800
Message-Id: <20230316153841.3666-3-rui.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230316153841.3666-1-rui.zhang@intel.com>
References: <20230316153841.3666-1-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, CPU model checks is used to
1. get proper rapl_defaults callbacks for RAPL MSR/MMIO Interface.
2. create a platform device node for the intel_rapl_msr driver to probe.

Both of these are only mandatory for the RAPL MSR/MMIO Interface.

Make the CPUID match optional.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 35 +++++++++++-----------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 8970c7b80884..2d2c15eea8eb 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1528,32 +1528,25 @@ static int __init rapl_init(void)
 	int ret;
 
 	id = x86_match_cpu(rapl_ids);
-	if (!id) {
-		pr_err("driver does not support CPU family %d model %d\n",
-		       boot_cpu_data.x86, boot_cpu_data.x86_model);
+	if (id) {
+		rapl_defaults = (struct rapl_defaults *)id->driver_data;
 
-		return -ENODEV;
-	}
-
-	rapl_defaults = (struct rapl_defaults *)id->driver_data;
-
-	ret = register_pm_notifier(&rapl_pm_notifier);
-	if (ret)
-		return ret;
+		rapl_msr_platdev = platform_device_alloc("intel_rapl_msr", 0);
+		if (!rapl_msr_platdev)
+			return -ENOMEM;
 
-	rapl_msr_platdev = platform_device_alloc("intel_rapl_msr", 0);
-	if (!rapl_msr_platdev) {
-		ret = -ENOMEM;
-		goto end;
+		ret = platform_device_add(rapl_msr_platdev);
+		if (ret) {
+			platform_device_put(rapl_msr_platdev);
+			return ret;
+		}
 	}
 
-	ret = platform_device_add(rapl_msr_platdev);
-	if (ret)
+	ret = register_pm_notifier(&rapl_pm_notifier);
+	if (ret && rapl_msr_platdev) {
+		platform_device_del(rapl_msr_platdev);
 		platform_device_put(rapl_msr_platdev);
-
-end:
-	if (ret)
-		unregister_pm_notifier(&rapl_pm_notifier);
+	}
 
 	return ret;
 }
-- 
2.25.1

