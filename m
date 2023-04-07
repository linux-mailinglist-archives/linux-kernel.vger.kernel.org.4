Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2176A6DB029
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 18:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240663AbjDGQFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 12:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbjDGQFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 12:05:39 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBCCB742;
        Fri,  7 Apr 2023 09:05:38 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id j22so9347428ejv.1;
        Fri, 07 Apr 2023 09:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680883537; x=1683475537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Be+z7Xy+Kh/2Wz1YaqaT8qS802NhtWrhkE2FhoyrkA=;
        b=fa88eLJBQATtfPY1DoSoeK+AZmGrh65RCjUN4LrdjtVXuQBIGmX1Bry/mZ1rgVKHRw
         oC5d3QX0fKER/4WNIXBC8xdVLMWYDZjjeHhsXctGCkYXYCVM9Gh2xSBq9cv+Qne9z+4Z
         sS0ymLkIsnMSvxAA16p9w19kQbBniBwcGUEz0Y7lfXaFZLts/PNl4uB6pPOsP6vwab1k
         H/xpCKUON6Dzl5Tr9nuLL2e0sEHwO7r6zVWGNHUPqDoXxiwVXeQA8jF0oCuLX1gqTTV7
         6y2cv9RM/uKAdC+scnxrx2uwMcrUOqTKFuoCGYfn7CHbq/n+IzUhNY+Y5zn4YTDnpTAO
         ioqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680883537; x=1683475537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Be+z7Xy+Kh/2Wz1YaqaT8qS802NhtWrhkE2FhoyrkA=;
        b=mINHUfAV3wSUXXcBfFYXGtocF1nNhf/JZZx3++MCKVluOTILwu7fMxFmBWFbzzzhXK
         I4UnJYbSo6FzQAKEJUwy0u+Ns6v5HpW6HSFzzx5d6uO6M5Bmptd4NI+56fBTU6u4EVNb
         1x4rSMWeQ1Yu4ab9MWVtkHydyr9AiL8CNwhizfZWYBXybdJlIWyD9wGltu249ZF0/Efh
         Uol1X0pw4zUZjuJllV2WOXu2b6XVvblVinN4W7eCz1N09vY5wZ3ueE/9QTT4GGIzNmq1
         j6lcogyPSoNW6QlKnc6dWDoZ+nc44wy2c0k4eBR1O4RSXjuq1xgeUOlUSYLVnve/9YDi
         u/eQ==
X-Gm-Message-State: AAQBX9f/hyWD5IFDKYRpcDlHji3IuoOo8ZuonVoG+kQWH9OjfmcfHTLL
        CvdVKFEIMb4QpYEO5f2z4JKmh32zvjw=
X-Google-Smtp-Source: AKy350Zg71akKfEqdKwLnNdu2/Y2KtP+Zfprg22VmXORRkPCdqSWl4BgtHjWLh0r2UURHDfGdvsdxw==
X-Received: by 2002:a17:906:4094:b0:92a:11be:1a40 with SMTP id u20-20020a170906409400b0092a11be1a40mr9171921ejj.11.1680883536536;
        Fri, 07 Apr 2023 09:05:36 -0700 (PDT)
Received: from xeon.. ([188.163.112.79])
        by smtp.gmail.com with ESMTPSA id lf11-20020a170907174b00b0092b546b57casm2147585ejc.195.2023.04.07.09.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 09:05:36 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] hwmon: ina2xx: add optional regulator support
Date:   Fri,  7 Apr 2023 19:05:08 +0300
Message-Id: <20230407160508.20479-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230407160508.20479-1-clamor95@gmail.com>
References: <20230407160508.20479-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI ina2xx sensors according to datasheets have dedicated
vs supplies. Add it for proper work.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/hwmon/ina2xx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index 00fc70305a89..fd50d9785ccb 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -656,6 +656,10 @@ static int ina2xx_probe(struct i2c_client *client)
 		return PTR_ERR(data->regmap);
 	}
 
+	ret = devm_regulator_get_enable(dev, "vs");
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable vs regulator\n");
+
 	ret = ina2xx_init(data);
 	if (ret < 0) {
 		dev_err(dev, "error configuring the device: %d\n", ret);
-- 
2.37.2

