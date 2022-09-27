Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED2D5ECAB3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiI0RWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiI0RWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:22:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8061C771F;
        Tue, 27 Sep 2022 10:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664299366; x=1695835366;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Cw27lEfIdc1DhVIpD8qZcxwH3Zpfg7Yzp+ZMZUk8s94=;
  b=ifdNnnAc0Elb8J5LDb7p2WHdgjt+sred8zPUXkVHIxPu4aLUM1E4VqE7
   PWto8Qi4I1oYhqkGOREeIqTVCFBTO+G5cxnqT4xuemTsq1Tk0zFfLxzaa
   4MEw0SuxcroREid0zcrvTEldBqOS8hgctrb1HERwqNdX0v8tTO/XtP/vi
   t/1nJ5BuhkNw6SnK4wr1J6IOHb55c/gVnq4veSfCxudqgrL2IYqiwyVBf
   SOWPBC5eez4vPZdXwxPAeZwXJRweev5hBil79dW8+8BOpILz6TZ9pguWU
   35vnxHccT5XLREJqNq/2DyrNGv+99oItEqdBQQuR2tjjoZ9SaFhhDwCde
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="363216994"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="363216994"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 10:22:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="623832196"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="623832196"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 27 Sep 2022 10:22:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E705A7C; Tue, 27 Sep 2022 20:22:59 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] pwm: core: Replace custom implementation of device_match_fwnode()
Date:   Tue, 27 Sep 2022 20:22:58 +0300
Message-Id: <20220927172258.62418-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace custom implementation of the device_match_fwnode().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index cfe3a0327471..d333e7422f4a 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -678,7 +678,7 @@ static struct pwm_chip *fwnode_to_pwmchip(struct fwnode_handle *fwnode)
 	mutex_lock(&pwm_lock);
 
 	list_for_each_entry(chip, &pwm_chips, list)
-		if (chip->dev && dev_fwnode(chip->dev) == fwnode) {
+		if (chip->dev && device_match_fwnode(chip->dev, fwnode)) {
 			mutex_unlock(&pwm_lock);
 			return chip;
 		}
-- 
2.35.1

