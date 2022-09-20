Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433915BDD40
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiITGbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiITGbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:31:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9825140D1;
        Mon, 19 Sep 2022 23:30:46 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28K6F2Di031678;
        Tue, 20 Sep 2022 06:30:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=N9Yn54dUST2gKFnCMhKvfF8BV8CmnCL0NZ9qkX3jmbg=;
 b=ZN9GH4gClZRXQtM97H466dHjZQXKB557GVxy6BqVfX+zcnHRFW7MNdknAn8zDZyS2/Xw
 1c3UsUKvS0t2IX1y+XBhtoCFtPLhsOYmxrzjNfHIbcZK+zVRs4iUPz2SAnIcgreUXuAS
 2TPEJytYvF93bO6o7lMr9shwSV1P+svDOBVIqIyKwVIRDmTGEaK1sWpY44rL2i/FuNYR
 OJwHIuSlBnByfOnaqH+pOjr5c2ezSHP+EoKufWu8BY56bujfP8ZSSpGONgRXTlS9rT0w
 O5d3zvLD6k7NyfiiFi8vQYpt8o0IqKx2AQXQWEz/gtUUowa5a5jpAXjeWxCOFzUyryTR mA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jq4r08h9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 06:30:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28K6U4W0016254
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 06:30:04 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 19 Sep 2022 23:29:58 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v7 4/8] remoteproc: qcom: Update rproc parse firmware callback
Date:   Tue, 20 Sep 2022 11:59:15 +0530
Message-ID: <1663655359-1402-5-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1663655359-1402-1-git-send-email-quic_srivasam@quicinc.com>
References: <1663655359-1402-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5KTpAmHccAvYMYkKZPyrMQFssYhKnp1D
X-Proofpoint-GUID: 5KTpAmHccAvYMYkKZPyrMQFssYhKnp1D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_02,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209200038
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change parse_fw callback in rproc ops from qcom_register_dump_segments
to local function such that, it can perform coredump segments registration
and it can parse section header in memory sandboxing required platforms.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
---
Changes since V6:
	-- Update parse firmware callback.

 drivers/remoteproc/qcom_q6v5_adsp.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
index 02d17b4..9ea10b7 100644
--- a/drivers/remoteproc/qcom_q6v5_adsp.c
+++ b/drivers/remoteproc/qcom_q6v5_adsp.c
@@ -440,6 +440,27 @@ static void *adsp_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is_iom
 	return adsp->mem_region + offset;
 }
 
+static int adsp_parse_firmware(struct rproc *rproc, const struct firmware *fw)
+{
+	struct qcom_adsp *adsp = rproc->priv;
+	int ret;
+
+	ret = qcom_register_dump_segments(rproc, fw);
+	if (ret) {
+		dev_err(&rproc->dev, "Error in registering dump segments\n");
+		return ret;
+	}
+
+	if (adsp->has_iommu) {
+		ret = rproc_elf_load_rsc_table(rproc, fw);
+		if (ret) {
+			dev_err(&rproc->dev, "Error in loading resource table\n");
+			return ret;
+		}
+	}
+	return 0;
+}
+
 static unsigned long adsp_panic(struct rproc *rproc)
 {
 	struct qcom_adsp *adsp = rproc->priv;
@@ -451,7 +472,7 @@ static const struct rproc_ops adsp_ops = {
 	.start = adsp_start,
 	.stop = adsp_stop,
 	.da_to_va = adsp_da_to_va,
-	.parse_fw = qcom_register_dump_segments,
+	.parse_fw = adsp_parse_firmware,
 	.load = adsp_load,
 	.panic = adsp_panic,
 };
-- 
2.7.4

