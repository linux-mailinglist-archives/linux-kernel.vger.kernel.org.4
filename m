Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6BD6C42DE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCVGRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjCVGRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:17:50 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62EE5983E;
        Tue, 21 Mar 2023 23:17:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaPEYDUAwa12pNVUxmAOQjxC3lNqRXs88nycmMu4Ro+/kLnnxRNXZVgfPK/5Y1Ecpa2xl3LUYCoQzXi8EgtoUTvwaU5OPeMbgsZxBMZKrEvLrUvm6QgS40imOI8j2jsJhdWoT2Q7W+kBX+EUjlVW5Pusm9kPSjU8OoRRj3rH6q9MbLT6p99o9RqsqGd9efr4/9YlPDy3tea2htlo/zoUFzXiLF6kpXzZy0T9IbGOq8hlwnrWcrRm14ms6WOIWEbq61E3zojfn+AWVUoLnJgwGXUWd77PFgZvviNfl+3JtRCXNbzQ8Zws7ETDtMXrYQgGGZmnEJkVdK8ZlndvJ//Dlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHf6i1oVFlO5A2IoRAhx3CloxN4P1lpsHc6NKUct93g=;
 b=kbaqIGKZFLyFI2QmU2dSSdiYurFL2ZQDCNvs3/pgi9nZP2RlDIW1gbixk9g+w+3vdrN0rzHrgaKX1s0shq2oVPf+ZLofNyqFKdU3NLr5U2HxE5sqoLCA+7c/T2hbKCF1W7qhBB6D201Yle36zJj2POgruoNTZ6HR7C+v9WvlwAScIPzoojYx2L7rz/F1w3Vv/RA5eWcau+Gk1yKFvVxFaByWtUxO50dD/xf0M6lHELeGoKROcsBu6h91p9RMchFFQKIxPmq/DbEj7umrAoGxG+vgfKKL78b0utr14My3URkJuFFrt7GWv+qQeBXHou5h4m3D7oah0CID9WG9jGgFzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHf6i1oVFlO5A2IoRAhx3CloxN4P1lpsHc6NKUct93g=;
 b=hI4g6BxGOxau48njpRBuWDJeeFI67Dm6cTrLuY0bS1tSsbz4HZ2tLZB4IfxMja1xMwya38SE9zleR5RGuuEtRvLPMRx6Zr7cfGAdUz1ssdh5OwErlIjtB3m2OgcT0pb9y5wpJPnRUamAXIhwL/wiJ1bpDHl0vNRQXvhdQZiJFUs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by DB8PR04MB7020.eurprd04.prod.outlook.com (2603:10a6:10:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 06:17:45 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e%6]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 06:17:45 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Varun Sethi <v.sethi@nxp.com>
Subject: [PATCH v2 1/2] crypto: caam - reduce page 0 regs access to minimum
Date:   Wed, 22 Mar 2023 07:17:15 +0100
Message-Id: <20230322061716.3195841-2-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230322061716.3195841-1-meenakshi.aggarwal@nxp.com>
References: <20230302062055.1564514-3-meenakshi.aggarwal@nxp.com>
 <20230322061716.3195841-1-meenakshi.aggarwal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR04CA0042.eurprd04.prod.outlook.com
 (2603:10a6:20b:f0::19) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9563:EE_|DB8PR04MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: cae78a5d-f8eb-4dd3-8193-08db2a9d268f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Egs40QQjbw8phhH++Dv8cs245EwMoP/82qz1UBZtonoShrzeIbl/hBChw12u+Ri/KTy3sWrBVLcNs7xgNs0F9gNuE4UKPyiQD320gC4j00HdJ1xCNd7SFo6jRoLvfnrHaJ91XHOQUMxeC5TqSNtXO1VweGe+P4dNN66Cf13PhXeD80dVd4+9BNL/m3DmVpZW0gt5ZwYSJUi5hosX1ACD2IXzJUdqbsjF1zVApGTNAjEQ1Uq/3/L4jDQXb/ES6avYAw0wvd/F0abZYEKNMlu1Ci4JBNs3f8EMI1Zcl+I7DxitvO+XVn210KETJn7N6SUi90mokvUFLXPw3Wn5jRkgUDB6Y4bDAENsvOmkOm1J0ywM85A35nlyOyltaSJkrCDRp06fsmIBu+NjWdffHSC3rDd3KKF00I+/rG/I3THbi6rBwTd06NbYxqMqGu7gnqW6Qo3lxIj9yycamM/NAEKrOJN2rrFDDfyyfPjIba3tTwGqu8C5U22wn9dtipMMvEyMNnJhkVEZLEWsweecw7YBgXD/92/TFeLMAT3ofjq5wnwutGrqhFKfUYevWiOjX29QsQlAXbEOVvGgsNVnNCPHA7I3R3+2M7VKK469bBGHaRfiGI3Tr0ev5RMwUcuCuYbMVylWEOij0TLkAC+f/E3CTym088fbk4q1z2CTsDMT/pUMZG9hB0f67Y+EqlYH5+SRJ0Xm/U5ffj2vv74Mof+lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199018)(54906003)(6512007)(2616005)(83380400001)(478600001)(6486002)(26005)(186003)(6506007)(9686003)(1076003)(8936002)(6666004)(316002)(66556008)(52116002)(66476007)(86362001)(38350700002)(38100700002)(2906002)(5660300002)(30864003)(4326008)(66946007)(8676002)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sWYkqmMA4DR0Wqt/rQ4zXJyPXDVwCykLMC58ViAc5RyLHPNhjl+CE8FfduG7?=
 =?us-ascii?Q?nPYli07+LJ/rQBsMH3ySb4dQKzAv9wkl/tRKqU6yfBrOiVh3O2XfRrgYwH5b?=
 =?us-ascii?Q?rrHHYLBAebihZ8J/bdCpbWf72ScvzsDO6N47k3M3YkDz5MOxso/yzYpaLczG?=
 =?us-ascii?Q?GrE5mE3gbvaAmB/uZnUZ3u7ZpMc0glYNM7SotY9jmT43DcDFp/gZJboafR0y?=
 =?us-ascii?Q?P9dIDeGiiqkscDmvn5Az3FSuh3NMOiJiZW6VmVUehTVIpGNefVcDHMzw82qb?=
 =?us-ascii?Q?uiIfXu1uwWFmgDAULR1NH6ds7nqdQ46yp1YRCK2UHstwBeTtlonisDwylmYo?=
 =?us-ascii?Q?UOjsOjTu69oPaecFduvp8pQgq4MyMh7ossobfc2m0g8uIQQQXPXrPvxIAx59?=
 =?us-ascii?Q?DXWf1xHhS7GN92Zg+2B343Xl/P/9yW0dttijhwsDM0yQhcpa97WIZXNTccx+?=
 =?us-ascii?Q?QJ0zefvXJPBYfCSL7w1ov5aUZOaWJNqdl5Gh9WEqYsunVHCpVyz4/dMC6GIE?=
 =?us-ascii?Q?RoZZRPIbfLYBeCzc0xj4377x18TL2YRPAMvymADYig88y8gK5+OpjPOzjaGJ?=
 =?us-ascii?Q?vFgBg4fSHEWdilI+0h2vEhEcjAfcZS1cHNEgDxLenOQ4+r7WFe6rj4sY5H6x?=
 =?us-ascii?Q?1ixs3R62Y5BMMYKyc7E8vDD/kG6J3wivFETdxruEMM8Hu3Jox1mU44l0Qm1c?=
 =?us-ascii?Q?KSXcmBQSk/yVAS85tQWnZTN1x6UBR67LgxJu/Zc9dFKmcLO9NVs9wH2TeDuE?=
 =?us-ascii?Q?Sag2LthdPd1R/CNfnSLOixW2CTxRceTeXssmp1i09d/+5uBQw+CP0lHW8c5O?=
 =?us-ascii?Q?a63D6FH3E9yczNVp0MVfMWsVIK+Mqj4UdsXQsj3edf+Pu44NGmk2pOPvzZOm?=
 =?us-ascii?Q?ikRcGh3IL3K/6iBQCPNJy7+Edrx2IbyhVxyU86wiiA3bVEj3X6PVTZjRtLTp?=
 =?us-ascii?Q?d5ZyZ8j87CJ/tw2KKWusGoiDLWzZd7faQfJIxYNYCyxBEzJo1fg+OKdxhcne?=
 =?us-ascii?Q?WVERoDr+nHnj4WbQvW0e/FguZi74rU+7HArI7/xfOZkqoW8iABTBJnpf37Qg?=
 =?us-ascii?Q?FNTXfLsAzsUKuvNlXe7rb+4uTl/H9DEP+jLct6IZMM1+QIA4M7UZp9sPyHN8?=
 =?us-ascii?Q?kBoB040u6ZAAKBPu27W2iIsK0E3u9PBOg/rz6LtidnA2Q1M8t8TfPJwLsULb?=
 =?us-ascii?Q?EwD04THXBYe54Qhvhje5nElqtC+ZM5PBPoNAS9sjpBBrjh1MKPUh3DMNQwzE?=
 =?us-ascii?Q?FDA47PgBqsxSAOhdF9fzZVoE77331D9KuFHp/lDxA+kTso5yYiEnEdRX7KVZ?=
 =?us-ascii?Q?BNSvf5/S7DKTXeExEHVmPGfxEXs2tajg4XmFo6OmFyHSe7W0lmerQ5t05thP?=
 =?us-ascii?Q?EltKg15F0Zag9+L/cE1unGvxdZkSR1ye0dUPy7HbtaiWB+ORjkouetZxk4ea?=
 =?us-ascii?Q?ZhGY4JfDtTN6BZRrLjnNdsBmaS3YqUWB4ZLh/YD7Anzj9oe2HNCyqJMUAYTB?=
 =?us-ascii?Q?706CjfOUKcduQgOV0cKpgirUdU+c938rLOa1Icd2UCFL/XwNrv5PyoCkMHjD?=
 =?us-ascii?Q?alEqZ4Pc2P0mhyU0f5DyzHTyHJ9NsH7HEmWIs2kl0pfJMIDdqT0jDJzaQHR3?=
 =?us-ascii?Q?0Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cae78a5d-f8eb-4dd3-8193-08db2a9d268f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 06:17:44.9477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: beVHQXh3NHGGaVCUGMr9jyZ/vzzoNQmQJP2pgwvdHM/ZRJ3crayoE4bC5gwOuAQm5VM2yhVrCU+YKzQM4fOORxxKxjIYozb2wVrhf2qlYBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7020
X-Spam-Status: No, score=1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
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
 drivers/crypto/caam/caamalg.c  | 21 ++++-----
 drivers/crypto/caam/caamhash.c | 10 +++--
 drivers/crypto/caam/caampkc.c  |  6 +--
 drivers/crypto/caam/caamrng.c  |  6 +--
 drivers/crypto/caam/ctrl.c     | 82 +++++++++++++++++++++-------------
 drivers/crypto/caam/debugfs.c  |  9 ++--
 drivers/crypto/caam/debugfs.h  |  7 ++-
 7 files changed, 83 insertions(+), 58 deletions(-)

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
index 6278afb951c3..ae07c1e5fd38 100644
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
@@ -836,15 +851,20 @@ static int caam_probe(struct platform_device *pdev)
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
+		vreg = ring ? (struct version_regs __iomem *)&ctrlpriv->jr[0]->vreg :
+			      (struct version_regs __iomem *)&ctrl->vreg;
+
+		rng_vid = (rd_reg32(&vreg->rng) & CHA_VER_VID_MASK) >>
 			   CHA_VER_VID_SHIFT;
 		ctrlpriv->blob_present = ctrlpriv->blob_present &&
-			(rd_reg32(&ctrl->vreg.aesa) & CHA_VER_MISC_AES_NUM_MASK);
+			(rd_reg32(&vreg->aesa) & CHA_VER_MISC_AES_NUM_MASK);
 	}
 
 	/*
@@ -925,8 +945,8 @@ static int caam_probe(struct platform_device *pdev)
 
 	/* NOTE: RTIC detection ought to go here, around Si time */
 
-	caam_id = (u64)rd_reg32(&ctrl->perfmon.caam_id_ms) << 32 |
-		  (u64)rd_reg32(&ctrl->perfmon.caam_id_ls);
+	caam_id = (u64)rd_reg32(&perfmon->caam_id_ms) << 32 |
+		  (u64)rd_reg32(&perfmon->caam_id_ls);
 
 	/* Report "alive" for developer to see */
 	dev_info(dev, "device ID = 0x%016llx (Era %d)\n", caam_id,
diff --git a/drivers/crypto/caam/debugfs.c b/drivers/crypto/caam/debugfs.c
index 806bb20d2aa1..798ba989a8a0 100644
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
+		       struct caam_perfmon __iomem *perfmon,
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
index 661d768acdbf..78e3c6b957c2 100644
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
+		       struct caam_perfmon __iomem *perfmon, struct dentry *root);
 #else
 static inline void caam_debugfs_init(struct caam_drv_private *ctrlpriv,
+				     struct caam_perfmon __iomem *perfmon,
 				     struct dentry *root)
 {}
 #endif
-- 
2.25.1

