Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81E174721A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjGDNDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjGDNDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:03:36 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2127.outbound.protection.outlook.com [40.107.215.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D8D10D9;
        Tue,  4 Jul 2023 06:03:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eu+F3oqaUTG+l2LHiQtekIjTMSdgExR+CBZq5r+dl6pyI2L2N0WPBUj0Xk2yrpZAhBxybALgHODqH0mszjB6KGN4Y979wgNc/uOQmHjutxusSrMU3v770jbU4W84bCCNLk4a+xKuJHiH52ozIz2Ju6A5LR6lRLYTgozBs6e+YigH6goaJuSE2ZzWk/657s4FjL7Mtqx6i/xm4d4oWdPxtXkFG14Oa7z5/7QZ6i6ENT9EveegtvkhmUrY8rToucmfNsdgxvS8qX0cGKTDMNIzTHY38FXU1yYI/b9CufuKYQLlBoyr6tqb0ttBHHyv/C3yxBjhzIhz1uTz+MPChBHO+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJJ5pMnb1fr2kULRAapmovW8e9ZPi/PWlNlldzHO8tM=;
 b=EuRORoa5nsJLmLivXPVbl4r7Fy82lYPjaCaFm1DQ3/hBzz7SB7o+r6rYYtNKRNuieokWNk3mxl20CFkD28c8VRtQkDzCMsQicPwsjDEjwN9+G/pH3APXyUx1iQpC9n87sov4XWKGVVm4ZqbHe8a7SPXsN8eaidzJf7jezKpaTZ81LVqZYlMi7qneCgcXfzAM4nJajoDu/5dxwbuJqVhiuzRoJlzHjxU3Xvh4ErEykI2vQtb+xTTNVxGfGIT6HCIP2ucicCWKtLIHpwbc9vqRjjzvK+G1NWyqMVe82/pg8DuQVokWsgMTa9T8IH11cHtxSUttdhEK3zDPbYnL78c43A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJJ5pMnb1fr2kULRAapmovW8e9ZPi/PWlNlldzHO8tM=;
 b=WRs5lefmUSzeCbWr7yBRH4WD17MA0YuecU5ka0CUb1aPNDa2nUrByuMBLa9L36yUvdJSndibOcZO2RZmjgnPAPqc2WjzSzIY9PKgjyHrYml8ncipKW6F+IGltppyA04r56wTAEqdrvTIaTLGqr3X1b9mufelkWsoVgE+bDnrRLND/iD+5/zkehAy8LcU8jlYCRaYJnDDdE5MaUIUfOCvIRmvTEMTQkMSF4C6VanogRv29KC6rpFpCBT2tFAFnV8IXCiX2OcHSNudkN05dGEub7CQ+1JGw3YpiT/XKo4mLFrueo4GNI65fwlEA7NmLVUAcViJCCya78DJ5C0MjvDExg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6198.apcprd06.prod.outlook.com (2603:1096:101:f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 13:03:29 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 13:03:29 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] power: reset: ocelot: Convert to devm_platform_ioremap_resource()
Date:   Tue,  4 Jul 2023 21:03:08 +0800
Message-Id: <20230704130309.16444-6-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 098f6a32-5448-4aea-1880-08db7c8f0f9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E7B673vMNbxk98Mxzh3r9EyRCfa3doYlFjaXOUo3oqObW/LPeeGM0ToYq1BuJy7q2FN5567WahEwuDoQn4fzN34OOd5CNP7avBJ+q4+qYlVKbT4c77ZJSgFTgvMNqmfigozd0RIqQjBNjHOr8oOwjBawBRIm8+XivadvVA9x0XBAyzdOp1sUEmKaq+YIj720qRBFCGjTsqGSTJMxlrhuLjTUhOkSSDXIG42I58aUUyv9pDWbbZEaVX4GHmZ/h5dJ7Uo/Fw2bjekqHfcipPXrfXszPtKiIyOwVSPMaEpe4+Tdx8gIEWMOnpkdX9c3KwRDSQw43vC1nfXu7/0wG3jKxH8QejvB+MI0npYGW6wo8YX4EkgYE0G2ov7AfkcCMy6cTCBdiDcm+Wbkz/viqu/adBntK9cWDmWzd9fQkHLUmGIM1D7ANyqthH+dzvC7GLbyiyY2Ag0s+LiiHR4eTfJW7FHPaPzmPK5FjU+kRucrIcyuUM60DhYxEsOXMNQhJkA3G1DbMyKkkTXEX0D42+WnAUGQ606JBqLWhzgvWfoxJ3NZAM9LaGfdgDqAybZrRnIPAKIAMD19B2dIZ7Qc07AEJP6mhS4iM1kiDjqULGyL5o1deBjZdCw/yMR6dsuL8XGA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39850400004)(366004)(346002)(376002)(451199021)(66556008)(66946007)(4326008)(36756003)(66476007)(478600001)(316002)(2906002)(8676002)(6916009)(8936002)(5660300002)(41300700001)(86362001)(6486002)(6512007)(38350700002)(52116002)(4744005)(38100700002)(6666004)(1076003)(6506007)(26005)(186003)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o0uIknqmzpXmikkw3kdPZ2LrM0imMjEWROE97m+mAfHDOrxlCSa6e1iaWlfe?=
 =?us-ascii?Q?S51z9iWjtmvnabrnVHj2M9o6G/G6CBkc6Zo48scum/lviTUglU/+a2YMRUsU?=
 =?us-ascii?Q?2q0TH+wROiHHZoOH6bza1zLGtYy6bTRpRt6itUvSdx2ZPYu9lz2hToZUr6uc?=
 =?us-ascii?Q?YNHYUUMiCd2RXoXj3dU4upIxi3n/jikS102A65eu9iiwnYr8EYIEGGILpSso?=
 =?us-ascii?Q?lJ/TC9FfqxQvgNE7XDnu58TFJFox8vqa2473MCb/CC2c/nqy6luIlGtkKcM1?=
 =?us-ascii?Q?VY9IaRHFmrasB1xaoCxg7wfgBc8cKiQXXBS/NswkwEBxPuyESDcIn1nPSXbz?=
 =?us-ascii?Q?2sI84K3s4Y5kjvC2aDc/k7WfsU5VQedonlztPrRtYv1yrGUz1Hgqgdfk7YO7?=
 =?us-ascii?Q?KBG4estWSsKo6y4B4mMQDp78mbD8wNLnWnxq9CD3FomUaGbY5wtOtIM93rLi?=
 =?us-ascii?Q?7/Bd7IhxKZQU6BkhPTVl2s3t2C5/3Tz16JfgUxXTxJQCB8CGtDCHskYQ+BCe?=
 =?us-ascii?Q?3+tNYGXD2FjesJhuOxY/X8ZLnnp+22a2WcH23FpTaXcW32uQz8Oj7Cej9e1G?=
 =?us-ascii?Q?z9jVrFsDtEpU0sJxvqfMQ13WJOaE4wRp25ee2yGGjI6K/atdB/rgQEouhcCb?=
 =?us-ascii?Q?meXvXntDn9/iOa3nfldvrMEHXQwtzYinWtIUhnmTaDQdRXKm/hCUIud9/NVP?=
 =?us-ascii?Q?2QtHiadbhbv5vVctK55K6expctTWFDt80Fut8kNSWPRyq2PaJDZZ5GzxMc/W?=
 =?us-ascii?Q?IjLMl/bG/S5NLGCg01qUGv1tHgvma9uyzam5GLlfb5Hhshpg08I9vDNz7+Au?=
 =?us-ascii?Q?xCyS4K9noSfhBKNApXvpO1ZQQi9SlHk/eStcslmSQXEjcNMhJ2UY0EcM0FyD?=
 =?us-ascii?Q?t2OjvK7FK5JxP763bVM+W80tR+mY3CP3RYdI2yz8K3r+YwvdMLv3G/YvjPuA?=
 =?us-ascii?Q?B3Ar9j/v/Je3IcvmBr9cvq0IvmL21G3K+12g6dVOuLe2aEPcJHSggOWfG20S?=
 =?us-ascii?Q?HWCk0Rj+ymZIa8QQTvaH53Pu3RH35Vcp9IgdrmN9nBJxOt0yTNP9kucxo9fk?=
 =?us-ascii?Q?Qy5+kIKXGpFFZJYUxe/Wdno9dQt3Pjy0ZuHDyVSx6bqRdfpPUV3Dk+0kiseF?=
 =?us-ascii?Q?Je/Rphkli0yiA+OOcReGgBLI5TJdDUZLRB8nSfyltH3jAmkN5y1w4f/jO/4k?=
 =?us-ascii?Q?DiJxVyIQUUKesDxnpIzERnp5RXMuSPiaeT1dcOyCNtHzN7IKfD/PYwh21xgz?=
 =?us-ascii?Q?hf9yroHbLKpRZg3CzpV2GyqPDAA9x5Ntf6wXTU9qd5ilqyas2V16JuWGI5Xc?=
 =?us-ascii?Q?UZgK89hDF5LabkowWnpBApNAs5E+5hFM8ypZnnlyo8S2tUi2kTTLIdel7v94?=
 =?us-ascii?Q?h9PXcdVHsHwpUnoSwbz5ToB42dwaO/NmU826QUxEQlxRPYZ/Hf3sNLSfWKYB?=
 =?us-ascii?Q?IY6vgXDot4zhw+DxN/YfRk/dAUc9gtapJVE1dPEmhfh5grX7Qu+dV81bpIZC?=
 =?us-ascii?Q?sBn6wkpnhyLLLDurHNDMnvJgsIqS3ZqQ/w41tKhcOBmFGgUCsDj6v8KHXXo2?=
 =?us-ascii?Q?bNLwEt500JXtj0KLg762dVZc7uiM2Hf5Ulcd/cxZ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 098f6a32-5448-4aea-1880-08db7c8f0f9e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 13:03:28.9478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AFKaJhPLQrXift8vlKZVKNOBIWBmgb6jCoO+Duju5zFFmsPo63Iap2Vc/ndpPEuyPmsvFCHwNJZGsceJ6q6S1w==
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
 drivers/power/reset/ocelot-reset.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/power/reset/ocelot-reset.c b/drivers/power/reset/ocelot-reset.c
index 8caa90cb58fc..031772a60b1a 100644
--- a/drivers/power/reset/ocelot-reset.c
+++ b/drivers/power/reset/ocelot-reset.c
@@ -69,8 +69,6 @@ static int ocelot_restart_handle(struct notifier_block *this,
 static int ocelot_reset_probe(struct platform_device *pdev)
 {
 	struct ocelot_reset_context *ctx;
-	struct resource *res;
-
 	struct device *dev = &pdev->dev;
 	int err;
 
@@ -78,8 +76,7 @@ static int ocelot_reset_probe(struct platform_device *pdev)
 	if (!ctx)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ctx->base = devm_ioremap_resource(dev, res);
+	ctx->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ctx->base))
 		return PTR_ERR(ctx->base);
 
-- 
2.39.0

