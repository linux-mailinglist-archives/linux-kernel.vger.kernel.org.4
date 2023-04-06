Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA5D6D9B70
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238521AbjDFO7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239163AbjDFO67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:58:59 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A81659A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 07:58:56 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso25692817wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 07:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680793135; x=1683385135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFQJ0JSK2AI42Y7WQ2NOgsYWULbFZSsr1UBIiIbTSbY=;
        b=mao3Fw3VDnEGFw2m5aPPM0jnpVyXLIIOXCZCPPqksXA3xVdYRwc5rtmp5MAwj1SPFY
         A1H2t/65LOh8htqlnLl6+kS667EED9ByiQOkx+gH4wGur6TRCmvobXOjFqck8fIcjg2p
         nvFQEHsrqMI2Ii7wRJGPXs21aZo/7cED3OSIb7gQHNGcJL8QNIU7Uw4SM+2vWmt4tqfe
         EnT1Qhume1y0LxuMvIZuGARn97d67nFUE3+AF7MG4u5vjXaTlv4M7OH5EZ5ZgnHks39V
         He2ZbgRgAtITuKdL5OTehehciTFlxISD8lGeWmvO6qLC6+1dBlDh0+6lny5X18eNjbjP
         3Btw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680793135; x=1683385135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFQJ0JSK2AI42Y7WQ2NOgsYWULbFZSsr1UBIiIbTSbY=;
        b=uyZzjm3sZo8VRe+DFNgyYQd7O1hZdM0CWx2hakgVinKAB/pSxmcH1PTlOfjBD7jITx
         OR2cKuLZUWWbXWhb90lR+Z021aWgK5/I5pekeDWdz1lg4SjCjO5njToN4MkGIlrxIRnd
         WOi8U6cwhx0z4LCgORNLhxj2vTwqrRU2zM7u83En1/qmwhkrDHJY8gCmHhQXYvqYSLp+
         JfOEeFECpyVdBAE9TlA00X60sixA+KrEWLsGAp8rec6U1ug1Qnsgbc/JNdLvIev+ki/z
         /tTLgZsoHmdmSHhWHx7YbhUhpT836AYAO7N8+8p6PWiBrmM/o7tQcJ9EiGJFkhkDq5xf
         Cqdg==
X-Gm-Message-State: AAQBX9d27LdZ6KR5ShmDRhoS0TeJzpUGQOSF06w7a77ZdvPmNr3SXHRS
        /7/3CQsmZ9HlcvIy+jRsoU7U1A==
X-Google-Smtp-Source: AKy350aMZIoUs7COMqn5CuqRo8MtaiTTlCouRN+4YP84oA+m0wsNCdeJzzbU6AoWpEoJOGonlay7FQ==
X-Received: by 2002:a05:600c:ace:b0:3ed:ea48:cd92 with SMTP id c14-20020a05600c0ace00b003edea48cd92mr8064920wmr.15.1680793135280;
        Thu, 06 Apr 2023 07:58:55 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d10-20020a1c730a000000b003f0373d077csm1768160wmb.47.2023.04.06.07.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 07:58:54 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     amitk@kernel.org, thara.gopinath@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com,
        dmitry.baryshkov@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH 2/3] thermal/drivers/tsens: Describe sensor registers via a structure
Date:   Thu,  6 Apr 2023 15:58:49 +0100
Message-Id: <20230406145850.357296-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406145850.357296-1-bryan.odonoghue@linaro.org>
References: <20230406145850.357296-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define sensor identifiers and optional shifts in a single data-structure.
This facilitates extraction of calibration data from non-contiguous
addresses.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/thermal/qcom/tsens-v0_1.c | 56 +++++++++++++++++++++++++++++--
 drivers/thermal/qcom/tsens.c      |  5 +--
 drivers/thermal/qcom/tsens.h      | 16 ++++++++-
 3 files changed, 72 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index e89c6f39a3aea..c20c002d98650 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -319,10 +319,31 @@ static const struct tsens_ops ops_8916 = {
 	.get_temp	= get_temp_common,
 };
 
+struct tsens_reg_data reg_8916[] = {
+	{
+		.id = 0,
+	},
+	{
+		.id = 1,
+	},
+	{
+		.id = 2,
+	},
+	{
+		.id = 3,
+	},
+	{
+		.id = 4,
+	},
+	{
+		.id = 5,
+	},
+};
+
 struct tsens_plat_data data_8916 = {
 	.num_sensors	= 5,
 	.ops		= &ops_8916,
-	.hw_ids		= (unsigned int []){0, 1, 2, 4, 5 },
+	.reg		= reg_8916,
 
 	.feat		= &tsens_v0_1_feat,
 	.fields	= tsens_v0_1_regfields,
@@ -334,10 +355,41 @@ static const struct tsens_ops ops_8939 = {
 	.get_temp	= get_temp_common,
 };
 
+struct tsens_reg_data reg_8939[] = {
+	{
+		.id = 0,
+	},
+	{
+		.id = 1,
+	},
+	{
+		.id = 2,
+	},
+	{
+		.id = 3,
+	},
+	{
+		.id = 5,
+	},
+	{
+		.id = 6,
+	},
+	{
+		.id = 7,
+	},
+	{
+		.id = 8,
+	},
+	{
+		.id = 9,
+		.p2_shift = 8,
+	},
+};
+
 struct tsens_plat_data data_8939 = {
 	.num_sensors	= 9,
 	.ops		= &ops_8939,
-	.hw_ids		= (unsigned int []){ 0, 1, 2, 3, 5, 6, 7, 8, 9, /* 10 */ },
+	.reg		= reg_8939,
 
 	.feat		= &tsens_v0_1_feat,
 	.fields	= tsens_v0_1_regfields,
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 7165b0bfe8b9f..a260f563b4889 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1274,13 +1274,14 @@ static int tsens_probe(struct platform_device *pdev)
 	priv->num_sensors = num_sensors;
 	priv->ops = data->ops;
 	for (i = 0;  i < priv->num_sensors; i++) {
-		if (data->hw_ids)
-			priv->sensor[i].hw_id = data->hw_ids[i];
+		if (data->reg)
+			priv->sensor[i].hw_id = data->reg[i].id;
 		else
 			priv->sensor[i].hw_id = i;
 	}
 	priv->feat = data->feat;
 	priv->fields = data->fields;
+	priv->reg = data->reg;
 
 	platform_set_drvdata(pdev, priv);
 
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index dba9cd38f637c..31f67da03bce6 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -517,18 +517,31 @@ struct tsens_features {
 	int trip_max_temp;
 };
 
+/**
+ * struct tsens_reg_data - describes register data retrieved non-contiguously
+ * @id: thermal sensor identifier
+ * @p1_shift: When non-zero is the # of bits to right shift p1 MSB by
+ * @p2_shift: When non-zero is the # of bits to right shift p2 MSB by
+ */
+struct tsens_reg_data {
+	unsigned int id;
+	unsigned int p1_shift;
+	unsigned int p2_shift;
+};
+
 /**
  * struct tsens_plat_data - tsens compile-time platform data
  * @num_sensors: Number of sensors supported by platform
  * @ops: operations the tsens instance supports
  * @hw_ids: Subset of sensors ids supported by platform, if not the first n
+ * @reg: Describe sensor id and calibration shifts
  * @feat: features of the IP
  * @fields: bitfield locations
  */
 struct tsens_plat_data {
 	const u32		num_sensors;
 	const struct tsens_ops	*ops;
-	unsigned int		*hw_ids;
+	struct tsens_reg_data	*reg;
 	struct tsens_features	*feat;
 	const struct reg_field		*fields;
 };
@@ -575,6 +588,7 @@ struct tsens_priv {
 	struct regmap_field		*rf[MAX_REGFIELDS];
 	struct tsens_context		ctx;
 	struct tsens_features		*feat;
+	struct tsens_reg_data		*reg;
 	const struct reg_field		*fields;
 	const struct tsens_ops		*ops;
 
-- 
2.39.2

