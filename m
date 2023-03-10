Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573F46B5460
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjCJW3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbjCJW31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:29:27 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A97123DC7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:29:13 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id u9so26538056edd.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678487352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G/4k4EDtHTwsGrCFmt9A01h3SrewNsUPMEHGiEs4FeY=;
        b=TVdIMwMMrCKmZDAj8bAXcosuz/F+qKLurmGg2tk/JuU0WAeW1zZ3e/5WJFm5zshZxi
         SqKw726uNsBDbGIY2pbSJBufxH78N4ZLW50mMwf71ESTokrIR6XsO7x+je/tAR/wbxyt
         WYxUzBPA1whbkcBPF2K2TOZDDwRH3y2IRF3GPsWajArp2ggTf55DAr1Qk6EvT7FlhPYH
         4+455PnI4SeL9cFUeXrD1nv1O4nsCQkfBMd95Ge0+t3wZzK1f5SMXGVkLeHw7CQi3s+5
         GMsfdtZzfaM1HAp/g0JL3uTpA1omwZTAUUW/0ofTxY2+KChGu+++CqNGcjjsOYO2bQ12
         1obw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678487352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/4k4EDtHTwsGrCFmt9A01h3SrewNsUPMEHGiEs4FeY=;
        b=IcuE29ZOhfp30P/tT0d4rg8X99eywsR87Qi1XoZ60EmQsZsjDA3nG+yowLPLGsghi7
         6mkmLXHOVmtC7Z3ix6lVvG6QdpEANz9yp5NVCHUdaAWuqbIOlCSeHuzt08eSzgVeePO+
         bfaKnptcxSupnJsnH+7wGLfri/f5ojIIaM3n29uwX0xC2vr3wGUB6dZVu3Fij4KouHc9
         Ee5XEKQVNwZ4brU+A/zt4mpeJGV1SaJ0h1ZCpgbPREbh1L2/D6/rWJd5FIV6OGOCEZpp
         wdP3P834VUIOhiytSjPZe3QZIlo79XMVRBIz0t5Ia31AQu9EVE2JMR6MUPGqNSYoAqfW
         2jEA==
X-Gm-Message-State: AO0yUKWuiIhmdFJ8l3PmNYdHBBSUzRqEighVMcbafu+1XPPpCbAdT2oH
        u4KEZ18RRjWKfL0N3f/zO8kyDw==
X-Google-Smtp-Source: AK7set+a17yOf6VzbwUc0CZ6vTQ58vWyCjXfAH5/wUdFVgNoDsRk2++Q9bB1eIS7zKuhlPF+RpY35g==
X-Received: by 2002:a17:906:9252:b0:8b2:23fb:dfd9 with SMTP id c18-20020a170906925200b008b223fbdfd9mr27625552ejx.39.1678487352519;
        Fri, 10 Mar 2023 14:29:12 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:34:52e3:a77e:cac5])
        by smtp.gmail.com with ESMTPSA id x101-20020a50baee000000b004aeeb476c5bsm525467ede.24.2023.03.10.14.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 14:29:12 -0800 (PST)
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
Subject: [PATCH 10/16] spi: pic32: Drop of_match_ptr for ID table
Date:   Fri, 10 Mar 2023 23:28:51 +0100
Message-Id: <20230310222857.315629-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310222857.315629-1-krzysztof.kozlowski@linaro.org>
References: <20230310222857.315629-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it is not relevant here).

  drivers/spi/spi-pic32.c:857:34: error: ‘pic32_spi_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/spi/spi-pic32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index 5a64ad0c94fe..04896e7ff2c1 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -863,7 +863,7 @@ MODULE_DEVICE_TABLE(of, pic32_spi_of_match);
 static struct platform_driver pic32_spi_driver = {
 	.driver = {
 		.name = "spi-pic32",
-		.of_match_table = of_match_ptr(pic32_spi_of_match),
+		.of_match_table = pic32_spi_of_match,
 	},
 	.probe = pic32_spi_probe,
 	.remove_new = pic32_spi_remove,
-- 
2.34.1

