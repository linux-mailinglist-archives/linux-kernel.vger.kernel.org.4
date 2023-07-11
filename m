Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3EE74E57D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 05:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjGKDt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 23:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjGKDtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 23:49:16 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2135.outbound.protection.outlook.com [40.107.215.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5676137;
        Mon, 10 Jul 2023 20:49:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GfhAc3AJ/uEIXuvyo++ytr/JtGLi1x5l/SITvqCycyNqXW0HmKCqxdGlgK3A//TFFyel+rSmCZpCNJhE/TjSyjHGbY96R+hAQH+/zMTAYaSf4cOpVbjenEOgI19YcxRsFn1nRGIBWxZyNYOqa1mRmLvPQcDaRHwETSKGxUjszp4XTIH1VV9CykztQql0BXbEDyBl7GzOffPnX3zMJlCv3eyn0aP6KLYYMNQUPpXQMIrgNTPB+L8GnK6Zek6dVmbKfZozXbIdw6jfeufjkn9RZXhE5jpujhUm/rf+d/3plbhdPsbAfypRaN/Yj44fuMjaW7Z1TMHmaXdsFqnOuTniLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILYywV7zcU/CuVcS9ZA6kjFhT2ZAFL1XcRgzE8tfcbo=;
 b=lGvmQULsHNTLybPjllprnl+ldI5Rz6or7CTantay/eYVxp5/745F5L9dkDlGSWPvZoJpHrdb61kOGzEFt0gDXAlPYJpcLxz4oa1FJkKMs96+rpBx+3NvgKByqHpbclIkRZURIeIpeEOUl9Lo99aLLfyKFYX2+CYTuocuQE5icRgFR2TSQUsghxUx0yHD8fwWJyEqoHkB67EFCBoYl4GbcAgwKiNQq4I01XtFPSybW8T5FVbiVcjLKTYJFJ7Wbwc1Oa/JVwmxU1cpZP3BaN7K5xFPBPz5EWG7lcOmDyqLZS5+367O12xSD7MxFOK5owXNwLxFuMS/7bEapdnBgvpFpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILYywV7zcU/CuVcS9ZA6kjFhT2ZAFL1XcRgzE8tfcbo=;
 b=Ft24zTR4kN4LGHurBdrXPqfv38K2wbAOGI2kgIRt8LAZ6ANJaefgPAXE+1klTJ+nMKjXc7oMSuADp1NZ/xu0JBFDu0Qupod88OwSz/JJPBhQRPFQmJM8dm0mkDrA+Vsg8khptvmPVtInI1ktQIVB3MyB1uHMjIWPPdWHoozfePj9LlbA0Hx8kOawB7H0xuee7ZXYa9v5984vI3Q79y4bGlG+kPmZg/a5LOBjUgx5MKTg1jupR4VB3iXigxIdT2DJVQ6g1XNPLUO8ocBQ6h+AE/3oygOPlihw5LCB1g7KhqFU1U4zftcfbJs0lSxJVs5dxkRQCREMYAsCKwfiQjoIww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5143.apcprd06.prod.outlook.com (2603:1096:101:4c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 03:49:07 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 03:49:07 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Yangtao Li <frank.li@vivo.com>, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] ASoC: tegra: tegra20_ac97: Use devm_platform_get_and_ioremap_resource()
Date:   Tue, 11 Jul 2023 11:48:45 +0800
Message-Id: <20230711034846.69437-5-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB5143:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a0b08ff-2489-481f-b7cb-08db81c1c74c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jqDtKtze0fIOziHRLZ5zIu2f6fStV5YAv84OQQX129aHZ56uo/IWBjAS8tEzo1k8DUWdFhxMyREwVA6HvSEPzZWVMkd53WLASgBMXjPP68v+n6UW1n89CUdX4vMl/99PdmNchiwzH0KERhwXHbk3Tqnir76XDdVnfOOWvK5HHMtqkSExUQcJ0vKevvINTF/fbgJObhf5LUbCTfu6ahJNKr9FTQPI4wKHLa1dMogeHdoV/ZTYwrtHS4JMpK9w1b4UbjzkRqA/MlDI04GRmtAujEMuRI/AXxPWhByIP2S8tnrM8YEDFwitvj8KQZrbwCVBjM8nQUw+9mmTNDYfC/8HvQQzJyI2XtJN0Mw4zoAgNyJnjSVhlGcKo7vUQTs3CU9pCKR+buc9S7pIKxlC3NwIjsRT1FGWX4NOv8Zvnjdy57bxw24tUU0uMMj3qUgQBO/v1WiU1V81aHbbRSB8o/1DviiB19d2EiXRwlO1FFeIxJG1y1J6raZNjclQKnzNU50TFwbf86rdPVzBCQl4BGgY9dYaOQU6pLGXyy2qW/k8pDgJpFYSvhrBjWOGbAbB/joQhkQOoNMcXRrwRZF3k/vWFOnNd39pO7IgH3FuyaFE436kuuFyB8JjbP69gvCSyv2t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199021)(110136005)(83380400001)(1076003)(6506007)(186003)(52116002)(36756003)(6512007)(6666004)(26005)(6486002)(478600001)(2616005)(2906002)(316002)(4744005)(41300700001)(5660300002)(38350700002)(38100700002)(8676002)(8936002)(86362001)(4326008)(66476007)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CPMYy5vU0w6vxMnhIXZph3eqttKAjpgq8YUtRoOsu+vXCp+magBziHG3oLJ9?=
 =?us-ascii?Q?On6kIU7ItumdfQ+qERvEIt+5lSiD7//U+BKZT8VEC2ICgG7NtMgreAILjX6M?=
 =?us-ascii?Q?uRqWjuG7+FMbcx2XSLiZ38J2lcp34+AmiPlTDWhLGOFLGOpz23/WunosiAB1?=
 =?us-ascii?Q?XqRP8aKMfUEHpmiaEzuPC6MDwYlcaZIPtCRiLNscl+q/+8qQSiP4JUG/Bvem?=
 =?us-ascii?Q?BdBN/z9LN3zKCJmSxHITRSO4TIoabIGxqfr2WzZxOdd3ujD2yZMoEqWingvT?=
 =?us-ascii?Q?/TDzPqkxTwKgEOWqhiZh7Sg8P+M0I1L0P/9mDx5++iAu2QMlDk3pMPuoBLoR?=
 =?us-ascii?Q?f2gEENFxb2IAiIKokny7Kknh/+CfQLMTaFWJNkA2Sxs8OwsZphqx+rwdPE+9?=
 =?us-ascii?Q?+2Koz16xBAfDJtuSbN+iJg8rEU34EjVgfbmDSv52FjixMngqmYwvDcGc7rKD?=
 =?us-ascii?Q?aMGbjtTm5pxiNMqDx7nlAqtvQG1kFHUNwwgLQ63l/85e7w9K6tqBH2v+5QJG?=
 =?us-ascii?Q?Y1kL7bF7H/40SyUmE4ieCvyuj/qvzpvIWQ9FFHBa5RsTpsfxGXdQdnDuDfgw?=
 =?us-ascii?Q?jd/UGmaHedU84W7eOM8r4dQwaiBI8u6lO8bVNqcMKpM8oiRQ9vNyuxhbGisb?=
 =?us-ascii?Q?kblkWh3hWr0eMAlRYaASw5tzzSQ8ZXH/GcKhUyLaOH3BMp9Ex5+hATt5sv+N?=
 =?us-ascii?Q?PCoXR8gP/3dSJJZzR6mtUt7OlFN8JHyFej94IoNLzsMLnFNRTF6+52UJjB4U?=
 =?us-ascii?Q?0KW6IFNZ7dpARf7ADytMT6+DDNy99x5UpX7wOnrb510T5G1bSW9TZVZt3+y3?=
 =?us-ascii?Q?ychLyH/NAUglFW2lqhoITqpgJhoZah9/96CoUzaOYeBpKMOf7RrIEys9dSEv?=
 =?us-ascii?Q?lXJ7fUnmE9fQ7/TAGap4oJ0UMkkdufJH/16eGMRGiQCWgxxwZ2oMxTqg/ojN?=
 =?us-ascii?Q?zbiipt7jFNExfSsvf9g6VemKYfgg6XY5jpb2iLz8+ghlxk+6jRRYR/gShTYI?=
 =?us-ascii?Q?g4UjRYUR00dhootMOZ4KhDmGGXBrr/RFH6nCQEvBXL1Tj2MWFzkCd1G+deEm?=
 =?us-ascii?Q?8rXwEx+ts5AUc1hM60nIMDWSTO1sXDvEOWzT6IrtGsOdHD8p9ntRerf33u3b?=
 =?us-ascii?Q?pIb8tkw+aCC9YfPKuVKK1H1wgLqqyS9jOrN7Jgx32wRoV7EhDIm3KV+bDEQ1?=
 =?us-ascii?Q?SwZUKMgKB0Rg3AINF8pr+uooaMDzq5xqfalq9rFSPzcNUWCLIOaRfWo8gZtM?=
 =?us-ascii?Q?ri3e5lfhxniRt09XL89agBMs72LDMT8HWRr20FQr9xEHzQ4P7lQ7EPiZKSmS?=
 =?us-ascii?Q?jfMXsf+mc31zrzhcOWsXNpxK6/H5ECgSGUNvjgicHirm+n3F8Zns+6cJrdQj?=
 =?us-ascii?Q?+xZ8cY62eRLnOisp493IwpNNwq9YVQpj0yZ0OYJFWV3uW9Eghq7o34LeIqXC?=
 =?us-ascii?Q?iKRAiVtF5sL+2vRgw77MFK7I/l36VFgpG2eXZShVfmsdN4d9fjnUtFzL1sIa?=
 =?us-ascii?Q?7LdR1AF1yS/bg+HQTF4gTN9FRMHu7pduLfXdZf9PpB4yvI2/0KUDt3fR5/dE?=
 =?us-ascii?Q?qVJbfoPS51Qd/czvspwkmCW8fKpO7/U00HL25PGv?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0b08ff-2489-481f-b7cb-08db81c1c74c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 03:49:07.7425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pu6Jccod+97WtZv18jji3rhRzVSX2Ta4B9K4AgES8uWNt+8pnRCZ/pLfTSFoAECjipnjwfvppyI/eqiseYOppg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5143
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
 sound/soc/tegra/tegra20_ac97.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/tegra/tegra20_ac97.c b/sound/soc/tegra/tegra20_ac97.c
index a4073a746ae3..60e7df41c64c 100644
--- a/sound/soc/tegra/tegra20_ac97.c
+++ b/sound/soc/tegra/tegra20_ac97.c
@@ -328,8 +328,7 @@ static int tegra20_ac97_platform_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	regs = devm_ioremap_resource(&pdev->dev, mem);
+	regs = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
 	if (IS_ERR(regs)) {
 		ret = PTR_ERR(regs);
 		goto err_clk_put;
-- 
2.39.0

