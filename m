Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A726BA933
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjCOHa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjCOHaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:30:12 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72616E690;
        Wed, 15 Mar 2023 00:29:17 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so962344pjp.2;
        Wed, 15 Mar 2023 00:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678865356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kl1DmN2IDzWs6eE+G64vJDwMqsz/I4iopBdZT5NNSQk=;
        b=k9G2DOVgQ6pm6s12Sc1/HZa8/62vAaV6qqudCSXDRREVCyfMc39C3P26gZ0Nwu58+Y
         7f2OzgOcs5PBcGbnvLxEi6k/EpK2JySxCKu/cC6Xs5eQhTMDUdqZoO8VWUIIkm17/Hec
         /+UEGOstnJM4TMbhgO3FoVhKKIiyWLA8l9jpYuC8tIzJb6eNsb6H5pO4QSnTi69PTKbq
         UEmVqxjThbTB1iG4V+lm4YdVPx6f+1wA4Hz5io6tAM/kYO5pl5dx7ZY7Fh+sX7/h0AI5
         TnVeXm9TSPdrlnd1TgIzpGz+SpH47XCoitUX4aZad0XxIr51aSXuBEgDoq0sDhUJy6Xq
         Tn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678865356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kl1DmN2IDzWs6eE+G64vJDwMqsz/I4iopBdZT5NNSQk=;
        b=5MyU9HzcSwb4uglsvEF1KX79qc5prvhDPfaLpSnJrFwxRkOufb6PKHr281PkxAv2QZ
         ZSMUcGNE7raeF5KGLiPs/hbIIlPwIowvzmijuWj66LeHy2hXzc36Sy1WZD89oVnNLeqt
         Qx/SoId8cPxyaVmhEqofmqQDTfiE21RjAZX6qainoeBGGolmAEZlolzVDKBdg53wRdZw
         LhAi0TU1hswV3evIsPRmoAaotYRXMgu9haZ3zksAyQPLxrCqrYf2KpQHIPha8nCRQ8Zp
         TBe87RTNcVmZErLHwvBp5iOBB/jRJ42RQAcTZCMmTRZt0VcDJ6/+NVkh+SwylG+NPVNz
         BjNA==
X-Gm-Message-State: AO0yUKWvHoznhteQRnjfg01nZt/Rvq/g8gdAla5LPXi/yl4p0YG2zu6i
        hkBYKfGAx7kA+A1GOZkSgMg=
X-Google-Smtp-Source: AK7set+N2OdtBNiqA1cKw3xxFr3aoK82s/uM1P8fD/ClXlB4B5hYwjCJO2ilP8o7HFBr+3w1L63yIw==
X-Received: by 2002:a17:902:c60a:b0:19c:be09:20d5 with SMTP id r10-20020a170902c60a00b0019cbe0920d5mr1565510plr.11.1678865356329;
        Wed, 15 Mar 2023 00:29:16 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id kz11-20020a170902f9cb00b001a0667822c8sm2740003plb.94.2023.03.15.00.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 00:29:16 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH 03/15] mfd: Add the header file of Nuvoton ma35d1 system manager
Date:   Wed, 15 Mar 2023 07:28:50 +0000
Message-Id: <20230315072902.9298-4-ychuang570808@gmail.com>
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

The system manager is a set of registers used for power control,
multi-function pin control, USB phy control, IP reset, and other
miscellaneous controls. It also contains some registers that
provide SoC information and status.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 include/linux/mfd/ma35d1-sys.h | 95 ++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 include/linux/mfd/ma35d1-sys.h

diff --git a/include/linux/mfd/ma35d1-sys.h b/include/linux/mfd/ma35d1-sys.h
new file mode 100644
index 000000000000..dcd85231125d
--- /dev/null
+++ b/include/linux/mfd/ma35d1-sys.h
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Nuvoton Technologies.
+ * Author: Chi-Fen Li <cfli0@nuvoton.com>
+ *
+ * System management control registers of MA35D1 SoC
+ */
+#ifndef __LINUX_MFD_MA35D1_SYS_H
+#define __LINUX_MFD_MA35D1_SYS_H
+
+#define REG_SYS_PDID		(0x000) /* Product and Device Identifier */
+#define REG_SYS_PWRONOTP	(0x004) /* Power-on Setting OTP Source */
+#define REG_SYS_PWRONPIN	(0x008) /* Power-on Setting Pin Source */
+#define REG_SYS_RSTSTS		(0x010) /* Reset Source Active Status */
+#define REG_SYS_MISCRFCR	(0x014) /* Miscellaneous Reset Function */
+#define REG_SYS_RSTDEBCTL	(0x018) /* Reset Pin De-bounce Control */
+#define REG_SYS_LVRDCR		(0x01C) /* Low Voltage Reset & Detect */
+#define REG_SYS_IPRST0		(0x020) /* Reset Control Register 0 */
+#define REG_SYS_IPRST1		(0x024) /* Reset Control Register 1 */
+#define REG_SYS_IPRST2		(0x028) /* Reset Control Register 2 */
+#define REG_SYS_IPRST3		(0x02C) /* Reset Control Register 3 */
+#define REG_SYS_PMUCR		(0x030) /* Power Management Unit Control */
+#define REG_SYS_DDRCQCSR	(0x034) /* DDR Q Channel Control and Status */
+#define REG_SYS_PMUIEN		(0x038) /* PMU Interrupt Enable */
+#define REG_SYS_PMUSTS		(0x03C) /* PMU Status */
+#define REG_SYS_CA35WRBADR1	(0x040) /* A35 Core 1 Warm-boot Address */
+#define REG_SYS_CA35WRBPAR1	(0x044) /* A35 Core 1 Warm-boot Parameter */
+#define REG_SYS_CA35WRBADR2	(0x048) /* A35 Core 2 Warm-boot Address */
+#define REG_SYS_CA35WRBPAR2	(0x04C) /* A35 Core 2 Warm-boot Parameter */
+#define REG_SYS_USBPMISCR	(0x060) /* USB PHY Miscellaneous Control */
+#define REG_SYS_USBP0PCR	(0x064) /* USB Port 0 PHY Control */
+#define REG_SYS_USBP1PCR	(0x068) /* USB Port 1 PHY Control */
+#define REG_SYS_MISCFCR0	(0x070) /* Miscellaneous Function Control 0 */
+#define REG_SYS_MISCFCR1	(0x074) /* Miscellaneous Function Control 1 */
+#define REG_SYS_MISCIER		(0x078) /* Miscellaneous Interrupt Enable */
+#define REG_SYS_MISCISR		(0x07C) /* Miscellaneous Interrupt Status */
+#define REG_SYS_GPA_MFPL	(0x080) /* GPIOA Multi-Function Control LSB */
+#define REG_SYS_GPA_MFPH	(0x084) /* GPIOA Multi-Function Control MSB */
+#define REG_SYS_GPB_MFPL	(0x088) /* GPIOB Multi-Function Control LSB */
+#define REG_SYS_GPB_MFPH	(0x08C) /* GPIOB Multi-Function Control MSB */
+#define REG_SYS_GPC_MFPL	(0x090) /* GPIOC Multi-Function Control LSB */
+#define REG_SYS_GPC_MFPH	(0x094) /* GPIOC Multi-Function Control MSB */
+#define REG_SYS_GPD_MFPL	(0x098) /* GPIOD Multi-Function Control LSB */
+#define REG_SYS_GPD_MFPH	(0x09C) /* GPIOD Multi-Function Control MSB */
+#define REG_SYS_GPE_MFPL	(0x0A0) /* GPIOE Multi-Function Control LSB */
+#define REG_SYS_GPE_MFPH	(0x0A4) /* GPIOE Multi-Function Control MSB */
+#define REG_SYS_GPF_MFPL	(0x0A8) /* GPIOF Multi-Function Control LSB */
+#define REG_SYS_GPF_MFPH	(0x0AC) /* GPIOF Multi-Function Control MSB */
+#define REG_SYS_GPG_MFPL	(0x0B0) /* GPIOG Multi-Function Control LSB */
+#define REG_SYS_GPG_MFPH	(0x0B4) /* GPIOG Multi-Function Control MSB */
+#define REG_SYS_GPH_MFPL	(0x0B8) /* GPIOH Multi-Function Control LSB */
+#define REG_SYS_GPH_MFPH	(0x0BC) /* GPIOH Multi-Function Control MSB */
+#define REG_SYS_GPI_MFPL	(0x0C0) /* GPIOI Multi-Function Control LSB */
+#define REG_SYS_GPI_MFPH	(0x0C4) /* GPIOI Multi-Function Control MSB */
+#define REG_SYS_GPJ_MFPL	(0x0C8) /* GPIOJ Multi-Function Control LSB */
+#define REG_SYS_GPJ_MFPH	(0x0CC) /* GPIOJ Multi-Function Control MSB */
+#define REG_SYS_GPK_MFPL	(0x0D0) /* GPIOK Multi-Function Control LSB */
+#define REG_SYS_GPK_MFPH	(0x0D4) /* GPIOK Multi-Function Control MSB */
+#define REG_SYS_GPL_MFPL	(0x0D8) /* GPIOL Multi-Function Control LSB */
+#define REG_SYS_GPL_MFPH	(0x0DC) /* GPIOL Multi-Function Control MSB */
+#define REG_SYS_GPM_MFPL	(0x0E0) /* GPIOM Multi-Function Control LSB */
+#define REG_SYS_GPM_MFPH	(0x0E4) /* GPIOM Multi-Function Control MSB */
+#define REG_SYS_GPN_MFPL	(0x0E8) /* GPION Multi-Function Control LSB */
+#define REG_SYS_GPN_MFPH	(0x0EC) /* GPION Multi-Function Control MSB */
+#define REG_SYS_HIRCFTRIM	(0x100) /* HIRC Frequency Trim Value */
+#define REG_SYS_TSENSRFCR	(0x104) /* Temperature Sensor Control */
+#define REG_SYS_GMAC0MISCR	(0x108) /* GMAC 0 Miscellaneous Control */
+#define REG_SYS_GMAC1MISCR	(0x10C) /* GMAC 1 Miscellaneous Control */
+#define REG_SYS_MACAD0LSR	(0x110) /* MAC Address 0 LSW */
+#define REG_SYS_MACAD0HSR	(0x114) /* MAC Address 0 HSW */
+#define REG_SYS_MACAD1LSR	(0x118) /* MAC Address 1 LSW */
+#define REG_SYS_MACAD1HSR	(0x11C) /* MAC Address 1 HSW */
+#define REG_SYS_CSDBGCTL	(0x120) /* CoreSight Debug Control */
+#define REG_SYS_GPAB_MFOS	(0x140) /* GPIOA/B Output Mode Select */
+#define REG_SYS_GPCD_MFOS	(0x144) /* GPIOC/D Output Mode Select */
+#define REG_SYS_GPEF_MFOS	(0x148) /* GPIOE/F Output Mode Select */
+#define REG_SYS_GPGH_MFOS	(0x14C) /* GPIOG/H Output Mode Select */
+#define REG_SYS_GPIJ_MFOS	(0x150) /* GPIOI/J Output Mode Select */
+#define REG_SYS_GPKL_MFOS	(0x154) /* GPIOK/L Output Mode Select */
+#define REG_SYS_GPMN_MFOS	(0x158) /* GPIOM/N Output Mode Select */
+#define REG_SYS_UID0		(0x180) /* Unique Identifier Word 0 */
+#define REG_SYS_UID1		(0x184) /* Unique Identifier Word 1 */
+#define REG_SYS_UID2		(0x188) /* Unique Identifier Word 2 */
+#define REG_SYS_UCID0		(0x190) /* Unique Customer Identifier 0 */
+#define REG_SYS_UCID1		(0x194) /* Unique Customer Identifier 1 */
+#define REG_SYS_UCID2		(0x198) /* Unique Customer Identifier 2 */
+#define REG_SYS_RLKTZS		(0x1A0) /* TZS Register Lock Control */
+#define REG_SYS_RLKTZNS		(0x1A4) /* TZNS Register Lock Control */
+#define REG_SYS_RLKSUBM		(0x1A8) /* SubM Register Lock Control */
+#define REG_SYS_DPLPASWD	(0x1B0) /* Deployed Password */
+
+void ma35d1_reg_lock(void);
+void ma35d1_reg_unlock(void);
+
+#endif /* __LINUX_MFD_MA35D1_SYS_H */
-- 
2.34.1

