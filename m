Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A54B74CA0A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 04:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjGJCrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 22:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjGJCrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 22:47:09 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2097.outbound.protection.outlook.com [40.107.215.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB0810F9;
        Sun,  9 Jul 2023 19:46:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uz3Mz21NHlmcW7OhgtHzsPy5V0dJD5S8Sju5TNRukr3SsYqU5TTrQ2bLBpJtGX3KsBVcqGQfACNtq3oTs90mntN/FEKGkfCkTylNtePIw6ypA6RDxvV1CujhafOahoUZe5Fhp7Ejhh8TLc2SrrINVFjKO7OUpQqsPcTw0iBboepkluOwjwBi5pk97Zn1FL/RrmY3XGc9vepaHaMPnSa4DiZq8LQe40RIaK1wo/OWf9Cd0kUqj9NpZgJ7lmGKGJCTzdDypcPNPN6N3jDwXT9vxXWkdO0xt4ja66UdIaYAs0UX3LP+Ak/HOJ6SgUJiVVCFycRB76HqtfF1C7cQoo/BvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmNGZA+pudw6HKwNbheKCXfxYv5tcn68wWhC3SzC6vQ=;
 b=Ruh/+5RVzLDcGWlpUjhpKB23r4Pubth1NIX5qe620D6jb0tniqOO1Me52pBPtxA4hQgZTSfABgz67bKRoBfpUrxT9NRaRZBx8qgCn52JLrJHQE8OBea9/ktpFroMy1tk95h9cxhRGY8v5sQH3cpGsBqJrOozhny4q0yPpn3K/QNeHTymOED3RRbcZzamYuzx3g751OnvVFHz5A73silETxLrjg/CatGBgnogWjJH5rTkcIBVT9otrJIv8dKjl3A8bc0JYqRFjcewbHr7silxPfdQ1nRPpntnXFPSlSS37KYetG69vRp4MPYMLJDnDd4dghx31eUAveobR//rHZD51Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmNGZA+pudw6HKwNbheKCXfxYv5tcn68wWhC3SzC6vQ=;
 b=S1tVj4D3hyf94+8V/06tg3YUFeO0s7yyVrQpdXnbCHm+2EJuVxFDxG56d6d1GzlxjQyeLby52iiC0sqJOB6SJI95fWzmfqaR29taZCPiaJYAbfovaSHnsodrs9yeJj1cJgr0gKquedaCAwLNVGcxDn1f6x/l1FwljN9u/DH72gMQSg/iGQVAHEXTRW9W+YYVeAfpnQ+jisSMnDiWatOFVzXEdKhiHoZk66MLPyXMmEipCV81NXXzyM8vyV1mwo/CfOgiXUzNHkMHmdpHgqzM6mSeO6A/q+jLxCpXndIWGkwh/7DgoZxq2gCNM+X3KmB2dAMEFcxq0wAandH1jjopJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4273.apcprd06.prod.outlook.com (2603:1096:820:64::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 02:46:19 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 02:46:19 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/11] ata: pata_ixp4xx: Remove unnecessary return value check
Date:   Mon, 10 Jul 2023 10:45:48 +0800
Message-Id: <20230710024550.59544-9-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4273:EE_
X-MS-Office365-Filtering-Correlation-Id: 57335ec3-5180-4e79-33bf-08db80efd6f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DnFW8Qv8ytwrnDZ+1BdDA6tqmNz0pvPZzIUO06A6CTInW3Zlkcy6nsDk4AtussOjyfhoeHi5498Fi3zZCPVhdZgpFUmPZquibcFjlHTVOubtpbp2kNsCqHbx9dplIGBrX8tvoVpOkq2Floe55eTfUFmOyt5K0t/ao+r2qxYfqCv9rmxkZ9W8nXcrjLufKKFt//Tj/RN4bE9tA6OBBqMZZwUx9zbgr+AGgjBZ8xKhSCoy+UpmHiVNTs2oOapWMFFP/egq6vohc6vXo3VBmmxFmcJCxrfnXTFTBrWa6JIcmELT2c9FadfxN6IS47CShXML1TMnPsqaSAmXabQn9DTs2Hq6wA6KEEmsN6pFdnYi3ymhp5k8EulC88dV/JedvxS84vcBGmk8u777HjYR3xWXf9T+jxbLc4gyXdK7cSmcU/mqoaTB/VPhlr0RAfy1KW/CRXW1KcvDftQdac0Lc5QZplt4P2lXsWk/pdZguzTMbKHW1xdMKBMIwwCLZ/6ZXEzqLhjVsL1DsDoazXy9XiF5WDg5FefDUB5zTZvcse1Nj13Lr7QRaDkOj4uH1/c35fDL5wfwxqroIK7J/78O3bFKop3V//eyKXdhhTMPaJZYvXdFqHMWoTspaaEtMubW25pt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199021)(186003)(6506007)(26005)(2616005)(6512007)(1076003)(83380400001)(4744005)(41300700001)(4326008)(2906002)(66556008)(316002)(5660300002)(8676002)(8936002)(66476007)(478600001)(66946007)(6486002)(52116002)(6666004)(110136005)(36756003)(86362001)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N6V36n/1i4m8XNKUYrH7P2WIlTFQkmC6paWnnSIT4meoLwzDJi/ANFVruxmL?=
 =?us-ascii?Q?m8A3FT7ADy5zhzv0ouMwsVbzMTq3R9YJnN9AJ5HuviKOUiJnbuGN3SCXaPox?=
 =?us-ascii?Q?2515k3RmL5S3ycZf/xohEhHlauxljncJ84xAOMCJDyjbqNhExcTU72S3+OSe?=
 =?us-ascii?Q?mKI9ch4WQDd4N6YPBiR9xF/O70vwpZ58hHC7UjSUFQRFskd7CCCRFCW55BxT?=
 =?us-ascii?Q?cPCDUgoffKZmsj4T3nxhEnQvd8TZUO3utQlRw2fWTdcdj+coOdwRMemBR06n?=
 =?us-ascii?Q?eT8ZywOVTFBrONwoidPj/kQWuSgeaXskiDSl/SdpYx+1LNRIr3KfvD0kQXkh?=
 =?us-ascii?Q?meO9TPlo12znli97FyrQOiwtfKqq/xJIxOkJATl7XzqoCiqUydlBJrabLIrE?=
 =?us-ascii?Q?arodXKniOyN3b/Th/maklp/Cg1aSKnkvjwFQdTC2MxtKnbzJjQj//m0gsMUb?=
 =?us-ascii?Q?fsBSq68cAahiqdSyGQaRFdQrYXYAnkQGfw2Dcw2N2u6UMEx47iyVIABlrWdT?=
 =?us-ascii?Q?WDHoXXIqsw9uSz6jBmj9uGStmFRQOdSaAYDTFlAmLBg5VAISNv39gQsUmtZZ?=
 =?us-ascii?Q?i1pIUhqixsnwyuvpHcPF2KoP+9HIc+7F827EUwVG00Nf4KglNPZobARtuR1Z?=
 =?us-ascii?Q?HnFRQYwZ4RTPq4Uuha4UvnSiyiBsUJYRzp1JqwZnfx6s2GWn4UqEpm4Lnhml?=
 =?us-ascii?Q?856RDyrb18i3DCpT3yQEMa+nzfmHD7ghX8QU23bLu+AkjH4ELfItrYzKWvC4?=
 =?us-ascii?Q?XNFyZVmZg1YAe2F2cSax0BGYD83GfYSWt7gkwNjx2rXB43B2G0i4bjrCCUgf?=
 =?us-ascii?Q?3cS2l2Sd6GC1hFMmVfLF5JCJdSvcd9I5iQJa5WAdTaK6tXqpPUjElbuzKMv8?=
 =?us-ascii?Q?nYM0y3RmckZSDGc+6jOjQXVmzLYJgEfRx9wWlJ9nRyFIQH7JJtKGJKKT+hYW?=
 =?us-ascii?Q?zcgJ5x1V+UJrSfXxW1UCLW6fBOJvcYiqZRDMudEf4V+2mgBmxUhb0nQu9WOl?=
 =?us-ascii?Q?YtV5TyHQcDr+FOw4Ydih1nbX4PAztpkFUs2bas8J2jxpVinwF0ME6/bkS0qY?=
 =?us-ascii?Q?rURzsk4sGzqiLW3PmstgKHCEw/Ud9DirVcDm5bz+UIUgQ+F5QqO6ndJ8OI7/?=
 =?us-ascii?Q?TDfXRtFaHV79h38kTlLRQVc0sPrgBNhIOKJSKun/KupmJ4j1z5kpNWVw3z4s?=
 =?us-ascii?Q?iOg3OYMNjpnxZlNGiSfkSvKC94wSzOLprwd6rj5z4ZwxLvVPhyQcPJ5uAj7E?=
 =?us-ascii?Q?WDGsBYPu3csZVEglois3PA1wqOZBOkTilE2T5QkeabW+T5pqWoL3nG8lZF8d?=
 =?us-ascii?Q?8tDUje78f/VcJdZmDzRLmh5knD0qzt8/G7J6RSc2ikQAEUEYGue15o4nFFi6?=
 =?us-ascii?Q?sp859Ld6XkaXZ1PkDKaYRMsSpM22fFRihsP8OZZq0b3s429fLR7397/TrYD+?=
 =?us-ascii?Q?QKHOBoiO1uh/gEvaVn6rzDzGFaKYJy4znr7W81VJTLiNFKDakJxBNNr5ofQu?=
 =?us-ascii?Q?SzrLLNyQ1w8kSYNiM9qrvw0zL8+cHdx+mrDdspQ5Tqw3xBrLubQqSGStEl2k?=
 =?us-ascii?Q?vDu/ZzwTfnNpKf91BXBevwZPpAxxJ7HlBFCXDxut?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57335ec3-5180-4e79-33bf-08db80efd6f0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 02:46:19.7059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JSewvr1gXjxuCqc4UvpReB0sbGOULGyrK1vu401NF04cuBWEqmEQMOvBMP6jdYfEwccfkSLzowiDiCbiML5uSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4273
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As commit ce753ad1549c ("platform: finally disallow IRQ0 in
platform_get_irq() and its ilk") says, there is no need to
check if the platform_get_irq return value is 0. Let's remove it.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/ata/pata_ixp4xx_cf.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
index 1b9f67e16864..246bb4f8f1f7 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -274,12 +274,9 @@ static int ixp4xx_pata_probe(struct platform_device *pdev)
 		return PTR_ERR(ixpp->ctl);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq > 0)
-		irq_set_irq_type(irq, IRQ_TYPE_EDGE_RISING);
-	else if (irq < 0)
+	if (irq < 0)
 		return irq;
-	else
-		return -EINVAL;
+	irq_set_irq_type(irq, IRQ_TYPE_EDGE_RISING);
 
 	/* Just one port to set up */
 	ixp4xx_setup_port(ixpp->host->ports[0], ixpp, cmd->start, ctl->start);
-- 
2.39.0

