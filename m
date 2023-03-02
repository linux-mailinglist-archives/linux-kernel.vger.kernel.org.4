Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6326A7B59
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 07:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjCBGWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 01:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjCBGWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 01:22:33 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93462311F4;
        Wed,  1 Mar 2023 22:22:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d45zRWpl6YnaGikN30IcZVetUSap63jVmGOIvdF5/ND4L7owRatgisDOt5cy5hKt4Dvl8dvdpt4dEebTXE6q1idExGO2c4fMud//apGDMd+CZKYtHzTjCp2PrqjGssIe4EBjyvC2yXnCUq+rt5FoTV/aGbkm4U9uzI0gkijyf0SQ2s+RyakwY/mVA9P6/0X3jWLpocYG54t8cpjZpND6imCHh4w3lc2YDZqjKDhS/yVCM43O8Mr4/6jCXs7it1yQyYq4MOySWADWOxHMC3e1QANKt26dFvdbdQPaw9EnLU3kqEKF31l0/UySYAlu3kNfFNdJr6vY7nLeA2/Rzk0/dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KO/hIEwWizTSq0ebr3mr/6YT3LFI430ANBpfFfYKrb4=;
 b=WK//fFVseAWwOGLvnhGRyXO9LgER4mXd6PdKTe/kC5Hfdu5+W/aTG/k/Dc6fwkaoSNhHs8yogCfK5ODZE6qoJWgLHSHYsbgSpLy8nECYG7kHD468H/lz+LyCPGcuZok52NW/pw8c58F9Xm+8Wy+/UxcjZmxUMLu696O0rPeqRSy9t1FNNisI43fYPyr+CRKzLKo77VSdgXzWtZkx33LIBLr4irWKg772reHDP6lSPB0wihU8jSmEreSWY696b0ohGNdKnsQeEN/XdjEmNeD9iAOc1kMp89P3PHEfEgTA6KDr2WVkfw9kTWyHusVPOKC/+HNlYV56DxFlZ2gMqmQqLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KO/hIEwWizTSq0ebr3mr/6YT3LFI430ANBpfFfYKrb4=;
 b=KkqmUWIQ/RYa4geuRUIixTv7FZbQMhBneHWfKZX3V3EMeswsHcb/mE1QJKhsiW15LRyNNHFhaB5lhBrLLHWZDeAwLgI2pEeBPj/eUxKNS3w6dQxL4S0WsS0E/wF9Dy9AQnjYgYF6eH7hjHD8nJJPk1XP5x4VnERr57+bi1sM2Vk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by DU2PR04MB8632.eurprd04.prod.outlook.com (2603:10a6:10:2df::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 06:21:26 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e%4]) with mapi id 15.20.6134.026; Thu, 2 Mar 2023
 06:21:26 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] crypto: caam - reduce page 0 regs access to minimum
Date:   Thu,  2 Mar 2023 11:50:54 +0530
Message-Id: <20230302062055.1564514-2-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230302062055.1564514-1-meenakshi.aggarwal@nxp.com>
References: <20230302062055.1564514-1-meenakshi.aggarwal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9563:EE_|DU2PR04MB8632:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fb12a61-e1da-4e16-0373-08db1ae65a77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pfi63zh9rsiaAqv0byXS7lUntk62/nL9Dg/ZH1SYmt4Aqe+XrZwdPN4jc4Dfcf49zdEENPhnL6pube6to4aZ8UHjtS2GpNmx/wEgfNLF1cecCSKRT41WLz+UACz1OUdU1yigGLP1pb/f+Gdcl2hXLbR68OEHtZWWEgU7ReWwyMC0jmidofE7PVZKPw+HQZ8AcH7FKIL03awG0nNR6k5DbH1jBjhCbHIGainxPOF7CIX1KcTzGCjyPCZLYPz1tm0rNVYKERgOkTyw1ZA//XtrtqOzjhkU6ZduFEcUqot0DlrhulSt+LURsHoPIJFXzVrps8Bzxblav5Tf5b8+kVBk3SHnEcvxHTn2YLFa9WWQeAXvNXvP+LA/dguboPCkbx4fTWcuiAhqdNSBfXjPnX/kdDOYRSnbr7V2BAUKqLTIcpRgYtkbF5hdcOqYu4POPmqRMwiXb/yxVzaqxJ6BECCA9EBlVDX00FX11A2gLSpnaylhHYvE0Xp9YXzaa5VflVkBIVfzRyEFjIs82jm18Z0E0ELUOHvVsMtGsG2JH9vdNjSFdL6HCq87KIqx1RwU1l3pXH+H5et7u0PAi1LZxIhCqXs8LwVGL6LttRIEscGHx7kbAQqFcI6J1EJdTKIaSHgBFdFVk9CcduUGRB0+qIp/lgnoC56+IFosKb8xWXq2KPi99+Xi9bpw++Jlhy3KLZmUta3VTDfBQV1QpwyJ35VWiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199018)(5660300002)(41300700001)(8936002)(38100700002)(38350700002)(8676002)(83380400001)(186003)(2906002)(66946007)(66556008)(2616005)(66476007)(30864003)(316002)(86362001)(6486002)(478600001)(36756003)(9686003)(6506007)(1076003)(26005)(6512007)(52116002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qZdsrITqHaqtnbca5+nITpbTM/o8d1y82fBDLb27hCu6OA/Wz86/MTR7sHrm?=
 =?us-ascii?Q?bMgKxJsWBktzZe2ukFSTIMIWw5QdRe4gkEEaTQaS+rG1gUFSOjU9S+37dDQW?=
 =?us-ascii?Q?ZxY8LLxCdUkAGjTXNTD/0qNn8LNLnvuscOgsC9NeUSHbmguWLfLNKru7PcGU?=
 =?us-ascii?Q?oJ4hy/1brQxqpyTtv0SC3WALvPgFLKzrO7+GbDqnq14CSdjbHvZps1p3nMdx?=
 =?us-ascii?Q?n1woY7NDbITd253SRiBfk8kbG/Lai1IW6+hxiIQylhh4U5fIBAe6KDKzEdjC?=
 =?us-ascii?Q?pGl6N+GUBpYYw66n9TwuRlhORbcF5LDxYqwKQSTGPml5J9sQFOeem4VIg3ty?=
 =?us-ascii?Q?B0cH8R7zh/ANTBovqpIWpdInQHahuRblczLPv6XZk9je8ADwd+bDmBk5Azer?=
 =?us-ascii?Q?5vi8gv2fyINL+Pi3gN8DBdpFBrqQiQhMCBo5BPm/BwTGWfJBJ6avU4hxftOt?=
 =?us-ascii?Q?cIZVxDFqLTDbiqWYVWS+DmOOCqSb1GNQ1cYYGoIdgK6dZRONDLDzTz9kHPbH?=
 =?us-ascii?Q?rPRzUs9bnCNtnBksosKqIEuWm8y+uPPsfSi6rKH2ZdSpNWLJqpWr0piUwTER?=
 =?us-ascii?Q?F739iXwAZ/dWNHhkYGfObbhWK7BxTIJvy1l16h7Bdhsh/hDlwpLaFfx/O+ui?=
 =?us-ascii?Q?GQ1B2sSCjM2TcLFUJUhucWrwqcobjaU/+R1xKJQ366hRpxsC1C4j+fxCbnIr?=
 =?us-ascii?Q?Zasc7RKPNPOylreyDslWupIR8ACj5o5ENA3Y16IKrKG//vAigKsR4vQaMSW4?=
 =?us-ascii?Q?zbh5YuDMLHuE8S9m8glJ+x4OA9Go34PUf4HPrZKBcMC/rbmS28ipLDcxarfu?=
 =?us-ascii?Q?pqR/deVCxCPpGRwn+gR3o15if2gPWX1vmdvvmbhAyzrvH/9R5GKzkqrGB85/?=
 =?us-ascii?Q?9WAYMHH70BywNuC141tIxu34es1O7cG2FFXKbJRRecPuLwwxjqSKJnvRMeTl?=
 =?us-ascii?Q?hDNDaxlFlJ3MXcJvNVP5vwRFaCoyJtL6a8RhqXI7XBB/JedlS/qNT7hPz4i6?=
 =?us-ascii?Q?aiMrEwLTn87dHOjk97KPNiX2rKHe0RtdfM6x4tIdzdH2GVngrAi+UsOW5R50?=
 =?us-ascii?Q?8Ph7o5mH8rx1+m6zJLU+2tIH2telKbcYp6ADDML8vkh6hrhP+qQs8S2cAeYO?=
 =?us-ascii?Q?0KBOEjixi8xcnSguyvzH4iLSsh/yldtV8G/UBpBJm6PfkGO8WhJ5GypGe713?=
 =?us-ascii?Q?khY/TNKf+8xKmk+fbITqEt1QilQvctIUlZANKGdR1KXeaqee07QXUu/YwmNZ?=
 =?us-ascii?Q?Pps8nmt1Jq5SnCScivlPll2f046ocTPbz5pcO0zKf1368WYIhpFUYgflzF+z?=
 =?us-ascii?Q?Pqt9K9WCHQiMlkzahVIJrhfkCQp6KbNq2/P6LqTPiX1a1oAYGlqQvMyGQRKR?=
 =?us-ascii?Q?qVBsH5UP74H/r5JYowhTG8i6Axa1uaBjyT635bBYibqE3d2CpiMXXWua3NAy?=
 =?us-ascii?Q?5ke3/0tfoy/5/6CnHoxdh3XW9vi2VIs/R1ufKHx2vqvXbtAmkRVCyJ3gVPcG?=
 =?us-ascii?Q?WdaNSTGUEm6aNhFxc/o3S6NixMoFxV0lk8HRW5ijNBqX+9W+Bjrd6VYNBjQG?=
 =?us-ascii?Q?BxaYGD2HWq4uN53mHhVwaCwTphFJ5ZIViYwXXUUQmUMFKTFv4zQkscrIFfYL?=
 =?us-ascii?Q?nA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb12a61-e1da-4e16-0373-08db1ae65a77
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 06:21:26.7481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8mIdE5Zf/3r+VyK3/MwW8ahEmKwIMhsv2H4fhi3m6V8SACLvjyZDHcmoQrGf/h3Up2jbT2++xW5WuwysW2Tp6geS9ULHgjUzw9tzQYM36A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8632
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
---
 drivers/crypto/caam/caamalg.c  | 21 +++++-----
 drivers/crypto/caam/caamhash.c | 10 +++--
 drivers/crypto/caam/caampkc.c  |  6 +--
 drivers/crypto/caam/caamrng.c  |  6 +--
 drivers/crypto/caam/ctrl.c     | 74 +++++++++++++++++++++-------------
 drivers/crypto/caam/debugfs.c  |  8 ++--
 drivers/crypto/caam/debugfs.h  |  7 +++-
 7 files changed, 78 insertions(+), 54 deletions(-)

diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index 4a9b998a8d26..29838b80a0bb 100644
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
@@ -3530,13 +3530,14 @@ int caam_algapi_init(struct device *ctrldev)
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
@@ -3544,23 +3545,23 @@ int caam_algapi_init(struct device *ctrldev)
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
index 6278afb951c3..be9724d05d01 100644
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
 
@@ -446,7 +446,7 @@ static int caam_get_era_from_hw(struct caam_ctrl __iomem *ctrl)
  *
  * @ctrl:	controller region
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
+	perfmon = ring ? (struct caam_perfmon *)&ctrlpriv->jr[0]->perfmon :
+			 (struct caam_perfmon *)&ctrl->perfmon;
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
@@ -808,19 +836,6 @@ static int caam_probe(struct platform_device *pdev)
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
@@ -836,12 +851,17 @@ static int caam_probe(struct platform_device *pdev)
 	 * check both here.
 	 */
 	if (ctrlpriv->era < 10) {
-		rng_vid = (rd_reg32(&ctrl->perfmon.cha_id_ls) &
+		rng_vid = (rd_reg32(&perfmon->cha_id_ls) &
 			   CHA_ID_LS_RNG_MASK) >> CHA_ID_LS_RNG_SHIFT;
 		ctrlpriv->blob_present = ctrlpriv->blob_present &&
 			(rd_reg32(&ctrl->perfmon.cha_num_ls) & CHA_ID_LS_AES_MASK);
 	} else {
-		rng_vid = (rd_reg32(&ctrl->vreg.rng) & CHA_VER_VID_MASK) >>
+		struct version_regs __iomem *vreg;
+
+		vreg = ring ? (struct version_regs *)&ctrlpriv->jr[0]->vreg :
+			      (struct version_regs *)&ctrl->vreg;
+
+		rng_vid = (rd_reg32(&vreg->rng) & CHA_VER_VID_MASK) >>
 			   CHA_VER_VID_SHIFT;
 		ctrlpriv->blob_present = ctrlpriv->blob_present &&
 			(rd_reg32(&ctrl->vreg.aesa) & CHA_VER_MISC_AES_NUM_MASK);
@@ -925,8 +945,8 @@ static int caam_probe(struct platform_device *pdev)
 
 	/* NOTE: RTIC detection ought to go here, around Si time */
 
-	caam_id = (u64)rd_reg32(&ctrl->perfmon.caam_id_ms) << 32 |
-		  (u64)rd_reg32(&ctrl->perfmon.caam_id_ls);
+	caam_id = (u64)rd_reg32(&perfmon->caam_id_ms) << 32 |
+		  (u64)rd_reg32(&perfmon->caam_id_ls);
 
 	/* Report "alive" for developer to see */
 	dev_info(dev, "device ID = 0x%016llx (Era %d)\n", caam_id,
diff --git a/drivers/crypto/caam/debugfs.c b/drivers/crypto/caam/debugfs.c
index 806bb20d2aa1..73fe8530c0d6 100644
--- a/drivers/crypto/caam/debugfs.c
+++ b/drivers/crypto/caam/debugfs.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
-/* Copyright 2019 NXP */
+/* Copyright 2019, 2023 NXP */
 
 #include <linux/debugfs.h>
 #include "compat.h"
@@ -42,16 +42,14 @@ void caam_debugfs_qi_init(struct caam_drv_private *ctrlpriv)
 }
 #endif
 
-void caam_debugfs_init(struct caam_drv_private *ctrlpriv, struct dentry *root)
+void caam_debugfs_init(struct caam_drv_private *ctrlpriv,
+		       struct caam_perfmon *perfmon, struct dentry *root)
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
index 661d768acdbf..fd2f0fc46d53 100644
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
+		       struct caam_perfmon *perfmon, struct dentry *root);
 #else
 static inline void caam_debugfs_init(struct caam_drv_private *ctrlpriv,
+				     struct caam_perfmon *perfmon,
 				     struct dentry *root)
 {}
 #endif
-- 
2.25.1

