Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76D26B6639
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjCLNNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjCLNNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:13:32 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4E520698
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:13:31 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id j11so38512356edq.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678626810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNTv3xaa9umrxHIJgX0gdbiFrLg5kepDivQRRUUNj8Y=;
        b=mG8+ne6l7Du079iLYFKAm363rTLrrVtTa9ONV2FnnfYLx9z+0BUd74yGDBf9AzPZxX
         QrZ1KXjPmZf0WaAdFO37yPbgZoFxApLLMBsvJhu0hu5AW8aFuRFAdxj0wXjl1Z2FwCdu
         A4uVkL//3t8ItL3/TvFvjOEN6RlwsHBJdOhPwcGGiW6TDk18/oOJ7BImmuG6/EVxPy3s
         89BwwXEdnsV28E71nkiplp+F7zUpWYoW1St11csIMZGdqp/Iz2ukoaZ+bo2P2g/WaIIZ
         jSkYNJB5oJPV1nTr/X5JQWcZ9oaHyq9x+77xqkR56N7qw6d3Vd9krj0g1cqQ9OIP4G3V
         xZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678626810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNTv3xaa9umrxHIJgX0gdbiFrLg5kepDivQRRUUNj8Y=;
        b=omxwKUyBw+7Psjz0b2nhHrvTfPiNdLAV7UMLNtc6X976jLt+4m7kBNXVXdxKSagViD
         fxn9nR6Eg28ZWs2Kx9mRLsT/QPMC6L+/sTgHAIX32JPz/6aSyu1qeU56LteU67cVqFiW
         /5ln7rt0I/WSxzdT/JYo+Gfig2osrtYtOmTA2cDRz/BvGgO+qNeTQe8YojD5XNiPp2Bm
         is8Rkgad4PHxoyngnUGZ6mU63Sjy1wTN2p+HIZTJpzxxNm6dJq+TLez3/vUzcLLm13Xp
         GpYBpaBSFVUmeyStvJcI4D2RUnMfUJtk4ssUVlDModoH3eta+t49+yKvRUPUCK7mlHHQ
         enwg==
X-Gm-Message-State: AO0yUKXnb1nYNH1Rr1y36RBjaoMPGdQvtg4Yf9ViVB7+ilNtRJeYfPWk
        IGZqU1LQEMjsWtegPM02WhPDGA==
X-Google-Smtp-Source: AK7set9hIVqb2QRhYpBrnz8OxTvSZYTsM/7cq1IWZ524Geu7mNPCnFJjF+tKxEOcIui41/2nlHg9Mw==
X-Received: by 2002:a17:907:869f:b0:8a6:5720:9101 with SMTP id qa31-20020a170907869f00b008a657209101mr37675191ejc.4.1678626809819;
        Sun, 12 Mar 2023 06:13:29 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id r19-20020a1709067fd300b008eddbd46d7esm2213279ejs.31.2023.03.12.06.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 06:13:29 -0700 (PDT)
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
Subject: [PATCH 03/28] media: cec: tegra: drop of_match_ptr for ID table
Date:   Sun, 12 Mar 2023 14:12:53 +0100
Message-Id: <20230312131318.351173-3-krzysztof.kozlowski@linaro.org>
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

  drivers/media/cec/platform/tegra/tegra_cec.c:457:34: error: ‘tegra_cec_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/media/cec/platform/tegra/tegra_cec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/cec/platform/tegra/tegra_cec.c b/drivers/media/cec/platform/tegra/tegra_cec.c
index 5e907395ca2e..7115636ca748 100644
--- a/drivers/media/cec/platform/tegra/tegra_cec.c
+++ b/drivers/media/cec/platform/tegra/tegra_cec.c
@@ -464,7 +464,7 @@ static const struct of_device_id tegra_cec_of_match[] = {
 static struct platform_driver tegra_cec_driver = {
 	.driver = {
 		.name = TEGRA_CEC_NAME,
-		.of_match_table = of_match_ptr(tegra_cec_of_match),
+		.of_match_table = tegra_cec_of_match,
 	},
 	.probe = tegra_cec_probe,
 	.remove = tegra_cec_remove,
-- 
2.34.1

