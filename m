Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F06463BE7C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 12:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbiK2LAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 06:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbiK2LAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:00:21 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158D15CD1B
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:00:21 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id x17so21447381wrn.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S89n9QHiQI/y9x3/RBBeD2hc63bXZL5TZ/yxbLwZvtk=;
        b=jTcvcwuWvgNvHwmUmzeQMRVKAegOPcG2ZjwxB2PW33UgzTjp7jTbcmYCdOdzAWYCND
         6Z0YViqTRRWciA4Am8h1w4W+rV1C/VQqg1fsB7P5fVygNls+q8UKXBGBRDdaVN8OUyw+
         S8uJDDfsj9Mfo822ih5yTnQ6EVPY9NHvUZP9wastoPuSVRQU3rQQyCtwk7jcT9CyN5ib
         MO1GHOTpy+jVHzuExdKOT41YwOrKL+kg6k3fSne9MNYeDvPaBuh360U95SWT2v+0LJK2
         GtTVy6MJydQB7AVsB8iADs5hIWbRNAF4Qidc0tm4uj/9ogoFAABJ5mtBopjIWQXocXm3
         kR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S89n9QHiQI/y9x3/RBBeD2hc63bXZL5TZ/yxbLwZvtk=;
        b=I4klsgQGhDkduOF2QyOncZMAo33NZ/spsqX6aM34/mSkoGiQOt0YKEbYjHSWTy9yLo
         IwciqoW1EI1ofMR+VBGRZP2ghIeqQl1wkPsBP/vlDhXg+6r3ZGG9pTXj0X5X0qCz2Ma9
         I+d3n4JN9t/jeWAvsZiFhsicHTsn6+zcprkT9vKjU/q6JoJzbPixk06VahtaFtxBU4+G
         sIWFH9QOJ9ukc2BzDpx4Vv+0y09DPgdjfXRTAFuYhkSCxUfzZEWwnUqc2/Xt+6rZ0mI5
         Z1+OyBY/nrM2d/fgka9SG5Ja76FBtkvuXCsD9OQfkUVh9fKtGFo7BXB7F3CuCOdc56h7
         XmUg==
X-Gm-Message-State: ANoB5pmmYf10+BNCJf/4p9ysAmsdA8O/el3pm2MuUUJCXBZVDJb4M+uo
        6D8sG912Vw+B9efE9ZXzNlVLKQ==
X-Google-Smtp-Source: AA0mqf63DpeHwXIOAS4d7AWl06t+1JwTBGisL74b30trT7xhe1v8XK9Jo9js7HcdVbdROc3U8Gg1+A==
X-Received: by 2002:a5d:55c3:0:b0:236:c12b:6e29 with SMTP id i3-20020a5d55c3000000b00236c12b6e29mr33781968wrw.98.1669719619592;
        Tue, 29 Nov 2022 03:00:19 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6b19:1d8e:fbca:fd02])
        by smtp.gmail.com with ESMTPSA id q19-20020a1cf313000000b003a3170a7af9sm1617658wmq.4.2022.11.29.03.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 03:00:19 -0800 (PST)
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
Subject: [PATCH v4 02/13] tty: serial: qcom-geni-serial: remove unused symbols
Date:   Tue, 29 Nov 2022 12:00:01 +0100
Message-Id: <20221129110012.224685-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221129110012.224685-1-brgl@bgdev.pl>
References: <20221129110012.224685-1-brgl@bgdev.pl>
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

Drop all unused symbols from the driver.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 9f2212e7b5ec..7af5df6833c7 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -42,20 +42,11 @@
 #define UART_TX_PAR_EN		BIT(0)
 #define UART_CTS_MASK		BIT(1)
 
-/* SE_UART_TX_WORD_LEN */
-#define TX_WORD_LEN_MSK		GENMASK(9, 0)
-
 /* SE_UART_TX_STOP_BIT_LEN */
-#define TX_STOP_BIT_LEN_MSK	GENMASK(23, 0)
 #define TX_STOP_BIT_LEN_1	0
-#define TX_STOP_BIT_LEN_1_5	1
 #define TX_STOP_BIT_LEN_2	2
 
-/* SE_UART_TX_TRANS_LEN */
-#define TX_TRANS_LEN_MSK	GENMASK(23, 0)
-
 /* SE_UART_RX_TRANS_CFG */
-#define UART_RX_INS_STATUS_BIT	BIT(2)
 #define UART_RX_PAR_EN		BIT(3)
 
 /* SE_UART_RX_WORD_LEN */
@@ -66,12 +57,9 @@
 
 /* SE_UART_TX_PARITY_CFG/RX_PARITY_CFG */
 #define PAR_CALC_EN		BIT(0)
-#define PAR_MODE_MSK		GENMASK(2, 1)
-#define PAR_MODE_SHFT		1
 #define PAR_EVEN		0x00
 #define PAR_ODD			0x01
 #define PAR_SPACE		0x10
-#define PAR_MARK		0x11
 
 /* SE_UART_MANUAL_RFR register fields */
 #define UART_MANUAL_RFR_EN	BIT(31)
@@ -80,11 +68,8 @@
 
 /* UART M_CMD OP codes */
 #define UART_START_TX		0x1
-#define UART_START_BREAK	0x4
-#define UART_STOP_BREAK		0x5
 /* UART S_CMD OP codes */
 #define UART_START_READ		0x1
-#define UART_PARAM		0x1
 
 #define UART_OVERSAMPLING	32
 #define STALE_TIMEOUT		16
-- 
2.37.2

