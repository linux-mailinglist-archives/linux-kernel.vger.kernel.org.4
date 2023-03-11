Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5496B5B12
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjCKLUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjCKLTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:19:46 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AAEAA254
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:17:05 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id x3so30673158edb.10
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dqe4tA01u8D6zg7qVVNxLh27ygPQ0D7vH2s6WJVZu1g=;
        b=hs+KTaByhaRR1Crrvl/6b7Pi+5fYgw3OGDij24beVPHGJ3OBSZd2iaAtQvl435zoEz
         TIAJ9/yjnEW/vbI+fI5bN8m0Gv0bfx0pJTDZCvvL/7YiwXCdftTPM9j1an+cfUzwjXpy
         eeKWWGgAuRlTeSjhytqdKpzqpWEz+bYEM4w8xux4YzWgsMLUxbQTMzP/6ejxkRp8B832
         jKK65FakobFYuKa47JSpRFPgY8SdUGaHFWWKuJIG+tEY+A79f8xkImbMyPeetoZGZNVQ
         /qK1WGpBdfEU2vtexd3E1Kj1odc0bHgoXMoxEAnImUg9RaSuYG1kxkO1HJDqnCfPGg8n
         wZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dqe4tA01u8D6zg7qVVNxLh27ygPQ0D7vH2s6WJVZu1g=;
        b=hvYZoYKBM6q3u886V1W2XV/3is5O3isIVOpRgZkKDcFhW9h/0JO3mqjjPORr/FQSSp
         q2jGAe4UDUV7xLxzkqVpdNDXp6GbRPyI3XzLLL3kR507Bbx333U9VO3kv5CCl8DNdFyi
         AlmJLkHh7FsGPCsI2xb0hQEBZ0dWWD5mr7EddhMUe5opt1FCG+UF6+s6tF9gkcrRWWoC
         dcCfMqq0S0lGaayd1Bae9DxjYMJjLf/YBNGAwvoobVLMJcP9x+cTLMNZrjnpwL/ZRTxW
         5Xti0AZFoRN7agDcWIRZdGPk+taPW+kRikYkiYN5wAQosrKy5pRN6Rj1r7hYOeyw2v9g
         NUZQ==
X-Gm-Message-State: AO0yUKUbiEiolQiXhyb2/Cos9wQE3kNXXV16WShh39q9z8pL5QOus2zC
        u9jE93K0KJt2Y7HP0+l0BaYiYA==
X-Google-Smtp-Source: AK7set9ps6Xl+ULaLLmt1Jk7XfUchILOeDp/mCfvP03IeYFsPT68lmc3NmDip9szz/n3mavp5ht89w==
X-Received: by 2002:a17:906:1515:b0:8b1:279c:82c7 with SMTP id b21-20020a170906151500b008b1279c82c7mr27776179ejd.50.1678533421024;
        Sat, 11 Mar 2023 03:17:01 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id mp27-20020a1709071b1b00b008d398a4e687sm973975ejc.158.2023.03.11.03.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:17:00 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Qii Wang <qii.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-i2c@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-actions@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/5] i2c: mt65xx: drop of_match_ptr for ID table
Date:   Sat, 11 Mar 2023 12:16:54 +0100
Message-Id: <20230311111658.251951-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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
matching via PRP0001, even though it might not be relevant here).

  drivers/i2c/busses/i2c-mt65xx.c:514:34: error: ‘mtk_i2c_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/i2c/busses/i2c-mt65xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index 43dd966d5ef5..59eaefe999b1 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -1546,7 +1546,7 @@ static struct platform_driver mtk_i2c_driver = {
 	.driver = {
 		.name = I2C_DRV_NAME,
 		.pm = &mtk_i2c_pm,
-		.of_match_table = of_match_ptr(mtk_i2c_of_match),
+		.of_match_table = mtk_i2c_of_match,
 	},
 };
 
-- 
2.34.1

