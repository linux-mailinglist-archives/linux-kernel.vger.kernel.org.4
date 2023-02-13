Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77BF694BBE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjBMPwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjBMPw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:52:27 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982271A643;
        Mon, 13 Feb 2023 07:52:26 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DFkmbd000824;
        Mon, 13 Feb 2023 15:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=0VvJRIYUJ1Q+yZA+rhwDocPrDjS8d43jsTRHEy+Ms7Y=;
 b=V5won4fXBo0kPt/KxsZwg1y+heSfHdoiF/2VipEk9ZsaDQzHCcHJrelW2RqjjKxebDNc
 Dt36z6cGww2J6UH9RPtivwdqLP0KBpD07NzPL1Pc65/sNcYcEYwoCIQVtG6pt4nIaYp1
 gYE8IlM3V0kUQ5b1Zu+WjYtthfQjSWFnQlnjvRlbbzB2OJUV/oXf+SezIOpTOnx2DT4d
 /1qbKPIdpdbFTR68J24i/DNagwAY+Kq8eXxrT5aO8A00hTJcZttIuOsr16/leeLrYG9P
 V8rEK6rzuDIds4CXftxDfviQ2dJTAiUi2WPJZn115+Q6RhtPCFNB4/hmogLYxCe7WyJu cw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3np21fvmu9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 15:52:22 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31DFqL1I012099
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 15:52:21 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 13 Feb 2023 07:52:20 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Chris Lew <quic_clew@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/6] rpmsg: glink: Misc improvements
Date:   Mon, 13 Feb 2023 07:52:09 -0800
Message-ID: <20230213155215.1237059-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4Usmd3l17Y4EajOPMYEpzdTJ6WbMmslU
X-Proofpoint-ORIG-GUID: 4Usmd3l17Y4EajOPMYEpzdTJ6WbMmslU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_10,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 adultscore=0 spamscore=0 mlxlogscore=755 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302130143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

 drivers/remoteproc/qcom_common.h  |  3 +-
 drivers/rpmsg/qcom_glink_native.c | 93 +++++++++++++----------------
 drivers/rpmsg/qcom_glink_native.h |  3 +-
 drivers/rpmsg/qcom_glink_rpm.c    | 94 +++++++++++++++++++++++------
 drivers/rpmsg/qcom_glink_smem.c   | 98 +++++++++++++++++++++++++++----
 include/linux/rpmsg/qcom_glink.h  | 12 ++--
 6 files changed, 212 insertions(+), 91 deletions(-)

-- 
2.25.1

