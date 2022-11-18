Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97AF62F4B3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241904AbiKRM1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241653AbiKRM0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:26:44 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFF99AC90
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:26:16 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id g12so8983777wrs.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ko+jjIDfILZRTvWmBV6W3WbxjLYlDDq9YeO4lkVcz7M=;
        b=wG6BBClFrP2ZpUq0SJaBVD26AkZ5G8xLeHuWRnkPNUG3LlK+lWfYOfpgG0tc92N1uK
         bUTXlgbeYtc5LiKT1YUb/h911q40aey2mzMn78dr2JFvwzletg79ZcqvbOqrXqsNPsLm
         G2G20KJ/8PP5178vDp02V87OlmQrRXPFUZ0X4zuCszl2nNuRrM7r5jfaJ+MCW4Yr+03y
         NYHlmAhr7aIddmXYZzez/xrD5V2fac10Sn4OTaFyEWP1LkUWHxMAyJDb92U7QmoxelwL
         UXB9oa4sFaWx8nqZScC9nLt2IRbGlSv/rrH8gH+Jcb34jmw9LvrWuqIiIPgmzi0KhhBH
         W9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ko+jjIDfILZRTvWmBV6W3WbxjLYlDDq9YeO4lkVcz7M=;
        b=abxepKHv4o9oebDCP6ncZ8y+yj01hfG9EsVa4m0ev3dkQ1wCM/vdbmAHRYely2ovwM
         KP8gdQXpYMLuWQKE/wp5tct7iYQntNbf61R/p8nM5SsSA6g3zcFY+dlZfUeKmTsyjHkq
         FkZp5SAi38Yylg9Uc0ea8GIkrZzpD4nisUyeg3w/cdiHpz1ZOv3oICWVX+hMW3i0wiGl
         tcV4CvqiHkvx3xz0EVEiWl0sVfLmEGeRKUGxaGCAKExI4Sxh5HmjAEbv6tYnqLQudPM0
         U1ySPSfkZ38XH4NbwV/7tj3BceEI1hTrZ2Au9tbypvmWVYECPqUB/DjIeY8ajc2A+K+a
         VBHA==
X-Gm-Message-State: ANoB5pkWTP7Tudv0dAXKTNdjgt2lrZ4A6ice1GnnA9lPdZm9SA8fASCs
        s9xHpo7opg3XzONXVbyJG08QsQ==
X-Google-Smtp-Source: AA0mqf7Q8YXDa6glOlpsZy8Ib6F5FK6TZn0OFn0WyHhGik6nIMe0ij6UF+WYSrTLepeQhB0pHEU/Rg==
X-Received: by 2002:a5d:5685:0:b0:235:f0a6:fafd with SMTP id f5-20020a5d5685000000b00235f0a6fafdmr4232376wrv.75.1668774374613;
        Fri, 18 Nov 2022 04:26:14 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b10c:1279:a704:75d4])
        by smtp.gmail.com with ESMTPSA id f19-20020a05600c155300b003c6f3e5ba42sm9873958wmg.46.2022.11.18.04.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 04:26:14 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 13/15] tty: serial: qcom-geni-serial: use devres for uart port management
Date:   Fri, 18 Nov 2022 13:25:37 +0100
Message-Id: <20221118122539.384993-14-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221118122539.384993-1-brgl@bgdev.pl>
References: <20221118122539.384993-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Shrink and simplify the probe() and remove() code by using the managed
variant of uart_add_one_port.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 091b8f277a04..cdd476d504da 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1457,7 +1457,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	uport->private_data = &port->private_data;
 	platform_set_drvdata(pdev, port);
 
-	ret = uart_add_one_port(drv, uport);
+	ret = devm_uart_add_one_port(&pdev->dev, drv, uport);
 	if (ret)
 		return ret;
 
@@ -1466,7 +1466,6 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 			IRQF_TRIGGER_HIGH, port->name, uport);
 	if (ret) {
 		dev_err(uport->dev, "Failed to get IRQ ret %d\n", ret);
-		uart_remove_one_port(drv, uport);
 		return ret;
 	}
 
@@ -1483,7 +1482,6 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 						port->wakeup_irq);
 		if (ret) {
 			device_init_wakeup(&pdev->dev, false);
-			uart_remove_one_port(drv, uport);
 			return ret;
 		}
 	}
@@ -1493,12 +1491,8 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 
 static int qcom_geni_serial_remove(struct platform_device *pdev)
 {
-	struct qcom_geni_serial_port *port = platform_get_drvdata(pdev);
-	struct uart_driver *drv = port->private_data.drv;
-
 	dev_pm_clear_wake_irq(&pdev->dev);
 	device_init_wakeup(&pdev->dev, false);
-	uart_remove_one_port(drv, &port->uport);
 
 	return 0;
 }
-- 
2.37.2

