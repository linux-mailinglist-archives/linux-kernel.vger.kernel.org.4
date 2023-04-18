Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901006E685C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjDRPgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjDRPgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:36:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1082B13F8E;
        Tue, 18 Apr 2023 08:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681832132; x=1713368132;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KfZPAkII450y6QsFRR+Dzs+dcuCUvr+EmFqzc6LmyAs=;
  b=G2op57fsXGyCIaYiFsNDSI9CJ+rH29bpeP3Ey5F3UM4+Z0qn/kC2baHz
   2PTdndY5+humSIFYHGXvp2XhsC8YBpm2E17aN9ThvGCjoliHFfEyKxwHE
   bmnn+DzGitCqRO0zGal8Pd9QWXSAq4n/mt15Sz7mas32WDPXb96g97CSe
   8ur2gCD4XiJUtvwf+nMYO/Vy0akAS0NmHqS4FLGwN3gwp+jyBa9cc/Y/r
   jcfryV5uNTOflhyhLLp0aCPeTPAb/sDfKOZKc5EyIQObF7gwrA2xQ9hLt
   ojbgttJ2hQBFnWlHmMf4Y3xSikuFoTHyCl7wcs1crcaSD6vTuVa8QhtZn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="324824948"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="324824948"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 08:32:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="691151956"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="691151956"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga002.jf.intel.com with ESMTP; 18 Apr 2023 08:32:32 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Wendy Wang <wendy.wang@intel.com>
Subject: [PATCH] platform/x86/intel-uncore-freq: Return error on write frequency
Date:   Tue, 18 Apr 2023 08:32:30 -0700
Message-Id: <20230418153230.679094-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when the uncore_write() returns error, it is silently
ignored. Return error to user space when uncore_write() fails.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wendy Wang <wendy.wang@intel.com>
---
This patch has no dependency on TPMI patches for uncore support.

 .../x86/intel/uncore-frequency/uncore-frequency-common.c    | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
index cb24de9e97dc..fa8f14c925ec 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
@@ -44,14 +44,18 @@ static ssize_t store_min_max_freq_khz(struct uncore_data *data,
 				      int min_max)
 {
 	unsigned int input;
+	int ret;
 
 	if (kstrtouint(buf, 10, &input))
 		return -EINVAL;
 
 	mutex_lock(&uncore_lock);
-	uncore_write(data, input, min_max);
+	ret = uncore_write(data, input, min_max);
 	mutex_unlock(&uncore_lock);
 
+	if (ret)
+		return ret;
+
 	return count;
 }
 
-- 
2.38.1

