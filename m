Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54440609EEE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiJXKXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiJXKXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:23:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDB757E18;
        Mon, 24 Oct 2022 03:23:28 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BC7686602333;
        Mon, 24 Oct 2022 11:23:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666607006;
        bh=5Az5jwOoNYNBJ2mRPMh4q4mbZC3HeNsPWS1nX5wzVIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AKSK+Z+G2slnRQgxym1b4q885YK+8x5oMNGu21Y6SLyoHZ9hYV4IQdHM/6fhX6Yg9
         YuZdJKoB/QORhd3aw8UkiA7xbuWo23246GQ71ZiL/+6sm0fcnZmgO4GGEA0kaAKPxr
         u7oMfZ7EqNb3dzW8BiMGVKB+fvC171aU79yAoSTp8Sm2qvPP/LWeYHz01Pcn6DHILe
         +a88Qg4LsK1fRmhBCnkuippMztoA5f7LkWICNW5TyW8LtEAM6XFU3OsbeKsdyQl76Q
         3o/a8goEkIXE7F7moVKhjdWcDrhBvQe9NCWOTM3c7K2+VwIO3Sov2JFAwaYzA18nWK
         vivjkDp0JeopQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        miles.chen@mediatek.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, chun-jie.chen@mediatek.com,
        jose.exposito89@gmail.com, yangyingliang@huawei.com,
        msp@baylibre.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] clk: mediatek: clk-mtk: Allow specifying flags on mtk_fixed_factor clocks
Date:   Mon, 24 Oct 2022 12:22:58 +0200
Message-Id: <20221024102307.33722-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221024102307.33722-1-angelogioacchino.delregno@collabora.com>
References: <20221024102307.33722-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before this change, every mtk_fixed_factor clock forced clock flags to
CLK_SET_RATE_PARENT: while this is harmless in some cases, it may not
be desired in some others, especially when performing clock muxing on
a clock having multiple parents of which one is a dedicated PLL and the
others are not.

This is especially seen on the GPU clocks on some SoCs, where we are
muxing between multiple parents: a fixed clock (crystal), a programmable
GPU PLL and one or more dividers for the MAINPLL, used for a number of
devices; it happens that when a rate change is called for the GPU, the
clock framework will try to satisfy the rate request by using one of the
MAINPLL dividers, which have CLK_SET_RATE_PARENT and will set the rate
on MAINPLL itself - overclocking or underclocking many devices in the
system - and making it to lock up.

Logically, it should be harmless (and would only reduce possible bugs)
to change all of the univpll and mainpll related fixed factor clocks
to not declare the CLK_SET_RATE_PARENT by default but, on some SoCs,
this is also used for dividers of other PLLs for which a rate change
based on the divider may be desired, hence introduce a new FACTOR_FLAGS()
macro to use custom flags (or none) on selected fixed factor clocks.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mtk.c | 2 +-
 drivers/clk/mediatek/clk-mtk.h | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index d31f01d0ba1c..3c1ac8d3010f 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -149,7 +149,7 @@ int mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
 		}
 
 		hw = clk_hw_register_fixed_factor(NULL, ff->name, ff->parent_name,
-				CLK_SET_RATE_PARENT, ff->mult, ff->div);
+				ff->flags, ff->mult, ff->div);
 
 		if (IS_ERR(hw)) {
 			pr_err("Failed to register clk %s: %pe\n", ff->name,
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 63ae7941aa92..f2db6b57d5b5 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -47,16 +47,21 @@ struct mtk_fixed_factor {
 	const char *parent_name;
 	int mult;
 	int div;
+	unsigned long flags;
 };
 
-#define FACTOR(_id, _name, _parent, _mult, _div) {	\
+#define FACTOR_FLAGS(_id, _name, _parent, _mult, _div, _fl) {	\
 		.id = _id,				\
 		.name = _name,				\
 		.parent_name = _parent,			\
 		.mult = _mult,				\
 		.div = _div,				\
+		.flags = _fl,				\
 	}
 
+#define FACTOR(_id, _name, _parent, _mult, _div)	\
+	FACTOR_FLAGS(_id, _name, _parent, _mult, _div, CLK_SET_RATE_PARENT)
+
 int mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
 			     struct clk_hw_onecell_data *clk_data);
 void mtk_clk_unregister_factors(const struct mtk_fixed_factor *clks, int num,
-- 
2.37.2

