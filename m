Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9C85F9A86
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 09:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiJJH4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 03:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiJJH4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 03:56:03 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FCC13EA1;
        Mon, 10 Oct 2022 00:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665388562; x=1696924562;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HID0mHHHZgyVwH5oNtP1G2gM2V0I0iEupf35hgDLXWE=;
  b=Ku7iFvkQshmi5NFsWXovCE9T8N3YrrftUm4omdB+JxYv7KiXdibHFZ6V
   BqGWfE5HoUEgcVyK40nD0QrwbZRYdU6ET8N1Z4Q3+sbjhKmtxKN+eZG92
   ckyv8fxXQeIHbBaA7uSmLjdc6Kra9iEuhfO1n90bXrlQ+eiKmX6K6fs8R
   JqXHmzB19FlqA2F7MHTteT6TU68wI+cyp+tA811ko9QB4liGfca+0igQH
   +zBX2AfINU2iuA2Ndgn+qc2jhzxMNdy/V96Pxb8zPFaLytepYD1Cuy0Zl
   UGvJBXvC8hKiQieY/Nc7g/LgyPwCN7tT9q4IMJC0CcdbMQalZQgchgxBi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="305762231"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="305762231"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 00:56:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="694539307"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="694539307"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 10 Oct 2022 00:55:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 614561E0; Mon, 10 Oct 2022 10:56:20 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v1 1/1] pinctrl: st: Switch to use fwnode instead of of_node
Date:   Mon, 10 Oct 2022 10:56:15 +0300
Message-Id: <20221010075615.43244-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

The OF node in the GPIO library is deprecated and soon
will be removed.

GPIO library now accepts fwnode as a firmware node, so
switch the driver to use it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-st.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index cf7f9cbe6044..987878c83349 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -1175,7 +1175,7 @@ static int st_pctl_dt_calculate_pin(struct st_pinctrl *info,
 
 	for (i = 0; i < info->nbanks; i++) {
 		chip = &info->banks[i].gpio_chip;
-		if (chip->of_node == np) {
+		if (chip->fwnode == of_fwnode_handle(np)) {
 			if (offset < chip->ngpio)
 				retval = chip->base + offset;
 			break;
@@ -1518,7 +1518,7 @@ static int st_gpiolib_register_bank(struct st_pinctrl *info,
 	bank->gpio_chip = st_gpio_template;
 	bank->gpio_chip.base = bank_num * ST_GPIO_PINS_PER_BANK;
 	bank->gpio_chip.ngpio = ST_GPIO_PINS_PER_BANK;
-	bank->gpio_chip.of_node = np;
+	bank->gpio_chip.fwnode = of_fwnode_handle(np);
 	bank->gpio_chip.parent = dev;
 	spin_lock_init(&bank->lock);
 
-- 
2.35.1

