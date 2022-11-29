Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D634A63BFF3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 13:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbiK2MVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 07:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbiK2MVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:21:22 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB1B5D6B6;
        Tue, 29 Nov 2022 04:21:21 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATBSHlN026338;
        Tue, 29 Nov 2022 12:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=2EqvUAVPf+FzRjsgjfi56F7x2lfzdUmMxl5oDk1dNBk=;
 b=CiIwERXMRx9UsI2oOVqN697/hw2l4Ocnkd3z6xqpAfDV8nzbv6kh4St8zD4ngj+jTlDN
 i1pQ8OTUqrVFWYEE0yDNE/aCXSMwH6R0WLsa0RO5VqgSbDvYDvayIsjpUEACujAGFdSz
 uD/Z1B6qzmWrS21JhV0yHbpBoaBGJIac8WOFZ5BUujE4qnWvDJmeAhFOg+U9OZi7ku9+
 7qwBhk6wKQsFlAcMQaOAc7KOqLFgjovu7BxU+Uu4YVVG7CJ8d74hAgshIUAjQ4krvvKv
 efKh783I6WpatsyWdYEZ6UpLrfjGlWR5Jf5Qwbn+MBfNSo27Q78/+JzixCBWqZrgiJ/C dw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m5a7f99v8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 12:20:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2ATCKVbB014949
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 12:20:31 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 29 Nov 2022 04:20:26 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <devicetree@vger.kernel.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v2] ASoC: qcom: lpass-sc7280: Add system suspend/resume PM ops
Date:   Tue, 29 Nov 2022 17:50:11 +0530
Message-ID: <1669724411-14840-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: m2ccWSyh_Wr8E-9VPMqyMATY_0uSkLL8
X-Proofpoint-ORIG-GUID: m2ccWSyh_Wr8E-9VPMqyMATY_0uSkLL8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_07,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=982 spamscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211290072
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update lpass sc7280 platform driver with PM ops, such as
system supend and resume callbacks.
This update is required to disable clocks during supend and
avoid XO shutdown issue.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Tested-by: Rahul Ajmeriya <quic_rajmeriy@quicinc.com>
---
Changes since v1:
    -- Add __maybe_unused flag for suspend/resume APIs.

 sound/soc/qcom/lpass-sc7280.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/soc/qcom/lpass-sc7280.c b/sound/soc/qcom/lpass-sc7280.c
index 70c4df8..d43f480 100644
--- a/sound/soc/qcom/lpass-sc7280.c
+++ b/sound/soc/qcom/lpass-sc7280.c
@@ -232,10 +232,28 @@ static int sc7280_lpass_exit(struct platform_device *pdev)
 	struct lpass_data *drvdata = platform_get_drvdata(pdev);
 
 	clk_bulk_disable_unprepare(drvdata->num_clks, drvdata->clks);
+	return 0;
+}
+
+static int __maybe_unused sc7280_lpass_dev_resume(struct device *dev)
+{
+	struct lpass_data *drvdata = dev_get_drvdata(dev);
+
+	return clk_bulk_prepare_enable(drvdata->num_clks, drvdata->clks);
+}
 
+static int __maybe_unused sc7280_lpass_dev_suspend(struct device *dev)
+{
+	struct lpass_data *drvdata = dev_get_drvdata(dev);
+
+	clk_bulk_disable_unprepare(drvdata->num_clks, drvdata->clks);
 	return 0;
 }
 
+static const struct dev_pm_ops sc7280_lpass_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(sc7280_lpass_dev_suspend, sc7280_lpass_dev_resume)
+};
+
 static struct lpass_variant sc7280_data = {
 	.i2sctrl_reg_base		= 0x1000,
 	.i2sctrl_reg_stride		= 0x1000,
@@ -426,6 +444,7 @@ static struct platform_driver sc7280_lpass_cpu_platform_driver = {
 	.driver = {
 		.name = "sc7280-lpass-cpu",
 		.of_match_table = of_match_ptr(sc7280_lpass_cpu_device_id),
+		.pm = &sc7280_lpass_pm_ops,
 	},
 	.probe = asoc_qcom_lpass_cpu_platform_probe,
 	.remove = asoc_qcom_lpass_cpu_platform_remove,
-- 
2.7.4

