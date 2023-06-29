Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BF7741EE0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 05:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjF2Dtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 23:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjF2Dt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 23:49:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E6F272D;
        Wed, 28 Jun 2023 20:49:25 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T3e9ox003236;
        Thu, 29 Jun 2023 03:49:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=QNEB0DBltSLS10Mp5KhryDGdmT/xI1ynZUs/jysRrQk=;
 b=jD0zOlrlfghslqLU+8esTioSUdwOzdueDUePz8YMAh57FpoeK7br47gCHeYkEogT5SwN
 hAghNwr3P4K4zpKPQHOsIdcUKf6HTGoXy8n4B6HP7Y1LlPtRKDbhYKNpa9vfxVHPsaJ1
 wzP7lLSLE9QFpl/muGWnTVzuB+zonQ6S2PD8XmxCyRLqIcjghKmv9c4AJXKXDseyIbVv
 6eAS8mc65c7Sxm6CBqGSW1KHK1ByFtLNAsKTJnrNugHaXBFzHjC+HqXDeldQycw2UfmT
 EInZQvUfW7iTJ9Bj9JTXOg2QDChNZ4dXL+wbup+bO5kczPAkABlSwhw0qnlXVUCbb6tI eg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgfp3tc0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 03:49:07 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35T3n6wQ021634
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 03:49:06 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 28 Jun 2023 20:49:03 -0700
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <andrew@lunn.ch>, <hkallweit1@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux@armlinux.org.uk>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_sricharan@quicinc.com>, Luo Jie <quic_luoj@quicinc.com>
Subject: [PATCH 0/3] net: phy: at803x: support qca8081 1G version chip
Date:   Thu, 29 Jun 2023 11:48:43 +0800
Message-ID: <20230629034846.30600-1-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dKDfZuQcpqdeSMEHxqnn1vKM47qirvvY
X-Proofpoint-ORIG-GUID: dKDfZuQcpqdeSMEHxqnn1vKM47qirvvY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=545
 clxscore=1011 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306290032
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add supporting qca8081 1G version chip, the 1G version
chip can be identified by the register mmd7.0x901d bit0.

In addition, qca8081 does not support 1000BaseX mode and the fifo reset
is added on the link changed, which assert the fifo on the link down,
deassert the fifo on the link up.

Luo Jie (3):
  net: phy: at803x: support qca8081 1G chip type
  net: phy: at803x: remove 1000BaseX mode of qca8081
  net: phy: at803x: add qca8081 fifo reset on the link down

 drivers/net/phy/at803x.c | 79 +++++++++++++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 21 deletions(-)


base-commit: ae230642190a51b85656d6da2df744d534d59544
-- 
2.17.1

