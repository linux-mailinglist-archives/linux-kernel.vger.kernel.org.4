Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CA86E0DC2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 14:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjDMMvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 08:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjDMMvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 08:51:45 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31ADA5E6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 05:51:42 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id k27-20020a05600c1c9b00b003f0a9f022beso606577wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 05:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1681390301; x=1683982301;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2NCSyvdX0SmPc9ExxsTpFJ2greUOcRi/vLBExtrGuM4=;
        b=VRVY6mW4C2eeH9XEL2rXf4kib+8LepoYm141EhEj4bMvddMWMZfWEbDgkVd2Fj86U+
         8XY43D+8ZnAkl+qpBUZPKykNENQ5Z2zTtvwwxjqsxoLGyN15QkzR6S/slTv51nhS+vNl
         5N3LR05EDvlN7cCZXDgERRZt6CthgOTM29OhPCTT9PWnp1NrXTcfWWrHxW1KAqIMjTR4
         QTTV9BH7BbOjgf1NeAgQSVmxdmGAnc8+GnrYry1RvKBlEC4Y5TjIV8VspCoEIef/ZZQk
         1JjNRHshJN85qXDV3vS/7/8E/HuDtNGgLzT1FUNEo0/qZmBLSorW4icPeTmIb4cHsuYq
         tUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681390301; x=1683982301;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NCSyvdX0SmPc9ExxsTpFJ2greUOcRi/vLBExtrGuM4=;
        b=SnD5y4X+2gb2s62kSjByBFYBqXr4T7oLN9ZLW7F4Yzh4ul8gk73pxe0JkIbucNJ1Lz
         +PXNAecsOLi5+m+ncsQjFfglXlLjOQ1pJ8/9N/GLglB2TkvvGxOAt6qHrO0c2d9nctYE
         ZIkXmc/VchaI0+o5JKgbMLpXstqFGJInoAj7ORUJUQ/+uQWddYcAtE1u78fJqqYba0Mg
         8rWor2cNwRP/ET3leWCLf4EVdulQ3ryMOlRV9iQMTqu1+ioVzfG6NJNykNSr7C2rVU/Z
         CjsWES8Dj0Sq0E0rXBrNEAaW213ADZS2gJYWWYboCqqZKA7KHgiVCKgcYBCESKH1QyX0
         XJfA==
X-Gm-Message-State: AAQBX9eYHOiquvW1//hAo0Xpl0+024nmbBHb4hH3FAHfYNNamYYiWN5x
        bdHf7dQGDsZ5furbS19pKP7bqA==
X-Google-Smtp-Source: AKy350aa1i5mgrVePFwrBlQob6A/5LRh1D6/2011CW+4P/unl+t6yKRaDKzFUe2AB+mGY/qtrWZ6aA==
X-Received: by 2002:a1c:4b0b:0:b0:3ef:4138:9eef with SMTP id y11-20020a1c4b0b000000b003ef41389eefmr1450843wma.36.1681390301230;
        Thu, 13 Apr 2023 05:51:41 -0700 (PDT)
Received: from [127.0.0.1] ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id k17-20020a5d66d1000000b002f67e4d1c63sm156356wrw.12.2023.04.13.05.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 05:51:40 -0700 (PDT)
From:   Guillaume Ranquet <granquet@baylibre.com>
Date:   Thu, 13 Apr 2023 14:46:26 +0200
Subject: [PATCH 2/2] phy: mediatek: hdmi: mt8195: fix wrong pll calculus
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230413-fixes-for-mt8195-hdmi-phy-v1-2-b8482458df0d@baylibre.com>
References: <20230413-fixes-for-mt8195-hdmi-phy-v1-0-b8482458df0d@baylibre.com>
In-Reply-To: <20230413-fixes-for-mt8195-hdmi-phy-v1-0-b8482458df0d@baylibre.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guillaume Ranquet <granquet@baylibre.com>
X-Mailer: b4 0.13-dev
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock rate calculus in mtk_hdmi_pll_calc() was wrong when it has
been replaced by 'div_u64'.

Fix the issue by multiplying the values in the denominator instead of
dividing them.

Fixes: 45810d486bb44 ("phy: mediatek: add support for phy-mtk-hdmi-mt8195")
Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
index e10da6c4147e..5e84b294a43e 100644
--- a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
+++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
@@ -271,7 +271,7 @@ static int mtk_hdmi_pll_calc(struct mtk_hdmi_phy *hdmi_phy, struct clk_hw *hw,
 	 * [32,24] 9bit integer, [23,0]:24bit fraction
 	 */
 	pcw = div_u64(((u64)ns_hdmipll_ck) << PCW_DECIMAL_WIDTH,
-		      da_hdmitx21_ref_ck / PLL_FBKDIV_HS3);
+		      da_hdmitx21_ref_ck * PLL_FBKDIV_HS3);
 
 	if (pcw > GENMASK_ULL(32, 0))
 		return -EINVAL;
@@ -288,7 +288,7 @@ static int mtk_hdmi_pll_calc(struct mtk_hdmi_phy *hdmi_phy, struct clk_hw *hw,
 	posdiv2 = 1;
 
 	/* Digital clk divider, max /32 */
-	digital_div = div_u64((u64)ns_hdmipll_ck, posdiv1 / posdiv2 / pixel_clk);
+	digital_div = div_u64(ns_hdmipll_ck, posdiv1 * posdiv2 * pixel_clk);
 	if (!(digital_div <= 32 && digital_div >= 1))
 		return -EINVAL;
 

-- 
2.39.2

