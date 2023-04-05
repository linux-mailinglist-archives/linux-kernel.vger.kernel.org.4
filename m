Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36546D77C5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 11:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237527AbjDEJId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 05:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237052AbjDEJI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 05:08:28 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2075.outbound.protection.outlook.com [40.107.6.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7E493;
        Wed,  5 Apr 2023 02:08:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljy+5GwgqY/OSUz7XsOh/Fbqft5FPpZiQKU9P7km0pWpgzumswKvTPSiNwNRBOJvTjqRRE0bscZBW2HUik7DMMoQFbV8v7RF5x7/sDBo6V6etd31tiPZNgJoPaSdQAge0yDUGmGr5PCwfqKvKXcmUgRSkPVlJkNz+eNxN/77WHAJlLe84OdwMWqOQh0DhG8AVjFIirE2nYMMzmM3+HvaLjRl20CXQaBEcJKamV3pF8J0+eTznQXv1YxtKvesqOajhnpi7NDYqHeH8E2jFRljjp8TTYGA5wPl1xHvGga/Bw+T8HR1ai2aMSg5bQ2Vl3vSd8PACShJoYIBu1Gekzdwgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QD3459cwMhznOuzvdaKRcmOH5t8xzsn0l0Hb0cK0uh4=;
 b=fqqNXL4YKtpYKMI7hIlzKhHUhhzb2d9wGTSgKRTyTgr0tZJBOYet63AJejP5Gh+JPJEw6Qf1VGLVFHPze/HkQQaMIvdGk86GPU15OzyWaetvT7bzF7t/rXeIDkC8VCY4EuMbtvY9Vn11Q50FmoZ3yoHXI0yfWhLtA2aZzdGIiFoZcTy8kXPCGWwI3oaEwSBCwoPw5fTCmujk8xEn8hnCqAvdzSSKsYmW7sK7PIiLcwtHZxvLnIyX8ZNfAPSHc+Yq3tPSX9kHVbN1NMwuqQxPw9SzET4wd2vF+Z5f2WH78PXcH7YaHL1xlqESSTE0EUhTg4g/Bk5Hu4KPawq3xWF7Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QD3459cwMhznOuzvdaKRcmOH5t8xzsn0l0Hb0cK0uh4=;
 b=cg/04NkTIYAxDe59h2pFi177o0/MpsL5hoNa/RFr8uFxUTo+0q+w/+xGFczDUV5SOrwdEfXD9/BrrTsw99jvuGRiw7U51d2h0LYPXfs5k5Z4xHVB5m3frUKCI7FV3zDXXFsr7I2zxViYDt0igGrdJ0fDKSbZt2DHm5eFQqiqn8Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by AM8PR04MB7473.eurprd04.prod.outlook.com (2603:10a6:20b:1d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.29; Wed, 5 Apr
 2023 09:08:20 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::dca6:e1e8:f142:2bc5]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::dca6:e1e8:f142:2bc5%8]) with mapi id 15.20.6254.033; Wed, 5 Apr 2023
 09:08:20 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Varun Sethi <v.sethi@nxp.com>
Subject: [PATCH v3 1/2] crypto: caam - reduce page 0 regs access to minimum
Date:   Wed,  5 Apr 2023 11:07:51 +0200
Message-Id: <20230405090752.1708455-2-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230405090752.1708455-1-meenakshi.aggarwal@nxp.com>
References: <20230322061716.3195841-3-meenakshi.aggarwal@nxp.com>
 <20230405090752.1708455-1-meenakshi.aggarwal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0029.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::34) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9563:EE_|AM8PR04MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: abcefffc-1c80-4875-69e3-08db35b54d2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: khdZC0MjuJfZgJdZRQI36ivgNBGem4pt+q0cK2PfTtNR31HtOJlNOOAQ6Is1ANVIf0YvVtYAiXWLnaaDnOS8qF/5Yb4Yg6znfYjYg5fPbz3PfsZcNgVjViQhCeV3RvwNbiM2xzBZZntdEs2AjmyzzuA295+5pmO+GYQg3BSU+dIQdwvSyl4J1nXNhLgav1+Hjt4Q8QEA7EaowBrhYYG6YU5PsWClg+nB5Pmek3fo+oEkC/mZFNnqm3uVAkGl98iaLcOP9e10iWA0CU6q8xw69XB0It6tM5OkPKGru37dnwamJ5c2ZDza7EI/36Lzk68+ah6T+79jMaCgK0GFgzQmgJ4WYYMviOzMMzJKkiVccyUOeM0/ta2/nfSvkA0uryr9wP+ADt/H6swRrdWTEAX0y7OsXpUR0uRkqc8n2dj4Dak8H47dPEOtpiZGZTYCTg1BpDc0C5FiEjp85QfbXuPbtJNFW1XqPFd0sdFF+HRpIYDvUc/BMjhfSae0947ma6swfw/T9uxccqRbetZJfW3e5Kb9jvdBjyOxrrumMA5OB41DBSiK/2yxaWwCFVh+InO6tKvtoNDPZMNQNR/BDtnpy9wqNuOgbNK2l+Ay9yVCqaoCJrTOXLeLTOTJdkJDrjBP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(6666004)(86362001)(41300700001)(36756003)(186003)(30864003)(54906003)(6486002)(4326008)(8676002)(52116002)(478600001)(38100700002)(2906002)(66476007)(83380400001)(66946007)(66556008)(316002)(8936002)(38350700002)(26005)(5660300002)(2616005)(6512007)(9686003)(6506007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0h6wg6ooGc4RmAbMzcqncNSACUPN9/AYGtLlQdOkutAz7UGGaFuAq4W/V0dz?=
 =?us-ascii?Q?o80AOZfY9VN2Hte4wkC5u3scRCoH8IQdiWv4wVKDJwGMHXZ1EFRcR8doR0Jl?=
 =?us-ascii?Q?r6Yk+dNlpFthoBaQRDJ0dc2fjjJYnsCVurg+Y1BNm/65g+AYMEcuEd56JSPC?=
 =?us-ascii?Q?wHJoMqVFhlrxIyr4Th3iRKzvoM+0spykZRPE4c2sBrd3bnXlWjspW+cp2MKC?=
 =?us-ascii?Q?7v+8j9gPwVKROYNSwmfU345gGmL+VRG+PIbOH3GHRGISLHtUNG/bYSWJ+w/Q?=
 =?us-ascii?Q?pts7Tv2BWquI1XmPd7qTubElxNwf8NOk7PrB+uFX1v6j3cEWt10B1oAQP26G?=
 =?us-ascii?Q?nLNtCdFLxvLAX4SVDGfIEW8G8gb65bDD++17f3Fi5xtAdb2FEivIP3kSi+PT?=
 =?us-ascii?Q?AYThVG5qwp+rqY+IT/KA/GmCLwUhJvTHOjJOFZ7igGJW+yVjV9T15y5BwKGg?=
 =?us-ascii?Q?FllB2QG5YGmuEEtHw3Yl7kRuAL3RrLESIfYrvV/f9uKArfRkWmtgiq1YQ+/Z?=
 =?us-ascii?Q?4ILiw/svOMTO5onn1RRqTQel+uYeE65qaLZUKOyAZlL3nN16WGh2Nb1LT/3p?=
 =?us-ascii?Q?YYPehy0cmRAvAwG8SZTfnCWyAk2tijERYUjff7OouKdmB5756skPYc9Tm/ie?=
 =?us-ascii?Q?Id3ytJeM4o7mHTBnmooOjD5NX7URf373HO4SUR96vxQweDS/80h3dEo+/K8B?=
 =?us-ascii?Q?7HtUAF/0wnRzk5I0VPo/JpN2mdsHULKA3PAIKG/uUEf5PJpghpQ/x3/Qxz1f?=
 =?us-ascii?Q?VpTN9wHlK4bXrAtRoOS6LvYs99XTawnZMA5FupQWR5aaEWUA2WXq4MQjC2hP?=
 =?us-ascii?Q?A+CKbdXG6TfXnaVInTZrW86dt2zNFh65VOAPGP479W5+Y+ulk9CRJ5BmMEHz?=
 =?us-ascii?Q?Bw4k4YTQ1V/GZKixTRCR/9dIqS+jS/XseWtPcNMcrq6JDC9QzTD7A0m2f0bl?=
 =?us-ascii?Q?Nr3ZVFvxrv0SghmiyTRD4bu6GM5BMt5J6lr5dZWQGEMxO1TUzo9qa9Rayhvk?=
 =?us-ascii?Q?9yv34Kt9pBPA6MDxneqavJINm0WqjfI8NRtS+7M5kekd+hLzwlKOOz8fmkaD?=
 =?us-ascii?Q?PD4+0/2nqIrk65fvc+skAg4iA9AYRtgM155IMv2/a7p80RTLnAQjD8kA7gJO?=
 =?us-ascii?Q?IhxVfVTQiq6ka9XLNlhr6pM98qm1IHCqJYgRGzMC3LDujKSWTJrYfEnkK74y?=
 =?us-ascii?Q?WLZcs0fr2YspEmWn6AKoiTwA6z4wXlo4C1w1PMzk/Iw2ybrn6sMJOVJkBPVp?=
 =?us-ascii?Q?ifKxGs32qwQcIpw0iBwkcKmci/rTSwCLpkBEVSZKvXA0KR3YolHAZPdAxgz3?=
 =?us-ascii?Q?oNDbZwC3Jr5cAdUPx2tgmdLBbYO3Flc09Lssdqahhpa8ju148620YrFGDIlC?=
 =?us-ascii?Q?UbtpNbLBSqmYwbjpNUFgWrz/YojN/gjg9cUYHIM0xqSd1vKgWnYnrPDhbNy7?=
 =?us-ascii?Q?H/YskoLvIg1FzgssWpwRwDQ56XDceM9GDn10Nnt/f6su6UsVWaCj02uB4kuJ?=
 =?us-ascii?Q?BaMltbV41tTdEfnhdUh4IIwRGyKVYWsxgqW0f/P1iXcOL37O2cncCf/g8zFH?=
 =?us-ascii?Q?O4atr8kQ+komtSwtXYUSgRRcvRZYT8yXghSqdCFgkUKV/q00UhjfgiFTaDAI?=
 =?us-ascii?Q?7g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abcefffc-1c80-4875-69e3-08db35b54d2e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 09:08:20.4807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TzSGYuDNoPtl3pr5GQA/PFLnBGpWSumV3sMAVhGJ5UYAHYP2VbsoAJPSOf+yGuMuGN444A4PFuOKkjU29gMU9om0EZBEValNcNfxtFiK7aQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7473
X-Spam-Status: No, score=1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horia GeantA <horia.geanta@nxp.com>

Use job ring register map, in place of controller register map
to access page 0 registers, as access to the controller register
map is not permitted.

Signed-off-by: Horia GeantA <horia.geanta@nxp.com>
Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Reviewed-by: Varun Sethi <v.sethi@nxp.com>
---
 drivers/crypto/caam/caamalg.c  | 21 +++++----
 drivers/crypto/caam/caamhash.c | 10 ++--
 drivers/crypto/caam/caampkc.c  |  6 +--
 drivers/crypto/caam/caamrng.c  |  6 +--
 drivers/crypto/caam/ctrl.c     | 83 +++++++++++++++++++++-------------
 drivers/crypto/caam/debugfs.c  |  9 ++--
 drivers/crypto/caam/debugfs.h  |  7 ++-
 7 files changed, 84 insertions(+), 58 deletions(-)

diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index 12b1c8346243..feb86013dbf6 100644
--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -3,7 +3,7 @@
  * caam - Freescale FSL CAAM support for crypto API
  *
  * Copyright 2008-2011 Freescale Semiconductor, Inc.
- * Copyright 2016-2019 NXP
+ * Copyright 2016-2019, 2023 NXP
  *
  * Based on talitos crypto API driver.
  *
@@ -3542,13 +3542,14 @@ int caam_algapi_init(struct device *ctrldev)
 	 * First, detect presence and attributes of DES, AES, and MD blocks.
 	 */
 	if (priv->era < 10) {
+		struct caam_perfmon __iomem *perfmon = &priv->jr[0]->perfmon;
 		u32 cha_vid, cha_inst, aes_rn;
 
-		cha_vid = rd_reg32(&priv->ctrl->perfmon.cha_id_ls);
+		cha_vid = rd_reg32(&perfmon->cha_id_ls);
 		aes_vid = cha_vid & CHA_ID_LS_AES_MASK;
 		md_vid = (cha_vid & CHA_ID_LS_MD_MASK) >> CHA_ID_LS_MD_SHIFT;
 
-		cha_inst = rd_reg32(&priv->ctrl->perfmon.cha_num_ls);
+		cha_inst = rd_reg32(&perfmon->cha_num_ls);
 		des_inst = (cha_inst & CHA_ID_LS_DES_MASK) >>
 			   CHA_ID_LS_DES_SHIFT;
 		aes_inst = cha_inst & CHA_ID_LS_AES_MASK;
@@ -3556,23 +3557,23 @@ int caam_algapi_init(struct device *ctrldev)
 		ccha_inst = 0;
 		ptha_inst = 0;
 
-		aes_rn = rd_reg32(&priv->ctrl->perfmon.cha_rev_ls) &
-			 CHA_ID_LS_AES_MASK;
+		aes_rn = rd_reg32(&perfmon->cha_rev_ls) & CHA_ID_LS_AES_MASK;
 		gcm_support = !(aes_vid == CHA_VER_VID_AES_LP && aes_rn < 8);
 	} else {
+		struct version_regs __iomem *vreg = &priv->jr[0]->vreg;
 		u32 aesa, mdha;
 
-		aesa = rd_reg32(&priv->ctrl->vreg.aesa);
-		mdha = rd_reg32(&priv->ctrl->vreg.mdha);
+		aesa = rd_reg32(&vreg->aesa);
+		mdha = rd_reg32(&vreg->mdha);
 
 		aes_vid = (aesa & CHA_VER_VID_MASK) >> CHA_VER_VID_SHIFT;
 		md_vid = (mdha & CHA_VER_VID_MASK) >> CHA_VER_VID_SHIFT;
 
-		des_inst = rd_reg32(&priv->ctrl->vreg.desa) & CHA_VER_NUM_MASK;
+		des_inst = rd_reg32(&vreg->desa) & CHA_VER_NUM_MASK;
 		aes_inst = aesa & CHA_VER_NUM_MASK;
 		md_inst = mdha & CHA_VER_NUM_MASK;
-		ccha_inst = rd_reg32(&priv->ctrl->vreg.ccha) & CHA_VER_NUM_MASK;
-		ptha_inst = rd_reg32(&priv->ctrl->vreg.ptha) & CHA_VER_NUM_MASK;
+		ccha_inst = rd_reg32(&vreg->ccha) & CHA_VER_NUM_MASK;
+		ptha_inst = rd_reg32(&vreg->ptha) & CHA_VER_NUM_MASK;
 
 		gcm_support = aesa & CHA_VER_MISC_AES_GCM;
 	}
diff --git a/drivers/crypto/caam/caamhash.c b/drivers/crypto/caam/caamhash.c
index 82d3c730a502..80deb003f0a5 100644
--- a/drivers/crypto/caam/caamhash.c
+++ b/drivers/crypto/caam/caamhash.c
@@ -3,7 +3,7 @@
  * caam - Freescale FSL CAAM support for ahash functions of crypto API
  *
  * Copyright 2011 Freescale Semiconductor, Inc.
- * Copyright 2018-2019 NXP
+ * Copyright 2018-2019, 2023 NXP
  *
  * Based on caamalg.c crypto API driver.
  *
@@ -1956,12 +1956,14 @@ int caam_algapi_hash_init(struct device *ctrldev)
 	 * presence and attributes of MD block.
 	 */
 	if (priv->era < 10) {
-		md_vid = (rd_reg32(&priv->ctrl->perfmon.cha_id_ls) &
+		struct caam_perfmon __iomem *perfmon = &priv->jr[0]->perfmon;
+
+		md_vid = (rd_reg32(&perfmon->cha_id_ls) &
 			  CHA_ID_LS_MD_MASK) >> CHA_ID_LS_MD_SHIFT;
-		md_inst = (rd_reg32(&priv->ctrl->perfmon.cha_num_ls) &
+		md_inst = (rd_reg32(&perfmon->cha_num_ls) &
 			   CHA_ID_LS_MD_MASK) >> CHA_ID_LS_MD_SHIFT;
 	} else {
-		u32 mdha = rd_reg32(&priv->ctrl->vreg.mdha);
+		u32 mdha = rd_reg32(&priv->jr[0]->vreg.mdha);
 
 		md_vid = (mdha & CHA_VER_VID_MASK) >> CHA_VER_VID_SHIFT;
 		md_inst = mdha & CHA_VER_NUM_MASK;
diff --git a/drivers/crypto/caam/caampkc.c b/drivers/crypto/caam/caampkc.c
index e40614fef39d..72afc249d42f 100644
--- a/drivers/crypto/caam/caampkc.c
+++ b/drivers/crypto/caam/caampkc.c
@@ -3,7 +3,7 @@
  * caam - Freescale FSL CAAM support for Public Key Cryptography
  *
  * Copyright 2016 Freescale Semiconductor, Inc.
- * Copyright 2018-2019 NXP
+ * Copyright 2018-2019, 2023 NXP
  *
  * There is no Shared Descriptor for PKC so that the Job Descriptor must carry
  * all the desired key parameters, input and output pointers.
@@ -1168,10 +1168,10 @@ int caam_pkc_init(struct device *ctrldev)
 
 	/* Determine public key hardware accelerator presence. */
 	if (priv->era < 10) {
-		pk_inst = (rd_reg32(&priv->ctrl->perfmon.cha_num_ls) &
+		pk_inst = (rd_reg32(&priv->jr[0]->perfmon.cha_num_ls) &
 			   CHA_ID_LS_PK_MASK) >> CHA_ID_LS_PK_SHIFT;
 	} else {
-		pkha = rd_reg32(&priv->ctrl->vreg.pkha);
+		pkha = rd_reg32(&priv->jr[0]->vreg.pkha);
 		pk_inst = pkha & CHA_VER_NUM_MASK;
 
 		/*
diff --git a/drivers/crypto/caam/caamrng.c b/drivers/crypto/caam/caamrng.c
index 1fd8ff965006..50eb55da45c2 100644
--- a/drivers/crypto/caam/caamrng.c
+++ b/drivers/crypto/caam/caamrng.c
@@ -3,7 +3,7 @@
  * caam - Freescale FSL CAAM support for hw_random
  *
  * Copyright 2011 Freescale Semiconductor, Inc.
- * Copyright 2018-2019 NXP
+ * Copyright 2018-2019, 2023 NXP
  *
  * Based on caamalg.c crypto API driver.
  *
@@ -227,10 +227,10 @@ int caam_rng_init(struct device *ctrldev)
 
 	/* Check for an instantiated RNG before registration */
 	if (priv->era < 10)
-		rng_inst = (rd_reg32(&priv->ctrl->perfmon.cha_num_ls) &
+		rng_inst = (rd_reg32(&priv->jr[0]->perfmon.cha_num_ls) &
 			    CHA_ID_LS_RNG_MASK) >> CHA_ID_LS_RNG_SHIFT;
 	else
-		rng_inst = rd_reg32(&priv->ctrl->vreg.rng) & CHA_VER_NUM_MASK;
+		rng_inst = rd_reg32(&priv->jr[0]->vreg.rng) & CHA_VER_NUM_MASK;
 
 	if (!rng_inst)
 		return 0;
diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index 6278afb951c3..de1f0acdb712 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -3,7 +3,7 @@
  * Controller-level driver, kernel property detection, initialization
  *
  * Copyright 2008-2012 Freescale Semiconductor, Inc.
- * Copyright 2018-2019 NXP
+ * Copyright 2018-2019, 2023 NXP
  */
 
 #include <linux/device.h>
@@ -395,7 +395,7 @@ static void kick_trng(struct platform_device *pdev, int ent_delay)
 		      RTMCTL_SAMP_MODE_RAW_ES_SC);
 }
 
-static int caam_get_era_from_hw(struct caam_ctrl __iomem *ctrl)
+static int caam_get_era_from_hw(struct caam_perfmon __iomem *perfmon)
 {
 	static const struct {
 		u16 ip_id;
@@ -421,12 +421,12 @@ static int caam_get_era_from_hw(struct caam_ctrl __iomem *ctrl)
 	u16 ip_id;
 	int i;
 
-	ccbvid = rd_reg32(&ctrl->perfmon.ccb_id);
+	ccbvid = rd_reg32(&perfmon->ccb_id);
 	era = (ccbvid & CCBVID_ERA_MASK) >> CCBVID_ERA_SHIFT;
 	if (era)	/* This is '0' prior to CAAM ERA-6 */
 		return era;
 
-	id_ms = rd_reg32(&ctrl->perfmon.caam_id_ms);
+	id_ms = rd_reg32(&perfmon->caam_id_ms);
 	ip_id = (id_ms & SECVID_MS_IPID_MASK) >> SECVID_MS_IPID_SHIFT;
 	maj_rev = (id_ms & SECVID_MS_MAJ_REV_MASK) >> SECVID_MS_MAJ_REV_SHIFT;
 
@@ -444,9 +444,9 @@ static int caam_get_era_from_hw(struct caam_ctrl __iomem *ctrl)
  * In case this property is not passed an attempt to retrieve the CAAM
  * era via register reads will be made.
  *
- * @ctrl:	controller region
+ * @perfmon:	Performance Monitor Registers
  */
-static int caam_get_era(struct caam_ctrl __iomem *ctrl)
+static int caam_get_era(struct caam_perfmon __iomem *perfmon)
 {
 	struct device_node *caam_node;
 	int ret;
@@ -459,7 +459,7 @@ static int caam_get_era(struct caam_ctrl __iomem *ctrl)
 	if (!ret)
 		return prop;
 	else
-		return caam_get_era_from_hw(ctrl);
+		return caam_get_era_from_hw(perfmon);
 }
 
 /*
@@ -626,6 +626,7 @@ static int caam_probe(struct platform_device *pdev)
 	struct device_node *nprop, *np;
 	struct caam_ctrl __iomem *ctrl;
 	struct caam_drv_private *ctrlpriv;
+	struct caam_perfmon __iomem *perfmon;
 	struct dentry *dfs_root;
 	u32 scfgr, comp_params;
 	u8 rng_vid;
@@ -665,9 +666,36 @@ static int caam_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	caam_little_end = !(bool)(rd_reg32(&ctrl->perfmon.status) &
+	ring = 0;
+	for_each_available_child_of_node(nprop, np)
+		if (of_device_is_compatible(np, "fsl,sec-v4.0-job-ring") ||
+		    of_device_is_compatible(np, "fsl,sec4.0-job-ring")) {
+			u32 reg;
+
+			if (of_property_read_u32_index(np, "reg", 0, &reg)) {
+				dev_err(dev, "%s read reg property error\n",
+					np->full_name);
+				continue;
+			}
+
+			ctrlpriv->jr[ring] = (struct caam_job_ring __iomem __force *)
+					     ((__force uint8_t *)ctrl + reg);
+
+			ctrlpriv->total_jobrs++;
+			ring++;
+		}
+
+	/*
+	 * Wherever possible, instead of accessing registers from the global page,
+	 * use the alias registers in the first (cf. DT nodes order)
+	 * job ring's page.
+	 */
+	perfmon = ring ? (struct caam_perfmon __iomem *)&ctrlpriv->jr[0]->perfmon :
+			 (struct caam_perfmon __iomem *)&ctrl->perfmon;
+
+	caam_little_end = !(bool)(rd_reg32(&perfmon->status) &
 				  (CSTA_PLEND | CSTA_ALT_PLEND));
-	comp_params = rd_reg32(&ctrl->perfmon.comp_parms_ms);
+	comp_params = rd_reg32(&perfmon->comp_parms_ms);
 	if (comp_params & CTPR_MS_PS && rd_reg32(&ctrl->mcr) & MCFGR_LONG_PTR)
 		caam_ptr_sz = sizeof(u64);
 	else
@@ -778,7 +806,7 @@ static int caam_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ctrlpriv->era = caam_get_era(ctrl);
+	ctrlpriv->era = caam_get_era(perfmon);
 	ctrlpriv->domain = iommu_get_domain_for_dev(dev);
 
 	dfs_root = debugfs_create_dir(dev_name(dev), NULL);
@@ -789,7 +817,7 @@ static int caam_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	caam_debugfs_init(ctrlpriv, dfs_root);
+	caam_debugfs_init(ctrlpriv, perfmon, dfs_root);
 
 	/* Check to see if (DPAA 1.x) QI present. If so, enable */
 	if (ctrlpriv->qi_present && !caam_dpaa2) {
@@ -808,26 +836,13 @@ static int caam_probe(struct platform_device *pdev)
 #endif
 	}
 
-	ring = 0;
-	for_each_available_child_of_node(nprop, np)
-		if (of_device_is_compatible(np, "fsl,sec-v4.0-job-ring") ||
-		    of_device_is_compatible(np, "fsl,sec4.0-job-ring")) {
-			ctrlpriv->jr[ring] = (struct caam_job_ring __iomem __force *)
-					     ((__force uint8_t *)ctrl +
-					     (ring + JR_BLOCK_NUMBER) *
-					      BLOCK_OFFSET
-					     );
-			ctrlpriv->total_jobrs++;
-			ring++;
-		}
-
 	/* If no QI and no rings specified, quit and go home */
 	if ((!ctrlpriv->qi_present) && (!ctrlpriv->total_jobrs)) {
 		dev_err(dev, "no queues configured, terminating\n");
 		return -ENOMEM;
 	}
 
-	comp_params = rd_reg32(&ctrl->perfmon.comp_parms_ls);
+	comp_params = rd_reg32(&perfmon->comp_parms_ls);
 	ctrlpriv->blob_present = !!(comp_params & CTPR_LS_BLOB);
 
 	/*
@@ -836,15 +851,21 @@ static int caam_probe(struct platform_device *pdev)
 	 * check both here.
 	 */
 	if (ctrlpriv->era < 10) {
-		rng_vid = (rd_reg32(&ctrl->perfmon.cha_id_ls) &
+		rng_vid = (rd_reg32(&perfmon->cha_id_ls) &
 			   CHA_ID_LS_RNG_MASK) >> CHA_ID_LS_RNG_SHIFT;
 		ctrlpriv->blob_present = ctrlpriv->blob_present &&
-			(rd_reg32(&ctrl->perfmon.cha_num_ls) & CHA_ID_LS_AES_MASK);
+			(rd_reg32(&perfmon->cha_num_ls) & CHA_ID_LS_AES_MASK);
 	} else {
-		rng_vid = (rd_reg32(&ctrl->vreg.rng) & CHA_VER_VID_MASK) >>
+		struct version_regs __iomem *vreg;
+
+		vreg =  ctrlpriv->total_jobrs ?
+			(struct version_regs __iomem *)&ctrlpriv->jr[0]->vreg :
+			(struct version_regs __iomem *)&ctrl->vreg;
+
+		rng_vid = (rd_reg32(&vreg->rng) & CHA_VER_VID_MASK) >>
 			   CHA_VER_VID_SHIFT;
 		ctrlpriv->blob_present = ctrlpriv->blob_present &&
-			(rd_reg32(&ctrl->vreg.aesa) & CHA_VER_MISC_AES_NUM_MASK);
+			(rd_reg32(&vreg->aesa) & CHA_VER_MISC_AES_NUM_MASK);
 	}
 
 	/*
@@ -925,8 +946,8 @@ static int caam_probe(struct platform_device *pdev)
 
 	/* NOTE: RTIC detection ought to go here, around Si time */
 
-	caam_id = (u64)rd_reg32(&ctrl->perfmon.caam_id_ms) << 32 |
-		  (u64)rd_reg32(&ctrl->perfmon.caam_id_ls);
+	caam_id = (u64)rd_reg32(&perfmon->caam_id_ms) << 32 |
+		  (u64)rd_reg32(&perfmon->caam_id_ls);
 
 	/* Report "alive" for developer to see */
 	dev_info(dev, "device ID = 0x%016llx (Era %d)\n", caam_id,
diff --git a/drivers/crypto/caam/debugfs.c b/drivers/crypto/caam/debugfs.c
index 806bb20d2aa1..b2ef2273298d 100644
--- a/drivers/crypto/caam/debugfs.c
+++ b/drivers/crypto/caam/debugfs.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
-/* Copyright 2019 NXP */
+/* Copyright 2019, 2023 NXP */
 
 #include <linux/debugfs.h>
 #include "compat.h"
@@ -42,16 +42,15 @@ void caam_debugfs_qi_init(struct caam_drv_private *ctrlpriv)
 }
 #endif
 
-void caam_debugfs_init(struct caam_drv_private *ctrlpriv, struct dentry *root)
+void caam_debugfs_init(struct caam_drv_private *ctrlpriv,
+		       struct caam_perfmon __force *perfmon,
+		       struct dentry *root)
 {
-	struct caam_perfmon *perfmon;
-
 	/*
 	 * FIXME: needs better naming distinction, as some amalgamation of
 	 * "caam" and nprop->full_name. The OF name isn't distinctive,
 	 * but does separate instances
 	 */
-	perfmon = (struct caam_perfmon __force *)&ctrlpriv->ctrl->perfmon;
 
 	ctrlpriv->ctl = debugfs_create_dir("ctl", root);
 
diff --git a/drivers/crypto/caam/debugfs.h b/drivers/crypto/caam/debugfs.h
index 661d768acdbf..8b5d1acd21a7 100644
--- a/drivers/crypto/caam/debugfs.h
+++ b/drivers/crypto/caam/debugfs.h
@@ -1,16 +1,19 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/* Copyright 2019 NXP */
+/* Copyright 2019, 2023 NXP */
 
 #ifndef CAAM_DEBUGFS_H
 #define CAAM_DEBUGFS_H
 
 struct dentry;
 struct caam_drv_private;
+struct caam_perfmon;
 
 #ifdef CONFIG_DEBUG_FS
-void caam_debugfs_init(struct caam_drv_private *ctrlpriv, struct dentry *root);
+void caam_debugfs_init(struct caam_drv_private *ctrlpriv,
+		       struct caam_perfmon __force *perfmon, struct dentry *root);
 #else
 static inline void caam_debugfs_init(struct caam_drv_private *ctrlpriv,
+				     struct caam_perfmon __force *perfmon,
 				     struct dentry *root)
 {}
 #endif
-- 
2.25.1

