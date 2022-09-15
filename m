Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B2C5B9814
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiIOJup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiIOJuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:50:14 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98ABC67175;
        Thu, 15 Sep 2022 02:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663235257; x=1694771257;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hboeAx8mMRpGs54TYdsSnLqFRA2TtwV90q8y69BhRkE=;
  b=S8bIGEOl5CepDHANbjnzTlUVB44BI3TYkzH2ivVLG4lBiKKTsqslG49i
   xczQKhpROTfAxTmuxyrM4BdmYEsAIboYyn9lja5acnDoykx5dlx8vjbQs
   OcsjS1UbxNvwqouqcgbsxEYb/3RxZVjnwrd1V67xCoPjkfzYWOY8B1tvp
   /HLzCPjq+SMpDIZyC9zPkeDIAIiyLJvIUMe/Ma9AaYwbXQLrFXKmgSAft
   dUtk1e8s9cy51IhtxE65mRf5HORd5zkJsHkIoF9O2Is7cne/ZFc9socc3
   6EHuxVx8YOGqnefhXp0qD9kKvkD5nJLZ4dCLqVI1P14si0uECy57OSeIQ
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="177279409"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Sep 2022 02:47:34 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 15 Sep 2022 02:47:34 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 15 Sep 2022 02:47:31 -0700
From:   Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
To:     <linux-kernel@vger.kernel.org>, <sudipm.mukherjee@gmail.com>,
        <arnd@arndb.de>, <linux-gpio@vger.kernel.org>,
        <linux-next@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <bagasdotme@gmail.com>, <kumaravel.thiagarajan@microchip.com>
Subject: [PATCH v2 char-misc-next] misc: microchip: pci1xxxx: use DEFINE_SIMPLE_DEV_PM_OPS() in place  of the SIMPLE_DEV_PM_OPS() in pci1xxxx's gpio driver
Date:   Thu, 15 Sep 2022 15:17:29 +0530
Message-ID: <20220915094729.646185-1-kumaravel.thiagarajan@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

build errors listed below and reported by Sudip Mukherjee
<sudipm.mukherjee@gmail.com> for the builds of
riscv, s390, csky, alpha and loongarch allmodconfig are fixed in
this patch.

drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c:311:12: error: 'pci1xxxx_gpio_resume' defined but not used [-Werror=unused-function]
  311 | static int pci1xxxx_gpio_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~
drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c:295:12: error: 'pci1xxxx_gpio_suspend' defined but not used [-Werror=unused-function]
  295 | static int pci1xxxx_gpio_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~

Fixes: 4ec7ac90ff39 ("misc: microchip: pci1xxxx: Add power management functions - suspend & resume handlers.")
Reported-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
---
Changes in v2:
  - Mention as Sudip had reported in the commit description
    as suggested by Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
index 9cc771c604ed..4cd541166b0c 100644
--- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
+++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
@@ -405,7 +405,7 @@ static int pci1xxxx_gpio_probe(struct auxiliary_device *aux_dev,
 	return devm_gpiochip_add_data(&aux_dev->dev, &priv->gpio, priv);
 }
 
-static SIMPLE_DEV_PM_OPS(pci1xxxx_gpio_pm_ops, pci1xxxx_gpio_suspend, pci1xxxx_gpio_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(pci1xxxx_gpio_pm_ops, pci1xxxx_gpio_suspend, pci1xxxx_gpio_resume);
 
 static const struct auxiliary_device_id pci1xxxx_gpio_auxiliary_id_table[] = {
 	{.name = "mchp_pci1xxxx_gp.gp_gpio"},
-- 
2.25.1

