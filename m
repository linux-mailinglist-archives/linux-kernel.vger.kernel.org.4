Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003D86E7141
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 04:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjDSCol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 22:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjDSCoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 22:44:38 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299826E8A;
        Tue, 18 Apr 2023 19:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681872277; x=1713408277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uZwJ0c3//1MoH6bx9XUFeOpEKZ8dn5klZ0L1TOTZauI=;
  b=N1cm6iM9QodSkEEP20aiJ8dllO8kRUiObkAZBQg5AiThA15bKXo/GAKI
   2vYfCFZrvd9RLjdHU60GuNp7JuLhuCqcFat8Jq/AhM//JdgGBEIcISdtn
   NnhfLFYKPpEtVwINWvMazlws8ZTK9s7pDEzf7hmzMWdZpRAH43f+r800s
   sjzsKFGRvPOtkG0fQMKTxP74DpuoWomXVM1xXb5Jl7CEwZCMzo09KRcKz
   SbzjF50o3xTQiOcqcx+Ogi96eH+I5UItw6cArPZi/H0psMpDvm9tvjinz
   YefYhNbrVTnrKHQFvrth4FYIdTGAzRmr9sr1Cm+k7wAGELoCKMVXX+KJZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="373215278"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="373215278"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 19:44:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="937478010"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="937478010"
Received: from hanboyu-mobl.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.255.29.76])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 19:44:35 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, srinivas.pandruvada@intel.com
Subject: [PATCH v2 02/15] powercap/intel_rapl: Allow probing without CPUID match
Date:   Wed, 19 Apr 2023 10:44:06 +0800
Message-Id: <20230419024419.324436-3-rui.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230419024419.324436-1-rui.zhang@intel.com>
References: <20230419024419.324436-1-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
Tested-by: Wang Wendy <wendy.wang@intel.com>
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

