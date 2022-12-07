Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB145645A58
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiLGNEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLGNEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:04:38 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2879626579;
        Wed,  7 Dec 2022 05:04:38 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7CsV3w014630;
        Wed, 7 Dec 2022 13:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=j9cx/MFjSByXA+OajzqQzpgqiNPs1L1NiMIX2tLCsCo=;
 b=PCj4ZmB/TQz6DZfXF+wtQQVgEg9VwlFjWTdbp6LnCVgIXayT47jpW2HzrGWi7cNuHCaz
 v2FTY3/6IMKN4AXig/cvnS3f+h8MlZcAX7skG9OJs6/wxy3kFVI5mzrztgxO4W6F2XAF
 iY5qwOog9/AD9Dfr+r0y6qssk1F+ZHmV8vNVXeWdH2NaVc3M3AEG9w8ziJWy+LL74euC
 YaTGgapUfSjeQsx/0LYxkB96egfbgh3Xky8kVmEltqeT0dDphvtyUdU8yX2qYCW13iwQ
 goBhS3dBOHIWVGF6jOC/T0kMeMnhhdf3YGzohbcawWjP/w0XU2/fKJ/ZBTUDpucwsGXB 2g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3marj0rdt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Dec 2022 13:04:33 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B7D4WSj029283
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Dec 2022 13:04:32 GMT
Received: from sarannya-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 7 Dec 2022 05:04:29 -0800
From:   Sarannya S <quic_sarannya@quicinc.com>
To:     <quic_bjorande@quicinc.com>, <arnaud.pouliquen@foss.st.com>,
        <swboyd@chromium.org>, <quic_clew@quicinc.com>,
        <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Sarannya S <quic_sarannya@quicinc.com>
Subject: [PATCH V4 0/3] rpmsg signaling/flowcontrol patches
Date:   Wed, 7 Dec 2022 18:34:15 +0530
Message-ID: <1670418258-11502-1-git-send-email-quic_sarannya@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sQSHeCWpDPPAU8TTWF5_rcQwyFsHbaqG
X-Proofpoint-GUID: sQSHeCWpDPPAU8TTWF5_rcQwyFsHbaqG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_05,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=683 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212070112
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added destination address of the endpoint as parameter in rpmsg_set_flow_control.
Zero initialized sigs variable in qcom_glink_set_flow_control.
Renamed rpmsg_flow_cb to rpmsg_ept_flow_cb.


Sarannya S (3):
  rpmsg: core: Add signal API support
  rpmsg: glink: Add support to handle signals command
  rpmsg: char: Add TIOCMGET/TIOCMSET ioctl support

 drivers/rpmsg/qcom_glink_native.c | 64 +++++++++++++++++++++++++++++++++++++++
 drivers/rpmsg/rpmsg_char.c        | 60 +++++++++++++++++++++++++++++++-----
 drivers/rpmsg/rpmsg_core.c        | 21 +++++++++++++
 drivers/rpmsg/rpmsg_internal.h    |  2 ++
 include/linux/rpmsg.h             | 15 +++++++++
 5 files changed, 154 insertions(+), 8 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

