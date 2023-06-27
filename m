Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B097473F577
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjF0HVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjF0HVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:21:24 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2112.outbound.protection.outlook.com [40.107.117.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BF4297E;
        Tue, 27 Jun 2023 00:20:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BT1pgVh8xUtQBEDpuOYDxqmM2/OjdGTV7cEG6hc6w3CXpPnW1LIJmyKkfNeWTJ5DhicZoYiAbCPSriXRo2DxFT+B4+3ylRgl4H7Kjg0EikbiWQZpwondB99HatcAHhvKW5BU6MDD7jFZBrwzbRysLPcTnmRgkFbyg5LSm0pobkSVc+iNCQQX3ZtSkqrQB+UJyJ0mpwXLE+z9BjQNY/Y72om02kIbRPQO+jVlLjbMBPYZCk1DP7L8x6wipeRSQqvNFj1o9ZS02N0mHyyRUE6IeaC9eF3pIhglvnMXyAPs5IdkkLJzqLxHYwMugQK1rHm7d6TQ6s0OeXhYd3Gp0FLBxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipZ7cDBYNNdoKsVpnNoptSlxnJGUlHASlE123uOL6N0=;
 b=iPtN0tL44SjpHYgBd03K5WmAxwvpWtjI/BKyjUCZenT96zunHTfvbCe8FN6wKnJtce1nOhXnSghLmUEugF97NbVgKQUlutWTT1FQe/STqFAeJzpLuvYQYNlCDe7S9GxFTz6xLkf2B1ZJzQnrU90O80Sk5rlzTeqVReVfm+yhOUrNq9pIVZKFxweJeyYvmAJq4MTktk3EyUm1ojKdjm8xj15Orxf8r+5i8TFdng2FG7f4E2uB87cnCVMiwQxiwSA7zie/DscaNqb1z93vGAUnJ4B7UqifiKMpL9MykQ/+T5fgeev+lndEyeGqdJHdWWazBkSxeYIFapyfuy4SaxukFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipZ7cDBYNNdoKsVpnNoptSlxnJGUlHASlE123uOL6N0=;
 b=iyllgPSeQC9yqhGTM1S5qIZlA5BJChC3irEg5fsAZBOGfVE/gLIz9z+1+j/aTqRIGWVAZhrkZk9Qvf0KBd3rutjFll59ILkJWMdPAp2s1zBBKHd39mhfH7Hn9BUXBx0WSvJhZ7dXbZYXDXFa1IuKsei6h+hSkGfKgxvgIg7sVjODLPqqoR+iphiKX28UJjRu6b0Ron1nVqgTxweehu16ZFhDhjTlKxcBL9c8W/88SJQRMNII7QrywtqWmXD+voqh1XHZjkzc08+o69T0t4rVsPUfj3s5JdN436sbaFYcmnlJUXaojvfdhiqBNl0dEviS+0i1X10D7VXuVxRTr6NSdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4289.apcprd06.prod.outlook.com (2603:1096:820:78::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 07:19:52 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 07:19:52 +0000
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
Subject: [PATCH 14/15] thermal/drivers/tegra: remove redundant msg
Date:   Tue, 27 Jun 2023 15:17:05 +0800
Message-Id: <20230627071707.77659-14-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230627071707.77659-1-frank.li@vivo.com>
References: <20230627071707.77659-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0098.apcprd02.prod.outlook.com
 (2603:1096:4:92::14) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4289:EE_
X-MS-Office365-Filtering-Correlation-Id: 05961cf1-58f6-47e9-44e0-08db76dee666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Y1VHTqbsbyElKys5nKiRST6RTqLXGOLw2707gxcihmQm767hBqrRom2+qgnWOnc4QVQvyB9unr6FHyZrePPYQKFWXFuyjI7I2w7P2ScFWY6hB4kjPfJb6Q8dPCpwt7cW/vk6KpFTMr071kMzOOduYGG9VOu5h9ipYOzyXjXgSZkz2kx1mcOlesyPq/3vEoBjhp2cKGTgaT9xeWt083NQHTq4xDUwpMRwEQNLmkPnTjlzsGqTexQdHG3MgGk7SKuE5q/mTn6sLbWwOoPzql2cYRiA+nCTdo19VkRHV44yHYEWCn+kmJeUBq/x5gf+u1kMwuER8i1uLvARWkd4JeJeeEYYRNxCkHaNdtPhT1NkZn5+vhDnYr0X0IN7HCdaDJvPb9AKKSLBwe39RjJQjsgSGWcj1+n2/zJuiRB8N8t0wl+2PZRWG59gPViCVYjvLjdOfwBJwb7bC9t4NQAKBrNYQIhc7yYfOV8B6Z8r7pMRtINa7YD1jbYGkHv5LSo4fVxR4NMwd3qxL0jDcs9f3OiafiXWwBZ9lDl2mC6SpRDFguB+gAIrSRxpvTYdgz8L0Q96X9yMWaXXrx+R12tjmUkDb9n/wi+KKqy8Zu/aMMEmZp9sasrbSI4sTfUV4ns1xKYblcSBYxghZP2xZJAiWTKsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199021)(6506007)(36756003)(6486002)(478600001)(52116002)(2616005)(6666004)(83380400001)(2906002)(1076003)(26005)(6512007)(186003)(4744005)(5660300002)(316002)(86362001)(7416002)(7406005)(921005)(66476007)(38100700002)(38350700002)(66946007)(41300700001)(8936002)(4326008)(8676002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uG+8QhCjxo+LGD4DSQGQOo/AkFbc8SveVqsCZglhWdKVH5o23w2f/TDAYBYq?=
 =?us-ascii?Q?1x8+An0fO2KYDsCf76akJYfcvGCJ+hJiNdvWKa8Mqb29fshp3VyqzD1C11NN?=
 =?us-ascii?Q?c32H1ddfGCftKrW00/cM1H3ZaiZQkbeTymm2mNmVRDL7G95nhpeifuolKuJ9?=
 =?us-ascii?Q?gbEbhN7X77Q7m8FLNTNqRNWegP8dohynXVzFKFWhGK+EyHiMmqjRKKv0A2qn?=
 =?us-ascii?Q?jtStnjAnFVunUyPhePLdpFteAm7hkBgIgX8nvPNJZTgWZl8TCGpGzVLv/hw2?=
 =?us-ascii?Q?3VYMhRV1+AQ99Eo8Z3vOzNVnC+mWjQK0uyy0yxWIRnLJd3jqCae48zOYZb/s?=
 =?us-ascii?Q?EVYziBgFyL3mu8i7LtSsb4UUW/8hvKsrfIrt8FF6U88cREk+N3njb8yS+XP1?=
 =?us-ascii?Q?XygU/1sg1DMw+fmHG+cpA4/8gIaRNTlXrwTZDOXVGnAUfOrCMb9PsB3fo70p?=
 =?us-ascii?Q?NbMIhaB4YiV5TUNFw9r9AUGuC5N6SNYQvPJf8UDovJprcZaFd6aJu8ujsLUY?=
 =?us-ascii?Q?MhsDPlelN1KaVntOwz7vfWIEzR6kSQTx0TAhiO/uv1BeSY2rEu5RR3+pQnpN?=
 =?us-ascii?Q?ADd+n54Asd+CeE86NpId9VM36QK1RXObh4x6QuJssT32EBMwRn1C3Psr/cAB?=
 =?us-ascii?Q?QJTg/aTRiJeeU+v6ovGoOvaDD/lCxMLBXzY3jEgRgpOLYlasr3CONrhJXEdm?=
 =?us-ascii?Q?nkTUA0ofHHSTzX0guEcpa6qqr2v1HJQVbDocB69II4AiTnAQheE0du7vQ0LT?=
 =?us-ascii?Q?nLZUaS5BlKGfQPc+CBX/JM0WjLNcEXtr8trfs7DBScUAfvzx8Z6XTT72HEZG?=
 =?us-ascii?Q?BdCxysyM8dVv0ricGuhO8Fx8rTarwWbie/x+Ov248miYVAp15v/TU5lN3w+i?=
 =?us-ascii?Q?7WUkXN20BRdRlsH5TXsUeRi/4bswWonm8I2Vs8/jptB5kz8f8Dox1lKCPdG1?=
 =?us-ascii?Q?7otdynN4Ug5IuTOv9tQuWtKM2jctiG9feobJwpAkVHVfNO5kdE6lbvyZQEVB?=
 =?us-ascii?Q?3ApCjX2FuyVDO/89H2B5d+6EGObs7q+BVfpFp/ROAobsvOMo4pUK75Mr8Zcq?=
 =?us-ascii?Q?PHZwy256HCeuBb9p+GpTogjNS/BkmVc7pU51q1XLtNfjewG+H/3HRWpECCHe?=
 =?us-ascii?Q?uxw/UtncC1X/38cNw1pJb2oE/beD1fFA66LLGlc/c6op0SZpwWsmakcXYlVH?=
 =?us-ascii?Q?aIaaTnfXUjMJ6OKG4Q6LB/nCsk+sL7KeTOioQRqUTR1euANPkGFo1PVjye4t?=
 =?us-ascii?Q?z+PwpwHqChWR8w8K+0LkqOOVeOpD+LHcMqstPfmZJqHlCoAFAxzljTWKpKSJ?=
 =?us-ascii?Q?BlA1qMf3zMVFM3k+0ya4n7opsUpqe5BcgL10F/N6kotJTB43vy4UX/wr3YXS?=
 =?us-ascii?Q?hQ6BoseSg/yeI9H5vdiQPADoVnD/llfz8DBd5BVUYO0nFaK/u5rW7jWv+jIX?=
 =?us-ascii?Q?zAtbcDom4BHoR2P7cxWCOcXUcfkNdiIgB5jWHqk6nvqaXk6G0ybflMWGgA9B?=
 =?us-ascii?Q?Bhm+hcdDu9J96SZCdSCkHCDzw6US4pmSBJI5GdKe390tpPAvQTOSs2uaONqt?=
 =?us-ascii?Q?yPHPcijhHH7/vdJnFw194qST1PIbWL3u5FzeHQSP?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05961cf1-58f6-47e9-44e0-08db76dee666
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 07:19:52.5051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ekrBh1Otf8kthZATVUXhtUnoA6x8fmcIaeY3c2Xxk6b4DtBNk9mldNn3UG74EdtueNSaS9ruaerc8BL93utSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4289
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upper-layer devm_request_threaded_irq() function can directly
print error information.

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

