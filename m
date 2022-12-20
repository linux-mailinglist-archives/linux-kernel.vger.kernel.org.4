Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0E4651CC5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 10:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbiLTJC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 04:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbiLTJCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 04:02:23 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2050.outbound.protection.outlook.com [40.107.247.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805141705F;
        Tue, 20 Dec 2022 01:02:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCygyiyXbiCOyWR9POS3cMdg9APnkMr8AZvlhut2ouHh1hB4M6OebmxLrTP30bPvHGgdiEHpPM/axR/VlDwr1XHlisT+jefDXQAChzZ7uKQuasAqEQY9+tFKB4Wo5/TakXtiUW4/zPTiNEqKDGayRFbs1ZNn8Zq62INz2MkHeXJRzrgCPP6oXHx2KASQ7gzzmvomQirk76qrt8jX/NNC6tZ/e+4HC63Y8is3m9GNmsMy+RCbWNJKXfMdi43exZ5qvCV5p16GpwGp8p7TqNEUmUpmgMqYrQUpKOPieJH/9e7YRcMy2a9mUyS2bJKkDgtVi3uVzskxv0rSFk+dJUVUnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqcvnb0BZvZ2HwzyQoLGjNQjfnL6akT6JQSNWdf5ZWY=;
 b=JLiJZjYPupku1HLnCZEsAMBDl+6CL2W0CbvXn94BqAqNlVwdmsgh2plym3btEg412ewO18cEk449j7juOC01iPYrnzC5raYHQFJbWpt6nqzyDWcE4Odp3tEr+MWo1Z+1S1yIDefLPzkpxnOKZBYDgGmg0+bfYa6DL8vuf0UHCTjP4TVjWEezxDroWuI1gG8t6hhxoVJ7ARivcYUjaepRT8z5Zjsunr/wPBG0zLEqi2tRmFg9IM+DpJidm4Lhwm8NwkXNKp7DWjftJXAP1gUGj8edyaN0eud+5mSajwgEJn9KJF3w8stMqhBzSCH+Sai1Py6CXw5oAJTD5F3RwgyekQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqcvnb0BZvZ2HwzyQoLGjNQjfnL6akT6JQSNWdf5ZWY=;
 b=gJg4ea7o0etHO3BzCF3tXN065ZQMHrJoUlVOMYL5mSqARFVJEMr8a5Xty0krpgVHYObcEMm9p+RYCkkSAYdR94NqnZUy95cjhQ20z+rZx5VCDKZqFQhmYeFH0KA1LJe4dPRvSLwPNV+xLFYt8tDtRWBeE294fMC69Ju/ASSN0DI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 PA4PR04MB9221.eurprd04.prod.outlook.com (2603:10a6:102:2a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 09:02:20 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b%6]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 09:02:20 +0000
From:   haibo.chen@nxp.com
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     stefan@agner.ch, linux-gpio@vger.kernel.org, linux-imx@nxp.com,
        haibo.chen@nxp.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] gpio: vf610: Support building gpio-vf610 driver as module
Date:   Tue, 20 Dec 2022 17:02:48 +0800
Message-Id: <20221220090248.1134214-2-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221220090248.1134214-1-haibo.chen@nxp.com>
References: <20221220090248.1134214-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0026.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::16) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|PA4PR04MB9221:EE_
X-MS-Office365-Filtering-Correlation-Id: c0061266-6709-41ea-4fa8-08dae268e6d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rvbbv7hnwclpHqGQkQNnGv29HholMVKGViftu0bj8EG7R9hG8moI5RoSXLO03dFFvTrqYVRm7c9V1CBgGTw3FtqV5qG1896WIdXsKqapVzDX+Lo3J2ASQyH86nejtO5zE4/wGZu/O9U4TcYChRdUZ3P8ayJs6ThEMr7V7VA1DSCBbyWdaqRO4PciJuE8UV8nZkiKos63y8GgO9XeLfqNPIaSy+DlE5rJB0QVLchEpqVLLDBiutUGVlU+5UIV0OSS0QDA1PFz9RRU4OSjw4c1a3zDbqY/rj5kY7QuncPunnDxxe0AK+lRGFPBGmbxC54sWYGQxWJECSTas+HmUX/6cYQxG5V/wTEn2cgw3xzRJswK8oZC9vwmZL9AEkxfFm79kpiVbxSNjXqjHWOZ4XUiqaL+m+Hi0YefHEt8zxt243XUJG8AW+9OnyA02Djq9xdThtasSXrayO7qd8AFSrRo20ROqIKItPvlz8om8xL/1S9ESrm0AmNhEkPz7itnnUVliEV51aiGlz/uzazvMadkFm82+vQh3cKPjT/96ZzPr/8KoJO7q1JzmQ8glOw11UVcbYPdlnXyNznPfoHNJNfE2j9O02AS9SDeOEcRzto59fTEqdoDpnIiMyDCa3R/H2bi2IcmNu3MaRk/qEcCkMhDicqBpja8h/UnZSu5AQVq497di0bELnrcqgs2lT5WDMrM7NVMn3LdBMUtaRLooJuR8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199015)(38350700002)(38100700002)(36756003)(86362001)(9686003)(316002)(6512007)(478600001)(6486002)(6666004)(6506007)(26005)(186003)(2906002)(41300700001)(83380400001)(5660300002)(8676002)(8936002)(52116002)(2616005)(4326008)(1076003)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MuAyf61V6Af9RcmLKO1BLofsYidVy0SuJjGEtlxcWbW92FlZRgUFXVvPUUJc?=
 =?us-ascii?Q?lDCBSFOdDPcoMTxxSActV5kkuKUGWRtpl/f0dsqlLIJNCXFiiUaC1+2HefWW?=
 =?us-ascii?Q?OB+OoiW34KG3qJ7ARJtbJCXR+FKcysnNzxznL1WHLHtbU4ycNWAHQYzn6Kjc?=
 =?us-ascii?Q?fbrcqHNa+mYoGQg7Nce+ckfA+q7lGG6f0wTCLXBintn7+XaYEtvQfD88KUxR?=
 =?us-ascii?Q?I75dYylkv/z8QA2PxL9w7R510/XZ0DKiVi/Zg6sff5gcQ4UKzZ11CeTAoOel?=
 =?us-ascii?Q?MXyHeP0EwBsmYxaW5D6rfUEL9VXZYXpUhxABZwobDrm2cb12VRuOTeqo4geh?=
 =?us-ascii?Q?cfY4Kmcll6+hGyagJ1JwitdK3JKTJHU+jCh62KuAf+CWc0TrqPsp4WCPqjpH?=
 =?us-ascii?Q?J/epnev0EPSNP8CXSrMp44eTTo5tcgw3/G1KasbSu7U/fPvJckGhET6Zs3eJ?=
 =?us-ascii?Q?wMReAnEEX9dLsnsx+yrAt/gM0hCG/4fMTHmeJ3s5mwNc2cQy8dumZV73DLZ4?=
 =?us-ascii?Q?F6uwEbeHFLDyHYdEEt2pboSonJJmTAqLnBRZV+mY2O8j8kL9rj4OKghduYSI?=
 =?us-ascii?Q?BdWZa/WzlRDrMqOB5X/zwPqZjsQUIc2fIdxUEnNP+xNGjfuPtnhpu/ZiO7Ok?=
 =?us-ascii?Q?Hu/OxAvHtiBxAaULlwjwCoXanbeHHn7gzET/f11wfcflzmkYGUnJh2/GLxFT?=
 =?us-ascii?Q?R/pp71IkKIL0G5fTJGa8i44TcnTxIEOnsGpGgqPhhEqZB6e/H3gSd51ENjel?=
 =?us-ascii?Q?tOR12nvKoii5BaLw8Q0LLaaq63Bf/0/qN70wTSRpTAPMQW8B5G7IUvYfdvpH?=
 =?us-ascii?Q?CKH0wFZAvoP1x2a21MKyTvC9hOk9l2SOo3hSvY12ZQaWfx6vAcwPhQyngwCd?=
 =?us-ascii?Q?KrMAeDPeH1NZ6bwNeT0BlM6o50StN6ZfPrMD/CNCpGg1Q6oXIsDDcu8T07RU?=
 =?us-ascii?Q?n2ozprjlWV/+aDWcQujmFCgqYn4421d11tLKJQ72H0xLEB3imMzhwuNjhTIr?=
 =?us-ascii?Q?fzUJEcRGUZGj+mWlrXvirWZfMS6I8kwb0fqhmVBQV9dP/Ooiuu5h0e9JuocO?=
 =?us-ascii?Q?wxHiBCsnXS60HilcYpxFecsedrESPXCNd2Y15+HvwYNE9WiqBO5FR2FwwfQm?=
 =?us-ascii?Q?gKKysXMlnG+9RMQo5/NdtHlAnjyxK0pChc0uC8+62KcSh1FoxuYIvf/tmeDX?=
 =?us-ascii?Q?XH2t0k1IngpxRro10nFs0Vwy5tUzqlumPVbBug/hoOVxA2NprWHJYaAp+j+y?=
 =?us-ascii?Q?fM4zvjM8Kjsn7IZV8CEQiLlpXAZBZjFHhcGqKpCVPnKXbXNA6p//XG/hr4Cf?=
 =?us-ascii?Q?vMN866LQk1irERRKG1Zv+MaTEeQVBKnMlrfgNyFQsTXQYp+XeeMVJxjW5Sim?=
 =?us-ascii?Q?ak7qlG2IxHtSDQAAJNAIbDdawMn4twunC5ZGqZFPobQ21bM312DSaT+GAstK?=
 =?us-ascii?Q?DaIYH/P2Sg5fqkJfUezc5HYTX2A0LraJ1aUgRVnG49bQtV+d6Ck3FUDsBMZB?=
 =?us-ascii?Q?OUNkDYwgMWUlZ71PPNOQDeD+N9V15zL+5vzfWDP4VcN9tkSSMUuZ9ODIkwDW?=
 =?us-ascii?Q?1k35Ti7pJXVQ4rIjPuG4j+J7PodvLvHedSSa9dwH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0061266-6709-41ea-4fa8-08dae268e6d4
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 09:02:20.6621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ebbJBQClKCgKWXkEqhzqTWlCkbDIDFYIG6dkUtX8516zACpUIorX973Sj2d2+s4aqHdxmk8giGzu7VERxhMIOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9221
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

To support Android GKI, need to build this driver as module.
So change the config as tristate type, and add module license.

Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/gpio/Kconfig      | 3 ++-
 drivers/gpio/gpio-vf610.c | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index ec7cfd4f52b1..53c35cc0ff73 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -680,7 +680,8 @@ config GPIO_UNIPHIER
 	  Say yes here to support UniPhier GPIOs.
 
 config GPIO_VF610
-	def_bool y
+	tristate "Vybrid vf610 GPIO support"
+	default y if ARCH_MXC
 	depends on ARCH_MXC
 	select GPIOLIB_IRQCHIP
 	help
diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index a429176673e7..942932ce825a 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/irq.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -355,3 +356,4 @@ static struct platform_driver vf610_gpio_driver = {
 };
 
 builtin_platform_driver(vf610_gpio_driver);
+MODULE_LICENSE("GPL");
-- 
2.34.1

