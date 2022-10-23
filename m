Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEC3609379
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 15:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiJWNOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 09:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiJWNOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 09:14:34 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51DD78BEE;
        Sun, 23 Oct 2022 06:14:03 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id m29-20020a05600c3b1d00b003c6bf423c71so8279260wms.0;
        Sun, 23 Oct 2022 06:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wICd/6PuTpid08ZKJYuwFfQs4b4ZSUfrEfLUDuMq7r4=;
        b=JJX2GWKwf2YgbHt0hvOHPyJRdg9csx7yobCOxSl4OlV/k4EIkjtl3ZSbXdrqxgGt4b
         /mRLZpeVd5vo4k+zoIj3d3qJobh3P59OcfAnk3s9rYenrtUF/H8IV26QnwZhZFxo/pPp
         ZgPCRlw/qEwNCSWlZHe57rqi4PXFDzHYD9CuYsUDo/7AXTsCfHZeBGV24OxZ9gcONrL+
         mCycGgJl+ts1sDrVInAr7HBGGhLSfGC1XrmgF765sy0WfIGL5lf+2tI/5RTS0MC7QlDb
         7FHuJdb15Rl3PUMQNWvTVvL8QAEi2cMxZyn+ZQfvhalXqo718Xbccys5GD9heftxUxo3
         as/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wICd/6PuTpid08ZKJYuwFfQs4b4ZSUfrEfLUDuMq7r4=;
        b=M7R+jouOVDpZKrKiz25odtx6nJbP2jXVdSz1lHZ8BR7QmI+iFhFa/WwwGlDlgltWfW
         YYCphQyW70T7gyy8W9OKWlSzzk0OkQL3+Ls2plbrru95Dxmfgy+LUUw82zN//4FVaFRe
         /bl8kLzI52UZxskCYPkvO8T+FgsGlYyOhOz620OG/KgZsvMT0W8oHYKIxjnR6yuS3wa7
         497Wb52W0qO4IiKV1oaMcxYAKKVlXajmTGfCCmgYJUsmxMzUl/SGf7PAoQC9jJ6nBlYz
         heUDUGD/8WA7nua04UEjll7rjXJ37pt2sxApB8rsZTSgnEl87zUrBnCNvRwS4IO41yKM
         SQQg==
X-Gm-Message-State: ACrzQf2CV1fs8ZIna3PnqkfJBlLLgXvvrWoi7PX6e015wWPIxld7ron1
        lAO+kcSU5f6fcY/Uzipfx6Bc9ZFUjG820A==
X-Google-Smtp-Source: AMsMyM7JQtRBvg+KGHjDb5WDChiHG5AKSbZaYThDcjUEpLbpzfHhN9OBrCNC/7BoFF95WHut9cGobg==
X-Received: by 2002:a05:600c:4784:b0:3c7:b52:3a9f with SMTP id k4-20020a05600c478400b003c70b523a9fmr12879211wmo.46.1666530839599;
        Sun, 23 Oct 2022 06:13:59 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-133-19-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.19.133])
        by smtp.gmail.com with ESMTPSA id l24-20020a1c7918000000b003b50428cf66sm8302475wme.33.2022.10.23.06.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 06:13:59 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v4 2/3] dt-bindings: clock: Add Ingenic JZ4755 CGU header
Date:   Sun, 23 Oct 2022 16:13:30 +0300
Message-Id: <20221023131331.4107782-3-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221023131331.4107782-1-lis8215@gmail.com>
References: <20221023131331.4107782-1-lis8215@gmail.com>
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

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

