Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D44749AE7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 13:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbjGFLkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 07:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjGFLkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:40:00 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20715.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::715])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0FEAA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 04:39:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nH6onbZ4PnehlCnqh/GHTB9p2LTWSi8DzqePV9rINQ4V2Da941YC4FrK7pPKYjpk+7BZgiR0CJ9/ts//KsIcrYWQDeLsFY/kq4N+zUbf0rOPO/E2zhB+yv4MSbrKu82X5Ohh/hstyC125NFGyutQZUZimcdhk658lzbUObIQ0FpedAG8dywsloBYsjwn8LL1rGNa7btsZfLqRsqoGcE6FLxl1X3JW+ns/WQ5cJToYBu4O2pQgntEgLNuDIHPIJ8RFqeeweH+lKN2WS14RP7GzUn+KoAUEsJIk6O1VqO6seA+8ZfAxUCTzi8o9YHF4TttaGRN/RMuyAEgNxyIBIVKdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yK9EleEj0j+QwSZkwxKUGLRKwRWew9Aw2iOcxvDynJA=;
 b=RSeS/OuPmq1qL5GE9G4RuD/0B/PENdiPVWEOYvSlbk4nCwR52+EtmQDRJTjbH/N5YeJopEyMVqyskunR/blEEPfgvDEk4fQnrXsaHEYJffuezVUxOjRBmaOberS2kqtfaFxlVf1JVTBafIx/O5UCR8yAJHKTO48ueiQzehL3IGg0qhw5iVEd8N1xwy25udmnvfkicoRGbz+knVIm/XkJg5mLzgH0n0Pqu7bIdzDPW+Ml/3PnK/zbKaDEG6V5XPaKHFOncFhUlhcf3gjiEZz7A5HLsqGeT/xuohhfaPIQC/F3s+INKJ73PTgZv+/VbUmvMQmbcyAPsd4bq0+ADZM9JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yK9EleEj0j+QwSZkwxKUGLRKwRWew9Aw2iOcxvDynJA=;
 b=mgsk6AQ/3UCKJxa1GjV7Jc+6nNpCEiQh7RmjKr5QHUedI7D2p1zClj8VAPZiQ68s+5fnCAucb7LkjIwf7tU8Z9QoVWEhb5esJFcBlQ1tbhEaDkXOUGaddTltlFg3KCr4NrnmJRRXmBiBI7PhVw/ZCOnk+i8y7AvpQeLl3tRX+oYwIEa/bdoWwA8NFcaz1DVvQQ4YzkaCfmS3ioAzRiyM/lSaAUQMf/4Z5CAe18FOnTP3mYTsCNFteOqnFEcrXXTN7Kvip8RnUqVbWYQ7x8cu+gWkW7o6k94uj1k9b4NYBTwWgAIbrm6mv8Zv4o39mjmtGD10XTBRiUW1AKFMDfZbsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5889.apcprd06.prod.outlook.com (2603:1096:101:d2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 11:39:50 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 11:39:49 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Lee Jones <lee@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] mfd: atmel-hlcdc: Convert to devm_platform_ioremap_resource()
Date:   Thu,  6 Jul 2023 19:39:33 +0800
Message-Id: <20230706113939.1178-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:3:17::25) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: 27b40156-4d71-4c19-7b87-08db7e15b4a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2wCMjNROu3ahzNKeXDoCcpHeiOR9DM850Z4K93WNkd5EzPs97dDdGtnl9PGE2siktoPz6rEgXl+BpF6AKsj8epOHs3ra2T1/A0c7QU2jJZIDPwmA8wW2pdnpibd1P4wxWxM5Hg44Knn7m9IkN8T45HVR+GtPfrP4D+eYVqiRdfSouNy6GHCEDgdNLW9cCENLCqlMqAvsohud1zz/D9UfFD1HMN4SAdNoesx011OqGKbKlfFTjmB6HafV51w5bC7Zv3AodOcL/43XNcH22+Fyhtm5R4WoGpd0TowysArN7SIn4VzM7LESi0IcdwJ8YDrsP7auRnu08Woif/jQzxpAcOy+Ghk3J4z4Lvr1VSUjta/8uF3r02FQO8xS2AS8JKZR7jNTCBhi9xm2JKtQSXsZW4dyEnMcFxkJs+6x1Lms+clwsAUqTdbCgAw9eyeG6KEJc3Irq6guUtkKyBRq83lDIlOYT064vdlzOG1yzno9QouQj6n6lOfRNzO0Dd4UqZCEQUJ90noI61I229yx+KGQB14Gu1udKjrAG2agQIgGLUlAJWwR4lR8tCmTpsiFs0l6ev6rTLuNLvibXvID6ikfMbWjaCLcFc0GnKkIXC4r2L1d/RU+3Izxo4h0wuKuCBdt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199021)(36756003)(86362001)(2616005)(4744005)(6512007)(6666004)(52116002)(478600001)(110136005)(2906002)(38100700002)(38350700002)(26005)(186003)(1076003)(6506007)(41300700001)(8676002)(5660300002)(6486002)(66556008)(66476007)(66946007)(8936002)(4326008)(83380400001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TQud9WsfRnDFb7mKrYPPkPUBKKVYUqRWmrLyM/AIkQXTFWu5IIKrLDEYCuHM?=
 =?us-ascii?Q?b/tnr7MAMCwI5mgrTzjFrKbfxAygPEZx948cbhW9gJUFfX1iluTgotcKnat8?=
 =?us-ascii?Q?SUISSrzBaZ3KCRVlbZMWhCjBf1WRRPiUFdWL7VtYp/WvhRB6NMwaDNiz47y0?=
 =?us-ascii?Q?8c/UBTza+CzVpcnQetzjKVbfTRRkwMpp5QMm48sConrU0NeaHt91QZeCTAC+?=
 =?us-ascii?Q?5mDKxf+btl6NnfVtWHvTfRxik5rgniyq3iNd4tACMTmdn06iQt1i4XYY/kBu?=
 =?us-ascii?Q?vBuzNfs/zg7/My+WaGgZ+jYa07rC6rP6Jj27TDvYp49t2zF8kjdUFx8XbsZT?=
 =?us-ascii?Q?aNwq8fd1fYRxOStcSc7mJFh7rVPwUqdvIMNVyEBarx6enoX9blaJs10+DdXm?=
 =?us-ascii?Q?9zsz2u48teVulXTh3wJKSnRVhQslqvHECWfQZ4CtVX0OGTHAfAmocTy9QevC?=
 =?us-ascii?Q?tsaUhXyZV2vMPIrpcamvxmUZ//g4XW7Ye1ilth+Og/Sk9X98MF9dLnOlldx4?=
 =?us-ascii?Q?zD9TkUWBHKgpSQBziMjbAWKemeCCd+2aTmZGQBT9nqNdJ/9LMWP1poL+VW9n?=
 =?us-ascii?Q?Nc3UoPaOaeisLB7TA3h3+NxpelDCuYcliv/Ffzkp2ga0vNW4ng/hb7WOz12y?=
 =?us-ascii?Q?khpkWZpkKGmGXl72LsqYM8zgf324qkA5dR9K8Ume4PIULGHNQMYSoNEfH5DT?=
 =?us-ascii?Q?4VWEMlbd7nLp9WQdsPBmYAqiWw+ItuIEQnka/wx5wfm6xbuvOtp1ykJPP2Z6?=
 =?us-ascii?Q?bVpCkNtSisPTv+AKnKbJnZ90tTutAQgkVRNivrDNepbsIaiqcZps75rJ8lvq?=
 =?us-ascii?Q?tB10BDO1OH68TxWiF+57NqIzWkuZNZ14DdQK2tKW6y2stRL5LuuDXabE+qBz?=
 =?us-ascii?Q?suzDgPGxYjwvFjwTvatSbPg3V7lJUW23R+Beh26TxtOpdLRb6jVo7gYcEA31?=
 =?us-ascii?Q?UsTAJWu8cauSv8B2K0JRRpwNUJqCve8JTwHQuvmTvoA0sSzc5ail1QCqsVHU?=
 =?us-ascii?Q?paLwT5bVt9pSPPej+4ybStIqF3Q2JqxoEYq/g1DTjzb3NRRnVVG4r98l0CaR?=
 =?us-ascii?Q?KabrkipUw+jgSc/sSLwv61RhO1dy5px/zL1M2IZlKKOaauNzoD8INkZnZVwb?=
 =?us-ascii?Q?nawrgcuyREOVAz5HAgOOEc1lI3Mhuh3Ern0bV6T8+o3qUnrC1y9TtWSQ/Rw3?=
 =?us-ascii?Q?SwlRqZ0YEONC6OBC2wm3cnuIhnUT+NOdu2+t117LM8XGhl+3rmiFonXS8goR?=
 =?us-ascii?Q?iIMzzhsaxkNBriR9Phq61jS6LCKmDCL9K0f/KS7MM5XxD2K7QAsiQF1uz8Sz?=
 =?us-ascii?Q?MPIrU8mHGKbXGkjrX20Mt2t7mA8fmdcuvzY+2rkUIDaCObmy5lon8TWfEToO?=
 =?us-ascii?Q?DSp37C0RfVIChRYvRBHnsRk3e5Pi4HHPt8+gaaX/JXcBg0SdX8sIJqSK1xFU?=
 =?us-ascii?Q?RJ44R6l6LhSum2ybiqCghk7svEICPSgYbFz/FjiarXhErs7pbJTQAEIvUJk3?=
 =?us-ascii?Q?YOMaAPKxL1WghDvLrsbFdI/906kSCxDZUWV35WTnbyvKvQSB58xmI6f9fMcq?=
 =?us-ascii?Q?nZuPyF+On+U0amuL7LlaEStWqWmq8vKNlrNL3SXp?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b40156-4d71-4c19-7b87-08db7e15b4a4
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 11:39:49.5792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wH9WPLaWbQPl3Tb36aHnEwy90g41z8bYXqNSpzQVNDdszXMhn2/Igo2Icz25Tfw00e414f7Aj+UcFHJf0+RZAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5889
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/mfd/atmel-hlcdc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mfd/atmel-hlcdc.c b/drivers/mfd/atmel-hlcdc.c
index 3c2414ba4b01..20de7f49a830 100644
--- a/drivers/mfd/atmel-hlcdc.c
+++ b/drivers/mfd/atmel-hlcdc.c
@@ -83,7 +83,6 @@ static int atmel_hlcdc_probe(struct platform_device *pdev)
 	struct atmel_hlcdc_regmap *hregmap;
 	struct device *dev = &pdev->dev;
 	struct atmel_hlcdc *hlcdc;
-	struct resource *res;
 
 	hregmap = devm_kzalloc(dev, sizeof(*hregmap), GFP_KERNEL);
 	if (!hregmap)
@@ -93,8 +92,7 @@ static int atmel_hlcdc_probe(struct platform_device *pdev)
 	if (!hlcdc)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hregmap->regs = devm_ioremap_resource(dev, res);
+	hregmap->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(hregmap->regs))
 		return PTR_ERR(hregmap->regs);
 
-- 
2.39.0

