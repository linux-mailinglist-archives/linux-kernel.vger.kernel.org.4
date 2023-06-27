Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D3473FA00
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjF0KQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjF0KQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:16:02 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2118.outbound.protection.outlook.com [40.107.215.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04272953;
        Tue, 27 Jun 2023 03:14:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8TK7FMioK79ECfuyLvudmUqaTTTxYzo4/vfQth+2PiLvD9Mdexk3rOp9S4LmnfsDgPh2QWBVSrlffeQu1Qtnx8/LknnS+xJCBfSJOelhHfOa0mvtKTaRBtzGnM123PHnEdDM3VqWhzzORJLUdiXee099CcpySCamRcH6DPLS/7ezSql+KTaJ6lCxQOMH6WrhBV6eMSINmsJ+LbXPSozCI/VmqTkucDWNYhUilUu2WM7lVNOH5PG338wtWvPWzYLjHj3pMXjJ9k9si++EkzX1FTK19FtDCNY3fDtXFg0yT5wJtUg3LWUDjkC8+6V1H0nwuLTDWOIGp53HAM1UMnikg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rIIic1NGOLrSpSOYr/tgCQmUEckFNCd+urcvRljaX4=;
 b=UARPcNuSGBweLGIlVrd5OM5aETVzc0fu4SYXpKJZKYr/pd6HX3AMpWutNuZLGfWjCFYhF0GSsDAXc5VBEhMok1e2Y1In8N19IfBii0R7bZchWMuz8z0gsiiLWcow/gle2NinFAkLbcdmA9laHmKvlciZtc6mj044+GFySZiveXbycBGM0GWsmSb62CqMQ1q7Ex3sKr1+wVUrJsmiDH0NhxSFsAmBBww+537dsAowHXT2mzrgF1xQ2YQGYeQLIj9n6AJME5G1Up0p0s2BqfmRKPQEA/vw8TNASmMMTkfai4eQ4qGJ3q7slSyfyozZ3909OtOvMT+2gndPoImKWOY0JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rIIic1NGOLrSpSOYr/tgCQmUEckFNCd+urcvRljaX4=;
 b=CdMzsZzspoUB7k+Lx/mcknmhi24aC4l/vdoC3t2Mtt+kee0ZuyZJzKBplJSO8QeTuzpguSYhnpJSxlRW5L224rIxDGPAEpMYvcHc69omk2vB01OA9KJz/zi7A9+xWJoPSPun2K+Kzoj7TmfdviONRnn25++te5HQu0GX5LDglb0ThTk9YXlT2Ik1wx6bmIDwz0SaACtZFYgWd9pO9qpGTNGIhpcJ3vRIMEAG4sOuFghrhdI60vPBk4rf00B9Y6gZzHjkEI3YDn9b1jfQO2OlLPlmt48XdhKhHKFOZrrZcCDwVIyUoVOql02aGVbAk59apOCMLVTUBLa9NbWtzU68Zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6661.apcprd06.prod.outlook.com (2603:1096:101:168::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Tue, 27 Jun
 2023 10:13:54 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 10:13:54 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     miquel.raynal@bootlin.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, thara.gopinath@gmail.com,
        heiko@sntech.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, tglx@linutronix.de, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        srinivas.pandruvada@linux.intel.com,
        DLG-Adam.Ward.opensource@dm.renesas.com, frank.li@vivo.com,
        shangxiaojing@huawei.com, bchihi@baylibre.com, wenst@chromium.org,
        u.kleine-koenig@pengutronix.de, hayashi.kunihiko@socionext.com,
        niklas.soderlund+renesas@ragnatech.se, chi.minghao@zte.com.cn,
        johan+linaro@kernel.org, jernej.skrabec@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v2 14/15] thermal/drivers/tegra: remove redundant msg
Date:   Tue, 27 Jun 2023 18:12:14 +0800
Message-Id: <20230627101215.58798-14-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230627101215.58798-1-frank.li@vivo.com>
References: <20230627101215.58798-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6661:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f983a9e-8612-43ce-4ce9-08db76f7360e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a6JhQjYW/Cqkyh3Si/1GVySgsWOqjG40VxshxfDGj9Y4P8I8sIIS/HzEIYz6BV1/a1wJBbt8If3UdakDD+spEeSlsaJS6QKNDF9iBl2U/Pl3Agr6epdImrzXNugYg2vxQlvsfsMmeeOQVXZM1iCjtKjZADSowCQ0nUCT4wfnJqQ1QxNOhWYrIxQiUJySlxU3Djb5EsijbQn45Ot1RSkzoqcYda9s0kq3XAIcZXBGOCo5rjPHiHfOIm3sv3vP6JxYPd1wIv+pu12jl9vYxTo2XZAs4vJfyHufuPLxMjaqCeF7tpKS6PBICmotcQstrHBSKBRt4JM/tL+bo/2qepEcDe3KpUNwAIh/IdgMHiPoyEl5qZ7pml0KRofmVCwSyWgB0sIAKAblUrmcEqAwm6NEITvrlHCPraE+TZWWan/zA3mv1tbf9xt7C/9a11qhlsXoWAFIueA5PxG+kAD4xBhbtRkMMuDPhX/d8ZWgqPnzph7Y6XzMpHy97RkPurzK/jywOPlUjYs3XC2mHZecvybqi+Q1WayrPWkrkvXE90KvPGrd6WYxHq+hNsgUfduNIkE1Zpn9fqfRVfodGMLIL+R3yNF1Rj+MizqOPABMbspS4ttbW6po/Y+Quivdt7tPeGDY28K5xQ8jgxIxMf8Q6TKwhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199021)(7416002)(7406005)(5660300002)(66946007)(66556008)(4326008)(66476007)(478600001)(36756003)(316002)(8676002)(8936002)(4744005)(2906002)(86362001)(41300700001)(6486002)(52116002)(186003)(38350700002)(6506007)(6512007)(1076003)(26005)(6666004)(921005)(38100700002)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d/HJ/AozBOQ3WCGANv65bqzGYSAnXPgz4CCPDNSFvhYiiQcUt81G/rklLhhd?=
 =?us-ascii?Q?aY06tFAdYToyWA3gWwU6vRI7ZCyr8kokngjr4btHlGnFUvVhc9t49rks8EF2?=
 =?us-ascii?Q?jkfTWxgh4D3+zF1xWETjFn9KNH2GBmdit6w7LersGNfoxNbfJbDkh+jCaleH?=
 =?us-ascii?Q?d317CY8ploNvg2hcdHgO7s8j0xP1hGElQb7JgiW5zm5zT5HYRJDKYlW9nUzl?=
 =?us-ascii?Q?S3B5xd1vpP6DclRdAV+ZX9vTEKKWEc8xrW3av73L8GqyOSp06FY29JtBDFRp?=
 =?us-ascii?Q?AdnfJ5OdkC0oPxvhZkydcU8Kn791GyMNEDw6MqgCjhqBigSpWl1te5RVn+xZ?=
 =?us-ascii?Q?SyC9Z/9alFSc6kcc6E7n8JrdV5UtGW1EEmFeUCbLGde76r8mxNIEooNPYjMf?=
 =?us-ascii?Q?nKBQIrOvYIePiPt+tWI0+K3UGrl5li+fW/oAGhminmL0WPzDheCcONN1XlTz?=
 =?us-ascii?Q?ohnOOPEfhAU5cC52Sntliqcfw+Vrt39yxE5MfvdRhdiOONFUReyW6qF/08oj?=
 =?us-ascii?Q?JmrOZ3Pv7lCYdVBc71r/XmZurSDW1cxL/F8yLjO/Fyi+S6+spL5dYyF3EWRq?=
 =?us-ascii?Q?xZkLmfzTaUpsOMqK7sJGe1sf0o8UEhiHDD/OmA/AjS6FDa6JqXW1iUXLniI2?=
 =?us-ascii?Q?uGYhMQgEudkrLB3aWdsGc/cpOtXtwfdWTzlnf1+I0p+44vaxV3jNqjACjZpf?=
 =?us-ascii?Q?iLFYSU6EJ+kw2UMjponNTQQBygWRh5EilRSYbzFspddz51ld4kVQRcbcfOxJ?=
 =?us-ascii?Q?NCSSQCdoT2ZmPBjoXiA8Eo/5X+mlkorJGOprPgbskbwt4j2WPODdgqcjTg+h?=
 =?us-ascii?Q?6OpRyU+YWtHrkb9F4yTDCZmMN7C+ngdffroAtEgGWon1WUY8nj4u3jSBKlGE?=
 =?us-ascii?Q?t0JZfoTtEV9Xiz/btap3/VJvDCisg9EpK6rcXfxOLWZuzjxKLimPEz53ZiG8?=
 =?us-ascii?Q?qZAkT1+wz5RzyhY/4ixQcJih2trOIxa2Y5iZWoAjC9N6joCujQoe6GURUxb8?=
 =?us-ascii?Q?ITskNAWQRtZyAopdOyrn9tNsnmsb4Zrx7pDZONO9IrBWzwc4bXtRrEAf/TTT?=
 =?us-ascii?Q?ZYhVgprdBL+fcCz7aM/MB8ObHyVpzn51kh9ptd2J0Xzhppgq9IkrJF6NeF7Q?=
 =?us-ascii?Q?NtpWPSkDJcJJWLHAO9LSOrGwockw6vNcdv5IguuARyra8EsxzalDv9N8ekDV?=
 =?us-ascii?Q?Swz7MnPFUSCXI70CiuddV/8N6WcIFtt1bQxY5NusbOYHuknUvYzURjGY/F+D?=
 =?us-ascii?Q?ziC0XmvTYE0oJgBt0c0H81OffGgSAJ6OtCAPzuRLn/tDesY9yhRvXaU7cI0G?=
 =?us-ascii?Q?XJPTonyDPNQkwUuffVIadSmg8QzrFRWsKDMnevr0ZJqiFDutAvE2pGLlyL7p?=
 =?us-ascii?Q?mEKfcxA6umQexXQTpfLWVDmtVCXSQzxpvWyEsHfDjBHJXaGcG7uoby8PK8Er?=
 =?us-ascii?Q?+m4sN31lML2crh2zDYKc0/rQ48mouSpYiTvAMMiv4LhOcZc9YrErYpa5K2YM?=
 =?us-ascii?Q?pozMETZoXB4GlN2Deb8yM5SC7JsHud/9vG6tlCv6O2Ec0khRHAr9GJ5iuxxG?=
 =?us-ascii?Q?IkdB6Q1CsJ9Q3Sj8gVULTJI1e+kYYrMbFFEw9gZU?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f983a9e-8612-43ce-4ce9-08db76f7360e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 10:13:54.1104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bne7KRUdJuJ6RX1GnbNzvzxkR1R/trqdehm4cGkSvKrYRQhccxKmVCSYSy78ZeIZES4k1jZ4xpLDCUOw86VogA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6661
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upper devm_request_threaded_irq() function prints directly
error message.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/tegra/tegra30-tsensor.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/tegra/tegra30-tsensor.c b/drivers/thermal/tegra/tegra30-tsensor.c
index c243e9d76d3c..535a0b7304e5 100644
--- a/drivers/thermal/tegra/tegra30-tsensor.c
+++ b/drivers/thermal/tegra/tegra30-tsensor.c
@@ -597,8 +597,7 @@ static int tegra_tsensor_probe(struct platform_device *pdev)
 					tegra_tsensor_isr, IRQF_ONESHOT,
 					"tegra_tsensor", ts);
 	if (err)
-		return dev_err_probe(&pdev->dev, err,
-				     "failed to request interrupt\n");
+		return err;
 
 	return 0;
 }
-- 
2.39.0

