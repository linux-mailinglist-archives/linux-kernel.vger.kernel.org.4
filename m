Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EAB6B6658
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCLNPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjCLNOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:14:14 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C5F515E0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:13:50 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g10so9628317eda.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678626827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSjnY2UnQpgl55C0x0EbScbpZu8mF5QaFScRi5nrBhc=;
        b=Dc26ZIuGptSW54drxYTvMfBZdnM7T2sqH0Ibrn8Isnx72gXt6vIiQrkYJ/ZXRTKeJu
         wXhScqvsjvycZ/sKKYPGCAOgFQPC157JwyaE2cQ5Co/gRVglSKhEm/qSXfGf8d6yTlWu
         NQEJdDvJriyTDULJvI7FxJ1RcMzG6pc3xa2jz7zclJQIsfcQW/69r3MrW5frrZZEiMUs
         8GlhS8zDtnKywTPP15jmvqXI2iI0UA8V27Mp8bX/cYx8afzVMoEJ++NwRakEsYUy8UnR
         X9/AcWhpkrweQyKVI5gMG7fObgCTsIyIHVoFEj8R4G5wb79/ddG9Kmwm4kVDZBQihQMt
         3fnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678626827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSjnY2UnQpgl55C0x0EbScbpZu8mF5QaFScRi5nrBhc=;
        b=VqqT9db6RzxQOAxDoCXxSt8++nLFRAns9DbCHwm3544E2FshPQhxWAeqImA50y4QBS
         CrPB+fLK0gLV1xquU3eNHyHXpE43Xxp8UJ0dYU5Rm1xo41bGMe1QbQv2O8r7RGyW93jV
         aashQE0YQQLIQGh1i6jWOvq3jjWf0k1ehUhDumFdApOGSUFsQm+SGOnx34ckPgsbutb2
         qdvlrzTJ+9Md19IadfYS1bc7EkXFjpPR1NA9XCqSDtRpFOsG7NwXmMbfogtf6uJhooYH
         3NhRz2T3apKZvLMubUzodxebpmn8vkxgTZ1ijtOHIpVJmiobW0ypG9rOLvdzreLvmkTm
         VrGA==
X-Gm-Message-State: AO0yUKXViIwV63HAdgnMYsI/JzfMlWwKTCeXXaWt0k38Djbe8/J759kX
        i5f1Jy0RGB5+lrL54ksOoxHaIw==
X-Google-Smtp-Source: AK7set/fcAtAWgh3+TRqI/ZkpAQaBtS1MV/NpNDoPVgH7rYzBAYx5gtRCk/B6oCX3nWaWawSfNsODg==
X-Received: by 2002:a17:906:db05:b0:889:5686:486a with SMTP id xj5-20020a170906db0500b008895686486amr37991558ejb.30.1678626827320;
        Sun, 12 Mar 2023 06:13:47 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id r19-20020a1709067fd300b008eddbd46d7esm2213279ejs.31.2023.03.12.06.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 06:13:47 -0700 (PDT)
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
Subject: [PATCH 12/28] media: platform: verisilicon: drop of_match_ptr for ID table
Date:   Sun, 12 Mar 2023 14:13:02 +0100
Message-Id: <20230312131318.351173-12-krzysztof.kozlowski@linaro.org>
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

  drivers/media/platform/verisilicon/hantro_drv.c:622:34: error: ‘of_hantro_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/media/platform/verisilicon/hantro_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index b0aeedae7b65..4041b5b38c4b 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -1135,7 +1135,7 @@ static struct platform_driver hantro_driver = {
 	.remove = hantro_remove,
 	.driver = {
 		   .name = DRIVER_NAME,
-		   .of_match_table = of_match_ptr(of_hantro_match),
+		   .of_match_table = of_hantro_match,
 		   .pm = &hantro_pm_ops,
 	},
 };
-- 
2.34.1

