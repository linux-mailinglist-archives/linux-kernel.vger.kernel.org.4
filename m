Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B7E6ACC95
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 19:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjCFSal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 13:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjCFSaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:30:39 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E88170F;
        Mon,  6 Mar 2023 10:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678127439; x=1709663439;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VvQq/hiW3ciMZLoERkUkYzqWpN07fmrNja7l175IvIY=;
  b=L8h8F49OtVGAMTSjKU6Xd0Rb5fbsnW8wV1Qeaps6DbG6LXTzJ2Cf990F
   D+OzjSYIebSUghZ7OKxnazoOsPfo96boW0u39HCxF9Eka6HuobGxy1gGT
   QXMTUWQxcLGlO+hxS1l4WYFKPhPUCedds6x/KewDLLfT6zSM+skelAkyg
   5LukkjHppCH6ViWnlYSQT48bMENrLu6qOKvEQf8xYqH6q4vP0sVI/XFLQ
   drTtfCrWj7efefNUXBWivJSNVOWd6ZJuXuuysbvn5vgsc3qXCnkebRmt1
   U9ZwXbWs14Vo+8oarCQF4Eir7KW2SE836FGEvxMYH07A4TyW9UT6pATMz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="333109220"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="333109220"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:30:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="669559042"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="669559042"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 06 Mar 2023 10:30:36 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5E83C14F; Mon,  6 Mar 2023 20:31:19 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/5] spi: mpc5xxx-psc: Return immediately if IRQ resource is unavailable
Date:   Mon,  6 Mar 2023 20:31:12 +0200
Message-Id: <20230306183115.87314-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230306183115.87314-1-andriy.shevchenko@linux.intel.com>
References: <20230306183115.87314-1-andriy.shevchenko@linux.intel.com>
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

Return immediately if IRQ resource is unavailable. This will also
propagate the correct error code in such cases.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-mpc512x-psc.c | 3 +++
 drivers/spi/spi-mpc52xx-psc.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index a2ea24a63cb4..8a436d1906eb 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -490,6 +490,9 @@ static int mpc512x_psc_spi_of_probe(struct platform_device *pdev)
 		(struct mpc512x_psc_fifo *)(tempp + sizeof(struct mpc52xx_psc));
 
 	mps->irq = platform_get_irq(pdev, 0);
+	if (mps->irq < 0)
+		return mps->irq;
+
 	ret = devm_request_irq(dev, mps->irq, mpc512x_psc_spi_isr, IRQF_SHARED,
 				"mpc512x-psc-spi", mps);
 	if (ret)
diff --git a/drivers/spi/spi-mpc52xx-psc.c b/drivers/spi/spi-mpc52xx-psc.c
index 1bf728f4d766..b75bc2457883 100644
--- a/drivers/spi/spi-mpc52xx-psc.c
+++ b/drivers/spi/spi-mpc52xx-psc.c
@@ -328,6 +328,9 @@ static int mpc52xx_psc_spi_of_probe(struct platform_device *pdev)
 	mps->fifo = ((void __iomem *)mps->psc) + sizeof(struct mpc52xx_psc);
 
 	mps->irq = platform_get_irq(pdev, 0);
+	if (mps->irq < 0)
+		return mps->irq;
+
 	ret = devm_request_irq(dev, mps->irq, mpc52xx_psc_spi_isr, 0,
 			       "mpc52xx-psc-spi", mps);
 	if (ret)
-- 
2.39.1

