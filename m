Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82566667E97
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjALTEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239485AbjALTDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:03:32 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB37169B2B;
        Thu, 12 Jan 2023 10:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673549008; x=1705085008;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7fLXc5FhVYxdThyYteHzhqZSsr0X9gRg8/NHTR49Nzk=;
  b=hkKDlCNZs02WZ659GtHQQZkOrb9+ZD7NaoBQ9H8aLNC/wg5U0CykEHoW
   XfAi2E8mjCEvrpkzEnaDA8dNP/Vk2JS/6n3FdNPHjInJXRvkjABz5EwAY
   7/i70C+9zMe5D02CHg4zRRj2s0AZUUQwH3ed4taZ5NaOoAx36BYWqDnOQ
   wRLWJBPmf8ZfmZNecVL2bUti5QKW30GOt3tssvxRc5xDq2F8aTKNkTqBN
   hSPQAUcLdogq6+cSCnzM/t5l6JBzQAQrjiZd0FhEs8mpcrd1jijg4mbKk
   ZZ0/nQpjxCVDMfDBUB3qjQOEP8fBc22dBOxPID0SwxGcHc4eLihi+PDWC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="325844682"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="325844682"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 10:43:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="781868543"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="781868543"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 12 Jan 2023 10:43:18 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 58F64130; Thu, 12 Jan 2023 20:43:52 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH v1 1/1] pinctrl: digicolor: Remove duplicate assignment of of_gpio_n_cells
Date:   Thu, 12 Jan 2023 20:43:47 +0200
Message-Id: <20230112184347.79642-1-andriy.shevchenko@linux.intel.com>
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

