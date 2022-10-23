Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DA56092C5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 14:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiJWMkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 08:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiJWMkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 08:40:35 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C47560533;
        Sun, 23 Oct 2022 05:40:27 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id v130-20020a1cac88000000b003bcde03bd44so8208076wme.5;
        Sun, 23 Oct 2022 05:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dapqSS0sMMSi71c9uytzDUSoWkN0M+DqgZAAqUkXNhU=;
        b=L728Dv3vR5mTRcYmuntXxgRAArTGo3XY6IxnUJfJNCJ7NJ93gxwH3uRJXjiIYQD3fl
         BCwkLp/x3AvR6MHUo+Uh8hjaCJSR0g5PBvFYXhXOTbBVgJ1gU2in87DilqqtsHZ7p/fH
         iqxX7xLPONxypuvXdcqT380UYPyt74iennkEpDjCig7+t21VZJeMPv1fGrUUPtFvNcxo
         craedP4azVWaXXtgXqNuyG/V2p4PH43yOF0yRCWPjOB0BxjTxQdeak4Kwpa4pWW/phjK
         6rFjwuL22H1TrbU66Dyqroko1q6f19fOHUx+RbTNk0IbxQ1Tmej0s3HzZavH1CB+87Pf
         r0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dapqSS0sMMSi71c9uytzDUSoWkN0M+DqgZAAqUkXNhU=;
        b=yNDZRNpXvVec9WC5y4BTTAQXukh4pwOyWPiy1aPf6whoawURfYvNqEf8q2cXP5xfcL
         mFnScfBwd4LCsfcqxYcf4r2kB9/ROq8EeH5+0QRrwbRyDeHHqGz51im5T07YpDRaXr1u
         0vU3YT0VM8NVc1N6WmtxhsZ4HP3QzJe3eiUaikQ2e0Sq+K79+87/L5JmnP1xVNHkk+sX
         eFssG5zTf56+/9Tqb1XzkwuIJyclbOLaQfzx+74BYH9ACKjUZ25RWUASu/GJmS+SJtJy
         0M0dFDGmEyZD9M8jgOXsJNBFIWpzT0lgAQmPzTpryyj9usZRJdx+/+5gwJdhKxnYbufY
         F82g==
X-Gm-Message-State: ACrzQf0Xj8TfJwzdWI2Io9qJmMbfnzlrS28VitHv6+2Fy8nWPHnoFzr4
        HSK5E6n4TdP3wVhqxozmeo4=
X-Google-Smtp-Source: AMsMyM7Mm3RbyqU1MF11/9Ol4tVUD1YWbDlFhX3EWNg/dxElqNn6Tl/3fpca05N5K/w00GT1HG/itg==
X-Received: by 2002:a05:600c:a47:b0:3a6:5848:4bde with SMTP id c7-20020a05600c0a4700b003a658484bdemr39291297wmq.189.1666528825806;
        Sun, 23 Oct 2022 05:40:25 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-133-19-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.19.133])
        by smtp.gmail.com with ESMTPSA id p5-20020a1c5445000000b003c71358a42dsm6286497wmi.18.2022.10.23.05.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 05:40:25 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v3 2/3] dt-bindings: clock: Add Ingenic JZ4755 CGU header
Date:   Sun, 23 Oct 2022 15:39:43 +0300
Message-Id: <20221023123944.4103876-3-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221023123944.4103876-1-lis8215@gmail.com>
References: <20221023123944.4103876-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be used from the devicetree bindings to specify the clocks
that should be obtained from the jz4755-cgu driver.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 .../dt-bindings/clock/ingenic,jz4755-cgu.h    | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 include/dt-bindings/clock/ingenic,jz4755-cgu.h

diff --git a/include/dt-bindings/clock/ingenic,jz4755-cgu.h b/include/dt-bindings/clock/ingenic,jz4755-cgu.h
new file mode 100644
index 000000000..10098494e
--- /dev/null
+++ b/include/dt-bindings/clock/ingenic,jz4755-cgu.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * This header provides clock numbers for the ingenic,jz4755-cgu DT binding.
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_JZ4755_CGU_H__
+#define __DT_BINDINGS_CLOCK_JZ4755_CGU_H__
+
+#define JZ4755_CLK_EXT		0
+#define JZ4755_CLK_OSC32K	1
+#define JZ4755_CLK_PLL		2
+#define JZ4755_CLK_PLL_HALF	3
+#define JZ4755_CLK_EXT_HALF	4
+#define JZ4755_CLK_CCLK		5
+#define JZ4755_CLK_H0CLK	6
+#define JZ4755_CLK_PCLK		7
+#define JZ4755_CLK_MCLK		8
+#define JZ4755_CLK_H1CLK	9
+#define JZ4755_CLK_UDC		10
+#define JZ4755_CLK_LCD		11
+#define JZ4755_CLK_UART0	12
+#define JZ4755_CLK_UART1	13
+#define JZ4755_CLK_UART2	14
+#define JZ4755_CLK_DMA		15
+#define JZ4755_CLK_MMC		16
+#define JZ4755_CLK_MMC0		17
+#define JZ4755_CLK_MMC1		18
+#define JZ4755_CLK_EXT512	19
+#define JZ4755_CLK_RTC		20
+#define JZ4755_CLK_UDC_PHY	21
+#define JZ4755_CLK_I2S		22
+#define JZ4755_CLK_SPI		23
+#define JZ4755_CLK_AIC		24
+#define JZ4755_CLK_ADC		25
+#define JZ4755_CLK_TCU		26
+#define JZ4755_CLK_BCH		27
+#define JZ4755_CLK_I2C		28
+#define JZ4755_CLK_TVE		29
+#define JZ4755_CLK_CIM		30
+#define JZ4755_CLK_AUX_CPU	31
+#define JZ4755_CLK_AHB1		32
+#define JZ4755_CLK_IDCT		33
+#define JZ4755_CLK_DB		34
+#define JZ4755_CLK_ME		35
+#define JZ4755_CLK_MC		36
+#define JZ4755_CLK_TSSI		37
+#define JZ4755_CLK_IPU		38
+
+#endif /* __DT_BINDINGS_CLOCK_JZ4755_CGU_H__ */
-- 
2.36.1

