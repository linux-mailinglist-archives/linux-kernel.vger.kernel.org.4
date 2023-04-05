Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838B56D81D5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238732AbjDEP2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238179AbjDEP2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:28:34 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B0B40DA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 08:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680708512; x=1712244512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yHr3YfcH0isSmBGhveOFvMlA78zsK4oy4JPk9GZ0c+o=;
  b=kahV4+PdJT+XinlAM/aR4gsAUHl3SOgcGhanmK8/OvJoqHrHPyK1Wx2I
   6Y8MEpTVuXsABRQlh8K+1glL9VkqYWx9vYG77u9XCztCJ8jUOZRV1DGGr
   7DjWErKukjLpifco1EXuIrcXZTbwSsc/gqiFW5ditlkZlxAxUzkTHgJSS
   AHPOHM+1bJgesKyeyvZ8rfYYkuZR91CBI1Z4IFyue9mLr0hE8nQBgZS5q
   9eJrSBCiA12+cwm5wrxnBNoFSPoAjpwZBK97OiV/5VFIjvKSwZtOLTH0N
   kuzOsLRIM6UOL311DICFVMC1zOkYz8umLDxvwrzp7NQqDAW1kVrSFvBE5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="345064768"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="345064768"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 08:27:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="756028427"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="756028427"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 05 Apr 2023 08:27:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B9AF24F1; Wed,  5 Apr 2023 18:27:52 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Bumwoo Lee <bw365.lee@samsung.com>
Subject: [PATCH v2 4/5] extcon: Use sizeof(*pointer) instead of sizeof(type)
Date:   Wed,  5 Apr 2023 18:27:44 +0300
Message-Id: <20230405152745.24959-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230405152745.24959-1-andriy.shevchenko@linux.intel.com>
References: <20230405152745.24959-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use sizeof(*pointer) instead of sizeof(type).
The type of the variable can change and one needs not change
the former (unlike the latter). No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Bumwoo Lee <bw365.lee@samsung.com>
---
 drivers/extcon/extcon.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index daaded92cf80..50c5fd454488 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1098,8 +1098,7 @@ static int extcon_alloc_cables(struct extcon_dev *edev)
 	if (!edev->max_supported)
 		return 0;
 
-	edev->cables = kcalloc(edev->max_supported,
-			       sizeof(struct extcon_cable),
+	edev->cables = kcalloc(edev->max_supported, sizeof(*edev->cables),
 			       GFP_KERNEL);
 	if (!edev->cables)
 		return -ENOMEM;
@@ -1161,14 +1160,12 @@ static int extcon_alloc_muex(struct extcon_dev *edev)
 	for (index = 0; edev->mutually_exclusive[index]; index++)
 		;
 
-	edev->attrs_muex = kcalloc(index + 1,
-				   sizeof(struct attribute *),
+	edev->attrs_muex = kcalloc(index + 1, sizeof(*edev->attrs_muex),
 				   GFP_KERNEL);
 	if (!edev->attrs_muex)
 		return -ENOMEM;
 
-	edev->d_attrs_muex = kcalloc(index,
-				     sizeof(struct device_attribute),
+	edev->d_attrs_muex = kcalloc(index, sizeof(*edev->d_attrs_muex),
 				     GFP_KERNEL);
 	if (!edev->d_attrs_muex) {
 		kfree(edev->attrs_muex);
@@ -1214,8 +1211,8 @@ static int extcon_alloc_groups(struct extcon_dev *edev)
 		return 0;
 
 	edev->extcon_dev_type.groups = kcalloc(edev->max_supported + 2,
-			sizeof(struct attribute_group *),
-			GFP_KERNEL);
+					  sizeof(*edev->extcon_dev_type.groups),
+					  GFP_KERNEL);
 	if (!edev->extcon_dev_type.groups)
 		return -ENOMEM;
 
@@ -1293,7 +1290,7 @@ int extcon_dev_register(struct extcon_dev *edev)
 	spin_lock_init(&edev->lock);
 	if (edev->max_supported) {
 		edev->nh = kcalloc(edev->max_supported, sizeof(*edev->nh),
-				GFP_KERNEL);
+				   GFP_KERNEL);
 		if (!edev->nh) {
 			ret = -ENOMEM;
 			goto err_alloc_nh;
-- 
2.40.0.1.gaa8946217a0b

