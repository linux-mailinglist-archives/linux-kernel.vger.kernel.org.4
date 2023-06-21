Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858CC737BCB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 09:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjFUG7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjFUG67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:58:59 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A41DD;
        Tue, 20 Jun 2023 23:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687330738; x=1718866738;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CJK1itE83jES6hQvMEqU9du+Ljig8LcS2pjooxNuxPc=;
  b=AScVIKc0RW/1RJX5jAEXpCR597hfqecElAxUIH9bt0DNkMe6yFbmhldz
   NByC8P1AxbFy0dyoueFaudwfeE+RqOt4uDbWwNNxubPgBO4nocdvN4s9I
   izH5+BZHBGd+RoADKk+axzXGlYG9eB8EKhvu9oJPxsuDXXJ6xcSh5PPvS
   D9IIUCRsnqoa0dciOSFOWRzaI9HAo/9rQQN23n2Qfo3SEFUl9SAVN9Joe
   bXwrl+v7FJJso4vO0a3WJtNI0UIyM9Kuuf77ELlA3XH3yS6n9yKkgeanY
   zCGQBDH9l6yNiX3THDdNS16QDfddxqR1U7a1scg3SXZNr96B2Wzo2C62X
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="357583451"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="357583451"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 23:58:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="717513671"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="717513671"
Received: from kleszczy-mobl.ger.corp.intel.com (HELO tkristo-desk.bb.dnainternet.fi) ([10.252.62.64])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 23:58:41 -0700
From:   Tero Kristo <tero.kristo@linux.intel.com>
To:     rafael@kernel.org, viresh.kumar@linaro.org
Cc:     srinivas.pandruvada@linux.intel.com, lenb@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas Neronin <niklas.neronin@intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Fix energy_performance_preference for passive
Date:   Wed, 21 Jun 2023 09:58:39 +0300
Message-Id: <20230621065839.635809-1-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the intel_pstate driver is set to passive mode, then writing the
same value to the energy_performance_preference sysfs twice will fail.
This is caused by the wrong return value used (index of the matched
energy_perf_string), instead of the length of the passed in parameter.
Fix by forcing the internal return value to zero when the same
preference is passed in by user. This same issue is not present when
active mode is used for the driver.

Fixes: f6ebbcf08f37 ("cpufreq: intel_pstate: Implement passive mode with HWP enabled")
Reported-by: Niklas Neronin <niklas.neronin@intel.com>
Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 2548ec92faa2..f29182512b98 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -824,6 +824,8 @@ static ssize_t store_energy_performance_preference(
 			err = cpufreq_start_governor(policy);
 			if (!ret)
 				ret = err;
+		} else {
+			ret = 0;
 		}
 	}
 
-- 
2.25.1

