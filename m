Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F3B647B87
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 02:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiLIBhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 20:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiLIBhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 20:37:04 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B7ADFDA;
        Thu,  8 Dec 2022 17:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670549823; x=1702085823;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ou+Pci1A5/SKXDxd7i9D/7kkMito0Sj0JDnAViwJchc=;
  b=RsX1UQdk88ppYUqfLOw6I6clGB6ExxK46/WITwBvglF1VqnFY+0PjYH7
   w5qiOgZZpz30IuJostuJlQWjZ8kQVjeW+s7hMdZDPQvBis0hkAXHjI0pu
   mFa5XsAHXlQXcwUiPASBxHrXiOFja6gNMOUBDQbnjpeoZms9WyWbOvhK1
   dNt4pPl5EKKbF5GHf1Yh/DO1chhbL32bV1d4G7DWVkigiUo+nGLNTQi0n
   nu/Y98NQw/WAcuINRsW3gzWeGILukvBXp1Uh20GwGtmtvKcxNPPsxQFcE
   gcx6Hc73VmiQKMiM8q8fcqwGk30DGgvLEkOVf2GzhHWL9+/ufhfIcdvgq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="344389774"
X-IronPort-AV: E=Sophos;i="5.96,228,1665471600"; 
   d="scan'208";a="344389774"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 17:37:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="821568200"
X-IronPort-AV: E=Sophos;i="5.96,228,1665471600"; 
   d="scan'208";a="821568200"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga005.jf.intel.com with ESMTP; 08 Dec 2022 17:37:02 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC][PATCH] thermal/idle_inject: Support 100% idle injection
Date:   Thu,  8 Dec 2022 17:36:40 -0800
Message-Id: <20221209013640.943210-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
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
idle_inject_set_duration().

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/powercap/idle_inject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index f48e71501429..4a4fe60d2563 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -184,7 +184,7 @@ void idle_inject_set_duration(struct idle_inject_device *ii_dev,
 			      unsigned int run_duration_us,
 			      unsigned int idle_duration_us)
 {
-	if (run_duration_us && idle_duration_us) {
+	if (run_duration_us + idle_duration_us) {
 		WRITE_ONCE(ii_dev->run_duration_us, run_duration_us);
 		WRITE_ONCE(ii_dev->idle_duration_us, idle_duration_us);
 	}
-- 
2.37.2

