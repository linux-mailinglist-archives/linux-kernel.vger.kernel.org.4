Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB568610182
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbiJ0TUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbiJ0TUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:20:37 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6452E5F7E8;
        Thu, 27 Oct 2022 12:20:36 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id b2so7504764eja.6;
        Thu, 27 Oct 2022 12:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wICd/6PuTpid08ZKJYuwFfQs4b4ZSUfrEfLUDuMq7r4=;
        b=c9Hpq5DN/DOwWiYXNjpgOAuJYKWCRuxzwS0BoRFvxbN8WY1BfVYHo4+k/o9DqgeClR
         w2FQp0nUjPlkWNnuXir78CF5AwG2h289wcBXQxcX55GfR3iEozi+tH8iBy96ywBBbdoo
         /JKz73N7ZjEhZZDVAqgH9VtBWuud4UjtIdOiwfKdCeNaS/o9l68q1wdPrJacA2NXBZPH
         q8v8UaR6qrAna8OckPwSvJY1TrQPqA3mY++jwPz9wI91Cm64fk/C1C6h8gPhH7arAmGg
         owcHddVsQUpRZa9p8SZ45x+FGQjAiEPWjwkRHdEq1WHVw0MmBEUxT86ZDbfPWnj54+wl
         JseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wICd/6PuTpid08ZKJYuwFfQs4b4ZSUfrEfLUDuMq7r4=;
        b=xQpwjQeUmkFWoFgrA/J0GakwnugL1su4muUNXPFT9wgABksnwXdDMPRomhVsSazs9e
         e8HP8jjHHgJBIiCvZTlkjq1h56ZG/aRvgtlQ1IMlsU+T80RoVuHvPsl0ka4jWMHnuRPh
         j29GGOM6+Usyi3L2adGpSgT2jH8iXUYVBgftMhBondLXXpL5yKMlhxa4cgenjFLdV6A+
         EcL2AJfQyZQH4PsQRVwIN6g5X9aKCouSw1CmPot+oN8dS0q5jsdJRAL7LMfDYAy/BA44
         9gcPMz+Mj/JFZbuKEpR8eaIWi4Lqs+J36PBSxUoEpH++tNqtbkLRgU5MIZWnJQd3Frt/
         Xr5g==
X-Gm-Message-State: ACrzQf2P/hvvFvR4UMVsuNE3IrHZGHORssKuRMKQlyIxxpADQXIY5X5M
        YF04Nil0jP4kPtzU+wsczBU=
X-Google-Smtp-Source: AMsMyM5gPDYck9Ry/GutIvil2hNm2f+io98EZmS1cwr63V0+8lZwyfzhDhpwv77EfspXVWz+R5CSqg==
X-Received: by 2002:a17:907:b16:b0:7ad:855b:c08c with SMTP id h22-20020a1709070b1600b007ad855bc08cmr6979494ejl.667.1666898435003;
        Thu, 27 Oct 2022 12:20:35 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-238-32-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.32.238])
        by smtp.gmail.com with ESMTPSA id w18-20020a1709067c9200b007acc5a42e77sm1187006ejo.88.2022.10.27.12.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 12:20:34 -0700 (PDT)
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
Subject: [PATCH v6 2/3] dt-bindings: clock: Add Ingenic JZ4755 CGU header
Date:   Thu, 27 Oct 2022 22:20:22 +0300
Message-Id: <20221027192024.484320-3-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221027192024.484320-1-lis8215@gmail.com>
References: <20221027192024.484320-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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

