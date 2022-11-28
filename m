Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1FF63B105
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbiK1STg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbiK1SS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:18:56 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1753332BB5;
        Mon, 28 Nov 2022 10:03:15 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ASEojVs030763;
        Mon, 28 Nov 2022 18:03:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=ucO8Atl17X7ElpyQIHVCM9HDITRkhOkat1Joa2DQArU=;
 b=JfjjdscQxUhkuM0Xvz3QYXX9g0JjyF3cnusjNwNG3RnALvFL7DBPlU/hZkXADwQqtmAl
 cQnNpvZU34vknzM7qZW2QGuH0XEGrwaH0u/KrBNFwBwBO6Qyf0yo/O509Q36ifNhOgTu
 FyjbFr7+hYZWqXKWYV34aw5sYaV6XfBXdrvSLN2EKhvKMA0+2jQ1OsZQcuFQ2II7klXc
 K/1gpxZyjvz6hcb1gIoPY2a2efSgixl9jCXVzazaIpygDpfTevI7iJErXOwCM3hnom7I
 fb8bWWEmT+g3h9rAL+qA0wJIheC9KTPgKlexfaubThzVr0albC9hDrvLfipGbXZ7um3P 7Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m4y3x8ket-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 18:03:10 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2ASI390C005122
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 18:03:09 GMT
Received: from sarannya-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 28 Nov 2022 10:03:06 -0800
From:   Sarannya S <quic_sarannya@quicinc.com>
To:     <quic_bjorande@quicinc.com>, <arnaud.pouliquen@foss.st.com>,
        <swboyd@chromium.org>, <quic_clew@quicinc.com>,
        <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Sarannya S <quic_sarannya@quicinc.com>
Subject: [PATCH V4 0/3] rpmsg signaling/flowcontrol patches 
Date:   Mon, 28 Nov 2022 23:32:52 +0530
Message-ID: <1669658575-21993-1-git-send-email-quic_sarannya@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: iuQk1dXVhBilL58RmWxtjoSlrZkAsV2j
X-Proofpoint-GUID: iuQk1dXVhBilL58RmWxtjoSlrZkAsV2j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_15,2022-11-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=604 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211280132
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Change from V3]:
Fixed review comments in previous set.

Sarannya S (3):
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
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

