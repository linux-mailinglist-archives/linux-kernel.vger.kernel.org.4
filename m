Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5662766D414
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbjAQCHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjAQCHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:07:45 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71BE1E295;
        Mon, 16 Jan 2023 18:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673921264; x=1705457264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r7skIjpac3ppa/NE5mrQpx7Ptisud6RZvpXv2fDUu3o=;
  b=V3K7aJYD7wmm8+7nC4HAKW5v9jTWaHMTtbVwFgC4/g2ru9jsHdUJ8lBb
   w98KBQzvZZQ0W+mMVzB1E5qIn6HwcvDJpH6tliUtfX5Hl0NGGygCtaiYs
   k2IsY3qj7nHllqw0mYbyQpOQpfhAGCksNFFytBCHc07Rqp14kT90HKaQk
   N5oqauqhAY01ciOj9ARImyslb4+GE3tgfTnC/MiPYn3wMAjvur7A8zcjX
   2KWsu1Ff6Au4BxT5xC6MKen4a9NoESg/stcZME24WqMferItSbYTX4uzs
   u0Jt731rGxVI0n4EAeMZcv9djn9ppkLvBClTOf5gNFmU7vYWJs+/DtzJY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="323287629"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="323287629"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 18:07:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="636703086"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="636703086"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga006.jf.intel.com with ESMTP; 16 Jan 2023 18:07:43 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, amitk@kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 1/4] powercap: idle_inject: Export symbols
Date:   Mon, 16 Jan 2023 18:07:39 -0800
Message-Id: <20230117020742.2760307-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230117020742.2760307-1-srinivas.pandruvada@linux.intel.com>
References: <20230117020742.2760307-1-srinivas.pandruvada@linux.intel.com>
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
v2/v3:
	No change

 drivers/powercap/idle_inject.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index fe86a09e3b67..dfa989182e71 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -160,6 +160,7 @@ void idle_inject_set_duration(struct idle_inject_device *ii_dev,
 		WRITE_ONCE(ii_dev->idle_duration_us, idle_duration_us);
 	}
 }
+EXPORT_SYMBOL_NS_GPL(idle_inject_set_duration, IDLE_INJECT);
 
 /**
  * idle_inject_get_duration - idle and run duration retrieval helper
@@ -174,6 +175,7 @@ void idle_inject_get_duration(struct idle_inject_device *ii_dev,
 	*run_duration_us = READ_ONCE(ii_dev->run_duration_us);
 	*idle_duration_us = READ_ONCE(ii_dev->idle_duration_us);
 }
+EXPORT_SYMBOL_NS_GPL(idle_inject_get_duration, IDLE_INJECT);
 
 /**
  * idle_inject_set_latency - set the maximum latency allowed
@@ -185,6 +187,7 @@ void idle_inject_set_latency(struct idle_inject_device *ii_dev,
 {
 	WRITE_ONCE(ii_dev->latency_us, latency_us);
 }
+EXPORT_SYMBOL_NS_GPL(idle_inject_set_latency, IDLE_INJECT);
 
 /**
  * idle_inject_start - start idle injections
@@ -216,6 +219,7 @@ int idle_inject_start(struct idle_inject_device *ii_dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(idle_inject_start, IDLE_INJECT);
 
 /**
  * idle_inject_stop - stops idle injections
@@ -262,6 +266,7 @@ void idle_inject_stop(struct idle_inject_device *ii_dev)
 
 	cpu_hotplug_enable();
 }
+EXPORT_SYMBOL_NS_GPL(idle_inject_stop, IDLE_INJECT);
 
 /**
  * idle_inject_setup - prepare the current task for idle injection
@@ -337,6 +342,7 @@ struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
 
 	return NULL;
 }
+EXPORT_SYMBOL_NS_GPL(idle_inject_register, IDLE_INJECT);
 
 /**
  * idle_inject_unregister - unregister idle injection control device
@@ -357,6 +363,7 @@ void idle_inject_unregister(struct idle_inject_device *ii_dev)
 
 	kfree(ii_dev);
 }
+EXPORT_SYMBOL_NS_GPL(idle_inject_unregister, IDLE_INJECT);
 
 static struct smp_hotplug_thread idle_inject_threads = {
 	.store = &idle_inject_thread.tsk,
-- 
2.31.1

