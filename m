Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4520A600056
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 17:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiJPPDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 11:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiJPPDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 11:03:18 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9A240E17;
        Sun, 16 Oct 2022 08:03:15 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id a13so12893688edj.0;
        Sun, 16 Oct 2022 08:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9Wg20rVnZ4v1joif76gIBjpt9SJeqrGz8H44eRdP3w=;
        b=A50Ffwth+rxwdeutEc8TDJvPwet06ye0MWIH/xcNVzsp5XM4majii9YrtKd5oiGkAF
         EoUP+3h0gDD3IAoB8OFtAyok0J/2UlMUF2idahWkAa9r2tVg+Eb7noyiSrAOeTRDtDe2
         QpErXUwTsy4zEFb64wQyRp1pjjVcIufnwZ7CMlYPKQABAYtLMjcOZMzopFw0/y0cGPti
         F2NLNyboq5gnup6y7VK1zWPcH1DstXaMevdg/RMabnGCkMtvU+SKO+l1vyEGsv0v0mHv
         diVoWKA3ZDpyg1tcv1I6ORVal8CWAnnsUM80VXq9zAos/86dZmiAoB0fb2s3WK491uZU
         Mv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9Wg20rVnZ4v1joif76gIBjpt9SJeqrGz8H44eRdP3w=;
        b=UTvC7RIsjpimmdUcyNbjbS6QNowzT00KD/nQSDAbOdsz6TlnAYqysrJ7XF+zSuD4BP
         iOLLd4VK7O2D+3SFLPLBytPDWet5wfErcQr7ZLsH+2AFqvp3VnSFtdTUUckffr3Ey7zI
         SE80evcuWbCvTgnDlOidKabsxyY9we8Gh/W6ib3+2EFC2yCto1HWZUEpsGwPrVzThMvV
         ONWesIUswU5lH7EXniZuhk+nlMYgG5R0s/EZaWgG556CBaQsKQGFU5qtq49roJB4jxZr
         LnwyMdFPKmKX5zCbvfJ2oQxNW23XuSVbfsbatVT0yKXRAOYe3j4PJ0mcnk+8cPz6TDxP
         h80g==
X-Gm-Message-State: ACrzQf2Bp1X10T+leVDOGGaSUi2BRBn3vnMMJjRrSiUlN+4HdRkQihxn
        EyCWXnQDtj1d0474tyFPdk8=
X-Google-Smtp-Source: AMsMyM6HOhUcf00Igkv0lWYtgsZdw9ZCMSqcer8E0tPJm4/gRRmRWlET+DRSDTRn/FDg2WZ3jNlFiw==
X-Received: by 2002:aa7:c78d:0:b0:454:fe1d:8eb1 with SMTP id n13-20020aa7c78d000000b00454fe1d8eb1mr6415212eds.59.1665932593668;
        Sun, 16 Oct 2022 08:03:13 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-39-7-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.7.39])
        by smtp.gmail.com with ESMTPSA id u8-20020a17090657c800b0078c1e174e11sm4645699ejr.136.2022.10.16.08.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 08:03:13 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v2 3/4] dt-bindings: clock: Add Ingenic JZ4755 CGU header
Date:   Sun, 16 Oct 2022 18:01:08 +0300
Message-Id: <20221016150110.3020451-4-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221016150110.3020451-1-lis8215@gmail.com>
References: <20221016150110.3020451-1-lis8215@gmail.com>
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
index 000000000..1ac13d61b
--- /dev/null
+++ b/include/dt-bindings/clock/ingenic,jz4755-cgu.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause) */
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

