Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348F074991E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 12:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjGFKLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 06:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjGFKLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:11:36 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2135.outbound.protection.outlook.com [40.107.255.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790EA1BF9;
        Thu,  6 Jul 2023 03:11:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fe64cXhyesR+dwexEjQJ4Ze76biHpyg+RZ0A1Gc26y5HMihtyudcBKiSvEUaq/V8naOg/7wBIkSmLFKs6R/7jqrF3S0Q1NMcGcIoOOcF6PaUnQhCvrqV3LdWbfQi++VJg9AUP+z8K1imDhyHcEO7XWuTGomMgNL4QJasITxqlPdiOxuHMa4937Owu9wlx9qad8XVBsEujaYX6i9FUcGSY1FpkkXGXacWAv/guw4yTM1H++KNKqrWeS2ba1V2uqoK+bYgjOozH1/r8spxMms5VmuQzDPscPoyOf5Pa7C+npFK7uup990OX4LB7vt0qhcrj90tAA+ZnMwz3bDoZgxS6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=md7tMaMi1unlCGMomdwbM6AxR16e8iBpJP/txr57lHU=;
 b=OcD45CkLnpkG3jKPFqPlnw01CxTYG920faFOaXJfEIdRXST2KZ3IPfTIThKuHbJJ8axa/D4hUzia64W/r16KSWzSPKXrT2kLPrXwtiCyma/NqDDExkcdphm9TwhxWhrD47hXktj+VOAXAwavdcGEzUQGq/qFMschw9/ZGn7yKaFdcF64fT84C88KVfZy46yGCavByaHxUgUO9lcdC9354U7XpV3rY8xpFwO4v1fvYxbpB4o2d3mctbG3/C6WcVz9sdG2yRHtu6aZUgqoxe/0Rh1OhPLLwn07Bg0p2rw9DJo4qgL1WfrSSJ+VeHiSVdpThpXmvrUJUFFo0YHUHP2aoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=md7tMaMi1unlCGMomdwbM6AxR16e8iBpJP/txr57lHU=;
 b=VWB2yHTLjyqG8wXGKLNbI8eCgpcdU6l1IdMWM9FMKWJPxeCN+LTUaFAu6zObK3PUdzK7l5sw6NaEye8BiVXf16f9sMZMwi+lgAxkkipo+MziCcNyFtpXAHTgW8LlZCkHUpbaCTAP6odUubHYgqPZMNwnyjUsJ6WF8wYd2uHQtj0ffYFfJdp6TYVMKqWrUAa/AHMCimaN7mBeXa227lhj9QT916QDP80bcu7bCkr35biL0Lth2RCMnO2ybwp/75dRwYc0j81sp+IHp+kwbKc0z3e4FHR1pCccNN9ax1J4Q75ZhLAYi/+0/rQvDyQBeZIEbY859y911EaEivADTJhSeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SG2PR06MB5287.apcprd06.prod.outlook.com (2603:1096:4:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 10:11:22 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 10:11:22 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] media: verisilicon: Convert to devm_platform_ioremap_resource() and devm_platform_ioremap_resource_byname()
Date:   Thu,  6 Jul 2023 18:10:55 +0800
Message-Id: <20230706101100.75654-7-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706101100.75654-1-frank.li@vivo.com>
References: <20230706101100.75654-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0093.apcprd02.prod.outlook.com
 (2603:1096:4:90::33) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SG2PR06MB5287:EE_
X-MS-Office365-Filtering-Correlation-Id: 66489fa0-2e51-48de-e010-08db7e09592b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mDXUf/iXWULwlR1bO6nYmUODpBgkn+NUYyIhNdkrA8yUWZbSGfV4Nn27K8Yugx1v9LNN1OM0TtBzzYXhqvc7JXczQSCcYgteBkup6rpX2CZpO5uzXw6c5hOtFNADl1ocK1OWgdAXSHR4671pC68wo9USiMxo9QmValR7q/zDzSmrW3QJEuoRc+UnzvLvPaFAuKugnmTgUczb0OfaXbRwvtGDmEcZw7hnk0VIZzglFasFD1uWfeifjl95eqI00wI5cKipFKYxvUMk1Wx6s6o399d8CVEiAjNvT6nYtc5if0eIeKWSBaUW68i4ukXxvztht6lkKrWVCIaEN/SkVdrRURKdLD46d73/Ms1lRpiTkqH54HSjuql/8SNTciVl7/4lIVLmbAtG63hEVg6lBHAT5HiJMs0nwF2x0uWQhVi18YRLBF0Fr9oaSbWQleoroiflXM7P8l7frztgnX4WnbgOWIi00b+ckiEYEj4w2S/oRHlq9wwBWHRdpVTcFxkVrCaiIfpwEaTZVGM4uBdBRWyCjzUPYbatNSb+Xoqlqx+9/ertpbDmMSPFS3eg5jCCebH2EyKgOLdh/KALl/kwY2qnjyodZ9dR19dtD89wx8kh+zZEp/sYCetF+kjFnxbm6oFE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(451199021)(2906002)(86362001)(8936002)(66556008)(8676002)(2616005)(6512007)(6506007)(110136005)(478600001)(6486002)(1076003)(6666004)(52116002)(186003)(5660300002)(38100700002)(26005)(83380400001)(316002)(38350700002)(4326008)(66476007)(66946007)(36756003)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OjABIZSLqVrPpQN4g0+m93Vwr4Zr9TKzwyqhjG72tj46tcH9Z4Nn0cNva6gh?=
 =?us-ascii?Q?Y4p6HHGMccoVE8Qpv8/H85+xyxvbiVqQocTdKUWnTlrxj+5/Obc7+wo4IT7m?=
 =?us-ascii?Q?FZexsGlSf00T2Ta6IrFc6IfTmoSsHmbtN8k+5t5fYuEHXqysHURwFDpNUvMw?=
 =?us-ascii?Q?e5AfW/fewLMWf9N2LU6b7WkaSC4JCCIRjjV1hHdmV1XVEYMsujMjDo+LTKPL?=
 =?us-ascii?Q?28sAA/HeqnNLAUd4vl5jjnnzVLNYyqEjYkKDRNl+NY9kaHjRxHmznUmoHC2j?=
 =?us-ascii?Q?OkU4a5i3aAWAu5N8zW/ORIwaUdxAvrucxIkPWQYvT6WmaNeKJ9xLlrr8H9Pa?=
 =?us-ascii?Q?Hy7vLbCwMxJX6uImAz7F1fr5pZXAm5ulxXw8ztIppqL+A3EXdZvetgHHlzhc?=
 =?us-ascii?Q?ruam7hbWBGHGoOFwaYZgc/CKElrAcO4/QC/vHiPwAbgCNxKIBHPZoiYhmacn?=
 =?us-ascii?Q?3uKbDdrAd+ajendW/oARyROV63BAfFpdcu6N6/C0F+2JUBUADFsM9iDP7UvL?=
 =?us-ascii?Q?knA8Sg3D2XdhVIq5tUSS0TbvZGrZ7AUcRUlyn7AsG8UGbkIN3LttV7s/r18s?=
 =?us-ascii?Q?ZEpIUguASMpXl0gjuuqSqMfK4VGL7OVa75XmVyL1eYQ8VMSYOPSEAOjdzJyg?=
 =?us-ascii?Q?pzjlcsVHSuS0YwbnE0pRe6y63OQ1ox5yBjB73NFaJVFqFEyJpvgMKyXoVqkw?=
 =?us-ascii?Q?zt8VJp/f3o89DWO7UwC1tHnr0S2I3J2VmrtmH2xeuVF8Oa4ncBKSsFBRuJZ0?=
 =?us-ascii?Q?LChUrgyhxg+xzF0SLWBzMrywGII/eD6x3rtMs3gFawpcOPQBhHhQXqQkmJ7J?=
 =?us-ascii?Q?BmBKALgjRE3SCEnFt9GlneBxzmhzU8GWMQospNdDXfZID4UfY8e1FgWMbXlg?=
 =?us-ascii?Q?5TEAFWdolEkRkksax11ol/5Ktf5f/l4JkWZ8O1xPNKqI8rnUD/yl5JFJcyQ3?=
 =?us-ascii?Q?sSQf4LN0MyEZoziXkJD1NPvNdBn9WuJ65ODD2gjSqdq1RdyTu+UPKq705Hxp?=
 =?us-ascii?Q?1eEkRHbw01oQGlVXt3DkBogl5YHLScWFSdlOdyXKcWSCrFw7ZO1iLdxh0DKR?=
 =?us-ascii?Q?+Y1EXJ1u+xSewrhPtOfASr/QAwe/mtnG/YUb7hwYjlgjRNh/uDXGzKnitOmw?=
 =?us-ascii?Q?trYc2tWit4wt2jEv5oE01y3Zpe32dkOHScPb/YeaqHn7q4/RHz8ja/VH5SzV?=
 =?us-ascii?Q?RYRmpmTyChNvj5OrECjjJbO0gYcDuPjnwFlrwLol3JvuRjqgroQ3SdUVjpou?=
 =?us-ascii?Q?0QFU8iOxotPjy6mTa+QhZ2+qZWg+cMH55MJysS4i9NEeWuHQ/tsjGRt3eH6U?=
 =?us-ascii?Q?oghZwOpcS71uaPzTa3dc2l0XubzuQ1/Fw25Lr8GMZPae2JI9rUqygFnCctJg?=
 =?us-ascii?Q?G0E+Q+HPS04j7Wqm4RznllH4YKDpyptXSBHUWCFpKCYF1jttRafFUKfuaIsy?=
 =?us-ascii?Q?G9FFqhAcK5kchE2hORtv78AyFlcHjGb9Td0spzZH+ujBOQrhioP3kNtffWEG?=
 =?us-ascii?Q?vgX0qqdqKiZnbFFmMuju+rqPYyliOAwMQbNOPcxCj+SYBgQUARdlfLOzpPLE?=
 =?us-ascii?Q?Poelllr3OBJcB2a81ZIR/TEG/fzPdIILiimMV6Yr?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66489fa0-2e51-48de-e010-08db7e09592b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 10:11:22.0496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D5ALM38mO6PxxMyClbLw0pFq0ECMMoQDobsmJDpaofX6CWnvUXGLi2o8hp53wXJJ9Lx07vOdH691GRkKgVqZzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5287
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() and
devm_platform_ioremap_resource_byname() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/media/platform/verisilicon/hantro_drv.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index c0a368bacf88..2dea7e0e701d 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -986,7 +986,6 @@ static int hantro_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
 	struct hantro_dev *vpu;
-	struct resource *res;
 	int num_bases;
 	int i, ret;
 
@@ -1047,11 +1046,9 @@ static int hantro_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	for (i = 0; i < num_bases; i++) {
-		res = vpu->variant->reg_names ?
-		      platform_get_resource_byname(vpu->pdev, IORESOURCE_MEM,
-						   vpu->variant->reg_names[i]) :
-		      platform_get_resource(vpu->pdev, IORESOURCE_MEM, 0);
-		vpu->reg_bases[i] = devm_ioremap_resource(vpu->dev, res);
+		vpu->reg_bases[i] = vpu->variant->reg_names ?
+		      devm_platform_ioremap_resource_byname(pdev, vpu->variant->reg_names[i]) :
+		      devm_platform_ioremap_resource(pdev, 0);
 		if (IS_ERR(vpu->reg_bases[i]))
 			return PTR_ERR(vpu->reg_bases[i]);
 	}
-- 
2.39.0

