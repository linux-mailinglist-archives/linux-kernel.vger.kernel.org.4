Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC74C6B663B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjCLNNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCLNNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:13:37 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4763A23117
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:13:35 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id fd5so4617080edb.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678626814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msjur9BIXfohR7MjKiHFK0aZDyGMTPkmem6NEGtsCjU=;
        b=OjW7Ch3WzJANLx1nyByhnbnA+p4+Psja196A21bF0aDMZDj+CjUc/V3NpqZSVXJz7J
         Q4s69NqmOUkMcMhUM52lRFAx8K6Hn3pTbfhlcNGcvYtm9T/Xdmpa1eFwio1guKXpLMjx
         /GbbBdI/iGN+TR2BIZr+OCddK8GbN3qlNgAEbLoQvrd9hqX8CNUxQUr1whlLYlnttiCD
         2ppydo1QRfSLe7qEMLz239tuUQR12OAwkuyjl7KW/bFdhhaPMbQAkE3KxuO+3gWxoGJ9
         OsgpWpgMvsI/YzdsoXmnuGMMDhZQ/0cnC86nUpxdiwnlRbtFNGkMGuAkbk1zVOtaFonr
         m6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678626814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=msjur9BIXfohR7MjKiHFK0aZDyGMTPkmem6NEGtsCjU=;
        b=zLALnQKdHMetSsSp9WF7HH0rGE9jxxqE+ZjFRjCpvOKGko05c5ONlVEGiGSbjyBOmr
         y5l389x/6Sd5FT7scwTlz52Ja1LBNinvmVyhq1Q9Eon6E5+EkxByGJU7qAJ2GD4Qs40b
         4gwwH1tT8NTccchDKf5RqNFkCNkEEI1xfEk9ej7YAPD7ZkpqqH+LbBOaOfxDL2ALYNaw
         1EpSTPW4feVFGDfEbBtVYK6PE/WBlk30yIZv9YO0MEUTva/ra+N1fimrtwuqGSaZv4k/
         M/iu4OoAFSzhtku+3A5iMJVktKzrFDVGeMxuCModpwRCQ0rt9jgsisyCxPwTyYvARvpY
         zL5w==
X-Gm-Message-State: AO0yUKUlB/qsbuETOLsRLrak1M381Nd5nj5n/xkvYo5LcyXRvE/APrmr
        rMBjRz3j9jgOlsQLnbbUxFuKYg==
X-Google-Smtp-Source: AK7set+x2TzZ8b+2TPoP/NPOIph3epGLp33Dj5+VNI5L1g2bCpHKzqAG9L+GEAXmbu6Kg//PKl57oQ==
X-Received: by 2002:a17:906:5206:b0:8b1:7fa:6588 with SMTP id g6-20020a170906520600b008b107fa6588mr30618440ejm.12.1678626813798;
        Sun, 12 Mar 2023 06:13:33 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id r19-20020a1709067fd300b008eddbd46d7esm2213279ejs.31.2023.03.12.06.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 06:13:33 -0700 (PDT)
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
Subject: [PATCH 05/28] media: rc: gpio-ir-tx: drop of_match_ptr for ID table
Date:   Sun, 12 Mar 2023 14:12:55 +0100
Message-Id: <20230312131318.351173-5-krzysztof.kozlowski@linaro.org>
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

  drivers/media/rc/gpio-ir-tx.c:24:34: error: ‘gpio_ir_tx_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/media/rc/gpio-ir-tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/rc/gpio-ir-tx.c b/drivers/media/rc/gpio-ir-tx.c
index 2b829c146db1..1a8fea357f14 100644
--- a/drivers/media/rc/gpio-ir-tx.c
+++ b/drivers/media/rc/gpio-ir-tx.c
@@ -199,7 +199,7 @@ static struct platform_driver gpio_ir_tx_driver = {
 	.probe	= gpio_ir_tx_probe,
 	.driver = {
 		.name	= DRIVER_NAME,
-		.of_match_table = of_match_ptr(gpio_ir_tx_of_match),
+		.of_match_table = gpio_ir_tx_of_match,
 	},
 };
 module_platform_driver(gpio_ir_tx_driver);
-- 
2.34.1

