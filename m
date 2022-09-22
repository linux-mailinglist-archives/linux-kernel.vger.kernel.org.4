Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881FB5E58A3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 04:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiIVChQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 22:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiIVChO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 22:37:14 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066FE9DB6C;
        Wed, 21 Sep 2022 19:37:12 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MXzpk3Z67z14S2B;
        Thu, 22 Sep 2022 10:33:02 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 10:37:10 +0800
Received: from huawei.com (10.67.175.34) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 10:37:09 +0800
From:   Ren Zhijie <renzhijie2@huawei.com>
To:     <sre@kernel.org>, <andy.shevchenko@gmail.com>,
        <chiaen_wu@richtek.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ren Zhijie <renzhijie2@huawei.com>
Subject: [PATCH -next] power: supply: mt6370: Fix Kconfig dependency
Date:   Thu, 22 Sep 2022 10:33:37 +0800
Message-ID: <20220922023337.15609-1-renzhijie2@huawei.com>
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

If CONFIG_IIO is not set,
make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-,
will be failed, like this:

drivers/power/supply/mt6370-charger.o: In function `mt6370_chg_mivr_dwork_func':
mt6370-charger.c:(.text+0x670): undefined reference to `iio_read_channel_processed'
drivers/power/supply/mt6370-charger.o: In function `mt6370_chg_probe':
mt6370-charger.c:(.text+0xb43): undefined reference to `devm_iio_channel_get_all'
make: *** [vmlinux] Error 1

To fix this build error, add depends on IIO to config CHARGER_MT6370 dependency.

Fixes: 233cb8a47d65 ("power: supply: mt6370: Add MediaTek MT6370 charger driver")
Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
---
 drivers/power/supply/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 591deb82e2c6..62111f4bb093 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -623,6 +623,7 @@ config CHARGER_MT6370
 	tristate "MediaTek MT6370 Charger Driver"
 	depends on MFD_MT6370
 	depends on REGULATOR
+	depends on IIO
 	select LINEAR_RANGES
 	help
 	  Say Y here to enable MT6370 Charger Part.
-- 
2.17.1

