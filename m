Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225656BA93C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjCOHbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjCOHaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:30:20 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E91C6BDF0;
        Wed, 15 Mar 2023 00:29:23 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso2850175pjc.1;
        Wed, 15 Mar 2023 00:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678865361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uvJs4X+K4UceXd2k+66/c3dGn+ev++3qcWkPqYJYAw=;
        b=gFr8KSmeoyAXQVW91BqTPyiRcKvFeSgkJMQvcGjpyHXPzfdPdmLJlL1rcre0rw6D1g
         uqsvxNyaZBmiAZFWZTXld/nJi9zvyS6NHMFZlfpvxnTAqucEi0/Fsx4drdw5NiY9V3+n
         jltvMfj32asvhVXklq94kgXCdcunAEvDMGMiU/j/Um9s9xBlp91VuGrhSrkWWWVZuh1L
         O3USOkDjKjwbGiWE6WqAuKDV1/4NpIQZVGklGVmAv1gFVqD0VT5vKQL6Xv7JodaZz5V6
         BWWm78s6PYqc8PU1NJ4cx5TdLEyFVao1LoKH5W0WIwk8i0wqJvgxTHdkOecI6hQJh1ow
         0cCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678865361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uvJs4X+K4UceXd2k+66/c3dGn+ev++3qcWkPqYJYAw=;
        b=aP8FIgKFMls6nMG5N1I+7qVCQrdrxFirTrLCpWnmxpWiqCP/ypJfwfvgO8M38UoRNn
         RwDcz/G8Xo6VErxFtGTWTNuQ+yKyA/HargTb2qdXbNhpzV0toBSfjjHfNPiUHJ0TG7Ur
         wY6em9TBmH1XkH/iWst7hzV9fgpiSC6yd+9noUPn1xMM5eS5m8aVChtqdCwzxxlN52vZ
         rjTQjMyBViKc5g33lbE+o22lZl2TNqsikjP7T7ufzmhhrmE6rIQj8fG4VnXMEeiNEPsb
         jyv6O2DFHSXjrUSUXA9NSG4z38SIMPEj1VEew+2q1WS6aTqZngdKDQJiJGihFe8W2VH+
         lkHw==
X-Gm-Message-State: AO0yUKUvN4KWyG8klBO0kkTWmSDpVnF+Hsr39JaDpQFrqLTZGf9b9s9V
        ZoKDIgxQD6lT5Exb7c/FD3I=
X-Google-Smtp-Source: AK7set/C1XOvKQHPg2+bUHWOgVhYILaB0LmAjbIsQNd0NE4qUrZGCifoXNzKbIeSuYPVAkm/OgJtnQ==
X-Received: by 2002:a17:902:dac8:b0:1a0:763f:2445 with SMTP id q8-20020a170902dac800b001a0763f2445mr2031537plx.11.1678865361305;
        Wed, 15 Mar 2023 00:29:21 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id kz11-20020a170902f9cb00b001a0667822c8sm2740003plb.94.2023.03.15.00.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 00:29:21 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH 05/15] dt-bindings: reset: nuvoton: add binding for ma35d1 IP reset control
Date:   Wed, 15 Mar 2023 07:28:52 +0000
Message-Id: <20230315072902.9298-6-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230315072902.9298-1-ychuang570808@gmail.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

Add the dt-bindings header for Nuvoton ma35d1, that gets shared
between the reset controller and reset references in the dts.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 .../dt-bindings/reset/nuvoton,ma35d1-reset.h  | 108 ++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 include/dt-bindings/reset/nuvoton,ma35d1-reset.h

diff --git a/include/dt-bindings/reset/nuvoton,ma35d1-reset.h b/include/dt-bindings/reset/nuvoton,ma35d1-reset.h
new file mode 100644
index 000000000000..6d0791b04d52
--- /dev/null
+++ b/include/dt-bindings/reset/nuvoton,ma35d1-reset.h
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Nuvoton Technologies.
+ * Author: Chi-Fen Li <cfli0@nuvoton.com>
+ *
+ * Device Tree binding constants for MA35D1 reset controller.
+ */
+
+#ifndef __DT_BINDINGS_RESET_MA35D1_H
+#define __DT_BINDINGS_RESET_MA35D1_H
+
+#define MA35D1_RESET_CHIP	0
+#define MA35D1_RESET_CA35CR0	1
+#define MA35D1_RESET_CA35CR1	2
+#define MA35D1_RESET_CM4	3
+#define MA35D1_RESET_PDMA0	4
+#define MA35D1_RESET_PDMA1	5
+#define MA35D1_RESET_PDMA2	6
+#define MA35D1_RESET_PDMA3	7
+#define MA35D1_RESET_DISP	9
+#define MA35D1_RESET_VCAP0	10
+#define MA35D1_RESET_VCAP1	11
+#define MA35D1_RESET_GFX	12
+#define MA35D1_RESET_VDEC	13
+#define MA35D1_RESET_WHC0	14
+#define MA35D1_RESET_WHC1	15
+#define MA35D1_RESET_GMAC0	16
+#define MA35D1_RESET_GMAC1	17
+#define MA35D1_RESET_HWSEM	18
+#define MA35D1_RESET_EBI	19
+#define MA35D1_RESET_HSUSBH0	20
+#define MA35D1_RESET_HSUSBH1	21
+#define MA35D1_RESET_HSUSBD	22
+#define MA35D1_RESET_USBHL	23
+#define MA35D1_RESET_SDH0	24
+#define MA35D1_RESET_SDH1	25
+#define MA35D1_RESET_NAND	26
+#define MA35D1_RESET_GPIO	27
+#define MA35D1_RESET_MCTLP	28
+#define MA35D1_RESET_MCTLC	29
+#define MA35D1_RESET_DDRPUB	30
+#define MA35D1_RESET_TMR0	34
+#define MA35D1_RESET_TMR1	35
+#define MA35D1_RESET_TMR2	36
+#define MA35D1_RESET_TMR3	37
+#define MA35D1_RESET_I2C0	40
+#define MA35D1_RESET_I2C1	41
+#define MA35D1_RESET_I2C2	42
+#define MA35D1_RESET_I2C3	43
+#define MA35D1_RESET_QSPI0	44
+#define MA35D1_RESET_SPI0	45
+#define MA35D1_RESET_SPI1	46
+#define MA35D1_RESET_SPI2	47
+#define MA35D1_RESET_UART0	48
+#define MA35D1_RESET_UART1	49
+#define MA35D1_RESET_UART2	50
+#define MA35D1_RESET_UAER3	51
+#define MA35D1_RESET_UART4	52
+#define MA35D1_RESET_UART5	53
+#define MA35D1_RESET_UART6	54
+#define MA35D1_RESET_UART7	55
+#define MA35D1_RESET_CANFD0	56
+#define MA35D1_RESET_CANFD1	57
+#define MA35D1_RESET_EADC0	60
+#define MA35D1_RESET_I2S0	61
+#define MA35D1_RESET_SC0	64
+#define MA35D1_RESET_SC1	65
+#define MA35D1_RESET_QSPI1	68
+#define MA35D1_RESET_SPI3	70
+#define MA35D1_RESET_EPWM0	80
+#define MA35D1_RESET_EPWM1	81
+#define MA35D1_RESET_QEI0	86
+#define MA35D1_RESET_QEI1	87
+#define MA35D1_RESET_ECAP0	90
+#define MA35D1_RESET_ECAP1	91
+#define MA35D1_RESET_CANFD2	92
+#define MA35D1_RESET_ADC0	95
+#define MA35D1_RESET_TMR4	96
+#define MA35D1_RESET_TMR5	97
+#define MA35D1_RESET_TMR6	98
+#define MA35D1_RESET_TMR7	99
+#define MA35D1_RESET_TMR8	100
+#define MA35D1_RESET_TMR9	101
+#define MA35D1_RESET_TMR10	102
+#define MA35D1_RESET_TMR11	103
+#define MA35D1_RESET_UART8	104
+#define MA35D1_RESET_UART9	105
+#define MA35D1_RESET_UART10	106
+#define MA35D1_RESET_UART11	107
+#define MA35D1_RESET_UART12	108
+#define MA35D1_RESET_UART13	109
+#define MA35D1_RESET_UART14	110
+#define MA35D1_RESET_UART15	111
+#define MA35D1_RESET_UART16	112
+#define MA35D1_RESET_I2S1	113
+#define MA35D1_RESET_I2C4	114
+#define MA35D1_RESET_I2C5	115
+#define MA35D1_RESET_EPWM2	116
+#define MA35D1_RESET_ECAP2	117
+#define MA35D1_RESET_QEI2	118
+#define MA35D1_RESET_CANFD3	119
+#define MA35D1_RESET_KPI	120
+#define MA35D1_RESET_GIC	124
+#define MA35D1_RESET_SSMCC	126
+#define MA35D1_RESET_SSPCC	127
+#define MA35D1_RESET_COUNT	128
+
+#endif
-- 
2.34.1

