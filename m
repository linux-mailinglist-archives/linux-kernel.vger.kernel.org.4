Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EC467EF79
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 21:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjA0UVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 15:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbjA0UVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 15:21:01 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850F077537;
        Fri, 27 Jan 2023 12:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674850859; x=1706386859;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/O70WEfgi8r2v8zGP89oVB7lVpD2sIvrsqQ6kxAoIH4=;
  b=YQniGedVZT7Sk5l16EPcQNgNVMgLqwVuOCRFSVqCcSDIlwXrRY1zoUtF
   RjycdSBa2Zd2sxZidWXURLnssoG7NHACaD4srRp9M05mV2jlIZAoTV/QM
   UjgYdD9vttJA+Ot/SA2YF26pUd6vNhHey4MH9Obv+T0xzt9QS9kteAW5S
   bjsuLeuqZg7VZPAsIEA0SowW2iSYPdgmz6WJ1W07VriSGFgbMsejOuvpR
   6ONPdbv6ZEVjn34SRA7CuMitHYtJpldhO2rwTrixtZK78xqME95KPTSzf
   yvw2Ssz8/RlnlfgHbrBwh6bKPlYUSy8PEXS8bR5pfrYqvYfJeVKDVPpsi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="310804597"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="310804597"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 12:20:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="693840013"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="693840013"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga008.jf.intel.com with ESMTP; 27 Jan 2023 12:20:56 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 1/3] powercap: idle_inject: Export symbols
Date:   Fri, 27 Jan 2023 12:20:46 -0800
Message-Id: <20230127202048.992504-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230127202048.992504-1-srinivas.pandruvada@linux.intel.com>
References: <20230127202048.992504-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export symbols for external interfaces, so that they can be used in
other loadable modules.

Export is done under name space IDLE_INJECT.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2/v3/v4:
	No change

 drivers/powercap/idle_inject.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index 21f7cd7d159b..a7aed680b54f 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -163,6 +163,7 @@ void idle_inject_set_duration(struct idle_inject_device *ii_dev,
 	if (!run_duration_us)
 		pr_debug("CPU is forced to 100 percent idle\n");
 }
+EXPORT_SYMBOL_NS_GPL(idle_inject_set_duration, IDLE_INJECT);
 
 /**
  * idle_inject_get_duration - idle and run duration retrieval helper
@@ -177,6 +178,7 @@ void idle_inject_get_duration(struct idle_inject_device *ii_dev,
 	*run_duration_us = READ_ONCE(ii_dev->run_duration_us);
 	*idle_duration_us = READ_ONCE(ii_dev->idle_duration_us);
 }
+EXPORT_SYMBOL_NS_GPL(idle_inject_get_duration, IDLE_INJECT);
 
 /**
  * idle_inject_set_latency - set the maximum latency allowed
@@ -188,6 +190,7 @@ void idle_inject_set_latency(struct idle_inject_device *ii_dev,
 {
 	WRITE_ONCE(ii_dev->latency_us, latency_us);
 }
+EXPORT_SYMBOL_NS_GPL(idle_inject_set_latency, IDLE_INJECT);
 
 /**
  * idle_inject_start - start idle injections
@@ -219,6 +222,7 @@ int idle_inject_start(struct idle_inject_device *ii_dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(idle_inject_start, IDLE_INJECT);
 
 /**
  * idle_inject_stop - stops idle injections
@@ -265,6 +269,7 @@ void idle_inject_stop(struct idle_inject_device *ii_dev)
 
 	cpu_hotplug_enable();
 }
+EXPORT_SYMBOL_NS_GPL(idle_inject_stop, IDLE_INJECT);
 
 /**
  * idle_inject_setup - prepare the current task for idle injection
@@ -340,6 +345,7 @@ struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
 
 	return NULL;
 }
+EXPORT_SYMBOL_NS_GPL(idle_inject_register, IDLE_INJECT);
 
 /**
  * idle_inject_unregister - unregister idle injection control device
@@ -360,6 +366,7 @@ void idle_inject_unregister(struct idle_inject_device *ii_dev)
 
 	kfree(ii_dev);
 }
+EXPORT_SYMBOL_NS_GPL(idle_inject_unregister, IDLE_INJECT);
 
 static struct smp_hotplug_thread idle_inject_threads = {
 	.store = &idle_inject_thread.tsk,
-- 
2.37.2

