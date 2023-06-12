Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A620A72CE6D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237978AbjFLSbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237709AbjFLSYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:24:50 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19ADD10C9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:24:49 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f6454a21a9so5514142e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686594287; x=1689186287;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FsjjWN/3ExrWWr4Y2ppq6JQGmoO1NTS4jkjNM8tw+cY=;
        b=K54KstXCd6kINZFUtZ3Smsy8fneDRssP9Duv/nwy9dWQ1mXbMw0Q3xn6fqjKVhyoRW
         UbP7QxyL4lzL2aiI4funWx4hQgIvgF1V6h3uBe2mC0aYxzG3AGgCocZpqXGrSZmvs9LY
         vlMIs6saA8UijChiRSWqs/UGCdQtuvgjdp4N7XXAEEmHQ7fUWyYSJu95z3E05avM+Imy
         KQgWoI13E96ZiKo6Kc+aAtb4KPHSdxxhMufzksEc272v5eA0/AAQLtbSnJPbIuZqGU8m
         dN3+gcPe3Wt0DSJhacABEX51q8dZWDNty7clvVR6d45SQ2zlBRZj5dp2WTPyuIlvDa2A
         Qq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686594287; x=1689186287;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FsjjWN/3ExrWWr4Y2ppq6JQGmoO1NTS4jkjNM8tw+cY=;
        b=fypnH5m0zPPEVeb783NFX2+NMyRKM5CpMkjmr1SZtNJlCUl8Uc497oEdpCVoYMNibv
         G4Or/3zwdjD5FhYVp6ZHiH3g+01eQ/48d9j51INJHum3D5YOpQogEXcSOTex4orZ7b/x
         XyyHJTIbHvh/gdRJk7/AbpPGkJv12WvQloJYxQbN27uPeliNBTeTIHpu3YD6Ix7IulqK
         SgE6hdGthfMa7C2rAuO82K8zZRg6ghFE9KuVUiP0iS3oQkGAyzCi5eqSAquv4ggv/BCo
         LnYvCvCuKn13dmp/h9Fs+QYHWA8v/oEs90AOVQ0l1+a64j5ZSFdE/G6alNmdruZTOU4+
         dylg==
X-Gm-Message-State: AC+VfDxGz0jyWXutRqiclIU/+01Bfg9GxZA1t1KW10zKoGg8oZKahUIQ
        Njfd+SEs9Ck93xm6KDx32xF8JQ==
X-Google-Smtp-Source: ACHHUZ5gh2WUgM3aKwlGzRs6m3JPDYp0MPUlhlGg74/eA25lZuz77rG1nbz0YBbUX9rHLBusN3lBYQ==
X-Received: by 2002:a19:9101:0:b0:4f6:1863:6b47 with SMTP id t1-20020a199101000000b004f618636b47mr4603716lfd.42.1686594287470;
        Mon, 12 Jun 2023 11:24:47 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id v24-20020ac25938000000b004f64073a252sm1502035lfi.96.2023.06.12.11.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:24:47 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 12 Jun 2023 20:24:24 +0200
Subject: [PATCH v3 07/23] interconnect: qcom: icc-rpm: Allow negative QoS
 offset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v3-7-5fb7d39b874f@linaro.org>
References: <20230526-topic-smd_icc-v3-0-5fb7d39b874f@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v3-0-5fb7d39b874f@linaro.org>
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
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686594276; l=1945;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=rgTDM+URKWJ36SFNnllBnyQwiFYuxKTtmuTacUJ+85U=;
 b=7UiBzS0n4xsdfHTqQtldUSL1Fr4X4ozDE1+IvyrfLr7nbeJycdVlDkurmHFJcs6oCBEdTQKJS
 fsyt6fTKUY8DDiVa5bFEWu8qEZXRBe/GT8V7EuZ9RnxlbiJiTJftXed
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
2.41.0

