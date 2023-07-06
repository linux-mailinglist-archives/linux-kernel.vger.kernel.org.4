Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C9A749AE5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 13:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjGFLkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 07:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjGFLj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:39:59 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20715.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::715])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3DCDB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 04:39:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxvznxlOP63xaOzyGxK18qfPvccTZIQL7D8HpLp5LSW/bobjvMLbFN/JI7t6nsXWqTP/P0Eq5msg3YjJK/VbfRF3C4wtr6x4tAHrDwjaqWPZKkO2CzBGoRCaf2WZq0d8XyY7oj+oLeZuLX0oLzMPmhQMLVernNI0iKSpXS9YUPUf4X1iafTTVHaWLRm8KnxV91boiLljrNAt7PtS9V/LZEXA3NkvQvNsiGjUzsbQGdF3qrIn9Z2LAJBwrpd2MXV6cKgr9rbUdbKdmR/RBZiJBjfyMgdIUKyAZhwcDBTS2YL15lVcNiLkH4cuzJDuc081kB3xEHKzgWyjM8RXxgxolw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roBYzc1yLKmrJuQyZPI3AB3Ts7ecD4YcbeZzN+6dOLU=;
 b=Z8BTASVWIk0F9wbD9qVZlOzI2nw6O9Xo7e4GqdBYgvlffaoK4prFzPs5FpX8F3qdRcRmMuHEmaWiDrsg2764WpLZ8jnJdARW5Nke5AvC3ujoMQ1c1sQGR39kqTs2zMMzUhTMinFNruEyi+BoE4ZkjjUg9MOtUxe0XJAojvb3KkFKQiqV2k/FZWgwxSdraeTU6vPA6opxwJiw97j2o+vGIYxUHOJUrIKgoiy7UtRnBm7mABJbFVO4hfYkqjaYW/JSUmPX4Z0fKGIyX2poOGdNc6vfmS/nkNCoq97Z8JWuRQcYz3pXhmoe1gYT2l9+QKoTDsuChXM7mZjrY096+tr7Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roBYzc1yLKmrJuQyZPI3AB3Ts7ecD4YcbeZzN+6dOLU=;
 b=p4Ofk/kTnpPTSNLnL6kWi1N+vvMj9ZRm1sf4Xhq+eG8qWND/Tohz8VwzWGSVU1bDXqcWhUTEfWSnkSWgSAPAsO8hCfNHmacSYQTsfYEkd8MKEaTSUb5pzR+3NPecsw3jSZzvr+AVwA1gw+a3x7K7a14xkXSCX1GwIv0xZ3BSPQHBkNqL4dSLOvdepXBmcFmAKRVquEr7BNCc68YhtkdQrZQezpjHGOXuiTieZxuSew2Gak9eXflp8+PBbDUfJuo5a8kZJC+xlZu8fbFLIKYafbCEX60+tZ8tN/Mk3TvyHagdCe+xzQCOcwZjqDKR+U+fommcQTZ8+SgFL64a2TRZbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5889.apcprd06.prod.outlook.com (2603:1096:101:d2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 11:39:53 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 11:39:52 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] mfd: ti_am335x_tscadc: Use devm_platform_get_and_ioremap_resource()
Date:   Thu,  6 Jul 2023 19:39:35 +0800
Message-Id: <20230706113939.1178-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706113939.1178-1-frank.li@vivo.com>
References: <20230706113939.1178-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:3:17::25) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: 90b57402-aec1-4502-23b9-08db7e15b6ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nGKBQzHlr3vwlXbmkIvWr12l8jxRO1F1GCPQ08ucE81eQpMBbXRU12LRs756EJyOfwYhqL6fbGUlgI0DHvI2vWsIykhynecyMJt0pboJEw31EL7WoMiefwPEsCfO++Rofsg7X2M+G7wISVC56nxh0YINm1pAeUiCNi7yCQzeO/2gJix9IvLfVioepjBxTVWiyQN9Cib5Vgx6+kl0ZLg3IF7HBc2QFjdHYn6zlTdSozdHK5g3gsDKTRwHoixTRLMwa5dTQ3oKTXAU15BI8QjEUoslJSAd/xxxzQGsu4dSZ/ZgQY0LOxfj4+5gktEWT98Wl67czxWxdmQGCElWzLc6gV26SRL9taqDhfVMPFvYIYqzY0tkgqcG4ZVS58KFeMPU7KcXGx5VAGGvRaGMOannoISxAWazpfiCjATxHhdf/gRMBBDblRYeqrzCCjaFMFyEUqsWsmrZqYQ9sPa04x3Uv7IqyZgvGtlwCEAcKrmHke3hUoMzAXeY6a7SYZxyUvWr754NTX4nKDWDwR1WGgvCdirH39DuzvQh1K928YhBcyGdf0jOtAV26k14jlfdEcQm53EUWOQAy+FlgxXzCeZRJqOpFFSFIoqNsgLDLRtnk58MGdolzGgf20FVyJZhDKjH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199021)(36756003)(86362001)(2616005)(4744005)(6512007)(6666004)(52116002)(478600001)(2906002)(38100700002)(38350700002)(26005)(186003)(1076003)(6506007)(41300700001)(8676002)(5660300002)(6486002)(66556008)(66476007)(66946007)(6916009)(8936002)(4326008)(83380400001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eeedIOwJyhPn+hUxJtTVgVwYOMlhT023qOLpRz30Dx7gMGSUdZtj7xIGSfHz?=
 =?us-ascii?Q?8/CQaBBjyqCPDolSQIe8zRX4psGXR1TEop6hCPNFEfS09GhzbI3nLoKKRYIK?=
 =?us-ascii?Q?KF7RbLsjfkbM8qltdTFrSJtjsT9lZTy5x5EAu6EC8h8D8pMipA7M3pQ76Mwq?=
 =?us-ascii?Q?hcI6IbP3nAnQGJLIx3t2oqd6JL5WK1h+3EBRuRN2FN8KaOHfzUuUAG8lZVSP?=
 =?us-ascii?Q?36RV122IhXWtQ6sCSIu7GQBihLI/OMWXUElWPhU4rUNmmGfNRfpDc9kWuet8?=
 =?us-ascii?Q?yS2uDCwfdgkG/k/VYY3UzmZ6u6/4fcpdchf3bCyNFaClJ+Ri4hHRJMNkwuFb?=
 =?us-ascii?Q?TAuwwAdfcNSlarOS6TNFqVV8cyvbonaHwmAw3DcY4NY2h0SPM3TKYIZ2LZsS?=
 =?us-ascii?Q?/Nu2ybKG5kvEfZPLGrufmXWYx8KKvBJwahCGTs6/KGb5Xh68xWZexQHoQ/tt?=
 =?us-ascii?Q?n2OgVmVenphE4Siqa/7vi71YzaPpcv8VQBip66z8/wc4izndB7P8cgbzR+Su?=
 =?us-ascii?Q?4lELCYof2ETxCtigeJifNJEb6HPnLbYNao41WlQ97AxDS+9+V0215VsMLgMF?=
 =?us-ascii?Q?XT0LB6LECbAN9zXv9MdSmZWh+oOnRaFWujQPI952OGtHTcitcVGLYYqWZr5c?=
 =?us-ascii?Q?jAzrCMQny7uNufKgi/dynek1o1I4VDv1HWrPIAWFZ5pAOHuE8p9t1fz58Wrn?=
 =?us-ascii?Q?1LIXe533P0fU+rfhVVZed/FElRfis79KkS3dQGVAZyu2oF1HrXku6DmxYo/f?=
 =?us-ascii?Q?Kb+ytkJT5xb4tS+1neDD3RDekAHWbsXya2QYiYcn/X0tltS116u4Ag9W1Sd6?=
 =?us-ascii?Q?pJ1JeJHhpnc+a/2I4vsn6n4MC/B0jA0jGeayCUSgi1gFpxQLVknVRHPFsRFL?=
 =?us-ascii?Q?9+kXBhXxbGkV66OGFb/Bx9ssR2wxwDHW8DE/cRXuwgw7AtDlJJ4So0Lqmg8n?=
 =?us-ascii?Q?CA5Ssgm/TzcUYUzD7rioZSEuvMuxRnCSr71FrCPFiS0B+cPZyEWeBm2n6NJK?=
 =?us-ascii?Q?1WjGU+9tL4W/gsIyUFwRN1o3rbjW92jH2+dV4xkv3tqvsG2aHRNjl8ydv6x1?=
 =?us-ascii?Q?GvcPBIa5uYvhnY7zSWuIszHwjvYmGCeU2i0EE9tdzsb/ggMOwQf5N2B56efU?=
 =?us-ascii?Q?9kvVQhehgBh750z67aiunS0amHMSSTigI+9+hwYRT4Ywcg25ud40glaxQ6ZU?=
 =?us-ascii?Q?nPf2O7bT/GyMd+MF+UO1nwGniVsakX61Svru+fT/hZ0sLLQTsxy7dM33Iv5s?=
 =?us-ascii?Q?flp8Jgv3vYlTalt3kN4TKF2HqwjVgsQ2puQubg82YZCVybiw81e0eYYANNzE?=
 =?us-ascii?Q?X/HGWEab5SLBzWPHsxa53KVGyOXN9Xlx2SvMwXkssqz0pxn0gWPorIkyDLhq?=
 =?us-ascii?Q?EeHMm5X0ayR+xtpxzh/Dkl624gYSwsJwFKlliuHFlFZHUJ/hD6a4ajr5KulL?=
 =?us-ascii?Q?FpyphaG8iPCykIaqK5VYn6PwzJ2QOP7TFCfvCL2KPyjD9XscaJX6ej+f+BiD?=
 =?us-ascii?Q?H09Xxn4eVgq0whEtWQqfKtvVfaHmXP8VxtsLkHWIK6dho247Wa8cwHqWsALY?=
 =?us-ascii?Q?NBruGYZWf5KPs5l33dpwPmEHZ8SuRnYYxiE4UtYM?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b57402-aec1-4502-23b9-08db7e15b6ac
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 11:39:52.9176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQVIYLlC4GHCyMFqrQriJtjOV21DA4Y+7a0cdqhkjcpcDpEasADQTDY/kOQOaHu7/t7E+ou6L5lB5L5qQI0xeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5889
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/mfd/ti_am335x_tscadc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 07825cfd8aa8..570bc2d33e2b 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -201,8 +201,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	else
 		tscadc->irq = err;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	tscadc->tscadc_base = devm_ioremap_resource(&pdev->dev, res);
+	tscadc->tscadc_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(tscadc->tscadc_base))
 		return PTR_ERR(tscadc->tscadc_base);
 
-- 
2.39.0

