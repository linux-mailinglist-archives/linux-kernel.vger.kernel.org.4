Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8BF635B32
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236787AbiKWLI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237417AbiKWLI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:08:28 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287046D481
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 03:08:08 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d1so16732490wrs.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 03:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S89n9QHiQI/y9x3/RBBeD2hc63bXZL5TZ/yxbLwZvtk=;
        b=YLqfKb2uPUZ5u8IKKS8v9dFwT1LJ3cQXBokiRhpYXLPsy0W4TeKCSP0n4hLrJWbmgQ
         /WyJVHReGFQoibIMoOazDY19AavkjJyJzzYTuW/q+6S3Zl2CwkSRpO0+o/yB11f+Lvlj
         rxPq23bonpm/1SWbJMHaqMPuecnx/k9wRrjdphPsBoJo+3k2QIVJd/g/mQB4rNWLkWJm
         pg2DzOdMBSgO08ySMjaT73dhp90A1xPbnCzm5gNwM7kNXW8pE2Pf0APhe8GpIrBYet1o
         frNq4IxSVxq7jrgFkHkt5DUItvwNqNhXd9gjyv7/yvBDF3mp9XTjCIKfeFGOh/BQxHj0
         Co3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S89n9QHiQI/y9x3/RBBeD2hc63bXZL5TZ/yxbLwZvtk=;
        b=WvrA61zv9TfS01eCYPYZuSjFloYJBFYxd3DMYjvVtwnkxPrfaHlnqYwDJ1u5IksUix
         oFiJIFh7bs45La8uSWFd6+wvSBrrjBkQUxSjPdv/WAiMBCgGgJ2vvhAvJd/gxI5LnOyy
         +17A0iTwxfm8pJ/SqB8+tZPK1HY8tBiltx94F+qt9VCK89/68amr15Gg+S8pOM6QGbPC
         tc2W7vB/IX1PAnsw4u6lnM+qA+OdRdTNQk6x8neP5B2lqwe/rlG3JBZ8Ezx0RwAv2ZMt
         hNv899o6yweYtWyEIoy35AopQfNg2HeM8penxPHN+KKBSjJlkEc61J8EegO/psMka48F
         6bAw==
X-Gm-Message-State: ANoB5pk9/26AvReRKa0531A3w3ZM48sznpc4BTbsbt1jxt7qsIS78XYx
        88bmQO9D/OAmVB4RcZVqdLqRfQ==
X-Google-Smtp-Source: AA0mqf7XcXHsZrQ0kn+i9/4Tav71MGu3rtYjFsUzq5XSxZTFgjB20GPpjRhgmHjxcvjkPYiEGRCBUA==
X-Received: by 2002:adf:e7ce:0:b0:22e:4864:ee11 with SMTP id e14-20020adfe7ce000000b0022e4864ee11mr5599177wrn.488.1669201686677;
        Wed, 23 Nov 2022 03:08:06 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ae74:d94f:4677:3378])
        by smtp.gmail.com with ESMTPSA id f13-20020a05600c4e8d00b003c6c182bef9sm2560406wmq.36.2022.11.23.03.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 03:08:06 -0800 (PST)
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
Subject: [PATCH v3 02/13] tty: serial: qcom-geni-serial: remove unused symbols
Date:   Wed, 23 Nov 2022 12:07:48 +0100
Message-Id: <20221123110759.1836666-3-brgl@bgdev.pl>
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

