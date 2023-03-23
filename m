Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B66F6C7028
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 19:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjCWS0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 14:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjCWS0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 14:26:00 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C104B21A1E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 11:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679595959; x=1711131959;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PYlgK/auf6S13xZ9xgnXhcn/6W9A7pV84R6rW1hh8CE=;
  b=is759ehmJHDA/cG1Omp5PckXmYheoIRXJ36YI8+aBW10FL5uKpBh+ulM
   7hAes6Nb53fEWkVeiP/wZlphOIRaYQTBrA07bhsk2oBVepyKAtgJyEW8I
   W3Cpb6N+f8eOgn0ieVSp4nHz4732LW7RPHAK9DF1Vpm/1oDF1CK1UUo0K
   AoQRS2HLRS6hwqJR3a4TH+edU63NIbfEK9BJvhsr6dBuyCUyjWDty33d1
   gdp8N81FXa+QekoVUmjkqmiAiwquLnNrTUJqryuYt+2o93fazXX6hcFea
   NtgKP2iXg1eZzAXkl2xq4yzAcaXmiBE2Q8I9ZDhaFQvyFIqtMNTVaDEWY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="341139999"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="341139999"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 11:25:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="928345883"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="928345883"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 23 Mar 2023 11:25:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1CDA9176; Thu, 23 Mar 2023 20:26:43 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] driver core: Add a comment to set_primary_fwnode() on nullifying
Date:   Thu, 23 Mar 2023 20:26:40 +0200
Message-Id: <20230323182640.61085-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explain what parent && fn == parent->fwnode conditional does.
With this refactor the code a bit.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index f1889b9cab45..b59692a4d809 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4982,9 +4982,13 @@ void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode)
 	} else {
 		if (fwnode_is_primary(fn)) {
 			dev->fwnode = fn->secondary;
+
+			/* Skip nullifying fn->secondary if the primary is shared */
+			if (parent && fn == parent->fwnode)
+				return;
+
 			/* Set fn->secondary = NULL, so fn remains the primary fwnode */
-			if (!(parent && fn == parent->fwnode))
-				fn->secondary = NULL;
+			fn->secondary = NULL;
 		} else {
 			dev->fwnode = NULL;
 		}
-- 
2.40.0.1.gaa8946217a0b

