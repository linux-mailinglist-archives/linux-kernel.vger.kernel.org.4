Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487DD66737C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 14:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjALNqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 08:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjALNqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:46:19 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BDB319;
        Thu, 12 Jan 2023 05:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673531178; x=1705067178;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TF/ASQYtRliCBB4yKQfpHosKjn/5Y072Nduf+oJWR4s=;
  b=Us1lQT7PWBVFHRb4kU0Xo+eidG4LW+A5py7LXkRyD1sImWe6S7J0P+zw
   Pb2bKLfl2Ctz6D/NHHjwNDljmK/CUv8A+FEJZTilhK+iD1S8rUebwKe3f
   +1Eb8KNtxBeLTIMYV9YGUTAgmUIZ3+t9rPIVOKAkglUZd4Q990U5Up07V
   BkiDKw0LH/1X/aaZ+zk8nJh+7Zo69dGMqMZDM0Aqaho6hVuB141oWDa9f
   g93SvccBzsTShXzH7kNhKj2qVMLWszTJSolACMejQ+om4sIWfepM33FdS
   AowX7WnpBH67t1+RJWQdIyBcSkXy9YjDHHrdiA1WgmzepNtQpiI2vi1e6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10587"; a="325729164"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="325729164"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 05:46:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="659787860"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="659787860"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jan 2023 05:46:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1E6C7E1; Thu, 12 Jan 2023 15:46:48 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Devarsh Thakkar <devarsht@ti.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] gpio: davinci: Do not mention legacy API in the code
Date:   Thu, 12 Jan 2023 15:46:45 +0200
Message-Id: <20230112134645.59232-1-andriy.shevchenko@linux.intel.com>
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

Replace mentioning of legacy API by the latest one.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-davinci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index fa51a91afa54..e1c1b9a527db 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -534,7 +534,7 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
 	}
 
 	/*
-	 * Arrange gpio_to_irq() support, handling either direct IRQs or
+	 * Arrange gpiod_to_irq() support, handling either direct IRQs or
 	 * banked IRQs.  Having GPIOs in the first GPIO bank use direct
 	 * IRQs, while the others use banked IRQs, would need some setup
 	 * tweaks to recognize hardware which can do that.
-- 
2.39.0

