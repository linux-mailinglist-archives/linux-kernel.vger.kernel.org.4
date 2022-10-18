Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB2D6035DC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 00:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiJRW0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 18:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiJRW0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 18:26:11 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BC891877;
        Tue, 18 Oct 2022 15:26:10 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29IMB80N027614;
        Tue, 18 Oct 2022 22:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=GimUMowsUDQcd21CbHiHFTXpkUwHHdoKaYJbXuA/hPY=;
 b=DrVV6lyV8rYGTjy7Sew10jmMzxymKbJQK040aIawMMafK5QtbAFTmTzyJ3ZzmfUi4eoS
 cbWiQ2KdSMgelqC0pAL8lHitj0KQr95D+JlMdXyZbjFH2melA/FeRmc6kfJOIqfQI3f1
 H0RKSUlByJ9l2aUFmGVB8awVFmJImjXbRTElvVMuxZC8eyBiwX/ZIrwo8PsTUW685kb7
 uPDv/sSKXLLfP9qfZalyZyeAm/q3KfauS9tAwxuL1ot4KIWg9MlayqI6LaX4MmokN5S2
 AbJqBycrHrrZJEf20FE4bA3z3QNYS2aJQ0W3Jxm16k9/+gkQ+v+VHcpzqhR9bcqhka2S Ew== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k9qwp1w94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 22:25:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29IMPtoh020270
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 22:25:55 GMT
Received: from quicinc.com (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 18 Oct
 2022 15:25:54 -0700
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [RESEND PATCH] slimbus: qcom-ngd-ctrl: Make QMI message rules const
Date:   Tue, 18 Oct 2022 15:25:47 -0700
Message-ID: <20221018222547.17529-1-quic_jjohnson@quicinc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914234705.28405-4-quic_jjohnson@quicinc.com>
References: <20220914234705.28405-4-quic_jjohnson@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3V_V3YbXRN96TImgFfKOdziloUXefTQR
X-Proofpoint-ORIG-GUID: 3V_V3YbXRN96TImgFfKOdziloUXefTQR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_07,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210180125
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ff6d365898d4 ("soc: qcom: qmi: use const for struct
qmi_elem_info") allows QMI message encoding/decoding rules to be
const, so do that for qcom-ngd-ctrl.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Reviewed-by: Alex Elder <elder@linaro.org>
Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>
---
This patch was last sent as part of the series:
[PATCH v2 0/4] Make QMI message rules const
https://lore.kernel.org/linux-arm-msm/20220914234705.28405-1-quic_jjohnson@quicinc.com/

As

[PATCH v2 3/4] slimbus: qcom-ngd-ctrl: Make QMI message rules const
https://lore.kernel.org/linux-arm-msm/20220914234705.28405-4-quic_jjohnson@quicinc.com/

Since the individual patches in the series will land in separate
trees, and since there are no dependencies between them, they are
being resent separately when the following dependent change has landed
in the destination tree
ff6d365898d4 ("soc: qcom: qmi: use const for struct qmi_elem_info")

That dependent change has landed in the for-next branch of
tiwai/sound.git (which I hope is the right tree for this patch) so I
believe this patch is now ready to be consumed.

drivers/slimbus/qcom-ngd-ctrl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 76c5e446d243..f5da340bee94 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -220,7 +220,7 @@ struct slimbus_power_resp_msg_v01 {
 	struct qmi_response_type_v01 resp;
 };
 
-static struct qmi_elem_info slimbus_select_inst_req_msg_v01_ei[] = {
+static const struct qmi_elem_info slimbus_select_inst_req_msg_v01_ei[] = {
 	{
 		.data_type  = QMI_UNSIGNED_4_BYTE,
 		.elem_len   = 1,
@@ -262,7 +262,7 @@ static struct qmi_elem_info slimbus_select_inst_req_msg_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info slimbus_select_inst_resp_msg_v01_ei[] = {
+static const struct qmi_elem_info slimbus_select_inst_resp_msg_v01_ei[] = {
 	{
 		.data_type  = QMI_STRUCT,
 		.elem_len   = 1,
@@ -284,7 +284,7 @@ static struct qmi_elem_info slimbus_select_inst_resp_msg_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info slimbus_power_req_msg_v01_ei[] = {
+static const struct qmi_elem_info slimbus_power_req_msg_v01_ei[] = {
 	{
 		.data_type  = QMI_UNSIGNED_4_BYTE,
 		.elem_len   = 1,
@@ -324,7 +324,7 @@ static struct qmi_elem_info slimbus_power_req_msg_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info slimbus_power_resp_msg_v01_ei[] = {
+static const struct qmi_elem_info slimbus_power_resp_msg_v01_ei[] = {
 	{
 		.data_type  = QMI_STRUCT,
 		.elem_len   = 1,
-- 
2.37.3

