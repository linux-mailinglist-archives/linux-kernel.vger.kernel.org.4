Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFFC6C4DFB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjCVOju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjCVOj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:39:26 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530D6521ED
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679495965; x=1711031965;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XodOHskzLqB9GOrDUS/F5Kh8Lt/zUFltWrdOozMmc8c=;
  b=Tx2pAAeGQgygEUDmpnqScbs3EkjrnpC35XNYuL7aMZBU+771JiNo6G0U
   2iupDvqhjbsFQ/JWqx8wngkuBQU7LhqkJCDUX9zIOByU3IPN4fyFotEi1
   nEpPpSfC2v+SgA3BENqc6EjyJ3SeJAI8tfAthvHCN5/RgTIEH9s6w8KpR
   8uKaicf8XtBM1o3uDo6YgBPQL7XcRTTKl1pUykedYy1yFeL5FrraIRkOQ
   /xeQoLZsKeyGZu1EFTOJAk2kkMRMolOh+LF560pfOLIazAIxQK0qQItCZ
   xFwtxsFyPKbQCjGnc4Y1Z3IjpZVLOYEZ0YbRI7IP0qXru+kKbzANoXOQQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="327609307"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="327609307"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 07:39:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="792579436"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="792579436"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 22 Mar 2023 07:39:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 03630944; Wed, 22 Mar 2023 16:40:07 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bumwoo Lee <bw365.lee@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v1 12/14] extcon: Use sizeof(*pointer) instead of sizeof(type)
Date:   Wed, 22 Mar 2023 16:40:03 +0200
Message-Id: <20230322144005.40368-13-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
References: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
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
 drivers/extcon/extcon.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 0e04ea185c26..b3f038639cd6 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1099,9 +1099,7 @@ static int extcon_alloc_cables(struct extcon_dev *edev)
 	if (!edev->max_supported)
 		return 0;
 
-	edev->cables = kcalloc(edev->max_supported,
-			       sizeof(struct extcon_cable),
-			       GFP_KERNEL);
+	edev->cables = kcalloc(edev->max_supported, sizeof(*edev->cables), GFP_KERNEL);
 	if (!edev->cables)
 		return -ENOMEM;
 
@@ -1160,14 +1158,12 @@ static int extcon_alloc_muex(struct extcon_dev *edev)
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
@@ -1213,8 +1209,8 @@ static int extcon_alloc_groups(struct extcon_dev *edev)
 		return 0;
 
 	edev->extcon_dev_type.groups = kcalloc(edev->max_supported + 2,
-			sizeof(struct attribute_group *),
-			GFP_KERNEL);
+					       sizeof(*edev->extcon_dev_type.groups),
+					       GFP_KERNEL);
 	if (!edev->extcon_dev_type.groups)
 		return -ENOMEM;
 
@@ -1298,8 +1294,7 @@ int extcon_dev_register(struct extcon_dev *edev)
 
 	spin_lock_init(&edev->lock);
 	if (edev->max_supported) {
-		edev->nh = kcalloc(edev->max_supported, sizeof(*edev->nh),
-				GFP_KERNEL);
+		edev->nh = kcalloc(edev->max_supported, sizeof(*edev->nh), GFP_KERNEL);
 		if (!edev->nh) {
 			ret = -ENOMEM;
 			goto err_alloc_nh;
-- 
2.40.0.1.gaa8946217a0b

