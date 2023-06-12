Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DE172BF17
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjFLKca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbjFLKcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:32:03 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9685B96
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:13:20 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f649db9b25so4760279e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686564728; x=1689156728;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w6oOHskvZpHQoGsginTih6QBOSYmBkE5Mrhb11FWZf8=;
        b=SCAq+m5FXg7+kU4PCnfN4lZrMCWwHNs8DmOks/vmxL7dcN+rkcLHIOcOhOlbzYtmvn
         5AP4lvLWB6z2YomchkNL7z7qSsIQxBIu0pVplRwXpAiee2fiLNOo++TpEewFYivk5vYg
         w3issjvTaEuD1dC8AJV1L7E+5yczCw528YE213/V3C8hLNwbM+0WruXXEAZ9M3t2FLj7
         J9miihImV14B7xiAKjwq/Zqum3s1d+Ojbpm31j7XcEY6KpG78JYrlaFJuAMvomlCpwJu
         rUJhSy2+QfV65VLd9kwCrrNn1yOYF8qCmk+JgXh5LRAK05po3hQT7jagFoKaMrjk9u1A
         zQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686564728; x=1689156728;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6oOHskvZpHQoGsginTih6QBOSYmBkE5Mrhb11FWZf8=;
        b=GIH/nKKdo8+y1FXyaCS5xeCJL9VnwQ8UCCSWyKYMMVAu9z8FaBBk9ibmwZ9wArS/O+
         RuGJBj+Snbkqbsc1rlpuH/ih8qJdCvBj7++QhC8b+S/9eGZOmmgzCHR0DHkRQkKTe4kl
         iA4NlcYqzR/pSB+mcrG2HEkSFnCWqQP6NYs6HYf+r9jckYZn6DNfoFLX/o1HgAkgYyEj
         sBWiCv5uv6jk/7rQN8ltfFyK+mgR1gomlSMb1Eu2xoEexdq5hNwEkmixhbTvahN5ZOot
         Hom2+hJegIVyAM/YChgpQ5p3J0SdlPW2U522ae3zy3mklZDDTIgl5tDGd6z79i/vynZB
         +1nA==
X-Gm-Message-State: AC+VfDwWXPu6lnRKvNGyaYY2X6N+NjirFZ403IxhTxU3oyVT8AVx0LAo
        DnLhM05iMeZJ3YSzUaUv3R7AI0TZSFhIgH1sR5ValA==
X-Google-Smtp-Source: ACHHUZ6DoFnZRVYKtyUJsx2YEj+47TFTaJWK8Kc9s3CQEvGiarLxK1d8tDtuMUXOC9fGD2fIm7PBzw==
X-Received: by 2002:a05:6512:521:b0:4f4:d071:be48 with SMTP id o1-20020a056512052100b004f4d071be48mr4794380lfc.14.1686563866315;
        Mon, 12 Jun 2023 02:57:46 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id f25-20020a7bcd19000000b003f7ff520a14sm10829525wmj.22.2023.06.12.02.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:57:45 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 12 Jun 2023 11:57:29 +0200
Subject: [PATCH v2 12/19] dt-bindings: clk: amlogic,a1-peripherals-clkc:
 expose all clock ids
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230607-topic-amlogic-upstream-clkid-public-migration-v2-12-38172d17c27a@linaro.org>
References: <20230607-topic-amlogic-upstream-clkid-public-migration-v2-0-38172d17c27a@linaro.org>
In-Reply-To: <20230607-topic-amlogic-upstream-clkid-public-migration-v2-0-38172d17c27a@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6566;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=UztVWvUWFGUUksXEP2qHwozkrUK7gyzliS7OjlRDluo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkhuwJXLqocVsZvSKTPXPMSuZmTKpKBo1rlqKh1MDK
 rWKDZROJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIbsCQAKCRB33NvayMhJ0StwD/
 4uJMXKbFQd58Mhu4CRgLitg2yuQEWGsiuV77G+NjiKLzf9iomailZDjh7C2Iyk2gA2tz0pUebZ6Y4L
 7m2wFj2BgNVIMpDQQeZmnyzEdOtne/t0wmudikE6+FqTOw+/oCuIggWia4kkyu2+iv72G1dWQf3e1j
 wRP9LtzkSo8CimoVSxyZICxhmXwSAut47o/OoPXVCUrgl/hzQy5Qng7RVqdJg3UqaXU6e6xqZZKHz5
 iujz6VLMpCFwfEdo4FFmJLqyLtl4DzBxjWTyOdeqt6+GUmJ+hrIYcgBbb8KVJkivv60oY0EvEQsTa6
 1lMKFAkfN/4uQGSfV0xMxU1Bda4IvudP9cXzc+VCHqYvf4fsdxgHGMyEQIY9LpzlNzjuZBdUENtGO1
 SUJOHyCbpT+85zCeyZ4M+8Xhm/82QC/bqeWR7Qwy1cQEoD396qvsjd5YzfpHsjQr1C4ozY9SVtJU9j
 IGvcSQxzYa1DeDtab8JLxcClZIVNouEoMdDKjTuokYWugzZguNSmvClNmNijTnxekdW35oPDSCgVYg
 N3MkMhbhpaFawhms6MV/bo0AX9NVP2hqxR7F3XXVt+9rXccqg/TPFXZTKzSG2kPpm6K8NHZAjDFeis
 l2UwRDoHAVes2dERFLh2A1VlRVXMrXE1xSZN6nQ9Ekn8cIxCOIMC6qygUvIw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to a policy change in clock ID bindings handling, expose
all the "private" clock IDs to the public clock dt-bindings
to move out of the previous maintenance scheme.

This refers to a discussion at [1] & [2] with Krzysztof about
the issue with the current maintenance.

It was decided to move every A1 peripherals ID to the public clock
dt-bindings headers to be merged in a single tree so we
can safely add new clocks without having merge issues.

[1] https://lore.kernel.org/all/c088e01c-0714-82be-8347-6140daf56640@linaro.org/
[2] https://lore.kernel.org/all/2fabe721-7434-43e7-bae5-088a42ba128d@app.fastmail.com/

Reviewed-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/meson/a1-peripherals.h                 | 63 ----------------------
 .../clock/amlogic,a1-peripherals-clkc.h            | 53 ++++++++++++++++++
 2 files changed, 53 insertions(+), 63 deletions(-)

diff --git a/drivers/clk/meson/a1-peripherals.h b/drivers/clk/meson/a1-peripherals.h
index 4d60456a95a9..842b52634ed0 100644
--- a/drivers/clk/meson/a1-peripherals.h
+++ b/drivers/clk/meson/a1-peripherals.h
@@ -46,67 +46,4 @@
 /* include the CLKIDs that have been made part of the DT binding */
 #include <dt-bindings/clock/amlogic,a1-peripherals-clkc.h>
 
-/*
- * CLKID index values for internal clocks
- *
- * These indices are entirely contrived and do not map onto the hardware.
- * It has now been decided to expose everything by default in the DT header:
- * include/dt-bindings/clock/a1-peripherals-clkc.h.
- * Only the clocks ids we don't want to expose, such as the internal muxes and
- * dividers of composite clocks, will remain defined here.
- */
-#define CLKID_XTAL_IN		0
-#define CLKID_DSPA_SEL		61
-#define CLKID_DSPB_SEL		62
-#define CLKID_SARADC_SEL	74
-#define CLKID_SYS_A_SEL		89
-#define CLKID_SYS_A_DIV		90
-#define CLKID_SYS_A		91
-#define CLKID_SYS_B_SEL		92
-#define CLKID_SYS_B_DIV		93
-#define CLKID_SYS_B		94
-#define CLKID_DSPA_A_DIV	96
-#define CLKID_DSPA_A		97
-#define CLKID_DSPA_B_DIV	99
-#define CLKID_DSPA_B		100
-#define CLKID_DSPB_A_DIV	102
-#define CLKID_DSPB_A		103
-#define CLKID_DSPB_B_DIV	105
-#define CLKID_DSPB_B		106
-#define CLKID_RTC_32K_IN	107
-#define CLKID_RTC_32K_DIV	108
-#define CLKID_RTC_32K_XTAL	109
-#define CLKID_RTC_32K_SEL	110
-#define CLKID_CECB_32K_IN	111
-#define CLKID_CECB_32K_DIV	112
-#define CLKID_CECA_32K_IN	115
-#define CLKID_CECA_32K_DIV	116
-#define CLKID_DIV2_PRE		119
-#define CLKID_24M_DIV2		120
-#define CLKID_GEN_DIV		122
-#define CLKID_SARADC_DIV	123
-#define CLKID_PWM_A_DIV		125
-#define CLKID_PWM_B_DIV		127
-#define CLKID_PWM_C_DIV		129
-#define CLKID_PWM_D_DIV		131
-#define CLKID_PWM_E_DIV		133
-#define CLKID_PWM_F_DIV		135
-#define CLKID_SPICC_SEL		136
-#define CLKID_SPICC_DIV		137
-#define CLKID_SPICC_SEL2	138
-#define CLKID_TS_DIV		139
-#define CLKID_SPIFC_SEL		140
-#define CLKID_SPIFC_DIV		141
-#define CLKID_SPIFC_SEL2	142
-#define CLKID_USB_BUS_SEL	143
-#define CLKID_USB_BUS_DIV	144
-#define CLKID_SD_EMMC_SEL	145
-#define CLKID_SD_EMMC_DIV	146
-#define CLKID_PSRAM_SEL		148
-#define CLKID_PSRAM_DIV		149
-#define CLKID_PSRAM_SEL2	150
-#define CLKID_DMC_SEL		151
-#define CLKID_DMC_DIV		152
-#define CLKID_DMC_SEL2		153
-
 #endif /* __A1_PERIPHERALS_H */
diff --git a/include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h b/include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h
index ff2730f398a6..06f198ee7623 100644
--- a/include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h
+++ b/include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h
@@ -10,6 +10,7 @@
 #ifndef __A1_PERIPHERALS_CLKC_H
 #define __A1_PERIPHERALS_CLKC_H
 
+#define CLKID_XTAL_IN		0
 #define CLKID_FIXPLL_IN		1
 #define CLKID_USB_PHY_IN	2
 #define CLKID_USB_CTRL_IN	3
@@ -70,6 +71,8 @@
 #define CLKID_CPU_CTRL		58
 #define CLKID_ROM		59
 #define CLKID_PROC_I2C		60
+#define CLKID_DSPA_SEL		61
+#define CLKID_DSPB_SEL		62
 #define CLKID_DSPA_EN		63
 #define CLKID_DSPA_EN_NIC	64
 #define CLKID_DSPB_EN		65
@@ -81,6 +84,7 @@
 #define CLKID_12M		71
 #define CLKID_FCLK_DIV2_DIVN	72
 #define CLKID_GEN		73
+#define CLKID_SARADC_SEL	74
 #define CLKID_SARADC		75
 #define CLKID_PWM_A		76
 #define CLKID_PWM_B		77
@@ -95,21 +99,70 @@
 #define CLKID_SD_EMMC		86
 #define CLKID_PSRAM		87
 #define CLKID_DMC		88
+#define CLKID_SYS_A_SEL		89
+#define CLKID_SYS_A_DIV		90
+#define CLKID_SYS_A		91
+#define CLKID_SYS_B_SEL		92
+#define CLKID_SYS_B_DIV		93
+#define CLKID_SYS_B		94
 #define CLKID_DSPA_A_SEL	95
+#define CLKID_DSPA_A_DIV	96
+#define CLKID_DSPA_A		97
 #define CLKID_DSPA_B_SEL	98
+#define CLKID_DSPA_B_DIV	99
+#define CLKID_DSPA_B		100
 #define CLKID_DSPB_A_SEL	101
+#define CLKID_DSPB_A_DIV	102
+#define CLKID_DSPB_A		103
 #define CLKID_DSPB_B_SEL	104
+#define CLKID_DSPB_B_DIV	105
+#define CLKID_DSPB_B		106
+#define CLKID_RTC_32K_IN	107
+#define CLKID_RTC_32K_DIV	108
+#define CLKID_RTC_32K_XTAL	109
+#define CLKID_RTC_32K_SEL	110
+#define CLKID_CECB_32K_IN	111
+#define CLKID_CECB_32K_DIV	112
 #define CLKID_CECB_32K_SEL_PRE	113
 #define CLKID_CECB_32K_SEL	114
+#define CLKID_CECA_32K_IN	115
+#define CLKID_CECA_32K_DIV	116
 #define CLKID_CECA_32K_SEL_PRE	117
 #define CLKID_CECA_32K_SEL	118
+#define CLKID_DIV2_PRE		119
+#define CLKID_24M_DIV2		120
 #define CLKID_GEN_SEL		121
+#define CLKID_GEN_DIV		122
+#define CLKID_SARADC_DIV	123
 #define CLKID_PWM_A_SEL		124
+#define CLKID_PWM_A_DIV		125
 #define CLKID_PWM_B_SEL		126
+#define CLKID_PWM_B_DIV		127
 #define CLKID_PWM_C_SEL		128
+#define CLKID_PWM_C_DIV		129
 #define CLKID_PWM_D_SEL		130
+#define CLKID_PWM_D_DIV		131
 #define CLKID_PWM_E_SEL		132
+#define CLKID_PWM_E_DIV		133
 #define CLKID_PWM_F_SEL		134
+#define CLKID_PWM_F_DIV		135
+#define CLKID_SPICC_SEL		136
+#define CLKID_SPICC_DIV		137
+#define CLKID_SPICC_SEL2	138
+#define CLKID_TS_DIV		139
+#define CLKID_SPIFC_SEL		140
+#define CLKID_SPIFC_DIV		141
+#define CLKID_SPIFC_SEL2	142
+#define CLKID_USB_BUS_SEL	143
+#define CLKID_USB_BUS_DIV	144
+#define CLKID_SD_EMMC_SEL	145
+#define CLKID_SD_EMMC_DIV	146
 #define CLKID_SD_EMMC_SEL2	147
+#define CLKID_PSRAM_SEL		148
+#define CLKID_PSRAM_DIV		149
+#define CLKID_PSRAM_SEL2	150
+#define CLKID_DMC_SEL		151
+#define CLKID_DMC_DIV		152
+#define CLKID_DMC_SEL2		153
 
 #endif /* __A1_PERIPHERALS_CLKC_H */

-- 
2.34.1

