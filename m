Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D3D74A604
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 23:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjGFVmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 17:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjGFVm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 17:42:28 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F8B19A0;
        Thu,  6 Jul 2023 14:42:27 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366LVEbs022729;
        Thu, 6 Jul 2023 21:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=nB+FrfRB00byByv0fjxvglIPHplvgPchqpWrlgRCZPM=;
 b=S/zyy80DBLgkkuGk2Cbcvj2ws4NtXGO1VR1jELLLdtygA36zVpPnsZ4if55o26fCjSIa
 9P1eUuO/4MdhhwSdbbCo9lY8pwz1L66s7+vTfrkMihWOm3CDEEan+3LX/vzgERMylF7e
 6Mz45N6xA+CcPYiI3ptZJi8OgSegFnhRNYjr2s4SwBq6W7ULVFSdRi5zRdvWLu5T88ZG
 MBPLwMWt1uCHIA9zHvU6bJdrNs2DkPqQzSrgcIWAOmbMwjGs8238GRtIVen/vOyuz+PV
 xfFXjf+nmtcqlEjxMSPQZ0iIZWK2BVM38nRtycFB5FsXotBdci8MaY58Qx0VFAZ+f96N xQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rnsu71hmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 21:42:22 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 366LgKVc010263
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Jul 2023 21:42:20 GMT
Received: from sarannya-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 6 Jul 2023 14:42:17 -0700
From:   Sarannya S <quic_sarannya@quicinc.com>
To:     <quic_bjorande@quicinc.com>, <arnaud.pouliquen@foss.st.com>,
        <swboyd@chromium.org>, <quic_clew@quicinc.com>,
        <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Sarannya S <sarannya@qti.qualcomm.com>
Subject: [PATCH V9 0/3] rpmsg signaling/flowcontrol patches
Date:   Fri, 7 Jul 2023 03:11:35 +0530
Message-ID: <1688679698-31274-1-git-send-email-quic_sarannya@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Pi5Y8vJEImoUSXfkDmfpgAbiLWOkmquk
X-Proofpoint-ORIG-GUID: Pi5Y8vJEImoUSXfkDmfpgAbiLWOkmquk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_15,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=711
 adultscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307060189
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sarannya S <sarannya@qti.qualcomm.com>

Changes from V8:
* Updated the argument for RPMSG_SET_INCOMING_FLOWCONTROL to int.
* Return -EINVAL if arg > 1 in RPMSG_SET_INCOMING_FLOWCONTROL.

Key changes from earlier revisions:
* Added two new RPMSG IOCTLs for rpmsg_char- RPMSG_GET_SIGNAL_IOCTRL and RPMSG_SET_SIGNAL_IOCTRL, to set/get the flow.
* Updated the cmd name 'RPM_CMD_SIGNALS' to 'GLINK_CMD_SIGNALS'.
* Return EOPNOTSUPP error in rpmsg_set_flow_control(), if the backend does not support flow control ops.
* For rpmsg_set_flow_control, change "EXPORT_SYMBOL" to "EXPORT_SYMBOL_GPL".
* Change return type of qcom_glink_handle_signals() from int to void.
* Added destination address of the endpoint as parameter in rpmsg_set_flow_control.
* Changed 'remote_flow' to bool type, and updated it's evaluation.
* Updated evaluation of 'set' in rpmsg_char as 'set = !!arg'.

Chris Lew (2):
  rpmsg: glink: Add support to handle signals command
  rpmsg: char: Add RPMSG GET/SET FLOWCONTROL IOCTL support

Deepak Kumar Singh (1):
  rpmsg: core: Add signal API support

 drivers/rpmsg/qcom_glink_native.c | 56 +++++++++++++++++++++++++++++++++++++++
 drivers/rpmsg/rpmsg_char.c        | 54 ++++++++++++++++++++++++++++++++-----
 drivers/rpmsg/rpmsg_core.c        | 21 +++++++++++++++
 drivers/rpmsg/rpmsg_internal.h    |  2 ++
 include/linux/rpmsg.h             | 15 +++++++++++
 include/uapi/linux/rpmsg.h        | 10 +++++++
 6 files changed, 152 insertions(+), 6 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

