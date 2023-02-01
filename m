Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3EE686E0A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 19:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjBASfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 13:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjBASf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 13:35:27 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813687EFC6;
        Wed,  1 Feb 2023 10:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675276523; x=1706812523;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oK6DUUze8znvc+KrQs5W1o6mGwQxnAuOtIKrU9lTeS8=;
  b=LO7jJ6mPy0mwyaL7c/Z7dbQ01K+tIG3dqMY3htxU7kqi0Gi/oXqbYsoe
   zLNQcxPWzspE4bHSFdEisrXQx6LKMFV1qNYh83YaZksEUMa3xTSQzPEQO
   Pg1//XHmaNL1mOeoSami5gxUcKSvOI+27alMIJ7eZtoH1TPQpPBhoeycO
   bOJKVf1USIZwyCAouV/b5zT5vCWj6gk3DRQpBGGbH7oJNF5moqwV22hXj
   yucise1ENuewyJvSlZ5VC9/MmncNuELzv63aDd9129B7G8HIpJwRTJgGF
   4yZdUd0sNBqP4LxbngmIFxvQEDjaj5Bb2unM+yBcyUOAgPwmxE1REksh7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="414440439"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="414440439"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 10:28:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="667014254"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="667014254"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga007.fm.intel.com with ESMTP; 01 Feb 2023 10:28:56 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v5 1/4] powercap: idle_inject: Export symbols
Date:   Wed,  1 Feb 2023 10:28:51 -0800
Message-Id: <20230201182854.2158535-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230201182854.2158535-1-srinivas.pandruvada@linux.intel.com>
References: <20230201182854.2158535-1-srinivas.pandruvada@linux.intel.com>
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

Export symbols for external interfaces, so that they can be used in
other loadable modules.

Export is done under name space IDLE_INJECT.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2/v3/v4/v5:
	No change

 drivers/powercap/idle_inject.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index c03b5402c03b..ec02b370ec16 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -162,6 +162,7 @@ void idle_inject_set_duration(struct idle_inject_device *ii_dev,
 	if (!run_duration_us)
 		pr_debug("CPU is forced to 100 percent idle\n");
 }
+EXPORT_SYMBOL_NS_GPL(idle_inject_set_duration, IDLE_INJECT);
 
 /**
  * idle_inject_get_duration - idle and run duration retrieval helper
@@ -176,6 +177,7 @@ void idle_inject_get_duration(struct idle_inject_device *ii_dev,
 	*run_duration_us = READ_ONCE(ii_dev->run_duration_us);
 	*idle_duration_us = READ_ONCE(ii_dev->idle_duration_us);
 }
+EXPORT_SYMBOL_NS_GPL(idle_inject_get_duration, IDLE_INJECT);
 
 /**
  * idle_inject_set_latency - set the maximum latency allowed
@@ -187,6 +189,7 @@ void idle_inject_set_latency(struct idle_inject_device *ii_dev,
 {
 	WRITE_ONCE(ii_dev->latency_us, latency_us);
 }
+EXPORT_SYMBOL_NS_GPL(idle_inject_set_latency, IDLE_INJECT);
 
 /**
  * idle_inject_start - start idle injections
@@ -218,6 +221,7 @@ int idle_inject_start(struct idle_inject_device *ii_dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(idle_inject_start, IDLE_INJECT);
 
 /**
  * idle_inject_stop - stops idle injections
@@ -264,6 +268,7 @@ void idle_inject_stop(struct idle_inject_device *ii_dev)
 
 	cpu_hotplug_enable();
 }
+EXPORT_SYMBOL_NS_GPL(idle_inject_stop, IDLE_INJECT);
 
 /**
  * idle_inject_setup - prepare the current task for idle injection
@@ -339,6 +344,7 @@ struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
 
 	return NULL;
 }
+EXPORT_SYMBOL_NS_GPL(idle_inject_register, IDLE_INJECT);
 
 /**
  * idle_inject_unregister - unregister idle injection control device
@@ -359,6 +365,7 @@ void idle_inject_unregister(struct idle_inject_device *ii_dev)
 
 	kfree(ii_dev);
 }
+EXPORT_SYMBOL_NS_GPL(idle_inject_unregister, IDLE_INJECT);
 
 static struct smp_hotplug_thread idle_inject_threads = {
 	.store = &idle_inject_thread.tsk,
-- 
2.39.1

