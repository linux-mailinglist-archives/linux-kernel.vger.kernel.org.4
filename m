Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231495B92FF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 05:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiIODTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 23:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiIODTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 23:19:39 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D76E0E1;
        Wed, 14 Sep 2022 20:19:37 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MSj544vdqz14Qb9;
        Thu, 15 Sep 2022 11:15:36 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 15 Sep 2022 11:19:35 +0800
Received: from huawei.com (10.67.175.34) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 15 Sep
 2022 11:19:34 +0800
From:   Ren Zhijie <renzhijie2@huawei.com>
To:     <kumaravel.thiagarajan@microchip.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ren Zhijie <renzhijie2@huawei.com>
Subject: [PATCH -next] misc: microchip: pci1xxxx: Fix build error unused-function
Date:   Thu, 15 Sep 2022 11:16:05 +0800
Message-ID: <20220915031605.86214-1-renzhijie2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.175.34]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_PM_SLEEP is not set,
make ARCH=x86_64, will be failed, like this:

drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c:311:12: error: ‘pci1xxxx_gpio_resume’ defined but not used [-Werror=unused-function]
 static int pci1xxxx_gpio_resume(struct device *dev)
            ^~~~~~~~~~~~~~~~~~~~
drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c:295:12: error: ‘pci1xxxx_gpio_suspend’ defined but not used [-Werror=unused-function]
 static int pci1xxxx_gpio_suspend(struct device *dev)
            ^~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

commit 1a3c7bb08826 ("PM: core: Add new *_PM_OPS macros,
deprecate old ones"), 
add new marco DEFINE_SIMPLE_DEV_PM_OPS to fix this unused-function problem.

Fixes: 4ec7ac90ff39 ("misc: microchip: pci1xxxx: Add power management functions - suspend & resume handlers.")
Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
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
2.17.1

