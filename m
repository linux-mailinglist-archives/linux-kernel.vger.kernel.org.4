Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B805BE0B4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiITIsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiITIsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:48:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9A02FFE3;
        Tue, 20 Sep 2022 01:48:07 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MWw705lpZzMn9l;
        Tue, 20 Sep 2022 16:43:24 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 16:48:05 +0800
Received: from huawei.com (10.67.175.34) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 20 Sep
 2022 16:48:05 +0800
From:   Ren Zhijie <renzhijie2@huawei.com>
To:     <heikki.krogerus@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <xji@analogixsemi.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ren Zhijie <renzhijie2@huawei.com>
Subject: [PATCH -next] usb: typec: anx7411: Fix build error without CONFIG_POWER_SUPPLY
Date:   Tue, 20 Sep 2022 16:44:31 +0800
Message-ID: <20220920084431.196258-1-renzhijie2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.34]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building without CONFIG_POWER_SUPPLY will fail:

drivers/usb/typec/anx7411.o: In function `anx7411_detect_power_mode':
anx7411.c:(.text+0x527): undefined reference to `power_supply_changed'
drivers/usb/typec/anx7411.o: In function `anx7411_psy_set_prop':
anx7411.c:(.text+0x90d): undefined reference to `power_supply_get_drvdata'
anx7411.c:(.text+0x930): undefined reference to `power_supply_changed'
drivers/usb/typec/anx7411.o: In function `anx7411_psy_get_prop':
anx7411.c:(.text+0x94d): undefined reference to `power_supply_get_drvdata'
drivers/usb/typec/anx7411.o: In function `anx7411_i2c_probe':
anx7411.c:(.text+0x111d): undefined reference to
`devm_power_supply_register'
drivers/usb/typec/anx7411.o: In function `anx7411_work_func':
anx7411.c:(.text+0x167c): undefined reference to `power_supply_changed'
anx7411.c:(.text+0x1b55): undefined reference to `power_supply_changed'

Add POWER_SUPPLY dependency to Kconfig.

Fixes: fe6d8a9c8e64 ("usb: typec: anx7411: Add Analogix PD ANX7411 support")
Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
---
 drivers/usb/typec/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
index 5defdfead653..831e7049977d 100644
--- a/drivers/usb/typec/Kconfig
+++ b/drivers/usb/typec/Kconfig
@@ -56,6 +56,7 @@ config TYPEC_ANX7411
 	tristate "Analogix ANX7411 Type-C DRP Port controller driver"
 	depends on I2C
 	depends on USB_ROLE_SWITCH
+	depends on POWER_SUPPLY
 	help
 	  Say Y or M here if your system has Analogix ANX7411 Type-C DRP Port
 	  controller driver.
-- 
2.17.1

