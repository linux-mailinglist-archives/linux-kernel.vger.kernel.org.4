Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3B573F9CC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjF0KNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjF0KM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:12:58 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2119.outbound.protection.outlook.com [40.107.117.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F0FE3;
        Tue, 27 Jun 2023 03:12:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZJpvi0Y5NQIgyj4Xln+18mW5TjqLL6yrBTnC8n4B4JmeIQRcGbnZu7SGvaZ5fHX2LRKsMw7a5USjmBD18kG1yCgjkOUQOTyIW+VjN5wAcIoEPd7PkBsgqt2UWzvaGFioOTa4UXZZGHKdkS7jW+rC8q5p5InoiPxr60mpoempsCUe6oLk81jJTQmaEWHnBCgwo3oq3YXdBts1TNDJdBKNzHU74WTwPStsl3cIF7miw+6bE0n2m2M3go+GTEUKggdPywzdvuIdR5KdgyLmohO6EE37k8j/41QhiHGpYVPzViBe0xb4rK+O8qUiWND/O7TMShxf02CkKzfYKUbgRR3QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXSQxkPIIVSDV+cdDYzwOObskwuXoMkScNrzd3ttqjY=;
 b=HfTYU4b7COfxZ56TZXSpTTCCefup/awJS9oqrpemMujwZB0QjL/390ayY8kMA8E6nt5DJkqtz1VA1tR6aT9wxzdN1oPQlMBErWZwlu0FS+SItbmvXRDBuL/icr1js/VQ4SvM9tbV/nohJzk3nvJRv8kAoOt9MxChFct5dyAlmAx7skAoYFqvyTB8Q2pU70yD20Tboz4EvupG3+QbunWas1hqKvctSbLAo6taA/AZTs2PFCpnjq9bKuU5guH1zdiylx9+AnwBwWzD8alK/ieeWSpQSZ3hFFhZTGdOmMqsd7vldIVwZqUK9Wrfew4HOWe9dz/UXei20/mkAoRDvsq6IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXSQxkPIIVSDV+cdDYzwOObskwuXoMkScNrzd3ttqjY=;
 b=SU1MhDJwpqHodKCElgXIO7433XVeieWIs4AWcpD3jRqzjFwAQ0UXfU13X8ESmrQyClulzFlQDzKp3bzMpSptkjDKHPMHhnvvl3jsPjEpCoUSU55RyswsFAiy8/9RVEogxqQlR8P8x6eGXLL934qf3n0XUYAAD1e24yeWYLzf+DR5fGdD1tiMOCDaEHQ/ZHaS2TAA4uTro0j8sIYIlsqTUOL2vu9TbcX/0ULuYU/ZKhjWopreYvXg7iyoLmrLMes9c/uWxXPoBQePfLGE/zytrocUVI3zIcNunHHwfUcajwvbEuN3i4UmtqitmvhHKjKV7gRs2CnSC75SlwhlP9GxmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6325.apcprd06.prod.outlook.com (2603:1096:400:419::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 10:12:51 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 10:12:51 +0000
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
Subject: [PATCH v2 04/15] thermal/drivers/db8500: remove redundant msg
Date:   Tue, 27 Jun 2023 18:12:04 +0800
Message-Id: <20230627101215.58798-4-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: 73405b81-fd30-4720-207a-08db76f710d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D4kcQk3iI3cXmcvBWFI2HzWWM1EEcjr6TU+iWVneW+mggHBcgWe6abe8Dc8/zLHvukzTiN/Klns3tR73ueUl00MO0+/Eg512WbEfdRehFA5UrjPWwZtW0GfrWZV7LQE88LljamIiLG09OEmn2a9q5GZXxN+0rcvZ1I5eUIocRJHvuUuZFF+yBEo0+77w45/NmFNGyV8NeKNdG1eOeFbQYPqr6WuR4KnjdSSsUzMPYFZesVOUmGKGVzvHFv/ziO+lBT5IgEpys5dW9C6kd71RUiL8S+9j6mORntzvkHDxKl5Yg2l4wpZ+7w+aMLmEcZt3Nky1ZgRAovF47g+wcQv8lXky6tSzolyMFF5KXM7m4VTSXeOfQ+ylMfk0DX9iYWqJQ7dFdCzJQgBFsI2r6xgj37xHWDI68uObgZNFtO9pisHfzumW1kw06fbs+ZOvxMkcHoGc1fEcOSOm9swZsNUrakCknSRSrEDweyqFlGAPmOmYWWuEWPus+FdBntY4fj5GkTmRF1NM1Q7jr0nsUuaS+saS8z7YyjNGPYG95M3hH7ziGC0BHCemwtNiTFqfvWMPs766Bm06QQdNbbs8gJGk5jgO8Vbc4ajwPoRKItZkWHSHFVjxpnsJXqjdGOvsV34xd6KpLD1kMx/XylGmvwgMWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39850400004)(346002)(136003)(366004)(376002)(451199021)(6512007)(5660300002)(8936002)(6506007)(8676002)(7416002)(36756003)(66946007)(66476007)(316002)(4326008)(66556008)(7406005)(478600001)(86362001)(41300700001)(6486002)(2906002)(186003)(26005)(1076003)(6666004)(38100700002)(2616005)(38350700002)(52116002)(83380400001)(921005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yylEDKHkzWhNO4iagFmlCxhORXgDBg4If4/LLAPPD0Nelby9ZGAf0yDRevcs?=
 =?us-ascii?Q?prLWtOKUS/ojJCtgkUuAOc5R4VNLWQGDxGrlRWrkBa+vkDVFC/JQ8UBaaEqu?=
 =?us-ascii?Q?9Zg763LDEmY2tsmJAuj0gPfUwjOL4R+GuEDaiXNjEx5Ne9LuH5VW6E7AS9WI?=
 =?us-ascii?Q?dj/Gy9OPo2dyKzJEiZ/m80zAyMHwsa1VZeT/EztmCj2V5fHWjGlxIqd2YJda?=
 =?us-ascii?Q?Up+zPLop9GLrmnK/lLDD3UIWCgB9VV0rknM7cjK+tjYXa0MLoegTvbqOSdQF?=
 =?us-ascii?Q?oP595dIsYg1l3U2vG+kU0U1fYsor/eek4CLKKaKRy3T3I43oUW5YzGUT9m12?=
 =?us-ascii?Q?y5fCcfqdtOG4BezkwhCNjCbi9otNwyi54rDONp8NRK+v8IMOhXryEGlqZWCf?=
 =?us-ascii?Q?pY7Ipy95KCD42rjIBPZgupVufBBbUPgMYrFG5Ri2umNJnpwiX+3t9JlUpJGx?=
 =?us-ascii?Q?HZ7LBQXEvjCZnVbh59TtgjX0uTrMg0ncjdMdP5KF//ukOQ7JLrnxtpDEr3kw?=
 =?us-ascii?Q?Qx63B77cEavVcYiy1SI6K3q49xSGz6A5bFpd55mb7hWcqeGc7m/0CA0e2PDR?=
 =?us-ascii?Q?BgnmOwjI/IJ2us31cRiR0rGhsgjxl/KSv12hdt3RY1m+nI+7Gac63laf+eDf?=
 =?us-ascii?Q?Dmk2z3rSrpt4w3gkzya/0aKgpQ53+4tSUYcveTMglNYNbxEq1df2FFsB+eDc?=
 =?us-ascii?Q?XsRe73vXXBTyb+xiKqK4hzKNz3NXEIlCC6DaOYi8z7odqJfH7bmaxd85CPXi?=
 =?us-ascii?Q?QDo3KwgktSNdBLFecSVxX4es9z+m/BY5SlT/nq+vnbZw9TrC0XmGWWhl12by?=
 =?us-ascii?Q?qQmUPzf0zOcq3BJSspFKd/LW0gIZ0un6K7Wgr/BwrdOrwBhs4cSQQInJ5axM?=
 =?us-ascii?Q?EQOs5DeNQ1ZUf87eyH5QEvH35KQpRYLn3enp2bXGlzwNNB0zuBL7UfAeIKqC?=
 =?us-ascii?Q?ixAoWsXiCj3wnq8h7yNhy+x/qSn3QvinRFgKJMm5fRbvxQfHqREyTGjghaHh?=
 =?us-ascii?Q?NS1yN+726gqvPjkz9VSdfRvJAaRuEmgWwq/WT+HoYz1DukyLcvUvu9RcgRJa?=
 =?us-ascii?Q?8DwImqTvfg71qkt7XH1Lrg21NNMd2/Ngv9uvlMpSJ6uZO7BJv4MBwfdUAvUS?=
 =?us-ascii?Q?0ETBJi8cG52PYSCzO1D+IPZ5qKJiq7AGTo3d2823Oeou2f8QtLs6+y483O6g?=
 =?us-ascii?Q?io/JRD1yCieqmOIQjY5+JAZmN61/c02yRhgbm4IVodxmY+lqLJx7J/359YB9?=
 =?us-ascii?Q?mDL9TNzi6HtpJ+rhMQOjkt1QLhhX6j3mHcml/Zyh8fngLAMPnmYQzlB1L9Dc?=
 =?us-ascii?Q?LyjTkfwAPjSyz+7bAgdVKkB1+iFfJ9HWw8WUpnpxC77jUcBJXMlOwrkcxI9C?=
 =?us-ascii?Q?aJjiSYFWPgOQj6DMQ1RZcKkp06HgzxNSNqHs6O2hH2xlr+TZqQ6kmnupGpnI?=
 =?us-ascii?Q?LHdZGWeBn0Yg8GpOM47RQVX8OtmOaqh40Ie/yjrd6d2pC1QgtvoTthXZzxzf?=
 =?us-ascii?Q?agfJjlaG2roqyIUEEm3sSXpJ1wneC+sLyclmCF2FNVDoTdqycokN2KZtgIZv?=
 =?us-ascii?Q?EA0y+VJGHVzH5ldQQasDU/DpdEf5698BYdZqRL1l?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73405b81-fd30-4720-207a-08db76f710d4
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 10:12:51.6076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Du/NliZkygzqJvhygl95BDyx2jCKAjZ8EKLdZEMYnHC+t5Y32JrIDpIr0W8GJdmVfR7WGDokr3O6lZOLz9lE/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6325
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
 drivers/thermal/db8500_thermal.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index fca5c2c93bf9..0a890d1338cf 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -167,10 +167,8 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 	ret = devm_request_threaded_irq(dev, low_irq, NULL,
 		prcmu_low_irq_handler, IRQF_NO_SUSPEND | IRQF_ONESHOT,
 		"dbx500_temp_low", th);
-	if (ret < 0) {
-		dev_err(dev, "failed to allocate temp low irq\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	high_irq = platform_get_irq_byname(pdev, "IRQ_HOTMON_HIGH");
 	if (high_irq < 0)
@@ -179,10 +177,8 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 	ret = devm_request_threaded_irq(dev, high_irq, NULL,
 		prcmu_high_irq_handler, IRQF_NO_SUSPEND | IRQF_ONESHOT,
 		"dbx500_temp_high", th);
-	if (ret < 0) {
-		dev_err(dev, "failed to allocate temp high irq\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	/* register of thermal sensor and get info from DT */
 	th->tz = devm_thermal_of_zone_register(dev, 0, th, &thdev_ops);
-- 
2.39.0

