Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F6E603423
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 22:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiJRUom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 16:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiJRUof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 16:44:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E422B1A223;
        Tue, 18 Oct 2022 13:44:30 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29IIw1ct022194;
        Tue, 18 Oct 2022 20:44:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=mBcZKhQtPPk6nDupBGM0mwVz5W4ozyHmllOfvso8wEc=;
 b=pFNV+1fP+71xlQgg5C3euqWXAsZa/VHo30i/+vSxT53PLw4QTsKXXx3RqoihYPi2PfAC
 gUtKl5uS+TBPBcbyUfm6njRIPEONMq59fl53vo+cLUqJwmFDsFRzKoQpDkScNac5gTwH
 bOMaowTikq3cl8cEXRS3dGRhPnDcucKjGHgxYjgUcLrbdM4zwnOL9GBbWMTsU/LdFVsB
 IxS3VIwMk4IKtR/1JCqUL3V0jGJj42Ir55E8jCv6PB5OVDK0de09WixuS5BxGu74kVfv
 OGNKx/BhJ/32sjk9CLLzdl12c5sfOlZ76A8Ili02LEGlJMK/giAmpeq0NRhU7F9GyeBW zQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k9qwp1qr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 20:44:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29IKiHdD025077
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 20:44:17 GMT
Received: from quicinc.com (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 18 Oct
 2022 13:44:16 -0700
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [RESEND PATCH] remoteproc: sysmon: Make QMI message rules const
Date:   Tue, 18 Oct 2022 13:44:08 -0700
Message-ID: <20221018204408.13314-1-quic_jjohnson@quicinc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914234705.28405-3-quic_jjohnson@quicinc.com>
References: <20220914234705.28405-3-quic_jjohnson@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YY595TaBYfefQ5CjstgCcHlGi3iiJyqS
X-Proofpoint-ORIG-GUID: YY595TaBYfefQ5CjstgCcHlGi3iiJyqS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_07,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 phishscore=0 bulkscore=0 mlxlogscore=992 malwarescore=0 adultscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210180116
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
const, so do that for sysmon.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Reviewed-by: Alex Elder <elder@linaro.org>
Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>
---
This patch was last sent as part of the series:
[PATCH v2 0/4] Make QMI message rules const
https://lore.kernel.org/linux-arm-msm/20220914234705.28405-1-quic_jjohnson@quicinc.com/

As

[PATCH v2 2/4] remoteproc: sysmon: Make QMI message rules const
https://lore.kernel.org/linux-arm-msm/20220914234705.28405-3-quic_jjohnson@quicinc.com/

Since the individual patches in the series will land in separate
trees, and since there are no dependencies between them, they are
being resent separately when the following dependent change has landed
in the destination tree
ff6d365898d4 ("soc: qcom: qmi: use const for struct qmi_elem_info")

That dependent change has landed in the rproc-next branch of
remoteproc/linux.git so this patch is now ready to be consumed.

 drivers/remoteproc/qcom_sysmon.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/qcom_sysmon.c b/drivers/remoteproc/qcom_sysmon.c
index 57dde2a69b9d..3992bb61d2ec 100644
--- a/drivers/remoteproc/qcom_sysmon.c
+++ b/drivers/remoteproc/qcom_sysmon.c
@@ -190,7 +190,7 @@ struct ssctl_shutdown_resp {
 	struct qmi_response_type_v01 resp;
 };
 
-static struct qmi_elem_info ssctl_shutdown_resp_ei[] = {
+static const struct qmi_elem_info ssctl_shutdown_resp_ei[] = {
 	{
 		.data_type	= QMI_STRUCT,
 		.elem_len	= 1,
@@ -211,7 +211,7 @@ struct ssctl_subsys_event_req {
 	u32 evt_driven;
 };
 
-static struct qmi_elem_info ssctl_subsys_event_req_ei[] = {
+static const struct qmi_elem_info ssctl_subsys_event_req_ei[] = {
 	{
 		.data_type	= QMI_DATA_LEN,
 		.elem_len	= 1,
@@ -269,7 +269,7 @@ struct ssctl_subsys_event_resp {
 	struct qmi_response_type_v01 resp;
 };
 
-static struct qmi_elem_info ssctl_subsys_event_resp_ei[] = {
+static const struct qmi_elem_info ssctl_subsys_event_resp_ei[] = {
 	{
 		.data_type	= QMI_STRUCT,
 		.elem_len	= 1,
@@ -283,7 +283,7 @@ static struct qmi_elem_info ssctl_subsys_event_resp_ei[] = {
 	{}
 };
 
-static struct qmi_elem_info ssctl_shutdown_ind_ei[] = {
+static const struct qmi_elem_info ssctl_shutdown_ind_ei[] = {
 	{}
 };
 
-- 
2.37.3

