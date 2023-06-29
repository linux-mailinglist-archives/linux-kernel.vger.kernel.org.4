Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE95741EE3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 05:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjF2Dts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 23:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjF2Dt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 23:49:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86184273B;
        Wed, 28 Jun 2023 20:49:26 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T3buJU008598;
        Thu, 29 Jun 2023 03:49:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=UsZZNOMcEsr6zHnCwEOy39/yVjTTEJoQuHl0GKi18Co=;
 b=ScFU1tXyLOrXZHKP3/qBvOfztYw94gTcasrHcObtYwPDUxy39RfkzlNLjsl2aGlve5dG
 ArAVItQA+PkGuutv5w0Qkv8EkUHeG6OVR3nb1FhElrEPq5p60UzCFnR1c+80Lgy08jHr
 MPGkN3lAzBBMwSdlrbu9Dq3Z2XLAnpZtSAszqe01o+Tub6fi9pOUh3fcPnH7oJPck3yP
 ym6wSFJyS2DPFoCJYaktg/9NF1+EqPxx82Or4+AspMxpURgdYCGmhZIU7Vr99wcDIV3x
 7X3kkCqVzu48FlK/4atZRreJFf+kzdPf98K1d91Ur55OZYyzNbKlJ1ZJ7eQbPz3+nzu8 LA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rh0aag602-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 03:49:15 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35T3nEMS021687
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 03:49:14 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 28 Jun 2023 20:49:12 -0700
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <andrew@lunn.ch>, <hkallweit1@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux@armlinux.org.uk>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_sricharan@quicinc.com>, Luo Jie <quic_luoj@quicinc.com>
Subject: [PATCH 3/3] net: phy: at803x: add qca8081 fifo reset on the link down
Date:   Thu, 29 Jun 2023 11:48:46 +0800
Message-ID: <20230629034846.30600-4-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230629034846.30600-1-quic_luoj@quicinc.com>
References: <20230629034846.30600-1-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7BYEfI2D6UCswZP0I9C8Et4V0Lu7pKVx
X-Proofpoint-ORIG-GUID: 7BYEfI2D6UCswZP0I9C8Et4V0Lu7pKVx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306290032
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qca8081 fifo needs to be reset on link down and released
on the link up in case of any abnormal issue such as the
packet blocked on the PHY.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/phy/at803x.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 29aab7eaaa90..5dc707eaf18c 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -276,6 +276,9 @@
 #define QCA808X_PHY_MMD7_CHIP_TYPE		0x901d
 #define QCA808X_PHY_CHIP_TYPE_1G		BIT(0)
 
+#define QCA8081_PHY_SERDES_MMD1_FIFO_CTRL	0x9072
+#define QCA8081_PHY_FIFO_RSTN			BIT(11)
+
 MODULE_DESCRIPTION("Qualcomm Atheros AR803x and QCA808X PHY driver");
 MODULE_AUTHOR("Matus Ujhelyi");
 MODULE_LICENSE("GPL");
@@ -1808,6 +1811,16 @@ static int qca808x_config_init(struct phy_device *phydev)
 			QCA808X_ADC_THRESHOLD_MASK, QCA808X_ADC_THRESHOLD_100MV);
 }
 
+static int qca808x_fifo_reset(struct phy_device *phydev)
+{
+	/* Reset serdes fifo on link down, Release serdes fifo on link up,
+	 * the serdes address is phy address added by 1.
+	 */
+	return mdiobus_c45_modify_changed(phydev->mdio.bus, phydev->mdio.addr + 1,
+			MDIO_MMD_PMAPMD, QCA8081_PHY_SERDES_MMD1_FIFO_CTRL,
+			QCA8081_PHY_FIFO_RSTN, phydev->link ? QCA8081_PHY_FIFO_RSTN : 0);
+}
+
 static int qca808x_read_status(struct phy_device *phydev)
 {
 	int ret;
@@ -1827,6 +1840,10 @@ static int qca808x_read_status(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
+	ret = qca808x_fifo_reset(phydev);
+	if (ret < 0)
+		return ret;
+
 	if (phydev->link) {
 		if (phydev->speed == SPEED_2500)
 			phydev->interface = PHY_INTERFACE_MODE_2500BASEX;
-- 
2.17.1

