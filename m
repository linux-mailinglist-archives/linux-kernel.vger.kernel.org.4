Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4569266A574
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 22:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjAMVxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 16:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjAMVxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 16:53:39 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB8889BFC;
        Fri, 13 Jan 2023 13:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673646819; x=1705182819;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rSk8kRnrN156Y49vFLwe5/TFThez7qh4vOwi5cU890s=;
  b=GJrOypMERElM75Wgm1FN1AAu2qaV0W/30fGAidTCRAXuqd4eLyvei93t
   TeIlKocjQY/r8x/0AinJOkzxvZ80QXj91lZV+jIR9T/LEYxBHcePWz0Wx
   XXtO/it8Ls121b7cchs0oDEnKDemv73xb5+GzJB4eS0EKzonehQM94rOQ
   phr6fCpge/pPqi0f3taqjsURskyov3clZyak6xrnesouaytscJPQ3Z3Jx
   4/EqPblZ1/Ma+tiRY2rG+9/K1OTY/esXmQV8kH0Y0aAIkJvwAnsBOouxM
   23qQ5nUrlMY8aBlFDSGxB00tUVyle+9DAcmSNE7CyaAekeRNol3kCUwb5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="351343129"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="351343129"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 13:53:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="766170868"
X-IronPort-AV: E=Sophos;i="5.97,215,1669104000"; 
   d="scan'208";a="766170868"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jan 2023 13:53:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 71E5814B; Fri, 13 Jan 2023 23:53:56 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH v3 2/4] pinctrl: bcm2835: Remove of_node_put() in bcm2835_of_gpio_ranges_fallback()
Date:   Fri, 13 Jan 2023 23:53:50 +0200
Message-Id: <20230113215352.44272-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113215352.44272-1-andriy.shevchenko@linux.intel.com>
References: <20230113215352.44272-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove wrong of_node_put() in bcm2835_of_gpio_ranges_fallback(),
there is no counterpart of_node_get() for it.

Fixes: d2b67744fd99 ("pinctrl: bcm2835: implement hook for missing gpio-ranges")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/bcm/pinctrl-bcm2835.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index 7857e612a100..c7cdccdb4332 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -363,8 +363,6 @@ static int bcm2835_of_gpio_ranges_fallback(struct gpio_chip *gc,
 {
 	struct pinctrl_dev *pctldev = of_pinctrl_get(np);
 
-	of_node_put(np);
-
 	if (!pctldev)
 		return 0;
 
-- 
2.39.0

