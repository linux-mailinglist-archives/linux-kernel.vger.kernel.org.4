Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AAF668495
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 21:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240346AbjALUyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 15:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbjALUwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:52:55 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447BD12767;
        Thu, 12 Jan 2023 12:26:39 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b3so30102957lfv.2;
        Thu, 12 Jan 2023 12:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJCpyBbrHQkjpmMb4tYSA1N8+xnQnzEWycA9Mz5viu8=;
        b=B8Fsq7wp1ePtnRbS3DgVbJQtNEHM70J0Fod7oWEw+9JClEt1Px+YJ66uERjuHVP0nh
         T4deO8UTUJ/zyCRJtkLPiMPW11T4YYawa48yPxzk8e6qtLs8xsiHGHP7KmGL3VgC4nGt
         vi2CyzKvNZlIUPqrFd+bz61Z3Id4ew0mb9Gja1QLHIDlbVJtWhB4VIXXpi83DwDkxUXH
         NbHbDNWgWu4E0XqGtmX2UZrgLW6XnjZJ3Yfmqtf16HC5RIafTLa3YXL/Xod0Uw2yp6Q0
         kkx/2GuPF3e7uh/H0GU8oPDrMRDCM/bGPwL6Vvkm/takGTQ9RU0BLV9DFIkmcR6l4kLU
         qaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJCpyBbrHQkjpmMb4tYSA1N8+xnQnzEWycA9Mz5viu8=;
        b=gdUyEdBIQMWVrgactMkQiiuH6XGPO+G0Sr5dGw+/Gm5ZGU6A6KoXnP3aKgNh08CIiZ
         vOXce1Cml1yMN2SeqCXE7CJMExFRqDg1tn/bZr5SxFOlvI7Te4xLpyv+Rs0tPldOLjQY
         IyF3unnHAZjiZ601yHc0CWcoBtxGz1XSk2pNwhjG2jmXB/eZEL8SDk6Ghs52InU94be0
         RLAWkytnga0yAJxAd0TwRzCqdzP8/hprRLm/505owl6xLFAEsXcJ/LwEMt+8e7EnqtC/
         ctY2q5U15Ue4PrGt5k0O5A4FDlZLZo16YO/vs0RGORQZKf8YX8z0qLOIEJ+cEnn0NbIp
         /CFA==
X-Gm-Message-State: AFqh2kot8+YFVUSEHY6KHR0LLN6WYuApEa8A5Z8qGswbtUmxQjcaDWuU
        ghIhcqXjWqcUD1RE1kehwWMzgpJTwCrM1Q==
X-Google-Smtp-Source: AMrXdXuJ+YeGNHyW4gFcD7sEpMpnIgJGzNqHRdBoZidR3Jf6ePGYhrVcd6kvF/kpT5NMKYQ04eEZpg==
X-Received: by 2002:ac2:4f13:0:b0:4b6:f3b3:fe14 with SMTP id k19-20020ac24f13000000b004b6f3b3fe14mr21224419lfr.1.1673555197512;
        Thu, 12 Jan 2023 12:26:37 -0800 (PST)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id k6-20020a2eb746000000b00281350bb5fbsm2346731ljo.2.2023.01.12.12.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 12:26:37 -0800 (PST)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] remoteproc: qcom_q6v5_mss: Add modem support on MSM8226
Date:   Thu, 12 Jan 2023 22:26:06 +0200
Message-Id: <20230112202612.791455-4-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230112202612.791455-1-matti.lehtimaki@gmail.com>
References: <20230112202612.791455-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Weiss <luca@z3ntu.xyz>

Add support for the external power block headswitch register needed by
MSM8226 and some other qcom platforms.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Co-developed-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 123 +++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 745627a36bcf..0dff7e811736 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -131,6 +131,11 @@
 #define QDSP6SS_BOOT_CMD                0x404
 #define BOOT_FSM_TIMEOUT                10000
 
+/* External power block headswitch */
+#define EXTERNAL_BHS_ON			BIT(0)
+#define EXTERNAL_BHS_STATUS		BIT(4)
+#define EXTERNAL_BHS_TIMEOUT_US		50
+
 struct reg_info {
 	struct regulator *reg;
 	int uV;
@@ -158,6 +163,7 @@ struct rproc_hexagon_res {
 	bool has_mba_logs;
 	bool has_spare_reg;
 	bool has_qaccept_regs;
+	bool has_ext_bhs_reg;
 	bool has_ext_cntl_regs;
 	bool has_vq6;
 };
@@ -177,6 +183,7 @@ struct q6v5 {
 	u32 halt_nc;
 	u32 halt_vq6;
 	u32 conn_box;
+	u32 ext_bhs;
 
 	u32 qaccept_mdm;
 	u32 qaccept_cx;
@@ -230,6 +237,7 @@ struct q6v5 {
 	bool has_mba_logs;
 	bool has_spare_reg;
 	bool has_qaccept_regs;
+	bool has_ext_bhs_reg;
 	bool has_ext_cntl_regs;
 	bool has_vq6;
 	int mpss_perm;
@@ -239,6 +247,7 @@ struct q6v5 {
 };
 
 enum {
+	MSS_MSM8226,
 	MSS_MSM8909,
 	MSS_MSM8916,
 	MSS_MSM8953,
@@ -1738,6 +1747,23 @@ static int q6v5_init_mem(struct q6v5 *qproc, struct platform_device *pdev)
 		qproc->qaccept_axi = args.args[2];
 	}
 
+	if (qproc->has_ext_bhs_reg) {
+		ret = of_parse_phandle_with_fixed_args(pdev->dev.of_node,
+						       "qcom,ext-bhs-reg",
+						       1, 0, &args);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "failed to parse ext-bhs-reg index 0\n");
+			return -EINVAL;
+		}
+
+		qproc->conn_map = syscon_node_to_regmap(args.np);
+		of_node_put(args.np);
+		if (IS_ERR(qproc->conn_map))
+			return PTR_ERR(qproc->conn_map);
+
+		qproc->ext_bhs = args.args[0];
+	}
+
 	if (qproc->has_ext_cntl_regs) {
 		ret = of_parse_phandle_with_fixed_args(pdev->dev.of_node,
 						       "qcom,ext-regs",
@@ -1863,6 +1889,36 @@ static void q6v5_pds_detach(struct q6v5 *qproc, struct device **pds,
 		dev_pm_domain_detach(pds[i], false);
 }
 
+static int q6v5_external_bhs_enable(struct q6v5 *qproc)
+{
+	u32 val;
+	int ret = 0;
+
+	/*
+	 * Enable external power block headswitch and wait for it to
+	 * stabilize
+	 */
+	regmap_update_bits(qproc->conn_map, qproc->ext_bhs,
+			   EXTERNAL_BHS_ON, 1);
+
+	ret = regmap_read_poll_timeout(qproc->conn_map, qproc->ext_bhs,
+				       val, val & EXTERNAL_BHS_STATUS,
+				       1, EXTERNAL_BHS_TIMEOUT_US);
+
+	if (ret) {
+		dev_err(qproc->dev, "External BHS timed out\n");
+		ret = -ETIMEDOUT;
+	}
+
+	return ret;
+}
+
+static void q6v5_external_bhs_disable(struct q6v5 *qproc)
+{
+	regmap_update_bits(qproc->conn_map, qproc->ext_bhs,
+			   EXTERNAL_BHS_ON, 0);
+}
+
 static int q6v5_init_reset(struct q6v5 *qproc)
 {
 	qproc->mss_restart = devm_reset_control_get_exclusive(qproc->dev,
@@ -1984,6 +2040,7 @@ static int q6v5_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, qproc);
 
 	qproc->has_qaccept_regs = desc->has_qaccept_regs;
+	qproc->has_ext_bhs_reg = desc->has_ext_bhs_reg;
 	qproc->has_ext_cntl_regs = desc->has_ext_cntl_regs;
 	qproc->has_vq6 = desc->has_vq6;
 	qproc->has_spare_reg = desc->has_spare_reg;
@@ -2054,6 +2111,14 @@ static int q6v5_probe(struct platform_device *pdev)
 		qproc->proxy_pd_count = ret;
 	}
 
+	if (qproc->has_ext_bhs_reg) {
+		ret = q6v5_external_bhs_enable(qproc);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "Failed to enable external BHS.\n");
+			goto detach_proxy_pds;
+		}
+	}
+
 	qproc->has_alt_reset = desc->has_alt_reset;
 	ret = q6v5_init_reset(qproc);
 	if (ret)
@@ -2118,6 +2183,9 @@ static int q6v5_remove(struct platform_device *pdev)
 	qcom_remove_smd_subdev(rproc, &qproc->smd_subdev);
 	qcom_remove_glink_subdev(rproc, &qproc->glink_subdev);
 
+	if (qproc->has_ext_bhs_reg)
+		q6v5_external_bhs_disable(qproc);
+
 	q6v5_pds_detach(qproc, qproc->proxy_pds, qproc->proxy_pd_count);
 
 	rproc_free(rproc);
@@ -2153,6 +2221,7 @@ static const struct rproc_hexagon_res sc7180_mss = {
 	.has_mba_logs = true,
 	.has_spare_reg = true,
 	.has_qaccept_regs = false,
+	.has_ext_bhs_reg = false,
 	.has_ext_cntl_regs = false,
 	.has_vq6 = false,
 	.version = MSS_SC7180,
@@ -2181,6 +2250,7 @@ static const struct rproc_hexagon_res sc7280_mss = {
 	.has_mba_logs = true,
 	.has_spare_reg = false,
 	.has_qaccept_regs = true,
+	.has_ext_bhs_reg = false,
 	.has_ext_cntl_regs = true,
 	.has_vq6 = true,
 	.version = MSS_SC7280,
@@ -2216,6 +2286,7 @@ static const struct rproc_hexagon_res sdm845_mss = {
 	.has_mba_logs = false,
 	.has_spare_reg = false,
 	.has_qaccept_regs = false,
+	.has_ext_bhs_reg = false,
 	.has_ext_cntl_regs = false,
 	.has_vq6 = false,
 	.version = MSS_SDM845,
@@ -2247,6 +2318,7 @@ static const struct rproc_hexagon_res msm8998_mss = {
 	.has_mba_logs = false,
 	.has_spare_reg = false,
 	.has_qaccept_regs = false,
+	.has_ext_bhs_reg = false,
 	.has_ext_cntl_regs = false,
 	.has_vq6 = false,
 	.version = MSS_MSM8998,
@@ -2286,6 +2358,7 @@ static const struct rproc_hexagon_res msm8996_mss = {
 	.has_mba_logs = false,
 	.has_spare_reg = false,
 	.has_qaccept_regs = false,
+	.has_ext_bhs_reg = false,
 	.has_ext_cntl_regs = false,
 	.has_vq6 = false,
 	.version = MSS_MSM8996,
@@ -2320,6 +2393,7 @@ static const struct rproc_hexagon_res msm8909_mss = {
 	.has_mba_logs = false,
 	.has_spare_reg = false,
 	.has_qaccept_regs = false,
+	.has_ext_bhs_reg = false,
 	.has_ext_cntl_regs = false,
 	.has_vq6 = false,
 	.version = MSS_MSM8909,
@@ -2365,6 +2439,7 @@ static const struct rproc_hexagon_res msm8916_mss = {
 	.has_mba_logs = false,
 	.has_spare_reg = false,
 	.has_qaccept_regs = false,
+	.has_ext_bhs_reg = false,
 	.has_ext_cntl_regs = false,
 	.has_vq6 = false,
 	.version = MSS_MSM8916,
@@ -2400,6 +2475,7 @@ static const struct rproc_hexagon_res msm8953_mss = {
 	.has_mba_logs = false,
 	.has_spare_reg = false,
 	.has_qaccept_regs = false,
+	.has_ext_bhs_reg = false,
 	.has_ext_cntl_regs = false,
 	.has_vq6 = false,
 	.version = MSS_MSM8953,
@@ -2453,13 +2529,60 @@ static const struct rproc_hexagon_res msm8974_mss = {
 	.has_mba_logs = false,
 	.has_spare_reg = false,
 	.has_qaccept_regs = false,
+	.has_ext_bhs_reg = false,
 	.has_ext_cntl_regs = false,
 	.has_vq6 = false,
 	.version = MSS_MSM8974,
 };
 
+static const struct rproc_hexagon_res msm8226_mss = {
+	.hexagon_mba_image = "mba.b00",
+	.proxy_supply = (struct qcom_mss_reg_res[]) {
+		{
+			.supply = "pll",
+			.uA = 100000,
+		},
+		{
+			.supply = "mx",
+			.uV = 1050000,
+		},
+		{}
+	},
+	.fallback_proxy_supply = (struct qcom_mss_reg_res[]) {
+		{
+			.supply = "cx",
+			.uA = 100000,
+		},
+		{}
+	},
+	.proxy_clk_names = (char*[]){
+		"xo",
+		NULL
+	},
+	.active_clk_names = (char*[]){
+		"iface",
+		"bus",
+		"mem",
+		NULL
+	},
+	.proxy_pd_names = (char*[]){
+		"cx",
+		NULL
+	},
+	.need_mem_protection = false,
+	.has_alt_reset = false,
+	.has_mba_logs = false,
+	.has_spare_reg = false,
+	.has_qaccept_regs = false,
+	.has_ext_bhs_reg = true,
+	.has_ext_cntl_regs = false,
+	.has_vq6 = false,
+	.version = MSS_MSM8226,
+};
+
 static const struct of_device_id q6v5_of_match[] = {
 	{ .compatible = "qcom,q6v5-pil", .data = &msm8916_mss},
+	{ .compatible = "qcom,msm8226-mss-pil", .data = &msm8226_mss},
 	{ .compatible = "qcom,msm8909-mss-pil", .data = &msm8909_mss},
 	{ .compatible = "qcom,msm8916-mss-pil", .data = &msm8916_mss},
 	{ .compatible = "qcom,msm8953-mss-pil", .data = &msm8953_mss},
-- 
2.34.1

