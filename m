Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A568D63A247
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 08:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiK1HuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 02:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiK1HuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 02:50:12 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7315A958A;
        Sun, 27 Nov 2022 23:50:10 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AS5pvbm013085;
        Mon, 28 Nov 2022 07:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=EvOYNr5YwYsIS+9C2KVrBrkRa6q4/RNX1EkrAtgxSz0=;
 b=pRMT6liRzaCzEJ+gyyAB9TSBPVuSRM2WcXU9/mavI0Kkf4QQqKhYNqhf2GFRiqVxmoJ4
 if1wzu6Fb3WewGZxUy6u9a8z8d494yKiKvZBnK9SM4bubVGharcdcvAvcFyiOzk1RYds
 wAGJ2S5F2ncHHjbjZozbF2KCTC5NVXkJCyWUsMeA+kLcYe4jPE0KFbXHrCpQszCozQrv
 o6vhHFj0V1NXDQ0WnjFITdHdc2oGJgNsaKASUWZcPQvcUmlKNmEADFltw/OB3eAVhG/n
 rKuWSoccanMC2q/z9TJuXpNy8RD54Z+yXpEtCcF4dkuDQ09McUfzlUFsUK4DE70m2MVF dg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m3bjrkpca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 07:49:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AS7nLi5009840
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 07:49:21 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 27 Nov 2022 23:49:15 -0800
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
Subject: [PATCH] ASoC: qcom: lpass-sc7180: Add system suspend/resume PM ops
Date:   Mon, 28 Nov 2022 13:19:02 +0530
Message-ID: <1669621742-28524-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oyKsuhqYmd0bM19Akig8BJRQ_oIBWATw
X-Proofpoint-GUID: oyKsuhqYmd0bM19Akig8BJRQ_oIBWATw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_06,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 impostorscore=0 priorityscore=1501 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211280061
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update lpass sc7180 platform driver with PM ops, such as
system supend and resume callbacks.
This update is required to disable clocks during supend and
avoid XO shutdown issue.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Tested-by: Rahul Ajmeriya <quic_rajmeriy@quicinc.com>
---
 sound/soc/qcom/lpass-sc7180.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/sound/soc/qcom/lpass-sc7180.c b/sound/soc/qcom/lpass-sc7180.c
index 77a556b..6ad1c5b 100644
--- a/sound/soc/qcom/lpass-sc7180.c
+++ b/sound/soc/qcom/lpass-sc7180.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <dt-bindings/sound/sc7180-lpass.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
@@ -156,10 +157,34 @@ static int sc7180_lpass_exit(struct platform_device *pdev)
 	struct lpass_data *drvdata = platform_get_drvdata(pdev);
 
 	clk_bulk_disable_unprepare(drvdata->num_clks, drvdata->clks);
+	return 0;
+}
+
+static int sc7180_lpass_dev_resume(struct device *dev)
+{
+	int ret = 0;
+	struct lpass_data *drvdata = dev_get_drvdata(dev);
 
+	ret = clk_bulk_prepare_enable(drvdata->num_clks, drvdata->clks);
+	if (ret) {
+		dev_err(dev, "sc7180 clk prepare and enable failed\n");
+		return ret;
+	}
+	return ret;
+}
+
+static int sc7180_lpass_dev_suspend(struct device *dev)
+{
+	struct lpass_data *drvdata = dev_get_drvdata(dev);
+
+	clk_bulk_disable_unprepare(drvdata->num_clks, drvdata->clks);
 	return 0;
 }
 
+static const struct dev_pm_ops sc7180_lpass_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(sc7180_lpass_dev_suspend, sc7180_lpass_dev_resume)
+};
+
 static struct lpass_variant sc7180_data = {
 	.i2sctrl_reg_base	= 0x1000,
 	.i2sctrl_reg_stride	= 0x1000,
@@ -293,6 +318,7 @@ static struct platform_driver sc7180_lpass_cpu_platform_driver = {
 	.driver = {
 		.name = "sc7180-lpass-cpu",
 		.of_match_table = of_match_ptr(sc7180_lpass_cpu_device_id),
+		.pm = &sc7180_lpass_pm_ops,
 	},
 	.probe = asoc_qcom_lpass_cpu_platform_probe,
 	.remove = asoc_qcom_lpass_cpu_platform_remove,
-- 
2.7.4

