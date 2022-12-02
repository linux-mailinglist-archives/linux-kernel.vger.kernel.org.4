Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F726402A7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbiLBI5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbiLBI41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:56:27 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25EAC0552
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 00:56:05 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d1so6747158wrs.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 00:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbfRkHz4/aW9Ej0X8Fhaj4Le2T1GhSly/B7XfhIOtq0=;
        b=JktLJu4rVvE9sWZWbk7w7Rz8IZyV0rFZh+goJTP/i2KKdtHMA4S8T1vUcxSTh/5ywY
         sXpRLYx/VPIcPs14Tz98iyvtpyZC+uV/e8WmlIZe5YkBzcvgCuwzGYh2P6fw4WcfV074
         vX4GWxX++bFE5BBxm44+CPuqtXpQGSAg4nrco7uhdkSfUX/yLy0uumrtiZJ6So0E0AWQ
         bgCMWEQ23qOm1apcuaTjanWDftzLAz827SbpcZ+daBynmQ5P2iXU1EZ7jNkdpjVlT3tX
         I4sKvXnQiW7/q3SnuUGjfwsuKOlqZkw4yl3O0pBJR3yAcRCWd0spk7xBIx2NGQ2IwjVt
         OcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbfRkHz4/aW9Ej0X8Fhaj4Le2T1GhSly/B7XfhIOtq0=;
        b=2vlFWxTtrRi1A9nCbok+ZNsO4Dp+0QUlOx1qSjscyvdzMOJxHFSYQOsqmc9ZXAYFzm
         DxRGUXU04a5rWQIwPm1Jsx0NAukCDIZHFpqzH+yjqYxE1ErDkc73h0O7fhZBssHEAPE8
         OoTfxxVfXqLO/5MZ+40X6m7BXQnUEB7TlRjnseT/Ne9exAz3eSVqfsiHxBvJUPFyZdSF
         et8w3XaZfnkFX2s+yST/Pqfv5oB+lB8HHLGlBtUka1pMl96GXs3zCHSrkukVkcc0Zkah
         WDw9RFxZFVMHNufR4cVhrNIasGuPvW2I1z3FqB1NNsBhqy4lQDd1Nza1MrtykLKLg5PK
         fmhA==
X-Gm-Message-State: ANoB5pmAuSJVPiwE5QCx/FQK66DOfNHVOtImuMj1kPQcBZn+h4PULrP9
        THA1FG45bF1cVReN+GEey8E2WA==
X-Google-Smtp-Source: AA0mqf6W5dJs+6xkkg/KNDhThIeAo4VOfAUHRRveInmom0lnH/BHM1cBfTRQY1FlCMakbSRwzwpicg==
X-Received: by 2002:adf:f2d0:0:b0:242:7c:eb9c with SMTP id d16-20020adff2d0000000b00242007ceb9cmr24328148wrp.178.1669971364317;
        Fri, 02 Dec 2022 00:56:04 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:29a4:6f04:ddb1:1ed7])
        by smtp.gmail.com with ESMTPSA id a13-20020adfed0d000000b0024219b1cb1bsm6527517wro.60.2022.12.02.00.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 00:56:03 -0800 (PST)
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
Subject: [PATCH v5 07/14] tty: serial: qcom-geni-serial: remove unneeded tabs
Date:   Fri,  2 Dec 2022 09:55:47 +0100
Message-Id: <20221202085554.59637-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221202085554.59637-1-brgl@bgdev.pl>
References: <20221202085554.59637-1-brgl@bgdev.pl>
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

