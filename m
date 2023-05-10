Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7179B6FDCAE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236894AbjEJLZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236322AbjEJLZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:25:33 -0400
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2070.outbound.protection.outlook.com [40.107.222.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C461D1FF3;
        Wed, 10 May 2023 04:24:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJyUQmvWAz+R5PPf4mKpMr7NfP8+4dFTuDaQhN2xA1hknd0GxyuT5s+Tln+61lzgeQ5Ic8AAPMyfh5p2Zbmmb58BSmeDMk09V9PUNxdUdy0pVLzQh/PxVg7P0fRPqAnRjsETFneHCQu7iy8DsSuf/mW193woGGdhbS4FWxyTA68mYWat6/pl0JyTzN5lVGhAPbTQ2KLRPLvmWtIyd1b5LG0XAOEQ4iq+G7YZZN/MDXhKXkn5sPjr4p0Xmtkne6ymI8zK6Mt5M3iALofNbPdv+0uqCkOyihMg6FJGUQVymPJ8dFYSVyRhsPegvBvBsdPKafmEnWUiqnDolDtzyN7a8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GF1H1Vj9zt2LnCru6sCLwq4LUj/re3BXEcFr6p6CFLo=;
 b=FdjiBdq6hI/1B/R2mXOlTp7t0c9P49oj9FkWlA/EOiZV4UBIRHaF9wu4MGVfgJ257jaSkO3bccyT5y9sffNoF5/ox8KK/Jwbqan295TI2oLEXQXSSVHq/SOVih3gjJjn4YjhgdQki0qRS3BAoN1yT2bYhyToUm2OghyQtj6FUln5I983WgdYnRu9MRWA0/idj73Ykp+tRjRdVjbVWM9kUVV2drxFlL8ZW7fbNz9vRRd4CUDE3p7zCUZY7MvDBSsWy6j2qS7x4Lnl7z419KSR3Vuk7G7E9LHiC/CYm4Yiq54Bc1gho/xSrn6k9lYjWKE9zvtRNHYOlbo/sLJcnUInhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b01:b::15)
 by PN0PR01MB9138.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:165::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Wed, 10 May
 2023 11:24:39 +0000
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a54e:e611:b89d:7470]) by BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a54e:e611:b89d:7470%3]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 11:24:39 +0000
From:   Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
To:     krzysztof.kozlowski@linaro.org
Cc:     Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Markus Niebel <Markus.Niebel@tq-group.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Conor Dooley <conor.dooley@microchip.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/3] dt-bindings: arm: fsl: Enumerate Emtop SOM
Date:   Wed, 10 May 2023 16:53:40 +0530
Message-Id: <20230510112347.3766247-3-himanshu.bhavani@siliconsignals.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230510112347.3766247-1-himanshu.bhavani@siliconsignals.io>
References: <20230510112347.3766247-1-himanshu.bhavani@siliconsignals.io>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: PN3PR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::10) To BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b01:b::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BM1PR01MB4899:EE_|PN0PR01MB9138:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b32b8f8-d050-4714-d134-08db51492479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dn1CjTZkroHM73eWqPOs8eXyF9UWgbdpiFYeMKOoVjRJGGVEA7n2/1dPrFurAonvmNVZNeXoP8qBaU04fSHDlZpwpIAdlGo1Tvk8un11H2mozKku4kG6TFpJh+nFuz9obtjs3Is4aizVIpgDy/4zjCHy4ZrctRs3qVI2XUit0gogO95VzzI36ljrefRZBS8Ma4dGK/tLIdKQlSIeRwD0trJrZlYQW1Wk4S+iSHovQerIH1g6GMkj5cgtfkcX8/YuE4TK7HmHsz6PoiTiVfDIcdaYQBwcF8QYZBqeVpJeEvpRxlbLnlLlFhJs39mAnIyPKlpjeFs/uHrhFrUp6wl3CYf+cxymqyb0Fk2+6TVArCKlsqA0vpdng9V5jRDjiUD8uytU3xw3QNB3LpWJCUg2vIgkGY1ox/XDisvQbvMwxgHg8fuK92KdJGvxYCXdH4u+VssJsO54CGAamX2FTMQyEZivRq2T9ihxaE7VirMdUtGA74f8/x+DdAEVRrrfeNYvRZITNVdj4QEFrYn0y4YbV83vPySVrgka3zOJQRyDLnt8E6KHPSmRYiDiV1SD/vIGvnpFUXqfszYvYbeG9G7aU97V+EwAk9/dz4Ky7qfJT3xXQ19Ze0LTDmhIrjavwt6Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(376002)(396003)(39840400004)(136003)(451199021)(41300700001)(38100700002)(52116002)(6486002)(38350700002)(44832011)(5660300002)(7416002)(8936002)(8676002)(478600001)(54906003)(316002)(6666004)(6916009)(36756003)(4326008)(66476007)(66556008)(66946007)(2616005)(86362001)(186003)(2906002)(4744005)(6512007)(6506007)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YbsaKcx7k0ytZ1Hm6nddHY620QorAP881J7qttHDSVZdin3VfsipUF0BeHMf?=
 =?us-ascii?Q?rP6ZDIqIjfUktO8MgfkAdiCfU1j3W2ANF581/HomzwDg4rdD2otzgLIJNKpD?=
 =?us-ascii?Q?5K6XgVYqmN+bGvUGVZNBZ+v4Wt1zhYgXUf8b55rZ8+NLIPSV+tCPyoAYLr6y?=
 =?us-ascii?Q?jI5PPetfG5Y2tpGNXyIwsa0zMZ+wtaQ+rPqw1dQzFccPhnMG0Xca4BCvRpZN?=
 =?us-ascii?Q?CBQrnrIYPpDq9FW+0ac03yjPXhkYUooICB2Imj0xXMsFPf0qCMx5TECE88nH?=
 =?us-ascii?Q?oSfC6AJhIcTfZtWEirtsgapkxhAz+Q4WrK+hdHo9STbXsMjaP8jLvS9L3TfF?=
 =?us-ascii?Q?xaPgqIhxikXIESjRsnzbxLgKMPDVZoAL2yR2wlxfN7oENBQlYueRQK7o7mtR?=
 =?us-ascii?Q?wFWicAUZ5inJ7Q8nssQAI1is3NS2ix7EKdlgb6qNpMaDdVju6MuQgcAZLK0u?=
 =?us-ascii?Q?XAezPSUBI9xt8oLO+/J3b0ALZvC5rndUhopRm1bLFnmITGCSwCnTSrYhmkQS?=
 =?us-ascii?Q?zxCgbguN82jMmotA/CtBsxW9pAMi5XMCohRX1cMVFYpfGzCLLF3Co/wVi0Nn?=
 =?us-ascii?Q?baIbCGZkIfRhO8cDaDRUYcI955kjlfb30tnuesdXlw+HU9p8zI4vYQ4a0BV+?=
 =?us-ascii?Q?qCBWSWl9qyLgX1MCjjpGD8W9K6L9llpNjPDGT+kKXH4ciaoTxz4BF5MJmwzi?=
 =?us-ascii?Q?v7PXskilDnW+JCrDOoeVxjcnYEORs2ooLxHXBu3/cgfajOGQ/hcJreURMggx?=
 =?us-ascii?Q?vUiihkYfUhh7DxRBXWSD8swFpbVkbxvljWaE79Z+wGw3MNut+xh/cRPJu9cc?=
 =?us-ascii?Q?La1+Pb186rB8yXO8szEYjEkbu5B1Cy8imijd9GaO5x602mW1fkbVoRk1rGM5?=
 =?us-ascii?Q?Xl2T7K7rwZDQFKKEZplbTg4LdQMpsANdpZa99NEKVuPdwg7qdBRstb9GQWjT?=
 =?us-ascii?Q?SYcXcCrtspxLLHROAb1fz23YO1Fq1TFiiA5osF1nIgH+CjUBCKK2g7JflO6t?=
 =?us-ascii?Q?HG95Mf8DXzA6yUnfstT1CsaOjlDD76D/JYPsC/DDFxK1yLxpW1Ht+gatT9pm?=
 =?us-ascii?Q?DvDjT0vkpbfKqpfdvBb4YFmkzrTVjrny7kNGb03NGUIPvatIpc45OEYvWKO/?=
 =?us-ascii?Q?JMK68wN/YAgP/diooI18BMRKbfi6kGrSwZN7HbiNbR8PVmtT31g0JLbXmSYb?=
 =?us-ascii?Q?baPfl85WZnpsPKJjsVwbfKiCEFkdJrx4EkUaNVNYO5uLp1ixDDospmOHQcVr?=
 =?us-ascii?Q?UFe8aamUUc11x1jEDYSwr5ydRoXexP0BKEvJ9zg2QZXR5/R6QLNgcacEJaHU?=
 =?us-ascii?Q?DaErplk7P05bX4ypQ1m03ud2jTgr3zxr22YPmt+Pc1XqBl2Oe3XwLALX00Dk?=
 =?us-ascii?Q?9qAU/sapLrsPC9owkrLvA3nVwNPqKoDfaciMrXrlzvwsUvl/RBlvtrx93w/9?=
 =?us-ascii?Q?lX+6k2I4UsABS12FabJPJpoCEtbt2C33aalOqWe7iA4E8UY5zRxVDb7sxuHd?=
 =?us-ascii?Q?0fR0E+EEEU1TSnyHKF3fnc7euxTkstSb3dwH/roaBwnwKtmCy0k53E2lJM+v?=
 =?us-ascii?Q?pgNdeUBMpQ4LxY8VDCt6FpwwvQ7BkJeZx0/ZY15kBSrLKmmvGT0IkAscoZdF?=
 =?us-ascii?Q?uIi4UnUQmaPPCbAMmx+oFXc=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b32b8f8-d050-4714-d134-08db51492479
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 11:24:39.0460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+wYnvEl53iByKWQl/xyi1i7MpQn/MfAIeDitjqiPAHBbksEsOES1ZkEwrzu+NKnzml9uED8rzj+eKsAVRjo5fvEZtNT5XEGGQQIsZFqcce4pi3dlsYLMs3T7Jb58/+g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9138
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entries to the list of imx8mm boards denoting
the Emtop SOM from Emtop.

Signed-off-by: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 442ce8f4d675..06eb2c790f90 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -884,6 +884,7 @@ properties:
               - beacon,imx8mm-beacon-kit  # i.MX8MM Beacon Development Kit
               - boundary,imx8mm-nitrogen8mm  # i.MX8MM Nitrogen Board
               - dmo,imx8mm-data-modul-edm-sbc # i.MX8MM eDM SBC
+              - emtop,imx8mm-emtop          # i.MX8MM Emtop SOM-IMX8MMLPD4 SoM
               - emtrion,emcon-mx8mm-avari # emCON-MX8MM SoM on Avari Base
               - fsl,imx8mm-ddr4-evk       # i.MX8MM DDR4 EVK Board
               - fsl,imx8mm-evk            # i.MX8MM EVK Board
-- 
2.25.1

