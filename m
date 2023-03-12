Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C706C6B665F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjCLNPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjCLNO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:14:29 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE072200B
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:13:57 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id y4so9044685edo.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678626837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSUxJvmcYZNHU5p44Si/GkT5n4QeYi/m+nC/+jkGmUY=;
        b=XUpM8Rmy7PnFzNbcL0zTFiuJpFVfxvLHNToRAg/PEhIOn5i3jUDYTrbExuiifCZjBa
         lrh/2gHR1SNfhiAIupdMYuN4BiECY5PDduKMVCgt/dKreE5Wg/tVSsTwrkD15OLzXkYx
         Ecua631wVTD/Oxl54ZVfyIQui2oVuNhx2mQFPm7RKgxRlbbEeYYitaPl/BlXPCrgNlUX
         XZF4sEohO6jZjxrG3VlNIM8pUxH96L5LPxy7NJI/31wC+MsSl6gwuHKl1HyQ4rEQUAi0
         WqFYN5wDqaG6b4ITF6OJjFk5JtUhKdpb608LUw4oYj30y83+6sqO96df1Ud9vqsBjNlQ
         hVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678626837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSUxJvmcYZNHU5p44Si/GkT5n4QeYi/m+nC/+jkGmUY=;
        b=iWF+ub9TOsCByZieDtLUVyXHjTHFyoka19GfhKlvlBOyarRoiDhTcQKTqX1h3xx8G4
         o5qQ6xKmD7o8TloRpmMr2xb4A5l2DkvypZAKo/sIMyowwyUmvMJTC2PrapGhGdL5+wAs
         YSw7+jjZGguUPfZTQeqdbHiP9E4gHirSds0XSRuSWBDjrCaeTrCUqsVTrHk26MvYaclb
         vYiVMMM541zf/IaTsMghgF+XNLcTewWjB/JPgODarnkbEDf1rU0h4dSC9aECmqlT6D6a
         OpGez/chwbi+cL/8L9jZ+7bdpl0g92//ENKWURXXhPkhWg2eLpb+F9O8aGWDtnDD1XAj
         0fMw==
X-Gm-Message-State: AO0yUKVdUP4eqpjhBQFV+D1PpT6MS6pmqYJWlcHGDLm5ae4t3nNKfyHT
        xyh6EYpzxO6roX1fr64i3GH0Gg==
X-Google-Smtp-Source: AK7set88AuX6ejtTeUpkVuYiIVeDjSz3hY6JSMWqIppvJBvfzaC26FemUOmCOTaRkYyk9DXQpBQS4g==
X-Received: by 2002:a17:906:1d01:b0:923:1714:b3d0 with SMTP id n1-20020a1709061d0100b009231714b3d0mr3219717ejh.19.1678626837477;
        Sun, 12 Mar 2023 06:13:57 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id r19-20020a1709067fd300b008eddbd46d7esm2213279ejs.31.2023.03.12.06.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 06:13:57 -0700 (PDT)
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
Subject: [PATCH 17/28] media: platform: sun6i-mipi-csi2: drop of_match_ptr for ID table
Date:   Sun, 12 Mar 2023 14:13:07 +0100
Message-Id: <20230312131318.351173-17-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230312131318.351173-1-krzysztof.kozlowski@linaro.org>
References: <20230312131318.351173-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it might not be relevant here).  This
also fixes !CONFIG_OF error:

  drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c:751:34: error: ‘sun6i_mipi_csi2_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c b/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c
index a220ce849b41..0851b6b4e1ff 100644
--- a/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c
+++ b/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c
@@ -759,7 +759,7 @@ static struct platform_driver sun6i_mipi_csi2_platform_driver = {
 	.remove	= sun6i_mipi_csi2_remove,
 	.driver	= {
 		.name		= SUN6I_MIPI_CSI2_NAME,
-		.of_match_table	= of_match_ptr(sun6i_mipi_csi2_of_match),
+		.of_match_table	= sun6i_mipi_csi2_of_match,
 		.pm		= &sun6i_mipi_csi2_pm_ops,
 	},
 };
-- 
2.34.1

