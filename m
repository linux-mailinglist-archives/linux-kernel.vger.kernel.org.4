Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA68667EBD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbjALTJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbjALTIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:08:48 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F216445;
        Thu, 12 Jan 2023 10:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673549454; x=1705085454;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LawLnTNYcPdrqJ0ONp98furwA0CqtsHwm67K1q+IPrQ=;
  b=GveMztBdBzfqFrbe2a323gMam9hx9KDV+jeaDERjXbfNy1egswGc9kcZ
   NBUlLUFuLbfh6ckUUPHjKuWb3VKfiBhLfXfpqXiLlLof/1kdE7kPlSVyd
   4aNnxtGpQUIGsV1ONqMNzXqRpvS0GRYYwasIkFjzObDmHJ0jgnT0i+UsR
   2+HFjHe2W39OrkzbYt7i/PrvZB0HOAGkBaP25CjYkugaqtl5E2CXyfCdf
   oPThFCEMNlTYcdCW6JPmVAWaAB5FzUYpo9ZFjsbrg/q3E9hB+bIghlW8H
   kQlvAe3dVZQKsqbCCS9KY2OtHkVQptFi9yyrxt3ZFKErqdirlrBQZdM6G
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="321491083"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="321491083"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 10:50:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="659928630"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="659928630"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jan 2023 10:50:51 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D1CA314B; Thu, 12 Jan 2023 20:51:25 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wells Lu <wellslutw@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dvorkin Dmitry <dvorkin@tibbo.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] pinctrl: sunplus: sppctl: Remove duplicate assignment of of_gpio_n_cells
Date:   Thu, 12 Jan 2023 20:51:22 +0200
Message-Id: <20230112185122.45216-1-andriy.shevchenko@linux.intel.com>
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
 drivers/pinctrl/sunplus/sppctl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/sunplus/sppctl.c b/drivers/pinctrl/sunplus/sppctl.c
index 9c57bccc4bda..2ed0591fb51d 100644
--- a/drivers/pinctrl/sunplus/sppctl.c
+++ b/drivers/pinctrl/sunplus/sppctl.c
@@ -553,7 +553,6 @@ static int sppctl_gpio_new(struct platform_device *pdev, struct sppctl_pdata *pc
 	gchip->base             = -1;
 	gchip->ngpio            = sppctl_gpio_list_sz;
 	gchip->names            = sppctl_gpio_list_s;
-	gchip->of_gpio_n_cells  = 2;
 
 	pctl->pctl_grange.npins = gchip->ngpio;
 	pctl->pctl_grange.name  = gchip->label;
-- 
2.39.0

