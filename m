Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE91635B3F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236978AbiKWLJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237571AbiKWLIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:08:32 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D349A5E3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 03:08:12 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id i12so24982662wrb.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 03:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbfRkHz4/aW9Ej0X8Fhaj4Le2T1GhSly/B7XfhIOtq0=;
        b=AGy0MYOOnKebCT2KvF1CA0lwhTW5qhu60TOQyMYjiIwYYdPvzBjMuqCy34ZDxnOxAa
         /noqVpIyDg6WR3oa8Q7ty/FSxYJjUcMqDLC0h71qbKFJaMTS9lNxf1s+SG+Pv3iK8o9P
         KaFXodivUlB865KxyrafFF6OAobC87eZ5mpN1Zd7iX70ciN0aZJsGdpAyr7br6/WhF6u
         +787dPruWXzqtJx7coNQAyKBlgKm+Xn9MxwYt3IjRLM9OJdOEsyUBNYnFYHn35ZRTAux
         HAFIgGzIEDnPEMIUK2RbRrdAmKc+6wcIV675j+zrsYJg4qi7kkvp/UshHndKfMe5E8x4
         6pXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbfRkHz4/aW9Ej0X8Fhaj4Le2T1GhSly/B7XfhIOtq0=;
        b=xLNFJQfHbjo5z72sz/Tost9ttF09Gfq+n5Grxw9Jdh5s1ubNJUNlmcE9fmZcXV7rnV
         SB54sL3VCdVGgHOMMJD3jC8PZOGXIOk4VsZQuIc0VbAZfVVHJH2gzA5mW4aTxRykf65C
         eEWTKoHiyUrnA9peYcHH1iS9L9sDh+tgXHl3Jgy++upc1r2VTWZk2XSKNvJCp3iu8nfn
         LUoax/0tBVWk2T6xSLjYFhYgbfu/HGUXpWssZ0eHbN/OUwV6Z9sGi9L5pUrdIYgk+74d
         tpI20gcqiib3WpNawCvNGoB0klMxKBNqB7AP0E29mpdkcMv60fYwLJBl/nxDsRvlyT+g
         9b9Q==
X-Gm-Message-State: ANoB5pkap46vl9zL+nj6Av7czF5llt+iVcJZixkqeoI+KUHG06/KQF3n
        XWC4ma89QpPQYN3EGv1srHjg4g==
X-Google-Smtp-Source: AA0mqf5a6EWO6iA5XpckEqZAv+qcaVpLZ0FVszb3Hr1WY/QMYQASstS57/Zoy0LEyudGTj73jAsb+w==
X-Received: by 2002:a5d:4e43:0:b0:241:d029:e98b with SMTP id r3-20020a5d4e43000000b00241d029e98bmr9305875wrt.551.1669201691326;
        Wed, 23 Nov 2022 03:08:11 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ae74:d94f:4677:3378])
        by smtp.gmail.com with ESMTPSA id f13-20020a05600c4e8d00b003c6c182bef9sm2560406wmq.36.2022.11.23.03.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 03:08:11 -0800 (PST)
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
Subject: [PATCH v3 07/13] tty: serial: qcom-geni-serial: remove unneeded tabs
Date:   Wed, 23 Nov 2022 12:07:53 +0100
Message-Id: <20221123110759.1836666-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221123110759.1836666-1-brgl@bgdev.pl>
References: <20221123110759.1836666-1-brgl@bgdev.pl>
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

