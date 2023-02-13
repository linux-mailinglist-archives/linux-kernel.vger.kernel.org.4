Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F2E694FF8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjBMSxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjBMSxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:53:25 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103EDD536;
        Mon, 13 Feb 2023 10:53:22 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DIqO2n022960;
        Mon, 13 Feb 2023 18:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=L7X4b9Rs6IsbLAWwUaBogsEHXCJDSbrORrVEXLlUz8U=;
 b=ZYK6L/bc4LCfpfyPfliqUYZ0CrJykr36cBSCwORvz3AR2BXkdejF8yumh5GsEJYkkJNS
 oWgBAXzH7Rhj57PY1gDobon/0ABoMPIOZ5v/TPpZc6MyFb/+ZFmv+4HMZMXovoLQaAKu
 Ssxw4jmmBmnPEhV/6TCHCWmUzSWmXznoX8YSNsH7IjGAOt8qCiX+bO2hWsRpHMnSCuM7
 +XbR5DmOpcqHFmziDPuNgcoeH5zVCTbGAXt4A5yM5/XjLneY6Cp6dkCA0netEDm2R+BC
 VRjlJy3OUvl8FHlxuAMqixQCFArErLaFSrvai0tIAi7ge/HXMlyNTUP0f0HwcCKlG153 iA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqtv0803a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 18:53:19 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31DIrIoH017813
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 18:53:18 GMT
Received: from hu-molvera-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 13 Feb 2023 10:53:17 -0800
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
CC:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
Subject: [PATCH 8/9] remoteproc: qcom_q6v5_pas: Add support to attach a DSP
Date:   Mon, 13 Feb 2023 10:52:17 -0800
Message-ID: <20230213185218.166520-9-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213185218.166520-1-quic_molvera@quicinc.com>
References: <20230213185218.166520-1-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WB42UDsyWb7It8hJognskUM5RRWuhHT0
X-Proofpoint-ORIG-GUID: WB42UDsyWb7It8hJognskUM5RRWuhHT0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_12,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 mlxlogscore=895 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130165
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some chipsets will have DSPs which will have begun running prior
to linux booting, so add support to late attach these DSPs by
adding support for:
- run-time checking of an offline or running DSP via rmb register
- a late attach framework to attach to the running DSP
- a handshake mechanism to ensure full and proper booting via rmb

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 103 ++++++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 1e14ae4d233a..7a1f0f898032 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -224,10 +224,89 @@ static int adsp_load(struct rproc *rproc, const struct firmware *fw)
 	return ret;
 }
 
+static int adsp_attach(struct rproc *rproc)
+{
+	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
+	int i, ret;
+
+	ret = qcom_q6v5_prepare(&adsp->q6v5);
+	if (ret)
+		return ret;
+
+	ret = adsp_pds_enable(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
+	if (ret < 0)
+		goto disable_irqs;
+
+	ret = clk_prepare_enable(adsp->xo);
+	if (ret)
+		goto disable_proxy_pds;
+
+	ret = clk_prepare_enable(adsp->aggre2_clk);
+	if (ret)
+		goto disable_xo_clk;
+
+	if (adsp->cx_supply) {
+		ret = regulator_enable(adsp->cx_supply);
+		if (ret)
+			goto disable_aggre2_clk;
+	}
+
+	if (adsp->px_supply) {
+		ret = regulator_enable(adsp->px_supply);
+		if (ret)
+			goto disable_cx_supply;
+	}
+
+	/* if needed, signal Q6 to continute booting */
+	if (adsp->q6v5.rmb_base) {
+		for (i = 0; i < RMB_POLL_MAX_TIMES; i++) {
+			if (readl_relaxed(adsp->q6v5.rmb_base + RMB_BOOT_WAIT_REG)) {
+				writel_relaxed(1, adsp->q6v5.rmb_base + RMB_BOOT_CONT_REG);
+				break;
+			}
+			msleep(20);
+		}
+
+		if (!readl_relaxed(adsp->q6v5.rmb_base + RMB_BOOT_WAIT_REG)) {
+			dev_err(adsp->dev, "Didn't get rmb signal from  %s\n", rproc->name);
+			goto disable_px_supply;
+		}
+	}
+
+	ret = qcom_q6v5_wait_for_start(&adsp->q6v5, msecs_to_jiffies(5000));
+	if (ret == -ETIMEDOUT) {
+		dev_err(adsp->dev, "start timed out\n");
+		qcom_scm_pas_shutdown(adsp->pas_id);
+		goto disable_px_supply;
+	}
+
+	return 0;
+
+disable_px_supply:
+	if (adsp->px_supply)
+		regulator_disable(adsp->px_supply);
+disable_cx_supply:
+	if (adsp->cx_supply)
+		regulator_disable(adsp->cx_supply);
+disable_aggre2_clk:
+	clk_disable_unprepare(adsp->aggre2_clk);
+disable_xo_clk:
+	clk_disable_unprepare(adsp->xo);
+disable_proxy_pds:
+	adsp_pds_disable(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
+disable_irqs:
+	qcom_q6v5_unprepare(&adsp->q6v5);
+
+	/* Remove pointer to the loaded firmware, only valid in adsp_load() & adsp_start() */
+	adsp->firmware = NULL;
+
+	return ret;
+}
+
 static int adsp_start(struct rproc *rproc)
 {
 	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
-	int ret;
+	int i, ret;
 
 	ret = qcom_q6v5_prepare(&adsp->q6v5);
 	if (ret)
@@ -286,6 +365,22 @@ static int adsp_start(struct rproc *rproc)
 		goto release_pas_metadata;
 	}
 
+	/* if needed, signal Q6 to continute booting */
+	if (adsp->q6v5.rmb_base) {
+		for (i = 0; i < RMB_POLL_MAX_TIMES; i++) {
+			if (readl_relaxed(adsp->q6v5.rmb_base + RMB_BOOT_WAIT_REG)) {
+				writel_relaxed(1, adsp->q6v5.rmb_base + RMB_BOOT_CONT_REG);
+				break;
+			}
+			msleep(20);
+		}
+
+		if (!readl_relaxed(adsp->q6v5.rmb_base + RMB_BOOT_WAIT_REG)) {
+			dev_err(adsp->dev, "Didn't get rmb signal from  %s\n", rproc->name);
+			goto release_pas_metadata;
+		}
+	}
+
 	ret = qcom_q6v5_wait_for_start(&adsp->q6v5, msecs_to_jiffies(5000));
 	if (ret == -ETIMEDOUT) {
 		dev_err(adsp->dev, "start timed out\n");
@@ -395,6 +490,7 @@ static unsigned long adsp_panic(struct rproc *rproc)
 static const struct rproc_ops adsp_ops = {
 	.unprepare = adsp_unprepare,
 	.start = adsp_start,
+	.attach = adsp_attach,
 	.stop = adsp_stop,
 	.da_to_va = adsp_da_to_va,
 	.parse_fw = qcom_register_dump_segments,
@@ -405,6 +501,7 @@ static const struct rproc_ops adsp_ops = {
 static const struct rproc_ops adsp_minidump_ops = {
 	.unprepare = adsp_unprepare,
 	.start = adsp_start,
+	.attach = adsp_attach,
 	.stop = adsp_stop,
 	.da_to_va = adsp_da_to_va,
 	.load = adsp_load,
@@ -710,6 +807,10 @@ static int adsp_probe(struct platform_device *pdev)
 	if (ret)
 		goto detach_proxy_pds;
 
+	if (adsp->q6v5.rmb_base &&
+			readl_relaxed(adsp->q6v5.rmb_base + RMB_Q6_BOOT_STATUS_REG))
+		rproc->state = RPROC_DETACHED;
+
 	qcom_add_glink_subdev(rproc, &adsp->glink_subdev, desc->ssr_name);
 	qcom_add_smd_subdev(rproc, &adsp->smd_subdev);
 	adsp->sysmon = qcom_add_sysmon_subdev(rproc,
-- 
2.25.1

