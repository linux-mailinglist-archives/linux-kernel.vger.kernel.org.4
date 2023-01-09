Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E49663428
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 23:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237614AbjAIWku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 17:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237868AbjAIWkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 17:40:12 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A265B13CD5;
        Mon,  9 Jan 2023 14:40:11 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309LFQcU024355;
        Mon, 9 Jan 2023 22:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=7Et2WCdafeFmG36VVKCpuOp0/eItwRJfS/YkPw93ZB0=;
 b=EkXcfv4cOU5rX15Evr2HSVM2sT90/7m7zgSpc9WO/lLXSf8zM8KOrj6qAr8SfTNAaMcZ
 9vDymHDbjzvDOKpzekV41wOCZe2eIw1mt+x8mHQN42uwnj2EoEgXgS3rOtSP9yAhgajU
 35HlBAxK3hSGkHWf33NVUZCEgEnP7RU0WNIofX3oTsazi+iLXHzgLs94XboPvBuowDSU
 sQO3RTm6kc0aw+MkBR/RHbcP1g0aWFqOIKxFVv9kwnjCEPXfqrKlxq04NWiiH+wlbLzi
 zVr/JO9n2/uy6piAXNhkWgsoODCPyI9U4jYOdrPNJK+ty6havQ6AWamHXOVFc5+UM4Da 3g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n0q6erk55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 22:40:08 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 309Me7hI026503
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Jan 2023 22:40:07 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 9 Jan 2023 14:40:06 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Chris Lew <quic_clew@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/6] rpmsg: glink: Misc improvements
Date:   Mon, 9 Jan 2023 14:39:55 -0800
Message-ID: <20230109224001.1706516-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SgYfXzDcFzwx9jqrlSr1B6R8-oZmoQfp
X-Proofpoint-ORIG-GUID: SgYfXzDcFzwx9jqrlSr1B6R8-oZmoQfp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_14,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=742
 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090157
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series refactors glink_native to move IRQ and mailbox handling to SMEM and
RPM driver, in preparation for more work. It then introduces the logic to fail
glink transactions and pending intent requests in the event of the edge being
torn down.

Bjorn Andersson (6):
  rpmsg: glink: Extract tx kick operation
  rpmsg: glink: smem: Wrap driver context
  rpmsg: glink: rpm: Wrap driver context
  rpmsg: glink: Move irq and mbox handling to transports
  rpmsg: glink: Fail qcom_glink_tx() once remove has been initiated
  rpmsg: glink: Cancel pending intent requests at removal

 drivers/remoteproc/qcom_common.h  |   3 +-
 drivers/rpmsg/qcom_glink_native.c |  93 ++++++++++-----------
 drivers/rpmsg/qcom_glink_native.h |   3 +-
 drivers/rpmsg/qcom_glink_rpm.c    |  94 ++++++++++++++++-----
 drivers/rpmsg/qcom_glink_smem.c   | 132 +++++++++++++++++++++++-------
 include/linux/rpmsg/qcom_glink.h  |  12 +--
 6 files changed, 228 insertions(+), 109 deletions(-)

-- 
2.37.3

