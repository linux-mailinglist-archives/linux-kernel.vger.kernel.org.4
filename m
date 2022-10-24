Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E207B60995A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 06:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiJXEl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 00:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiJXElj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 00:41:39 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D564F644;
        Sun, 23 Oct 2022 21:41:38 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id bh7-20020a05600c3d0700b003c6fb3b2052so5879177wmb.2;
        Sun, 23 Oct 2022 21:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wICd/6PuTpid08ZKJYuwFfQs4b4ZSUfrEfLUDuMq7r4=;
        b=jjZRu61Zz9je/FuNlTUBvyCzyajBofhir7iaRQiirc5cqEPZbgGWSYX3FpKJRUMwpy
         M2eOBXg9j85DhSHRknLW+t+XRJxIbdtHnOhIE9cWIFJXDU+gwSFdiyBMH2gnJ820rYT3
         K3Kt+29QslICltY4OJTahLnylxchXxZ10Suy9ayQ/OAqToAvPPELIQP7uf6mf0kO+S89
         bItqF14g5jNghSMpwkwF2jKYgGsvmDdBZX5BaCNUqA3L1eAbVEt1mpwsJ+Zd1j/Po94u
         o79us3crzVgapMzUXdh5EJ11ihbOucW0qJrhbRlmPs2PrUUpOQH5kgshQe1UdKLfpL/l
         lXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wICd/6PuTpid08ZKJYuwFfQs4b4ZSUfrEfLUDuMq7r4=;
        b=kmn+6/Uk9d57V+80MZEVlfOQRzPVQqW9/5snbvzkwI0MinDDDRt2w0v80ANVq09hCW
         nnRHtn5rgqZBQESMHYkTVeCvjDHHNflUX46qKAeU0DwPhdPGvKa8XU1q6t7EfR4XA7Hk
         TpI45yesrEa3gu8m1JkfLpccQ++yTKooPrQI7ICJczhPomyo6HcEA5S2BmMEfXG26KX+
         Kbyn+4sLGhud7cjKH2c3Hb49OndhT7a7+cNMr/gAQDjI6n+Aqe/9wI4I3hzRY/jXkfEe
         jiaXCaHaiLyGjnnvY18YNAa8ksUKHtoovr0LRqEw/RWC5pgaGBfshzqsgL2V/Q8eKlb4
         w5cA==
X-Gm-Message-State: ACrzQf1VWX8ua80erNEzrlPLQUgiPho+8IjwsJWeacXA48gY348+0V24
        8AYuwjCU5QVubWmzUKcjrWI=
X-Google-Smtp-Source: AMsMyM4iLUS0RSVP1H5BnYMlYOPVhT4ceY7yBZLRrRGezOuM8PIp7Wi+vwJ7wGXX9sqTUu1LP6NSKQ==
X-Received: by 2002:a05:600c:3585:b0:3b4:a308:1581 with SMTP id p5-20020a05600c358500b003b4a3081581mr42475836wmq.77.1666586497358;
        Sun, 23 Oct 2022 21:41:37 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-197-18-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.18.197])
        by smtp.gmail.com with ESMTPSA id l39-20020a05600c1d2700b003c6deb5c1edsm9856925wms.45.2022.10.23.21.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 21:41:37 -0700 (PDT)
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
Subject: [PATCH v5 2/3] dt-bindings: clock: Add Ingenic JZ4755 CGU header
Date:   Mon, 24 Oct 2022 07:40:55 +0300
Message-Id: <20221024044057.4151633-3-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221024044057.4151633-1-lis8215@gmail.com>
References: <20221024044057.4151633-1-lis8215@gmail.com>
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

