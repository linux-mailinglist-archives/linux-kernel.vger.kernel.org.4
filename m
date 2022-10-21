Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECCD606EC7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 06:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiJUEP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 00:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiJUEPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 00:15:01 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2056.outbound.protection.outlook.com [40.107.247.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A009578BC;
        Thu, 20 Oct 2022 21:14:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GeJD3V0fvjqHt3bBpYokmjYBZNWA7n9vr9OViAFrQPoFiSVDqm39eGHzCC9B2DI0Eli2atpRXCwYI8FiG5hG4/ApxMXb0Tqv6YZLrhNApop/PCzwxKigZa29zO7eqQnbebkCc9cprlvZJcJHkt/APfNrvMxR9Z95yM3zn/piwvyaapbHoJq2tWkKEvml1fe/Nf5yFHirKBtUFq8CX10PH42VRIb5DOrPiZTsn4se4AlpRqQg9Eiwcrth0COfVuY+u6+QM+Z+fTkYM1ySqHwcABJwIC1xSHZ+OmsT5DqQHukyL9SftVD+ZA18YK8Ae9Zc/VECww6T9WMfMHrslfyDIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lmd7U3HA5UYUtnW7yd0cOy+Wpwv4BP/NsvISeSF++Y=;
 b=cp+UxGruUYs4Qsb9Kd2KgMvqqZG78pWWelgopTl+M2zvJIeALUYmJX3IjPoT8L5QhuWISDi2tQuawEM1ylwEDtyl/AROWJ/rChtfBNsHbMPCmAwgFqkCEa1t7qDni2nuXJhAZSpTGPYTHx9EaRSrLIe35IfxpYMmUAtmzt1hqW4cYdd/HdtKh2YPQ/1UT6tY633Wcx90Ze+AnfKtKFwGLJGAgAPKqu3CdT9mu48hT7+mRtJ/sCo7gFsE/cvpxePkT5Fbi0fwcLLxb3leB2RqnelVSqh7iEDEZUe3BhcgDSAtaBKzDU1zcTmIW2ba/G05oRBwtPzJhAbSAwr91+q4+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lmd7U3HA5UYUtnW7yd0cOy+Wpwv4BP/NsvISeSF++Y=;
 b=Qe+4g7yIXc88ti3jIOebOqYC4BYPfEwdJ3FsTak1vSbSaTHxYbPLAP0of1y5mglbBRA7Gdoy+inN9Vlg9AlayiGHLHGLs0hBdB9rsBwIMXynwZxFrOD5QkUoDfgqTdzmcM58GYF64yEzYoKIFJjznlj1AuSMLlg2zrjvZXCrO3w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7294.eurprd04.prod.outlook.com (2603:10a6:800:1a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 04:14:34 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Fri, 21 Oct 2022
 04:14:34 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@kernel.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V8 7/7] remoteproc: imx_rproc: Enable attach recovery for i.MX8QM/QXP
Date:   Fri, 21 Oct 2022 12:15:26 +0800
Message-Id: <20221021041526.3696483-8-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221021041526.3696483-1-peng.fan@oss.nxp.com>
References: <20221021041526.3696483-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:4:186::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VE1PR04MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ed24a3c-f0ec-4c60-ffd8-08dab31ac27b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eTbq2VLkYN3mnpf6+zyvzNz8QEwEGutcdkASMnGkrgpjSIT7ay06+UXU8z30Po9myYTS1qP6R5JXDF2sXa554tzQlJKr3V1tmjpfI8mGMbZy6C5BFENItR/NbJbH1gOGOFQQkJknN5zsfYHUZv35y27Usnp578d1D+1sZylNTtAdYvdCGIzdGcoQae/VC2sGnSus7x7b0zM3eLSsWHDPywwnBGzd2dSqLxs6YLv90IpHytymSdZhWEu0Ij82PT6MltT6IaCplFqxc/hDpi1yv521wJxynRYu6r8ANug1GCcce/dn8COlS5rf12n3PRyWZJVS814UlQfwgQQC+Cz1BFjg5cyv/xGkcuMvbcskkNKS8iDdPI4U/G9+K4gb1flZjPglUswOQMNIlDoebWhhbaNeKtGhGDIY1/bsgsGQDmcKuHJ2Or1IwgpQ/UXrtlfP1nOOipX23/Hq50aObPRWhZb2pqE76ja1c7eKi2Wi0y0Ut/9lvRzwdNnPGchHMYX45S9kAPMATQaRA6Ue2aR49FOPUjxIISlLK1JKkJ4yA7ipURY7+17hLofBvm/zTii37EvhYmIqjYIv3zsPn6flZ5qD9W4U+knBEWsiGxXgmt67lBaPfKdKdxUcxBX3qTkZilToMN88KP3tPYRQUEBr36RuKjKtpSUIEk28cAty0qbwb3GKM/VtQAN/ru8BcMFVO6u66Q5Pxxodf+bL0bEU0Jk2iYeL+NYi4gbHBhMbY3woovMEqvaz1NJh1Kzu2SBrpiV/CzxfnehNjC6fuQNh7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199015)(38350700002)(186003)(2616005)(38100700002)(6486002)(2906002)(1076003)(478600001)(4744005)(66476007)(66556008)(8676002)(66946007)(86362001)(6666004)(8936002)(316002)(4326008)(6512007)(6506007)(26005)(41300700001)(52116002)(7416002)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VM5rKKQgSevwgqJLxR8KdcOwVQLZmZ5JogWDdAQTZN+vhu4LZpAqwIqXMjQO?=
 =?us-ascii?Q?2xIwdV7WCVQiUXcbgCfJmj0auXLvgNKMms0uWLb/bpW4Xb02wBesLFYWs+je?=
 =?us-ascii?Q?6QCzNoOi3s95HJkD7mmZ0/dzVdIpRjbkX+dmzH5DdAIpX903AyUUdd5/6Lco?=
 =?us-ascii?Q?Yv4C5YuesQqDRYDcd8BkcusN8CtJb8k4+Qjz6aq4hv2U/a5uR/1n2HbIEPAZ?=
 =?us-ascii?Q?UwCyS/PaVNm84xSerjZl/TrjnNrRcmLyqf4nAbBW+1kTH0FEG4XAxrCFDH3l?=
 =?us-ascii?Q?CK1LLjpxDT+0Y5mBxDCiWVRg6jvHaODgGMLjYDCtrKf+2sigI919U91BJAGo?=
 =?us-ascii?Q?3RnalNcDYuQln849VcYjWfefKQ4rZTVleVCQVCKbNKZczviY7DE4b0cP5/Mb?=
 =?us-ascii?Q?ZCkbJWYkz7iuUByy9b21z5EQ4EdeZeb9GQkmDPoWgS1Pqbv5QEQC/I4c1q9k?=
 =?us-ascii?Q?3LR1RWlithGRg6ZoWO4gLUD0GwK0JVp/efYID5f8pTCbKC2ZItVbWnRR/M4W?=
 =?us-ascii?Q?VFls82MJwhrMsaP9JW874PN7+5EnwC7Rhlb2SG7LmSIq9nYrkalP8pKCy/pc?=
 =?us-ascii?Q?fvajcToxwXvLspgQ6CUsaClODH0c1E6wMXQ1EvxglbbFTW8GWaxdIo07q0Aa?=
 =?us-ascii?Q?bt9pDse7wSy5IYd0zt8RmvWl0G/ToBVFJvP8T8vcniHesT6fYmjElcadX/uW?=
 =?us-ascii?Q?ZhuZ3H8NYggm8qnNq5PFY0thLszn0SvjAImDTes7ZPS8Mw3UOTgKYTRAQg1B?=
 =?us-ascii?Q?voqFZucxuyff8Km4dOqRvDPJbRyBtKwym+2iRUkC9PueUmDKAQwjuwp21dpO?=
 =?us-ascii?Q?XmzsoFbsB56Bd/r2BLDMJrIDC54jCRPV7+aKfY2Zq8lG1zdexOUTwhPJ6c5I?=
 =?us-ascii?Q?V00Pws7MUHSlUNfX1QiWFWFGb7+eFli112v5I0MHrzK+mC32VMl+v17+7Rnr?=
 =?us-ascii?Q?rjBuEqljyorbuVyCjZPI/lE+6OxxeMz/TwBIMLl4QgZGM3UKmRtPCAyoQTxX?=
 =?us-ascii?Q?ZS1N0n9ZByFK/xjtYNblzeoyhn8fGWNZ6z/fxwLW02rH8MG7f6cqA4mGPhCP?=
 =?us-ascii?Q?7iXUI0kSw+Q6E5yox6wOO/1RCtAua9AXFEQkNNWkCLBOKzAn4wcsRrgIK23v?=
 =?us-ascii?Q?RBOqFyHdQLjDPz09zg99XWiIllCqZ8Yc7g0+cKLh0d8vb7S/DOqt8XnJTuM7?=
 =?us-ascii?Q?CS/kVjamZMq+nus2gma96zyZ4unup6cKIGzmZkQpu2JPhAMptRKkWpch1vGV?=
 =?us-ascii?Q?FPo94gTaMALQt3rAW4rJJfkxWD/D33KcrtWZ4/06h0KougeRAqRP+nWpB7YS?=
 =?us-ascii?Q?yRIUVTgNgAtKVAs54Q+Xqsifun21MQaHggF01RisI2u4VNamzxBFC2z6mQhb?=
 =?us-ascii?Q?FkeewD8cJScBfKvgKV2Nf5OTG6bibnXBFVhBuQRw3IFYYGLr6kGNbYAPYn2j?=
 =?us-ascii?Q?wzvhH2XrYa3OJ3NuxAiceatGSOFipkg7orj3l6ie32sCBNl/+1EMpjys1/O4?=
 =?us-ascii?Q?m5emtUURFpAvoxPzEPzPUijs0X/Jf9LLuIWBAU8exRcdPrDyO8B0aBeXCbuQ?=
 =?us-ascii?Q?rIMv5vBGjx6Nahqm+fybweioQnTtWtqQlSKLvDLx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed24a3c-f0ec-4c60-ffd8-08dab31ac27b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 04:14:34.2731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQMg2D16rEjg1QZnB9ySo6D5W6kzMpFGh+Ozg5BufQ8MZCGDGkrIrUT363SWbefagnAWilZIG3jPbirC5Rva2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7294
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8QM/QXP M4 could recover without help from Linux, so to support it:
 - enable feature RPROC_FEAT_ATTACH_ON_RECOVERY
 - set recovery_disabled as false

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index dda4e8a12adf..2c471e46f4ca 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -948,7 +948,8 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
 		}
 
 		priv->rproc->state = RPROC_DETACHED;
-		priv->rproc->recovery_disabled = true;
+		priv->rproc->recovery_disabled = false;
+		rproc_set_feature(priv->rproc, RPROC_FEAT_ATTACH_ON_RECOVERY);
 
 		/* Get partition id and enable irq in SCFW */
 		ret = imx_sc_rm_get_resource_owner(priv->ipc_handle, priv->rsrc_id, &pt);
-- 
2.37.1

