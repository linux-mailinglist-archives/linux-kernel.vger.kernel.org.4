Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0754573338E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345478AbjFPO0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345434AbjFPO0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:26:13 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BC230E3;
        Fri, 16 Jun 2023 07:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686925571; x=1718461571;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jbvx+fzCk6wuoZXDOskZS3VFaadcPZdfZkhrwY1ULLc=;
  b=lPYbMMdPn16dDXSSud8doBGuw+4pB1fxXcWMrTmIYmPVIIasgccFYdRN
   W2r0LAgibmZvQ9eZar0E0RSFBn+4oipgbfXsLppaLJpzL5DPiG4EGbKrK
   krZ2nlO1UXjMxJ2mpyHRc3mQKrydzAuz6p46Eb4xBfWaElBfJbYBqIwdl
   wefvLozWVDvAgFNd3m0tKYxZ1TyiGXrz7AEp/0FYDnD/0DZAn+y0vxknq
   dT3sIiOu3Nv1wL/gGP7i/LCnblQvka8B92UDiqYKiG5GF+DKRwCZdAOqm
   S1Xvg/apXfCKdUI0ELZ9fPhbmCMwENnYZuoiTARIkESOB96Q+fPVNOvQT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="348934347"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="348934347"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 07:26:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="716043859"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="716043859"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 16 Jun 2023 07:26:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BC90E379; Fri, 16 Jun 2023 17:26:17 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] pktcdvd: Use clamp_val() instead of min()+max()
Date:   Fri, 16 Jun 2023 17:26:14 +0300
Message-Id: <20230616142614.36206-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a couple of places replace min()+max() pair by clamp_val().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/block/pktcdvd.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index a1428538bda5..18a960bb6165 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -208,14 +208,11 @@ static DEVICE_ATTR_RO(size);
 static void init_write_congestion_marks(int* lo, int* hi)
 {
 	if (*hi > 0) {
-		*hi = max(*hi, 500);
-		*hi = min(*hi, 1000000);
+		*hi = clamp_val(*hi, 500, 1000000);
 		if (*lo <= 0)
 			*lo = *hi - 100;
-		else {
-			*lo = min(*lo, *hi - 100);
-			*lo = max(*lo, 100);
-		}
+		else
+			*lo = clamp_val(*lo, 100, *hi - 100);
 	} else {
 		*hi = -1;
 		*lo = -1;
-- 
2.40.0.1.gaa8946217a0b

