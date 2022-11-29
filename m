Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4208563CBF0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 00:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiK2Xem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 18:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiK2Xeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 18:34:36 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3678CF020;
        Tue, 29 Nov 2022 15:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669764876; x=1701300876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z2p0ZEt70m3lASgdlGcNqNlgamI3K0iU68fdPui8BqQ=;
  b=F54it81DKS6gQC3b9YRtjxWg/ifh5hBhGWupmXTUjZtKFVhSqmQ+uRgX
   RZOP2sU/0m5AZdOuFkyE/6dxrXBZbCYci3WZKup8mL+wzcMpaQWNrmbiM
   Ix2PTOaWJFXJGTM2zQKH6ZvyUOP+9utWAhmckWSLQs3C7lGCcoQigC6Uj
   cCVGF3566Z57pA+UjnAG3j2TpdFXM3deHTsJ/1gsWebv9jbYHJq+1r3Ax
   wGh5FGTGFlJ430NpVUBPQo02rY1fz96h/hWko1FQYTuFnXvppjGbj5twF
   FAu5tQTJ+zI4Kta1A++b2geIITMXHJx3QL5lMJT4ivTv8siSBOYh+eyhk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="342178167"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="342178167"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 15:34:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="768617600"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="768617600"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga004.jf.intel.com with ESMTP; 29 Nov 2022 15:34:35 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, amitk@kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 1/4] powercap: idle_inject: Export symbols
Date:   Tue, 29 Nov 2022 15:34:16 -0800
Message-Id: <20221129233419.4022830-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221129233419.4022830-1-srinivas.pandruvada@linux.intel.com>
References: <20221129233419.4022830-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
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
v2:
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

