Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3C2715B7B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjE3KUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjE3KUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:20:23 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D9C100
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:20:13 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f3b39cea1eso4605179e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685442011; x=1688034011;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TpJbF1vFcph0nkpsSBRbxFLj0ciOsLhfijS4NONr96M=;
        b=F5l6WabXtdWoe0wkyxQKwqOGBv9ndkFti9OPfNqK9InuWA0r697ZO9wwuVdblKgEoN
         yoTsBgjfDz9Dl7+DP5nkdpkPaCVeeo87Nw5xIqZDdL2v6yGlcX3yqrUTxnL4shB5gq7n
         kjbvHWAMoZgn4EBuVnR8cbLKtn1YtxFl1OMwO3kRgca4vh8sy73EEZA8njVDDQU0+7P1
         IEX4eJ6rO7oThNOumAEwTvuVXOHVLYZPFf3SOKZxA1ek/heEt5ZrkysAIW1zwcr8smjf
         QcdNdXWrHwUYHSgtQw9hRaCZGn+GK+1Zd+ChhXUDUo+fdKv3ndbBK3Nw5bnwMyhw30aq
         Ksrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685442011; x=1688034011;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TpJbF1vFcph0nkpsSBRbxFLj0ciOsLhfijS4NONr96M=;
        b=XA9SjBJ4YkMU+lloQUdiIh2UpDNVQHED0tNEKmGPKPNjx7LsV/dfPd0W397Y4qsT8T
         5beZsnljksOY4NDbnJQPDJYDByFNJ5/Rp6wQZNsuEAMxL8AoUOeuplyOe2IX2escZZPU
         sgNxruzqSV30XbMp+whtZZn6hA9mpdoyPv/iNoQcpFIm+L4mQ6ASFkCjXKmtz11wu38F
         4WrfN2wXIwkk2CjvEXNqzhuvQssJNVM/dAWfebMg1gXqw2MFm3QJEmgDTBj7i1YTIwNP
         6+OMmGVIeJ9wzAz5or2XGDjMjS9bR0RRIOwWf6jrmgLifTjrZpHcRlG0+7xYnYoOACI7
         Zwcg==
X-Gm-Message-State: AC+VfDyVPfFkX7+t3LlnSEOagWK8jifMJj8rNcFUg9kGAHkgh6NhCi1q
        TYWn3+l5wyJBII5UTghTEqf8CwvS1u3GKN/vdwA=
X-Google-Smtp-Source: ACHHUZ75nHtvUU8HKrZUZdI39jVhUanPQSM49ng0efyE81zqxBRzT8GGOIIvKEk+VDtnTxHVRpYhKQ==
X-Received: by 2002:ac2:5d29:0:b0:4f4:dd5d:f3e0 with SMTP id i9-20020ac25d29000000b004f4dd5df3e0mr491433lfb.51.1685442011619;
        Tue, 30 May 2023 03:20:11 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id c25-20020ac24159000000b004cc8196a308sm290902lfi.98.2023.05.30.03.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 03:20:11 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 30 May 2023 12:20:05 +0200
Subject: [PATCH 06/20] interconnect: qcom: icc-rpm: Allow negative QoS
 offset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v1-6-1bf8e6663c4e@linaro.org>
References: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Evan Green <evgreen@chromium.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685442001; l=1945;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=dz+IMFIwrWQG2KEgD4qzubF0Nm4zxh38RgJ42e7JIhs=;
 b=WeZHcBs3lJx2hai55HcZVPIZ/sVXkhnpLL5ugWyYPdfyR9RaNJXJ7v+qa64a2m6jWCME4R2N9
 kTXkNXyLEmWBBtxpBx7iwaPecG2/pJVC/rQYYPybQZTHDGbu9cbIN6/
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some very very very very unfortunate cases, the correct offset of
the QoS registers will be.. negative. One such case is MSM8998, where
The DDR BWMON occupies what-would-be-the-BIMC-base which we usually
take into account with the register calculation, making the actual
BIMC node start at what-would-be-the-BIMC-base+0x300.

In order to keep the calculation code sane, the simplest - however
ugly it may be - solution is to allow the offset to be negative.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index d2c04c400cad..ba840a436cc0 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -29,10 +29,10 @@ enum qcom_icc_type {
  * @num_intf_clks: the total number of intf_clks clk_bulk_data entries
  * @type: the ICC provider type
  * @regmap: regmap for QoS registers read/write access
- * @qos_offset: offset to QoS registers
  * @bus_clk_rate: bus clock rate in Hz
  * @bus_clks: the clk_bulk_data table of bus clocks
  * @intf_clks: a clk_bulk_data array of interface clocks
+ * @qos_offset: offset to QoS registers
  * @keep_alive: whether to always keep a minimum vote on the bus clocks
  * @is_on: whether the bus is powered on
  */
@@ -42,7 +42,7 @@ struct qcom_icc_provider {
 	int num_intf_clks;
 	enum qcom_icc_type type;
 	struct regmap *regmap;
-	unsigned int qos_offset;
+	int qos_offset;
 	u64 bus_clk_rate[NUM_BUS_CLKS];
 	struct clk_bulk_data bus_clks[NUM_BUS_CLKS];
 	struct clk_bulk_data *intf_clks;
@@ -108,7 +108,7 @@ struct qcom_icc_desc {
 	bool no_clk_scaling;
 	enum qcom_icc_type type;
 	const struct regmap_config *regmap_cfg;
-	unsigned int qos_offset;
+	int qos_offset;
 };
 
 /* Valid for all bus types */

-- 
2.40.1

