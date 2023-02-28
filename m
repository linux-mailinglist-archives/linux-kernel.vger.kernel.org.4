Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDB26A5407
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjB1IAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjB1IAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:00:20 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2078.outbound.protection.outlook.com [40.107.249.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4062B617
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:00:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jdn3EhiiDAN4aK5Obxzq4/WhqMv6Fo4RJ4HixriO1NzsNAwAP3pPinljBE2RFb+B44ZfjkUu0PMUXnENDd+PCOhB4kqMoVJxJlQP62aMM0RsHBUHs2wxI3ruts1yNyDfHS63blS9nGjR8MFBvxMwWBiAynbteosflxtPWDvgpWtkREW2UAuWB2FA6GdZTbp88BUWMUL2PsCVYLXVX+Njci55B1BUbMeAS7J1tY+R9iJALym22GhZCu+kV6jiqG3jHggw/ewoNm0CZDATMfU5GwGZQPLWtoWGMvaO/16opdFO6C1eakABjHga4fhCU2ijPCgfVaMtMdWyIwx02aLgDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJtx4IerzcTyFW+T5Q2PQfzsta97Cr+IXa9xAGnO4Y8=;
 b=H4HUKQMVlDjx72nueg8Cq0FOx6bRifxGpEVOWmfReOEJjJQnworvbbnKwDTrjjinJmm4roRrjCzR3/foRkOQ/y+DdDh6ZHJeGxjla+SMBZ2TpLUuPWPPcgpuLoYvM/LbHfjve5CMabhAdiI7JpDT47blp21o4LxDRXjow770rb/3sdZW3F4sEHJ5e8xOsP55AKVxHc0VHm3MAU1jqI9A8pcpgVJLqJ4Wx5P0vkyCDqex0XELD2dB11BGI//xEn64BEH/nKWJzAlRRspD96m+riw/iO2VXk8FbS+Cl+9v+jhONBUXqOGcvIbV5dr5l27UKGsR9ZxSwekjM7tjoebLdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJtx4IerzcTyFW+T5Q2PQfzsta97Cr+IXa9xAGnO4Y8=;
 b=N32//6XlXYgKCtrCIa7uoYrFnUw+AIwoFpb035gkJQxBjCaM6lTq6j3N8GObX1FxVf0ib3L+4DiUstHAdkV1HrCQMuRhLRG7kRhAfBPqrG8HB7Abtgq2ZPJcPpqmzenHO1gmL+NH2snKOWjL2uktazrv1tSHq76+icXkJSx3icQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com (2603:10a6:150:27::9)
 by AM0PR04MB7058.eurprd04.prod.outlook.com (2603:10a6:208:195::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 08:00:02 +0000
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36]) by GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36%6]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 08:00:02 +0000
From:   Jindong Yue <jindong.yue@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, l.stach@pengutronix.de,
        peng.fan@nxp.com, linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jindong.yue@nxp.com
Subject: [PATCH 5/6] soc: imx8m: Add MODULE_LICENSE
Date:   Tue, 28 Feb 2023 16:06:43 +0800
Message-Id: <20230228080644.412894-1-jindong.yue@nxp.com>
X-Mailer: git-send-email 2.36.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To GV1PR04MB9183.eurprd04.prod.outlook.com
 (2603:10a6:150:27::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9183:EE_|AM0PR04MB7058:EE_
X-MS-Office365-Filtering-Correlation-Id: 1817b2d6-9321-4169-4abc-08db1961cba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t2vlpyUkV5wGjL4T0ksjfBJP38Qxg/EQAxNAemURUU5TE5pTKIOtszaqaVFkRox5SO9fJ2KeSFsO8I3MYqASS/biumvcqlvC1fu/zUGHRSxup7EDUQwFGfsF3xbjZMvmLhGf+PHU806zVrjCnZ/UpibY/xtgbBPy81X04lqelIwtt8rjSTtksM6DEvK8f/UAJ8rOMSkDgkEopOMKOWYjo7KKNwtwJO8ES30gmCVEZwlTDAfk+gWvGUBTw86/rtqsa4fbt/E4Ao0EBONpfR7KOlKsCFV9nh2DbYFVXSb+/wF8O3bsnRMuV6PKvZWWvLnDT/UtQ24ws9OPk5L/yR8K5lVKNb69Vb6NMfAwiMS6tuqwlVNeUKqIK1YgCboHqczmaANlPnXDsyC1t5j23GiyibgcLrbBOmGh0ZkNW9O7aDhl0jchjRj9UmEJ6pSe0MHgjWVZk+83RfDSgdI71PQgLAJS7GYUYHbE/1ziNseKYgfQ5A91iBq56MiNzYGIZMhdamFORnuKmwNFzklcCbzJJvxLHpzwB6YBjqbxc9H9BG6p5Dclk1fhorpXZMx+dteR0w0krTINw6W32znE7Xta2fFR06C/LhQAlh0pmwHfpryPsbTw0Q0+zX2qEwQnLJslgf3AzKAHvkcelYyo9E/xHPAlv6y5AO96OwhTKCxCzP4HNpxiZSnIj+YPCOnpjZPrvlxK1Ph66xjDkD/+kgDXUZ4W0Q4TB9lU1p/FOFJnU5g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9183.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199018)(2906002)(38100700002)(38350700002)(8936002)(4744005)(41300700001)(44832011)(5660300002)(2616005)(86362001)(52116002)(478600001)(6486002)(6506007)(1076003)(6512007)(6666004)(186003)(8676002)(66556008)(66476007)(66946007)(26005)(316002)(4326008)(36756003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WgbRidzQLcQCxtQAjUhgc5rtmzWc8DAG5Yhujt+qA22Ot+Nx5gzTiDijIzDo?=
 =?us-ascii?Q?0Tu6RR2/Li/t1Kr21BOvz4ctW+3IBcIqKPWKiWSMFFpTc0NonTVqCyNCuUu3?=
 =?us-ascii?Q?2DQ6a09G1GshBzihpkarzg4u8Q63cEipY5QZt71ftHsNpis4wFHJguxQjO9f?=
 =?us-ascii?Q?e2PEU/Kbt1D13NIQYw/DRtogqbKMlNkRH/XYn0R+tDijJbCKqT4ovwrWU1ey?=
 =?us-ascii?Q?GRlvgbpZz9k/ge5NU2+rjlz7ggeksf0ghShzUCukHfsrO9B6iAWCfd4m4YCT?=
 =?us-ascii?Q?4RyxS1oUSDT3WpvjIPaNa02ejOIlK6t3RhrA1I4OGL6Fmjdca3t7BtiPiV5k?=
 =?us-ascii?Q?LtetA0td5py7PaYw4hM4ywN9w13Xoakn9/U2l/yWTCiCeufPcNNryK8drWY8?=
 =?us-ascii?Q?5dvUQbJzORQKevqp6BWmwlth5RT3Qzl08Bmozlb6lY/qsWZkcZBWDRfYCDM3?=
 =?us-ascii?Q?/5kvM+CoMdB8GaCUZZDIe1UdUBHE/fgxz24fjhhboOFiap+yW1nZJDCZ1btn?=
 =?us-ascii?Q?IEXVXt6ayAfx3vDCDwl+NMfTiAn8U063a8TOuBrn2vpTG7FUluageRtyVt4S?=
 =?us-ascii?Q?lWa9ip96bBVlb2BAgZpRAoFsWk8J40f4HmYinEjIztaaNSZgEL8zw+FWdb5D?=
 =?us-ascii?Q?ewMFr/8jTEps4bhq0XU5cX2vWAtlumbnAnGR9PA76N3+B3aeznmgysoz6YJt?=
 =?us-ascii?Q?E+Kr0nlq+je9iAmbLdxtv+mVfJqYfg9KzeFlJRIsa/4Vwzzn6UNBhD4r3yqN?=
 =?us-ascii?Q?sFAS/xyzuwI52LS8WvJMUML0Wsx1KJLoxip5R3njL0uvU+Qs0tpfZUAammlQ?=
 =?us-ascii?Q?91wiroCZkF7R7pB4uYOmOgkJlFt9hPN6Grx1WLz9Ddsjc2UWBgW+mqGYjd/y?=
 =?us-ascii?Q?C/6GTZ6CvZRxD2g6eyTvyrOGvJi5qXWSnY6w0RN/mCA3BpIlNlDtRDau62GI?=
 =?us-ascii?Q?GY2/253fidFGFa6cpDiHoJMuHO5hzZsRD9tmctw6tLDtFiPD/295X55OQKXK?=
 =?us-ascii?Q?DvpPXzoRNSSePZWHpML+kM3fEQ5siBU48hC3LTw1P2aB+HN6a70yR36Jjb1l?=
 =?us-ascii?Q?eJ6WiEn8t8fdTJfDSl0ZGjdxE487AOruq7/AuG0hNTCvqHy65LJ9bkCC9giK?=
 =?us-ascii?Q?ZsU9+aiHjAXte2FxwLitk8L0djqRWmqM/2JW1pyJyhLpYxoxKYYDDxWmB1df?=
 =?us-ascii?Q?u7mRvezi2JlZvpRs9NNlIisCloT5jf8nTL9m/HLB3E0saJAyhF2IY3zwSpq+?=
 =?us-ascii?Q?Co79uEikyuMrg9BJgGXoJsuD9uqiix+j+mDwQ1jb7NWIu1JXayUbpG59acC4?=
 =?us-ascii?Q?nGM7vzCuHJ0I3gTUrgNr+sDwXHyrH2O6uR6O+YbL7tXGIsXew7YJxxo6c/o6?=
 =?us-ascii?Q?3pFp18UG/tmGQMwNgVQSteWpW9WHS2SWd01TuNg9E9xCiwC4Y6rBRVGK+QSC?=
 =?us-ascii?Q?7GFkEpvUO8y/4jTggQ74qEPaA6ikzoq4x1VjwJT9I/UtMytx32EE/aBhmuWw?=
 =?us-ascii?Q?/vF7LhVHWo6jlysgeW3l1X0MReguYTtpiOgsfA+k9ndPCUm3MQh4dJwX10Vd?=
 =?us-ascii?Q?QJ5c6RtN2pnrepBaZAoaYlFClPqwLuc/g3GZRNFB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1817b2d6-9321-4169-4abc-08db1961cba8
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9183.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 08:00:02.6472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e3eqMrL36vcVGlowLKefj1I/UEaWbPbDszXP4I7i5coCfOXwQqLpDEY4DwwdYEI4lHFuQxWLBKYOMuFmlFkdDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7058
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MODULE_LICENSE to support building as module.

Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
---
 drivers/soc/imx/soc-imx8m.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index 32ed9dc88e45..1dcd243df567 100644
--- a/drivers/soc/imx/soc-imx8m.c
+++ b/drivers/soc/imx/soc-imx8m.c
@@ -242,3 +242,4 @@ static int __init imx8_soc_init(void)
 	return ret;
 }
 device_initcall(imx8_soc_init);
+MODULE_LICENSE("GPL");
-- 
2.36.0

