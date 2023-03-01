Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2EC6A65D4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 03:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjCACyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 21:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjCACyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 21:54:39 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2079.outbound.protection.outlook.com [40.107.7.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2E121A00
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 18:54:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQzrA7uQ7sOEv7UWDGozVFMk7ylqbEazEZwDkmGKd9e/h2smCKDqidCIbija0O9KPdiQV0lIalKmSZtj7GoqCpyOUpLMCjQ8K7ldSf4cROEeHVIS0X0yLRe4K2wBL9aKR2VqGBxVy39qamxc+4zippTH0qPIi3oy7eWX5N2C0GD7VsJ0xnYIFObmMEGnnQzBR9qhUJ6WxVhD1ILlt7vve3pm94Ggif7YTbOPvS6nMsSGRXJ+g36CxlmkkfumXW0sx/SW6nuOhu29EQoXLXtQR062vut1xr8y49Y8Wek9sFxhLlH6pZtwLYQAS2JyYi0eTAHPMtUBoGiUQw9fmxoA9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pK3RCSD4HZYDF9uNi+8ot2kqwxTvdVPeF8tW3Z1VaYg=;
 b=Kd5B4GFgLGqrGxugvP2P+VoR58tTw09MsY+RKNh1U4l7p/42cwvD8k5Q/glV/TbMAgMLDxNcBIJatJTFsL4+fJ5rOTkODxy9tGKmxRGg1yaRLSv8jELDHYiju9HydA0y6TACUhlGXpXOXuB9vEJA2UGOXSYycvBhFM4ftAFO+3ZiAm8BVJ461UwqSAG0xh1sLpA4QUWhR0bP6fLk95DAEzb/1nGq2InTg3ywuBdNZeQCK36K1f9yaaUVwZimUNxpR8teMOedaI6BdRmNwQK7aO0bCuI2A3lsD2T+WCcqqk6SxNNYaoursmjqC7njXniLd/fXSTLYDl1M3Gi37E2GxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pK3RCSD4HZYDF9uNi+8ot2kqwxTvdVPeF8tW3Z1VaYg=;
 b=csDpRpM5WfLmeNvvYLfkAugegTinJWfnsIeMLre7OftA0awcyv7SvmrhfixOahnijTH9nYPBDgslQjOQu2mdZPXuW/0n5mNPzQWTsznZe74SuWCVVbgeHP5NgjtfiBRY2UBTLZjS4BAaVlBdxjoiK6hXde/KpPVd6OmWpGdeloQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com (2603:10a6:150:27::9)
 by VE1PR04MB7469.eurprd04.prod.outlook.com (2603:10a6:800:1b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Wed, 1 Mar
 2023 02:54:25 +0000
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36]) by GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36%6]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 02:54:25 +0000
From:   Jindong Yue <jindong.yue@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, l.stach@pengutronix.de,
        peng.fan@nxp.com, linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jindong.yue@nxp.com
Subject: [PATCH v2 4/7] soc: imx: imx8m-blk-ctrl: Use dev_pm_domain_attach_by_name
Date:   Wed,  1 Mar 2023 11:00:39 +0800
Message-Id: <20230301030042.2357706-5-jindong.yue@nxp.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20230301030042.2357706-1-jindong.yue@nxp.com>
References: <20230301030042.2357706-1-jindong.yue@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0136.apcprd02.prod.outlook.com
 (2603:1096:4:188::16) To GV1PR04MB9183.eurprd04.prod.outlook.com
 (2603:10a6:150:27::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9183:EE_|VE1PR04MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: 73f50da1-1e91-4efc-f51d-08db1a004429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o2bLB9FLaZUIW9Ln1tMpO7ffAE+f8nSup8qdXOcFZawtWSWWNOMfGD4UDAzV4Ju3qXd7iuR85QnFT2a+01WcS/T/zkT8R876ZubQon0znloXFJac6p0z1cfGXw5Ixyte8qY69egt891LbLFUpYJuoqLH4vL55Xbhz4weFZPNpisWq8Jst84x1J6QBvjFK5JPMEGCg+BsCGyqt+wrn8czEavDhvqSs4KNWg4vYUZ48e3ss8n9LfVyjNUS/FPxzok/brfwu8ujIsGDhuXrWUzpgIPkdaRizM1bU4H1C/INnu9ul8IDTZ/RRhkURsrNVXMVx5IUTkhwPq/h6SlEHbt4pilTceau3DYsrSTs+9jkSjMl6tnkRlVEZG4a+EQwS6XHQyv6/E/6I/1IkIAuTKNroSjx6zhc5tq/pRN8+xJKATjOqPlePEPGiHhz6rREcVhLLvGpxvacUe4A+gpOl2VcsZEC24JYsID55tkIjn0OexjkbR69+Ui0Lj5ZOeYaZMlpN+a/8oVb+GyofgCEkI3L+HEd3T7LFJqzOpdOD6KiE70YNV/hY6Pnez2fIdKfchBxXrsvD9RR6J/cveuEZ+BAhkjRHmOGbCSlvQ6Hi56ss/+3bkEwvepS0QKiea8/Nl5sbvnqlcFwc842scbSl8QPBxp6AcyIfudKbVGYGG5BOLwfguarUZ6pzOhCwqnx1S7iHmpjRyK84asNhc0tK0epgpeNZcY15Y1T4xKfrTkYfhA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9183.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(451199018)(316002)(86362001)(41300700001)(6666004)(2616005)(66476007)(8676002)(66946007)(66556008)(4326008)(4744005)(5660300002)(186003)(478600001)(36756003)(44832011)(2906002)(52116002)(6512007)(26005)(1076003)(38100700002)(6506007)(38350700002)(6486002)(8936002)(83380400001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vYrzzGpdfEyX3O8ISsdBRNie94GECt27oBsiemVWGdVTZV13AYzj/+534D7X?=
 =?us-ascii?Q?YtgZjna5VQtv+rcIwcldBJ5RGx0waAbbmBBeWs+1RL8rKu47lK1tgFoUtncV?=
 =?us-ascii?Q?M3bnX1RjFIPeARFN1x1tCqHbDkSs5LjpUuhpLVsZZPI66tUyuWuQPNs0yTbv?=
 =?us-ascii?Q?YEphIgQYYG0D3qmFuHmKSuem/ZWRAEk3kj3ZJqzjXnXaPqKzTb/9vGuK1FSE?=
 =?us-ascii?Q?Ssfdt80Xbn2uOz/TWbtOSjWtvue8/CJjvbArqda/bACDL69ij4I3dbb9ELsO?=
 =?us-ascii?Q?C4YVb+UMR/mfNnety4mDqcAi5p2o/Dq9NK0aOw+DoY/p9lvcVYc8Nnroeni/?=
 =?us-ascii?Q?qGN7beFg16++m9r5wBDvVZPb+YmIFMlXp671ql27xJMuF08p0l22FpeGlTfz?=
 =?us-ascii?Q?DctBNMr5V0zEQ4wBPSjclXdXu0IIjsSR5BMt9/HGW4OJHrbAAQrOE1MoFZky?=
 =?us-ascii?Q?5DFvMMNv4D+xW03VYOQkFiPrWTjTO0udueEoNbfLW6gOgn7zuWcWYhFZ1jIX?=
 =?us-ascii?Q?WMIkLxQ7Lq0bcDaHkJ01GuxijWQa0eHOMkolQCs8uVxtk1rOhe2mE/+2ADqB?=
 =?us-ascii?Q?MlDlc46Y4tAD1FyqPWjZQfSsLwN9Yhb0dIwoNfrcRdWo6iO843tO1mXCqJfE?=
 =?us-ascii?Q?6mN1fulRpG6GtTr4w4iJnJ9S/MO1Nm0O0BebatrnWidVtWaj6j5NUv5lpu/6?=
 =?us-ascii?Q?EOLHpIOVxynWIB0qyZzBjW8L5LyKQyTeyTPjyFZb2fFuZXQ7rxgIrBAaP3RN?=
 =?us-ascii?Q?oo8ssvXMtl3oZ4hytXTCFNSkmwgVuiVy3hm+hanE54UAx8QyGS4w5EK6z4tp?=
 =?us-ascii?Q?wo+lGpDH33x7wZop8FvkdXd5Ec+IdUcYTuohnaaj2wKoYiwVor6zDrR/CAhu?=
 =?us-ascii?Q?9zkKus7m/1P6gYs1iZIVB2Oi42GuEJjW7JRKx+gNRr2Irvjq5kiGiO9cn1lG?=
 =?us-ascii?Q?B8PI1mV8eUr3dlpIC37KErJd0NkKJD4vT3qQGgcAuhQR+bbuJfehNtKChd4b?=
 =?us-ascii?Q?iJByBN1reEYEZmjkSaSSgdESJtMheUQ69vtXXA0kIZf1c97tdzH2FliAQ5nO?=
 =?us-ascii?Q?yCMKY1F4z8E2c1loO2YnNnMq9vROxsTaqoxdBApaXPshao21aw4y2Xde7Vks?=
 =?us-ascii?Q?V2DlvHWY5/scN10o9qt3VbkmcWz26QdPagjVSyO+702z6adQYs4MMy9nuFeY?=
 =?us-ascii?Q?mqvUcwTHusLPmhHwYu0isofxc0TRFewkdeNutHuGt3gNgXdKpXr9OTXLoBjI?=
 =?us-ascii?Q?9G7W2PqE7yejF3DwAu1Uzll/JeA7SyKcg4YA6m/h11kURexZNz85gFGU0SSA?=
 =?us-ascii?Q?i4crsYAvWC715fWJf0jGNq1Z6mKVSi561SxvORTpYkpb2JkM56LtjGH0a+So?=
 =?us-ascii?Q?jEPXBOmhlXrfa6SIO+bUfyfpDXI4yOLWVMSkIRL75cF2ckOhpwrK7aO+pMZZ?=
 =?us-ascii?Q?eILml3nFIcaLhPoLhngCkDUjQAmGw7fAMGaEXN6H42ISxS4ooT6gqw7ICqBZ?=
 =?us-ascii?Q?cFy1UNcAu0iDhm8VjO7GudzAY2RRt2t4EV5AUjpUJPMpzTBqg6QNFvwzCtDx?=
 =?us-ascii?Q?xtubYzN/a2nQMSW/4irhXY9qFDJ/KCnFSJPMbgir?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f50da1-1e91-4efc-f51d-08db1a004429
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9183.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 02:54:25.2572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 22kFLHvxHxv7+cdb48F8wseIG5qrF3qRCF8FzmKBctx/OgqzP4YHDtbE4uaALMp5PEwUS3BporYVuaxbPwJ3eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7469
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The genpd_dev_pm_attach_by_name() is not exported, it should not be used
by consumer driver.
Use dev_pm_domain_attach_by_name() instead.

Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
---
 drivers/soc/imx/imx8m-blk-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index 399cb85105a1..af67f2c3f7a1 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -210,7 +210,7 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 	if (!bc->onecell_data.domains)
 		return -ENOMEM;
 
-	bc->bus_power_dev = genpd_dev_pm_attach_by_name(dev, "bus");
+	bc->bus_power_dev = dev_pm_domain_attach_by_name(dev, "bus");
 	if (IS_ERR(bc->bus_power_dev)) {
 		if (PTR_ERR(bc->bus_power_dev) == -ENODEV)
 			return dev_err_probe(dev, -EPROBE_DEFER,
-- 
2.36.0

