Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B496B5468
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjCJWaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbjCJW3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:29:31 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0293B122CCE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:29:12 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id a25so26663943edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678487351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/eg1nDT/DWvLF5qBMG6NeaUBghGjrzLVFlQFnIJNFjE=;
        b=qaM3ve+wW6Gt6rptzeOJgI7fsp/Nf85KO2ZcgbVSiZvSdKp5Lr9KO8TDlnRG/o5Hy2
         TrgRr1jPBZGmhTO+TmX8f1piK0XT3kowYscmhQmvRScvGE8MZQdZBAsFLcZ2WF54WtRc
         0xO2YIPBIwQIHXDxIED7dRCrxLgRUUnTgunX0XIZEkmmqqnTUWtEOPRzGjHnp04BTRdI
         TssZlvrynUkkWzqMaRdxZZ/oBOMtbfo6eg1I3yZ/9Bpp3iBqBTjMxv6/p0XVZmsFxs5i
         m8j/rIeHeT9kW0DgB9tKW9eyd5uxzp0gl3HoqYAGC0GtE6t4DwGguWLoOW5e7l302rbF
         XDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678487351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/eg1nDT/DWvLF5qBMG6NeaUBghGjrzLVFlQFnIJNFjE=;
        b=m5YKpJ4/lm4xcwrZ7zNhc1vmRMn4eP26tiW1pEdtZRZ5CoSW0O6eknefVawGsCaYHH
         67FXfcATZosQX19oP/duSgKG6Hk80b6bRCmTu22difCrWoE3vnVe05GdxBmIDVtQfSvv
         CA873soFNU50Jo93h4GdiZdGVj1qRcjfd1VEK9lGwBc0Q1AOYnOgNqVYfjlzSR61Bzex
         ZPSzMxishufs694CotteYPp7Pkb2MQbIXTmkg5FEOzkINJ+cF5TUKYAVDKFguuxXP1Td
         3DJeL0V2Gysw13MUj8+UBTd2GzR+zPO0rd1A1WTGmg9qrbyuqrCjlIFTl0cPyaglXsqo
         txWQ==
X-Gm-Message-State: AO0yUKVnI21GffJHOvo3iK+FbbyqLUX+Ac1feFgV827NnHn7eDK/lpjz
        3aUc3wBTVw7M7+YKmDPS65iS7Q==
X-Google-Smtp-Source: AK7set9jp7Yps5gdDa4xVZKk1y8Nuy79LZJ+JZ57vzOOBv4Dpd2cWsCrZ/AoIk5/8nmVVUyC9Qydyg==
X-Received: by 2002:aa7:c489:0:b0:4af:6409:30ea with SMTP id m9-20020aa7c489000000b004af640930eamr27406591edq.19.1678487351312;
        Fri, 10 Mar 2023 14:29:11 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:34:52e3:a77e:cac5])
        by smtp.gmail.com with ESMTPSA id x101-20020a50baee000000b004aeeb476c5bsm525467ede.24.2023.03.10.14.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 14:29:11 -0800 (PST)
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
Subject: [PATCH 09/16] spi: pic32-sqi: Drop of_match_ptr for ID table
Date:   Fri, 10 Mar 2023 23:28:50 +0100
Message-Id: <20230310222857.315629-9-krzysztof.kozlowski@linaro.org>
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

  drivers/spi/spi-pic32-sqi.c:694:34: error: ‘pic32_sqi_of_ids’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/spi/spi-pic32-sqi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pic32-sqi.c b/drivers/spi/spi-pic32-sqi.c
index 4c8493f34fca..ca89e6d22fc7 100644
--- a/drivers/spi/spi-pic32-sqi.c
+++ b/drivers/spi/spi-pic32-sqi.c
@@ -700,7 +700,7 @@ MODULE_DEVICE_TABLE(of, pic32_sqi_of_ids);
 static struct platform_driver pic32_sqi_driver = {
 	.driver = {
 		.name = "sqi-pic32",
-		.of_match_table = of_match_ptr(pic32_sqi_of_ids),
+		.of_match_table = pic32_sqi_of_ids,
 	},
 	.probe = pic32_sqi_probe,
 	.remove_new = pic32_sqi_remove,
-- 
2.34.1

