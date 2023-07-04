Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AE3747210
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjGDNDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjGDND3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:03:29 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2127.outbound.protection.outlook.com [40.107.215.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E934010C8;
        Tue,  4 Jul 2023 06:03:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zs1snLzOeN+S1fR1oKppyXGEmlsPmv11Dn6P49wJKJpiaJHts5IKof+MN/KtW2yUzqNVvrfu2sfASEygqIxQSdORiLJz0e+q9CY9e77YAQoq4O+x+OispjuBPrcdYApNIidToGyTl8VEHI4V+OUp7rC0VfZkPH2uD9VIPYXIgLVYTPmo2YFlCibD/skM4rmAVhLVOAQgCY6NiwEHRvlfPcVmvWJE8lADf9bVA4a+l1IbAtxjuu0Zsa3C+R9Lmf11TVH7/zAyYvuVNdMqI9UCdrN+Ih97CFE1QpV2AUFgXNGkZ+OlnBwTh9B0+pCs3JUq/NiERdH+G2EdC7YpeIaI2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7O4jvljBdWjGRtnVNCj52St+UjbBfVuVP1jgmrHXss8=;
 b=fZqjvJ07KQD93rw1wKDC+Zl6mlC4FHagQWmRV1/guNqSf9RxTWee/ny1e+lNsFFR4s8NzyiOK8NIpRBCE449UmhTJlsrpV48LXR5qAJxiwe1b3CtG/uquu7OvbU+0+hVZujD6a+MqyWohRnT0hzrZb7+8IqH6arvAPeU2ryojValJkmquOQsn68POZsOIcFHPmfGA9FR8z9O6gW0niKWsEQN+EZ7LT2rYIBJACjztJ7yNtgUy/SctyFJ8IPQQpOF+Akg8lQZRRSe/hYGrQSUPHMbE0Z/Z0rp/f20mQbwuOr5OAYLVc6Cz5F7oS8VfjPoBG1f/deoZWp6at4uCOxhew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7O4jvljBdWjGRtnVNCj52St+UjbBfVuVP1jgmrHXss8=;
 b=eb3vx2p/CWQ5MHvaUixj2qUEVfMaRCRbde53uziRuUhOgujuCsyG1caNHkvCaBdAhgHoN3ZRSwO7uEEAg4aKv48JZtlXdJyVTX/K5J+WtOSGF9ICg7r7JSG37MP+OPbU/2Ngzd+RCtLsSx+BrHC4KtO66/2VJ+UiaS5N0lT9B9821sttrRVFbZ21LPgxP7Ji2wvfR4fIsMjoXiRKc68D9jWR4HGZ+WO96gZIKSWqvVkCeEU64tG/mrd9MOrjrk6TS7aCJJXH4LG9R0J85y6tirMb0m20D8anHeSeLfEF9vOFqJHmAC2bWfDVE7HOk0jCSPmlrEZh1257jHkXkcc1NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6198.apcprd06.prod.outlook.com (2603:1096:101:f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 13:03:19 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 13:03:19 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] power: reset: at91-poweroff: Convert to devm_platform_ioremap_resource()
Date:   Tue,  4 Jul 2023 21:03:03 +0800
Message-Id: <20230704130309.16444-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0209.apcprd04.prod.outlook.com
 (2603:1096:4:187::12) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6198:EE_
X-MS-Office365-Filtering-Correlation-Id: f949c01f-31ed-451c-369a-08db7c8f097b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K4w3Ww3mOGhEacEe0eLyrVtjh+prGap3pNMja4vngEX0UTDTVzOELKQ9mwjRLRLnv+dN8/12tXqE1K7qRSScuNeegS1uSi4t1fIiE8OZd/JQD/S/+MZFc+x4Qg44LVmhHo3NalbW+jvRGExqW1ZJxvdyQHlmPB9qzxBFuEg7GKAWBV4c/hWFV8Cxnz4q9VGGXux2BY/6tpYAr0dFw05Kkr6k/EgLZRtel+yisy2mUd9/rQ8slfvsyiHE6fuBheFcD8l5jW4kyeCsfUTdVCVVlwYlZASDukeWwRh+AdJygPGwEMN4nMW0ijr0GEdN2Hk9ZywN7VQbzimwC3S7GEFqeu8Tcexbs45drJgl4HtD3k+GSmHskI8kKtS629iwBtz1SD2oXjX7DrGE96Bf2KgFubwhijuPNZlwXOUdLdNiQ4drYsvIaaioDaFLLxiTUpewLpgOOCSxGL/5j8uH+cyEA1L2TEH35qIVOFKvqSO4HpoUdZQ2LaLjTBYBvqpF3R59q2pMcLJ2LqwY8WwUVunj0beduE5awwqHoXxFMZRms/A6QNHuPPzU8JPKuffrr60ruuX9wkTc8BCsvkpXuvfE9WaPxX3gINdq4HeaEZEdpKWz/uNMFbO8PbDzw/S+ScsP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39850400004)(366004)(346002)(376002)(451199021)(66556008)(66946007)(4326008)(36756003)(66476007)(478600001)(316002)(2906002)(8676002)(8936002)(5660300002)(41300700001)(86362001)(6486002)(6512007)(110136005)(38350700002)(52116002)(4744005)(38100700002)(6666004)(1076003)(6506007)(26005)(186003)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TsYveq8iOvWEN8M1qrmZZBjrRQ8Z7zWBA8wXbn7kYtvuzhgud8VhmU4+4PYC?=
 =?us-ascii?Q?MMgX1mnwCJxKBmUiiQUq0yrDDEfBPBd6m/U3boTPFUsioUOQoToJYSKhJsYw?=
 =?us-ascii?Q?GZ9M569/n9eI1Tf9uJnh3mNtD2ZB9CLMR7Ppn1G/E9mbxYUilqWo80Kzga8l?=
 =?us-ascii?Q?bSwL9Ew0C0UHMqzMq/xcI7xVBpfQhFoN5Mbx5dXEI5VZmjIaX7s15r+xidF2?=
 =?us-ascii?Q?yzDqfqRMN+kCH5qFnVvociqU68OT6QsRIP7z2Zx7vvGXcSThbsFGrSa7RRHy?=
 =?us-ascii?Q?cWQrOO5iqOczIfbH7WNwfy6t4eNpMi+IoHVodOUJAA2eyuAL2ysCNn205PdE?=
 =?us-ascii?Q?qKsLgEOaHf8O0JLBnzxbiuLAq8bO8de4Q4fByOCLKr5o6gOV/vj//lwkySW4?=
 =?us-ascii?Q?on8Wt6hI9e4x4BdfFedt2z1GrIr/j655UHerN/XhbMF4F9F5HOsbbEJHPcAm?=
 =?us-ascii?Q?BBMitGJlUSMEtYRute7W0JhYR6iJp3j6TIVAy8r8pxT8SN6+xb1WVWEp7vvD?=
 =?us-ascii?Q?TIamp+t1GKk8y5ImNKAwQ7RdB4C36yfIQxUK8QAYuvkl2cRdYXtcWPTCvPhZ?=
 =?us-ascii?Q?ezD4hQmB158m3Mouwnho4SsC4QkKr6z7GcC1Qihli0q7NHS4VaRNst/T90Yb?=
 =?us-ascii?Q?f1quq2pO+t6HLz0RyWArd0dntKjzMq71deCg8vH/pbRB2c0cvDahzgPPXPK2?=
 =?us-ascii?Q?5h2T2AusOLGSy26W+i2omXhCBJ/WTMenBwwjWgy7mKj42XeynlYNLWTBBUK2?=
 =?us-ascii?Q?RwvosSm4i4/iKUIl+2dB9pVgzMj1SoFI+TiQLWxKjN6EZ9NbAKUW8A3HSeGS?=
 =?us-ascii?Q?gVgG+EUB84Vk9xIEQpo0muZRxwRJQFxQBVUSEvJ5xWKiiJiP3MBt3x2kmCoP?=
 =?us-ascii?Q?7Fidi/Mtz0oe3ICYOG1kEnig7TDcsATeGcn5o+zePAFBhFppX/4tyTdCpxl+?=
 =?us-ascii?Q?PNPtISFYwKl3EtdCFKef9Hx0VHk0K6KsxC5R6tbuRS6yZ+36Kk3K2MJpBmXP?=
 =?us-ascii?Q?F1zZiH/vRtcbdrxgbDRydKYRqAruMA6QAt2h9YgMVkW63DXRixlLiBfCidFV?=
 =?us-ascii?Q?3dGH5hHAZ5MmgF5sLO2NgcGKL7K0G2W/5HDHjpwTFEYCFwgPtQ5lI+g5VpAR?=
 =?us-ascii?Q?CIKyVdI3PLi0SPtsPm/SpmRc5FbuawuKAjWeLH6uUrGNgmzGZpS8ygFEh5y4?=
 =?us-ascii?Q?P5x6bVQyj46xdkoLw8uEoXEyAaObmjoTWYKQ3doNKP+Viv2VtYKpjA4OfGRE?=
 =?us-ascii?Q?ozYSoTKDmCzInmhhJLb32Y2YLseLNZFzO/5yCxFyk00Hvj8Eo5qjzbwpxW6n?=
 =?us-ascii?Q?z5EhSuEHR+xdSpq20QyKRoskvHgJwh1IhM5SWkT7p+P1GVYpPGYqueakBlLm?=
 =?us-ascii?Q?QeI8TC8Zj5bFVLNXMGT+Sqs/IXbOpC+8eGP2w3IXODRbinJKOj9zFTg1pbof?=
 =?us-ascii?Q?HgEYAZAfGCcPdiGY9m5dBZCemUDiK5yoiaiFaQ/r9BDpxsGXOC9/g7yy8hQm?=
 =?us-ascii?Q?WHlxeBpToI8sc60sZ+g0d1leOaLmgFcY7Qx9oIPJRwQBqqf0CGH8Qc8eBoE7?=
 =?us-ascii?Q?DeIKgTlG0Kq4j13jVsxq6Nc32ctPcYiYSNnThGQm?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f949c01f-31ed-451c-369a-08db7c8f097b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 13:03:18.6665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4eGqdZitlPKgcTseFF82nRXJZofFDy/EwOW19vHmXq7dSAwbc+FD2rcXYlLDLT1eyKnzJ093gu3Hhc6Khg5k2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6198
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/power/reset/at91-poweroff.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at91-poweroff.c
index 9e74e131c675..dd5399785b69 100644
--- a/drivers/power/reset/at91-poweroff.c
+++ b/drivers/power/reset/at91-poweroff.c
@@ -151,13 +151,11 @@ static void at91_poweroff_dt_set_wakeup_mode(struct platform_device *pdev)
 
 static int __init at91_poweroff_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	struct device_node *np;
 	u32 ddr_type;
 	int ret;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	at91_shdwc.shdwc_base = devm_ioremap_resource(&pdev->dev, res);
+	at91_shdwc.shdwc_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(at91_shdwc.shdwc_base))
 		return PTR_ERR(at91_shdwc.shdwc_base);
 
-- 
2.39.0

