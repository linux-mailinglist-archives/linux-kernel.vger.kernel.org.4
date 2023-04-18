Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7154B6E5E09
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjDRJzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjDRJzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:55:19 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88F16E9E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 02:55:00 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a5so15103037ejb.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 02:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681811699; x=1684403699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rm5Clkhi7OKyfk2gyaI7Jz7GWaSKwLEnRxea7jsImnE=;
        b=B/zuyYIGHjFHmCaELOHZqzcpXx1oeztJyGgpjhVFTT04tNSu+qVh7QsJ5voRLZCtJX
         KMyJbWjMMswC9N7QP9G/Wj9Ah7Yyzv4XpEmnUM8Fdd32ANk27C0pnTwcP3Q1O9x0QrzT
         AFfD5LIiFqk+CbE2Z17q3vwdPUJJ/FVzbPUPycvm3HPqMEUSVqkrBMmrmfbCv/fORT+V
         37FcsPsQ4+vHLvFQa/1PxzdmuaTib3C1vu3WhLI4pcoXYuW4U5JYQWKdbYnm4VCar8nv
         81RPjL377XhYn6mFlWUVyS7SyfHzro9GqbwzoSvmL5vLqE26OrxHcjkL+OTtpXxvm/7W
         hJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681811699; x=1684403699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rm5Clkhi7OKyfk2gyaI7Jz7GWaSKwLEnRxea7jsImnE=;
        b=VmHpMMMAjxb7JGDmUSuUOrGv00PgkEppRP44mocix00KUHm7l//eExtFwCk+6ijS2V
         EQ6eSS0KC3L1/hPpt7BFldt2UyDygV6SM3G7qAR44fPPR4MoXrG2SUo+KRB2hordSzJ5
         kFsbM322+HKfrL+I+MwTHhluAfn8VwibMzMsGQwhQY+J/bxfd4nS3KtxVEoYrwCoYky4
         DMfVIco5ofUtQLRUkdUELs+sw08JYmA1s4imZHNucXMc+zeNZEmnTGvtuGrLkOwadkgT
         ht+A62DhJOMS4xROdqkDGLHAhMak4x3W5toNrYpg3dbUE6icAB1NbXF3o5fTgddyqqCV
         ajhw==
X-Gm-Message-State: AAQBX9c9h8X6M78mt+eojSfwpKlCCaYVWbONmV1gIgBCXKwqnpxyDN8l
        6atdE8OSz3GwWLupY035PMi2xQ==
X-Google-Smtp-Source: AKy350Y4civICNM8zr7hd+GNeg3iFkCFRk5nboyltEkmFIyKL8bL8WfrBh55oP9yhCB2QT/73VnYjg==
X-Received: by 2002:a17:907:16a8:b0:94f:2d38:896b with SMTP id hc40-20020a17090716a800b0094f2d38896bmr9767703ejc.53.1681811699278;
        Tue, 18 Apr 2023 02:54:59 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a276:7d35:5226:1c77])
        by smtp.gmail.com with ESMTPSA id o4-20020a509b04000000b00504d04c939fsm7076578edi.59.2023.04.18.02.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 02:54:58 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 7/7] soundwire: qcom: use tabs for indentation in defines
Date:   Tue, 18 Apr 2023 11:54:47 +0200
Message-Id: <20230418095447.577001-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230418095447.577001-1-krzysztof.kozlowski@linaro.org>
References: <20230418095447.577001-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use consistently only tabs to indent the value in defines.

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v2:
1. Add tags.
---
 drivers/soundwire/qcom.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 90afc8f15b82..aad5942e5980 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -58,9 +58,9 @@
 #define SWRM_INTERRUPT_STATUS_SPECIAL_CMD_ID_FINISHED		BIT(10)
 #define SWRM_INTERRUPT_STATUS_AUTO_ENUM_FAILED			BIT(11)
 #define SWRM_INTERRUPT_STATUS_AUTO_ENUM_TABLE_IS_FULL		BIT(12)
-#define SWRM_INTERRUPT_STATUS_BUS_RESET_FINISHED_V2             BIT(13)
-#define SWRM_INTERRUPT_STATUS_CLK_STOP_FINISHED_V2              BIT(14)
-#define SWRM_INTERRUPT_STATUS_EXT_CLK_STOP_WAKEUP               BIT(16)
+#define SWRM_INTERRUPT_STATUS_BUS_RESET_FINISHED_V2		BIT(13)
+#define SWRM_INTERRUPT_STATUS_CLK_STOP_FINISHED_V2		BIT(14)
+#define SWRM_INTERRUPT_STATUS_EXT_CLK_STOP_WAKEUP		BIT(16)
 #define SWRM_INTERRUPT_MAX					17
 #define SWRM_V1_3_INTERRUPT_MASK_ADDR				0x204
 #define SWRM_V1_3_INTERRUPT_CLEAR				0x208
@@ -125,20 +125,20 @@
 #define SWRM_REG_VAL_PACK(data, dev, id, reg)	\
 			((reg) | ((id) << 16) | ((dev) << 20) | ((data) << 24))
 
-#define MAX_FREQ_NUM		1
-#define TIMEOUT_MS		100
-#define QCOM_SWRM_MAX_RD_LEN	0x1
-#define QCOM_SDW_MAX_PORTS	14
-#define DEFAULT_CLK_FREQ	9600000
-#define SWRM_MAX_DAIS		0xF
-#define SWR_INVALID_PARAM 0xFF
-#define SWR_HSTOP_MAX_VAL 0xF
-#define SWR_HSTART_MIN_VAL 0x0
-#define SWR_BROADCAST_CMD_ID    0x0F
-#define SWR_MAX_CMD_ID	14
-#define MAX_FIFO_RD_RETRY 3
-#define SWR_OVERFLOW_RETRY_COUNT 30
-#define SWRM_LINK_STATUS_RETRY_CNT 100
+#define MAX_FREQ_NUM						1
+#define TIMEOUT_MS						100
+#define QCOM_SWRM_MAX_RD_LEN					0x1
+#define QCOM_SDW_MAX_PORTS					14
+#define DEFAULT_CLK_FREQ					9600000
+#define SWRM_MAX_DAIS						0xF
+#define SWR_INVALID_PARAM					0xFF
+#define SWR_HSTOP_MAX_VAL					0xF
+#define SWR_HSTART_MIN_VAL					0x0
+#define SWR_BROADCAST_CMD_ID					0x0F
+#define SWR_MAX_CMD_ID						14
+#define MAX_FIFO_RD_RETRY					3
+#define SWR_OVERFLOW_RETRY_COUNT				30
+#define SWRM_LINK_STATUS_RETRY_CNT				100
 
 enum {
 	MASTER_ID_WSA = 1,
-- 
2.34.1

