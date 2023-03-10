Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8DB6B5459
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjCJW3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjCJW3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:29:15 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0C2122CD2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:29:09 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id a25so26663643edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678487349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BSow9olcoHPDQWGX+9sZKUw+pImGguqL+rxp9AEhbQU=;
        b=WMD94TIdueIJwD4R0dzXoVlrA+lBE3XxCJOkt5lcGwJl3T9aSx5oXLSImUAdS8gGWj
         nevEWuDRfJ5RPH0TtzsEO8S3/WbblgN6c7T0caLdrg4JVyKOqAgZy1gYCF24w5rLBjjL
         MGSsSfrwG4aZGC+l8fhUpOJRtBywlP3akFV3IGOYCLF3G4b5n7kiyAbJDLHKhRR8a7LS
         Z2ZsSKJ0xALhO2Jtv+CXbxq0jXTpVzfN+2istoSvNEtpe8cznSwbbzPN3KeRr/R4kSF7
         IFSRNgff5R+GmFDJEXkLP5PhiObPKCY/RCtarbKc44EdzHR0zp2QleIG+ceGsJi5jxoD
         dz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678487349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BSow9olcoHPDQWGX+9sZKUw+pImGguqL+rxp9AEhbQU=;
        b=i4FbxUgA6b7NSlcYN4wFF2S2I1aQHqyW3prH62mlVtdbSgDdnPZsjEoIlMHd9TTl23
         8DLfHvULh8+2naELVIWw06ZQxTjgEz9fMEw7ecgsm1wKsA3xouGgXp96lXFqT3FVoiQa
         A4KRDG9a7buIF/ulsGZK7dbmdX4Xy5V36pm3IkDRoMx6toTz//fkDyS3Jy12mYPyRPyH
         AOVPEzvgpAoqGdwiyvLdFCSKTUFLrgxLwHU/MPepzB1TKZ6TA3jZ34oYIEdGpWiW+Crj
         e7JkoY//U6j6tZhYRc89FEGJoUucvC5NReEc5HfUw+P98tP4+swNHdP8FWMIBxlqFr00
         3nyA==
X-Gm-Message-State: AO0yUKVefbTM4StJQTqKiaKXQ6913Y8t4S0c2Is9n5Eiq0K+KWlpLBgu
        715O39XJ2P+1g76qt5OF43S+og==
X-Google-Smtp-Source: AK7set+ZEfdl5RMmf1uVdzsphu0VuJcqw6uo7c4Au9pdNtDAtzSnz6tjiqyq5MBaqY6lf3+ZmyTllQ==
X-Received: by 2002:a17:906:8156:b0:886:221b:44e5 with SMTP id z22-20020a170906815600b00886221b44e5mr26872458ejw.62.1678487348858;
        Fri, 10 Mar 2023 14:29:08 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:34:52e3:a77e:cac5])
        by smtp.gmail.com with ESMTPSA id x101-20020a50baee000000b004aeeb476c5bsm525467ede.24.2023.03.10.14.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 14:29:08 -0800 (PST)
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
Subject: [PATCH 07/16] spi: s3c64xx: Drop of_match_ptr for ID table
Date:   Fri, 10 Mar 2023 23:28:48 +0100
Message-Id: <20230310222857.315629-7-krzysztof.kozlowski@linaro.org>
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

The driver can match only via the DT table (all platforms are OF-only)
so the table should be always used and the of_match_ptr does not have
any sense (this also allows ACPI matching via PRP0001, even though it is
not relevant here).

  drivers/spi/spi-s3c64xx.c:1496:34: error: ‘s3c64xx_spi_dt_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index cc69f8ffdbdc..7aec496070e2 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1526,7 +1526,7 @@ static struct platform_driver s3c64xx_spi_driver = {
 	.driver = {
 		.name	= "s3c64xx-spi",
 		.pm = &s3c64xx_spi_pm,
-		.of_match_table = of_match_ptr(s3c64xx_spi_dt_match),
+		.of_match_table = s3c64xx_spi_dt_match,
 	},
 	.probe = s3c64xx_spi_probe,
 	.remove_new = s3c64xx_spi_remove,
-- 
2.34.1

