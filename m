Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6C3667EAD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240281AbjALTGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbjALTFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:05:43 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86A45275F;
        Thu, 12 Jan 2023 10:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673549278; x=1705085278;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7fLXc5FhVYxdThyYteHzhqZSsr0X9gRg8/NHTR49Nzk=;
  b=jSGfRC3kjtIVLOndLOufaWpicZsLrgsMvXf0uRubZx2otsG15GWg5gOo
   OYZYB/36rPAR2ewewEBEtXJRy7J7Mjm91KESvp/GaV//xE9cz5mYlC6aX
   CV5JeGe1ychdMAnYdDJZTu/eYcRrTgdeYzQu43BYS9JUII1pu+MYZSxJU
   6T3SNVJluAkoHkQX9Rsn7pEvb2roccwbq7VIccYopnCIbqsgf221WjmEa
   swdL3FW3AHC832i+jYX6KGcXNJtj1n92Mx+/aIPIYXQrcZSOCuLWnl90X
   d064nenV1AJtzYCHx926lnyryclrv4exPj9kom0YYpkORHQ/wCfdy/5Aq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="410033741"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="410033741"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 10:47:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="831799216"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="831799216"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 12 Jan 2023 10:47:55 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B134114B; Thu, 12 Jan 2023 20:48:29 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH v1 1/2] pinctrl: digicolor: Remove duplicate assignment of of_gpio_n_cells
Date:   Thu, 12 Jan 2023 20:48:22 +0200
Message-Id: <20230112184823.80349-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_gpio_n_cells default is 2 when ->of_xlate() callback is
not defined. No need to assign it explicitly in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-digicolor.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-digicolor.c b/drivers/pinctrl/pinctrl-digicolor.c
index cc3546fc4610..05213261b8a4 100644
--- a/drivers/pinctrl/pinctrl-digicolor.c
+++ b/drivers/pinctrl/pinctrl-digicolor.c
@@ -248,7 +248,6 @@ static int dc_gpiochip_add(struct dc_pinmap *pmap)
 	chip->set		= dc_gpio_set;
 	chip->base		= -1;
 	chip->ngpio		= PINS_COUNT;
-	chip->of_gpio_n_cells	= 2;
 
 	spin_lock_init(&pmap->lock);
 
-- 
2.39.0

