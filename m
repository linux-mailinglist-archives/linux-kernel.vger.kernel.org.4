Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1986B6670
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjCLNPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjCLNO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:14:58 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B8B497D1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:14:13 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id s11so38495558edy.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678626853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+WYHU/SqewTwrfZuCdGJulxf+5ECuJ2svWptTLYXIE=;
        b=qa63Qo9fSC+Ap6jq8NDE2/EKVxm+oVWK3PFoPnwE4yBlATkz7TLk5YW9j1Aus6jlO4
         6yc4oApxJj/EDKros+pMJB38lQNWN1egudsvqOCBUzYW64WGkXUr4UF5uvMAhzPeK5rn
         MFPFUDZQfSOayCcp9U5gDPkJDFkGju6UWmsy9KCRljegOCC7go6mgN7GfCuyf/VdVbFD
         RI2fxqf3sl093J1Dwc5Jpz0d+PVkRtuxgBckuhSs48nPfSE/o9nrnsQU4Mp4x4rkVe1u
         GMHKWSQnkdmVR/BpH9WvboP+5QMDYLm5XUHxVqEXRB/RgiCPMXI3gOvVA9FVBVyWZXAk
         RPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678626853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+WYHU/SqewTwrfZuCdGJulxf+5ECuJ2svWptTLYXIE=;
        b=U/q8A/MYLvNM/FCbmbhQkhEl52gunvwpUhir5I5srpffvOyW7q3qeYIbEXvQRxoo8z
         uAxzVHjuXkzr7MCKUTPt2/DssFBddz5xUiSiIuIR4+kHQmUZhGb1kuPWqjR/hbL+vhNo
         f/tKWo23yLyuyP/f22HsNasY+qvHUZ2Jebpl+5Z7csVSJQUO1Iy3cpTroWjjs5X1qlA5
         YeEZKDgXaLEPM6AZLtuj638jZg0qxm7LzVzesuxyaAM87ePEocmmVO82wAFLbB4GYeHu
         xupObjsCd/aSSQ4htPNk4BOrc+1r3tfCv5elBIemkqXTQjOrhG5LeWng89l4+7PzkE1v
         YSzg==
X-Gm-Message-State: AO0yUKUskHdLyQfqPWywwk+FGxnQCaTmtHlPig9XfYkfCgI0MSC+7p/Q
        bjPsjEy7augb2Q48ZJzKKaoH6g==
X-Google-Smtp-Source: AK7set+ykF8LuOJPvpEW6vSvb+7ovcB0VmDW/wPOL+5hsoHHErX+DX/e38bZbR9JDZSOpCTKdXlvqQ==
X-Received: by 2002:a17:907:72c7:b0:889:d156:616d with SMTP id du7-20020a17090772c700b00889d156616dmr37155221ejc.27.1678626852856;
        Sun, 12 Mar 2023 06:14:12 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id r19-20020a1709067fd300b008eddbd46d7esm2213279ejs.31.2023.03.12.06.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 06:14:12 -0700 (PDT)
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
Subject: [PATCH 25/28] media: i2c: ov7740: drop of_match_ptr for ID table
Date:   Sun, 12 Mar 2023 14:13:15 +0100
Message-Id: <20230312131318.351173-25-krzysztof.kozlowski@linaro.org>
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

The driver will match mostly by DT table (even thought there is regular
ID table) so there is little benefit in of_match_ptr (this also allows
ACPI matching via PRP0001, even though it might not be relevant here).
This also fixes !CONFIG_OF error:

  drivers/media/i2c/ov7740.c:1203:34: error: ‘ov7740_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/media/i2c/ov7740.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov7740.c b/drivers/media/i2c/ov7740.c
index c9fd9b0bc54a..42121916d25f 100644
--- a/drivers/media/i2c/ov7740.c
+++ b/drivers/media/i2c/ov7740.c
@@ -1210,7 +1210,7 @@ static struct i2c_driver ov7740_i2c_driver = {
 	.driver = {
 		.name = "ov7740",
 		.pm = &ov7740_pm_ops,
-		.of_match_table = of_match_ptr(ov7740_of_match),
+		.of_match_table = ov7740_of_match,
 	},
 	.probe_new = ov7740_probe,
 	.remove   = ov7740_remove,
-- 
2.34.1

