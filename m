Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6926B5B08
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjCKLSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjCKLR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:17:26 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B0D13F6AF
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:16:26 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id cy23so30636421edb.12
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OCzg8SfNWOR6ZGwqRQLrQy1Mo0FTE4MlBOnbJtRBfZ4=;
        b=x6ny6ewhdLvAMEqWw/3v72kyLaxkOEQQMYQmghS2Psgll1Kl6XAJkbVe7IVZPOjRQ/
         Lz19EHwiTGVBsfi94BuHFfz+ITLVvmLB/R4E+rcM9UEvXuPZo1cDnpmuQ89F9w68mVsg
         jz+hHWlyHpmFzs4utE+du/L35nyBCVtkBHAgqrna5CADgVdD6RI0KmqUuT67/dfwqUlA
         xJkNduPizZaltQC3JRZtvS05az6SpWXuk/M/kfUQnOjd4E2OcZKO23x+Y7ucRZ3mKmcM
         hO4wBI3KXesk2mGPJoUKDBaNN7hPlXnByOVo5dpEjuOqzqtNmR1U5Zyqm+u536bHkG0Z
         jkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OCzg8SfNWOR6ZGwqRQLrQy1Mo0FTE4MlBOnbJtRBfZ4=;
        b=E0kSnpoMuZDCsMCrVmuNZ4dlL6QoEyBheQkme0wvM0YTDq7ATE+8BlkT6Q6BR1nnZE
         snY4JhD+h8iNaCNX56pbg/bvJ5Y4SttXEKHss+Fht3IgvNl1f5RTPK+ErJ8A0oA1L/KR
         i0NTpTWAPd+QdMxYAybrTXEBr4B8qUgTWYXAErGxP/8hZ8x6igTuIxiBvav6Dmg4ZqUh
         YvkwG2DSDX4sJOQuTBMYa9W8aK3T7FOj1p3UcOEJfl3xBdM5iNRG54GMu8WTMvrjpKEU
         WDqCZ99qmtdzNG8LGs1dWju4ZNk22MZUV9ygW2I/qvwNKgL6hnvJmyLR+BZ/toprlZgS
         DmHQ==
X-Gm-Message-State: AO0yUKUti1MZeXghEMyXFFNw34LBedDuSY6hsbco6+8fDKFFtcyngABF
        fY2R4iOvtGG7ZsJwy59BHsKHZN3dKsY/4fEXnUA=
X-Google-Smtp-Source: AK7set9cjLbbYo2UOa5RfYgrzvA4oeSfkxQ06b+0q09ZBj03pG80CWlkc8SXf/95ocSPl0c1+DXLfQ==
X-Received: by 2002:aa7:d149:0:b0:4fa:dad6:4b63 with SMTP id r9-20020aa7d149000000b004fadad64b63mr573298edo.37.1678533373699;
        Sat, 11 Mar 2023 03:16:13 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id a20-20020a1709065f9400b008be0b7242d5sm994267eju.90.2023.03.11.03.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:16:13 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Eric Tremblay <etremblay@distech-controls.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] hwmon: gpio-fan: mark OF related data as maybe unused
Date:   Sat, 11 Mar 2023 12:16:09 +0100
Message-Id: <20230311111610.251774-1-krzysztof.kozlowski@linaro.org>
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

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  drivers/hwmon/gpio-fan.c:484:34: error: ‘of_gpio_fan_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/hwmon/gpio-fan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index e75db6f64e8c..be7f06fb7f78 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -481,7 +481,7 @@ static int gpio_fan_get_of_data(struct gpio_fan_data *fan_data)
 	return 0;
 }
 
-static const struct of_device_id of_gpio_fan_match[] = {
+static const struct of_device_id of_gpio_fan_match[] __maybe_unused = {
 	{ .compatible = "gpio-fan", },
 	{},
 };
-- 
2.34.1

