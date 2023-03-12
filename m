Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782C76B6651
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjCLNO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjCLNOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:14:07 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F195509BF
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:13:47 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x3so38433455edb.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678626825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mi2x5KmVHY8aFVS8WFaKRIl7phB/m6sMx8X9ScJ0O1Y=;
        b=GG1FZzu4R08U7ZrQJTDqnm9yyObLtqMDWCx3B/cxyKmqz+Inu/lGru3GBlSAmoNZ2d
         WS9SlIFw7l28qxUjUEIBnfHvBpm5c6g1F4pUDGTJklw6dfbWjyAvPQGUtVzR7OyvFiyQ
         dyuSUmpAGQUkWb8ymF+2KyhC2+95GCs3P8qBCovptLLx92YGuEIvrF2/nQKp3RKdKB2q
         4WRWxJI+thxZatMOq8kxvNE8yRXL8FB+dRcXQH7oOSuC9AcNWcYgasCTPck/INBz0sk4
         D5bd8nEqJArLbuAbevCLQSORbLT9ASQ4UO6q9+5gCJHqKdXkvauSNJboZF8dLbTMmvXn
         eDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678626825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mi2x5KmVHY8aFVS8WFaKRIl7phB/m6sMx8X9ScJ0O1Y=;
        b=rvKLTtjAsJkSIn2ckWRUZpixNuKxLakRci7NlsrpZ+6+78wbG5a+rlp6ootzNZeTTI
         k6g1OoyboFhjNCb8pFf4239DwHTybLg6ey19vxEXLT3oTd6s6PjK0Kih/z0y142/HPer
         CIyKjFnYo6BWWGhjddI1OQJa666ZS4hPpqXGHPrW4y5u8OKG9VqJb0VHHJ3Ll93QnEIE
         LWXE5FAdkjyUFzwv4AawaUmut36ThRXybH700jmIZReP1oqDl8RontRSWk77S9lcBZwR
         qKfnoEuc40BKrQvvhL8BohP4b9MFvuryWytzvqxO5zXnqu+PDFV8QfkI6DdmqSs2Bq3A
         xAnA==
X-Gm-Message-State: AO0yUKUE/L9Rpe/I96nKglfUiTgvATvHBHjmsxVLeOZ1WEVR4kRj0nRs
        WMJ3qoVJHenF8bINpu6NkrPw4g==
X-Google-Smtp-Source: AK7set+7qUF+bcLWEkAr4Cox0v1rHikG9c/U926xfMgDAeF0Y5GVKCnNz9afn9B0OfITyqkEgAYQeQ==
X-Received: by 2002:a05:6402:1005:b0:4f9:f45e:c8b3 with SMTP id c5-20020a056402100500b004f9f45ec8b3mr5025265edu.27.1678626825396;
        Sun, 12 Mar 2023 06:13:45 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id r19-20020a1709067fd300b008eddbd46d7esm2213279ejs.31.2023.03.12.06.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 06:13:45 -0700 (PDT)
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
Subject: [PATCH 11/28] media: platform: ti: am437x: drop of_match_ptr for ID table
Date:   Sun, 12 Mar 2023 14:13:01 +0100
Message-Id: <20230312131318.351173-11-krzysztof.kozlowski@linaro.org>
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

  drivers/media/platform/ti/am437x/am437x-vpfe.c:2620:34: error: ‘vpfe_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/media/platform/ti/am437x/am437x-vpfe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/ti/am437x/am437x-vpfe.c b/drivers/media/platform/ti/am437x/am437x-vpfe.c
index 2dfae9bc0bba..fe89b8e250e7 100644
--- a/drivers/media/platform/ti/am437x/am437x-vpfe.c
+++ b/drivers/media/platform/ti/am437x/am437x-vpfe.c
@@ -2629,7 +2629,7 @@ static struct platform_driver vpfe_driver = {
 	.driver = {
 		.name	= VPFE_MODULE_NAME,
 		.pm	= &vpfe_pm_ops,
-		.of_match_table = of_match_ptr(vpfe_of_match),
+		.of_match_table = vpfe_of_match,
 	},
 };
 
-- 
2.34.1

