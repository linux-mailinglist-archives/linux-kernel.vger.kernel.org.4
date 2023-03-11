Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5AA6B5F33
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 18:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCKRiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 12:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjCKRhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 12:37:55 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D584E98875
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:37:33 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id cy23so32945740edb.12
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678556191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyv/Ot8W77P43I7crwiy1gRRQ+CJGNpQ8ExpT2cUljE=;
        b=i2PRkfHTxKwOaApCmbdBDXXomfd/yMBu1xJfGVyWQ4GGTJZJeUm2SCV+wUW7/S788K
         QlHeG6UH31x3KebDimUYOqGUIVG7jUrpDvuv0VMJ7fKpRhm/XwUr75QsrgAhXHk8k1Kd
         rLWy9QWPVd8Mfw9jylDRI+49godbsHbW3IZSrSDzyqgiZTiAUJ52uChEuCT1MpfjL8+m
         FTgeOilF7vVNwlA/ZwQIfQBdiRRNKtEWFUbdaW1aubJ11u5cbbWwMccDztU4Q6fxAxqm
         lGYkfQCoPaszs/Bcde74oCib9k9mDiGTsDyu1MtvISRKMz+osby21mCFmXsmUUCC7X1M
         UIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678556191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyv/Ot8W77P43I7crwiy1gRRQ+CJGNpQ8ExpT2cUljE=;
        b=mlpRr9HUg6sefB4iHXn50qSWwhntmAlejBHnbj4JuNR5Zcvm2qgLjsJ/5FyJc/nFfz
         7lOsNRmzhL2Rf+CfBYQSx734jjXsNjoez8yFrmc25xV5QK841RRYT69uRQYMYL1E4zXK
         S8yZ9a0+msOw5X/6R8sqASqk0axMoCmuGhhoxP3VppHjls2QKQXhWGA+P8XRcvVBk/ON
         TZ/7yl3qwpViF8LCIkijyxaGeOp1OSpxre8HcXgTMCz6b89ZMxGqZU2SVTXTOK7Bvnn1
         8SEXj3svtfF54MFwivdNFNRb6qXP60s9+VJyq5cnpaJiW8rVL0MIkmbBVg41v/Fz42Gl
         FVaQ==
X-Gm-Message-State: AO0yUKXoep5y9LVMyovOojzBtNYY1R+0rUzil2S0e1cKi/Z0WuRoz/Rs
        MUevbSkBMqMRZYWZsER+crmulQ==
X-Google-Smtp-Source: AK7set8/ddWXTFvR83RNYypGa0WBBDqK9TW8JW4bID1syStw8CQae7CdIFT3RRXevMHmabYbISlaMQ==
X-Received: by 2002:a17:906:4783:b0:8af:2107:6ce5 with SMTP id cw3-20020a170906478300b008af21076ce5mr40384100ejc.35.1678556191866;
        Sat, 11 Mar 2023 09:36:31 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6927:e94d:fc63:9d6e])
        by smtp.gmail.com with ESMTPSA id jy2-20020a170907762200b008de729c8a03sm1315253ejc.38.2023.03.11.09.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 09:36:31 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Richard Leitner <richard.leitner@skidata.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/7] usb: host: max3421-hcd: drop of_match_ptr for ID table
Date:   Sat, 11 Mar 2023 18:36:19 +0100
Message-Id: <20230311173624.263189-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311173624.263189-1-krzysztof.kozlowski@linaro.org>
References: <20230311173624.263189-1-krzysztof.kozlowski@linaro.org>
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
matching via PRP0001, even though it might not be relevant here).

  drivers/usb/host/max3421-hcd.c:1943:34: error: ‘max3421_of_match_table’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/host/max3421-hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/max3421-hcd.c b/drivers/usb/host/max3421-hcd.c
index 28d1524ee2fa..d152d72de126 100644
--- a/drivers/usb/host/max3421-hcd.c
+++ b/drivers/usb/host/max3421-hcd.c
@@ -1951,7 +1951,7 @@ static struct spi_driver max3421_driver = {
 	.remove		= max3421_remove,
 	.driver		= {
 		.name	= "max3421-hcd",
-		.of_match_table = of_match_ptr(max3421_of_match_table),
+		.of_match_table = max3421_of_match_table,
 	},
 };
 
-- 
2.34.1

