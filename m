Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC78746CA3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 11:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjGDJBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 05:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbjGDJBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:01:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EFD13D;
        Tue,  4 Jul 2023 02:01:23 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3645u2Ii020368;
        Tue, 4 Jul 2023 09:00:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=9P5eBdVfLtYOOJDULc0BTnaORrTk/ZJWH4Jn1CflL6U=;
 b=K+Lkq4J3judG6rPGwm3CJuqmSKDB9m8dts/n+dQLWML/vgKyjGnNusI6CFDkZO6H622v
 uVgyaoLNV20r80ugJrVWNJLeDJLGrnylRcURSV2rHATIzCLDiLF5RN2jjsdAXGhSw+/b
 3TeZFbrRulYgdkC4T+Gc5O24Dk8Fu5lbcqoV3IymXlh2uNQfkF32MsQod2SXc/4nmU+z
 8MHAMcv2DU2avhc1h3u7qx0MjaZO5F97IXVFMlU+Qlm9N2cMWzRlouMQNfp2OQu0TSCe
 +QaVX2Y7VwkW2O3a3yRe8eeUFAoecv3LeZd913t+sTTFCnnutYiR0OB9eTzJctEovtVh iQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rm14jhh4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jul 2023 09:00:57 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36490u59027942
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Jul 2023 09:00:56 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.7; Tue, 4 Jul 2023 02:00:52 -0700
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Luo Jie <quic_luoj@quicinc.com>
Subject: [PATCH v1 0/2] net: phy: at803x: support qca8081 1G version chip
Date:   Tue, 4 Jul 2023 17:00:14 +0800
Message-ID: <20230704090016.7757-1-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UcSZblCWcQPUzT0Ik_faRiPgIlrPoNCS
X-Proofpoint-ORIG-GUID: UcSZblCWcQPUzT0Ik_faRiPgIlrPoNCS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_04,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=590 lowpriorityscore=0
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307040074
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add supporting qca8081 1G version chip, the 1G version
chip can be identified by the register mmd7.0x901d bit0.

In addition, qca8081 does not support 1000BaseX mode and the sgmii fifo
reset is added on the link changed, which assert the fifo on the link
down, deassert the fifo on the link up.

Changes in v1:
	* switch to use genphy_c45_pma_read_abilities.
	* Remove the patch [remove 1000BaseX mode of qca8081].
	* move the sgmii fifo reset to link_change_notify.

Luo Jie (2):
  net: phy: at803x: support qca8081 1G chip type
  net: phy: at803x: add qca8081 fifo reset on the link changed

 drivers/net/phy/at803x.c | 95 ++++++++++++++++++++++++++++------------
 1 file changed, 68 insertions(+), 27 deletions(-)


base-commit: 3a8a670eeeaa40d87bd38a587438952741980c18
-- 
2.17.1

