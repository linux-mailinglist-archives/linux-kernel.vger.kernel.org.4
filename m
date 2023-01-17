Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0411B66E69E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjAQTLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjAQTJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:09:15 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D3B37F31;
        Tue, 17 Jan 2023 10:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673979788; x=1705515788;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IlDh+Dysr/T/XY5HyMKzy4u/jUEYxfwAxA0eTJ167wQ=;
  b=AtBTZbxr9IYJgBvAgkQ0uoaHrX6gk4H+mmhAu40ivUwWTvWbrvgwxdXb
   fJjL8MY+Vl3i5WG/tOfiJ4FYAAWDYKjjjFA65vch8VlIt0OBks3UEmq1r
   drVnrQMC1EzqjoPNzXzPejj88C7fTyNQDXac1MHG3XefvANNO4MRY0YSr
   3Nf2eB599FnzsaR7ENjUrYLjADfiSOvllmxCiBDTtJ2XNnzuT3r2YYkwL
   lIcnsuELSrqV+IZFpEsXFgZQ0gTDBMYGul8o1DCybNTEsziFdwNRMjkQ4
   gLdZ8dfPmOfdWYgenC1V10zKONPnL2bw83BbWpCzl2gyRC3pLjN89QPup
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="326850252"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="326850252"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 10:22:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="748133276"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="748133276"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Jan 2023 10:22:54 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] thermal/idle_inject: Support 100% idle injection
Date:   Tue, 17 Jan 2023 10:22:40 -0800
Message-Id: <20230117182240.2817822-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
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

The users of idle injection framework allow 100% idle injection. For
example: thermal/cpuidle_cooling.c driver. When the ratio set to 100%,
the runtime_duration becomes zero.

In the function idle_inject_set_duration() in idle injection framework
run_duration_us == 0 is silently ignored, without any error (it is a
void function). So, the caller will assume that everything is fine and
100% idle is effective. But in reality the idle inject will be whatever
set before.

There are two options:
- The caller change their max state to 99% instead of 100% and
document that 100% is not supported by idle inject framework
- Support 100% idle support in idle inject framework

Since there are other protections via RT throttling, this framework can
allow 100% idle. The RT throttling will be activated at 95% idle by
default. The caller disabling RT throttling and injecting 100% idle,
should be aware that CPU can't be used at all.

The idle inject timer is started for (run_duration_us + idle_duration_us)
duration. Hence replace (run_duration_us && idle_duration_us) with
(run_duration_us + idle_duration_us) in the function
idle_inject_set_duration(). Also check for !(run_duration_us +
idle_duration_us) to return -EINVAL in the function idle_inject_start().

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
Change log:
Compared to RFC/RFT
- Add a pr_debug for 100% idle

 drivers/powercap/idle_inject.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index c57b40477246..3ac81086d71f 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -170,10 +170,12 @@ void idle_inject_set_duration(struct idle_inject_device *ii_dev,
 			      unsigned int run_duration_us,
 			      unsigned int idle_duration_us)
 {
-	if (run_duration_us && idle_duration_us) {
+	if (run_duration_us + idle_duration_us) {
 		WRITE_ONCE(ii_dev->run_duration_us, run_duration_us);
 		WRITE_ONCE(ii_dev->idle_duration_us, idle_duration_us);
 	}
+	if (!run_duration_us)
+		pr_debug("CPU is forced to 100 percent idle\n");
 }
 EXPORT_SYMBOL_NS_GPL(idle_inject_set_duration, IDLE_INJECT);
 
@@ -219,7 +221,7 @@ int idle_inject_start(struct idle_inject_device *ii_dev)
 	unsigned int idle_duration_us = READ_ONCE(ii_dev->idle_duration_us);
 	unsigned int run_duration_us = READ_ONCE(ii_dev->run_duration_us);
 
-	if (!idle_duration_us || !run_duration_us)
+	if (!(idle_duration_us + run_duration_us))
 		return -EINVAL;
 
 	pr_debug("Starting injecting idle cycles on CPUs '%*pbl'\n",
-- 
2.31.1

