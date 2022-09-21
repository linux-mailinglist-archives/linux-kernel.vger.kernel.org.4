Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298C85BFA8A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbiIUJQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiIUJPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:15:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98048C442;
        Wed, 21 Sep 2022 02:15:21 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 72C556602028;
        Wed, 21 Sep 2022 10:15:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663751720;
        bh=/154pUNJ44grFXqJRcV6FEo9+3ZZSy2/vfCsiBboVF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=foJ0C5NYi0WPOm1K8zVonIYepoETfalbtxTAi4U4wRjrszmkr+BHh56zEdWC9kEkz
         3xPW4Yp7JsCNbYJn5nJ+gF8EGNkZ5K6gjImgALxOiME+DcqVvB1xixBOX9RU45iSER
         mLWlA84LLZm7eoHNhY2RMlEW4rMSRvZ5/s0rout1BIF2WKoAvZtt0lqHj3M+uWrN9T
         3/0u8uMmFhql9ENBSe0lYdKuRAuOHUXG2iT4P75aXe75T8uLH9zupxW6kLsilHS2Qh
         B0FlbKFpc+KnK7VRLz4W77IoufXNm2EAfxGPP5BQTAXVJL8jxrN2rtmwlXNfHEG0RW
         4FpfLkPnOInoQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mturquette@baylibre.com, sboyd@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        y.oudjana@protonmail.com, angelogioacchino.delregno@collabora.com,
        jason-jh.lin@mediatek.com, ck.hu@mediatek.com,
        fparent@baylibre.com, rex-bc.chen@mediatek.com,
        tinghan.shen@mediatek.com, ikjn@chromium.org,
        miles.chen@mediatek.com, sam.shih@mediatek.com, wenst@chromium.org,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, kernel@collabora.com
Subject: [RESEND PATCH v6 7/8] clk: mediatek: clk-apmixed: Add helper function to unregister ref2usb_tx
Date:   Wed, 21 Sep 2022 11:14:54 +0200
Message-Id: <20220921091455.41327-8-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220921091455.41327-1-angelogioacchino.delregno@collabora.com>
References: <20220921091455.41327-1-angelogioacchino.delregno@collabora.com>
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

The ref2usb_tx clock was introduced a long time ago and, at that time,
the MediaTek clock drivers were using CLK_OF_DECLARE, so they would
never unregister.

Nowadays, unregistering clock drivers is a thing, as we're registering
them as platform_driver and allowing them to be kernel modules: add a
helper function to cleanup the ref2usb_tx clock during error handling
and upon module removal.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-apmixed.c | 9 +++++++++
 drivers/clk/mediatek/clk-mtk.h     | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/clk/mediatek/clk-apmixed.c b/drivers/clk/mediatek/clk-apmixed.c
index f126da693a7f..60e34f124250 100644
--- a/drivers/clk/mediatek/clk-apmixed.c
+++ b/drivers/clk/mediatek/clk-apmixed.c
@@ -100,4 +100,13 @@ struct clk_hw *mtk_clk_register_ref2usb_tx(const char *name,
 }
 EXPORT_SYMBOL_GPL(mtk_clk_register_ref2usb_tx);
 
+void mtk_clk_unregister_ref2usb_tx(struct clk_hw *hw)
+{
+	struct mtk_ref2usb_tx *tx = to_mtk_ref2usb_tx(hw);
+
+	clk_hw_unregister(hw);
+	kfree(tx);
+}
+EXPORT_SYMBOL_GPL(mtk_clk_unregister_ref2usb_tx);
+
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 1b95c484d5aa..62d650045cba 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -188,6 +188,7 @@ void mtk_free_clk_data(struct clk_hw_onecell_data *clk_data);
 
 struct clk_hw *mtk_clk_register_ref2usb_tx(const char *name,
 			const char *parent_name, void __iomem *reg);
+void mtk_clk_unregister_ref2usb_tx(struct clk_hw *hw);
 
 struct mtk_clk_desc {
 	const struct mtk_gate *clks;
-- 
2.37.2

