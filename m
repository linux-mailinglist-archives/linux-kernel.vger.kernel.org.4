Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA926DDA04
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjDKLtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjDKLsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:48:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1772135B5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681213720; x=1712749720;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7VrN3slwc1LQogRpZmTA8V/KyyDIUcLvvghnWCubjmI=;
  b=PkeYAusFpIqhkYH7lfkYZvzuD5i/0vD0ZLQU2XB0aRKu5i7iDMZ/HzbB
   Oby/72x1npTHlsZW4Gpu7cLNKPINmU6uLA9Z4usUtoDITskTvOh+Yi6aV
   a0Fl7Fy8vO1X/GZisDdKcm/z0LUQ9fEVsL52DAJ9TOklxIxknbVo5q2MT
   jhSKe/1fx3y55D4S4qcHeXM3/xh1OqX4fZWaz7V6l76oolzeBE2T3K333
   39KnHKgW+asSdADCGvRUTDyR6YUjgUT7SBFOQYJkjFriXQ5iNPTqs49Yp
   +VltqbdS51s7hydh0uMQq+dz2qIhjt6xNfJSI+gC/3truN4UNDILX0SGy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="343600835"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="343600835"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 04:48:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="777888100"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="777888100"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Apr 2023 04:48:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 40F5869A; Tue, 11 Apr 2023 14:48:26 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Bumwoo Lee <bw365.lee@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH v3 2/3] extcon: Use sizeof(*pointer) instead of sizeof(type)
Date:   Tue, 11 Apr 2023 14:48:23 +0300
Message-Id: <20230411114824.82960-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230411114824.82960-1-andriy.shevchenko@linux.intel.com>
References: <20230411114824.82960-1-andriy.shevchenko@linux.intel.com>
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
---
 drivers/extcon/extcon.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 5da1cc60582a..76dc41e8f250 100644
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
 
-- 
2.40.0.1.gaa8946217a0b

