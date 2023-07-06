Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE0B749B67
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjGFMJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjGFMJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:09:12 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2107.outbound.protection.outlook.com [40.107.215.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7237B19A0;
        Thu,  6 Jul 2023 05:09:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S01MHSq8s8RU5jy8X0Aucdahm/e50vmvrKiaoTq0u/qAqq8sblbGOj7GOU4D6UiZFZSALqcqCMs0NGCG/MUQ8TdJ8HuoP7oJAoMyKuiPL26lJAE+wKVWyaKu/mGtGJJUW8bk2pD4bEIvkKk5vuMpj/x0ztp2N5Lk30BRVpGfgTOgqVOe9HUzr5TKdYuGYO4otCh3DIBu4b08IgpcYioarXWjgkapRtlpRxWHHkyu/febIRUUZwikFZNDpkHN+AwJPo+ZXljw3R+mPdJ1qCHT+jdrJxoeyAKM4BFFJUOLmieMA684aEJyL5IWcfaDcuIzL0/39h5u4Yj16slVTmFibA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYK0gWsmtg565K4lS9dtcMG4ncAikY/JtazCy2/f1rU=;
 b=nKCFYqprL96OUx/dAykuJcO3Z5YmTgPCllhcJa/XlKdsqDXDZmMWbj8QNO9oSAFf1EQ6F0EdTBn6hzrLeePc0iBVlsE0C7LTmA/LHu+myh/+xTXqIzZsXzE28o0DibNTQGm+15KyDPWzf6QC3tkFXLfbafwdSVbhG68BiA+Pv3+q7CxVZcINGZFtEIFi6pfinu66n1BNWPLPHSC6qK7ZMomKphi6w6qAQuKiovJfD72WkcIwxwbxWxVG+XQvJfDiMXe9rQCSYgD0Lvz7g1RyirW0ho3Dt9ERfdQJfvSdHjnMpoKiIuex+ogDRsEN7rkTDxAn06KgDsqAWB/n+DgPTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYK0gWsmtg565K4lS9dtcMG4ncAikY/JtazCy2/f1rU=;
 b=Kbm3cTKYMEEYpaZk6wKMNJRja82hJVXx/CjiVbhtKV/FolRhtMnqj9K9ZDUSUZLvJNCY5xQBFh2Ac/qhCjQQ9e2Hvihi13JtuaDivn87XJ5+769KMAcyspw8Ka19eq5WmwmvPMmOZ093iOKg4TvFTyxgTpuUhX8d8HKiNkl9mQMBOp0a11kTya3CTRqBhApM5dZbdqHDcWykTE30CGzbdBSl6KLiZ1jQacDW4/WYMqFFzw2YYP15DUR3sFELXCIvAlYcmGFME2d2cLxHysMCpKwg2asliE0Uc8hA2pj7q3iCTpC7ZGqbUTXgaiVA8Ls8FPEYXkN7ubvtKfzBocIvBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5634.apcprd06.prod.outlook.com (2603:1096:400:278::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 12:09:07 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 12:09:07 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Yangtao Li <frank.li@vivo.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] net: ethernet: broadcom: Convert to devm_platform_ioremap_resource()
Date:   Thu,  6 Jul 2023 20:08:50 +0800
Message-Id: <20230706120850.11026-4-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706120850.11026-1-frank.li@vivo.com>
References: <20230706120850.11026-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5634:EE_
X-MS-Office365-Filtering-Correlation-Id: befcd9bc-7106-4868-5546-08db7e19cc50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1TPU7ynRUIz/fpMHptuvDX3mmZPvihlruo1HL30AXkuuANcnA5r+RNIaqGIgmZYPW/dq2cRLqQBK4fR3CVs8osUv6MxEJLXw3xpIS6oaxJBC5QIwiKnGPWxsRv3Zpu+dLA7DKUXU6Sf6Dre4YK31vbc0uuwWS0fxV0U9Q0A5D2EaKkuTwkEvGyBI5Is6mnX4kHxOrwJVljXGwH4hQuknVmSpAmgH0NbtOPrddFKarMSlqJlVpEvKYif+CiioA6Pqvuk7aQKyYDoi5TjCzu7JHMQZsK3DxjvC4zSMyo3b0Y5yYREaEI8IvdwBs0AaZFqcsL22s04YLdTnCAsXiwLQBOfMkkz/9A+Fv7GJqZQK9/+qguPnvCCyvYlth5pK4Zft8x+bs5RDlJNEjUSxOlb/n0AbGjgA45JheZQMBggpJTTDHsbff0zRoMS3xKca4WZcSdMev2TEYqB3A8TEHtIVdKii+QG6ShEktzVSz+ujMzIEExxrv2JyvOMzyl/8ktQuBnNGnPkBnXSWi3WARn+8QeDosyqtO0hU1aiHuNh0qI+JyPbU1G6p7dp+V0I2gKJG4LmTEMXAnYkJCn6lKOAoDWDf1blUGjvAbLNMN1nK1pDr0CJQ+cM/kNPjzlDgclZW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199021)(6486002)(52116002)(478600001)(6666004)(110136005)(83380400001)(86362001)(2616005)(36756003)(2906002)(66946007)(6506007)(1076003)(26005)(6512007)(186003)(38350700002)(38100700002)(8676002)(316002)(66476007)(66556008)(4326008)(41300700001)(8936002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f8NMqAueIIIt6LE4wGGaCohlRWwGqtyyRFISlxaHhvw99XvtrCcp+5ZZuIYu?=
 =?us-ascii?Q?BXokwaRcJCB7wFWmmYjrbCYUxBGq1Zwlbn/aKqqaW7iB32Ufh305uEgFdJK9?=
 =?us-ascii?Q?2P0HApd5liq6UM3by9lmQgh43Xh/nt51qi7BbuVGGbde5KQLnwLMXOOXkN62?=
 =?us-ascii?Q?Hb+RyUYFdkknnjYqBwOsQcu5en3yz721wQeOMMI9DhmRKhAdzSSUDv/HFeLs?=
 =?us-ascii?Q?7kdvf4U2E9FHEhExsTZKZQCak4Vr8Oq9QkdHsOrmRSmbPOoj8hHzAJCNYw+6?=
 =?us-ascii?Q?WDg8azBaVZHouhJw9oedf9ypl35Zzqt6QZ/VOQmmw7rq7lREZ/SsQ+0GAHgL?=
 =?us-ascii?Q?teFBrJ3ULeyCYb7F40rmaLWGx+fRfJozX0jHFwxBny18KzTrBUuHJlN5pXhk?=
 =?us-ascii?Q?DsPfXjp8wD/LzNeecbvnJXvv3wfYuqJPPn82a2vdP8MjUbIEXNZvz4IiV3r4?=
 =?us-ascii?Q?DY2mzmfUxWqUzBflXqgXkX3Z8ZXhUQ+1MiNWyQhkN7teXX2yUBg+hCvVWJzh?=
 =?us-ascii?Q?Tq2UfKfJliC4NEmKiDe6RkkymWb1Kyomn3Id1xma44lLZwVbOqwsSb11cddq?=
 =?us-ascii?Q?NTj8Bhrjn67al+pBfPoOVWZEm+xy6KO9GpoverW+wPzfSLQldckOTimlpxno?=
 =?us-ascii?Q?/ooo4t55CeSEXW+NUbfkvn9+N/ht52XLME8cw11ln3vSxZA+Wpg99Yr0ZFDJ?=
 =?us-ascii?Q?qgJg3ze0mhHATgsITiYnOx7tRY94foHRdoIAHqss9IeaAFA6QwrwKE4f1SQH?=
 =?us-ascii?Q?cYppgGTHCXRQAZhOCH0ChwNQwmGgJfvOzBtjAz1Je8ix2OXAJa77+DoRZCR9?=
 =?us-ascii?Q?f7OD3yGYcMB15OcTCmrG9v0DO0gtLO5z414HKZMxdmR7xE2ht7BYYTuRXLnC?=
 =?us-ascii?Q?XON5qY2Tws+3y+lMFkuoK0N482H9oT3fKnXW+PQgecVX7Vz1ms+3Ws6qqWbT?=
 =?us-ascii?Q?O3s4bOI8Hn4CNWYb4Slr0dGBLr9kAkDgACgxRuc1dYClFiZfdezU+SeYXsVI?=
 =?us-ascii?Q?KgvigNojZLNyXAHPO9w2HR+PFD9/bhuwuCzLTyg1btaUifeYx8gEu8ov4hIf?=
 =?us-ascii?Q?k7I9Zi6OlrsrYwHFyTbsxY6U4Pl+7xqQimQiO1V+d1CoklToxgeWWPrmvhq6?=
 =?us-ascii?Q?fCFXb9lx5QF/d7epk6kWrpUciGzC5E8szuFaqpS2ljOIrB3jB2TBKDDtkiPN?=
 =?us-ascii?Q?NgcARsYaW7ed3abNOzCTYxQu570/nNrO7XskpvA1b8qTPRDMd7XuqtZyuz1b?=
 =?us-ascii?Q?BkcQaCIpS+CYDcQKof7Ggq6cX3dV/KzQAaCUIFyXxH1I3XhxM1DC5Cc/xa/+?=
 =?us-ascii?Q?uZ9BFN7n1pgz/ns1JkximL7b40hfj4DHdJvWvTmCx3wO/EsgfB7DjJyIXunK?=
 =?us-ascii?Q?tJoAU5wKfRea3DvVBCye8uXO1q3i0I9j8pGskoSVp+SbQiBDbcB0kambTH0N?=
 =?us-ascii?Q?wOxE7sG9D+SBrnitkqF7uwgiinbStjwddeh9WJPoi8JsXL1y30qgYIkqaiXs?=
 =?us-ascii?Q?2cbRr0B57MwC0ckfiVawxzHX1yucBFTrK22z1A1f0JjXwBWXR/jBCMCfUqYL?=
 =?us-ascii?Q?irll13bvHaEhplqt7aP2o+tRH0MIqZbEaFQDUnvY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: befcd9bc-7106-4868-5546-08db7e19cc50
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 12:09:07.1460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2qH3u63wBOexqLDt/E9kLWLIddetmVCCD0eidV+uTsMKYR2awAHw1hyDErFmRjnCqMKtOw+meaIro2fvL6Obnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5634
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
---
 drivers/net/ethernet/broadcom/bcm63xx_enet.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.c b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
index 2cf96892e565..e6b28077449b 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
@@ -2648,17 +2648,18 @@ static int bcm_enetsw_probe(struct platform_device *pdev)
 	struct bcm_enet_priv *priv;
 	struct net_device *dev;
 	struct bcm63xx_enetsw_platform_data *pd;
-	struct resource *res_mem;
 	int ret, irq_rx, irq_tx;
 
 	if (!bcm_enet_shared_base[0])
 		return -EPROBE_DEFER;
 
-	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq_rx = platform_get_irq(pdev, 0);
+	if (irq_rx < 0)
+		return irq_rx;
+
 	irq_tx = platform_get_irq(pdev, 1);
-	if (!res_mem || irq_rx < 0)
-		return -ENODEV;
+	if (irq_tx < 0)
+		return irq_tx;
 
 	dev = alloc_etherdev(sizeof(*priv));
 	if (!dev)
@@ -2690,7 +2691,7 @@ static int bcm_enetsw_probe(struct platform_device *pdev)
 	if (ret)
 		goto out;
 
-	priv->base = devm_ioremap_resource(&pdev->dev, res_mem);
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base)) {
 		ret = PTR_ERR(priv->base);
 		goto out;
-- 
2.39.0

