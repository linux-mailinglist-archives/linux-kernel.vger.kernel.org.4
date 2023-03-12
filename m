Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B69E6B667D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjCLNQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjCLNPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:15:24 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C86424736
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:14:27 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g10so9630775eda.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678626851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THpEp92433h+ylj7MjAYKkh14oWq1rOr1JhG8G/iCi8=;
        b=oAmaUM64wINePdwiqsLNucIG+F9KVg+0pWxZOpOISN2zYDiUgU/yv8K5zf+HIZRWPZ
         gqp4IIjSd7LtENMJBZIt7lshH2rvnihGtVbM63owEfuqy1ZnRmPYbqfol/+ZvEOFrVHd
         VrpVxvSPZkZ184qqVYaaA01f9WueIzTpU4xqyjJwEvnUqnT3eZZIWAaIJ47PeOYFqomk
         OLUX3ERM+cf4hPKZE2o+qFFER0cVDl4rCmbPRj/hJ99arP84p18QGB2xvAsldfupkt19
         8HnLUAFOtlXajbO89E+91nZDyTEEkk6iYKERayn5ufjor7DdI4g+Ukx48Qb0WK633X4i
         4kDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678626851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THpEp92433h+ylj7MjAYKkh14oWq1rOr1JhG8G/iCi8=;
        b=TA1h2UM7CsnfwA/slVi5CZ1oaVlDC8kPxtszSzrgbHH8uSo4m2omFfWHa4Tgfljeof
         FEDWW/jxktk3ytU8pcC4wlwWkl8gtHCaMorVHFLEAvSxdsXIWaNBwqU6Q/IIebobg+Nd
         0qwVsFTh1HjsN6eUCBYuE6dePIS7aoy3egWrWNa1UAKpH17Oo/xszgUR9B0qcCVdw+cu
         tMuesc/qsG7IwuqoPrWAU4HzLJy0U3h7vzjGqDEP6FZ+jSQpqBvbJx16BJcbVnd7Ml2Q
         JPZ2IH3WsPjVxdex3j/9316Qbzi8f4nxCyU/I/ntSg17+ZY27rwy+0GTKJ9ec8ogclhV
         Efgw==
X-Gm-Message-State: AO0yUKWqLOYe2rY79TLswFSG8jlcylH0AAydZVRwCDsYsVT02qokOrFV
        6nOnFoD6/aBPRdxd/22tVvIkXg==
X-Google-Smtp-Source: AK7set+tfDLUKN48RCQQAskWmohpYOld4F3QVzJjtSNuw8cfZUaPqmD3dqlxAS7yrTZJTXMv3+HlmQ==
X-Received: by 2002:a50:fc0b:0:b0:4fc:88d8:a031 with SMTP id i11-20020a50fc0b000000b004fc88d8a031mr69807edr.28.1678626850958;
        Sun, 12 Mar 2023 06:14:10 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id r19-20020a1709067fd300b008eddbd46d7esm2213279ejs.31.2023.03.12.06.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 06:14:10 -0700 (PDT)
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
Subject: [PATCH 24/28] media: i2c: ov2680: drop of_match_ptr for ID table
Date:   Sun, 12 Mar 2023 14:13:14 +0100
Message-Id: <20230312131318.351173-24-krzysztof.kozlowski@linaro.org>
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

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it might not be relevant here).  This
also fixes !CONFIG_OF error:

  drivers/media/i2c/ov2680.c:1149:34: error: ‘ov2680_dt_ids’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/media/i2c/ov2680.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov2680.c b/drivers/media/i2c/ov2680.c
index 54153bf66bdd..4d8724952c5f 100644
--- a/drivers/media/i2c/ov2680.c
+++ b/drivers/media/i2c/ov2680.c
@@ -1156,7 +1156,7 @@ static struct i2c_driver ov2680_i2c_driver = {
 	.driver = {
 		.name  = "ov2680",
 		.pm = &ov2680_pm_ops,
-		.of_match_table	= of_match_ptr(ov2680_dt_ids),
+		.of_match_table	= ov2680_dt_ids,
 	},
 	.probe_new	= ov2680_probe,
 	.remove		= ov2680_remove,
-- 
2.34.1

