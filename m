Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5D45F5B41
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 22:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiJEUz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 16:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiJEUzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 16:55:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2CA6919E;
        Wed,  5 Oct 2022 13:55:23 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 295Kfu9L017131;
        Wed, 5 Oct 2022 20:55:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=NUQzIl1koD2p/5aypamO918G/LiJKNVmP1A+WyBBvQA=;
 b=ZynAvrYPGKwoqUp6OSc9AcPVSBEWzyuo6yGm6DM/gp2SdBgLLeInKQk4SC4nz19btMfz
 oeZobgc3hwUD4lFaAoRMr3k2gSJc7CRdQd1AWvA1DGD7fJ00uWzDmZKogo/sbR9c/MWf
 LHaRlwt+xE1sm5h7+A2YA3ZrnkkXgpPsXO9KFqbIeyJz6xolEBHaExhnis+NglFkWGTb
 /JCeVMATrJQTsC0gwGUUYIG/bPtD8+0w7PEsuVGSHjZR47os9gEY4vDOehxyls55AZGI
 A6NmNfQAv2XBxL53YN/pXhSlJQO2GQPXTSHwg9TjcB8PSixp01OHJiLnBOzRjuZZX5zX 9g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k06sjn66b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Oct 2022 20:55:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 295KtF0l006104
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Oct 2022 20:55:15 GMT
Received: from quicinc.com (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 5 Oct 2022
 13:55:14 -0700
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Jeff Johnson" <quic_jjohnson@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        "Sibi Sankar" <quic_sibis@quicinc.com>
Subject: [RESEND] soc: qcom: pdr: Make QMI message rules const
Date:   Wed, 5 Oct 2022 13:54:58 -0700
Message-ID: <20221005205458.31437-1-quic_jjohnson@quicinc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914234705.28405-5-quic_jjohnson@quicinc.com>
References: <20220914234705.28405-5-quic_jjohnson@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7ciNLxjORYeyBsRCeJr1dVQf_FHvDMG8
X-Proofpoint-GUID: 7ciNLxjORYeyBsRCeJr1dVQf_FHvDMG8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_05,2022-10-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210050129
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
const, so do that for QCOM PDR.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Reviewed-by: Alex Elder <elder@linaro.org>
Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>
---
This patch was last sent as part of the series:
[PATCH v2 0/4] Make QMI message rules const
https://lore.kernel.org/linux-arm-msm/20220914234705.28405-1-quic_jjohnson@quicinc.com/

As

[PATCH v2 4/4] soc: qcom: pdr: Make QMI message rules const
https://lore.kernel.org/linux-arm-msm/20220914234705.28405-5-quic_jjohnson@quicinc.com/

Since the individual patches in the series will land in separate
trees, and since there are no dependencies between them, they are
being resent separately when the following dependent change has landed
in the destination tree:

ff6d365898d4 ("soc: qcom: qmi: use const for struct qmi_elem_info")

 drivers/soc/qcom/pdr_internal.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/qcom/pdr_internal.h b/drivers/soc/qcom/pdr_internal.h
index a30422214943..03c282b7f17e 100644
--- a/drivers/soc/qcom/pdr_internal.h
+++ b/drivers/soc/qcom/pdr_internal.h
@@ -28,7 +28,7 @@ struct servreg_location_entry {
 	u32 instance;
 };
 
-static struct qmi_elem_info servreg_location_entry_ei[] = {
+static const struct qmi_elem_info servreg_location_entry_ei[] = {
 	{
 		.data_type      = QMI_STRING,
 		.elem_len       = SERVREG_NAME_LENGTH + 1,
@@ -74,7 +74,7 @@ struct servreg_get_domain_list_req {
 	u32 domain_offset;
 };
 
-static struct qmi_elem_info servreg_get_domain_list_req_ei[] = {
+static const struct qmi_elem_info servreg_get_domain_list_req_ei[] = {
 	{
 		.data_type      = QMI_STRING,
 		.elem_len       = SERVREG_NAME_LENGTH + 1,
@@ -116,7 +116,7 @@ struct servreg_get_domain_list_resp {
 	struct servreg_location_entry domain_list[SERVREG_DOMAIN_LIST_LENGTH];
 };
 
-static struct qmi_elem_info servreg_get_domain_list_resp_ei[] = {
+static const struct qmi_elem_info servreg_get_domain_list_resp_ei[] = {
 	{
 		.data_type      = QMI_STRUCT,
 		.elem_len       = 1,
@@ -199,7 +199,7 @@ struct servreg_register_listener_req {
 	char service_path[SERVREG_NAME_LENGTH + 1];
 };
 
-static struct qmi_elem_info servreg_register_listener_req_ei[] = {
+static const struct qmi_elem_info servreg_register_listener_req_ei[] = {
 	{
 		.data_type      = QMI_UNSIGNED_1_BYTE,
 		.elem_len       = 1,
@@ -227,7 +227,7 @@ struct servreg_register_listener_resp {
 	enum servreg_service_state curr_state;
 };
 
-static struct qmi_elem_info servreg_register_listener_resp_ei[] = {
+static const struct qmi_elem_info servreg_register_listener_resp_ei[] = {
 	{
 		.data_type      = QMI_STRUCT,
 		.elem_len       = 1,
@@ -263,7 +263,7 @@ struct servreg_restart_pd_req {
 	char service_path[SERVREG_NAME_LENGTH + 1];
 };
 
-static struct qmi_elem_info servreg_restart_pd_req_ei[] = {
+static const struct qmi_elem_info servreg_restart_pd_req_ei[] = {
 	{
 		.data_type      = QMI_STRING,
 		.elem_len       = SERVREG_NAME_LENGTH + 1,
@@ -280,7 +280,7 @@ struct servreg_restart_pd_resp {
 	struct qmi_response_type_v01 resp;
 };
 
-static struct qmi_elem_info servreg_restart_pd_resp_ei[] = {
+static const struct qmi_elem_info servreg_restart_pd_resp_ei[] = {
 	{
 		.data_type      = QMI_STRUCT,
 		.elem_len       = 1,
@@ -300,7 +300,7 @@ struct servreg_state_updated_ind {
 	u16 transaction_id;
 };
 
-static struct qmi_elem_info servreg_state_updated_ind_ei[] = {
+static const struct qmi_elem_info servreg_state_updated_ind_ei[] = {
 	{
 		.data_type      = QMI_SIGNED_4_BYTE_ENUM,
 		.elem_len       = 1,
@@ -336,7 +336,7 @@ struct servreg_set_ack_req {
 	u16 transaction_id;
 };
 
-static struct qmi_elem_info servreg_set_ack_req_ei[] = {
+static const struct qmi_elem_info servreg_set_ack_req_ei[] = {
 	{
 		.data_type      = QMI_STRING,
 		.elem_len       = SERVREG_NAME_LENGTH + 1,
@@ -362,7 +362,7 @@ struct servreg_set_ack_resp {
 	struct qmi_response_type_v01 resp;
 };
 
-static struct qmi_elem_info servreg_set_ack_resp_ei[] = {
+static const struct qmi_elem_info servreg_set_ack_resp_ei[] = {
 	{
 		.data_type      = QMI_STRUCT,
 		.elem_len       = 1,
-- 
2.37.3

