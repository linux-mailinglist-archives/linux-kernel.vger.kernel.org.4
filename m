Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FC56CBE4D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbjC1MAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbjC1MAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:00:20 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D1283EC;
        Tue, 28 Mar 2023 05:00:07 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SB2Ken007147;
        Tue, 28 Mar 2023 12:00:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=qllw3QjSzdXhdCLmRWBTk2zYlUIAlefYkCKCwtvtJxg=;
 b=JQS3EIpdMMVYyzN7y80SmEUBHCHFZmI8EKKRR6j5ibPAfN/JGcAjdvtF4+qc0wkBvTaW
 H8SF9vdod5F+nWbPNq0LURZYmGG3k7iNjxPnK2qelU/4+suT9Hfr3Jh87PMbRV8hVAdl
 bmJuegGKQX+6fBwfzT+4Ab4uri92818RIy+X2CdeWkZq0+rRQaSVOEV3MY2Xv8JfSkoo
 nOiv3wl1zXcA9Wu2/iNGP1yXSMuojt6dIiYuzFBzjkNvmdhTJcYGHiLayUw7JRvUSHna
 oMgvxOXBh7njpIdfl2qURM6v4x6a9qgkyFdAIhU/kdOlF7vL/qSS4eEv7szREKvpS8oi 5Q== 
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pky0x86r9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 11:59:59 +0000
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32SBxucu029462;
        Tue, 28 Mar 2023 11:59:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 3pht1kf50n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 28 Mar 2023 11:59:56 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32SBxuwa029457;
        Tue, 28 Mar 2023 11:59:56 GMT
Received: from minghao-gv.ap.qualcomm.com (minghao-gv.qualcomm.com [10.231.253.196])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 32SBxtNR029456;
        Tue, 28 Mar 2023 11:59:56 +0000
Received: by minghao-gv.ap.qualcomm.com (Postfix, from userid 2359059)
        id BF7011F6FE; Tue, 28 Mar 2023 19:59:54 +0800 (CST)
From:   Minghao Zhang <quic_minghao@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, linus.walleij@linaro.or
Cc:     Minghao Zhang <quic_minghao@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_satyap@quicinc.com,
        quic_tsoni@quicinc.com
Subject: [PATCH] pinctrl: qcom: Add support to log pin status before suspend for TLMM
Date:   Tue, 28 Mar 2023 19:59:51 +0800
Message-Id: <1680004791-4216-1-git-send-email-quic_minghao@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zJ79Emvkn7RZoJzBmvKNZrKswhrlLFBO
X-Proofpoint-ORIG-GUID: zJ79Emvkn7RZoJzBmvKNZrKswhrlLFBO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=828
 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303280096
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
 drivers/pinctrl/qcom/pinctrl-msm.c | 133 +++++++++++++++++++++++++++++--------
 drivers/pinctrl/qcom/pinctrl-msm.h |   1 +
 2 files changed, 105 insertions(+), 29 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index daeb79a..872c49f 100644
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
@@ -628,6 +643,29 @@ static void msm_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
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
@@ -644,40 +682,13 @@ static void msm_gpio_dbg_show_one(struct seq_file *s,
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
@@ -707,6 +718,39 @@ static void msm_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
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
+	printk_deferred("%s: %s, %s, func%d, %dmA, %s\n",
+			g->name, is_out ? "out" : "in",
+			val ? "high" : "low", func,
+			msm_regval_to_drive(drive),
+			pctrl->soc->pull_no_keeper ? pulls_no_keeper[pull] : pulls_keeper[pull]);
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
@@ -1450,6 +1494,35 @@ SIMPLE_DEV_PM_OPS(msm_pinctrl_dev_pm_ops, msm_pinctrl_suspend,
 
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
+		printk_deferred("%s\n", pctrl->chip.label);
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
@@ -1512,6 +1585,8 @@ int msm_pinctrl_probe(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
+	pinctrl_msm_log_mask = false;
+
 	platform_set_drvdata(pdev, pctrl);
 
 	dev_dbg(&pdev->dev, "Probed Qualcomm pinctrl driver\n");
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
index 985eced..8ccbb6d 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.h
+++ b/drivers/pinctrl/qcom/pinctrl-msm.h
@@ -155,6 +155,7 @@ struct msm_pinctrl_soc_data {
 };
 
 extern const struct dev_pm_ops msm_pinctrl_dev_pm_ops;
+extern const struct dev_pm_ops noirq_msm_pinctrl_dev_pm_ops;
 
 int msm_pinctrl_probe(struct platform_device *pdev,
 		      const struct msm_pinctrl_soc_data *soc_data);
-- 
2.7.4

