Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AD8736741
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjFTJMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjFTJMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:12:12 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2103.outbound.protection.outlook.com [40.107.215.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B152D185;
        Tue, 20 Jun 2023 02:11:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsuMJy4OcakpHLxN9RJwj4abfFtJV/T3JYQPWsj1jxq4xlnXiq84yEOqGkUe5YUgqd3y+gbj1ygK0bGRNkw5Y0ZzJw0gpS/T8L2YIcdCWPMHC3b2g4c/xR/jUpVHc0fUoVRcGDWf7zbFPie1x4iFhJ2frgMb4AwC+t2ujUAPO/owqINZI9sEa0OZgVG9/m8C0ZpkN/+YWqVTXmQOv0cFRUHv/QjJnXTzuac6fGEIk+mLpWft9Q27jA9MMEQBCWoZQco1QYTCIzYAAs2NQfMxTcn2ceMBsmpYXcvV9MT2Myin22RUZmRWKQDQd9k0gc5I20SbkyFf0XIc4VDf0c1Apg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFRIpDy9mxKf73VaQXtUPoyL7qnzSdTF1HT8l2XaQcE=;
 b=SSZfvtD/o4zFWguZC9NBCCpijbSFTdZufKblUhw/Mgs+oeBmdPudmamNSUSHqy8/opmtgwQrgBqlsK0ACa7sUduehIMPT6rk50pF5AR0WLDlvnyE8Bvh/tA4727BPgoiqe1K3CJ7V8VHE8+4pRW74VDFSdgMYvn2+hrENI1SiclAJPysw4veAsjhTOk7+7GQScBQxykL5WCrbAOSz1Da7HAL8ubxG0J6MdypP0jf8vh3BD/B2myp01/tbuYdJ0O9B0wPhiN93vidxAF1dmFyd3PAk3grqnJOqE8G5lC9DteZWZW2EHibFmgQh2l8ZuQrU9k9DhivX1HE8na/ZptrGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFRIpDy9mxKf73VaQXtUPoyL7qnzSdTF1HT8l2XaQcE=;
 b=TcO7nEBnD0ETkneJrWTVs1dzhEFO/o3YKtA3nhB+HKU5qvxzYbIC7h3dN+RUYGcZI1sQ2HiCPtyZ1l4CIVrI+d8yVxsddwHYLj8AKD45dPW7kfQB2BhUq5ORvgBGtcMi2/1BYsgkqKIaQoMiRelgEo1iWDizou46fQ30R4/+fvf7jt3cYl9vzeFINAb9+9B9fgD2rBhAgRTptzYflHI2jKbvjEAyj+VXlpBYPSP+H7jqRk9JQ/p2FTcSDY80Gd/q2W3uOrR9J3ODLMW2AJeGxACpxXf/n+B68e2Fwttwg/PphBvpa0saMsqBn9NG7Wcd5Y3ZnCbl6iY0IpQxRDVLwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB4510.apcprd06.prod.outlook.com (2603:1096:400:65::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Tue, 20 Jun
 2023 09:11:33 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%4]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 09:11:33 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     glaroque@baylibre.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        thara.gopinath@gmail.com, anarsoul@gmail.com,
        tiny.windzz@gmail.com, wens@csie.org, jernej.skrabec@gmail.com,
        samuel@sholland.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, edubezval@gmail.com, j-keerthy@ti.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        bchihi@baylibre.com, f.fainelli@gmail.com,
        niklas.soderlund+renesas@ragnatech.se
Cc:     linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v4 07/11] thermal/drivers/qoriq: remove redundant msg in qoriq_tmu_register_tmu_zone()
Date:   Tue, 20 Jun 2023 17:07:28 +0800
Message-Id: <20230620090732.50025-7-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230620090732.50025-1-frank.li@vivo.com>
References: <20230620090732.50025-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB4510:EE_
X-MS-Office365-Filtering-Correlation-Id: 67bbbaaf-c8e5-4016-1b47-08db716e5778
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZqD0kPV0fP5TPf6EC6uwX3iZA5vgdjRX9wapUbTYU9h25qxjT8vV17Pw0Nyd5fU5d28k+q8MILPd+1hK9Ww/1DcnkZqCRJplilHsF93OhcHvPqeekB8X0pxp1US7KQoSytSkTLmStDiTr7ekdhmNajzbadh6d7bz+iYLEWIlyEOnDgIPnstGk2DqOhP4OIvW5dppJVdR+bL4E+h/9Wy1ZHBCehzOgCF6cqI1w12glTTASE88Y7ZWCVkHy7Dk5LTKDBnLnVIdcqbv4uH1lkDnR5Ks7zEFIUtZ8fY7zxG6HpA51ZaNz592RPb4n1weeL3jCIRhhu2WfQIXmTyv5oQQYuxgPtPylx8czR5AUfa5vGTKLqEm+I9yU5NygkJJdLzcGnjOLkCM1OyK9BRJ4s2XpSQKJWI8xMZHuPWe0QM1irocF0M+ssxVwxm9IUWgO/lwKzG8MhYvaZDFRzWAu/MY8cke7H5Yiti5y+/tDzatLHPXHnyQBND77uClTA+PaUM6GlAiSOQL3vsEa9hrXfn6m6ESHPlhW2w3b7dhXP6VyVYemV2Lq5iBah4K9haz47idmD5/s6kWK00MuRBSMhhnOLnxU5HXmqe69kFaXd2v3cPYnbR9jGOZlyDl7RKaqs8/MNvKvwtP3iLq83jJtfXHBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(39850400004)(396003)(451199021)(478600001)(52116002)(6666004)(6486002)(921005)(5660300002)(8936002)(8676002)(36756003)(4744005)(41300700001)(2906002)(86362001)(7416002)(7406005)(38100700002)(38350700002)(66476007)(66556008)(316002)(66946007)(4326008)(107886003)(26005)(1076003)(6512007)(6506007)(186003)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1jnBNFKqkREkbDdAZqC0rvASmrzJcGcM85IJdusnf65M/TdwFXuvn8msyAY/?=
 =?us-ascii?Q?gaJtwJFjP6hvr3BdpEOjJS//K8NeQQaWR//0v+pl+JavW1HCLGIXBOcuN92X?=
 =?us-ascii?Q?mz/3TfGAkUm32fWH9qt5F6Fqb1OA7C+OYTbr1WoCE/EgF78qjI8YpI/AvRLJ?=
 =?us-ascii?Q?lFdTaJYhPGiRBB4SM5VVloOFDo3g1/FQwDiVyuSFGp/2Vbe8Z36l9yDXLgYb?=
 =?us-ascii?Q?Oz+LhhOfcrAVENvyvThYKXf5LUljzeJwIXWwN6HkVeE6j33rBFpMa3xp1PWX?=
 =?us-ascii?Q?AOfqiq7nrQY1nJGE3P1RVRqCjpRlChdF/uYG2NPsgzQUQbGRXgKO5qA8+U8A?=
 =?us-ascii?Q?MOtxov2va5WC4AuwYvZCXFvs2unZDOwixAI87ST9ZlClClX/hiBV7VwDf2s6?=
 =?us-ascii?Q?CzHa9FBXXZWdFqbknEt/IOivPj4A/+ZJ2d/k7hQmzAhSgQlphEdP8Bn2ZfiA?=
 =?us-ascii?Q?OivGTtQ6ZH//Myma9PtFNHsCTZIRaAotrNMm98j+OnUXqEWhQQWE8FvpsrFq?=
 =?us-ascii?Q?OBWn8wDy0ZQ4OKEamT9dNhcMQYfg0fGUo4EgK+IfQk0k441KtAeCnrD/4MAu?=
 =?us-ascii?Q?PVsEqcPUAnRl9hC1vhWcjyj8qna/uOKZ1VaiN3QAeNx1q+2T+RmwmKqQxtbT?=
 =?us-ascii?Q?SIaSDwSn3iMzUS8dEZSkgKk/GyYtFGK8v0VU9kYqpSXM4jBnTrsZLfrcX42Y?=
 =?us-ascii?Q?c0JnIxdnlrJLyG8xj2eUE4Ouh+cgJy42mDQiXioljtDGeyHciERkjLFL9gdA?=
 =?us-ascii?Q?Trphd2gZKeSZEDZVqCi+P0m/KrnRws/FKd1Egn/zlGqDPhALCI04inFAhZSp?=
 =?us-ascii?Q?95PXBfaRQoz6d1Qy4xiLPGfPxsS5G7cgkE3Fx7wD8yChKAgQQvm+0TMPZA3u?=
 =?us-ascii?Q?/4X0s717n47B9DaOQKviE+OwDn0zwbSq68XVsFgDyieOOWigKXgVC+DuJI2h?=
 =?us-ascii?Q?YYqrXeGTSnbf1Bf46DeTLGnmEPBDWEb6rJMork9tZRTdRLbsLm1/Wuo/Vog3?=
 =?us-ascii?Q?8w6DE7ZC+wzEhEeDCK7jke/XTsCX9mD4s4Yjb7+bKLR4f9VLePtgXzgfWyzZ?=
 =?us-ascii?Q?Zmbyh5RtMTRLgKB5imgx97GwfZT2iskpuwNS3DY5XQh7ZEbsmTVIXYWkud1J?=
 =?us-ascii?Q?Ov0f8VjB6dp5HziTuFcQHJjoOEf3oJsRAkxNTfwXdtzrgikUfFQv+sttOgfR?=
 =?us-ascii?Q?RywNP0uGD4pQ6iBQsA8HYLJ9SWxd8ExYQEA736MQCJd56vhEnWO+vnMG0uD/?=
 =?us-ascii?Q?c0Y8w4xdL3wjsB+cgvyUB5wHeES9rQFw9RBvu6rZcW28t5401nFQo3ecaZba?=
 =?us-ascii?Q?AhM5a8nIGCaoyqnPImix4cDVEKyliBL1gAxK+ihXI0CCmidT5ITTOB+kXZHS?=
 =?us-ascii?Q?eM/WLQXPpB/v2yLqTzencdl8DBW4TIw88R517QV2dyir5W9zYNP57w3yd79Q?=
 =?us-ascii?Q?O1zo+Pu8nplVY2UzZK5h94xIP5b1TyhTA301+nFhPyDaOxbhWecPcZdOhnGZ?=
 =?us-ascii?Q?WDpetkKdM8oPEuLmN5MuaLyx9ANv3xJl3y8xzi5MVp1zc+UQ4Iuha28cF3Zz?=
 =?us-ascii?Q?QUPXZyca3OEQQ2Edw8VWvatVShK0cVo0J1O9Rn0k?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67bbbaaf-c8e5-4016-1b47-08db716e5778
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 09:11:33.2638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c2o0KX9qRzvEyM6kSsVdPFHOGR40G6VQclwUDUXzqGcGepLeGNgA94VqIvsu9mPyibNONQlddFxzcm7/mLFKGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4510
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upper-layer devm_thermal_add_hwmon_sysfs() function can directly
print error information.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/qoriq_thermal.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index e58756323457..61b68034a82e 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -157,10 +157,7 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
 			return ret;
 		}
 
-		if (devm_thermal_add_hwmon_sysfs(dev, tzd))
-			dev_warn(dev,
-				 "Failed to add hwmon sysfs attributes\n");
-
+		devm_thermal_add_hwmon_sysfs(dev, tzd);
 	}
 
 	return 0;
-- 
2.39.0

