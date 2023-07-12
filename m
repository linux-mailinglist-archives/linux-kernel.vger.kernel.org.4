Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FE775052A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbjGLKwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 06:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbjGLKwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:52:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A324C10C7;
        Wed, 12 Jul 2023 03:52:39 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36C8cnfx003815;
        Wed, 12 Jul 2023 10:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=9kopEKy0CzwxpGm86TYpnrg0eSGrBkWZlaQuOJ20tVI=;
 b=W9gX/VxAwxjHpXSOHzwq5KSifC1yoeLSwDCOzUHpLESMZaDwEtJX3UTQRoET25ToLFKt
 w7rWDpTRqzs5YH7Lbobockc+F0LjURWOo8Gx9lJbGABLc4ACUHRBdBf8SNK57yCy/+QG
 1uFG3VYvAsSwbe7/Z/zFBxcGaFu1ePbKDDzKTF96j+ztmJYbo7Yj0yP01+Nw0qg1H779
 2IolO55mN4jEMrMBL6aDkcrfFWkh4ZemIWFXs/vFhWFHkz7BUtHC6sNfQ96ZMrI+FGcQ
 vTEgTwAUEEwjEBFs1KAtDc+uouATzhLhCqCv+fioNcJ9dhIEJvTpqTb7pyo/+CL6xPLK MQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rsgar93av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 10:52:32 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36CAqSwC012097
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 10:52:28 GMT
Received: from ipa-build-02.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 12 Jul 2023 03:52:26 -0700
From:   Minghao Zhang <quic_minghao@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@somainline.org>, <linus.walleij@linaro.org>
CC:     Minghao Zhang <quic_minghao@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_satyap@quicinc.com>,
        <quic_tsoni@quicinc.com>
Subject: [PATCH V3] pinctrl: qcom: Add support to log pin status before suspend for TLMM
Date:   Wed, 12 Jul 2023 18:52:00 +0800
Message-ID: <20230712105200.26012-1-quic_minghao@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4459JJjMDKUGGWmlEsARCryLzwQY7sKr
X-Proofpoint-ORIG-GUID: 4459JJjMDKUGGWmlEsARCryLzwQY7sKr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_06,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=880 spamscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 clxscore=1011 adultscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120096
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index 2585ef2b2793..ed1c5b2817aa 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -82,6 +82,21 @@ struct msm_pinctrl {
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
@@ -653,6 +668,29 @@ static void msm_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
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
@@ -669,40 +707,13 @@ static void msm_gpio_dbg_show_one(struct seq_file *s,
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
 		seq_printf(s, " %-8s: egpio\n", g->grp.name);
@@ -732,6 +743,39 @@ static void msm_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
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
+		g->grp.name, is_out ? "out" : "in",
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
@@ -1475,6 +1519,35 @@ SIMPLE_DEV_PM_OPS(msm_pinctrl_dev_pm_ops, msm_pinctrl_suspend,
 
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
@@ -1536,6 +1609,8 @@ int msm_pinctrl_probe(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
+	pinctrl_msm_log_mask = false;
+
 	platform_set_drvdata(pdev, pctrl);
 
 	dev_dbg(&pdev->dev, "Probed Qualcomm pinctrl driver\n");
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
index 5e4410bed823..60e0257dafbf 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.h
+++ b/drivers/pinctrl/qcom/pinctrl-msm.h
@@ -161,6 +161,10 @@ struct msm_pinctrl_soc_data {
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

