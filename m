Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB96D74A9BF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 06:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjGGEK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 00:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbjGGEKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 00:10:20 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2072a.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADDE26BC
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 21:08:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqjy5b+JKBEJ2uMj0Yv26onCbsj0clz/yektES3ZlR/U5MRrTrnljXfeNccBZJG08JlPhjk/1Gau9yOBjpTGQ7oqBAXOmxJECe9Pb218efhB+EJmTrtuGgclysjn+1oLSI6oraTNbEuT4TASNfMrZ1fCgDkcjPSkj+vyl4a6GGWte+vluBuY1+ZAcn67ZkOaL00tqMUKbNzz52fa2NDJSw+ufZ7ZGj27LM9owZg2BsKmrUC+oPbS6LTrB5ABJIPiWKwy4GP2RdRORd0u0D3WplEY8owXR9f8YCsrf1WUPBzLkZ90SCwn5+LYoSAtH8Bo8oPHiZcZuNY6k7UBXTvP2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oiux6bfSStl3D4931E8/30VqNTqHrgttlUkj9MFjPTE=;
 b=X5s8LXvP1vG1nLY8k292kgiMz8PoeisB0eXw39dQsHimdRkexmm7oFF/nDyhAbQr86m3al6BMTYCUMKmKCckOYsY3bWfDHrwMsGlONn0KZGsmIsqwY2zjBPONAdzwG7rYJPy75P3ixvsE4MCYlErEpfMd4IyFcUi5eAlxbhf3y+emrihIVmBxEduUKo04lC9BiRE4wC/cP2LfCfW/GtjIp9ShwHraWYrX7S4QQzDv+P7tXeEMlKeAJNgFPlxKEwXyL7uHmE4oloo+zOM+dWf9++nkng7FfhQjEJ3UYUxSY+3CWxoZcPuKoALnQUcI1ZSbcc15fyDexNi2oVtPyxCvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oiux6bfSStl3D4931E8/30VqNTqHrgttlUkj9MFjPTE=;
 b=MuSEbVIIngkvCxYUNXZelmcV7y5/hZYXoM8tHg5Ue2kXLD8Fbp5zae6t67NbUW1H5kLi3KP32LGvIRI4DQ20QaVhzGqiPeWCt1Fb2Ix+0F2MSpuNmQqrtnzvoQCZztegcZBfLdbsBNVKH+R+vgvCoCyCaCXPdFBO/GaTZPQO33CV2OQivkJagInzGN1Y2mU/vXHVNLNHVqaQiau5sl9BVsR7dtyQ10w1Q+4ygHvVTF1p8fG3OLKF+tGaXIcE/6zoePiBFLKG2ne5YZqyJnlbinxmRtBIvPtY6xZn4WJzlPQgngF+5rgOIM1z/Aq5LzOX8HvbrVQhgpYJJhC3k9M6pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5470.apcprd06.prod.outlook.com (2603:1096:400:264::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 04:07:05 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 04:07:05 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/18] mtd: spear_smi: Convert to devm_platform_ioremap_resource()
Date:   Fri,  7 Jul 2023 12:06:21 +0800
Message-Id: <20230707040622.78174-17-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230707040622.78174-1-frank.li@vivo.com>
References: <20230707040622.78174-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0112.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::16) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5470:EE_
X-MS-Office365-Filtering-Correlation-Id: 340b5357-43d7-4f68-04e7-08db7e9f9fb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mj9xTZ1L9xsSKdOBO9gf4dx6AnsSSr9W8tZy79MakTJ7gP57iLIg04rMKtoARW3qwThxRvLDP67A5fausi4p87faPGFKw+ZQ5437wmA0zWxTwW/yMzmN7NxfUMzNSFD/kMwkPDQLFHIqyo80dYRITSRCHd86e9Y0+DASET28/jy/cKbIpchrGME8ZL7INqKp0MG2ZvYrtq83/YnBBpLvx2ql/jfWUNPHODkVventbtrJ/KJcJ/gC82M7sdYSQXFhhDLIIwrv3mxPKgCTu4b2fmgZMT0vGyt7sGrDFMu5Ss9KapdHUea+Sczbg2S1vLaJPDG6Yc/E6SskLVLQLbxPACRjj525GCK25gN38bojoasll1LvhyVtbPqKpuheLbVrh+n/ocx24W6gHEpVJvxH2AdOaNIcYxUNHAJj5tcBigIMQo6FNNxwn0SitT78qcLeo2Od3GVTwAgjgO+anRBaUcSZUPYxmfoFjMm5HcNeY2o2aGI6IFt2zly4qsfsUVifNhQN1NncIyC1M3Ot5/eReeSJy7MF/xxQjesf+1N6EgIDidYzs6qL/Dzr5vdKrKW00+JIaIcxwcwCGe/3XCOxwMd5Mwjx404hUaIeetm08PVBw7z5ccT5P9vqJyplgZG3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199021)(478600001)(6486002)(52116002)(6666004)(110136005)(26005)(186003)(6506007)(1076003)(6512007)(2906002)(4744005)(316002)(4326008)(41300700001)(66946007)(66476007)(8936002)(5660300002)(8676002)(66556008)(38350700002)(38100700002)(86362001)(36756003)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8WIUIDg7aJGW4Xc9RCg2TPQoNkWbTrqom/eJGvWFpTzawqCSMcedF5l/lA7u?=
 =?us-ascii?Q?bgNwT3MNov5TvvROvdKXB3Pj8fh++sWXEqG6mdRrgQKDRmpn9moG45tRhiLq?=
 =?us-ascii?Q?5P2LyG9pqdPQHXBKkbXP8iMdo47+MyKx6lmH6FZiRaODl5vwP51Kwjk8PXJi?=
 =?us-ascii?Q?GNqik9cHXnqGyF5h6rsQmFgDeKpv32bWU1OZ6QDIG7Gtc8DSiyyiWEztpAbl?=
 =?us-ascii?Q?B2qaYJlAKNzMWF559/6+yim3/5iwLrep79zQ0gaW9M+2MJpNP77pERF1/96T?=
 =?us-ascii?Q?Eb55ARyi6IIk6GPrViQTLe9wTNaQFBjN7uT6c++0LYCIKRWq3neNfk7gmpFJ?=
 =?us-ascii?Q?MBxw50SGw9u7tK+Y5cFlSwNGcRdbB3DwTgfAEuqwmW+fSqWQrWX/tDlDTmCb?=
 =?us-ascii?Q?SW03lzUm37YXF/9Twq+h5o8pUqMkAztaPDQjWOMixdXJDSAJDhNtyjEOslfQ?=
 =?us-ascii?Q?VGdq2NU8/ofljkLlNQtPL2O7vVuHrTHoFRlAr+TJ1RiVCf+fFSgAAaPhDGKS?=
 =?us-ascii?Q?qPKOzBhC08iYJu0fPou3FRQtMPhoLTv/4rc8uaP2eIYuc6gBdlMKmRL6ACUV?=
 =?us-ascii?Q?hg+hfQKENL/88GvVugDkxEcOXd/w9qNKnisYpUSS7doCi4LXbZLKJZf/bxIQ?=
 =?us-ascii?Q?YKiQjXeDSJVAVBnDSPd/IGBUCzNkjNjsnsJScJkDpEzBsLgULCkEt/1SZuoV?=
 =?us-ascii?Q?pakjUe/ErNZPfuYZl+yRm+dAbGEklcqgA6tCA6QZwBXiqwM2FUV+A5Uax6Oo?=
 =?us-ascii?Q?TOwVxoEyHVcRFlFHq/vJOBuBZYnGr5hVx0UqhDPZdIteP/6/kDBigaA+KTSy?=
 =?us-ascii?Q?d4arZFRkyO7mtL+1n3p/+G9jtL5ceFrBtY6XlL7M2TvXUqx8TCFE8WufTUu6?=
 =?us-ascii?Q?txjJ+ZdWpgrHZtZcKGsyJg0knU1ZcIkOiZO8hXYb9/wvDJMKVZ4c6EZPq2R6?=
 =?us-ascii?Q?qUQv0EVqtaLgrfGUMOvPKpgJBb2igUGT/clm2Vq+3422TVCBoKlV023sKsf5?=
 =?us-ascii?Q?IoI2osskvXpgo+dm66czncwPoDDOABJEOtAdy/i+ySr0uH61DyjRR6F8UJU2?=
 =?us-ascii?Q?A1m9Z6XlnCw2D6dlLM/gqhMQOQWHklY/Ol6GiGnsPYDT5O2qqGwV8ZgEgbM+?=
 =?us-ascii?Q?l8BV0ETbLQsOhOcJUdVlLMOAj4Zr9BzGpd7zAElJc4cSa/OGEAx8ZO4SBMYa?=
 =?us-ascii?Q?QjjdHSQ/iFft4p9XXd5rIBM7ZRtrKhoEuiIIeU6ngwfk7y1321wC+JId1ZBW?=
 =?us-ascii?Q?cXNQ85Bvjp3UkZJYmpJj7Qd8KoGxDROWrw/JW679qasBscFAm1yFM6Yz7Zo6?=
 =?us-ascii?Q?PS4Idw90Wu+eb5N3wI3Y3Jg1lO5QqEzk3c4GysJDCxKft5b9OhJcNjJ3Nj4i?=
 =?us-ascii?Q?9vTY5tVIYAi39xpnqevcjep4KHC/BEqTU4/U6/EZR5jFGQ08+/wwhC54OFE0?=
 =?us-ascii?Q?yb8sayTVrgiDcKGHtE2ynNe4pggDtmXMfptXPQiu11uAeF5EJgD3z6tfMPTs?=
 =?us-ascii?Q?O1j15gpIguNO8oHmFgZzDbqRlw+XunyKSbAf+eVDZtrHn3S8pgBiAkcnQyt8?=
 =?us-ascii?Q?bLsNHjiYfsrXdDCgfkvFbea/yOjZckr/NCaXmU3Y?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 340b5357-43d7-4f68-04e7-08db7e9f9fb6
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 04:07:04.9453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZoSDHhg3U5GuZITXkYdRmbPXk9D8s3zID/eR8xdSo2P1qI0UqhBiOAnBy0Nz2O7+WCt3jtm4+S1J1tv2La6nFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5470
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/mtd/devices/spear_smi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mtd/devices/spear_smi.c b/drivers/mtd/devices/spear_smi.c
index cc17133be297..93bca5225116 100644
--- a/drivers/mtd/devices/spear_smi.c
+++ b/drivers/mtd/devices/spear_smi.c
@@ -937,7 +937,6 @@ static int spear_smi_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct spear_smi_plat_data *pdata = NULL;
 	struct spear_smi *dev;
-	struct resource *smi_base;
 	int irq, ret = 0;
 	int i;
 
@@ -975,9 +974,7 @@ static int spear_smi_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	smi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
-	dev->io_base = devm_ioremap_resource(&pdev->dev, smi_base);
+	dev->io_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(dev->io_base)) {
 		ret = PTR_ERR(dev->io_base);
 		goto err;
-- 
2.39.0

