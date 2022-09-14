Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3655B80D3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 07:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiINFZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 01:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiINFZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 01:25:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761041FCE3;
        Tue, 13 Sep 2022 22:25:38 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E4WKcv022370;
        Wed, 14 Sep 2022 05:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=kf1PjFo7IM7XRsc38i/cpBBRWGBAbq5ROsOen1zVJPQ=;
 b=ixe5wnLq0Kx7pK2WcxncGxowsbMgJ6XK0H6TT4HMt+OPMgSQssW44++z6y425/CPU4h2
 rrUDx5+B1PJ0zH3wyTKiKgPok8QbPV4GtXGiHGOsMrfqcBr1InQ2ajrKE4p51vuu10Hf
 ncUggdbzx7QbpPbu/iRQTt4YnbcJ+e4iSLGO7Q6YyAgDUaB2nFWs79RBx6egMZW0ok7a
 kL53JKKuT0NuTK55hnXbolNaXjYSXWjpDxNL/CiXKbQQRiveSYN+cs1ASgWG/OJDnjxa
 Vo2G78ydED3tbPSSSznGk9NHEE561jsHMcSJBXcdg/4W8Ci9vGC/VVJGdfblS2k0vKWh ew== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jjxys1cb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 05:25:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28E5PWtL016778
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 05:25:32 GMT
Received: from deesin-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 13 Sep 2022 22:25:29 -0700
From:   Deepak Kumar Singh <quic_deesin@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <arnaud.pouliquen@foss.st.com>,
        <swboyd@chromium.org>, <quic_clew@quicinc.com>,
        <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>
Subject: [PATCH V3 0/3] rpmsg signaling/flowcontrol patches
Date:   Wed, 14 Sep 2022 10:54:59 +0530
Message-ID: <1663133102-10671-1-git-send-email-quic_deesin@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NYomRweMdH66E2_KeY1Ta1lBonlpiz8b
X-Proofpoint-GUID: NYomRweMdH66E2_KeY1Ta1lBonlpiz8b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_02,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0
 adultscore=0 mlxlogscore=519 spamscore=0 clxscore=1011 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140025
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Changes from V2]:
Trivial review comment fixes.
Avoid TIOCM_DTR etc signals in glink layer, use native signal macros only.
Glink layer to provide only flowcontrol on/off interface, no specific signal passing/receiving to client.

Deepak Kumar Singh (3):
  rpmsg: core: Add signal API support
  rpmsg: glink: Add support to handle signals command
  rpmsg: char: Add TIOCMGET/TIOCMSET ioctl support

 drivers/rpmsg/qcom_glink_native.c | 63 +++++++++++++++++++++++++++++++++++++++
 drivers/rpmsg/rpmsg_char.c        | 60 ++++++++++++++++++++++++++++++++-----
 drivers/rpmsg/rpmsg_core.c        | 20 +++++++++++++
 drivers/rpmsg/rpmsg_internal.h    |  2 ++
 include/linux/rpmsg.h             | 15 ++++++++++
 5 files changed, 152 insertions(+), 8 deletions(-)

-- 
2.7.4

