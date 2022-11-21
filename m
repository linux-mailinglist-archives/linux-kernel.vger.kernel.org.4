Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797A563234F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiKUNSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiKUNSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:18:51 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA33F748C5;
        Mon, 21 Nov 2022 05:18:49 -0800 (PST)
Received: from kwepemi500022.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NG7HW6wnzzmVn8;
        Mon, 21 Nov 2022 21:18:15 +0800 (CST)
Received: from huawei.com (10.67.175.34) by kwepemi500022.china.huawei.com
 (7.221.188.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 21 Nov
 2022 21:18:44 +0800
From:   Ren Zhijie <renzhijie2@huawei.com>
To:     <linus.walleij@linaro.or>, <zhanghongchen@loongson.cn>,
        <zhuyinbo@loongson.cn>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yusongping@huawei.com>, Ren Zhijie <renzhijie2@huawei.com>
Subject: [PATCH -next] pinctrl: pinctrl-loongson2: fix Kconfig dependency
Date:   Mon, 21 Nov 2022 13:14:22 +0000
Message-ID: <20221121131422.217806-1-renzhijie2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.34]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500022.china.huawei.com (7.221.188.64)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_PINCTRL_LOONGSON2=y and CONFIG_OF is not set,
gcc complained about undefined reference:

drivers/pinctrl/pinctrl-loongson2.o: In function `pinconf_generic_dt_node_to_map_all':
pinctrl-loongson2.c:(.text+0x1c4): undefined reference to
`pinconf_generic_dt_node_to_map'

To fix this error, add depends on OF to
config PINCTRL_LOONGSON2.

Fixes: f73f88acbc18 ("pinctrl: pinctrl-loongson2: add pinctrl driver support")
Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
---
 drivers/pinctrl/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 35f167f70829..7d5f5458c72e 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -260,7 +260,7 @@ config PINCTRL_FALCON
 
 config PINCTRL_LOONGSON2
 	tristate "Pinctrl driver for the Loongson-2 SoC"
-	depends on LOONGARCH || COMPILE_TEST
+	depends on OF && (LOONGARCH || COMPILE_TEST)
 	select PINMUX
 	select GENERIC_PINCONF
 	help
-- 
2.17.1

