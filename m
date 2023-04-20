Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5B26E8A4A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 08:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjDTGWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 02:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbjDTGWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 02:22:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB70C4EC6;
        Wed, 19 Apr 2023 23:22:05 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33K4ccUm014832;
        Thu, 20 Apr 2023 06:21:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=JwmapguWBdTRkDjinAe7jlDp1FMI8FQWcW6ykNvkW8g=;
 b=mIdRosnZoQ7w4jGMJ/K52MtsGK70UZ82ety7duPZdrU7luPwza9+pvbxg1W/yr+l1bga
 Qwu8GwYvkdmDMaAL71C3w4cN3KrUajwCZpp7prIm241g039jXY1L/ta0+H20Q6rBl2L9
 LdVSnF7FybuQbv40AjJaBdNle1lXi/ysKAdjdwQTAQxtzTRVi2se6xQ58JYPPDmPNwA3
 Ur1DPCt78AeZXFxYktCxwKEf/mKMXacruFtaF4wrwCSTP11SCpbUO+0JAFFAaqXFm30D
 AddJlxfwjBiW5/+SsS68pnkw7FTi/LdOFBPERpPPVeDy0grBF/9uhkEn1F9YEs+fA3qH LQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q2dy7tgqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 06:21:59 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33K6Lwr6028210
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 06:21:58 GMT
Received: from sarannya-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 19 Apr 2023 23:21:55 -0700
From:   Sarannya S <quic_sarannya@quicinc.com>
To:     <quic_bjorande@quicinc.com>, <arnaud.pouliquen@foss.st.com>,
        <swboyd@chromium.org>, <quic_clew@quicinc.com>,
        <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Sarannya S <quic_sarannya@quicinc.com>
Subject: [PATCH V6 0/3] rpmsg signaling/flowcontrol patches
Date:   Thu, 20 Apr 2023 11:51:26 +0530
Message-ID: <1681971690-28858-1-git-send-email-quic_sarannya@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 95E1_EKwq6mSy_NNBf5QmaiILnCB-nwH
X-Proofpoint-GUID: 95E1_EKwq6mSy_NNBf5QmaiILnCB-nwH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_03,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=733 clxscore=1015
 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxscore=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304200050
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added new IOCTLS- RPMSG_GET_OUTGOING_FLOWCONTROL and RPMSG_SET_INCOMING_FLOWCONTROL
to get/set the rpmsg char device's flow control signal.
Updated the cmd name 'RPM_CMD_SIGNALS' to 'GLINK_CMD_SIGNALS'.
Changed 'remote_flow' to bool type, and updated it's evaluation.
Updated evaluation of 'set' in rpmsg_char as 'set = !!arg'.
Add destination address of endpoint as parameter in rpmsg_set_flow_control.
Addressed review comments to change variable names/descriptions.

Chris Lew (2):
  rpmsg: glink: Add support to handle signals command
  rpmsg: char: Add RPMSG GET/SET FLOWCONTROL IOCTL support

Deepak Kumar Singh (1):
  rpmsg: core: Add signal API support

 drivers/rpmsg/qcom_glink_native.c | 64 +++++++++++++++++++++++++++++++++++++++
 drivers/rpmsg/rpmsg_char.c        | 49 ++++++++++++++++++++++++++----
 drivers/rpmsg/rpmsg_core.c        | 21 +++++++++++++
 drivers/rpmsg/rpmsg_internal.h    |  2 ++
 include/linux/rpmsg.h             | 15 +++++++++
 include/uapi/linux/rpmsg.h        | 11 ++++++-
 6 files changed, 155 insertions(+), 7 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

