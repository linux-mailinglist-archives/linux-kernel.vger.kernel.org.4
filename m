Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD985BD1BD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiISQC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiISQCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 12:02:30 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA9B3C8D3;
        Mon, 19 Sep 2022 09:00:55 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JD2Zbm008848;
        Mon, 19 Sep 2022 16:00:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=eKdTyxOiLccVrdw63VF1sE1mujYcuFpBho0TboPJW5c=;
 b=fKm7hjDG3H7LZ3DXi+Q1DsbhOF4mYx/BuCQ2kh/FvRu/1n9QdxiVTqRz9CuEWe2Qfela
 zi6FVLAq5S15Va+s82vPYG2pg/oPIEzsrQeBBZhPp9T0VD7FWOxSbhBXH6q4hIDRpp7r
 CitpYSzNZPenT4rTHzaErvU9LDuW9LaeaqTkDyFGY28UsFgRUEqzj10c/yKZVm9BtszN
 k/yOo7pXuQSZRAUpZRNt6B+JwVdXGqjsid8UTZGv4Cz4jGrPzdffy/gao6Z24cy901XA
 RfGFJ4xOw/Rb3VFfo5HLykwtP/HIKCNATotd2lmKVJzQH3CcrAWuixn+hyyMcQQulSaD 0A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jn6b1w7qn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 16:00:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28JG0mAL027052
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 16:00:48 GMT
Received: from hu-gokukris-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 19 Sep 2022 09:00:47 -0700
From:   Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
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
Subject: [PATCH v1 0/3] Handle coprocessor crash
Date:   Mon, 19 Sep 2022 09:00:37 -0700
Message-ID: <cover.1662995608.git.quic_gokukris@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MjeLGTW-q5V1rioyDz0QRALP64xzrRuE
X-Proofpoint-ORIG-GUID: MjeLGTW-q5V1rioyDz0QRALP64xzrRuE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 mlxlogscore=516 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209190107
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the following changes in case of coprocessor crash:
1. Send subdevice notifications before panic
2. Do not report crash if SSR is disabled
3. Avoid setting smem bit in case of crash

Gokul krishna Krishnakumar (3):
  remoteproc: qcom: q6v5: Send subdevice notifications before panic
  remoteproc: qcom: q6v5: Do not report crash if SSR is disabled
  remoteproc: qcom: q6v5: Avoid setting smem bit in case of crash
    shutdown

 drivers/remoteproc/qcom_q6v5.c | 43 ++++++++++++++++++++++++++++++++++++++----
 drivers/remoteproc/qcom_q6v5.h |  2 ++
 2 files changed, 41 insertions(+), 4 deletions(-)

-- 
2.7.4

