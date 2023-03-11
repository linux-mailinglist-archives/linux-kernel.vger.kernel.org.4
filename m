Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFA66B5ACD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjCKLN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjCKLNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:13:18 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E939E10A81
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:13:10 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id y4so1263281edo.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bq/suyyejHELTOKo5Lqe9JDVsAF8B3eTSU6jYYaw5rs=;
        b=GcR1BBQCdR4Nyqe7Dp9VmqBVN4+13vTx5EQOi44pJiaYeXD+D+mKtO4fvpp9GIPG7r
         BRskmMZAc7XIdFRRJjgBgEQ1P5GIFa4CF13JemkF79TJICvhP2c10MUllTPK1seye4pi
         re5dV0XML2v+mh3EmItQ33rYyB5W+zffyWOzFosg/rs/L4s7KEG0ns7ppsI7jsSDRr5F
         W2qiVDcRrk8B46+pmYoU4PIX7mUPqicOY9cvI7rvl/lClgykghEKJdGipn0oy64VBbz9
         cZ3ElInRGqJOoyxjVR0VwTCWuuHRceQZLGarrhTJRQ2bWjnZs0TKtT3xc/PFhZQxHq1+
         0p0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bq/suyyejHELTOKo5Lqe9JDVsAF8B3eTSU6jYYaw5rs=;
        b=QNmuWTCeEvLNowVMIuMw8po7seDiXT+VwDNtCPWqJHmXWcM+l8VMbmhkt8OQjw2yj8
         hp+DL9M9+T214IIOlWhtXcIA0RZvRiSaXdjhJOgYS51IQhQYpzVTNBSM/USa2tbVPqPP
         bVh808lz1FKkQBgSqawAVKcXd2IE0PSEXDLxaHuCzOhzkLeayVOk1Rbv9tBTzsc7m9La
         FPlEr1Hh9XV7syfQJxejQ1Gih0ALtGpxh/iQpHI6jwDUrfwTDmDQNheU+ACSWecPBU+h
         dAKRrkwyZW3qv+3B5G+bwP+jNIEqcW2mNm/p294DlLD18aTsQke5ZZyqVuV5Gl6fPqA/
         hsGQ==
X-Gm-Message-State: AO0yUKUGHP7MRd5fUdtFLv1rIbYDzBVy8/Mm70W/CSAUl2SzBhSEUuoY
        wg+J55ZAKPiisjF6jCEwVda+XA==
X-Google-Smtp-Source: AK7set9dk+CAqDZes0jxHQYmgJHEtMKUFbr5JbHgUMiQ/8tZWwFWDoce+nP6IcyAWHRx026mDdaNnQ==
X-Received: by 2002:a17:907:c61b:b0:878:4e5a:18b8 with SMTP id ud27-20020a170907c61b00b008784e5a18b8mr30977606ejc.66.1678533189212;
        Sat, 11 Mar 2023 03:13:09 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id s11-20020a170906bc4b00b008ee95ccfe06sm973189ejv.119.2023.03.11.03.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:13:08 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mun Yew Tham <mun.yew.tham@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Nandor Han <nandor.han@ge.com>,
        Semi Malinen <semi.malinen@ge.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/8] gpio: ftgpio010: drop of_match_ptr for ID table
Date:   Sat, 11 Mar 2023 12:13:00 +0100
Message-Id: <20230311111307.251123-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

  drivers/gpio/gpio-ftgpio010.c:336:34: error: ‘ftgpio_gpio_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpio/gpio-ftgpio010.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-ftgpio010.c b/drivers/gpio/gpio-ftgpio010.c
index 2728672ef9f8..31e26072f6ae 100644
--- a/drivers/gpio/gpio-ftgpio010.c
+++ b/drivers/gpio/gpio-ftgpio010.c
@@ -349,7 +349,7 @@ static const struct of_device_id ftgpio_gpio_of_match[] = {
 static struct platform_driver ftgpio_gpio_driver = {
 	.driver = {
 		.name		= "ftgpio010-gpio",
-		.of_match_table = of_match_ptr(ftgpio_gpio_of_match),
+		.of_match_table = ftgpio_gpio_of_match,
 	},
 	.probe = ftgpio_gpio_probe,
 	.remove = ftgpio_gpio_remove,
-- 
2.34.1

