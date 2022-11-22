Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294816339E1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbiKVKXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiKVKWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:22:03 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A423C6C9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:21:49 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id x5so19908817wrt.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbfRkHz4/aW9Ej0X8Fhaj4Le2T1GhSly/B7XfhIOtq0=;
        b=badEK2WdoytxqPHQQJ2dTGNsZ/Ug5vkC26Nuou2trL0/6fuUZ+KxcNaBjzdiIxCemR
         6wUkqx0R09h98Z/pHx3QSQ8r5ikWtPMk4EOuf/jxEn6k9SKtlNh8Mslt8UertvXt8JYn
         R4Revq2bFvBZlbdEQEqXL4hkr2J1SiL1C9rdjSaauNFB7c+omPi1EabF+Kt1k1c1tRip
         W8Lsxn1gIt8Z7e3u8Frq0XEd1WyY1EFig365eTh26oYz7TZFAc3KAZW5Nj9vMHs3fb3N
         MOuLD/3+PHqya6638adyVVlXaISFVZ+cxrPqzijS76PciKbT7LzKbyc1BNf/uj4iJTmw
         dxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbfRkHz4/aW9Ej0X8Fhaj4Le2T1GhSly/B7XfhIOtq0=;
        b=hIWCTS7e9EXAg2eXSQ8Ls+Ah2n7XZ73kI2bv7T+ocpJcv9t1vL4Z4iC1CgCWnTyOva
         2qvw3L+Z6yG1FdgsItTlwPXpEhz4qF5axDWBQh9erkpr2SWrseojTNyQz6KaZzgBMCob
         3KK1G7rSjh3hy23+5sMlGi5C3T8as+rD1nsdu94um9g30KI6Gse6rIwOE175IE4zzr8i
         HgrZoQHfIyaksWDxiMIynEwvfVxFTta0ECf+FwcUTdFtqEBq4jEKOBKYvZ438N3OcV0l
         HYYraaukc5dOYzugQGEsQtRiIbuSBG5dnxpuQI3sEl7LnglgrG4CV3dCiuTwMnZpycFU
         HTFw==
X-Gm-Message-State: ANoB5plWq4RD1AQw0y7AtWxP1Eu1LO6zFA7ZsQ1HbzB9yvPtsBISWha5
        vJpgprXX9NTMXd9dcErur+e0aw==
X-Google-Smtp-Source: AA0mqf5ZisxDZOYZShoBLE3WJna9NP2GLBaYluJa7DSKYMkB13kdH9DiyZBHO5vRifYM0dJqpr6FrQ==
X-Received: by 2002:adf:fdcb:0:b0:22e:386f:4088 with SMTP id i11-20020adffdcb000000b0022e386f4088mr13828460wrs.526.1669112507986;
        Tue, 22 Nov 2022 02:21:47 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e011:9e81:66f1:3415])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d4083000000b002366e8eee11sm13432873wrp.101.2022.11.22.02.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 02:21:47 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 07/15] tty: serial: qcom-geni-serial: remove unneeded tabs
Date:   Tue, 22 Nov 2022 11:21:17 +0100
Message-Id: <20221122102125.142075-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221122102125.142075-1-brgl@bgdev.pl>
References: <20221122102125.142075-1-brgl@bgdev.pl>
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

Remove redundant indentation in struct member assignment.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index fba02f71a874..68a1402fbe58 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -141,26 +141,26 @@ static inline struct qcom_geni_serial_port *to_dev_port(struct uart_port *uport)
 static struct qcom_geni_serial_port qcom_geni_uart_ports[GENI_UART_PORTS] = {
 	[0] = {
 		.uport = {
-				.iotype = UPIO_MEM,
-				.ops = &qcom_geni_uart_pops,
-				.flags = UPF_BOOT_AUTOCONF,
-				.line = 0,
+			.iotype = UPIO_MEM,
+			.ops = &qcom_geni_uart_pops,
+			.flags = UPF_BOOT_AUTOCONF,
+			.line = 0,
 		},
 	},
 	[1] = {
 		.uport = {
-				.iotype = UPIO_MEM,
-				.ops = &qcom_geni_uart_pops,
-				.flags = UPF_BOOT_AUTOCONF,
-				.line = 1,
+			.iotype = UPIO_MEM,
+			.ops = &qcom_geni_uart_pops,
+			.flags = UPF_BOOT_AUTOCONF,
+			.line = 1,
 		},
 	},
 	[2] = {
 		.uport = {
-				.iotype = UPIO_MEM,
-				.ops = &qcom_geni_uart_pops,
-				.flags = UPF_BOOT_AUTOCONF,
-				.line = 2,
+			.iotype = UPIO_MEM,
+			.ops = &qcom_geni_uart_pops,
+			.flags = UPF_BOOT_AUTOCONF,
+			.line = 2,
 		},
 	},
 };
-- 
2.37.2

