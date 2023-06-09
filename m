Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1653F72A46A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 22:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbjFIUUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 16:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbjFIUTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:19:45 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10A81B9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 13:19:24 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b15a327c20so24664271fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 13:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686341963; x=1688933963;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FsjjWN/3ExrWWr4Y2ppq6JQGmoO1NTS4jkjNM8tw+cY=;
        b=Znr1n54W+8fGpzjYv2vsQaYQk388QlI8dSxPWoZAGkfXcOcU+zzS0ZWnmAHgtqhMlm
         mbWUmPrPjo3ga2TSeTUc+GJF2gMBhEZ4dUffy6+RIyLTH0VW2iWVP9NZ13uVUav+tbfF
         rFBFevWSv2RbmfVSYp/OnoD9NIllMYZN1n5XppHtBrqL5ym7+eDGZsYhNnrXuC1LCd17
         s9xNhmIINS6dU5tcVeEbE9wx7PKNEgHbbVxIO7DmbZlccSQ1nxAS6SfXtrqfXE+NfqBN
         eSVV4PjeeLvATX0eExC/FGTV5fC1cXsQid5momBXnL0+wPuIFuMKCdeCZ+OTy6jQH/fl
         RCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686341963; x=1688933963;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FsjjWN/3ExrWWr4Y2ppq6JQGmoO1NTS4jkjNM8tw+cY=;
        b=bTf0g65gj8KcQpgYHac2SNQO1kb8BmCBTtTLrD+wuIVze/zdE6Rof9C38SIZyacNYq
         hbb5KJ/O8Nx1U3r2gq9lUNkkQe0gu129DNxdbuWhtNdVruDycoD9VgZulM7zFZgpnE49
         lpTkcyIJsd30qFjjApdGD81X8cdEbae7DJJxFr6ub3bSCPRmA961Lj4V4lX9HOcrybd/
         g8oiRfL/J5aN2y9clcSRvDlkcufNmi4M+TDRAgVRSpU63rYLd1MQtqE/oyMPDIRgl1Iu
         KBHb2UFGgYNg1wGa63wV6y3f5tYY6pHC+pd0FnagFyOfyqu/+6kwwRqirgcq+560BZxX
         Ul4w==
X-Gm-Message-State: AC+VfDwQkQ8AwtQtrrndHdLiuf4c4qcsXj3T/NYp/fTlW9D8+RueJPYQ
        V0zRLS3LJVQtUM7xYFXKMpnnFA==
X-Google-Smtp-Source: ACHHUZ57goyW/TYEI402vG9vnZdhnXMaiJo033PjpTU1zzDdaYe4dYLm2bogyH4FG5Eb8c3/QPZVdQ==
X-Received: by 2002:a19:4347:0:b0:4f3:b2a7:68ef with SMTP id m7-20020a194347000000b004f3b2a768efmr1366987lfj.10.1686341963033;
        Fri, 09 Jun 2023 13:19:23 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id b18-20020ac25632000000b004f628eb7884sm641349lff.232.2023.06.09.13.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 13:19:22 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 09 Jun 2023 22:19:11 +0200
Subject: [PATCH v2 06/22] interconnect: qcom: icc-rpm: Allow negative QoS
 offset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v2-6-e5934b07d813@linaro.org>
References: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686341953; l=1945;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=rgTDM+URKWJ36SFNnllBnyQwiFYuxKTtmuTacUJ+85U=;
 b=FpmhfeRG1aZHlIzvOClTkP2gbB2RANAcmI1h8mAYuMlhbe7Bt3tok8yu6mu1PrWXHl6YmwNdS
 JrH5kM9VHImAsQt2ZwnH4WuksfsviX+z/C70P9DPFSNckquLgr3QAlq
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
2.41.0

