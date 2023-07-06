Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0A6749433
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 05:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbjGFD2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 23:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbjGFD1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 23:27:55 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2115.outbound.protection.outlook.com [40.107.255.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282421BCA;
        Wed,  5 Jul 2023 20:27:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MK2/a+e78ah8pxVxjf/fUgDuiUcRAoiAcMATdDh0GjCtKHF0x4U2AXhYc5nHnE3XRoK/VpLTZfFpwz1b/BjmOv2Isp5YoeyY1M2/402Jd2ElcDGsxSsgaM9BnudmlOnSuM/2Q7Q0Rnz9LK7eW4tCrzOaE5PQUSQyvI4oyvPW0RKSPg3itNV1WmsXfolc8ay+DumawAR8ApiwoqE84pDOxUN8An0rmJEpThrSZN9uM9gUL933ZmdMeoEAxtnxxvXIqbuE1PuuVfE97yvEhtuQX6mC0KQVAkxejdt4YcPHpXx9urGZW7RHgyujeiEQwKnXO8ByeaJ9uPjZAKvtVwv8pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ns0m40CcGvHiMhch9ByAoFwsTf5wKU3Ra5aiSpfZNmA=;
 b=jo9PlF4F3+kmzwCEDLdYO8RWKaMI/daIZ62zsvSCz9dhOj/EXmVFa+o+o55X+GMZ154BdZ3hUYiPM75kMGwgHLjJ+53Sy0jVTZ6ltqZ63GbrsiF8+VT5KDKUfGsIGLeJjnh3QurPDwQd537mB2PVxney8Y5MXG6OQClkfdQuGqTeM2z1f479XiVp3z3NXgUG0+sqyhIq3Zu5ZgYHlPlYxtWRz8KGymsqtZugtfsNNxNA19zsojfkyuMen4uuXDyLp33Ej5Luhl000zR1umt6juv+2yzXKW0A9HuSXh6AGz5e76BSDW6LDYvA55SwpsPFFLo32Z1op1vytR5b6RhDUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ns0m40CcGvHiMhch9ByAoFwsTf5wKU3Ra5aiSpfZNmA=;
 b=lRJIR/DZclp0q6yuCmg9vzUbS1QhV67o6jaq4LKUOYE1oG4EeqP3QvyxTtGTEnEHa0aUl+U+Qri4qpHKMMeUY1MkNLXTDsOUpY5gK8YFMvshpsFSvraft6Lel3V9DQktBkC26ZVaVVUcgyySZVZ7x2SQgKRrR/xKd9TVoj+Vn3oGytF9o5MPxmisda8d6ykS5W6LbMvlORhC7fmiEEsTGE/PsaAaVJj9EqhgFqpf2H7IA3KyhFi/6EuAtrmfG6J4V3cetpcSd1brAgvfwe3R8q/fJ0pUL0GFJug+onHYX6URQteQQrkmwewGJ7AHR5+ByQssWWh65cVzPt5b+8EMsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5043.apcprd06.prod.outlook.com (2603:1096:4:1a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 03:27:44 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 03:27:44 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] spi: rspi: Use devm_platform_get_and_ioremap_resource()
Date:   Thu,  6 Jul 2023 11:27:24 +0800
Message-Id: <20230706032727.9180-5-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706032727.9180-1-frank.li@vivo.com>
References: <20230706032727.9180-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0174.apcprd04.prod.outlook.com (2603:1096:4::36)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB5043:EE_
X-MS-Office365-Filtering-Correlation-Id: 41e753d8-24d2-4d5b-d0db-08db7dd0f608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zs5cq2x7oa6NXygGjhfs7GkuKclWrb2nX2F0zUjwfR1i9pwKdqdzOiI/lBGa5P0zaGgIdm61lREAGs8ACEsQifOSs8KB/njSwUBL0kJiQYil48CGywRaOvcAykJ0DVKpbAiErmyPDhxQI10z0dXBDwNuHzFJecBwxpScmfIe2zVj4bJk48itgPz793CjomwhNcfEapDyHCScAUocKOjFvhz7/aERRBgZf5XbYDxXYGhta01s8LbfS4bsE1hj7esNFOs0EIlQelm+++AyhDce//mNp9Qr8eDXotNz0eTUAjJNQXFfOXRCkX5S3/6tUPjUv4PnfTPP4djSBE4Mb2MtDRzkARtWPFa5NaBkZHY/+XWSC016Ik/ukIgQcr0zl5gMO0lJ985pZ8rpnHw5TAHaTu33dUCa0LMjcBISjw5L8P9qQy0UsPMiPijpCQU3ayDt0FUYTRcGgATNcNYN4yikaBGa+/plczda97cVR+vrx4p4hwM0O3EWEJgMTqNOcI+mWRUHGUp1pfvcHCsemgBu83y9JieticXs61Ui2KRzLu6eNkCNcGn2BsNzblB32qWE1kVGUmytlcgawbT4xLnKSnEvvn++sIsS9GqeLyLXtDT/APhayRRGH5VMQp6UBXgS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199021)(5660300002)(2616005)(8676002)(86362001)(8936002)(83380400001)(38100700002)(38350700002)(41300700001)(316002)(66556008)(66476007)(36756003)(6916009)(4326008)(66946007)(6512007)(186003)(52116002)(1076003)(6666004)(6486002)(478600001)(26005)(6506007)(4744005)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U28qL5yAt+MrQM31S72a9upVjsKL4gS+gUWdWWx4IyUn8H/e4EXGAXGKCNa0?=
 =?us-ascii?Q?aq+bDPghXrs/otpZ91A0G+pNguh9iwu3pvDtOpMynxHMn8NfiLdktp+4oRaN?=
 =?us-ascii?Q?GfTxSJN39Kk0KJij+KLIWL3I3wLL+et/q3IXYZgajMAVMZWMs9F7AM1twE9X?=
 =?us-ascii?Q?EXzzEywjGAcHSpZMfckJd9OYb1vYIVrdS17w1pNamJlvkUD0n/sOJ48W5wZ6?=
 =?us-ascii?Q?qFOqtchO4ePd005PH/zYYmYIzhSLVVt/FFPt1kNjRd8sWCXQAPZQEhWlqOv/?=
 =?us-ascii?Q?H8kz1vfj/DAWFHWr3Ix6BIkpKL5GpOuEm2GfTxybZtrysrqaOQ168pT0UL17?=
 =?us-ascii?Q?pm3m/mrNeQkgwNWZjHiVXdeDb9hA8vUfYlfQAUkSfobcap4b82Wz/gpMaiEN?=
 =?us-ascii?Q?7AbBZ7ey3roSaSJTfYlEJUkFudIzUf6ZyQie0u2nVL6pu4Ha2K1V97eCoHbz?=
 =?us-ascii?Q?r3QbaCAk8jQQxGxrWh9vSplrywmjCPtKzVGFQmxmWEBXQvkGRAu7PSNAhfsX?=
 =?us-ascii?Q?Lcddlp8ijClrt+o+zOj6bmhQ2tyaEUQjThe7IGqJoEVjtSQpccGN2liQpEoA?=
 =?us-ascii?Q?gUWwPOFOeVMNVpWDEeUPsDfDpGazYmEXsyaITVFT2kYm0a2yZ5vqsjU8As1i?=
 =?us-ascii?Q?XBX3UvE+4Bp3zqhbleSCsffvcjaUp5oPKzk3/53hEUx0xhtBRA1Uk6K2zViR?=
 =?us-ascii?Q?M/5QJur3SuxDnkwzIv8ewQd31bTZv7wqthFzejzj1IF1Qp71b6OhqfRlyCw2?=
 =?us-ascii?Q?EmXTwNpfYH/lJtIeb56IS7sG0hILHqVgzkaKZNRHg04HlrvTE5oWzTptN5Tq?=
 =?us-ascii?Q?FJfKGHryjV6Ys8BkZ4fdcE3NmGR1URqxo2I5gEEj9aqyVofpURwigW5RcRrt?=
 =?us-ascii?Q?qD1kguMrUE5l54KEGq+a+TyXiKh9wT190tdCv2hL16HHaeVJi7zKPXZsK+po?=
 =?us-ascii?Q?gR3UK8A4ZiGPyWcnjC/2+5g1/xPGBaxEnZbetG1gUUK+6uc+DUMzS2Uxf7Lr?=
 =?us-ascii?Q?2auMvUjUkhch6az6xIEDy/TO+dAfRgHMhqW21fmN398kPxY7tx4OP2o9EeWE?=
 =?us-ascii?Q?wjwncsANFDzWiuLjfdCkrcdsQhvx1QErQg78x5gd/Me2HiGam0o5pkzkiGCw?=
 =?us-ascii?Q?IeZwRyVMjCFmjb+b8ABi8g2XtDbk51pSdVXwb1IFxNvNc5830aWMtwg/+E3X?=
 =?us-ascii?Q?c4fVeQChXKq/WG1L76RTo8bYH/16FwDOrtR/0WPmdocyg/nxIzaYqhP3Phco?=
 =?us-ascii?Q?Ym5F9UbUIMLtVm7t2DYk/5jLP7iUVLcVvD42+0OlUrN6RMDwhIng88ipPaiM?=
 =?us-ascii?Q?JLMdgruqEVY/4m61fftbWbn9CknkQj79N7bs/zGD+YU2ZqyY3Ii51mXIJ/G4?=
 =?us-ascii?Q?0ORoc/rsspx/hdDrKVbH1dtvTgTIvNMu9VZ2eXdbE3041M3thVuD1XL9MKJ9?=
 =?us-ascii?Q?LfEzi6lNfZ9IG830fqOADcBRzGjLV8Y13AKo1XR3zE9r18oZXmLk9ud7jtja?=
 =?us-ascii?Q?D1JRfFDglXn4FGluG0TLxeDc2CpAf3uYPwah0avk05wEEqNMwhpEyrBqeiAa?=
 =?us-ascii?Q?a3H8Y8PgC1gRuVoVPVJK1Px6258SoVnMkq96g+49?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e753d8-24d2-4d5b-d0db-08db7dd0f608
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 03:27:43.9517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /0HXDm0kExPRbvVvCdIJywrvqAir6h9nxzBaGyHePVY52bM0A7NSHUQ9L1HtnHC37ayJSB2SaIJbRWNasiTLBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5043
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/spi/spi-rspi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 08ceebbaf69b..9312a9d58a1b 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1317,8 +1317,7 @@ static int rspi_probe(struct platform_device *pdev)
 	rspi->ops = ops;
 	rspi->ctlr = ctlr;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	rspi->addr = devm_ioremap_resource(&pdev->dev, res);
+	rspi->addr = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(rspi->addr)) {
 		ret = PTR_ERR(rspi->addr);
 		goto error1;
-- 
2.39.0

