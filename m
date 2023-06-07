Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D294725E9F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240599AbjFGMSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240580AbjFGMSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:18:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038781FCC;
        Wed,  7 Jun 2023 05:18:00 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357BolVM026152;
        Wed, 7 Jun 2023 12:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=FbsyScr3o1Tp4SEpV27GA285wZAUeGoW1kZuL2UWEtI=;
 b=HloIIbiY8EWLYWe8N97mViNKL1dUALgqwlzk560ZrxYDU8RR7lImWpt+KyrCNcDveyEt
 hnkaF81zFfj5+LliI0jsCXGr5puegKAVu3UmIwWu/+f48sSh6eV1kdUCynV24hj6SQV7
 XJJXHVmQ6Zwzsubh8I1wamv5kozlHKYTOp18+9VcB4Mi7xUD6P+Y5cPdUb7MhnufkVgG
 ZK2qzJDjxs7s71PTNqw+gyJNf9dZU/UvLy3mywntvmeUsVjYUkM1e+KRbZxEMqMoHhM2
 aGk4taTu2N3gA+o0s3deBFPvLPXFarjs4PA0dzfWj0mmCwMbj8RVtOPkgDG0bQC2lZZJ bQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2a719tfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 12:17:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 357CHubm009697
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Jun 2023 12:17:56 GMT
Received: from mmanikan-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 7 Jun 2023 05:17:51 -0700
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mathieu.poirier@linaro.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_varada@quicinc.com>
Subject: [PATCH 0/2] change glink work queue type
Date:   Wed, 7 Jun 2023 17:47:29 +0530
Message-ID: <20230607121731.26958-1-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rOph_R_WR1fvenRfsK20ffAm7n7JYd24
X-Proofpoint-ORIG-GUID: rOph_R_WR1fvenRfsK20ffAm7n7JYd24
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_06,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=490 suspectscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070102
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since rx & intent worker threads are bound
to kernel global workqueue, it takes more
time to execute. If these worker threads
are not executed within stipulated duration
QDSP6 will OOM and glink client drivers get
timeout error.

This series will change work queue type to
UNBOUND work queue to ensure worker thread
execute as early as possible.

It's verified on IPQ807x.

Manikanta Mylavarapu (2):
  rpmsg: glink: change rx work queue type
  rpmsg: glink: change intent work queue type

 drivers/rpmsg/qcom_glink_native.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)


base-commit: abbd8bb42915d9ed06df11b430bf4ecb3d8ac5ad
--
2.17.1

