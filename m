Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EE76150F8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiKARmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiKARmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:42:38 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAAB1CB08;
        Tue,  1 Nov 2022 10:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667324558; x=1698860558;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F1q8w57mHPaiy0oFIx6dL3sLIgTgPFyzkabGHkE+Pbc=;
  b=iJSkEHUZQ80xSdg39ECByhFTNzrHmEvw8DSAsj/dlRlse1IiSyRX000p
   VU0EgYah5iHP34oZMH8E2/shn0CdaBnU/AarVMHraz1O8Ro5i1vHK+z/m
   cv79dJcu2PrsCnJL8RHZm6H/BO17K0kd6iVDaVNbbST5osAbxQmGww+cV
   JiY5IVEqIWA7dinya60RUSwoRiUwrt/L3ait5RT39o9/oEEi/JwGIlBGw
   O9WFwW0vEFhtrn8l6ZfYLo8P6b0p4p3oAEYTG5X/vxylKmegFmg1Xq9kX
   trZpCTn4p7EwLrt9+VjW3Ns37xrBWkwirnGHcFGucTsKO+etum8nQgUiZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="310909165"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="310909165"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 10:42:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="667272869"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="667272869"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 01 Nov 2022 10:42:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E71DCD0; Tue,  1 Nov 2022 19:42:57 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/3] pwm: core: Drop unneeded casting in pwm_seq_show()
Date:   Tue,  1 Nov 2022 19:42:54 +0200
Message-Id: <20221101174255.54452-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221101174255.54452-1-andriy.shevchenko@linux.intel.com>
References: <20221101174255.54452-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The casting form void * to char * is not needed and done implicitly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 855abd0a776f..36128f3301ac 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -1158,7 +1158,7 @@ static int pwm_seq_show(struct seq_file *s, void *v)
 {
 	struct pwm_chip *chip = list_entry(v, struct pwm_chip, list);
 
-	seq_printf(s, "%s%s/%s, %d PWM device%s\n", (char *)s->private,
+	seq_printf(s, "%s%s/%s, %d PWM device%s\n", s->private,
 		   chip->dev->bus ? chip->dev->bus->name : "no-bus",
 		   dev_name(chip->dev), chip->npwm,
 		   (chip->npwm != 1) ? "s" : "");
-- 
2.35.1

