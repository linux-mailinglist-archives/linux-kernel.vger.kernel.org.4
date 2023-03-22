Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29B96C4DF7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjCVOjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjCVOjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:39:25 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EA32A141
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679495964; x=1711031964;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d4qGUtkkw/1Zx3uos2jaj6d4j/Os0XO1Iz7gJZdoh0U=;
  b=d4PDK/NkVXq0TApvuKjTPvIgFZXH7HTkvPm9mh3jEyEekbAAfTEEOzOB
   xjTsA3X1Yb+vtbq8dJy/mhjfZ2gRxhIHZF75Hb25YBAGnx55kHkOKTPXf
   z+M0aLjXjS5ixCwvRty0aFbIG/3dIYd7A4jjW8jkW+tK0ufBkfU6oqmh+
   pOCsneLOEgqRW8cda6TW4smM0/tqIXqtpbBMlmbl8FcxbXDx2ZgsFcUlj
   DNgpr3bmjrrohdXWBvdzOS2gr30zJaJw2iZ38BZ1U/YdjABLvkeUod8Es
   Ji6M4eTmDR9JP91dsx93UNiRPp6SqrgyeamR2+Qjuz1gMc5qHmOggVooJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="327609300"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="327609300"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 07:39:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="792579431"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="792579431"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 22 Mar 2023 07:39:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C092C638; Wed, 22 Mar 2023 16:40:06 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bumwoo Lee <bw365.lee@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v1 06/14] extcon: Allow name to be assigned outside of the framework
Date:   Wed, 22 Mar 2023 16:39:57 +0200
Message-Id: <20230322144005.40368-7-andriy.shevchenko@linux.intel.com>
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

The documentation states that name of the extcon can be assigned
outside of the framework, however code does something different.
Fix the code to be aligned with the documentation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/extcon/extcon.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index ac84f4aafc69..14e66e21597f 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1269,10 +1269,10 @@ int extcon_dev_register(struct extcon_dev *edev)
 	edev->dev.class = extcon_class;
 	edev->dev.release = extcon_dev_release;
 
-	edev->name = dev_name(edev->dev.parent);
-	if (IS_ERR_OR_NULL(edev->name)) {
-		dev_err(&edev->dev,
-			"extcon device name is null\n");
+	if (!edev->name)
+		edev->name = dev_name(edev->dev.parent);
+	if (!edev->name) {
+		dev_err(&edev->dev, "extcon device name is null\n");
 		return -EINVAL;
 	}
 	dev_set_name(&edev->dev, "extcon%lu",
-- 
2.40.0.1.gaa8946217a0b

