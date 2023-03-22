Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9346C4DF4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjCVOj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjCVOjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:39:23 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7797431E19
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679495962; x=1711031962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kBAOit4snqoHUt4I0yuPk3ujQh2EhLlWYoA5K0fcvog=;
  b=loTAv2A+xpYkS1pHZbun5wqpCJoYTfmnu9OPP82zwvIXUWubuSp+rMx5
   vG//0t9l4MPKVwV1XeRBmAdGZ0VGVGF0HMJAll/R7UbW9Bz4FWa6roSF5
   6d743EkyTgcRtZSNj9XIETuP3757cv7dgulYTUYIKqdfWy3ugx4c16CM1
   xvwvevpWN0jEZrXRV89eY+NuP71+XDlFo2w64y6CvqWyFoiUh7CWJj3Bj
   jpHvdC4GzpCTu71JvHt12DDgCczuznTfc5lgFK+pG1w4yy+T/upqcXdKI
   7hatze5cP5+ZEY7fgn8/7ma5qlJakfB6KIKNHMb4HuNlkAZXWMpVtKJkG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="319622115"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="319622115"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 07:39:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="856116414"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="856116414"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 22 Mar 2023 07:39:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B24C650B; Wed, 22 Mar 2023 16:40:06 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bumwoo Lee <bw365.lee@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v1 04/14] extcon: use sysfs_emit() to instead of sprintf()
Date:   Wed, 22 Mar 2023 16:39:55 +0200
Message-Id: <20230322144005.40368-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
References: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the advice of the Documentation/filesystems/sysfs.rst that
show() should only use sysfs_emit() or sysfs_emit_at() when formatting
the value to be returned to user space.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/extcon/extcon.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 70e9755ba2bc..ac84f4aafc69 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -370,12 +370,12 @@ static ssize_t state_show(struct device *dev, struct device_attribute *attr,
 	struct extcon_dev *edev = dev_get_drvdata(dev);
 
 	if (edev->max_supported == 0)
-		return sprintf(buf, "%u\n", edev->state);
+		return sysfs_emit(buf, "%u\n", edev->state);
 
 	for (i = 0; i < edev->max_supported; i++) {
-		count += sprintf(buf + count, "%s=%d\n",
-				extcon_info[edev->supported_cable[i]].name,
-				 !!(edev->state & BIT(i)));
+		count += sysfs_emit_at(buf, count, "%s=%d\n",
+				       extcon_info[edev->supported_cable[i]].name,
+				       !!(edev->state & BIT(i)));
 	}
 
 	return count;
@@ -387,7 +387,7 @@ static ssize_t name_show(struct device *dev, struct device_attribute *attr,
 {
 	struct extcon_dev *edev = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%s\n", edev->name);
+	return sysfs_emit(buf, "%s\n", edev->name);
 }
 static DEVICE_ATTR_RO(name);
 
@@ -398,8 +398,8 @@ static ssize_t cable_name_show(struct device *dev,
 						  attr_name);
 	int i = cable->cable_index;
 
-	return sprintf(buf, "%s\n",
-			extcon_info[cable->edev->supported_cable[i]].name);
+	return sysfs_emit(buf, "%s\n",
+			  extcon_info[cable->edev->supported_cable[i]].name);
 }
 
 static ssize_t cable_state_show(struct device *dev,
@@ -410,8 +410,8 @@ static ssize_t cable_state_show(struct device *dev,
 
 	int i = cable->cable_index;
 
-	return sprintf(buf, "%d\n",
-		extcon_get_state(cable->edev, cable->edev->supported_cable[i]));
+	return sysfs_emit(buf, "%d\n",
+			  extcon_get_state(cable->edev, cable->edev->supported_cable[i]));
 }
 
 /**
-- 
2.40.0.1.gaa8946217a0b

