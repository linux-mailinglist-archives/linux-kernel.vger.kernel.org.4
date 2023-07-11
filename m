Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB6F74E57C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 05:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjGKDtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 23:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjGKDtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 23:49:11 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2106.outbound.protection.outlook.com [40.107.215.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22AAE42
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 20:49:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiJE0ttvCRv6F5D1MB2aFs+6cYAyjmFEzZORLgSg9NZliGtrs5SOaExLsGbjbT4vW3h2rlV++EgJrd9m6/K7cKDWMsIGq5NKGqNsRXpdJ8WbDrajeMcxCVDwwtYzJugfXHv9DWIevkz4RGFVRa2L6lxP3hSLphmg/VBgdLYlc0AblXCHfpQzN1givFVx6csKlQdkKkok4Si9IgQBhZknXmUB6NA86v6PPphMcjPxqpsPkbaUistZ92SyOV6PFtS76AmhZFKTW0dghCNrcSewbvIoT0S6Kjm92PM50qBbgLqmQNBaUS1fB8ZSV/iRrUCwn9XDBDNJ+o4bpa5H9HJCnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wxd2p6NIvmJKsDRggsqubjNkLWiicblbFmqelvcoET4=;
 b=S/GLb38hzyYhd98ox4iyLu1Qj8rafquYyeO9wDcxEW1M6/D2XBh5sf+8X507qbb2QGSt3ekNyz/3brUidT/dz1NSOP5tNIeRMCvK1+/3fQs8mX+wWeqINVo79GTG3pdXYlAr9/O1d0xya1JxOqOTSRjJSnvP1w79XyDhf9KMBLedtV3w8kgPEloVYBB/ZanlDvvTVv72Mzi5aXfge4bMo7e1+yUAIypWrGjYOnoX7SkXyTOb2HT5hzphUcX7yvAdcy9z//wm/md5yAkYIR/ud30b7K31EwOgsxbT91Dq2aQ6ucseSC6wjrH9tUFqoLWjpGyhx2I8/TwXR1xKOpQebg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wxd2p6NIvmJKsDRggsqubjNkLWiicblbFmqelvcoET4=;
 b=iKuXmrgCYR2TkO9LjyUo90cssGTSkkluC+YE5HCQnfMnWrkjwyCujvNTXvvP5JuPA8PBsQXDakuE6TiyL2MtFA3fUTnLDz0z02JaTo0GUPvJdwh8rLBUWsxffsuOzCvHfHPtkSni1ZZYcA9UuoPX8F0K1XOiFYG66wTCWEx+MasLhcMJG6XwDor+Ucx3SpZAtsPV97khLykZXNVQlWX47sTvRA6DztPvRbK/7RwUd2y6GBjUOK/8AzcokF/OzM3rwtMNVZUCa0XZ0tOkLBExsOx/KLaYb1HT7Y7tggrcQrbDZ/m1wI51Z+zgNtIHd4I3JIAm9ch3OwZboh+cMYeAzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6595.apcprd06.prod.outlook.com (2603:1096:400:451::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 03:49:05 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 03:49:05 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] ASoC: pxa: Use devm_platform_get_and_ioremap_resource()
Date:   Tue, 11 Jul 2023 11:48:44 +0800
Message-Id: <20230711034846.69437-4-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230711034846.69437-1-frank.li@vivo.com>
References: <20230711034846.69437-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB6595:EE_
X-MS-Office365-Filtering-Correlation-Id: 5056e61b-e151-46f3-7b58-08db81c1c5d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fv8vsospZL47Lodqery/NvkajvU90x2vwThvbfpYXwDONUDG6dc0AUDHFV9sKV/c2OQ0n6ABZi7ZA747PG0ZJTwBpqoSDE0l1jOqZtI6gUbnlPaW7oBonmEpiUqKxff5X9aEaF+XfwZS3+r+FgsTgY8F7OR1/kPJnErtIuA8kJbp+44ywWvnjMpao5VppkZy1loFcqKVAfhafnkduVBxNfxVbHrniNo4Qzrbhcqf3DJmCfcK1hASCwxYJyE/QGDRl39mYphQakVvaFV5O2ilxoItinKCrJcfmJW63TAaoqZhgWUxHvmmKESuaFiNOCGidgdAIniDdlPdF60VkQ3chEV70YmSNLnwpWwZtY7cvgRyjf+cKbsWCY4U5iH1W3mObKE/YV5xHIpg/CZINNXdCpRV8crSkzLRQl3VLLsGkWDIGx3Be8Q6yNaLoIqPNW2FjzdrBni4LCGzEq+SIw1bMPliB1jgKGN+FynXntWcyM4gKtP2ROdMoikVy8RgKPh6TrKKWQVht3srI1mQAW5O9ojqP7s1LyvNUPkLqwM4e05kxk+RyA+CZryeGU5SvWzQB7/nSTR4CB5kxAtLeCodk9uwjJ9uptX+xyi86MYlM2RAZTKvqkSqBisILxACvKeljUXDrQvprcKYjdjExdDLyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199021)(38350700002)(38100700002)(86362001)(36756003)(6666004)(52116002)(6486002)(110136005)(478600001)(26005)(1076003)(6506007)(186003)(6512007)(2616005)(7416002)(316002)(2906002)(66556008)(5660300002)(66946007)(66476007)(8936002)(8676002)(83380400001)(4326008)(41300700001)(41080700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FRpr22Xc4zRJVCE1uVv/p3a5W9hoWBZIKfJ442cgIZshdRBJJmfnpZPF3Aaw?=
 =?us-ascii?Q?8HPAUEZJ/UllPBJBQp/bkCS7MvV55AbhIN8pzoxoaCGcoOrsZo03q/21CzmK?=
 =?us-ascii?Q?vabqBrgGbSDtnyozEKlvfHeamM/nmNHs6K9XBz3K6VX22Lf6FyiGWokDQHX+?=
 =?us-ascii?Q?LsgZUA8F7IX2n3oXEchL5odwQIlV0S3SF/MmVUJI+UMvIAHnulP8QroAdL8f?=
 =?us-ascii?Q?0vag2HsihAT/uOuv0M4EBN/nu7ZPg84GXJzaXh4W/gbRjiFLoQdoEYpgpRV3?=
 =?us-ascii?Q?MYGmrYdJznlwMSZ24MTS+DGVJ5uIO5pEspQ0MZT+uZ/RwyidJrtoaOJOosCp?=
 =?us-ascii?Q?31iDYwNn8yrK6BdJrhm/EuyQ/hGFuPk4NM6dLxrxa/092o2GZ1BC4/7Jc9U/?=
 =?us-ascii?Q?e4nPdTzuTgktDVuTyFT6RynOh5G+/I0wHXEigygrp/HdPt1GAnCfH1BN+Gtf?=
 =?us-ascii?Q?IhGCrKEm1zJx6EVtzO3I/0tI6Aicj8PQ8hXN13Y9jb5/HyQlbZUT34eZqV1J?=
 =?us-ascii?Q?hp/hrKZjrbv6/jZK9ZpRCn3kzt6dEJjXvhFY5oNx72bxFiT4R212mK3Zf87/?=
 =?us-ascii?Q?l5dq/PJnbzDn0rTuBKdGnRpTUTzqrmpiqN04KrtThlFDkDZQ4l/znZCOFHN8?=
 =?us-ascii?Q?K0UO60PS1gNGK05eX3TqMwVTk5OCkhN5EQRlowiSqV9JY2aMSKDToYe9qCbO?=
 =?us-ascii?Q?rfd8UhkxfD8pj+cauDms72WsfCGeNc+aE9oBTJQTzWe4cbUMxwYO6KoLqKRQ?=
 =?us-ascii?Q?0Apy2Mq/D0LDj7buGsVYtsH2CAg/EP8hCuw1SgvPlZKTufFhiaEwyZFFBFsS?=
 =?us-ascii?Q?Nm3oqGZMwdNeXplTo0iBHGawhvOQ6+PYOQ9F/zT1rpBU3W1ue46j3XQreLE+?=
 =?us-ascii?Q?ZhqeDUqr5n5ljOjqtpi6d1p1Z2c1mXiSy0oBQZ+DYs1bfN7Iv8au3V4PopSZ?=
 =?us-ascii?Q?kf7H/Ga+w3r7qS1EzD2KYOftcDurEeY6bjwc7dUEsYsEUqI6rC6g2FAW6+eT?=
 =?us-ascii?Q?SBfn5NpM7uDn1Jaqa+BrbphdkGOrvyDifaMXLB4lexriOvdvaUjamt3w6Uez?=
 =?us-ascii?Q?lAeUUIfI/iB3WULVpVQ+hXWEB/PlFL8vlCxN/PuK4+2mc3kSQzVZA9w06yC7?=
 =?us-ascii?Q?thA0YUv7a9IiXO6X3p4IoJI2pfs9FTqLhksW7/z8yxAniRGRNc+94XYiEiQd?=
 =?us-ascii?Q?0fkHOBB4k7XRBr69mlprpgL0SvQLr81Rn5ERR2bWyt95BewGYWuFmtxNKovM?=
 =?us-ascii?Q?duE9ZjQn+xC3BtmhF/bRLR7N2IoFi9A23CKhXuzEc4Gg7nNk7Yh0yaysWPbn?=
 =?us-ascii?Q?wXYUMUxQR1nEx6YQJpceLit1hnV7Yd0mzm71ixeRtUbDg9v4Aq/IDQcf6DI4?=
 =?us-ascii?Q?8kPhFLu+EFV7YZL61h21ZfsI8EovnE0kFYGm4r+WQyXfdSA5nsQApNAV2nsD?=
 =?us-ascii?Q?7K6OJks/heyfwB/IHYieKImyX4j7OqlcoeZrJMN4dxauLgQ883toH0MnYJbO?=
 =?us-ascii?Q?TJ5WvWT5H/+AO9kzUROzmrAkjmpxpPNuSMC8bl61VVda6u31Q6IqwNDgYW82?=
 =?us-ascii?Q?5h5nYEeAB3d+KRw3mU9mB78zo8szjgvTDwlk0Sp8?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5056e61b-e151-46f3-7b58-08db81c1c5d6
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 03:49:05.3595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c+Wt8n14JhDsCbX4m7VVIawaM2IZSJzdelDZRQtqLdIWVpD4blH5iYQf2jdzLx8M6FQnbxKjTUwsJDNomi5sFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6595
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
 sound/soc/pxa/pxa2xx-i2s.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index 3e4c70403672..10636506b622 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -370,18 +370,11 @@ static const struct snd_soc_component_driver pxa_i2s_component = {
 
 static int pxa2xx_i2s_drv_probe(struct platform_device *pdev)
 {
-	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	struct resource *res;
 
-	if (!res) {
-		dev_err(&pdev->dev, "missing MMIO resource\n");
-		return -ENXIO;
-	}
-
-	i2s_reg_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(i2s_reg_base)) {
-		dev_err(&pdev->dev, "ioremap failed\n");
+	i2s_reg_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(i2s_reg_base))
 		return PTR_ERR(i2s_reg_base);
-	}
 
 	pxa2xx_i2s_pcm_stereo_out.addr = res->start + SADR;
 	pxa2xx_i2s_pcm_stereo_in.addr = res->start + SADR;
-- 
2.39.0

