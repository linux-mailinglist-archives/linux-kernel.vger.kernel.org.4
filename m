Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46616E2821
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 18:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjDNQNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 12:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjDNQNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 12:13:04 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A580139
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 09:13:03 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-94a9606518cso314742566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 09:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1681488782; x=1684080782;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zYQcygXwpJtgvQS6PifePVs7bdptrcY70QQxe9GzfcI=;
        b=rQKGZqU143eN5We3KUXtGaJ9yIwyR38GoLyQ3zVVsNqkRfSQCVYSKrETwwWmrnjCTD
         /HL34ojcvfMZJbZ0Sl4svlgeAwoPZ3WUMJnQ3v6WfZkUsNd/EQIxX5eqKIPnCQwgNh6C
         vanXFx1ea4YdiPmkcDLjAg4k7fhKXybGahBHX3QAKqJw5d2OFaWJB9c8hx/mHdDgEnpR
         DgKJ4i9oZ7gMXUfue3BL2X4MHalODcpeL40PUcrwQ2GTaM7IpJ3vsgaJpVbqbusNGx99
         77enZYwgNFesCZGInlKblO0YU/FzpVHd0nkJ/h1X+lg1lnlLycaYycrPuHlZ3rrlON6W
         yH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681488782; x=1684080782;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYQcygXwpJtgvQS6PifePVs7bdptrcY70QQxe9GzfcI=;
        b=hgMf4VS7QZCTRvfQtIcrSE20nY/9qqVU2mhRYub3lYqdUFqdZ0ovbaol31jJW4z1aS
         iHFM33K+u4+KOXWj0zdM341wUJEOOYuyjvkbQQE6BB86kYea74ijt7reRZ0F7UFfNb6K
         DepAhAraEUqSY4FksOE2CJXkel3of1qC4bEhJVGnDsTLnDYTvasXdsToXZmeL1i1/1S1
         BekoLdPsRYrh2GMEWR+KNRU1ACbDFyYFh8aFz9XbhvJPmdkE7gUP/m+rgpWZldb73zBC
         u8JTPwhogyooSK0m8AttuGLZteYmIhK7LnV9Zau1Un+q8/IMOYsxtGB6ixTM0HjAf7ur
         ddtg==
X-Gm-Message-State: AAQBX9c7NPgpgrkX11eAYYvV26eQyBwu+pZ9fgdl3u8mqbhfLopkaYhU
        Z35v1trPs9dYw47wiP+DjXNgrg==
X-Google-Smtp-Source: AKy350ZwPnR35MbzJwWg/cyopvybTKJ6He8maInl0W5V/A8A8m41PdLFb40JKrxf0JIz/8Mq7iEGrw==
X-Received: by 2002:a05:6402:100d:b0:504:80a4:d019 with SMTP id c13-20020a056402100d00b0050480a4d019mr7138523edu.12.1681488781860;
        Fri, 14 Apr 2023 09:13:01 -0700 (PDT)
Received: from [127.0.0.1] (2a02-8440-d20f-2c76-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:d20f:2c76:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id h23-20020aa7c957000000b005066ca60b2csm2242687edt.63.2023.04.14.09.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 09:13:01 -0700 (PDT)
From:   Guillaume Ranquet <granquet@baylibre.com>
Date:   Fri, 14 Apr 2023 18:07:46 +0200
Subject: [PATCH v2 1/2] phy: mediatek: hdmi: mt8195: fix uninitialized
 variable usage in pll_calc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230413-fixes-for-mt8195-hdmi-phy-v2-1-bbad62e64321@baylibre.com>
References: <20230413-fixes-for-mt8195-hdmi-phy-v2-0-bbad62e64321@baylibre.com>
In-Reply-To: <20230413-fixes-for-mt8195-hdmi-phy-v2-0-bbad62e64321@baylibre.com>
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
        Guillaume Ranquet <granquet@baylibre.com>,
        kernel test robot <lkp@intel.com>
X-Mailer: b4 0.13-dev
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ret variable in mtk_hdmi_pll_calc() was used unitialized as reported
by the kernel test robot.

Fix the issue by removing the variable altogether and testing out the
return value of mtk_hdmi_pll_set_hw()

Fixes: 45810d486bb44 ("phy: mediatek: add support for phy-mtk-hdmi-mt8195")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
index abfc077fb0a8..054b73cb31ee 100644
--- a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
+++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
@@ -213,7 +213,7 @@ static int mtk_hdmi_pll_calc(struct mtk_hdmi_phy *hdmi_phy, struct clk_hw *hw,
 	u64 tmds_clk, pixel_clk, da_hdmitx21_ref_ck, ns_hdmipll_ck, pcw;
 	u8 txpredivs[4] = { 2, 4, 6, 12 };
 	u32 fbkdiv_low;
-	int i, ret;
+	int i;
 
 	pixel_clk = rate;
 	tmds_clk = pixel_clk;
@@ -292,13 +292,9 @@ static int mtk_hdmi_pll_calc(struct mtk_hdmi_phy *hdmi_phy, struct clk_hw *hw,
 	if (!(digital_div <= 32 && digital_div >= 1))
 		return -EINVAL;
 
-	mtk_hdmi_pll_set_hw(hw, PLL_PREDIV, fbkdiv_high, fbkdiv_low,
+	return mtk_hdmi_pll_set_hw(hw, PLL_PREDIV, fbkdiv_high, fbkdiv_low,
 			    PLL_FBKDIV_HS3, posdiv1, posdiv2, txprediv,
 			    txposdiv, digital_div);
-	if (ret)
-		return -EINVAL;
-
-	return 0;
 }
 
 static int mtk_hdmi_pll_drv_setting(struct clk_hw *hw)

-- 
2.40.0

