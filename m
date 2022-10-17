Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5C7601466
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiJQRMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiJQRM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:12:29 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DA167059;
        Mon, 17 Oct 2022 10:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666026749; x=1697562749;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eEL0Wkgz2QTB6hPhPIAefByf4yM70/tBp3XIDpf3g4Y=;
  b=Mw+WegJSWyGn9/wX52ebCAgKuATaxnBjIJdONaBZ/GHuCQn8iMS4nIR+
   maJYJgMu4ad+gzAVU+VPBKXZGd1xxIhE4ZGt5c3VyUdws/JTVSPwvp2v8
   sxDx7LOOQfEeMdr0DgMtX9KGkRNloV8SBqmIRQvZ3JG3zs6DDUYVhOxoa
   SJi9sKYDL3yNIzsxS6zDMFdV2LYZkequ+DDSTOD865fKptzodgucHW1xZ
   UGK9U2QgMhwOGwGLxfBNFAiY917OrwFsapw0Rqap33o0Tqip87hcnU4g2
   q+2KUiEnSN4VZ8iT2HYwddU+Hp/B0Gv1K+orqWZb2rYWk9Lwdlzlte51d
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="367886364"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="367886364"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 10:12:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="733239970"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="733239970"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 17 Oct 2022 10:12:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6542426D; Mon, 17 Oct 2022 20:12:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 1/6] spi: pxa2xx: Simplify with devm_platform_get_and_ioremap_resource()
Date:   Mon, 17 Oct 2022 20:12:38 +0300
Message-Id: <20221017171243.57078-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

No functional changes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 2bf21c2e7a52..03ed6d4a14cd 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1482,8 +1482,7 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 
 	ssp = &pdata->ssp;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ssp->mmio_base = devm_ioremap_resource(&pdev->dev, res);
+	ssp->mmio_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(ssp->mmio_base))
 		return ERR_CAST(ssp->mmio_base);
 
-- 
2.35.1

