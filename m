Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C66D5B7A29
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbiIMSw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbiIMSvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:51:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA886381;
        Tue, 13 Sep 2022 11:36:08 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28DISxap023142;
        Tue, 13 Sep 2022 18:36:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=x/heB6q2D/lSJBzQsR7Yoo/qqho43QjYowbw3qAX/6k=;
 b=Z8XJGYqopyUJchfPnHmcHVo0ajzfkKHYSbQKWpY7SzOsR/N4DW+NbvRdKsxUg+wasy+J
 pypS/SfLkCflu10DmUIrBYZdiq+d2ODoDgEes7ctGHSS7MHQMYNldIKQUZNZtFH3JUF6
 ao09X5jo+201Eo+UnMTg/67MmvxGw+RRanreQ7E2d5/IO9jj4xyE/u8cTVdtF4Zn+o99
 EV0/W1TQlyCDIUG4+iHx19hMbQ8RlJsPSsVHnPVlQJYD2ZzHLMRCFZORtPjnG6h+lnK1
 PJHEwiKVttN1qGAETt5Q9hcPlE1pRfxMOBEaocfuJ7ZFOJ1S03uBwm6ODSsrwAr1HnMK xQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jjy0e0195-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 18:36:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28DIZxOS029286
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 18:35:59 GMT
Received: from hu-gokukris-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 13 Sep 2022 11:35:59 -0700
From:   Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Satya Durga Srinivasu Prabhala" <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        "Guru Das Srinagesh" <quic_gurus@quicinc.com>,
        Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Subject: [PATCH v1 3/3] remoteproc: qcom: q6v5: Avoid setting smem bit in case of crash shutdown
Date:   Tue, 13 Sep 2022 11:35:44 -0700
Message-ID: <9e549a54e2a6ede3e413de933fd1725c660993c3.1662995608.git.quic_gokukris@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1662995608.git.quic_gokukris@quicinc.com>
References: <cover.1662995608.git.quic_gokukris@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bnP1ArD21dhUlS2dpIgVor6FUBRkKT1l
X-Proofpoint-GUID: bnP1ArD21dhUlS2dpIgVor6FUBRkKT1l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_09,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=863
 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209130085
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid setting smem bit in case of crash shutdown, as remote
processor is not able to send the ack back.

Change-Id: I33f19087627e5a7fe2c3bcce377b51b903574bc4
Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
---
 drivers/remoteproc/qcom_q6v5.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
index 1b9e1e1..569427a 100644
--- a/drivers/remoteproc/qcom_q6v5.c
+++ b/drivers/remoteproc/qcom_q6v5.c
@@ -237,8 +237,10 @@ int qcom_q6v5_request_stop(struct qcom_q6v5 *q6v5, struct qcom_sysmon *sysmon)
 
 	q6v5->running = false;
 
-	/* Don't perform SMP2P dance if sysmon already shut down the remote */
-	if (qcom_sysmon_shutdown_acked(sysmon))
+	/* Don't perform SMP2P dance if sysmon already shut
+	 * down the remote or if it isn't running
+	 */
+	if (q6v5->rproc->state != RPROC_RUNNING || qcom_sysmon_shutdown_acked(sysmon))
 		return 0;
 
 	qcom_smem_state_update_bits(q6v5->state,
-- 
2.7.4

