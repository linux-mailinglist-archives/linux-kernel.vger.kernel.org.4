Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D64171F8FA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 05:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbjFBDc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 23:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjFBDcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 23:32:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCB8107;
        Thu,  1 Jun 2023 20:32:21 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3523RLGS010375;
        Fri, 2 Jun 2023 03:32:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=8Fr9E41LV4XYbsh2GbgkeOokUoanLTDOkI7MomT0vNU=;
 b=NegNc5DpxMr0QtCrm2mTlzyyiRYC3Dwqi2AbXCXhZ1WqP0+Lmfts+KMskup3sYQUZaQM
 XAcnmtINS/MLBhS8c6VIjLmctCkZIsPa5YrIwIsP25xYcS4AGkibNWKbPz496G+argoJ
 xIRDQ2P4GAApksvGTW1Lguu45zF8fDmFMUFK4U8yiWc1UURPR5z9+gmSxCsS3eI66+I0
 o9sB1JtgaBxkKKYBYP/GwtKaWduEWhTJSAF8fTFYOzbZghvWhE+WWfOaAaz6hKPDdbnb
 9GFadXtGLOdlNb6OYHp6C2diZeBQGKimkBlX0S2GcQApsbLPA5KKgDWzfdhTkTzzXBQd ow== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxugr9p3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 03:32:15 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3523WE2d016825
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Jun 2023 03:32:14 GMT
Received: from ipa-build-02.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 1 Jun 2023 20:32:11 -0700
From:   Minghao Zhang <quic_minghao@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@somainline.org>, <linus.walleij@linaro.org>
CC:     Minghao Zhang <quic_minghao@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_satyap@quicinc.com>,
        <quic_tsoni@quicinc.com>
Subject: [PATCH v2] pinctrl: qcom: Add support to log pin status before suspend for TLMM
Date:   Fri, 2 Jun 2023 11:31:46 +0800
Message-ID: <20230602033146.46387-1-quic_minghao@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UYInF-gqJwn7E7KD2dGbkb_DP5JC-chx
X-Proofpoint-ORIG-GUID: UYInF-gqJwn7E7KD2dGbkb_DP5JC-chx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_01,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=979 phishscore=0
 bulkscore=0 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2306020024
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change supports to print pin status before device suspend
to debug for TLMM. And expose 2 APIs to enable/disable this
functionality.

Signed-off-by: Minghao Zhang <quic_minghao@quicinc.com>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 133 ++++++++++++++++++++++-------
 drivers/pinctrl/qcom/pinctrl-msm.h |   4 +
 2 files changed, 108 insertions(+), 29 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index c5f52d4f7781..fbc379c82e4f 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -83,6 +83,21 @@ struct msm_pinctrl {
 	u32 phys_base[MAX_NR_TILES];
 };
 
+static bool pinctrl_msm_log_mask;
+
+static const char * const pulls_keeper[] = {
+	"no pull",
+	"pull down",
+	"keeper",
+	"pull up"
+};
+
+static const char * const pulls_no_keeper[] = {
+	"no pull",
+	"pull down",
+	"pull up",
+};
+
 #define MSM_ACCESSOR(name) \
 static u32 msm_readl_##name(struct msm_pinctrl *pctrl, \
 			    const struct msm_pingroup *g) \
@@ -654,6 +669,29 @@ static void msm_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
+static void msm_gpio_pin_status_get(struct msm_pinctrl *pctrl, const struct msm_pingroup *g,
+				    unsigned int offset, int *is_out, unsigned int *func,
+				    int *drive, int *pull, int *egpio_enable, int *val)
+{
+	u32 ctl_reg, io_reg;
+
+	ctl_reg = msm_readl_ctl(pctrl, g);
+	io_reg = msm_readl_io(pctrl, g);
+
+	*is_out = !!(ctl_reg & BIT(g->oe_bit));
+	*func = (ctl_reg >> g->mux_bit) & 7;
+	*drive = (ctl_reg >> g->drv_bit) & 7;
+	*pull = (ctl_reg >> g->pull_bit) & 3;
+	*egpio_enable = 0;
+	if (pctrl->soc->egpio_func && ctl_reg & BIT(g->egpio_present))
+		*egpio_enable = !(ctl_reg & BIT(g->egpio_enable));
+
+	if (*is_out)
+		*val = !!(io_reg & BIT(g->out_bit));
+	else
+		*val = !!(io_reg & BIT(g->in_bit));
+}
+
 #ifdef CONFIG_DEBUG_FS
 
 static void msm_gpio_dbg_show_one(struct seq_file *s,
@@ -670,40 +708,13 @@ static void msm_gpio_dbg_show_one(struct seq_file *s,
 	int pull;
 	int val;
 	int egpio_enable;
-	u32 ctl_reg, io_reg;
-
-	static const char * const pulls_keeper[] = {
-		"no pull",
-		"pull down",
-		"keeper",
-		"pull up"
-	};
-
-	static const char * const pulls_no_keeper[] = {
-		"no pull",
-		"pull down",
-		"pull up",
-	};
 
 	if (!gpiochip_line_is_valid(chip, offset))
 		return;
 
 	g = &pctrl->soc->groups[offset];
-	ctl_reg = msm_readl_ctl(pctrl, g);
-	io_reg = msm_readl_io(pctrl, g);
-
-	is_out = !!(ctl_reg & BIT(g->oe_bit));
-	func = (ctl_reg >> g->mux_bit) & 7;
-	drive = (ctl_reg >> g->drv_bit) & 7;
-	pull = (ctl_reg >> g->pull_bit) & 3;
-	egpio_enable = 0;
-	if (pctrl->soc->egpio_func && ctl_reg & BIT(g->egpio_present))
-		egpio_enable = !(ctl_reg & BIT(g->egpio_enable));
-
-	if (is_out)
-		val = !!(io_reg & BIT(g->out_bit));
-	else
-		val = !!(io_reg & BIT(g->in_bit));
+	msm_gpio_pin_status_get(pctrl, g, offset, &is_out, &func,
+					&drive, &pull, &egpio_enable, &val);
 
 	if (egpio_enable) {
 		seq_printf(s, " %-8s: egpio\n", g->name);
@@ -733,6 +744,39 @@ static void msm_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 #define msm_gpio_dbg_show NULL
 #endif
 
+static void msm_gpio_log_pin_status(struct gpio_chip *chip, unsigned int offset)
+{
+	const struct msm_pingroup *g;
+	struct msm_pinctrl *pctrl = gpiochip_get_data(chip);
+	unsigned int func;
+	int is_out;
+	int drive;
+	int pull;
+	int val;
+	int egpio_enable;
+
+	if (!gpiochip_line_is_valid(chip, offset))
+		return;
+
+	g = &pctrl->soc->groups[offset];
+	msm_gpio_pin_status_get(pctrl, g, offset, &is_out, &func,
+					&drive, &pull, &egpio_enable, &val);
+
+	pr_debug("%s: %s, %s, func%d, %dmA, %s\n",
+		g->name, is_out ? "out" : "in",
+		val ? "high" : "low", func,
+		msm_regval_to_drive(drive),
+		pctrl->soc->pull_no_keeper ? pulls_no_keeper[pull] : pulls_keeper[pull]);
+}
+
+static void msm_gpios_status(struct gpio_chip *chip)
+{
+	unsigned int i;
+
+	for (i = 0; i < chip->ngpio; i++)
+		msm_gpio_log_pin_status(chip, i);
+}
+
 static int msm_gpio_init_valid_mask(struct gpio_chip *gc,
 				    unsigned long *valid_mask,
 				    unsigned int ngpios)
@@ -1476,6 +1520,35 @@ SIMPLE_DEV_PM_OPS(msm_pinctrl_dev_pm_ops, msm_pinctrl_suspend,
 
 EXPORT_SYMBOL(msm_pinctrl_dev_pm_ops);
 
+void debug_pintctrl_msm_enable(void)
+{
+	pinctrl_msm_log_mask = true;
+}
+EXPORT_SYMBOL(debug_pintctrl_msm_enable);
+
+void debug_pintctrl_msm_disable(void)
+{
+	pinctrl_msm_log_mask = false;
+}
+EXPORT_SYMBOL(debug_pintctrl_msm_disable);
+
+static __maybe_unused int noirq_msm_pinctrl_suspend(struct device *dev)
+{
+	struct msm_pinctrl *pctrl = dev_get_drvdata(dev);
+
+	if (pinctrl_msm_log_mask) {
+		pr_debug("%s\n", pctrl->chip.label);
+		msm_gpios_status(&pctrl->chip);
+	}
+
+	return 0;
+}
+
+const struct dev_pm_ops noirq_msm_pinctrl_dev_pm_ops = {
+	.suspend_noirq = noirq_msm_pinctrl_suspend,
+};
+EXPORT_SYMBOL(noirq_msm_pinctrl_dev_pm_ops);
+
 int msm_pinctrl_probe(struct platform_device *pdev,
 		      const struct msm_pinctrl_soc_data *soc_data)
 {
@@ -1537,6 +1610,8 @@ int msm_pinctrl_probe(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
+	pinctrl_msm_log_mask = false;
+
 	platform_set_drvdata(pdev, pctrl);
 
 	dev_dbg(&pdev->dev, "Probed Qualcomm pinctrl driver\n");
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
index 985eceda2517..faae8a28c8c6 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.h
+++ b/drivers/pinctrl/qcom/pinctrl-msm.h
@@ -155,6 +155,10 @@ struct msm_pinctrl_soc_data {
 };
 
 extern const struct dev_pm_ops msm_pinctrl_dev_pm_ops;
+extern const struct dev_pm_ops noirq_msm_pinctrl_dev_pm_ops;
+
+void debug_pintctrl_msm_enable(void);
+void debug_pintctrl_msm_disable(void);
 
 int msm_pinctrl_probe(struct platform_device *pdev,
 		      const struct msm_pinctrl_soc_data *soc_data);
-- 
2.17.1

