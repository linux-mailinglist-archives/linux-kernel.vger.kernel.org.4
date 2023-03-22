Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987CB6C4DFC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjCVOjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjCVOj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:39:26 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00EC51CAD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679495965; x=1711031965;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CBCCxTTZs2kCb/p6GUvHy/Ipc4yohpZu5RckL85FL+w=;
  b=BtBtGPs4sd8XAJa1/i4OUiCKPcb50n+ES0wsgzxtZ4rHVIbVvrEy/fFQ
   gLNfqal8bP0yjt6fBPlykacRnTtwDkVNjzhVLYWAkYhHRGB3xQQUVzsDJ
   hrt1UMohuWHwX2VONKn6QgmQjwrh23aJn0A/NFaN7CK0+/BA2u0IQBLHn
   7sH0gS8GetdN04b7MtQmeYkDVjBx/wkst3Y/qD+nE7FrySS1iNmheoIgg
   YKZ0ne1L+LVgzE/Wa9mLd/uaMRNQj73HYyQsVUfyDLhZEKUiDILnYkj6p
   5TQh13Awd8FnyzxzcfAQ4I0RdFWDx5GxkxQyaRhm9puFfmhG/z0AGLpoY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="327609306"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="327609306"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 07:39:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="792579435"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="792579435"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 22 Mar 2023 07:39:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E3BC480A; Wed, 22 Mar 2023 16:40:06 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bumwoo Lee <bw365.lee@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v1 10/14] extcon: use dev_of_node(dev) instead of dev->of_node
Date:   Wed, 22 Mar 2023 16:40:01 +0200
Message-Id: <20230322144005.40368-11-andriy.shevchenko@linux.intel.com>
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

The dev_of_node function should be preferred.
In the result we may drop unneeded NULL check
of the pointer to the device object.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/extcon/extcon.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 5cadbfc151e6..32e96cb49067 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1429,21 +1429,17 @@ struct extcon_dev *extcon_find_edev_by_node(struct device_node *node)
  */
 struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev, int index)
 {
-	struct device_node *node;
+	struct device_node *node, *np = dev_of_node(dev);
 	struct extcon_dev *edev;
 
-	if (!dev)
-		return ERR_PTR(-EINVAL);
-
-	if (!dev->of_node) {
+	if (!np) {
 		dev_dbg(dev, "device does not have a device node entry\n");
 		return ERR_PTR(-EINVAL);
 	}
 
-	node = of_parse_phandle(dev->of_node, "extcon", index);
+	node = of_parse_phandle(np, "extcon", index);
 	if (!node) {
-		dev_dbg(dev, "failed to get phandle in %pOF node\n",
-			dev->of_node);
+		dev_dbg(dev, "failed to get phandle in %pOF node\n", np);
 		return ERR_PTR(-ENODEV);
 	}
 
-- 
2.40.0.1.gaa8946217a0b

