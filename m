Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06856651147
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 18:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbiLSRgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 12:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbiLSRg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 12:36:28 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1566DFC7;
        Mon, 19 Dec 2022 09:36:26 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id r26so13898645edc.10;
        Mon, 19 Dec 2022 09:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/0xWO84mZV4IGXHow05EqrpGj/+BB5Qsxuyp4ptP3o=;
        b=IXJg1WpwcF38WgEOXYS+xE1R3q/Z5A+KzeHCXSKBNq5Q9V0PsxvFniq+18LDkn1XBG
         CFbGy2tqhjBQ+pvKE3BwkwjIUVs6jdRW/l7n7Uxnxayl3ASOyWKMks9g/JjtVKUgUu0T
         F/wStXQetiQCpFFzJ5xr7X1d/G3g5X7AbbcM6Tta8slZlSahJuMLoD8qHl59PRKbiHEJ
         XQ6H2LAqexaC+QDoGUyrXdhPqNc+SjHe/dtySKTEGiNKM3+vxrNoiqKIQRePrXM9vRcR
         8i03/UO7WlHqFw/UBDWv8zf1TzeY5CsgTq4sVhueJk2QMZoZYvOuH05lVWq7+IdIPDUe
         WWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/0xWO84mZV4IGXHow05EqrpGj/+BB5Qsxuyp4ptP3o=;
        b=2GvJrf40S0fyE8r+2cYkI/mWQZ6fTZF7RcOaRrPcniIqaaabG0ZK2k57/oCLHwyiaB
         KPGbgA4U5Xud5wQlRcUAwlLrxecmUidy8qTS1RA21ZCHr/D1SkU4nZmCkp5GAuDD48Q+
         X1m+zz7R0JrFixuZwxSN8ORPzHfo1h+6DIK+oh7yWyC5ZYvGzQ0VvEU9SQsV0vc22rkp
         pyPtg+1frKdUUeBIu/ZJ+CmENzcI+0Q0zpOy9nOhUPUDYepNO1j+9fYiqRWlA4abknpL
         CUbX2u41Bpajv0su6B+gEA4K01xp3AD2YKjoh4oWfnqzqSCxpMyDhYuCTOuI2axBYNIW
         Y/TQ==
X-Gm-Message-State: AFqh2kodlQUoZwBB9m2mAcQO7sbtfuC8n8XVGD5CZZjjxZUp3xfGV1NK
        BhI+MGftq2fvln+OAfaquC7tsTwQrIh6Sw==
X-Google-Smtp-Source: AMrXdXs8NpfCdv5tqouJXLm9aXjxeW2XHzpk2ex5vtv6JINkuwxTYtIEEkYhlhxDYlVZd5Rzgb/jag==
X-Received: by 2002:a05:6402:2b8c:b0:466:12a0:11f3 with SMTP id fj12-20020a0564022b8c00b0046612a011f3mr9955256edb.22.1671471385610;
        Mon, 19 Dec 2022 09:36:25 -0800 (PST)
Received: from localhost ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with UTF8SMTPSA id p18-20020a17090653d200b007c1651aeeacsm4600337ejo.181.2022.12.19.09.36.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 09:36:25 -0800 (PST)
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] iio: adc: ep93xx: Add OF support
Date:   Mon, 19 Dec 2022 18:36:18 +0100
Message-Id: <20221219173618.1030415-2-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221219173618.1030415-1-alexander.sverdlin@gmail.com>
References: <20221219173618.1030415-1-alexander.sverdlin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for EP93xx conversion to DT.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 drivers/iio/adc/ep93xx_adc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/adc/ep93xx_adc.c b/drivers/iio/adc/ep93xx_adc.c
index fd5a9404c8dc..e530a37180e1 100644
--- a/drivers/iio/adc/ep93xx_adc.c
+++ b/drivers/iio/adc/ep93xx_adc.c
@@ -21,6 +21,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 
 /*
  * This code could benefit from real HR Timers, but jiffy granularity would
@@ -227,9 +228,18 @@ static int ep93xx_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id ep93xx_adc_of_ids[] = {
+	{ .compatible = "cirrus,ep9301-adc" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ep93xx_adc_of_ids);
+#endif
+
 static struct platform_driver ep93xx_adc_driver = {
 	.driver = {
 		.name = "ep93xx-adc",
+		.of_match_table = of_match_ptr(ep93xx_adc_of_ids),
 	},
 	.probe = ep93xx_adc_probe,
 	.remove = ep93xx_adc_remove,
-- 
2.39.0

