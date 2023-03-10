Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6F76B5455
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbjCJW3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjCJW3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:29:06 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4821220BF
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:29:05 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id i34so26420166eda.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678487345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ADHlp/biBCVZeifGXqje13pwL1TD/yH+Vs4GNRSOSmk=;
        b=gOjP1UUs30lsqxRQ45sMLZli5wdZwOUprEKASjWMuOlyLzQDeiBSD2Hq3tIo+JrpKI
         AArmC+ZLrunGz5fN3pTsr9FDr1XBx+iXT2ewlMt4mqhfD1/xs0oPen4jvt8byPCJmURq
         oPDOovgdqKMczeymwr2b7yNBm6QACG+fmkmSzHtc+G9+qsU4Ol1bCgf42TFMSBv5mo0z
         2prH2dORIW8Fj83FHmH5UmMl5Hv7Q0/N53UmQ05E2Zvih2Taqzkpmw+w+q7nolMec0/h
         +ntxOzSypN9XSEK03IgE8Bm20Ofus/MK+h5mh+VvTIfDF5G5gnoSvhCZL49djmgt7RwL
         IDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678487345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADHlp/biBCVZeifGXqje13pwL1TD/yH+Vs4GNRSOSmk=;
        b=ooCa+N3prTtT+dMNnUxXG7qKaPL1x6a6/8jp8JUdeVBTNBWgAw5JwG4qnJzj16w+9T
         WT58+gAJLTlcr8TByk/rOi2nLlgDbVKCEJW1t3z02ora/xLxOijWBgaYsMDWIKk4vstT
         S+ihN4Z/bD5uYaun/+Wj9gdGqm7lTzagDXDX/2qwYC4N8FI2rCM+6e31pTuFCJlcn1PC
         s8pqaSIgabXyt+NBQwbpgeghu36eoJyh1ksXXlZqygTx7lqKyO/caU0cfKHdohAlISL1
         g1FZ8z5Vnet2oLZv1au1zndodYlymWz+420NOG64XAGDYkw3NyaJazygckq7+DwhZf3N
         UTMA==
X-Gm-Message-State: AO0yUKU/svcbxq7RVL67qJDUGx1xh+PPXRrsZsIsJs6MKe5T6nchpApM
        Sjr4/Bt+aX+wPgq9J0HqNRvVUw==
X-Google-Smtp-Source: AK7set8jBrx8YyuYtrKMeUiH9xfKEhHMLTU3KB16tvrIfpqUWe0eJHY4hKaNb7RoSr0Tp0Ya9mPiGA==
X-Received: by 2002:a17:907:cf48:b0:8e0:4baf:59bb with SMTP id uv8-20020a170907cf4800b008e04baf59bbmr28471712ejc.22.1678487345059;
        Fri, 10 Mar 2023 14:29:05 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:34:52e3:a77e:cac5])
        by smtp.gmail.com with ESMTPSA id x101-20020a50baee000000b004aeeb476c5bsm525467ede.24.2023.03.10.14.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 14:29:04 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mark Brown <broonie@kernel.org>, Kamal Dasu <kdasu.kdev@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 04/16] spi: meson-spifc: Drop of_match_ptr for ID table
Date:   Fri, 10 Mar 2023 23:28:45 +0100
Message-Id: <20230310222857.315629-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310222857.315629-1-krzysztof.kozlowski@linaro.org>
References: <20230310222857.315629-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it is not relevant here).

  drivers/spi/spi-meson-spifc.c:434:34: error: ‘meson_spifc_dt_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/spi/spi-meson-spifc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-meson-spifc.c b/drivers/spi/spi-meson-spifc.c
index 06626f406f68..af832fbbf258 100644
--- a/drivers/spi/spi-meson-spifc.c
+++ b/drivers/spi/spi-meson-spifc.c
@@ -443,7 +443,7 @@ static struct platform_driver meson_spifc_driver = {
 	.remove_new = meson_spifc_remove,
 	.driver	= {
 		.name		= "meson-spifc",
-		.of_match_table	= of_match_ptr(meson_spifc_dt_match),
+		.of_match_table	= meson_spifc_dt_match,
 		.pm		= &meson_spifc_pm_ops,
 	},
 };
-- 
2.34.1

