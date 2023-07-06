Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193DB749487
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 06:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjGFEFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 00:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjGFEFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 00:05:20 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2090.outbound.protection.outlook.com [40.107.215.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C18F1BC0
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 21:05:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlWgDo5IzjEyNs0/1Qc7C2HNMCqf9Qf28vrFRHKN88qJzJgVD+C0ICml5T2izMy/8UUR6euKK60qhT4cBS3Tqk5yWnMy0zS0jC21ju1A8isPH/4utKPuvMEDQPADUlaC+UUVmtDYhB7UxL0k7zTOFrm3nFBGWcGvLOSSQv+grFzntwMUgdW72+EgRezqM8QlB1o8Dg/fA9kK0xDg5R7TDR2U4K5EG5N1k2cUO57kvCG6kXisCa3lzvCbiHA0s0EfvpGAb7JQ6YSpa8yBUWaThSh58VmHuzjGSAGujvoRXgB3lk0aLVm3Y4Bkybu6IOGcfQyCyZRmwGzEDRbIfN0EKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzQgmSD4liK3lnHQdlTnRMVRI9lsTJKk7I9V7JPwaWA=;
 b=QbIdXkDRAzO19TEdfrk6KW03xtcOHscvzHHleIvhnMExA2veXIxv8OSbIiVgsTOwS0dczhfl/JmL8zGon0tJDJoS2GROVbphyAODkZ7Z4xKeYdmIJE2yv0uUZOFcgrF3uagpOONUw/jGC7esWft+b+kSNud2SQ0IjUNdPkkplouZCOmpAFsh4+ncrofUHZy1QTbPOnvBf+pw423k/8nCq4V1tZ14uPA6I4Ab5Op9d2YUE1X96gmBQpr+60FkxBRxSHqG95VbCnWtQvVb7a+hM3Zx3YigwPALKX3vAJijGZ7OTOMP3EqmMHbcqe2BytZ2QDmEd+8pibhwSQQP5Ae3ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzQgmSD4liK3lnHQdlTnRMVRI9lsTJKk7I9V7JPwaWA=;
 b=AOqTE8EjxNLOOaTGmli71E1xOuUQtyxIzYKM+X7xJlorFZDKWJQ4ARAo2qnY+DqJ95PEJZf3W8/RK3H4qf0g7PPMs9EL+r0vIg7YFHv+1bReFu+hFzogZqjEmBimY/tVEavAKUW3l6GUY0kAJghZyZleSR1MhvkF7Ji+ZsCQZTSbZoORFgzHOjUeSNwJzapeSg7LYBqCAODVqtf1BJH6S7kVTmb/XGP0u+/P8gkqg2nzAqrkvvPY4hd4Kpqj9pGQZOcvuzolK6j1e+EVBK21En5hmu+jte9j+zw0qHPDWzm6xe9kb7fggr46hjOUII+jjW5hphN/8a+JMUJ/HRG0aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4994.apcprd06.prod.outlook.com (2603:1096:4:1a1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 04:05:13 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 04:05:13 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] nvmem: sunxi_sid: Convert to devm_platform_ioremap_resource()
Date:   Thu,  6 Jul 2023 12:04:57 +0800
Message-Id: <20230706040504.34057-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::29)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4994:EE_
X-MS-Office365-Filtering-Correlation-Id: 0764f58a-2203-4261-2294-08db7dd632a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oBGS2OHjeyRYZdDza7I5al8zuD+WwmLgW2+y2qZucB9/ISmtGfXnU3/s0D4rBETlSD1oBVPRUNyaKCy/nkCv0URLkCwyq3HZzTgQ61+k/nnprJ5ZVWD+7mqU8jh759EMp1sBBfNnJbSfZHjf+iCl+5WgfyRo5b5UUW2B9kBrhAFSqfhDKx8VyxtR+ECdikuE/xIxuPn29kXaaYD3uoJZiO32tD7E7jNs2P6N+vLO1ctXNSdAz+ZSa6E6E43iPRN67/SrsoseOXWtG7DrEouquLuaf/jcGu11KXDKCJ9iAk+oNAEvS5w9kxJzSKbN+PhZIXi663NNgzKNVkmR2XwLU8JSJS+K6pHusX9EyR2c+j7PdBOdBg6dyo5oW+ItSkT+nufVfINjoj+doqkqWFkv/btD9k75D9dkm41NiS/cxzL4zBjQ/65Od9bAIUlNxwRLuv0aqnEihd4Nndz+R9L6v5/7Ucd0buloFq15zYcAAEpeMcETYZGROFg429x2QaHlyZWzSX6fJ3eiNy81lcH2FbdSmthea3xg7kHUEyypjQUMekt2Xejur4pvmyH2aQaMeoNWphZgZtWd3qCIj3qrLwOxNceEeS3S9cXkQo2HCJb+hZ6YUnlxPSR4B2U2jAy6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(451199021)(41300700001)(4744005)(478600001)(6512007)(110136005)(52116002)(86362001)(38100700002)(38350700002)(6666004)(36756003)(6486002)(316002)(66476007)(4326008)(83380400001)(66556008)(66946007)(8676002)(2906002)(8936002)(2616005)(26005)(5660300002)(1076003)(6506007)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MWjlQMSDdhwJHm1RYwJJUetAPuoTk2Twf0NcWZmwdTUF+wruApTQj+dpSR0J?=
 =?us-ascii?Q?sLd0bY2MCpGfVfwd/mWuqDroSaPy9szo20L/XZEY/InUDZOocUzbbTBe7xU+?=
 =?us-ascii?Q?HEDTPT+sh7Bkrli3G+uFlASH0pTHw2xd29W4NVI0NxWtbaezLK5KnGZfnOef?=
 =?us-ascii?Q?0KpLz/8UTUj9WkjAz4/mrFDNvgcmOrZFvZOx9bSl+bGqqcJrGH2FsWkLFStd?=
 =?us-ascii?Q?qoXf8AozwsKMhruoScN0alIYbNojv0E20M8qdnSZi2t5FAZuyHw5SiWG68Sz?=
 =?us-ascii?Q?sFs1KrDbjl7fPEaEFlbj0fDrPBSP/rHQheF2yJnYbhXFAjFteHHnCPEIxl6W?=
 =?us-ascii?Q?PQpeMC6FH2W193cJHUB0qvQHdFShry0+WhRUFXKtWFkP/bo/70/5uj87+jVi?=
 =?us-ascii?Q?GUP/GJTR435BjERsmcAPTJIt2h5FhVBNBZrpNWdst/iOhhUfXQTevTdBXWoe?=
 =?us-ascii?Q?BeMOEqShNOB97/9VjSpYWVhRnRBne3Z2yAjGaURlOju1eQF2Zp3bR3SrCLut?=
 =?us-ascii?Q?EduchHrjF+qU33QCil6WLeCVlw/1s9QnbOvT57TYrv7cyOW263ugZiwbB3xw?=
 =?us-ascii?Q?K9zURqEmF7ZqjEsmC1uC4dooJEAQdW/bXPshk/0r/SBsCe3NCXP784KFiIoi?=
 =?us-ascii?Q?BWbOvsJNhKEtkbF5TpLtuFGBL6UEqPuMlbHb8qr0BZvBYyajVla8BR1RjyWW?=
 =?us-ascii?Q?Da8kyuCoKJCsmJRJGScpY1gBSLnUEVbczJSs1fQuLnV5noyNyot2vBuik8ua?=
 =?us-ascii?Q?fn/0B7LCE7qAGGQmN2YtlPxKJ8cHwlyroxuKPA/IrEnfoJ0d26VLihsVMU6Y?=
 =?us-ascii?Q?iTG1tLyLKUaAYhwauujEvQU0apt8jj+YeNM5QEMXruKmLnTv9TD7e5A4Szjx?=
 =?us-ascii?Q?C+ux3CIDs8vywsTLhzl4Obde1KvCFJ6hmRVL6IikDnxSnDtM/ekFxmsASMT0?=
 =?us-ascii?Q?qOFr/Sew3mhmqQps88u1MVYhpyXnArGL++lB9+lTC2IDIOZ42UkjPCxl8slG?=
 =?us-ascii?Q?PT2WAOBjvE2HImgGctUK7AejGv9mILAsWFdSWEIdCezzD4PllpOKUzxC+EXy?=
 =?us-ascii?Q?WF+2EOI7U+YdOW8H5RDsXBTMcDQAgKdWXPH8w29LrcG5h1gAnkGxhvZkn8N8?=
 =?us-ascii?Q?uDIas05b1+3x+fOiThGzngoXIH7K4G67/Aesth1Nf/ToqExjGCp2U0bSeOO2?=
 =?us-ascii?Q?cx/Al7wIiO7q5CeUMxeBecoNxE82zjMqi3gJPCuMH69d1FjozhUKrwSYDeDd?=
 =?us-ascii?Q?FVCLjsylqWRjobIBu1gZm12J+QoKZYuhweIK1wefAL/LFVZ/BRZi7ZmYs4eE?=
 =?us-ascii?Q?MkfUMK6yx2EIoOGAzL/pJV0qPztaBRc+AFoNxmR4DQ4ffGHp8z8DrH6j3GNr?=
 =?us-ascii?Q?7jphJD6iuFa9ytDHsZRC0StR/dVs/KJSAW08yfaopt9LdQW3cd2rzG/+fNzU?=
 =?us-ascii?Q?fPlkWpCC1edOMLJvHoXY+n7h5e5x3Jn4LV/om+mWdVqt+HLdBC/71j22fwbX?=
 =?us-ascii?Q?usUHFl8AhyMeWjaG+F56T7FMIA1zJCkuO6eDh2Wjl/lzEz5oUgf/FQVtPvc7?=
 =?us-ascii?Q?U52FOYnbEPpGb+EgOWZsLGMRLQg6IaNAV5aIRW0a?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0764f58a-2203-4261-2294-08db7dd632a7
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 04:05:13.1643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FbrEPo02T7MpbblE0WBR5VIcPTZafEiIAeJ5CBYRl1ey3bLspXcq00HI5uoP/Orl+V/AnCLSBbBRLjoVBxZYXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4994
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/nvmem/sunxi_sid.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index a970f1741cc6..6bfe02ab169a 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -125,7 +125,6 @@ static int sun8i_sid_read_by_reg(void *context, unsigned int offset,
 static int sunxi_sid_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	struct nvmem_config *nvmem_cfg;
 	struct nvmem_device *nvmem;
 	struct sunxi_sid *sid;
@@ -142,8 +141,7 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 		return -EINVAL;
 	sid->value_offset = cfg->value_offset;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	sid->base = devm_ioremap_resource(dev, res);
+	sid->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sid->base))
 		return PTR_ERR(sid->base);
 
-- 
2.39.0

