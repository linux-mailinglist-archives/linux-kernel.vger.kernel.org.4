Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FA3658EE1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 17:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbiL2QUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 11:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbiL2QT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 11:19:58 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E6F13CFF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 08:19:56 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h16so17779127wrz.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 08:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDpCQXfYYeEajOv2TSbXiA18Zt/t8Tes9TDsjO3NMJY=;
        b=yNLYjLmFkWgpBuxsj3eCtD/tewyWrBUjf/VDqz9k2I8wFreh2JLvBmkwy76s9K2bR0
         NjIjDB5jdTOVn5I7OCol+10dKoOpfQDSmQsREjobtiiX+no1N6HDVDac63lGKrKVJHI7
         a/dNQgrAgkkbX6eo8gyHKBWD9yzCRpHHF0r9Wv+4q7mBUQyxIEGYIw8d/V2Ev/Sv6P6o
         70VS6oZnZq4wNuZ+4RA3ID0TQtRQLJnvpOtvu07/0mE5+IGovwljbG+qshXgqn8So+IN
         W8/Ex4HcTs7FfWUC1aXRWR1q4M9guN1IOsi0ZCSeoyBKrtN90J6A1o80zu4/EZ9dtDYs
         Fubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDpCQXfYYeEajOv2TSbXiA18Zt/t8Tes9TDsjO3NMJY=;
        b=bEASJQUAPt8i4v6V25wYz83xpuosr2gz53TGnN+5Ddn0q6EKu/bVTH6oXwuUS//10q
         mX0XpfVTsAQR1cwwNtbzCnk1i8pSbRugolxAgt1bxSm9nlYqs/CyQcWS8pS0b7mXI1eV
         sKxPzL/5w8sE7nZUp26IiujifWqcRRsUuaPMoxU0qiE6ymdOWQSOWnhez9zeLQMiGcRc
         EVJmSOH6DxyVqvQNbM4ovPhBfooQKgvSB9idWfxcHmeh0/hVODdPOHeha5jXp7islH1h
         pxotnkfFBnTEPUqUZrtDjiilas2NJrbjeEzoieEnNdsvn1PfPXtxoHD6hDHybhIZyu86
         hRdg==
X-Gm-Message-State: AFqh2kqtKfQbN1ZbY6ii3T4wsGiMuFBqo6JBMIyyrbLt1R+Ne7Je+LCI
        daC11LFvZdYeRlhp5pSa1JR/+A==
X-Google-Smtp-Source: AMrXdXvJkZIZ8ZCse4FEIYklGaB6f5dxdugGRdR7nEI4aKVZOu1OLJno2BcF9sbWPcmY//eCfxVizg==
X-Received: by 2002:adf:e383:0:b0:267:b8df:932b with SMTP id e3-20020adfe383000000b00267b8df932bmr23522542wrm.23.1672330795175;
        Thu, 29 Dec 2022 08:19:55 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:8f7a:98d8:9d8d:ced8])
        by smtp.gmail.com with ESMTPSA id t5-20020a5d49c5000000b0028cf987d944sm1333199wrs.33.2022.12.29.08.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 08:19:54 -0800 (PST)
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
Subject: [RESEND PATCH 2/2] tty: serial: qcom-geni-serial: use devres for uart port management
Date:   Thu, 29 Dec 2022 17:19:48 +0100
Message-Id: <20221229161948.594102-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221229161948.594102-1-brgl@bgdev.pl>
References: <20221229161948.594102-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Shrink and simplify the probe() and remove() code by using the managed
variant of uart_add_one_port().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index b487823f0e61..7d5b51d7fb9e 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1470,7 +1470,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, port);
 	port->handle_rx = console ? handle_rx_console : handle_rx_uart;
 
-	ret = uart_add_one_port(drv, uport);
+	ret = devm_uart_add_one_port(&pdev->dev, drv, uport);
 	if (ret)
 		return ret;
 
@@ -1479,7 +1479,6 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 			IRQF_TRIGGER_HIGH, port->name, uport);
 	if (ret) {
 		dev_err(uport->dev, "Failed to get IRQ ret %d\n", ret);
-		uart_remove_one_port(drv, uport);
 		return ret;
 	}
 
@@ -1496,7 +1495,6 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 						port->wakeup_irq);
 		if (ret) {
 			device_init_wakeup(&pdev->dev, false);
-			uart_remove_one_port(drv, uport);
 			return ret;
 		}
 	}
@@ -1506,12 +1504,8 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 
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

