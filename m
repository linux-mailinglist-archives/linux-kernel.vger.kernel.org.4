Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC89709C98
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjESQkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjESQj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:39:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7F5118
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:39:56 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JDrSNv018183;
        Fri, 19 May 2023 16:39:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=PmwwrCpP7s99PhPdzluX1Sv8XiSbaEIsrIgEmINB0Rk=;
 b=Wf0SRleSvO52qMXB7aGBehpJV6kPHzKuuhCOvZuJTg8l9rA4j/y+Sax68jgOMWuj7oJv
 ZbdIFTJ5yH8GbqwNw77+YnYwqw8b2jp2RgHGzlc01uV+FcuYP3oSHhI8//EemjOOtKXx
 +3KCM8G6AQpyucHAp2MyfpZkVjWB/KP5og1wlHGxgBMhk9Pr7UgajlxJAfdiNaQ2Gqob
 vgwLfUP9s2oUHxdWQuH2Oko1hCO84xLvhJw9qhW3tj85auRDkTYCrBlPFoyfXF7pv6cb
 N3t+XMFlMXxrbG2PAa59oBxt7LetLhMI3WJ0OBPZQuTKn1gE5EzETB7RtGGH5l9Eoi+0 jw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qpad1gh8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 16:39:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34JGdPGS028036
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 16:39:25 GMT
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 19 May 2023 09:39:24 -0700
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     <mani@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <mhi@lists.linux.dev>, Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Carl Vanderlip <quic_carlv@quicinc.com>,
        Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
Subject: [PATCH v2 2/2] accel/qaic: Add MHI_QUIRK_SOC_HW_VERSION_UNRELIABLE
Date:   Fri, 19 May 2023 10:39:02 -0600
Message-ID: <20230519163902.4170-3-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519163902.4170-1-quic_jhugo@quicinc.com>
References: <20230519163902.4170-1-quic_jhugo@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2sHiRmlS5lQ5Mg4baExhW76VCI9KLtuz
X-Proofpoint-ORIG-GUID: 2sHiRmlS5lQ5Mg4baExhW76VCI9KLtuz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190141
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AIC100 does not initialize the SOC_HW_VERSION MHI register as expected.
Some instances of AIC100 are observed to have 0xFFFFFFFF in this register
which makes the controller think that the link is down and return an error
up to MHI. This results in a failed initialization.

Allow these cards to initialize by advertising
MHI_QUIRK_SOC_HW_VERSION_UNRELIABLE in the MHI controller.

Change-Id: I62f31a063abf49e8f22ee2aa630d76babba83c8d
Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Reviewed-by: Carl Vanderlip <quic_carlv@quicinc.com>
Reviewed-by: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
---
 drivers/accel/qaic/mhi_controller.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/accel/qaic/mhi_controller.c b/drivers/accel/qaic/mhi_controller.c
index 5036e58e7235..2c85063d8cc6 100644
--- a/drivers/accel/qaic/mhi_controller.c
+++ b/drivers/accel/qaic/mhi_controller.c
@@ -400,6 +400,7 @@ static struct mhi_controller_config aic100_config = {
 	.event_cfg = aic100_events,
 	.use_bounce_buf = false,
 	.m2_no_db = false,
+	.quirks = MHI_QUIRK_SOC_HW_VERSION_UNRELIABLE,
 };
 
 static int mhi_read_reg(struct mhi_controller *mhi_cntrl, void __iomem *addr, u32 *out)
-- 
2.40.1

