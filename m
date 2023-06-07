Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D447265FB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 18:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjFGQbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 12:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbjFGQax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 12:30:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E9D2111;
        Wed,  7 Jun 2023 09:30:33 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357G8qsi010792;
        Wed, 7 Jun 2023 16:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=TOZfVF/9xmbn180Ru8MNahMQR5iJqpzYSTRbhQM3/kM=;
 b=Y3q8Ca6OyYYvEeJfXVkgF90sMkULwT+R0GGcgQMCv2HhECuAWddvXqH8naIl7rAv0rqZ
 lZh8PDqhmh4pBWq58jz3IzdvMVBIf4EKE95aVxG3aGKNyqyI+gJu0hpfLHygpkKuGsu0
 JKXsALEVCPnlmwmw7iDjhhPibJ0OSAgSN8MFa0Vl10EAC4S+Hq1OkOU0Sz41TJhYyoEz
 kjCN+0Xucec+DEPNwhHDh0AdXl+0+40SAVqhZ6cIqHHCkdfvcooeYVN34YsRfUWbh1nO
 NNA7XXdXtjZDHOZwKmWm9NuwLJRY4AmYHlSR5ia/hEZcI6nirLAM0Wk5q2m4YQ6FQGSL tA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2w5501mm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 16:30:18 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 357GUHhD009362
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Jun 2023 16:30:17 GMT
Received: from ekangupt-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 7 Jun 2023 09:30:12 -0700
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        <ekangupt@qti.qualcomm.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        <fastrpc.upstream@qti.qualcomm.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>
Subject: [RESEND PATCH v1 0/2] Privileged process support on remote subsystem
Date:   Wed, 7 Jun 2023 22:00:05 +0530
Message-ID: <1686155407-20054-1-git-send-email-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: G5fFzBcDiXE7ohCLu_4MzHy6vxEKMWvP
X-Proofpoint-ORIG-GUID: G5fFzBcDiXE7ohCLu_4MzHy6vxEKMWvP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_07,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 impostorscore=0 clxscore=1011 bulkscore=0
 mlxlogscore=902 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070140
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to run remote user process as privileged on remote
subsystem. The privileged user process can be given prioritized
access to remote processor resources. This is achieved in kernel
based on the group ID of the process. The kernel will have a
pre-defined fastrpc group ID and if the process's group ID matches
with it, then the process is treated as a privileged process. This
information is sent to the remote processor during PD initialization
and the PD is treated as a privileged PD.

Ekansh Gupta (2):
  dt-bindings: misc: fastrpc: add fastrpc group IDs property
  misc: fastrpc: detect privileged processes based on group ID

 .../devicetree/bindings/misc/qcom,fastrpc.yaml     |   6 +
 drivers/misc/fastrpc.c                             | 124 +++++++++++++++++++++
 2 files changed, 130 insertions(+)

-- 
2.7.4

