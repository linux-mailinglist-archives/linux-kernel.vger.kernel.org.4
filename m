Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA0A6E7B54
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 15:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjDSNyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 09:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbjDSNyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:54:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9FF13C0A;
        Wed, 19 Apr 2023 06:54:01 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33J9W1Wc030480;
        Wed, 19 Apr 2023 13:53:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=bOP9REL4bDVbPp5LAmiFsanF4KApVmQdSdmb2BgMyBg=;
 b=Kt8wBQfkIZsK+mFwfHdw+GhVa/MdnvCNgSmzrL0bcipJatdT7IrSk5NRh83IfQvY92wW
 SGp1LMcPse1cmQWP4I2opsizJB5agaf1W7GGJ+uIAQtKutX3BSqaBbbkBQXhPk18qBaA
 LmWE1Td0Yyw+RFNj6B1PEMFjBg1AgSVAr+0aQELitG97nvPT+ZpjOU6jQ8MJdiLWzBAp
 kkHQ0dohXMCSV3DcS5uOp8otGOk59Hr4UohYivR1xam4arslKELpDyxUMf8j1zhhC8yl
 snQsp01PUJxPHQ1PHJNs9EBYDLe/XT/ejg2BmM9xa3QQnqrulYu9AJPX73/SPgMoeby1 gg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q1wxk2uvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Apr 2023 13:53:55 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33JDrr11008758
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Apr 2023 13:53:54 GMT
Received: from sarannya-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 19 Apr 2023 06:53:50 -0700
From:   Sarannya S <quic_sarannya@quicinc.com>
To:     <quic_bjorande@quicinc.com>, <arnaud.pouliquen@foss.st.com>,
        <swboyd@chromium.org>, <quic_clew@quicinc.com>,
        <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Sarannya S <quic_sarannya@quicinc.com>
Subject: [PATCH V6 0/3] rpmsg signaling/flowcontrol patches
Date:   Wed, 19 Apr 2023 19:23:25 +0530
Message-ID: <1681912409-25248-1-git-send-email-quic_sarannya@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kEsJYGKdySadr_5KaHtvw6QzAz8a8WZh
X-Proofpoint-ORIG-GUID: kEsJYGKdySadr_5KaHtvw6QzAz8a8WZh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-19_08,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=648 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304190123
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added new IOCTLS- RPMSG_GET_OUTGOING_FLOWCONTROL and RPMSG_SET_INCOMING_FLOWCONTROL
to get/set the rpmsg char device's flow control signal.
Update the cmd name 'RPM_CMD_SIGNALS' to 'GLINK_CMD_SIGNALS'.
Changed 'remote_flow' to bool type, and updated it's evaluation.
Updated evaluation 'set' in rpmsg_char as 'set = !!arg'.
Addressed review comments to change variable names/descriptions.

Chris Lew (1):
  rpmsg: glink: Add support to handle signals command

Deepak Kumar Singh (1):
  rpmsg: core: Add signal API support

Sarannya S (1):
  rpmsg: char: Add RPMSG GET/SET FLOWCONTROL IOCTL support

 drivers/rpmsg/qcom_glink_native.c | 64 +++++++++++++++++++++++++++++++++++++++
 drivers/rpmsg/rpmsg_char.c        | 53 ++++++++++++++++++++++++++++----
 drivers/rpmsg/rpmsg_core.c        | 21 +++++++++++++
 drivers/rpmsg/rpmsg_internal.h    |  2 ++
 include/linux/rpmsg.h             | 15 +++++++++
 include/uapi/linux/rpmsg.h        | 11 ++++++-
 6 files changed, 159 insertions(+), 7 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

