Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3BE74CA03
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 04:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjGJCqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 22:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjGJCqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 22:46:15 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2107.outbound.protection.outlook.com [40.107.117.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0EDE7;
        Sun,  9 Jul 2023 19:46:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KY2f0bnL9jl9wKvDqEQKoO52ytq+SjPMvqOpXBevMQFHcmGt8kh6txRLlOzeuFTA5sDacefCamGfZ4FkvbTsQU/ajkav3brLE0fw5MB7tzHASuKWxLNEh9G4qzKTRiJsMEMgTJYLD4zfjT4Rclz9HEFjPqTaEg2O6X2VSvFSF/2S3gZISgsy3/Wx1EHyxzpr0c2HS1mv5S7r9aaZJrk4TbXqJZStDtRs4k52Al97OmjATga9W+Yi7dEcLUHbx1cpWCANQk6NTCqo15wWPjLFDbrngKvYLwT+GRICjl14Z07oKz1CkctTTVhxfgOrssdKBqh4DRwLNV/Z1nB0E0AOow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9xFBA9s/AaoFvOWhJGrw75YQRui/TIjlzelOzhrGWs=;
 b=Jpl8a8QOkt9mgm7mVfwy3VFGW1I/4gsRpmnGIGr/zoKp1LYJEGFrN1CB3V8f6rVfy8+4cal30ziI7w2BV0I3tEbEmOvfGl/e+UZXj2x3hX+xgRvPhxp6cV3BUHMVYH5aWkZ9DVKhfhK+H9o8mr40nDT0rr61jII/dx7ejGd/bczy5QOcTheE7a+q5oxAlxBwYrfho0wBpZ0QvgaW4FhjGFr59Lf0M0xG7pFnRL6e+GMvNESerc8OJcug8pSgoP+85RGpyQ9mdRq2KrnD4s63q9zedTSBfsgv6DG5leYocl5PLftbBVt8nUKDwZPrtscOYAhV5Xyyr1gasS+z71CKiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9xFBA9s/AaoFvOWhJGrw75YQRui/TIjlzelOzhrGWs=;
 b=obn9cH/1+r3UwuN8gZrejYicuxdUrsDu2+4CEcDm3I13cjfK8zxMfLYW6+Y3L9MfCIKRZbAGCtJwsGTWfE5cDOjm2HLvZv2etgpy6X8y/EC+UwStDQPH7XMRT2ojyWD5X1IPTTrLf6xQd1jonuU2rfzDyhnIJo+EuWRreJ2+j+UmEegfen8Wu9Wb7wrdJ47Gh8ikawEJYAvpTi6I6nT6A44KW0r/f1rB2JLcL9WCFliEvNAnhEum5UXeuFaRMI7sKpCjrbGfZ5YE/LcCjJXaXLtURF4igwL3YG6d3k1/LcrbfkQ8701imRSvSrF4fjsEojEgKvNHKzArQttJRtEQqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6357.apcprd06.prod.outlook.com (2603:1096:101:13e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 02:46:10 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 02:46:10 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Damien Le Moal <dlemoal@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Thierry Reding <treding@nvidia.com>, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/11] ata: ahci_tegra: Convert to devm_platform_ioremap_resource()
Date:   Mon, 10 Jul 2023 10:45:43 +0800
Message-Id: <20230710024550.59544-4-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230710024550.59544-1-frank.li@vivo.com>
References: <20230710024550.59544-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0100.apcprd03.prod.outlook.com
 (2603:1096:4:7c::28) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: c16ec319-d0cd-4bf6-850b-08db80efd125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MwYS/oWEdFfpRIK5T+h48aWwY9rmnAYbsS3dDFUBwoM6FddPsyQgFjvHY1WIJytjPUxjKK750nabTjpraJ4pBF8D2Q+O6CXBNeJxLcJWdROeRu12Mv3/1GFnen6TRXmoXQ6+atyXMd9+E5qFtRb3ZvUNep9CYR1ZgVdB1vNo5vwWKWaWhN0fUvDnJANJ71apTzVnmTHZajNvLJZfBZdaeecYyXI7+wj+rwpqGm0hXfZaLd3ns7n/1kFkxi94rgPU4355MLTfigq4zydf90D7LP8wDG7HWuWUr0uezf2X+SIQiNTYgwMTdjvH2ggGpr4QErHQZp6yHfxTr7pkjBaJS+WuVxL6+GlOEu9LkiOluUaLVlKkin2xYNDRzdMhitZqnyYf6seDhfME+vk9BUYK4p58OE6trLMv/nCrqPaUyCjqbHpZ1m2M/3WJnMswYdsIimSuHJzcMBrYPFqukUjvWwRq7qiV8XzbqiFsWOAa5vfSDQaMOs/PHoEWMnotknr8aszyql5MdkmQacoCSM0KG3BZH29ULtzsDw7HSVLt4Xtwei2nTbpVELGfRuXcsDnSg12nWH1UXuoAgNGGaa66hEP78zSRXKG39oKaIE9fqK3RJqeEg9QVdfNcjsOwMrrG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(451199021)(186003)(6506007)(26005)(2616005)(6512007)(1076003)(83380400001)(4744005)(41300700001)(4326008)(2906002)(66556008)(316002)(5660300002)(8676002)(8936002)(66476007)(478600001)(66946007)(6486002)(52116002)(6666004)(110136005)(54906003)(36756003)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tjx4DkYqsWBa+Bn/EBrfwDaw0MmuX7SM/3nK8I84s+JNklZVa0UQaF1xYp89?=
 =?us-ascii?Q?cM2yfGQm0aakscCviys7QM9/YUxuTng3Qnj8yjT37zvV+RPSvleWoOzYBGpn?=
 =?us-ascii?Q?sds/pdV2cL//6SlPPkoR0O1APiZplQuc7zm7/BuDEGM9ax1ahOb3hMx9a7GF?=
 =?us-ascii?Q?0tAXMw95fgMlMNCV34BFUd+PT33+Y99rBJ7KNPqdDHjHpkNl2o/dUnvxidtX?=
 =?us-ascii?Q?B+wzPFR7i8gPT/1dxIvSeUmj1A2nfZK5YSBe64t2Kr4Pfkgw3CNe/LFPXmpp?=
 =?us-ascii?Q?P/Pa2g/blOvlvLy8h9JtxRW151oU6R8nS2VQqhygglAUMGyNUxhP3bvP6+mg?=
 =?us-ascii?Q?RJC6Jx7UY8Ky/Cmi9BNLeROJlOBWde3NN+mh+XZVp5722dG1yz7ShlHLpCM9?=
 =?us-ascii?Q?5+5OLthI2ycAvoFdNBLOjsOXXTJ2C8d9No38H38dE+do3VufUrNJ3nZCSzYq?=
 =?us-ascii?Q?GDUSeEivLzc2jf3H/xCGYFAOfC3JjW8er9TO0w0lpYeKrh5LVzPoeHEblMKu?=
 =?us-ascii?Q?M3S7k8LQxwUGj1QkvAtlWQ5EPB7A5yTd49VoWGaObBXdr8cTYDnywdXz36mG?=
 =?us-ascii?Q?Xa+bT0Epp5jVDfhcZUO2O9fN3BOkIVqRoan7lX+r9xrIbcMdLdd8qyZOOgq8?=
 =?us-ascii?Q?bzuEptY+mKe8kaKNS47yBzFjTUFN5lohyWlWQSkWQEZl+ZS4lCUpxZjixeAx?=
 =?us-ascii?Q?YYrlQg6MaheR7AiKoPzpiaywNb06Flq8nzIFjQYXrqeKCfauVhvzDy3m4hQW?=
 =?us-ascii?Q?yl1ExHRsSszsi5zpf2k2Tcc2Rl9d/qOzZASt6PY5WsyUHiplreqiewVT7DwE?=
 =?us-ascii?Q?fJX70v+z31YpqIoTDFEdc0xq+iAi60lZWP/XU8jx0wFxNJFfCwJ9tqsGhSkQ?=
 =?us-ascii?Q?iJf+GTCNRvpB6QlrArUn2savrmraDTL+Xj54g9KMoJdwInAnZS6ZzQs2XGWy?=
 =?us-ascii?Q?KM0QPVTXske0H8Y+Ihqd3gRtO4javyPVedd273uVTEtnelLyS/jy3pfPVeFF?=
 =?us-ascii?Q?/6lx9ESjRpzD7Qrhj8nYvVilP4SXxxNY8bHaGmZdy9Bg0sDW6oN8+bNXXGq+?=
 =?us-ascii?Q?99z5Dl3MRQy99eNSwyXNuKGp2CVHOJII7O16+8+NDwrrskJhOLBCGOJwnHNs?=
 =?us-ascii?Q?f9KkK1ulcY+Cd7qTFIoupn6thgC+KOxGF1mx0eAehcZvTwLe6I2+1CahXwRL?=
 =?us-ascii?Q?Swv/4ir2tumsao/i6Dv5bTsJRK3A2sHp17ChWM9oFZ4BCy+AVOWydYyEPZJO?=
 =?us-ascii?Q?pRzDJRuJFMI08HzbNWok5E19X6yjiCurOMwbYzZLdxPS+WsGYMf8uiOHDmyS?=
 =?us-ascii?Q?lSyCoqZPyvg0MboKzQFYfbiofT2r60DyxOI3cBfCEk90cGXW+nh+AEVoBAdq?=
 =?us-ascii?Q?YP2uebSN+OnRnGan+Z93EeJpcaWphzpmb5iUI+GSSnQ2dDfuExZwTBvfUzDR?=
 =?us-ascii?Q?2MiuwbYuPR6sbEyI24WhhP6bPHFnIhNzuIYyJYa+TZMdfgiJyZvHXtt5j9B8?=
 =?us-ascii?Q?o2xBWWd1EsmMc0yOVQH8uluZa7viuSLK0nRR1bTk4XujV2KQRtBW1Gzp/elD?=
 =?us-ascii?Q?QQ6qpo/94iiWh4sTaauq6e3MMzY/dNbq5nMXdvVp?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c16ec319-d0cd-4bf6-850b-08db80efd125
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 02:46:10.0024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cOlJfGXLsIHz8DuPcOJw8CuPt3zJnIyzriTngj2o1/L1xfQosegN9Ozjlq3QkqzFUoHG0ikapc0+eskw64sSvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6357
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/ata/ahci_tegra.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
index 21c20793e517..d1a35da7e824 100644
--- a/drivers/ata/ahci_tegra.c
+++ b/drivers/ata/ahci_tegra.c
@@ -530,8 +530,7 @@ static int tegra_ahci_probe(struct platform_device *pdev)
 	tegra->pdev = pdev;
 	tegra->soc = of_device_get_match_data(&pdev->dev);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	tegra->sata_regs = devm_ioremap_resource(&pdev->dev, res);
+	tegra->sata_regs = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(tegra->sata_regs))
 		return PTR_ERR(tegra->sata_regs);
 
-- 
2.39.0

