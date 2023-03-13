Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46E16B8278
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 21:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjCMUOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 16:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjCMUOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 16:14:19 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E030E24121;
        Mon, 13 Mar 2023 13:13:50 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 196FE5FD14;
        Mon, 13 Mar 2023 23:13:12 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1678738392;
        bh=qcIGKcZIb5cUrNAdB7ZZAIiITgzMPRGFSQuzjV413Y4=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=aDFbwqf4suEffITUw430m/mQvA2yrKtAOcnjLqfIOgG4dgR4u1WIT14QGp6n0Tqa2
         3HIcw4VMFOxXUpGeJKv7knpm5JNRXR1uQNUmAf0wHtMu7jdKhDA7VSkNtHWK/RmAgK
         sNjemi/8ANEm9vPFgYb6E1oorrPdxCFTEhBRjYXEtDNxOLVobDudcHOgJTpIwkLZtR
         JubmIYBH2BONfdId1JIc/Zz9vxw0NHcXKgz3U95u2w4mm0hiirQwvHYipmZpW8ZEpe
         V7rmppVzA20MGBdC3wJK0FWlTiIeZliC3SG+rtzbnspkugR91oeoQDE8b7Db9PQWVL
         24mMf7WO1xIzg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 13 Mar 2023 23:13:12 +0300 (MSK)
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
Subject: [PATCH v10 1/5] clk: meson: make pll rst bit as optional
Date:   Mon, 13 Mar 2023 23:12:55 +0300
Message-ID: <20230313201259.19998-2-ddrokosov@sberdevices.ru>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20230313201259.19998-1-ddrokosov@sberdevices.ru>
References: <20230313201259.19998-1-ddrokosov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/13 10:14:00 #20942017
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compared with the previous SoCs, self-adaption current module
is newly added for A1, and there is no reset parameter except the
fixed pll. Since we use clk-pll generic driver for A1 pll
implementation, rst bit should be optional to support new behavior.

Signed-off-by: Jian Hu <jian.hu@amlogic.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 drivers/clk/meson/clk-pll.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index afefeba6e458..314ca945a4d0 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -295,10 +295,14 @@ static int meson_clk_pll_init(struct clk_hw *hw)
 	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
 
 	if (pll->init_count) {
-		meson_parm_write(clk->map, &pll->rst, 1);
+		if (MESON_PARM_APPLICABLE(&pll->rst))
+			meson_parm_write(clk->map, &pll->rst, 1);
+
 		regmap_multi_reg_write(clk->map, pll->init_regs,
 				       pll->init_count);
-		meson_parm_write(clk->map, &pll->rst, 0);
+
+		if (MESON_PARM_APPLICABLE(&pll->rst))
+			meson_parm_write(clk->map, &pll->rst, 0);
 	}
 
 	return 0;
@@ -309,8 +313,11 @@ static int meson_clk_pll_is_enabled(struct clk_hw *hw)
 	struct clk_regmap *clk = to_clk_regmap(hw);
 	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
 
-	if (meson_parm_read(clk->map, &pll->rst) ||
-	    !meson_parm_read(clk->map, &pll->en) ||
+	if (MESON_PARM_APPLICABLE(&pll->rst) &&
+	    meson_parm_read(clk->map, &pll->rst))
+		return 0;
+
+	if (!meson_parm_read(clk->map, &pll->en) ||
 	    !meson_parm_read(clk->map, &pll->l))
 		return 0;
 
@@ -341,13 +348,15 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
 		return 0;
 
 	/* Make sure the pll is in reset */
-	meson_parm_write(clk->map, &pll->rst, 1);
+	if (MESON_PARM_APPLICABLE(&pll->rst))
+		meson_parm_write(clk->map, &pll->rst, 1);
 
 	/* Enable the pll */
 	meson_parm_write(clk->map, &pll->en, 1);
 
 	/* Take the pll out reset */
-	meson_parm_write(clk->map, &pll->rst, 0);
+	if (MESON_PARM_APPLICABLE(&pll->rst))
+		meson_parm_write(clk->map, &pll->rst, 0);
 
 	if (meson_clk_pll_wait_lock(hw))
 		return -EIO;
@@ -361,7 +370,8 @@ static void meson_clk_pll_disable(struct clk_hw *hw)
 	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
 
 	/* Put the pll is in reset */
-	meson_parm_write(clk->map, &pll->rst, 1);
+	if (MESON_PARM_APPLICABLE(&pll->rst))
+		meson_parm_write(clk->map, &pll->rst, 1);
 
 	/* Disable the pll */
 	meson_parm_write(clk->map, &pll->en, 0);
-- 
2.36.0

