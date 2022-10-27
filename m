Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2D360F3C8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbiJ0JhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiJ0JhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:37:17 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0BF73C0D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:37:16 -0700 (PDT)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MygV15FsgzpW54;
        Thu, 27 Oct 2022 17:33:45 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemi500015.china.huawei.com
 (7.221.188.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 27 Oct
 2022 17:37:11 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <srinivas.kandagatla@linaro.org>, <gregkh@linuxfoundation.org>,
        <krzysztof.kozlowski@linaro.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH -next] slimbus: qcom-ngd: Fix build error when CONFIG_SLIM_QCOM_NGD_CTRL=y && CONFIG_QCOM_RPROC_COMMON=m
Date:   Thu, 27 Oct 2022 17:59:04 +0800
Message-ID: <20221027095904.3388959-1-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_SLIM_QCOM_NGD_CTRL=y, CONFIG_QCOM_RPROC_COMMON=m, COMPILE_TEST=y,
bulding fails:

drivers/slimbus/qcom-ngd-ctrl.o: In function `qcom_slim_ngd_ctrl_probe':
qcom-ngd-ctrl.c:(.text+0x330): undefined reference to `qcom_register_ssr_notifier'
qcom-ngd-ctrl.c:(.text+0x5fc): undefined reference to `qcom_unregister_ssr_notifier'
drivers/slimbus/qcom-ngd-ctrl.o: In function `qcom_slim_ngd_remove':
qcom-ngd-ctrl.c:(.text+0x90c): undefined reference to `qcom_unregister_ssr_notifier'

Make SLIM_QCOM_NGD_CTRL depends on QCOM_RPROC_COMMON || (COMPILE_TEST && !QCOM_RPROC_COMMON) to fix this.

Fixes: e291691c6977 ("slimbus: qcom-ngd-ctrl: allow compile testing without QCOM_RPROC_COMMON")
Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
---
 drivers/slimbus/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/Kconfig b/drivers/slimbus/Kconfig
index 2ed821f75816..a0fdf9d792cb 100644
--- a/drivers/slimbus/Kconfig
+++ b/drivers/slimbus/Kconfig
@@ -23,7 +23,7 @@ config SLIM_QCOM_CTRL
 config SLIM_QCOM_NGD_CTRL
 	tristate "Qualcomm SLIMbus Satellite Non-Generic Device Component"
 	depends on HAS_IOMEM && DMA_ENGINE && NET
-	depends on QCOM_RPROC_COMMON || COMPILE_TEST
+	depends on QCOM_RPROC_COMMON || (COMPILE_TEST && !QCOM_RPROC_COMMON)
 	depends on ARCH_QCOM || COMPILE_TEST
 	select QCOM_QMI_HELPERS
 	select QCOM_PDR_HELPERS
--
2.31.1

