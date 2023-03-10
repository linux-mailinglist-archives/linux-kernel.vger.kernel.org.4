Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057F76B5483
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjCJWca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjCJWcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:32:02 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5882D148B65
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:30:38 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id o12so26464625edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678487430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=268bZ1TBueiybyhkcpErcA+C9yqfqKZytn9F0qROzMs=;
        b=WbmdjplXq98Xewg+y118GdddG0T2GZpR2Lv2/E3ifF6exl4IYQoLFQYyyIwWCZ4GLt
         NTNzbH8KnPh15cZHw6H6IVh5m5DxVU0eX787ZT9b2lCpn7vRtwZDMn/StenHYkx2lhEd
         aA+MSGLK6E8xpijpR590AwNAaT+xiFblPrDnPajvvjz+7yNfYb7YmfKf5p391xtV75iF
         FluPgocmtnvggbxFVGHtgUUeUAuY5jm0BqAymCoYnUMuW+HzzEML7aR2B7AtTzTOwXIx
         WpsN/IX7ihA+QtjwDwgoIkeDLgwFSGGhtqcfAJlhGXn3mz9dfZ/Sl/UVB2h20Qv3HN1y
         fibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678487430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=268bZ1TBueiybyhkcpErcA+C9yqfqKZytn9F0qROzMs=;
        b=u35Lynbbs1PiZCsiW3GGIl103NA2LVp+9pOMYRppwpkRK76nYQHc60zOMjJDtxYHGK
         v1WzW5ELIBj3KN4HCoTaXa+q8tSaQk8PRPvSlfGx6xWxJKDAPBYMhCAcCSFFTep4AWdj
         x69VZo2AJbl/4iO4siqbhjVYI0sOS4hjrcHREpxu8Ci+WEfDPicZKV/ArOMctvGfhGNt
         53bjqbhUOxkhFN+oUMxknZOUi4QGuNBrAs5/DhjiGJmhSlr4Q8Ie76TtGlmXRkoqfq6W
         QY6ybmKKPM9kfLEWF1EjeJKoEiyPvghyfesMSDcvDWqjUI16PTaexV2DdD72R2xf3Hr1
         qvkw==
X-Gm-Message-State: AO0yUKWJwOc3N9ivJC3mA+2xAnfc6w2X9dQi5JwPl2KwOkjepvhxi1ls
        7uIyMK5ePOIS6nW8Z37e7MoIYQ==
X-Google-Smtp-Source: AK7set+39I2qc56oSch7xhdvqbptNHo5xMzdm85sdCUofyZHp7Ij1rQzQcSllFkME3nFWMD70VBWYA==
X-Received: by 2002:a17:907:6ea6:b0:8b1:7dea:cc40 with SMTP id sh38-20020a1709076ea600b008b17deacc40mr33181747ejc.9.1678487430083;
        Fri, 10 Mar 2023 14:30:30 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:34:52e3:a77e:cac5])
        by smtp.gmail.com with ESMTPSA id l23-20020a170906939700b008c5075f5331sm360279ejx.165.2023.03.10.14.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 14:30:29 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] crypto - img-hash: Drop of_match_ptr for ID table
Date:   Fri, 10 Mar 2023 23:30:27 +0100
Message-Id: <20230310223027.315954-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310223027.315954-1-krzysztof.kozlowski@linaro.org>
References: <20230310223027.315954-1-krzysztof.kozlowski@linaro.org>
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

  drivers/crypto/img-hash.c:930:34: error: ‘img_hash_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/crypto/img-hash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/img-hash.c b/drivers/crypto/img-hash.c
index fe93d19e3044..4e9a6660d791 100644
--- a/drivers/crypto/img-hash.c
+++ b/drivers/crypto/img-hash.c
@@ -1106,7 +1106,7 @@ static struct platform_driver img_hash_driver = {
 	.driver		= {
 		.name	= "img-hash-accelerator",
 		.pm	= &img_hash_pm_ops,
-		.of_match_table	= of_match_ptr(img_hash_match),
+		.of_match_table	= img_hash_match,
 	}
 };
 module_platform_driver(img_hash_driver);
-- 
2.34.1

