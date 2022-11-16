Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36EC62BC59
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238601AbiKPLqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239115AbiKPLpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:45:21 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AFBE01D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:30:24 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id k8so29445869wrh.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gowsE7hNlaIPNBrjX8jMoHX9a5SfoQDa9L3yGECo7fI=;
        b=CB+4a9drfYjA35ewFEncE/G/eXxQ3vIlDbHIXVWP0JzBzKtp05EBTSREhn8G0f+GE6
         HZbXv5VtID/vXMp6aK5oqbpJPbgwLbE8sQ+T1aXjYzo8vvL4jsiPSssn6YSo6WVNHwij
         1pibrE6ZAy1AOEmqbxFJgiqPGlUxDn7ADmqz/b7GnKOBQZbdEFADDLnNiNTgF8u93fNM
         VfQTH6D8Ao/e1X2rHPYJZ47AKWqnuTXHO6Rff0K1qRhYUvcG8waaRBJPiSRu+CWjdIpF
         GCNwelzHrS3qlrnNhaZMjQZUx/s7AdGBoW0NR5qiIJfK+zT1h+YO5R3p1Bq0eAnxJSG5
         SovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gowsE7hNlaIPNBrjX8jMoHX9a5SfoQDa9L3yGECo7fI=;
        b=MdDNBJW4MYN/FCMT0Rdjk/2YWjWqteZzhwdQwdlcbWa6LsjCZErOgCBGEeqFU48uaL
         7Gi1rdh0+KoPitSD8GfdhUfpjsOdgWoKhYlXnzeSFt55xrPclt/pCd+DgpeKBURFd4Rx
         ocI7AVCyhePCbWZerAQzSIfO0buGt+sqOoNVEqCKxEN1MJwYbHDj8V2wCkaJ2x0CuQd2
         t+wW1sS0VM6gZwGrsGRT3YCKrWWeRNvEtCu6DLBwr3nt1dj+dNJHvJxTmOauuraPgpzn
         npJxpMA5Zm8pTm5jQpPp7ANg6WovZHckYmj82nKCeqP+mP49Q0r+RrUpvry47wN3/Uzx
         jJUw==
X-Gm-Message-State: ANoB5pn/YD+nx5ORzadjfajX1Cd2YNnpMzcn5YrH792R81pxLdsKKK4V
        slUbesDTZ3MqhRvcGZToRAQZWw==
X-Google-Smtp-Source: AA0mqf68jVY09+coGVYqioG2x0mpu/td/Sse8Eb5vdOAt8tsNx4O1zGtA+4DJj82huPRBFRMJrp4rg==
X-Received: by 2002:a05:6000:242:b0:236:5ea4:68c4 with SMTP id m2-20020a056000024200b002365ea468c4mr13402043wrz.503.1668598222928;
        Wed, 16 Nov 2022 03:30:22 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c1d8f00b003b3307fb98fsm1929489wms.24.2022.11.16.03.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 03:30:22 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/3] soc: qcom: llcc: Add v4.1 HW version support
Date:   Wed, 16 Nov 2022 13:30:03 +0200
Message-Id: <20221116113005.2653284-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116113005.2653284-1-abel.vesa@linaro.org>
References: <20221116113005.2653284-1-abel.vesa@linaro.org>
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

The LLCC found in SM8550 supports more slice configuration knobs and HW
block version has been bumped up to 4.1. Add support for the new version
and make sure the new config values are programed on probe.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/soc/qcom/llcc-qcom.c | 125 +++++++++++++++++++++++++++++++++--
 1 file changed, 118 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 82c3cfdcc560..6bb88816958e 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -21,6 +21,8 @@
 
 #define ACTIVATE                      BIT(0)
 #define DEACTIVATE                    BIT(1)
+#define ACT_CLEAR                     BIT(0)
+#define ACT_COMPLETE                  BIT(4)
 #define ACT_CTRL_OPCODE_ACTIVATE      BIT(0)
 #define ACT_CTRL_OPCODE_DEACTIVATE    BIT(1)
 #define ACT_CTRL_ACT_TRIG             BIT(0)
@@ -41,19 +43,30 @@
 
 #define MAX_CAP_TO_BYTES(n)           (n * SZ_1K)
 #define LLCC_TRP_ACT_CTRLn(n)         (n * SZ_4K)
+#define LLCC_TRP_ACT_CLEARn(n)        (8 + n * SZ_4K)
 #define LLCC_TRP_STATUSn(n)           (4 + n * SZ_4K)
 #define LLCC_TRP_ATTR0_CFGn(n)        (0x21000 + SZ_8 * n)
 #define LLCC_TRP_ATTR1_CFGn(n)        (0x21004 + SZ_8 * n)
+#define LLCC_TRP_ATTR2_CFGn(n)        (0x21100 + SZ_8 * n)
 
 #define LLCC_TRP_SCID_DIS_CAP_ALLOC   0x21f00
 #define LLCC_TRP_PCB_ACT              0x21f04
+#define LLCC_TRP_ALGO_CFG1	      0x21f0c
+#define LLCC_TRP_ALGO_CFG2	      0x21f10
+#define LLCC_TRP_ALGO_CFG3	      0x21f14
+#define LLCC_TRP_ALGO_CFG4	      0x21f18
+#define LLCC_TRP_ALGO_CFG5	      0x21f1c
 #define LLCC_TRP_WRSC_EN              0x21f20
+#define LLCC_TRP_ALGO_CFG6	      0x21f24
+#define LLCC_TRP_ALGO_CFG7	      0x21f28
 #define LLCC_TRP_WRSC_CACHEABLE_EN    0x21f2c
+#define LLCC_TRP_ALGO_CFG8	      0x21f30
 
 #define BANK_OFFSET_STRIDE	      0x80000
 
 #define LLCC_VERSION_2_0_0_0          0x02000000
 #define LLCC_VERSION_2_1_0_0          0x02010000
+#define LLCC_VERSION_4_1_0_0          0x04010000
 
 /**
  * struct llcc_slice_config - Data associated with the llcc slice
@@ -97,6 +110,14 @@ struct llcc_slice_config {
 	bool activate_on_init;
 	bool write_scid_en;
 	bool write_scid_cacheable_en;
+	bool stale_en;
+	bool stale_cap_en;
+	bool mru_uncap_en;
+	bool mru_rollover;
+	bool alloc_oneway_en;
+	bool ovcap_en;
+	bool ovcap_prio;
+	bool vict_prio;
 };
 
 struct qcom_llcc_config {
@@ -497,6 +518,7 @@ static int llcc_update_act_ctrl(u32 sid,
 				u32 act_ctrl_reg_val, u32 status)
 {
 	u32 act_ctrl_reg;
+	u32 act_clear_reg;
 	u32 status_reg;
 	u32 slice_status;
 	int ret;
@@ -505,6 +527,7 @@ static int llcc_update_act_ctrl(u32 sid,
 		return PTR_ERR(drv_data);
 
 	act_ctrl_reg = LLCC_TRP_ACT_CTRLn(sid);
+	act_clear_reg = LLCC_TRP_ACT_CLEARn(sid);
 	status_reg = LLCC_TRP_STATUSn(sid);
 
 	/* Set the ACTIVE trigger */
@@ -521,9 +544,22 @@ static int llcc_update_act_ctrl(u32 sid,
 	if (ret)
 		return ret;
 
+	if (drv_data->version >= LLCC_VERSION_4_1_0_0) {
+		ret = regmap_read_poll_timeout(drv_data->bcast_regmap, status_reg,
+				      slice_status, (slice_status & ACT_COMPLETE),
+				      0, LLCC_STATUS_READ_DELAY);
+		if (ret)
+			return ret;
+	}
+
 	ret = regmap_read_poll_timeout(drv_data->bcast_regmap, status_reg,
 				      slice_status, !(slice_status & status),
 				      0, LLCC_STATUS_READ_DELAY);
+
+	if (drv_data->version >= LLCC_VERSION_4_1_0_0)
+		ret = regmap_write(drv_data->bcast_regmap, act_clear_reg,
+					ACT_CLEAR);
+
 	return ret;
 }
 
@@ -636,8 +672,10 @@ static int _qcom_llcc_cfg_program(const struct llcc_slice_config *config,
 				  const struct qcom_llcc_config *cfg)
 {
 	int ret;
+	u32 attr2_cfg;
 	u32 attr1_cfg;
 	u32 attr0_cfg;
+	u32 attr2_val;
 	u32 attr1_val;
 	u32 attr0_val;
 	u32 max_cap_cacheline;
@@ -667,8 +705,14 @@ static int _qcom_llcc_cfg_program(const struct llcc_slice_config *config,
 	if (ret)
 		return ret;
 
-	attr0_val = config->res_ways & ATTR0_RES_WAYS_MASK;
-	attr0_val |= config->bonus_ways << ATTR0_BONUS_WAYS_SHIFT;
+	if (drv_data->version >= LLCC_VERSION_4_1_0_0) {
+		attr2_cfg = LLCC_TRP_ATTR2_CFGn(config->slice_id);
+		attr0_val = config->res_ways;
+		attr2_val = config->bonus_ways;
+	} else {
+		attr0_val = config->res_ways & ATTR0_RES_WAYS_MASK;
+		attr0_val |= config->bonus_ways << ATTR0_BONUS_WAYS_SHIFT;
+	}
 
 	attr0_cfg = LLCC_TRP_ATTR0_CFGn(config->slice_id);
 
@@ -676,6 +720,12 @@ static int _qcom_llcc_cfg_program(const struct llcc_slice_config *config,
 	if (ret)
 		return ret;
 
+	if (drv_data->version >= LLCC_VERSION_4_1_0_0) {
+		ret = regmap_write(drv_data->bcast_regmap, attr2_cfg, attr2_val);
+		if (ret)
+			return ret;
+	}
+
 	if (cfg->need_llcc_cfg) {
 		u32 disable_cap_alloc, retain_pc;
 
@@ -685,11 +735,13 @@ static int _qcom_llcc_cfg_program(const struct llcc_slice_config *config,
 		if (ret)
 			return ret;
 
-		retain_pc = config->retain_on_pc << config->slice_id;
-		ret = regmap_write(drv_data->bcast_regmap,
-				LLCC_TRP_PCB_ACT, retain_pc);
-		if (ret)
-			return ret;
+		if (drv_data->version < LLCC_VERSION_4_1_0_0) {
+			retain_pc = config->retain_on_pc << config->slice_id;
+			ret = regmap_write(drv_data->bcast_regmap,
+					LLCC_TRP_PCB_ACT, retain_pc);
+			if (ret)
+				return ret;
+		}
 	}
 
 	if (drv_data->version >= LLCC_VERSION_2_0_0_0) {
@@ -712,6 +764,65 @@ static int _qcom_llcc_cfg_program(const struct llcc_slice_config *config,
 			return ret;
 	}
 
+	if (drv_data->version >= LLCC_VERSION_4_1_0_0) {
+		u32 stale_en;
+		u32 stale_cap_en;
+		u32 mru_uncap_en;
+		u32 mru_rollover;
+		u32 alloc_oneway_en;
+		u32 ovcap_en;
+		u32 ovcap_prio;
+		u32 vict_prio;
+
+		stale_en = config->stale_en << config->slice_id;
+		ret = regmap_update_bits(drv_data->bcast_regmap, LLCC_TRP_ALGO_CFG1,
+					 BIT(config->slice_id), stale_en);
+		if (ret)
+			return ret;
+
+		stale_cap_en = config->stale_cap_en << config->slice_id;
+		ret = regmap_update_bits(drv_data->bcast_regmap, LLCC_TRP_ALGO_CFG2,
+					 BIT(config->slice_id), stale_cap_en);
+		if (ret)
+			return ret;
+
+		mru_uncap_en = config->mru_uncap_en << config->slice_id;
+		ret = regmap_update_bits(drv_data->bcast_regmap, LLCC_TRP_ALGO_CFG3,
+					 BIT(config->slice_id), mru_uncap_en);
+		if (ret)
+			return ret;
+
+		mru_rollover = config->mru_rollover << config->slice_id;
+		ret = regmap_update_bits(drv_data->bcast_regmap, LLCC_TRP_ALGO_CFG4,
+					 BIT(config->slice_id), mru_rollover);
+		if (ret)
+			return ret;
+
+		alloc_oneway_en = config->alloc_oneway_en << config->slice_id;
+		ret = regmap_update_bits(drv_data->bcast_regmap, LLCC_TRP_ALGO_CFG5,
+					 BIT(config->slice_id), alloc_oneway_en);
+		if (ret)
+			return ret;
+
+		ovcap_en = config->ovcap_en << config->slice_id;
+		ret = regmap_update_bits(drv_data->bcast_regmap, LLCC_TRP_ALGO_CFG6,
+					 BIT(config->slice_id), ovcap_en);
+		if (ret)
+			return ret;
+
+		ovcap_prio = config->ovcap_prio << config->slice_id;
+		ret = regmap_update_bits(drv_data->bcast_regmap, LLCC_TRP_ALGO_CFG7,
+					 BIT(config->slice_id), ovcap_prio);
+		if (ret)
+			return ret;
+
+		vict_prio = config->vict_prio << config->slice_id;
+		ret = regmap_update_bits(drv_data->bcast_regmap, LLCC_TRP_ALGO_CFG8,
+					 BIT(config->slice_id), vict_prio);
+		if (ret)
+			return ret;
+	}
+
 	if (config->activate_on_init) {
 		desc.slice_id = config->slice_id;
 		ret = llcc_slice_activate(&desc);
-- 
2.34.1

