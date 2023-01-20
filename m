Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FC26758F4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjATPoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjATPoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:44:09 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F242F6A334;
        Fri, 20 Jan 2023 07:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674229448; x=1705765448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6Qu9mgbn0uz4KQv860MeQD3YerquUjWp1+UWLUDD7Ng=;
  b=U984D4Q3e7ck21HEAPhZ1bmUnnP5eDxIG6xd77HOO5N1KNkiCpfXkGdK
   aeKf58fbjH1Q+KoFRRHahyqVgDk2viEBAW1I3d1WRwmLwPVYhGXnbSveR
   gkZs/xEi6kNqEjThM5OCVK14NvJilhFgRrASehgqLP//uzCbn7TON+7ty
   HxDIx0t9zqvSola27JcH0koJAiRZ11Ng6yO7bcW9fVUwa6r0IBYhoSrLP
   FLhLIrTtvBEqxc78xCzSuCCwOZr7DYQEvWPCVWETGz8UVCFR9qUPnMil7
   k7Fq0gQi07T9hF1DmjTI+heXeY2SahEOLhqlG0VN7UC6L2on5x8fwsR97
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="390114963"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="390114963"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 07:44:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="989427703"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="989427703"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 20 Jan 2023 07:44:05 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 18DC1373; Fri, 20 Jan 2023 17:44:40 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 5/5] usb: fotg210: use devm_platform_get_and_ioremap_resource()
Date:   Fri, 20 Jan 2023 17:44:37 +0200
Message-Id: <20230120154437.22025-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120154437.22025-1-andriy.shevchenko@linux.intel.com>
References: <20230120154437.22025-1-andriy.shevchenko@linux.intel.com>
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

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/fotg210/fotg210-core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/usb/fotg210/fotg210-core.c b/drivers/usb/fotg210/fotg210-core.c
index ce00d9407ce5..202d80adca2c 100644
--- a/drivers/usb/fotg210/fotg210-core.c
+++ b/drivers/usb/fotg210/fotg210-core.c
@@ -135,11 +135,7 @@ static int fotg210_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	fotg->dev = dev;
 
-	fotg->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!fotg->res)
-		return -ENODEV;
-
-	fotg->base = devm_ioremap_resource(dev, fotg->res);
+	fotg->base = devm_platform_get_and_ioremap_resource(pdev, 0, &fotg->res);
 	if (!fotg->base)
 		return -ENOMEM;
 
-- 
2.39.0

