Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB80F6BC875
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 09:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjCPIM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 04:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjCPIMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 04:12:16 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D674BB4226
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 01:11:59 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id ay18so624222pfb.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 01:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678954318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwV6VYDE9vSsyL4JSjL9Zar1d7X05582NjZ9783DM58=;
        b=xUcynJsZbG0BzmyW4csRCgP+aPDiFQDPHx6Daz4x32sU5LCMLzzx3fioFAS3qklPhI
         aXWGiL7AvCxyOqepazwG5S25Us1+gQU+mdOk4+Wbghk8U8jnA2Iw56f2lL386dco5xJS
         hhsuQtFWrYyF3HzZ3vVJgGQIrGRzptB3pG7dW6A7U+Nbxc4NdgTd/O4GCxnqOmO/4Egb
         c2slEpAii03dNfX0df5rboe7gLQwr2cBAS6zondvgJjva+mDw5W8wXX89lRiTjcSR3Kr
         sfBryG2xkMSaFHkNWPkVXObPF4GXU4wzl0Cjj2UZ5wS5AaREFCqYtm9guxR/kd6d0MJR
         TeKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678954318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FwV6VYDE9vSsyL4JSjL9Zar1d7X05582NjZ9783DM58=;
        b=sM2KMo5aDYheXCArnwr/JmBhrF1mGUnjZ4ncNq3HIXXMXL37r1XqL/2x+mNTasdCJ/
         xG8OJodGPcdSO5z6dPxNuWV/EW2CqRSgkoY//wxEd8Ck0e5TGyjf/kzeqlhSQHU8fsas
         yZFqTaJToAy46tdGZOFppH4UeDQ2RyCU0PgDwaxkYaCunABlP5XLRNHgZ4Je0iByHkPJ
         o1MLV/IQ+cOaclRDhzwChfslU9+Srxn9U9sXhEWo43Gp6HMjD1sHI2otUBRN7bBZ/4c9
         vWNYCwhCtA8lyvKpn45CQror0sXAOHwuDx55DshuzAic4aSlZvgY2xipjGcELH8K1ozt
         9W4Q==
X-Gm-Message-State: AO0yUKXDn9oyf1AVjQhMdekcLOKVFeeDxKk6GYjBjz494Ar3Bj7MUQBB
        +FYJWPnlTNfK4HIKErOSAAk2
X-Google-Smtp-Source: AK7set8qZiOu+nvavFsgD7DFR1hNW71SEhHs1WP3MWVr/ieiPUsa+UYLhvJuRr0C34dJiVzthxOlWw==
X-Received: by 2002:a62:3204:0:b0:623:f2d5:feb6 with SMTP id y4-20020a623204000000b00623f2d5feb6mr2128092pfy.20.1678954318655;
        Thu, 16 Mar 2023 01:11:58 -0700 (PDT)
Received: from localhost.localdomain ([117.207.30.24])
        by smtp.gmail.com with ESMTPSA id 13-20020aa7910d000000b005d9984a947bsm4804422pfh.139.2023.03.16.01.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 01:11:58 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 06/19] PCI: qcom: Use lower case for hex
Date:   Thu, 16 Mar 2023 13:41:04 +0530
Message-Id: <20230316081117.14288-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230316081117.14288-1-manivannan.sadhasivam@linaro.org>
References: <20230316081117.14288-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To maintain uniformity, let's use lower case for representing hexadecimal
numbers.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index f48990ac86dd..249033d1b248 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -39,17 +39,17 @@
 #define PARF_PCS_DEEMPH				0x34
 #define PARF_PCS_SWING				0x38
 #define PARF_PHY_CTRL				0x40
-#define PARF_PHY_REFCLK				0x4C
+#define PARF_PHY_REFCLK				0x4c
 #define PARF_CONFIG_BITS			0x50
 #define PARF_DBI_BASE_ADDR			0x168
-#define PARF_SLV_ADDR_SPACE_SIZE_2_3_3		0x16C /* Register offset specific to IP ver 2.3.3 */
+#define PARF_SLV_ADDR_SPACE_SIZE_2_3_3		0x16c /* Register offset specific to IP ver 2.3.3 */
 #define PARF_MHI_CLOCK_RESET_CTRL		0x174
 #define PARF_AXI_MSTR_WR_ADDR_HALT		0x178
-#define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1A8
-#define PARF_Q2A_FLUSH				0x1AC
-#define PARF_LTSSM				0x1B0
+#define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
+#define PARF_Q2A_FLUSH				0x1ac
+#define PARF_LTSSM				0x1b0
 #define PARF_SID_OFFSET				0x234
-#define PARF_BDF_TRANSLATE_CFG			0x24C
+#define PARF_BDF_TRANSLATE_CFG			0x24c
 #define PARF_SLV_ADDR_SPACE_SIZE		0x358
 #define PARF_DEVICE_TYPE			0x1000
 #define PARF_BDF_TO_SID_TABLE_N			0x2000
@@ -60,7 +60,7 @@
 /* DBI registers */
 #define AXI_MSTR_RESP_COMP_CTRL0		0x818
 #define AXI_MSTR_RESP_COMP_CTRL1		0x81c
-#define MISC_CONTROL_1_REG			0x8BC
+#define MISC_CONTROL_1_REG			0x8bc
 
 /* PARF_SYS_CTRL register fields */
 #define MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN	BIT(29)
-- 
2.25.1

