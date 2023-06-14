Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3D07306B3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbjFNSFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbjFNSEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:04:43 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B5D211F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:04:41 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f769c37d26so1144256e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686765880; x=1689357880;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=43WXKM//3PGv9o6RwF8pM2BvmgRQSkW/hfnQEDsAZP4=;
        b=xgMycTOmhiQ/2m7TIIgWdHMJMNT6nwXASYOwGIBmY3O+EBu2V/l6wWtYWsUErNENV9
         iVQXXp51xeh2Mq2jOoRQXiatgE78/MJ4kKO02d9OQYVYzSKIN1Wu9Mwaq7e0cVnZH2CR
         xEh887MgslQg2UtO4KVXaYIgypRGdLZ70ADwmVT7kr/GDlT4gMPF5tQ1MNitBCcIS4Jt
         6+ElzeVGpm6eUpDucD6AoXtM3R1SC+ROUA4CfzcbmvRwxUAcOxvEE/dhAkQeSQzePMF6
         JLFRvrs4riLX7Dq4SrQgnPQF7+cnWRhib8tsmLgZmHBbveEpb5jlcIlMBxgv/G3XT4K5
         3mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686765880; x=1689357880;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43WXKM//3PGv9o6RwF8pM2BvmgRQSkW/hfnQEDsAZP4=;
        b=COMjfRRTx23OcNMQo5ankLY52RfQGYid0zztm/gTh3fl1HMdJduzLbJ5XHKGu6EIr8
         GLCivAV3ln/W6Tcxjyuhxxx6wOvcMbFCbNOEtXNLEK449cUvx8w41/pkJMfR5qWiA42U
         S6xLeEmRHAZinLT1e7tTzXOLLri0H1aRhmRh9QMqtXdEAOWUhvtefnMrXQOU1hCB9hH3
         m8hO9cu2G87BBBK4oVzXHBm83QWnF3bKw9KWnhNvUfuSA539RE4AofOnYdaXFFG/5fc5
         YyLcWlHX0SJmsfZAXKEDyBzHL2lr0sxo9edR9RxqG/u896b8Wn7ewZpa+2LBlbKAaV2X
         z+LA==
X-Gm-Message-State: AC+VfDy3G5HGtOxr4Hve7U5/Qcw3BvOhKnLtdLAiEtLJLUtAmmkZ2+/N
        55pn4BvlZH+WqMNDJRMbtEwjOA==
X-Google-Smtp-Source: ACHHUZ4l0jx/W72hBObZKWI7wAyuQfn4uM7K0aD6CvBAVErzvamUHbZ/nU62ivSngJIx0XUd3qVKDQ==
X-Received: by 2002:a19:920a:0:b0:4f4:b806:4b5f with SMTP id u10-20020a19920a000000b004f4b8064b5fmr8074574lfd.57.1686765880116;
        Wed, 14 Jun 2023 11:04:40 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id l18-20020a19c212000000b004eff1f7f206sm2224053lfc.9.2023.06.14.11.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 11:04:39 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 14 Jun 2023 20:04:23 +0200
Subject: [PATCH v6 04/22] clk: qcom: smd-rpm: Move some RPM resources to
 the common header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v6-4-263283111e66@linaro.org>
References: <20230526-topic-smd_icc-v6-0-263283111e66@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v6-0-263283111e66@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686765872; l=2480;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=htdvXfCYU07v6+YNPv56ef+1cDlrbXu+3LbOKbiWsm8=;
 b=iKXknn+N3Ds8jmRkYZstXu2eya+oOrgy7E4hjgC4X+xu1O9ma1WFiu8WBeSN2dCyVjuZ9gTkh
 bPy7/Bn0s2kAH2eix3LPZxTCLN4yO5RtG9va1hw3Xp7zI/AIxaISk+u
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for handling the bus clocks in the icc driver, carve out
some defines and a struct definition to the common rpm header.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/clk-smd-rpm.c   | 13 -------------
 include/linux/soc/qcom/smd-rpm.h | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index e4de74b68797..937cb1515968 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -18,13 +18,6 @@
 
 #include <dt-bindings/clock/qcom,rpmcc.h>
 
-#define QCOM_RPM_KEY_SOFTWARE_ENABLE			0x6e657773
-#define QCOM_RPM_KEY_PIN_CTRL_CLK_BUFFER_ENABLE_KEY	0x62636370
-#define QCOM_RPM_SMD_KEY_RATE				0x007a484b
-#define QCOM_RPM_SMD_KEY_ENABLE				0x62616e45
-#define QCOM_RPM_SMD_KEY_STATE				0x54415453
-#define QCOM_RPM_SCALING_ENABLE_ID			0x2
-
 #define __DEFINE_CLK_SMD_RPM_PREFIX(_prefix, _name, _active,		      \
 				    type, r_id, key)			      \
 	static struct clk_smd_rpm clk_smd_rpm_##_prefix##_active;	      \
@@ -171,12 +164,6 @@ struct clk_smd_rpm {
 	unsigned long rate;
 };
 
-struct clk_smd_rpm_req {
-	__le32 key;
-	__le32 nbytes;
-	__le32 value;
-};
-
 struct rpm_smd_clk_desc {
 	struct clk_smd_rpm **clks;
 	size_t num_clks;
diff --git a/include/linux/soc/qcom/smd-rpm.h b/include/linux/soc/qcom/smd-rpm.h
index 99499e4b080e..8190878645f9 100644
--- a/include/linux/soc/qcom/smd-rpm.h
+++ b/include/linux/soc/qcom/smd-rpm.h
@@ -2,6 +2,8 @@
 #ifndef __QCOM_SMD_RPM_H__
 #define __QCOM_SMD_RPM_H__
 
+#include <linux/types.h>
+
 struct qcom_smd_rpm;
 
 #define QCOM_SMD_RPM_ACTIVE_STATE	0
@@ -45,6 +47,19 @@ struct qcom_smd_rpm;
 #define QCOM_SMD_RPM_PKA_CLK	0x616b70
 #define QCOM_SMD_RPM_MCFG_CLK	0x6766636d
 
+#define QCOM_RPM_KEY_SOFTWARE_ENABLE			0x6e657773
+#define QCOM_RPM_KEY_PIN_CTRL_CLK_BUFFER_ENABLE_KEY	0x62636370
+#define QCOM_RPM_SMD_KEY_RATE				0x007a484b
+#define QCOM_RPM_SMD_KEY_ENABLE				0x62616e45
+#define QCOM_RPM_SMD_KEY_STATE				0x54415453
+#define QCOM_RPM_SCALING_ENABLE_ID			0x2
+
+struct clk_smd_rpm_req {
+	__le32 key;
+	__le32 nbytes;
+	__le32 value;
+};
+
 int qcom_rpm_smd_write(struct qcom_smd_rpm *rpm,
 		       int state,
 		       u32 resource_type, u32 resource_id,

-- 
2.41.0

