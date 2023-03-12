Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290976B665B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjCLNPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjCLNO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:14:28 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACC1521D9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:13:59 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id er25so10370216edb.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678626833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnLBQwh0LWohgIW0ttdnCRYb1T+hHfqYVBdWUEvm5SY=;
        b=La4x93DEoIwur2ndgJwLR2ny+YVu7M7nkEdhVk1ax5v8kLMw3TJYokXlZF8BTLzFjr
         PRu/S0l02NyAfTpFe4pEI66UWaAF6uJmcsVb1BR2FK6jsIfvFwDPOFk5wFG2iVlmIxhI
         ZJ/g12UWKozHWmTzOeZepQ3MJ3r7QVlHcomJFs3p2sPClVH5Gx16kWz33VatYadsdgFk
         8+5zH1m4BC6cKBxTckNMY0KDC0pilc1T9xae70XkESQD63z5dT3nFJX5kwAf9svjvpJT
         c3i2O6EBh/quArbGNHgqQMbDNPKQh6Z10jClmZdBJqN51EgX8JTNuD0PGN37wDWnlHFV
         5sZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678626833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnLBQwh0LWohgIW0ttdnCRYb1T+hHfqYVBdWUEvm5SY=;
        b=awbkFsR3TkNspZbg6G37dYysBllk+PKFZBj1bXcbNIG7WOPG59dHiCnmFG28OdQbA8
         ROg6QNQ9DsNYiLi4DGPgmQ0+bvSsSvK/oRu2YcsoN6wGwAWncNuFD7mw0xdBG/14YZtd
         u3dKWLBmUWDP9w/A6CF9o5mOseymdBLRoXqQwOMfRQiE1nje/vt++MOHOUgu9+ru63Qh
         6Ftup6iU8zzdrZ7v0lYfhVv6nWwCTqOTXd+RcJg7vuTpSEQhUgNA7T8tKI5gdJKEyxVp
         awsEuykXIVTw6od1KBn4Zi5L/tATGTX+ccyfHFXmN3+TNwLSuAssfNTTjB5YMgM4q7rx
         0FBA==
X-Gm-Message-State: AO0yUKW01F1L436aaOBDg1uFwH7hcV5rfLUSTXW3h5tC7I/IrqF8HfT6
        atfMCl1vMused9IICKfCidJdSQ==
X-Google-Smtp-Source: AK7set9Bjjfvn/Sovq5DWKvwxol1DOkWW2/CuykQR76iLeg9De2xNQq2nnrXH4F7baVnuHw64PeF1g==
X-Received: by 2002:a17:907:1c1f:b0:884:930:b014 with SMTP id nc31-20020a1709071c1f00b008840930b014mr39417055ejc.6.1678626833357;
        Sun, 12 Mar 2023 06:13:53 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id r19-20020a1709067fd300b008eddbd46d7esm2213279ejs.31.2023.03.12.06.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 06:13:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Joe Tessler <jrt@google.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Wenyou Yang <wenyou.yang@microchip.com>,
        Bin Liu <bin.liu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-rockchip@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 15/28] media: platform: mdp3: mark OF related data as maybe unused
Date:   Sun, 12 Mar 2023 14:13:05 +0100
Message-Id: <20230312131318.351173-15-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230312131318.351173-1-krzysztof.kozlowski@linaro.org>
References: <20230312131318.351173-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c:627:34: error: ‘mdp_sub_comp_dt_ids’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
index 091a68685590..817ba9660b5f 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
@@ -604,7 +604,7 @@ static const struct mdp_comp_match mdp_comp_matches[MDP_MAX_COMP_COUNT] = {
 	[MDP_COMP_WDMA] =	{ MDP_COMP_TYPE_WDMA, 0 },
 };
 
-static const struct of_device_id mdp_comp_dt_ids[] = {
+static const struct of_device_id mdp_comp_dt_ids[] __maybe_unused = {
 	{
 		.compatible = "mediatek,mt8183-mdp3-rdma",
 		.data = (void *)MDP_COMP_TYPE_RDMA,
@@ -624,7 +624,7 @@ static const struct of_device_id mdp_comp_dt_ids[] = {
 	{}
 };
 
-static const struct of_device_id mdp_sub_comp_dt_ids[] = {
+static const struct of_device_id mdp_sub_comp_dt_ids[] __maybe_unused = {
 	{
 		.compatible = "mediatek,mt8183-mdp3-wdma",
 		.data = (void *)MDP_COMP_TYPE_PATH,
-- 
2.34.1

