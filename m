Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A0E72E23A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242094AbjFMLuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241681AbjFMLuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:50:05 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2124.outbound.protection.outlook.com [40.107.255.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE6DE73;
        Tue, 13 Jun 2023 04:50:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ao0S65YoDB2LPKJM/p1ND1hsyXEyFHZXJykCNRD9UhvV9pVRBe2U1Ow3AooZSnGqzvQDDVES6WzpuXE5BPqVdYM2NApsRgqm/7tLXGpN0+wnauBF5N0HfDErRaAOD/TilWX37JuJqMyO0IkXTlrXuUy9VTIi8xCcBgxWJmWN2qcXT5Iz51iIDPmmBYh8TShpXMViKJnK4PzHPF6aIFxUmVKDvpWfNqi/1qfugepbw0W6nK7ZP/abP8QAHUOboXzVuA8GUSXK5+aZdpMo5FcYhGFaORGCMfcGxY4YNtVbTpDom7Xi0e5VsJOQmCl8Nx/xsA2WajlqooDMH48QWL/FIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rD8kg+92/T4iqfi8bXxqd9k54ysUymkpnPOGQgUuiY=;
 b=m10dPO60KfDRwvzOtvDbRw8ny880AiUX/m+n2eWx+iZODYMzXrF3kPixXeezumc/mKGeY/L9mdR7kTbuLqQ5qB6hdqIM8Obcma0bx01GZn1IHsuoJ2yNsrk1qoDoZe2dJuCN5mAulKABDz8eXwdhmJrJLV2k3yshG/0YPg8lYAPu60TetfoPvuVgCl+nziPBnhb6Fku+PF4xNIVUdR652lHMBYips0wgoRadCZKlhHAmXPZoHZWj0bkr+utkFqnkNwAYnDwLyRUwJyF/89Tqtoi2KHagYJXkXvIT/lQfKBkDPFZKakeJFv2F4C9nyybPu20h7yknVJ+431ibaXQi9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rD8kg+92/T4iqfi8bXxqd9k54ysUymkpnPOGQgUuiY=;
 b=Q9ayJzPLd35VQcfHu6bc/O/FIw+AStPpdukBNahEj8yi+gpzkWVAPWW/MbH/kpP8YpapCv3JH9Jo+9Q77WD3B4suHGjj4c+uVT50imVMPPrVQABxqm5tKD8+lU4GuBArFnZGcIcTeOMSjPTUTIB6jjuXyYc4D6JajQ74h2saFg0QvXk/T8N9zmlr68ZfEol1s5oWI97yQJAy9u9snPvCKPmn71MwKf5ZB2e2hGi0FH2AdqeUCko9GTJXpZpvlkEsrexXQm+NlCMxcdPRoUr9whtbx25YuxJxisBJXGjNyekK5AG+p4z09GcQBV22QjIBgqH+0KwbrtT078TUubZl1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5315.apcprd06.prod.outlook.com (2603:1096:4:1ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 11:49:59 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 11:49:59 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     glaroque@baylibre.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, thara.gopinath@gmail.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        anarsoul@gmail.com, tiny.windzz@gmail.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        edubezval@gmail.com, j-keerthy@ti.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, bchihi@baylibre.com,
        niklas.soderlund+renesas@ragnatech.se, wenst@chromium.org
Cc:     linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v3 08/12] thermal/drivers/ti-soc: remove redundant msg in ti_thermal_expose_sensor()
Date:   Tue, 13 Jun 2023 19:49:00 +0800
Message-Id: <20230613114904.15749-8-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230613114904.15749-1-frank.li@vivo.com>
References: <20230613114904.15749-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB5315:EE_
X-MS-Office365-Filtering-Correlation-Id: e1fedd5f-2645-436b-1046-08db6c0450d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GiyktBAkY/PcZDhdnlkx7GNaiRzRUMrUEUeqNsUUZix7KznvCcXQp+bCSLiv1zMSj2u7/yKSKYj/At10KvTa0TfjMgeBL5AFUkB6yBo8HcyLi2DXsE+FOfKaKYfz6mEbWJGlpfMtnxt7wIBvgPMMW4Wznbu1xIkmhcZlSOeFOBvlc2FbjA+Cqp6Mnqu0O3KRdlcjrNJlnLfyRDCLzUbBTXb8oaLeKom1NiTlF0YNwJRDaoP55WO7koYDSKeXP8/z5TEwit3je4pppjHGKwk1gBEBHTVP3efcW7954iHNG/mfQlac14TVjjkCio1TiznOImTpkoDV2AMeqa8f4PN1eWAaENurv1hj8dmZ5L/DHOhYAtftpxRd2O0I0revUF6IwmdImNSaVHsxrsFddsddZylYQ9MYNdXXqEtuw47UMZ+UK9JB6nfIkVFPI7ZV6/itCtAacnTTipysLl6wwfnlyyP0DSVLaVF/d1m95GYxMwLo64UYIGyR73JhwSLHxlLM/V7sQPTagnTSIyKMteJdkt/Ywk7GBf22yngsudvOnBE1BkTxzlCPhTmSnBIZH8CEnJS0uJAqYOGCuM9rcazWh+G9SZVwfvQ1thnJfDQRY+6Wp2RjJERbL8gCIoboOUF4Y127xGMmFQCQPpPgKiORTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(451199021)(4326008)(8936002)(316002)(7406005)(7416002)(66476007)(41300700001)(478600001)(186003)(2906002)(4744005)(66946007)(8676002)(66556008)(5660300002)(6666004)(107886003)(52116002)(6486002)(1076003)(6506007)(6512007)(921005)(26005)(83380400001)(36756003)(86362001)(2616005)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?17SLZiE4mTjtRUdajNlakyHR4pZrQxzN8xBbn9aR2Lvr6iJfsK8gs9YogolO?=
 =?us-ascii?Q?OZttLE57YyT1Otuy82wScvddwIYUDR5W20NpZ3WTyrXVHUSyI4KDbcZbRLRB?=
 =?us-ascii?Q?aPHifaBbaF399IPJeoCmyselgvmVkKoeLLRIL5agBbzEll0X5YXfEOHqsvGs?=
 =?us-ascii?Q?dYvEPF5oi5ir/Fg6jPyvdyPKu9K195xT756ecLmZ8VqmWHD9BR6X26LYn6aw?=
 =?us-ascii?Q?LyIYrNNWUTFSaKnghDL2NRJ7ZAF+eHI4YZx9NlK7s4Ds+lk29y2wtbi7WZ3+?=
 =?us-ascii?Q?1FQvtj0C3tyT2d1W5LKn0AVYj5LS0f9e7MBtNDaCCzTWqZg5yh+ifYh3gF2j?=
 =?us-ascii?Q?d6mTWk/3F9VuaNH6I7dMYG099KbDHU3wrJ3vfgKSVsYXl4V+5TXC2W6YgnW7?=
 =?us-ascii?Q?jIhA6t0kaJP1X4RMs9MXKf+4P8i8UTZIp/OUUxc7FLuT5d7p3teDjlmNcI5I?=
 =?us-ascii?Q?POT/IwJiFj3TTAe5FIWpdiYZhapOJDCbl4wa4YmfjjN0SK4T4iXhfwznj4BJ?=
 =?us-ascii?Q?LfpDq6peayZnDGT3FseRYBvlvUWYZLWWbOU9+hEy5YTJ7oZHCAuVRf4oZhCt?=
 =?us-ascii?Q?rHwR2GhMaEFXXJhdM8Hz2LkuSRZCFsupLPktDMrWcty8Ji8gPcvu6XMr8Vry?=
 =?us-ascii?Q?i2VbUGT7ffzSofkjSOwdvslDsBHW31p6aT/HHwnScaxgjS72/2rb63It2IRZ?=
 =?us-ascii?Q?NbTLpFMvRuLvBmu5xCJNfRWRxD+oNTnuOaFSCHaUgEBexugps6yRwSs63H57?=
 =?us-ascii?Q?khGBCSiwIvOtBYnjnQgW2XQRQM82lxElofCW/c208xDk8atEHOr00ie+SSr/?=
 =?us-ascii?Q?lrgWjbORd9IdlhwiwlG6UiOYCag7uvHkP23pc2OjrFAyxOlhRNcInwpP7W//?=
 =?us-ascii?Q?5TV14Pb5wVCdBdPn1fzJafPlN/6RSHzlJKSkmIvtDSzOElMUG6b8mQiYxqmo?=
 =?us-ascii?Q?zZDBkOw4pZ0iP6B/cEfy8ItrPeLG1+pSDi24k3uxT5tvGOZldk5FhE7q+FGq?=
 =?us-ascii?Q?ZxVqC76ZV8N+EWLy2+roj70EBlFyb2g9216SbiFNb0FTiFkfxlNuc1bldQiC?=
 =?us-ascii?Q?oIOAZY9jex+BX4PKu8cVKH+2TF31EbAsTL2SDkY7vuWJ5mUSkV8cdbzYi8XS?=
 =?us-ascii?Q?ZbarGb3CCxMEWZRaEehXa+t523ZjoCp6abpp0MsPeVJXJ/M4PuOnkkqJlezB?=
 =?us-ascii?Q?LO/yzVIRgA0y9GsvuDufjAQxBGUssHwGMZrXuALgKutrXXwcBk63C/8RfAbp?=
 =?us-ascii?Q?ah64VR44m0FEaJvMqvUqM93+DxO1RmLenFv0XblNmcsADAAmoX0s89n4NJsJ?=
 =?us-ascii?Q?ddDa6GrhR6zyG6ZzVICLoIuv0LpFPAWDiw6g8+wDbWP4wye9S9KeAnuyyutR?=
 =?us-ascii?Q?+t4hhY2YxZ13k7x58eGkA6JqdZng1TSWnqYQfjQPpuIls9W6ncW1yQgjKrP7?=
 =?us-ascii?Q?VooSeo6C/V6xVG+IooADqsOHNKnk14vIF+Vk8epJN+4J53t4IpyriI8hRLQC?=
 =?us-ascii?Q?QArYSpy2o5YriPit4gU/NaLXzwZxCLEMJXdi7HXJYg5iIdw4xNY3IJ+uxcwJ?=
 =?us-ascii?Q?sWLsIS+2nFvp78+9VorUgSDqBx3JRaRimLPih+gT?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1fedd5f-2645-436b-1046-08db6c0450d9
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 11:49:59.7034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /rgT9zlyGzFCJMdJdxWM+xyLX7nQBfhbDSdDTnDmcYVO/rX48Vo9NY7H+spoezcoK9Z2eljZ+iD1PzWwt7K6jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5315
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
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 6a5335931f4d..d414a4b7a94a 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -182,8 +182,7 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
 	ti_bandgap_write_update_interval(bgp, data->sensor_id,
 					 TI_BANDGAP_UPDATE_INTERVAL_MS);
 
-	if (devm_thermal_add_hwmon_sysfs(bgp->dev, data->ti_thermal))
-		dev_warn(bgp->dev, "failed to add hwmon sysfs attributes\n");
+	devm_thermal_add_hwmon_sysfs(bgp->dev, data->ti_thermal);
 
 	return 0;
 }
-- 
2.39.0

