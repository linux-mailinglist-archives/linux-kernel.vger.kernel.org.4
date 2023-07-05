Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BF574841B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 14:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjGEM1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 08:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjGEM1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 08:27:04 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2123.outbound.protection.outlook.com [40.107.117.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C73B0;
        Wed,  5 Jul 2023 05:26:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCUasleyzLy8wKR14koojITIkJ47cdtw/j7EvXcffpp3F0BcrzXlKlxA4DVJNnxxpaRDT6tryz0NyH5SJV++XzRnY07jJq1kPw/uLmigKlYookaVbfJ4Yi870S1XPr6JUJKNcAcPzxs21os126icbZ52vObRPn4hbMS4ZapA5Pzbk+dT9aJSHrhTopszWOk143CiXJPuK/hxftauIFAE68d2PwYCLMOeOO/UhOMBOGXk0lOA/DjiaQhDP3mFpKFOwbQDHNuD92wELL/Z6XXKQ/PmsrgAg8iogOc+EgCLHLUvDqBdWyF96MBXRvSS6ewu+zUtlvKxX7tiFp+/dF0stA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hDW4ykj5bPi2qKiSLnWOEALPOIdRubEXi8LqQYCLmA=;
 b=YJdKFPJSOJIlR0oGZdEawY5Nyux7HlQXry6EQNRq+ZDfCd6XmZkzRFJJ1j2hp/MtqW/q0lYEqAP/5rzAbOfUhFEFd1cYHVhH3FzlyzuC4fFn4bauvklnMmPReTAG1wg12pK8aAqC1LuZlL2Y7ec+WVuljEeo5q3jLrZF/jVIvWPKPZ7fEyKjs4ZYjJNRDmHtb+aHE6tGg8VL3rMef1K3QaKY7Adfk57Qum0eJ+lYzijK/n6BMka7Nw/akK1JBC45LAB+sQxs1bHd+TUQdsFFhKK/EX1tVuJquXx9PlnMqlxa7WpkcVugYGfrUNm+D07phNxOXBVarjo+TcSei3bbYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hDW4ykj5bPi2qKiSLnWOEALPOIdRubEXi8LqQYCLmA=;
 b=bxaBJxr7alXocmY0ohZqFfm5WA2TFhCrJAsHyv/YypKs6DsyeTaO0GV7v5z8qIsR6bcSIR8KqYnwPOcoGR+Qvk5GnpsXb0Vg3OdTSjgiVCTSbJKS0vXh66ZJclpSk22vuebC4nR3RImaYSSamNCFdNV8I0Ebj52kk+uz0Q3A/u7SXk7eLkXMUr+xvg8ZfoeOuzvmLAww0r7NStRvxek3DMBga8m23NeOv5jyrfqu/uFx7XoyOsUr/FzGI4FLugP85UF55TPy7APwlCOE48Mc+33vLDuAR8cDRQLatl8q2iz174/G9imhtmO/47szN/wJog2bP4ufieNo63dUDrWeFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5551.apcprd06.prod.outlook.com (2603:1096:820:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 12:26:55 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 12:26:55 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] soc/tegra: fuse: Use devm_platform_get_and_ioremap_resource()
Date:   Wed,  5 Jul 2023 20:26:40 +0800
Message-Id: <20230705122644.32236-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230705122644.32236-1-frank.li@vivo.com>
References: <20230705122644.32236-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB5551:EE_
X-MS-Office365-Filtering-Correlation-Id: cedbd3fa-8f60-405f-ff5a-08db7d531e4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o48KgybcstMno6e0JpBD0Yrb60+JzSiIiKaGhAzCiJrEvlltMYu6FvVWZddHV9p+WvbgHa64EFo4l2sKJR1hiKzP7psUAJwnqVu+XRzabM5HRdFyqPySbDSSo7uDtSLDoCEbVMsjDGQkkn0EyyQD1VpAaK+M2Ud9RhrDKTEFT8Iv4JRjshSl+2FPUJdTZz1hAt6gySvtGWddHDtYrf0AH/8gKZo41tW51zkdwz5iFbZbgxVMndmGY2MbYygUbom/R2l/32gRQKJG3hlOFWzJZLI8e8oqxon5bEmi9XEpDDkGOwY47ApRx92mc/GLsL7QJpqwWNuKnua7AW1UubMnd1qJ8FdFdKkjBP+IGFwNSOlm3yfBpClpRGMt0k+uDnZJ3X/AN8Sticn9jT/1qNFDNeSUVrcKg0yWZ5dLCUJL+06UQ2K+Y4EszAPnDg9fAnBqU8vvXuosgkb3kyL5QmFF/6QVydFaIeF199CEZwNK3bC/Y4URHVh6eVDF7mI6EuGWKi6uae5JAHIIriAPQRdfEfcdiLlFqDMs3zR7PB0ZdD/Z+/qli0AM7j3ZHPEtv83k8NMRuZBxBtfG06FVvJpQOHDZtc+Tbnjjfa1oCPhNRb5mQ8PHoE18zYoE5BgyiYgp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199021)(5660300002)(8936002)(8676002)(41300700001)(316002)(2906002)(83380400001)(2616005)(66476007)(66556008)(4326008)(66946007)(6506007)(38350700002)(38100700002)(86362001)(186003)(478600001)(26005)(110136005)(6666004)(1076003)(6486002)(52116002)(36756003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f/X6EUgrDD1lABn0JxDTJz/dwhX93QGkcZMB2lY5GG2/GYSpegXs5iKkE/1V?=
 =?us-ascii?Q?2kwDQUR3Oa1kjt64BORNybm7FxeurtDOal6H9G8qb17mWhQfYjnwIyTJNTVy?=
 =?us-ascii?Q?DeKrqZKmWck39EmhyvHaIGqCu8INbXOkqNO+gVLXW3panvuUkT4KUhCdgIiC?=
 =?us-ascii?Q?rTiKxRHhmSf7CePbDl6S0p9mBI5cQ8xbUPXujrlMStN515NTICFjOqfM7Jzj?=
 =?us-ascii?Q?oCEMQvG2Brv5b/R/EcJRZMs8vuoumXUztTWch7If7MhOm70t+VwJuM04PyNv?=
 =?us-ascii?Q?+xmnPJKrdLli9BAfIltnyNBgLX92cYNWjeE90uonwkVGezXHvJ4Xkm/3DSBx?=
 =?us-ascii?Q?vF5+JMOsBw1lSrt3RhRAMYB3xqxKrtFjIPm4U+9tL8zAJL4uNz3UG8OnHczs?=
 =?us-ascii?Q?U+iGFOS4KIm/s0RB4/cbCHDO2hls+3SAybmWCd8Yz/q9BH6i15JlVbQMFAEg?=
 =?us-ascii?Q?pAS1Vxb63y2n1NfKNcPunyb1Bv37YpTw5ja5f8hOV1Wzq8D/vXb9rktk8g18?=
 =?us-ascii?Q?37tmhjZCkMLUC/GaYeP1UdGQc891ueuVR1gT5Ov9wmGDMziePkedK9Q/xn47?=
 =?us-ascii?Q?2m7VDOKeuPcyn/GDJ2RxYK/WA7g8yUc8ITM1TZb917Qo61CRER1mm8lTx0+L?=
 =?us-ascii?Q?ytdnlQNvopCPRop/rsFP/B4nXRJ8U/2cMJjO+D9FNr+fOLf3SPJRe/oFkV8B?=
 =?us-ascii?Q?mCiFYoBoXmW/FJiUN308FRBgj4N8fM3AX43olTsckWZvu67z/vswBooqLSAw?=
 =?us-ascii?Q?8SHOG7uZAkbc2iEyhGTluzgW8ab8RldD4WzIp0XxDQl5AlBNb9zqrmu7kKKg?=
 =?us-ascii?Q?V+5rUu4wpSUee/OYqxV1/VWPe3nx5GvoRZFdoHbNPTMUTegVutMZJTsYdsMg?=
 =?us-ascii?Q?yyiboYqacidXsaSl6xESvRdPQJ/LUT23v2gXjEF3iru69emb+dR2BMvg8hhD?=
 =?us-ascii?Q?t2WJFMH8SqnjfIDzSLnnBks+7mbvUvD5cuxThf4hs9sSk/7xFyJUtFfdeKmr?=
 =?us-ascii?Q?pIouq5ItuJ7ZKwgiOZDsKpWBD3mtb5URXb0Uk2bOIbR9ddIKhTP7LF+IxFBd?=
 =?us-ascii?Q?WoKPAfA3+axQXp2g/HZm+vYY8eQqXnQZkuC5SMjzs4ZU9UsCESAo08LYJGo5?=
 =?us-ascii?Q?c7rb7znutMFxj8Atr2O3Knh8trkuZ9PKOD8xLP6pOcf7onpOUzB7bsIU86UD?=
 =?us-ascii?Q?kZMBEwWhj15P9jbb9vjx6j3A1qxRzRxMdwrG0nUhy/j5D/Hx2HcFcUf1S3m0?=
 =?us-ascii?Q?eA9e7KNfLE0gutThaj2C816cNHaaltFnT3nuwQJ+xrY2jnIKezRUFqmMRHSa?=
 =?us-ascii?Q?tzfBGy30vWSgbkyKVmMU6gasJtZiX70Jq4JJQeCiQY2pYn50FIWa0BTSXds7?=
 =?us-ascii?Q?C+v2EUkZZisN6pJ45urOUtaYC/M89NRr8Pp7FbrJUX+U2CuAdY8wwZlGHzze?=
 =?us-ascii?Q?BiSZMjvFFYZ+u/TyMcOP1d2J5tc3yoC3bTI/InuixMg4PppAyMrQW5fZbaix?=
 =?us-ascii?Q?J20l0Htu0qta8drX3Nc98pRXrqeaUB+PVc50dOR/Q3ROeJ3u1ZDiJzvYawaI?=
 =?us-ascii?Q?K3+euBDtl0hyCji40JAMuCYuQuAZc2bg1+A31Mwy?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cedbd3fa-8f60-405f-ff5a-08db7d531e4f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 12:26:55.0025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nP6wkJhsy+1WBjktKByhAZyYsiTmKZxds3qTWe7zVZeEWnBVAnpJcvWucCdmqJj+//e6NInS+VoEeE1+RqqMBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5551
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/soc/tegra/fuse/fuse-tegra.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index d7a37f5d4527..a2c28f493a75 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -125,13 +125,10 @@ static int tegra_fuse_probe(struct platform_device *pdev)
 		return err;
 
 	/* take over the memory region from the early initialization */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	fuse->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(fuse->base))
+		return PTR_ERR(fuse->base);
 	fuse->phys = res->start;
-	fuse->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(fuse->base)) {
-		err = PTR_ERR(fuse->base);
-		return err;
-	}
 
 	fuse->clk = devm_clk_get(&pdev->dev, "fuse");
 	if (IS_ERR(fuse->clk)) {
-- 
2.39.0

