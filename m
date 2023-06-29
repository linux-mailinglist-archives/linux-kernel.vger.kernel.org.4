Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE525741EDF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 05:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjF2Dti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 23:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjF2Dt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 23:49:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0F71BD3;
        Wed, 28 Jun 2023 20:49:24 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T3japp019917;
        Thu, 29 Jun 2023 03:49:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=uRKaP7DatgDduxvtLtj6NGLqcnXa/rZDM8YgpRlxzwo=;
 b=mGH+JMS5Qev5RQ78hYu8zsuVnjl3SjOYbA2V52MNsYWNP92BUkYoEnguE6cnW5F+eHL/
 7yPF5laxs1qbKSQadAPLxPpsxp2a/uLBIJK+szvEMvxOdx7/N3SYLok6p/VOPqhkKNVB
 MYmnMoR8Js02hOsd5qAUGG5dSkNlbPtnTw/C/sjc3q7dGDXaBmXX8DJpKFadeYCd7PSk
 4+K2EEIkhFTEqGx7QPomx84MElA/6yYgfxaMCjUUloygU1vX79Iys8KdMlXqbyKUALeZ
 LxGblZU88FGpclnVMHfJ+qzN/JVuTk5NfZPEYdvrER9yy9/E0QVm3EWWhcbwo7QNnwSr bA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgas2ttne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 03:49:10 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35T3n9L1023229
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 03:49:09 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 28 Jun 2023 20:49:06 -0700
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <andrew@lunn.ch>, <hkallweit1@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux@armlinux.org.uk>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_sricharan@quicinc.com>, Luo Jie <quic_luoj@quicinc.com>
Subject: [PATCH 1/3] net: phy: at803x: support qca8081 1G chip type
Date:   Thu, 29 Jun 2023 11:48:44 +0800
Message-ID: <20230629034846.30600-2-quic_luoj@quicinc.com>
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
X-Proofpoint-ORIG-GUID: vDnzgmAVvZMddROhTb9saxmgzf949VJl
X-Proofpoint-GUID: vDnzgmAVvZMddROhTb9saxmgzf949VJl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290032
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qca8081 1G chip version does not support 2.5 capability, which
is distinguished from qca8081 2.5G chip according to the bit0 of
register mmd7.0x901d.

The fast retrain and master slave seed configs are only needed when
the 2.5G capability is supported.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/phy/at803x.c | 58 ++++++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 20 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index c1f307d90518..3339ca372b24 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -272,6 +272,10 @@
 #define QCA808X_CDT_STATUS_STAT_OPEN		2
 #define QCA808X_CDT_STATUS_STAT_SHORT		3
 
+/* QCA808X 1G chip type */
+#define QCA808X_PHY_MMD7_CHIP_TYPE		0x901d
+#define QCA808X_PHY_CHIP_TYPE_1G		BIT(0)
+
 MODULE_DESCRIPTION("Qualcomm Atheros AR803x and QCA808X PHY driver");
 MODULE_AUTHOR("Matus Ujhelyi");
 MODULE_LICENSE("GPL");
@@ -898,12 +902,22 @@ static int at803x_get_features(struct phy_device *phydev)
 		return err;
 
 	if (phydev->drv->phy_id == QCA8081_PHY_ID) {
-		err = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_NG_EXTABLE);
+		err = phy_read_mmd(phydev, MDIO_MMD_AN, QCA808X_PHY_MMD7_CHIP_TYPE);
 		if (err < 0)
 			return err;
 
-		linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->supported,
-				err & MDIO_PMA_NG_EXTABLE_2_5GBT);
+		/* QCA808X does not support 2.5G capability if the chip type is 1G according
+		 * to the register MMD7.QCA808X_PHY_MMD7_CHIP_TYPE.
+		 */
+
+		if (!(QCA808X_PHY_CHIP_TYPE_1G & err)) {
+			err = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_NG_EXTABLE);
+			if (err < 0)
+				return err;
+
+			linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->supported,
+					err & MDIO_PMA_NG_EXTABLE_2_5GBT);
+		}
 	}
 
 	if (phydev->drv->phy_id != ATH8031_PHY_ID)
@@ -1770,20 +1784,22 @@ static int qca808x_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	/* Config the fast retrain for the link 2500M */
-	ret = qca808x_phy_fast_retrain_config(phydev);
-	if (ret)
-		return ret;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->supported)) {
+		/* Config the fast retrain for the link 2500M */
+		ret = qca808x_phy_fast_retrain_config(phydev);
+		if (ret)
+			return ret;
 
-	/* Configure lower ramdom seed to make phy linked as slave mode */
-	ret = qca808x_phy_ms_random_seed_set(phydev);
-	if (ret)
-		return ret;
+		/* Configure lower ramdom seed to make phy linked as slave mode */
+		ret = qca808x_phy_ms_random_seed_set(phydev);
+		if (ret)
+			return ret;
 
-	/* Enable seed */
-	ret = qca808x_phy_ms_seed_enable(phydev, true);
-	if (ret)
-		return ret;
+		/* Enable seed */
+		ret = qca808x_phy_ms_seed_enable(phydev, true);
+		if (ret)
+			return ret;
+	}
 
 	/* Configure adc threshold as 100mv for the link 10M */
 	return at803x_debug_reg_mask(phydev, QCA808X_PHY_DEBUG_ADC_THRESHOLD,
@@ -1822,11 +1838,13 @@ static int qca808x_read_status(struct phy_device *phydev)
 		 * value is configured as the same value, the link can't be up and no link change
 		 * occurs.
 		 */
-		if (phydev->master_slave_state == MASTER_SLAVE_STATE_ERR) {
-			qca808x_phy_ms_seed_enable(phydev, false);
-		} else {
-			qca808x_phy_ms_random_seed_set(phydev);
-			qca808x_phy_ms_seed_enable(phydev, true);
+		if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->supported)) {
+			if (phydev->master_slave_state == MASTER_SLAVE_STATE_ERR) {
+				qca808x_phy_ms_seed_enable(phydev, false);
+			} else {
+				qca808x_phy_ms_random_seed_set(phydev);
+				qca808x_phy_ms_seed_enable(phydev, true);
+			}
 		}
 	}
 
-- 
2.17.1

