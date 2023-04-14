Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9E06E2822
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 18:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjDNQNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 12:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjDNQNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 12:13:05 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8182136
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 09:13:04 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-504eac2f0b2so2896101a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 09:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1681488783; x=1684080783;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=flkZrEmQ4lhBir76YpEsiit3KQbCll7hap6g9ky4XjY=;
        b=zaTmkBAJWvJky4Aq1jB49C5WY+IgRDVMOCslR69Vl6Fgr4/MRocM/kLTVgfUS8Vc9t
         Q5XzQKszCuzICokhmRt1Go9VJJvcH1uT6f+5rfYnMRm/VGeYBqxiP4x2NmQ1MevYDkjN
         Lxk0CUgrBgJbq5FMC8z4GlSzvTMMDwmIo9sndS4eHwEvB5es271P2gctIkx59RCxGrjD
         qQOHmZ/zRLOW555qQAT+JAPtnfGECgKfLCX77sAM0b2vkpi1jeX85CPnkPEabfcUueWU
         o/6fqwlu5lZhedeQOhwirSYVKUm8EFzTq31Ybde4rBY1SDN7cNyHo866FrH2kGX024ZB
         3Y+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681488783; x=1684080783;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flkZrEmQ4lhBir76YpEsiit3KQbCll7hap6g9ky4XjY=;
        b=kzlcmRuwnqnhE1lwSZQO1xSEVNN9IqzMNaFyv6hbNSHoZwRAilW8bU3sHkzAipaC6W
         D5isZInhSxUosSvsHRh6VMnH0vDCsDyVXYHSYOGIw9pZbtoNOpvet5WRAL2Z4aIF76bz
         rP8SO0WYrOufku6b3GQ0EicoXsY5cjpJIH9KMXSYYoLEyHTXNeuQdVN+N/aI0/F8ijq4
         aclcXLBX6tIGN4a+ODmFo0ERJszlZxcJKzaZFv6FEatoMhqhrj9DGvMcOEheAxUt8gIB
         GyWkG1UEkUvrhea2ebIILeElYmBjFuDl0S22JSeDOK152Lh2wqqWkQm/1eFYFTJSHHi8
         bwOw==
X-Gm-Message-State: AAQBX9c67bx0Gl6ZkyjhNh3F2zxk0SM/OjgHWrK8ymk/dpUR1ClO+PGl
        2oQpeZCPM9nV6cDaHIiZabjRig==
X-Google-Smtp-Source: AKy350b2JE8Qx2Y+iWCoW/RhZBJ5V4rhMWPwFiGL7k5VHEtk/DsRY4ZLJHBMfiz8yCcBW8ZuvdtkfQ==
X-Received: by 2002:aa7:d85a:0:b0:506:8e06:8b4b with SMTP id f26-20020aa7d85a000000b005068e068b4bmr290176eds.8.1681488783366;
        Fri, 14 Apr 2023 09:13:03 -0700 (PDT)
Received: from [127.0.0.1] (2a02-8440-d20f-2c76-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:d20f:2c76:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id h23-20020aa7c957000000b005066ca60b2csm2242687edt.63.2023.04.14.09.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 09:13:03 -0700 (PDT)
From:   Guillaume Ranquet <granquet@baylibre.com>
Date:   Fri, 14 Apr 2023 18:07:47 +0200
Subject: [PATCH v2 2/2] phy: mediatek: hdmi: mt8195: fix wrong pll calculus
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230413-fixes-for-mt8195-hdmi-phy-v2-2-bbad62e64321@baylibre.com>
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
        Guillaume Ranquet <granquet@baylibre.com>
X-Mailer: b4 0.13-dev
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
index 054b73cb31ee..caa953780bee 100644
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
2.40.0

