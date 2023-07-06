Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CB2749640
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 09:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbjGFHVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 03:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbjGFHVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 03:21:03 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20701.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::701])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC9ADA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 00:21:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5paLk+7V816k8XxgfmddTtaTnBMUD5vDwmmLUg765bvGUD0muj7SRjiyND96rbQjmO1dgL1bhb+mWClahuRyamJ1qpBV4n30n/s/TWEucl2Mc2TnTDjF5cE5hqdwzR7WPf9twnNB2U610R8kNO0VQTRZz9LkAVYC+kOWs9M5BENGbTGwyhCsYNGynQ9YIk8Fa3q7EY0X90q7/EO3W1yQk4sVzvvlrqIvN5CSXvkLBCE1R385sDAxQrJoQW1ldVVRK1KMrG8ciZaZL6sBQ5mecn7UsBG+Sxs9ujMB+LTAYJrNi9vXmfaMPGFG+aDUIHMu/wpE9nvfDbNfN1sfSEKWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJBOK8xyw9ftYhILMulajm3dM/lm2fvC2zjlfOnZHMc=;
 b=CbovC/vqlorhjhWQ2Eg0c+rkBLzw6S17KY5QCrzjU35iTyFwj9JkuqTgqWjB1/X2Z5LBRscqo2aXfDPT6iR6xm29z3/Mj7R6UPVemqu/kQh/u60S6G60tCRKdInVzpUVlO6gtGv/EGmcNNZGE1BS/IjL7ZMmgFxMnlGNawvsOsz9DFomHNL0gAM56CL7fszVqQ/opuSFs0b96MF65/GrPvCSMmJnxunkjc5HYSYFfcWBi8EOOId5/P8KtihCMwfbHgGwt6BB9bF59BSLHTZGIAtdCei+9CSZ6mP+wnumjNgPcHOfr143K2fzD5dYpGj8KZED3F3qsBQhoGvPkjEpsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJBOK8xyw9ftYhILMulajm3dM/lm2fvC2zjlfOnZHMc=;
 b=Ij/Fm0z0nRS6REwqVX7GtzRg+LjcMkHXHCxy08MdbNv6aRoUjgAV4RleZ8CwuZSS8XF2Lw9HJU50PgxXj/rvcWhbbPTcFQ/6gVm1B/AHrD0u2zKQ66u9QJvKjmYjJgbSgfry7DzYbAfufsuMuF1uaBpjIHGQGe0DnCmX8xEteY8WdjbWU2gBDztQRqsdxpW+yPWw5am14oCeEWaaRlbrlNiB/jL867sEQdevlcJtc0+JmD5W4nXV4uYwrhx/0LfyNjJR5zztCY3j7ks+Y2qopGehadyUtN2vTb3OzfHj91jSmzHXTOV+KfjIAd6qHL08jSZbDc8Co9ZcSooBR9++3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6081.apcprd06.prod.outlook.com (2603:1096:101:d6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 07:20:55 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 07:20:55 +0000
From:   Yangtao Li <frank.li@vivo.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] bus: da850-mstpri: Use devm_platform_get_and_ioremap_resource()
Date:   Thu,  6 Jul 2023 15:20:37 +0800
Message-Id: <20230706072042.31296-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706072042.31296-1-frank.li@vivo.com>
References: <20230706072042.31296-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:4:188::19) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 029b3d14-de89-4e7c-fada-08db7df189cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rtYAKxhPSioLExckjKLc7NylOmVc1C+UGpmLGvQwB6GQhZRHQTAH+XKTwOBG/JVDHwdovjPxcayEmYhtLSIKPNGugoptZxrHviIledePvoacs8Ol+Lq52G1CNpW9UcV3Y67wlOpu25dxM4ZdHTOAEpGNP8olVPP0+aaAFWYPYh0LwpVsrTLCtij6LeTaYqcOQaLjOxBZsUbet0anZYyGFcd9Gk4m1YJR2vQeMyoLxyAtNbYXWXsN/pbv1gVmGBfPSuW9IrJsuIf1ALOjawh1sgebvtB6hy4fxb43UMbLTBJySOPYkrzSB4vgiV6B6THTh7dJfpAgCfofV4l7g7itNMyJbpQRQH3HppfwFF3ZI+zy01rdb9pglTYyo+zc3ByIbNeyhy+FjBEBmFdhiFkIEc9rVBaKkprs+AvinHeVqrHLyc0/tCXFBxg++YZ0mpr4y8IvuMlOwt5dO+8pRBpNQd7JSnnd4ZXM8E1bK/Dd+qXsYFaYddbwNOBHQli5hqdJC5rfDmemQOOLzA91YxF28BvwQQOTzrmsr5WyCt0HZ6iAdnXvgV3Qv0GnzLrNvJxfw4ZD1+mEuj7U3OZGAVORIeagb7AROf01oiNpH1lutOy4++sIjRM/OUQRFfzHak9J30vVyijlNicV7fbuO3+NLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(109986019)(451199021)(38100700002)(478600001)(66476007)(66946007)(52116002)(6486002)(2616005)(6666004)(66556008)(41300700001)(8676002)(8936002)(38350700002)(316002)(4326008)(186003)(83380400001)(6512007)(6506007)(1076003)(26005)(4744005)(86362001)(5660300002)(2906002)(36756003)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YajbHK16UyHPRjy65LJ/zej83N2vdHl3wOZXtNuyZ485Bq1+obLSBWMdlxcq?=
 =?us-ascii?Q?4aXRkIFNPp3pmuN6Q/RVTOpoOXvScBuTGnGILWRLXU0EX42DGb24IMzAtS2b?=
 =?us-ascii?Q?9SNaq2/pZs2Kz7Be3Zv68nRbonJqLNTSPXaW97MAoKoXKaYasrT/Yzyz1P6u?=
 =?us-ascii?Q?CZwTzZsNZ2UN3v+fVE/dC8zgEQFm/BenuxCRWjoMPMBBTHmEAAxLztud7XBz?=
 =?us-ascii?Q?H7ArbZwTFbYiVzr3acullaPRYBqIUIQ6FobVwyj+nS9Eel/4YZe+v643Qm1K?=
 =?us-ascii?Q?cEJoeRSLqGGhBHAr0yDivVgz/UBihbfDj03tkW0YWLwMYBB18PIyOjkvn7mg?=
 =?us-ascii?Q?iw15mPt0wHQxzwfB6FA1/c2ptaeWALBn5Pft78TZi439mDtxH1Asrp6Fj0DG?=
 =?us-ascii?Q?TJ+kd5y4Ah/uUdo6TU8K6i/I9VQ0dBCx2Zu5jSVAL6HbsdMsp6hBYsO9RyJW?=
 =?us-ascii?Q?Zgq6X9QlXR4Bc7UlRGf5WuMdWh4nbF4qts2zqwBtrkaZkaLAAMG2lxHkT0/f?=
 =?us-ascii?Q?JbvLPwRUcb/PLkkCuRlkYwwZDYWr8h4HikfRLo0xrP6Ic3e+sggwka1A1uBq?=
 =?us-ascii?Q?iG+xe/LqkqVcGWvBLdR/c3hnRTbQhRcsXXll73tH/P3rJtgGvTeLDpOr7zLf?=
 =?us-ascii?Q?/zAFd76AGoHbfaervNl2Z2x+kjWWmv/l31ZewU7rD560ZXN9wdxAflsiaQF1?=
 =?us-ascii?Q?L9ihAGgnHSmTG8mP47FbUbeHhvFTBkJfj/L7EOZ7UERCox6un9k25fC41zQY?=
 =?us-ascii?Q?DwCxiWma+yG+S/LPpEd6lDssgl9anikMa51VQMWhw4ownGnq2q4Y+wt1wZO9?=
 =?us-ascii?Q?w5ehMoMJRvyCi3r3Kdo4s+Kqwp3BVy28GqFpOR7PXihw9nA5MA2KqQlbRWR7?=
 =?us-ascii?Q?hKE8gJ6Vs8sMuOTdjWvOm+WjVRp56ajh0UlR76nu/N5FJI91DPJXV7Jb3dr8?=
 =?us-ascii?Q?vF3Z0Z3Z7DXLa9fLtKTN/+y+VK3IJGXfM2RkFssL+zF188c7gfxw2S/HWMHQ?=
 =?us-ascii?Q?FNlykJrbmWFmloti3MBec7YQ8BxMhkDXBpCLbzrOXxVIEv+wQCYDEyqheZh+?=
 =?us-ascii?Q?rKdny6pBCALyeucxpvhv47F8o5HjRxh84LXCv04ij6hEOKNj5fqRDPorEt2H?=
 =?us-ascii?Q?A6M0pboOEeKjQJoatCTDkKZy1ZyU533Ir7K36Du1d2yTB/ZmexEwabpLrXlk?=
 =?us-ascii?Q?l21mMOcm2YBaKk2D9j78wCrWzQoySJBhHz+4W7TdRcJHfgRoXDSdULRVVWJs?=
 =?us-ascii?Q?qkTQFgKu6vMkQ/tDC/iDZ/fmT0Qr+L7xdumTZIKlq0nVFfv5/ngChfj5Tcdf?=
 =?us-ascii?Q?7EiYSuvTtWUw4CVq1TtT/ol033RWxeKKLv3EskrDe5lbpJ0HCbX1pDboqNx7?=
 =?us-ascii?Q?1J31pUDib3/T44/T5oUgojuVa1WdQ1h2+4yuCgfGUQIM7v9TOufpFrJM36An?=
 =?us-ascii?Q?5xv5Oq45J7dck1ZaFgvyP3h/UgntcxNBRp7hi6NBy/JO3UKMq5RwHAjx7WgA?=
 =?us-ascii?Q?NrK13wGanvBCNr4CW99S8pCtdlTiJplZ19Iypt2L41B9vOt246vRjZ0BFZUh?=
 =?us-ascii?Q?l26z3+4CIAfS/hNRM05utqRhvx6djbMSu48Pap97?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 029b3d14-de89-4e7c-fada-08db7df189cc
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 07:20:55.7961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: azSGpnVYKuXzf/+BApkmJ0Bv17uABZBiAM08hgO9u6HcWQIEmDAbuP9+yLQZUqJDTnwN5/P7V1wHdO8vN6NQ2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/bus/da8xx-mstpri.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bus/da8xx-mstpri.c b/drivers/bus/da8xx-mstpri.c
index ee4c02335130..864b61adf005 100644
--- a/drivers/bus/da8xx-mstpri.c
+++ b/drivers/bus/da8xx-mstpri.c
@@ -213,8 +213,7 @@ static int da8xx_mstpri_probe(struct platform_device *pdev)
 	u32 reg;
 	int i;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mstpri = devm_ioremap_resource(dev, res);
+	mstpri = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(mstpri)) {
 		dev_err(dev, "unable to map MSTPRI registers\n");
 		return PTR_ERR(mstpri);
-- 
2.39.0

