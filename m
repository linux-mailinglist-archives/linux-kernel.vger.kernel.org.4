Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368CA7358A4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjFSNcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjFSNcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:32:52 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FB7101;
        Mon, 19 Jun 2023 06:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687181571; x=1718717571;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iFF5DN6oG5LxHqftmodvyVCWe0fRqJT8Cy4sLlEHdrc=;
  b=HKmlcFLm0GzMRuFpJ/bpByHDN3Ry0OGrGPlsaBPV0+D/vAN+srMrsh/B
   cIf71UiJpTHZxDe3iFDeLHeNoWTMRQIPjxbW6Y1OHrH9/k9PKpB7OZ/xN
   u3pJcXXCNLZ/pxFqFOqlwzrMedhgSi4AZ9n3liEXd/ph6TRcr+GLQtdri
   qw2U7sDXejwgidH0dJo3CjXvTKmWz7bvwHmMEGPCsUrz9jmB0xi4985ED
   9rEaGNNwfpIwFyGgxrMqE7enPh4VJFLWEabT1GRqSigHbIVkuI65mXNWf
   rlAXjGTiC1HsPQwJVNEzafW1dct3VmVc6lVsWhk+NK85x7HJD+IOmZ5rQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="388692012"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="388692012"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 06:32:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="743464098"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="743464098"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 19 Jun 2023 06:32:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E4F6E40F; Mon, 19 Jun 2023 16:32:58 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Subject: [PATCH v1 1/1] hwmon: (nct6775) Fix use of undefined variable
Date:   Mon, 19 Jun 2023 16:32:57 +0300
Message-Id: <20230619133257.57569-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's unknown how, but in one place in the code the undefined variable
is still in use. Replace it with the respective bitmap API call.

Fixes: d7f4737c37b5 ("hwmon: (nct6775) Switch to use bitmap type and APIs")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwmon/nct6775-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/nct6775-core.c b/drivers/hwmon/nct6775-core.c
index a334fcf9406d..56aa68875c42 100644
--- a/drivers/hwmon/nct6775-core.c
+++ b/drivers/hwmon/nct6775-core.c
@@ -3829,7 +3829,7 @@ int nct6775_probe(struct device *dev, struct nct6775_data *data,
 	case nct6797:
 	case nct6798:
 	case nct6799:
-		data->in_num = 15;
+		bitmap_set(data->have_in, 0, 15);
 		data->pwm_num = (data->kind == nct6796 ||
 				 data->kind == nct6797 ||
 				 data->kind == nct6798 ||
-- 
2.40.0.1.gaa8946217a0b

