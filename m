Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C52747212
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjGDNDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjGDNDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:03:31 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2127.outbound.protection.outlook.com [40.107.215.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6923210CF;
        Tue,  4 Jul 2023 06:03:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCaN8kBdQlUdU4lGhuEPuUWSyIWzDxd3H+8YnnM7nE17BKeB71asibjc5x+yVxTsUjKhheNb4iSW70vnyxGFITboza3JYwVIZSHHwtOgAB3l89jqPAsQ1NbKAYZJWbtxrZBoYxVHwW1JJYwJxPn9plzFuYrlThaeTGegK+UwTcdpXI+8VWDCIzJ/AV7BAGbjF+G9ge6WgLhgYGtVM1olBBg3BHKUmpvroS4SggvIOKgezSJPWrKxXSJ7An0FzkEu4InDBrDIJO0HV2WVOM3cYPC1ryv//EL8sEvqzedaIcGbGSGi2qY7QikBbf5F/njC5pstCUWmSXnNFGLlGuXVMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1H4QRIw5THNFCCruk/I7hsZLPuqOLJzaUmubmAl4Ls=;
 b=Dx+FPXMH5J67qMRA+E5MNz+OotfcL+L0wduZLAjhwDsEd14I+MizMGkDYUIPYBH4bHAq5tWaSXU+bk9orfpdsIJ0QefM3tMlek7beWw9aZixAhucV8Wp997qwfmHf3NY941ewRnWhm5PhgmkOvvxNkg6Jo34Pb4EqvpCo6tNg3HgJEaI25XGjAqZhC41orIpfnpDuxeab94JqSl31IAXxh9ZMDuS0t2SWIJgrYVU9vHWfojhrdxh9T+Uskrof0g3ZPXOLa45lXD0TrJ8DRHvq4BaW3RldOLhCHsNBLtn52KKBc47y3AegXYx09v48/ENmxOXHNZMjI3aJz3jBIYGWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1H4QRIw5THNFCCruk/I7hsZLPuqOLJzaUmubmAl4Ls=;
 b=E4ErRDRxYswtPrbFSrkenR918OxjgydQt9j2lIl0wD+WxOQ3mdOFzc4IiMSoclzU6N47sta5Y7M9jn0lZLMIsV5fylP3LQuqCxpSdG5bEyZZiBApiKDCJCfDcbsArsza/IbRmeI6zYxPtYD/EjVaK7zca8tfcDfrcfd1GCqxXNZGFhBxSptOBNOTiFCjLvl50euwFY+RlwaVTRQq2xJLV9OVwPb3FbaKS4FoCsbDr1+WCPKyB9PE5D3q3/VSkXX6X/NepOxx4wbv2UCP/owOB4ib6DCqZn5mAEEStxIuzAvY7GILY/IyUPMLyP4Be3uVsUY1txkX9MFmRIzJ2zc6GA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6198.apcprd06.prod.outlook.com (2603:1096:101:f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 13:03:23 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 13:03:23 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] power: reset: brcm-kona: Convert to devm_platform_ioremap_resource()
Date:   Tue,  4 Jul 2023 21:03:05 +0800
Message-Id: <20230704130309.16444-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230704130309.16444-1-frank.li@vivo.com>
References: <20230704130309.16444-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0209.apcprd04.prod.outlook.com
 (2603:1096:4:187::12) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6198:EE_
X-MS-Office365-Filtering-Correlation-Id: f33b1ce1-0290-4b3a-a2f1-08db7c8f0c54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /0sEDedAkFLmrAv0oLBeCiMzgj714hPPJ5uUU2Tlnej0CUsXFFjAd755jWLX6oDmaW6/auDGrCCpCXTf4+Sbq7OW3birW525M4AWgsEpq09mZqbn8HIOKVsqUNqquehJ8blv5L1oR26f9MAu3pBx3nbUSEMt3V4MLZtqRmnGi6RYmwTuFN4ExocN55QqQpSz0by8L79EdBbOVG8n//xF59UVMpLWSvUP9mbb9YSOFvBZ1D6tr8uqr28Z/dJ00z8rhfv5W07f1GnH60P0BjKzxAUOh5c4S7vlIKCW6mNlpaeS+4ZY7oCMJph7Sqa+8ZlhfxAFDuw0+oYiXwsmP+e2HcvduTJ9nIplh0NMZnXOTvcKEhSiVyMj928fgGkpC1UlqIwUTfXgQqJcaFVIOeSKeiFQHZ14sQkNUXtRFe8fwjN9QCJ9r3m1OxoU4leZTA9IsM2V121sS4SUpDFefJtlHJqKIHt+T8W2P+aqaqNuOhKRTcpKaWanCl7XBGUSBMeEspDAg9J8R8jP6lnrC1aTvIQ8RycjuCghC/8+1e/iKRCvVPDgFWoG4JY1mgwP0xxoZlkQDty6ykpsX+dd8HpQ1wOGgumDhK5GvGLaP6g4jOeoOKFobTDhIlZu1foyEbpP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39850400004)(366004)(346002)(376002)(451199021)(66556008)(66946007)(4326008)(36756003)(66476007)(478600001)(316002)(2906002)(8676002)(8936002)(5660300002)(41300700001)(86362001)(6486002)(6512007)(110136005)(38350700002)(52116002)(4744005)(38100700002)(6666004)(1076003)(6506007)(26005)(186003)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vpWe9DLR5+TYEvwSLoBPitchb04MLKFODN7Kf4/sVhNiU2j5YIRcEqo6Dzx6?=
 =?us-ascii?Q?2RIsUmhZ9Y0LHDP1qCkH9wzanq74x+BqeQUKWP7YwGcY4qI3AhLwil1t4EfR?=
 =?us-ascii?Q?7HBJE4gT8oEQJ4siM8xv89hJLfcm0TT5qXCnhz8R6FP59CJD2tR9Xuu8VFMk?=
 =?us-ascii?Q?aTyiFkhyi2DKn2sDi3SfIdhEzqCQv6L2PuUC/fij4aMtKaH7W9eD7lXIIy3X?=
 =?us-ascii?Q?nfTHorPrMxhP/97iyw//2jFBxkn3a1FTV+Yi3UftGIvuB4Ny3MMfOAnJPk3L?=
 =?us-ascii?Q?4dEJAWDHcoFAYiIneWJHYrF9tzxG0eqdZA1vvtQV9T+DuLSxMGh4jrFxlazl?=
 =?us-ascii?Q?Mylv6HeOGB8nOqjAM33SYji/WM2Gq4A3ngD1COBVqidw36LnAl7LW23bPxB7?=
 =?us-ascii?Q?+66FBKxFsY0mi+K3gytBcfEuHlQZ83ijjmhL0O2tpJ9CE2C//jwtxRkUQMZ4?=
 =?us-ascii?Q?CUfG/bsu4Dz3/fqBJaAUFOrRf9csSOO38XEC24BOBWvmAmixJEBCU7goPYe+?=
 =?us-ascii?Q?UGcRGrZCPq077Ww4wD3PcRdDtQ+qEhnobfGZIeLpsY+Net8b6MfT+rwiHj7W?=
 =?us-ascii?Q?DTIJuYAl1qE7oeKh9Ol7Tq01zYBoNmoft0oKGFHiKdibklW+kuUr0LgaITzX?=
 =?us-ascii?Q?RwkzqrXaXu2PLXlykbQ7JGmpePYWVOoNgiEZEgPqA+o3JKc1Kl+KCiPmrknv?=
 =?us-ascii?Q?bbNtnGWjMM1imtcyfI8HqmtCuvzqdkl3nRD3H5mBNWxMZ10Tnc7y4QD5aGuC?=
 =?us-ascii?Q?83C41qu+/fH42hYajOVqmB8a4m3zumaKp/tXfV4mrDfGJ0O8T3Twi5fG4rxK?=
 =?us-ascii?Q?ughqR22H+SnKKynRG7F03qG+GhsFB+xLHyuxZvscfri+pgt3Xgr65bI42zTW?=
 =?us-ascii?Q?uiHMSvUbELdTvHGsi9q//5vvmXNq28KalyVY/Gaqmjl2pGk+1U9OXNOvIAFK?=
 =?us-ascii?Q?xodJ0RWXTfofd/7vTl/NgvgQBn7oic+zgVn2zpY84XF/g1oHTokHuFCwVCHT?=
 =?us-ascii?Q?SEuWGjwO3S34qdsU0sY0nrw4YBJem3XZNMncP1OeQb9rxZf6qt0di4BBWl62?=
 =?us-ascii?Q?Tj5Ka12sbne0nUS0iXIZyqIR+eLDggqyki65t74RDkDaA50qVzLJ3qI2/lae?=
 =?us-ascii?Q?38VzAV2DtiFqsiTT4gEL5eHSO0b8jnjaThD5s/E75MW+ndD3M05ICvnic18I?=
 =?us-ascii?Q?wgHEBnl5Zq6NIb43YvcrIRha40puryReAc/iwdaWvD8/WWd7vuP46EIjO/D+?=
 =?us-ascii?Q?fIQt30YSB4C1xgxKtBOm6YLnX4UgpZHL2NvBiKc8GSpOIqaSU7b3tNPrTJU9?=
 =?us-ascii?Q?EXnH8HnvemJmqZRH/SvPnlsqwCRLQI+F+P6Ps1g95fDagfAa40Aqb07Sae0Q?=
 =?us-ascii?Q?3vtkeboA+TxR0dtmAv8hBN+Y+LL//6naiWXrWFuEMBsUz++Oim8l9ZvXwzxV?=
 =?us-ascii?Q?/C3hxFKU+/IL2MqpUaXNYWrmrrbnWvk1VAl2/BXIIG2CLQ+uKkPBe3bsh/ew?=
 =?us-ascii?Q?hvxVC2Xfrb0vG9snc4zMAkxaIpKpMr+Y3FjoygYt2If9/1jkr+ch3vc1KMCw?=
 =?us-ascii?Q?AnAbwNItX7VbzcM7iaObOs8t+0QwRl2wMHPJYV73?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f33b1ce1-0290-4b3a-a2f1-08db7c8f0c54
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 13:03:23.4492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CFNAv96d1UFeTKKRwkCf+NzUD1TUxiqGTFWgpDdvbRocZxpsWn+PjM7xQpx3G97PFDwVTo3FyOnJu2YoHoa35Q==
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
 drivers/power/reset/brcm-kona-reset.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/reset/brcm-kona-reset.c b/drivers/power/reset/brcm-kona-reset.c
index 3de024e3ceb7..6444f6154761 100644
--- a/drivers/power/reset/brcm-kona-reset.c
+++ b/drivers/power/reset/brcm-kona-reset.c
@@ -38,9 +38,7 @@ static struct notifier_block kona_reset_nb = {
 
 static int kona_reset_probe(struct platform_device *pdev)
 {
-	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
-	kona_reset_base = devm_ioremap_resource(&pdev->dev, res);
+	kona_reset_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(kona_reset_base))
 		return PTR_ERR(kona_reset_base);
 
-- 
2.39.0

