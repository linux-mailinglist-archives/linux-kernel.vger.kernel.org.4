Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF38E6B1400
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjCHVfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjCHVfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:35:48 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E69CD13CF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 13:35:41 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id j11so23051442lfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 13:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678311339;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SOECaGmGmUJLrulLw8TRNrQNT4lkSkMI20VbWaQaVaY=;
        b=o2v3nZSRV6jX/ICAGftZdATJ2s6wCtxca6GFrbERkhh9MKuTWUSGF+BS2bz0fruDeY
         p6Tz9BBV0QTw44vdXR6hLNpREOYFMDUoklZE9yGtUmec+0noRMW7rU86LKQJHZYsyI2a
         rypoiclDLhzo2+DkRr9+/YTCI5syEXb71RRCosKKjs54FLmsTDaH0iBjFv2Egd7iMgqd
         9RA59HOR0gQyDikhy8X/zS/Ehx+jPhm/A4bWv6UzHb4emXNMH9bxcYnDf2Hwd8N+KYcv
         N1kGQBANwqL8cVLv6yaMyeXFcLvUvCBlTm7c5+xOhgTnqD+cQH9f7oDL4Tpzb06icVfu
         4lnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678311339;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOECaGmGmUJLrulLw8TRNrQNT4lkSkMI20VbWaQaVaY=;
        b=pl5d74STFCKn95s2ZLicQqEzYkLxFn9VCtZPA2b94FAPJtYjVGWd0I5qJhZFAn3BRs
         8dvUutzpWoNG4HVhzklY7hG7XhGztbUm+mI+K1387cD3jrDVzanN1VSxZYaXznr2X8zD
         pTm+d5PZc7I1GJAGPb9Ng7wZ9JEFP0/EDZi9/Toyf7xotr/vksiObpkNDpPwMXB7MZrE
         V+jNQR9CRI/C2JTuU4lFUccypf45qiVW9XrkG35M5L3NyYs7xqEcpn3NQCcUfPLjJQfP
         lnj176J4xJafXm9D876G3bqYvpgc4Y3/E5L7QLSZs9FkXds293pVfmqmxVPzVqGn6/NN
         CgKg==
X-Gm-Message-State: AO0yUKXyWMrdqb/ojh4DKTVcxn5me5vrGHD8+Q23YQIL5Oqw7oFFCGhS
        3t4WfWQRVxgPkYkzk+gZvaDadQ==
X-Google-Smtp-Source: AK7set+DhSpnXnr9I8EDcOc3nQqFLUuF9k/Txcs+BH+Z+yUwfbbNUk8TN5SUvxdNTY58WT65NosnFw==
X-Received: by 2002:ac2:46c9:0:b0:4db:1bee:c with SMTP id p9-20020ac246c9000000b004db1bee000cmr4952816lfo.44.1678311339444;
        Wed, 08 Mar 2023 13:35:39 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id u7-20020ac243c7000000b004dc4d26c324sm2467479lfl.143.2023.03.08.13.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 13:35:38 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 08 Mar 2023 22:35:18 +0100
Subject: [PATCH RFT v2 02/14] clk: qcom: smd-rpm: Add .is_enabled hook
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-rpmcc_sleep-v2-2-ae80a325fe94@linaro.org>
References: <20230303-topic-rpmcc_sleep-v2-0-ae80a325fe94@linaro.org>
In-Reply-To: <20230303-topic-rpmcc_sleep-v2-0-ae80a325fe94@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678311334; l=1448;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=DkAvY529UR+RwkQzY1FO48/jck/x44pR7ssps7xiA3g=;
 b=bMTX86MhRue6/CH4CAoR6mX0UhkJTn6HwQaKXt995jwdXJIOSTvZ4jiIt70kDOEqeCI115aI/A1n
 ZdtbcESyAwGjcxMnj2Cdm9vW5rThMJ5JfMdD6oFC26GRd42RhZeu
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shawn Guo <shawn.guo@linaro.org>

The RPM clock enabling state can be found with 'enabled' in struct
clk_smd_rpm.  Add .is_enabled hook so that clk_summary in debugfs can
show a correct enabling state for RPM clocks.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
[Konrad: rebase]
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/clk-smd-rpm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index 198886c1b6c8..ecacfbc4a16c 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -424,18 +424,27 @@ static int clk_smd_rpm_enable_scaling(struct qcom_smd_rpm *rpm)
 	return 0;
 }
 
+static int clk_smd_rpm_is_enabled(struct clk_hw *hw)
+{
+	struct clk_smd_rpm *r = to_clk_smd_rpm(hw);
+
+	return r->enabled;
+}
+
 static const struct clk_ops clk_smd_rpm_ops = {
 	.prepare	= clk_smd_rpm_prepare,
 	.unprepare	= clk_smd_rpm_unprepare,
 	.set_rate	= clk_smd_rpm_set_rate,
 	.round_rate	= clk_smd_rpm_round_rate,
 	.recalc_rate	= clk_smd_rpm_recalc_rate,
+	.is_enabled	= clk_smd_rpm_is_enabled,
 };
 
 static const struct clk_ops clk_smd_rpm_branch_ops = {
 	.prepare	= clk_smd_rpm_prepare,
 	.unprepare	= clk_smd_rpm_unprepare,
 	.recalc_rate	= clk_smd_rpm_recalc_rate,
+	.is_enabled	= clk_smd_rpm_is_enabled,
 };
 
 DEFINE_CLK_SMD_RPM_BRANCH_A(bi_tcxo, QCOM_SMD_RPM_MISC_CLK, 0, 19200000);

-- 
2.39.2

