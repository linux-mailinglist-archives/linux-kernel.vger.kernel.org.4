Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E5563FB25
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbiLAW6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbiLAW5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:57:40 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99B7A444;
        Thu,  1 Dec 2022 14:57:38 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 1B0C85FD0E;
        Fri,  2 Dec 2022 01:57:32 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1669935452;
        bh=XU1bxoWrykCIxVdFR9T9KlwOWfuXOxPytqzRPXwAy18=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=ryfu3zlINlnEg5WtnhdYY0DhdKbMmieEI0hBQdTdjkPCeBQGMTCQbRzdCw+AZu06m
         QDiDgyC5NOf7a3jWRg1ENQGdvZIWexoDUcWWhqt0FeqRfEUTlgBHSGTKJDkhDLbitn
         b/ud1RDW3kZ13VMn1UxArrRtr/uQz/F7X5QvkaWn5bryeOPrrQh01iCBKDid4ul+l8
         D4m6mT7WfYLYQ6vKaHOcGhHsJ0hPYZPdciLqQID7aBCpKC3wIBTUZGm82Ldp72ZQll
         xUVvBSvU3PDpZy6H44F/6Ay51Xq9aIin49Xh08FSJ331eJDqR1ALInjZt84MGePpna
         QlTzsFFVq4D6g==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri,  2 Dec 2022 01:57:32 +0300 (MSK)
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <khilman@baylibre.com>, <martin.blumenstingl@googlemail.com>
CC:     <jian.hu@amlogic.com>, <kernel@sberdevices.ru>,
        <rockosov@gmail.com>, <linux-amlogic@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: [PATCH v8 05/11] clk: meson: pll: export meson_clk_pll_wait_lock symbol
Date:   Fri, 2 Dec 2022 01:56:57 +0300
Message-ID: <20221201225703.6507-6-ddrokosov@sberdevices.ru>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20221201225703.6507-1-ddrokosov@sberdevices.ru>
References: <20221201225703.6507-1-ddrokosov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/12/01 20:49:00 #20634374
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modern meson PLL IPs are a little bit different from early known PLLs.
The main difference is located in the init/enable/disable sequences; the
rate logic is the same. So drivers for the new PLLs can be inherited
from the clk-pll driver and redefine init/enable/disable routines only.
For that purpose we need to have meson_clk_pll_wait_lock() in the export
symbols list, because each lock operation should be ended with wait
cycles.

Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 drivers/clk/meson/clk-pll.c | 3 ++-
 drivers/clk/meson/clk-pll.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index 9e55617bc3b4..81c810d57a48 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -273,7 +273,7 @@ static int meson_clk_pll_determine_rate(struct clk_hw *hw,
 	return 0;
 }
 
-static int meson_clk_pll_wait_lock(struct clk_hw *hw)
+int meson_clk_pll_wait_lock(struct clk_hw *hw)
 {
 	struct clk_regmap *clk = to_clk_regmap(hw);
 	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
@@ -289,6 +289,7 @@ static int meson_clk_pll_wait_lock(struct clk_hw *hw)
 
 	return -ETIMEDOUT;
 }
+EXPORT_SYMBOL_GPL(meson_clk_pll_wait_lock);
 
 static int meson_clk_pll_init(struct clk_hw *hw)
 {
diff --git a/drivers/clk/meson/clk-pll.h b/drivers/clk/meson/clk-pll.h
index 367efd0f6410..85fec18c4b8a 100644
--- a/drivers/clk/meson/clk-pll.h
+++ b/drivers/clk/meson/clk-pll.h
@@ -47,4 +47,6 @@ extern const struct clk_ops meson_clk_pll_ro_ops;
 extern const struct clk_ops meson_clk_pll_ops;
 extern const struct clk_ops meson_clk_pcie_pll_ops;
 
+int meson_clk_pll_wait_lock(struct clk_hw *hw);
+
 #endif /* __MESON_CLK_PLL_H */
-- 
2.36.0

