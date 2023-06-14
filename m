Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4AB721514
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 08:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjFDGQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 02:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjFDGQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 02:16:44 -0400
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [IPv6:2a01:4f8:a0:821d::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8240FD;
        Sat,  3 Jun 2023 23:16:42 -0700 (PDT)
Received: from localhost.localdomain (unknown [77.239.252.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id B5B7D1407DD;
        Sun,  4 Jun 2023 06:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1685859401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T8jpqaxDLqQtOX66/9PpVei4now+MDnXbEkrIyxDJjc=;
        b=rS7UY/IU1tVUYfJAGPtuy9mQoowO1OmrG7gLgFZMeVWbMoR0jQ8PhsroCw//dpFBbDiiIq
        FaN/2sOovu9a60jQ+Ti5GWiloJUGikXtXZBI5q/2S7JgoC6pF6kOml0BjTSWdFYG7VWk8M
        Zjsmet6KFkeKowQYN0O7KIIqGv1+HW4=
From:   Alexey Minnekhanov <alexeymin@postmarketos.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Alexey Minnekhanov <alexeymin@postmarketos.org>,
        Konrad Dybcio <konradybcio@gmail.com>
Subject: [PATCH 2/3] remoteproc: qcom: q6v5-mss: Add support for SDM630/636/660
Date:   Sun,  4 Jun 2023 09:14:20 +0300
Message-Id: <20230604061421.3787649-2-alexeymin@postmarketos.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230604061421.3787649-1-alexeymin@postmarketos.org>
References: <20230604061421.3787649-1-alexeymin@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Snapdragon 630/660 modem subsystem is similar to one in MSM8998
and can almost reuse it's reset sequence.

Downstream sources call this q6v5 version "qdsp6v62-1-5" and its
code path has additional checks for QDSP6v55_BHS_EN_REST_ACK
status [2].

Inspiration is taken from Konrad Dybcio's work in [1], but reworked
to use common code path with MSM8996/8998, instead of completely
separate "if" block for SDM660.

[1] https://github.com/SoMainline/linux/commit/7dd6dd9b936dc8d6c1f1abe299e5b065c33741e8
[2] https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/lavender-q-oss/drivers/soc/qcom/pil-q6v5.c#L393

Co-developed-by: Konrad Dybcio <konradybcio@gmail.com>
Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
Signed-off-by: Alexey Minnekhanov <alexeymin@postmarketos.org>

---

In his commit Konrad mentions that modem was unstable, but I don't
observe such behaviour on my device. Modem does not restart by itself,
and I could successfully enable ath10k Wi-Fi with this (and it was
also stable).

Also worth saying that in my initial tests just using qcom,msm8998-mss-pil
as-is, without separate resource struct and separate code paths for
SDM660, was also working fine. So I'm not sure if separate struct and
code path is even needed for sdm660.
---
 drivers/remoteproc/qcom_q6v5_mss.c | 54 ++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 8e15e4f85de13..e270fc4798766 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -71,6 +71,7 @@
 #define QDSP6SS_MEM_PWR_CTL		0x0B0
 #define QDSP6V6SS_MEM_PWR_CTL		0x034
 #define QDSP6SS_STRAP_ACC		0x110
+#define QDSP6V62SS_BHS_STATUS		0x0C4
 
 /* AXI Halt Register Offsets */
 #define AXI_HALTREQ_REG			0x0
@@ -123,6 +124,7 @@
 #define QDSP6v56_CLAMP_QMC_MEM		BIT(22)
 #define QDSP6SS_XO_CBCR		0x0038
 #define QDSP6SS_ACC_OVERRIDE_VAL		0x20
+#define QDSP6v55_BHS_EN_REST_ACK	BIT(0)
 
 /* QDSP6v65 parameters */
 #define QDSP6SS_CORE_CBCR		0x20
@@ -130,6 +132,7 @@
 #define QDSP6SS_BOOT_CORE_START         0x400
 #define QDSP6SS_BOOT_CMD                0x404
 #define BOOT_FSM_TIMEOUT                10000
+#define BHS_CHECK_MAX_LOOPS             200
 
 struct reg_info {
 	struct regulator *reg;
@@ -250,6 +253,7 @@ enum {
 	MSS_MSM8998,
 	MSS_SC7180,
 	MSS_SC7280,
+	MSS_SDM660,
 	MSS_SDM845,
 };
 
@@ -700,7 +704,8 @@ static int q6v5proc_reset(struct q6v5 *qproc)
 	} else if (qproc->version == MSS_MSM8909 ||
 		   qproc->version == MSS_MSM8953 ||
 		   qproc->version == MSS_MSM8996 ||
-		   qproc->version == MSS_MSM8998) {
+		   qproc->version == MSS_MSM8998 ||
+		   qproc->version == MSS_SDM660) {
 
 		if (qproc->version != MSS_MSM8909 &&
 		    qproc->version != MSS_MSM8953)
@@ -734,6 +739,19 @@ static int q6v5proc_reset(struct q6v5 *qproc)
 		val |= readl(qproc->reg_base + QDSP6SS_PWR_CTL_REG);
 		udelay(1);
 
+		if (qproc->version == MSS_SDM660) {
+			for (i = BHS_CHECK_MAX_LOOPS; i > 0; i--) {
+				if (readl_relaxed(qproc->reg_base + QDSP6V62SS_BHS_STATUS)
+					& QDSP6v55_BHS_EN_REST_ACK)
+					break;
+				udelay(1);
+			}
+			if (!i) {
+				dev_err(qproc->dev, "BHS_EN_REST_ACK not set!\n");
+				return -ETIMEDOUT;
+			}
+		}
+
 		/* Put LDO in bypass mode */
 		val |= QDSP6v56_LDO_BYP;
 		writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
@@ -756,7 +774,7 @@ static int q6v5proc_reset(struct q6v5 *qproc)
 				mem_pwr_ctl = QDSP6SS_MEM_PWR_CTL;
 				i = 19;
 			} else {
-				/* MSS_MSM8998 */
+				/* MSS_MSM8998, MSS_SDM660 */
 				mem_pwr_ctl = QDSP6V6SS_MEM_PWR_CTL;
 				i = 28;
 			}
@@ -2193,6 +2211,37 @@ static const struct rproc_hexagon_res sc7280_mss = {
 	.version = MSS_SC7280,
 };
 
+static const struct rproc_hexagon_res sdm660_mss = {
+	.hexagon_mba_image = "mba.mbn",
+	.proxy_clk_names = (char*[]){
+			"xo",
+			"qdss",
+			"mem",
+			NULL
+	},
+	.active_clk_names = (char*[]){
+			"iface",
+			"bus",
+			"gpll0_mss",
+			"mnoc_axi",
+			"snoc_axi",
+			NULL
+	},
+	.proxy_pd_names = (char*[]){
+			"cx",
+			"mx",
+			NULL
+	},
+	.need_mem_protection = true,
+	.has_alt_reset = false,
+	.has_mba_logs = false,
+	.has_spare_reg = false,
+	.has_qaccept_regs = false,
+	.has_ext_cntl_regs = false,
+	.has_vq6 = false,
+	.version = MSS_SDM660,
+};
+
 static const struct rproc_hexagon_res sdm845_mss = {
 	.hexagon_mba_image = "mba.mbn",
 	.proxy_clk_names = (char*[]){
@@ -2475,6 +2524,7 @@ static const struct of_device_id q6v5_of_match[] = {
 	{ .compatible = "qcom,msm8998-mss-pil", .data = &msm8998_mss},
 	{ .compatible = "qcom,sc7180-mss-pil", .data = &sc7180_mss},
 	{ .compatible = "qcom,sc7280-mss-pil", .data = &sc7280_mss},
+	{ .compatible = "qcom,sdm660-mss-pil", .data = &sdm660_mss},
 	{ .compatible = "qcom,sdm845-mss-pil", .data = &sdm845_mss},
 	{ },
 };
-- 
2.39.3

