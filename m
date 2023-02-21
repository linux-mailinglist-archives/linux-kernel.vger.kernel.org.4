Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9487E69E26A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 15:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbjBUOfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 09:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbjBUOfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 09:35:46 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83362005F;
        Tue, 21 Feb 2023 06:35:45 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LB9MPR024326;
        Tue, 21 Feb 2023 14:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=AC1xYKipaPJWbKj69BmeE0bYdn5l/8Aabloq8JJcKV8=;
 b=XZgAexUCF6b/OYEXVchLxf+cRTKv9hFaCS+mCVg8OHyeih2qJgh3lUlRaEZMyljlnEcG
 QRw5B1pfQbfnrbwpYFA/cMiAqPu3wXsItoo+u+qHgqj5BbCYjGpphSNO4V6k0m+S/cXe
 DnwkprA/Cluv0dfFoNSh7LYXB6JvmIXLN30IkxZBNiGq02euqJJKQfNWpIoNQK5kYBCs
 QQ5fpBXuvHwSOlwWXe0WmTykqr0+mpszIx0chGvR+aC2IDMHUvCVNhNA+r+547XHsA7Z
 5dzRy8I6cZb8fFE4v9spDaIJlN93hRBTUbn/84oj1UGGX7tj58JSwmLjbjbOKQcb7Abo nQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nvvrrge22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 14:35:41 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31LEZeZ8024752
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 14:35:40 GMT
Received: from sarannya-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 21 Feb 2023 06:35:36 -0800
From:   Sarannya S <quic_sarannya@quicinc.com>
To:     <quic_bjorande@quicinc.com>, <arnaud.pouliquen@foss.st.com>,
        <swboyd@chromium.org>, <quic_clew@quicinc.com>,
        <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Sarannya S <quic_sarannya@quicinc.com>
Subject: [PATCH V5 0/3] rpmsg signaling/flowcontrol patches
Date:   Tue, 21 Feb 2023 20:05:11 +0530
Message-ID: <1676990114-1369-1-git-send-email-quic_sarannya@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MNyi_RZ2S6STRRaHnGAWBhi1X6fW4E9R
X-Proofpoint-ORIG-GUID: MNyi_RZ2S6STRRaHnGAWBhi1X6fW4E9R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_08,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=456 priorityscore=1501 adultscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302210121
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added two new RPMSG IOCTLs for rpmsg_char- RPMSG_GET_SIGNAL_IOCTRL and
RPMSG_SET_SIGNAL_IOCTRL, to set/get the flow.
Addressed review comments for changing variable names/ desciptions.

Sarannya S (3):
  rpmsg: core: Add signal API support
  rpmsg: glink: Add support to handle signals command
  rpmsg: char: Add TIOCMGET/TIOCMSET ioctl support

 arch/arm64/boot/Image.gz-dtb      | Bin 0 -> 12413735 bytes
 drivers/rpmsg/qcom_glink_native.c |  63 ++++++++++++++++++++++++++++++++++++++
 drivers/rpmsg/rpmsg_char.c        |  60 +++++++++++++++++++++++++++++++-----
 drivers/rpmsg/rpmsg_core.c        |  20 ++++++++++++
 drivers/rpmsg/rpmsg_core.c.rej    |  11 +++++++
 drivers/rpmsg/rpmsg_internal.h    |   2 ++
 include/linux/rpmsg.h             |  15 +++++++++
 include/uapi/linux/rpmsg.h        |  11 +++++++
 8 files changed, 174 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/boot/Image.gz-dtb
 create mode 100644 drivers/rpmsg/rpmsg_core.c.rej

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

