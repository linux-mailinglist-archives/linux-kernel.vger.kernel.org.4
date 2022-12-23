Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9849E6552C9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 17:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbiLWQ0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 11:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiLWQ0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 11:26:44 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B235FFF;
        Fri, 23 Dec 2022 08:26:43 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id jo4so13064825ejb.7;
        Fri, 23 Dec 2022 08:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxDL+X8NmnukiauYcA33D3M1w50IAdYmljuXwdjMwII=;
        b=Ic2NXkxd20lD/6DOmo7za4NfqIesYZ5KwzWGj7PL1MVAd2X5VqAHmFFZkOritE9yWN
         Xi5samHQOW698C7ygZU0xxC2y46eMVFto07/yxTfKVCNuyXEOmuscQ/al+VDnTPri+SH
         UhIF5kv3Q2PgaXjY+y+WtJSSDEsjj026I1HnfcIOg2KCgH+nlb7fVhbtCu+/c4tu32XL
         wuVL7XghWdcFN7D8eL7jqcYBTvdsawX/JyHkRnX+Rg0H/PrebkBKbo1NlFOv6pKSBFGk
         3urNCu1b3kktdvtW3pX4R7iA7BJCHV4ofK7zmO8Y8Tw/7CAmRhh+otuZpvulGkJUnTsD
         tb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxDL+X8NmnukiauYcA33D3M1w50IAdYmljuXwdjMwII=;
        b=U3u6t6Mg5qGX4cUvKQPJdwQgLTzu1mtao48BHn24t+OaTuAiNj9n/Ieq5eL8zdFgKk
         OMk9y2Sjz04dTJDmUTxLzF8q+orKSF4Vlx8Hn++jV7Z/vxIZGtpduchM2k1cl59PIWt8
         HJwwxh5AnMEwRdTtWOiZJL1pXYEzZG2zJAOYEOUN8l0HXi1aCuRj60uJkZFZyVorlNY8
         D8Uyz/9xPJGljmgwWj1IMJLmdJeqGO7jEtYC7zJDUMCsHG+xfLjfdHzNKDhRI5n4jv2/
         yyBfO5K5W3rzVSj1VBxg/uXO806RT3TYYAzmRogDwbKrI1dB+WtKE7rt7e6YHske1Qvw
         XgIg==
X-Gm-Message-State: AFqh2kpXvS3dE75L0Rv18uIw+yXoMSbnrkgi8qOdL2nyemzKgYc/rVdd
        un/cSVR33lQN6CrkGrVqMUKeOoZP3sM=
X-Google-Smtp-Source: AMrXdXsPIDPmGkpmye/C3rLElx/wzoe7cpMFawUaJnMnOf6cyBcP9awLfAw/jesDD6tBb7XqMmdw/Q==
X-Received: by 2002:a17:906:5dd2:b0:7c1:7010:f413 with SMTP id p18-20020a1709065dd200b007c17010f413mr12371630ejv.19.1671812802210;
        Fri, 23 Dec 2022 08:26:42 -0800 (PST)
Received: from localhost ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with UTF8SMTPSA id fu19-20020a170907b01300b00781be3e7badsm1550295ejc.53.2022.12.23.08.26.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 08:26:41 -0800 (PST)
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
Subject: [PATCH v3 2/2] iio: adc: ep93xx: Add OF support
Date:   Fri, 23 Dec 2022 17:26:36 +0100
Message-Id: <20221223162636.6488-2-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221223162636.6488-1-alexander.sverdlin@gmail.com>
References: <20221223162636.6488-1-alexander.sverdlin@gmail.com>
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
Changelog:
v3: Removed comma, of_match_ptr() protection and the ifdefs

 drivers/iio/adc/ep93xx_adc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/adc/ep93xx_adc.c b/drivers/iio/adc/ep93xx_adc.c
index fd5a9404c8dc..a35e6cead67d 100644
--- a/drivers/iio/adc/ep93xx_adc.c
+++ b/drivers/iio/adc/ep93xx_adc.c
@@ -21,6 +21,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 
 /*
  * This code could benefit from real HR Timers, but jiffy granularity would
@@ -227,9 +228,16 @@ static int ep93xx_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id ep93xx_adc_of_ids[] = {
+	{ .compatible = "cirrus,ep9301-adc" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ep93xx_adc_of_ids);
+
 static struct platform_driver ep93xx_adc_driver = {
 	.driver = {
 		.name = "ep93xx-adc",
+		.of_match_table = ep93xx_adc_of_ids,
 	},
 	.probe = ep93xx_adc_probe,
 	.remove = ep93xx_adc_remove,
-- 
2.39.0

