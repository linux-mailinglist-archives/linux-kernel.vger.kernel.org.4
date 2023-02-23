Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD18E6A02AF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 07:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbjBWGOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 01:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjBWGOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 01:14:01 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6851EBCF;
        Wed, 22 Feb 2023 22:13:59 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31N49Ddh004525;
        Thu, 23 Feb 2023 06:13:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=itMCcoMGHXoMQVi/aVCtN40n9UEt67oMQzhzDLbvy84=;
 b=bFVSo/7sOHx8DQoT8gOOFGmrLRXCJxUES14zAvEMZhV+hxW9VHoy9NX5m7qIbkdEDTz0
 7fBlCS6ERvnMdGReL59fO2U+tqTwKlGSohSSJSQNNqN8fkgCSKSCgF4O1Xm8FkV5W/eQ
 InalrN4Ejz8MvQKFeaFOljhozFq+ZaYKUfxi7nuHGSfERQXqaqmGkNkJemCosQNdy69a
 1GsxX8TXlynsFQQLl/9Zl9WdqbFXuxOh32nZ1JQpwmEBWYBqV0uiUW3eOT95VMiVFpX4
 /bggUqQxhrXzhFpMaVlZAXr4qCN+eVoSlxr0i4pg8ZAEclbbOo3FA41UFDWlEumRtGSR OQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nwywd0c1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 06:13:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31N6DtKB022001
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 06:13:55 GMT
Received: from hyiwei-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 22 Feb 2023 22:13:52 -0800
From:   Huang Yiwei <quic_hyiwei@quicinc.com>
To:     <mani@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>
CC:     Huang Yiwei <quic_hyiwei@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_satyap@quicinc.com>, <quic_aiquny@quicinc.com>,
        <quic_gurus@quicinc.com>
Subject: [PATCH] mailbox: qcom-ipcc: Support multiple channels for a given client
Date:   Thu, 23 Feb 2023 14:13:18 +0800
Message-ID: <20230223061318.1793-1-quic_hyiwei@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4cWtDjFRIY_Ft_6VATCQ9SSs1DNfE43A
X-Proofpoint-ORIG-GUID: 4cWtDjFRIY_Ft_6VATCQ9SSs1DNfE43A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_02,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 clxscore=1011 impostorscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=747
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302230052
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently a new use case where two signals for the same protocol and
client is needed, that means there will be more than one channel
for a mbox node. Current driver only supports one channel, so need
to remove the limitation and let the driver find every channel
correctly.

Signed-off-by: Huang Yiwei <quic_hyiwei@quicinc.com>
---
 drivers/mailbox/qcom-ipcc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/qcom-ipcc.c b/drivers/mailbox/qcom-ipcc.c
index 7e27acf6c0cc..367658af089e 100644
--- a/drivers/mailbox/qcom-ipcc.c
+++ b/drivers/mailbox/qcom-ipcc.c
@@ -226,11 +226,9 @@ static int qcom_ipcc_setup_mbox(struct qcom_ipcc *ipcc,
 		for (j = 0; j < i; j++) {
 			ret = of_parse_phandle_with_args(client_dn, "mboxes",
 						"#mbox-cells", j, &curr_ph);
-			of_node_put(curr_ph.np);
-			if (!ret && curr_ph.np == controller_dn) {
+			if (!ret && curr_ph.np == controller_dn)
 				ipcc->num_chans++;
-				break;
-			}
+			of_node_put(curr_ph.np);
 		}
 	}
 
-- 
2.17.1

