Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD7F62072A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 04:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbiKHDET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 22:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbiKHDEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 22:04:08 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E2A2FFDD;
        Mon,  7 Nov 2022 19:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667876647; x=1699412647;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gx12/V9+4eqZkr9V3cg1u7gq6FKczYaDMmSB1jBBM2g=;
  b=DCqoVApWPnv0VFbwOFvUvH+LyoSMY+jwmsJLdy9FNkO7EFcgv/0d/Zgj
   XEY7Wa6gazQhh6o6cz1llWHKPMmmZHA2CRy1VtbttqoVKDp2NpnZFkgR9
   8PP9u6783wNCKCcBEE7N/ble4w1C3UK/4b/mMwlB7FBF8BY7pFBRYAU3F
   L/XuOKz+5y25sRNbifJYdwTU7M+JGNCiesCQhjkLHGx30eDlosqjHxqRt
   egYfHIT1ESaVbJpicg4e5Vc1LRjj1TLVu/tc2vj/n5YPl02ofprGubyRS
   P/iq9ubX4tNpAkkiKfEWAJCmgJNX29y8ehk7oPOwwDDYW3cbsH+egHowt
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="337310747"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="337310747"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 19:04:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="638612673"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="638612673"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga007.fm.intel.com with ESMTP; 07 Nov 2022 19:04:06 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rui.zhang@intel.com, rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/4] powercap: idle_inject: Export symbols
Date:   Mon,  7 Nov 2022 19:03:39 -0800
Message-Id: <20221108030342.1127216-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221108030342.1127216-1-srinivas.pandruvada@linux.intel.com>
References: <20221108030342.1127216-1-srinivas.pandruvada@linux.intel.com>
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
 drivers/powercap/idle_inject.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index 999e218d7793..e73885bd9065 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -159,6 +159,7 @@ void idle_inject_set_duration(struct idle_inject_device *ii_dev,
 		WRITE_ONCE(ii_dev->idle_duration_us, idle_duration_us);
 	}
 }
+EXPORT_SYMBOL_NS_GPL(idle_inject_set_duration, IDLE_INJECT);
 
 /**
  * idle_inject_get_duration - idle and run duration retrieval helper
@@ -172,6 +173,7 @@ void idle_inject_get_duration(struct idle_inject_device *ii_dev,
 	*run_duration_us = READ_ONCE(ii_dev->run_duration_us);
 	*idle_duration_us = READ_ONCE(ii_dev->idle_duration_us);
 }
+EXPORT_SYMBOL_NS_GPL(idle_inject_get_duration, IDLE_INJECT);
 
 /**
  * idle_inject_set_latency - set the maximum latency allowed
@@ -182,6 +184,7 @@ void idle_inject_set_latency(struct idle_inject_device *ii_dev,
 {
 	WRITE_ONCE(ii_dev->latency_us, latency_us);
 }
+EXPORT_SYMBOL_NS_GPL(idle_inject_set_latency, IDLE_INJECT);
 
 /**
  * idle_inject_start - start idle injections
@@ -213,6 +216,7 @@ int idle_inject_start(struct idle_inject_device *ii_dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(idle_inject_start, IDLE_INJECT);
 
 /**
  * idle_inject_stop - stops idle injections
@@ -259,6 +263,7 @@ void idle_inject_stop(struct idle_inject_device *ii_dev)
 
 	cpu_hotplug_enable();
 }
+EXPORT_SYMBOL_NS_GPL(idle_inject_stop, IDLE_INJECT);
 
 /**
  * idle_inject_setup - prepare the current task for idle injection
@@ -334,6 +339,7 @@ struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
 
 	return NULL;
 }
+EXPORT_SYMBOL_NS_GPL(idle_inject_register, IDLE_INJECT);
 
 /**
  * idle_inject_unregister - unregister idle injection control device
@@ -354,6 +360,7 @@ void idle_inject_unregister(struct idle_inject_device *ii_dev)
 
 	kfree(ii_dev);
 }
+EXPORT_SYMBOL_NS_GPL(idle_inject_unregister, IDLE_INJECT);
 
 static struct smp_hotplug_thread idle_inject_threads = {
 	.store = &idle_inject_thread.tsk,
-- 
2.37.3

