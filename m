Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE776B5470
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjCJWaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjCJW3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:29:43 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDB3125DB1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:29:16 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id j11so26472591edq.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678487355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DIL/eAhzd2Q+CmLa0/Vp8uh0M9mRf6IHTk8hQZUVPkA=;
        b=k9IOHxBgd0bMymkB/VVDYynw3dg0wz5WLTLxzV6gvhi0zHI1m8CQMly3VXoSXuKFCp
         8h9Sng22gMlalzZGQ190Jfc2ocLKGquLyts/VCYV4KgnzhNpLAw1lmCH08tqlBTGh9uX
         opjEMpR+/6cN4xnJkfQRHijm2E+EP866a7+7DUN7ENr4l/jbDJAouQL9++JBziQhUcen
         89Kb5I7fiA11hsVqegrlnQFLmvaJvdNzACOqIF+Q8V10Tmi8VpXBpBjWc0BjNbw236gS
         IGoWXG5ofcZOzKkhc2pkde95caIVRGE7UK7159UQqJklSACcPwP+y8SGCq20FhEImF6F
         06VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678487355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIL/eAhzd2Q+CmLa0/Vp8uh0M9mRf6IHTk8hQZUVPkA=;
        b=VHxda77qS4dcJHSU9nXtZ2TbR08MzJ4U5mjTa6lWzf3e87IJcfvgLOaJ70sHsdW3to
         wjrbjy6s6dQlt18Dxei4nMibcAR5i95anIFiSnyIFmNvka1r0/Wb5pTEH5mO3HNwV9mE
         eBzH3g2M+molNwba/2TJQMBJ6BUHksrerPSJrvXFDHcAFGGRM6dCPwVX/yehQbVTE4CI
         jzS38QppuFcPzDBSqAP6lVaW6m+dM8aiw/XiAgm+W6G0+yIJ6rzEvkjaXQuhFuT/gTeZ
         cJtUDdjG55bfOCZJt+ngsLF/nLnkX4CWCdLddO4tx4QC+U9NxMbamMnH9irkKJbQ+hF8
         fMig==
X-Gm-Message-State: AO0yUKW2FmWwa5xTSja99JPuypUqBMkOJW+MB/BQTBOFI4yOBqR/oreX
        rY/xkoEY85sgzuqeQnXaeJCtCQ==
X-Google-Smtp-Source: AK7set84qDZr9RcwJ70A6u3nLP8atYZ9eptCD6oONVkchKcqZ66qh2jURUNfTUs7WD78mR7YiVblZg==
X-Received: by 2002:a17:906:dd7:b0:87e:a34b:9e2b with SMTP id p23-20020a1709060dd700b0087ea34b9e2bmr27657561eji.28.1678487355376;
        Fri, 10 Mar 2023 14:29:15 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:34:52e3:a77e:cac5])
        by smtp.gmail.com with ESMTPSA id x101-20020a50baee000000b004aeeb476c5bsm525467ede.24.2023.03.10.14.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 14:29:15 -0800 (PST)
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
Subject: [PATCH 12/16] spi: pxa2xx: Mark OF related data as maybe unused
Date:   Fri, 10 Mar 2023 23:28:53 +0100
Message-Id: <20230310222857.315629-12-krzysztof.kozlowski@linaro.org>
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

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  drivers/spi/spi-pxa2xx.c:1757:34: error: ‘pxa2xx_spi_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/spi/spi-pxa2xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index a75ba2993f3c..19e996a5a02e 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1754,7 +1754,7 @@ static const struct acpi_device_id pxa2xx_spi_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, pxa2xx_spi_acpi_match);
 #endif
 
-static const struct of_device_id pxa2xx_spi_of_match[] = {
+static const struct of_device_id pxa2xx_spi_of_match[] __maybe_unused = {
 	{ .compatible = "marvell,mmp2-ssp", .data = (void *)MMP2_SSP },
 	{}
 };
-- 
2.34.1

