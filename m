Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8796339D3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbiKVKW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbiKVKVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:21:52 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4968C1E705
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:21:44 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id bs21so23993234wrb.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S89n9QHiQI/y9x3/RBBeD2hc63bXZL5TZ/yxbLwZvtk=;
        b=lXri/kjkjF6wgMkUC9670NWTNkvUagyJHjO/mp/WQk9YIFgBxvqgeKuTRyPtSwv4Ys
         0szCZxbswm8NB260ozpnUy5hd4bw0SwWXRuMyRpv9+Z+IUAGnw0oDT2tCAvXZWihBSUd
         3dH/qKcJm9mNyi5V5uhQw1B2Io4JszwFJA934peEDCI7VUOGCjp735xlfETSwowadnC6
         DPCPzzA0U7P0nQIVUfBmjCJnFYl6145znTct8ToidcomhW/VQR+1J9R+GnIuSmT38urb
         mEbloh9iU4FT3uTLqf2i97w2jpnakU2HJv9w7vXSIkIgfbrNmLyhA1WkDHS0YtEL4PKU
         f5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S89n9QHiQI/y9x3/RBBeD2hc63bXZL5TZ/yxbLwZvtk=;
        b=fg+cxSqSwTaJPrb6LUxFBFznZa+2nukO4yhBK6fZdLjI5gzlCZQe0H3uT6n7FEKgcx
         UMCEGz13s9vsvVBGihX4jMfxwxUWFsxzbrQuS/ZUlab/foPlVQvtXeFPmf9tIDG9JWMS
         YX7ivzaIy8eddQ+TkGJWzBcNSlc8xakX+N37GQsJNnzXrZ+2YzR2lQYjI27RrLmQzp22
         G6a9YoF4aR5duFkmdcTvJp+zYvvCuYbFuSBm9vsxKwuw/9hmkvsDt0ppY28nAuLsMvSX
         qMSAB7VlNpZ1d+Hhdxi5p9FqBjUAeK79vn2JTRsBXHhpfh7f69SmOQqFrSl1SEVAFXsD
         Kitw==
X-Gm-Message-State: ANoB5pk6hF/q3YUnyc4QXMxjsU9WGQ5qQrTqDL6jO4WZFR0THZumBZsO
        /Lj/aUfXhuA9f3T3AZ01bDSEBA==
X-Google-Smtp-Source: AA0mqf7T/UGTI8PICc6/eFUx/UjF4InHLPn+jrCX3I6f0b9GOgRStPUmk5A0bgznjN0NqS1sK3yUpg==
X-Received: by 2002:adf:cd82:0:b0:238:b29e:4919 with SMTP id q2-20020adfcd82000000b00238b29e4919mr13769717wrj.583.1669112502874;
        Tue, 22 Nov 2022 02:21:42 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e011:9e81:66f1:3415])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d4083000000b002366e8eee11sm13432873wrp.101.2022.11.22.02.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 02:21:42 -0800 (PST)
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
Subject: [PATCH v2 02/15] tty: serial: qcom-geni-serial: remove unused symbols
Date:   Tue, 22 Nov 2022 11:21:12 +0100
Message-Id: <20221122102125.142075-3-brgl@bgdev.pl>
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

