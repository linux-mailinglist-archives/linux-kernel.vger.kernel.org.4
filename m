Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E2A748422
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 14:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjGEM1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 08:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjGEM1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 08:27:09 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2090.outbound.protection.outlook.com [40.107.117.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66912B0
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 05:27:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLnDn5GxguLAtt5VlAI2HqYG0/gOvQDsszLgfit6YV3w0z26970XGkHG+I7CZme89P1SGW9Lpk9FgOaTLCicTHoWOq65uusRi2bTjhcbsovq86asX+XV3DOpv1YC7LxH2cFnhrTkFmRgdfWCFwKy0jAexHFO325jbnd1PC0dgt1shGKpKwYTTxtDxFv/5Cdz0DJnDxNv/4NehjKOFrzbG25LnYi8Qs9rut6obYEdEK1nS94WLB3pWF3HNprZwbnDCa+L3FpFtdAygIddm/UO5CuxaYvnVMWa85ZFcKuIK0mebv99/gxX3fI3w7/oimwdrrmC8vUOYKfw5c8dXRog0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7yRHhFC8dqC0HNG4GTCtBUNnB+/Jrxcu0ttfywWZQI=;
 b=mxdP9Bdqm3gD3c4oc/cDthy2U8LiaVrpNm4+G3ytqkZq53ZkNG+uy3HyWAzRo8fsu17wXH8EfGDFKCEI+iTQv7ZJdb72ecKrR0s+F27LQk19iWHj4vxE1fsC8wFWmXlUxUSixCsO8oEGcXxaoLiuf24ZI02GhlMrFfWSCeEbUlP6+rtTh1u1AxaP6pA8bpsKHItWesqSy3SPx3eONu4SyuZnB2mr3cz8jmOhnKs+aFoQ6wdtWnk8uzXMp9jkf6UPsFlV/LQK7tkPJYSP95BsV3EVHoRYTzBOAsnOVUQAREvvKD6OhZa266DnfHNe+Q/L46Bn5zoTyTimCArNj308Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7yRHhFC8dqC0HNG4GTCtBUNnB+/Jrxcu0ttfywWZQI=;
 b=ILYqc/DgV2MyElWpNWRzHHlgLWzsSfIsJ5Wyep6B3VuJrApqsekcXeRP7vkUozZ6b+ivb9bNOAwm8IKcK4599eOJJYZmvdHq7er9lXvC23Bl7GZ2IBJC47GrY0Su9IFGNlfuc7KpCkBbJUi2Mzc3dpM7ychz28DWXx/J9mNkxFVURpYh6NJ5Xj+fM8rGa5o/NrMnOGiFLgBhW6okJdmvILJ5q0G6/vN/JxjA9kruhnYost7iBsqSugBjoSmA1NDESHb6RKsDVQBV0xyfAIup1/aDZq130fWX/uDO4IBDmndKprSrdSU0u5dP6scvVX27hft9aS5urlZY606scobP/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5551.apcprd06.prod.outlook.com (2603:1096:820:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 12:27:05 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 12:27:05 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Krzysztof Halasa <khalasa@piap.pl>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] soc: ixp4xx/npe: Use devm_platform_get_and_ioremap_resource()
Date:   Wed,  5 Jul 2023 20:26:44 +0800
Message-Id: <20230705122644.32236-6-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230705122644.32236-1-frank.li@vivo.com>
References: <20230705122644.32236-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB5551:EE_
X-MS-Office365-Filtering-Correlation-Id: f270f739-a8c1-450f-95a6-08db7d532464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y52+RY0Ln1uTktqleOY04dzpeP4GflXp1Di78lykD4nNj7MN4TcToaXwrbdcmEWCP1wLCaFPnK4uhTsFBvcxX/+6qMySVKIi9A2FU8uFXb58JI+h6ekpd4eKZz6oK+DcR9tvx9TFwvxl2co6P+g/gwfLlvF6Gjk6bB/oFq3gtTv/4dMax89JRlOvH3drzWGE1Dy6WCeJNcpgBJ7d/qtuxB3guNgicc4Hh4czFceKaJW4/PIlribTAYEQnjTt/Ok4qWxUemrRKzV5ND/iwzpRV4sP7CeRwoLHJ/Qk5r2IuX8u8C3NqexzhAYBO6EduQrFdt9lhYZf+Nczbyh8n28+HXjIKZQm1/eu9vkH2qmzcjdEV8m1/t/p0o1CK1OC0CCA7cApm2LWljLLxpN8ET2iLC3Cpn+fJHsZIFv8w5R3BWC6nkNNC6SBt8Ii2akaxlylGy9lR1xPA8NEMY1Hz+255QmdILgdsTuDlwdTQ/z0LwgXUl/qUdNlI5D2e9BRvxNMCotPakZKMsw4alZHj8FPdvO3nL11wb+/G1mvs6VRaHJsgp+ERK4nYsTtRU2bC09tlOSl0lRXmVoxU+5WTn4Zi021SyES6UCnff8DETFHIWh9fYrYwcpNY6MhXsvlGfiB/JgKXeoQTYK6e12WIMV/PA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199021)(5660300002)(8936002)(8676002)(41300700001)(316002)(2906002)(83380400001)(2616005)(66476007)(66556008)(6916009)(4326008)(66946007)(6506007)(38350700002)(38100700002)(86362001)(186003)(478600001)(26005)(6666004)(1076003)(6486002)(52116002)(36756003)(6512007)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MBrRsCTa1IH/4srV0nRXBOjJCMmwMWsz+EvqweLZ+z3N8jea9+0YFXio1ieg?=
 =?us-ascii?Q?czxiYQuvyuxQ53JaMva1rDBkbpmum0wr4b0cWkTLESW4c2K919B9IwVDpNOh?=
 =?us-ascii?Q?knUBeHgWJLeHs2D2YfUjLs0E/VqF3SuCCwQsgOUXmhPcmL5rVfUVZKSkjWwj?=
 =?us-ascii?Q?oH2OPLZxvtr1SjXH9vqQ5dT9d1zugXn1IEUVNQlidWe0kYquO5ngQpXcPhpv?=
 =?us-ascii?Q?Q9O+b2skUvzh8r3xyQW7ipnIRuyr0HuOqowrHXa2H89d2HZjCBHw/5AMozsL?=
 =?us-ascii?Q?X2+hnbCH1ESXfQgzOJiTgMCMFkxkQjem4HWLklgadifAwcZwBtsgCSQBWvE9?=
 =?us-ascii?Q?BaBlEdgRBDNWwCWvgmjVdvanfB06JlcgioCx8roMhuDx1S6BW3QCZqgm1AyI?=
 =?us-ascii?Q?jc5rVx6CloRBcgv+uzGMIjWzL5X55gm4RTyUvBNH0YrJJPep0VcNNeuJz4nU?=
 =?us-ascii?Q?pDFdSjd5Ybz+Kbr5NB9zw4bkp6dcAMyjjpzEBZVzEsJcLBa2zrczafDv5+LK?=
 =?us-ascii?Q?SwQRtdbAgA4NUCbMDjO8BoWRQN1ldu3pZP6i4L+lrIyOKzSYYzFrniqmO6By?=
 =?us-ascii?Q?HEcdNg4HuPOSqfgrW1XWapdhN6wMaKkG/p0dT6bHTr9hgwo4Idv9YXK4LqKj?=
 =?us-ascii?Q?LH6fFXYKlQ5ZpcS2ZXxq2TZtYNkuuCD7HdU0EZEwzY2MudH8UytJ8p+zm5L0?=
 =?us-ascii?Q?3TG9jITnxWw+xaqkeJixQYAu0/WL3WzAg2oRRqSTlqx4LjfA5nmfm6QngVFS?=
 =?us-ascii?Q?8ga/jYKtqq/Zc/WHcOY56MvjcDCzj26Vi4wINPz4YkWa4TFJAaHfJAPDYwt4?=
 =?us-ascii?Q?cysp1Op1gQcVkUrGEYWoomGyFcK9BXsj4wCN600Xit0aDh9vwD/OcPf8Jx8o?=
 =?us-ascii?Q?nZwjb1udNV+x23Vosaav5SgofxDbT8sSeEKB/pQ9u2pMmMtm/5DVMBLBsZc7?=
 =?us-ascii?Q?wwT3P8EHyuai/b42QXdVapSbUsJdyw9BWEtQUrFcTMvJITPBw0Z4e5sDTrT4?=
 =?us-ascii?Q?NvDk0x0s9ZHwccrvU7GZAXFJMyLKWGxS0yNrx7jnYg02Avfv5gh7Q8g4yabX?=
 =?us-ascii?Q?Y9cmDaA+HiWFHjiiE0kPWZXQrDSxyUW7mP/Zsq0Qtj2PDM0Alr46PUqGeHLr?=
 =?us-ascii?Q?SZqNDr7xmzdd5S1wcEfPjla6dS8Z28QLEOy/GKgDFY0IXfgjG9wm3fIAGUsS?=
 =?us-ascii?Q?xEj73JmQ0ORiza8gCoZtPFbVD6A+Kv5NTo0SBcccjpvZhU3XiASrxyQZcGij?=
 =?us-ascii?Q?vG9FTb3uHA9TNV70ORC6vZK2BTDZgnUJsZWBcl7igfpJHXHw26HfLdsvSuIa?=
 =?us-ascii?Q?cSyRwm44ya/2GAv+KYmPGHwBu1Z+f6NLhQ3NYNWBMIAVi+E6g6Kd2boD5CFJ?=
 =?us-ascii?Q?N0lqjhnuFHZPK7VvxpMldjUeaOkbGinzdfYqF2yKxE8OMzdMDf1EfqaCi95g?=
 =?us-ascii?Q?45BP8jLSC8UbnKJGNtBEjq2owtRJBHip8f8ejyQDoUz2rWdkW8Rh2ZBOpeNh?=
 =?us-ascii?Q?IKsQzaWYItisD+G2kIkagCieedZH3dBU4KMIEeasaT6sG+LPUy/7dUWpX0Lw?=
 =?us-ascii?Q?lAYhcHLaKilDu5e0n/T1UjsfLAMD45zSiwaZtopR?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f270f739-a8c1-450f-95a6-08db7d532464
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 12:27:05.1610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J28JcNgggsBjR7tHOslkXKzE1luFptYTpuzqLF5ptW62avW9Zh32MBDzN3d74h2RTvUL4SO8FRcEI3jkI6KeYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5551
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
 drivers/soc/ixp4xx/ixp4xx-npe.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/ixp4xx/ixp4xx-npe.c b/drivers/soc/ixp4xx/ixp4xx-npe.c
index 5be9988f30ce..67384031ef97 100644
--- a/drivers/soc/ixp4xx/ixp4xx-npe.c
+++ b/drivers/soc/ixp4xx/ixp4xx-npe.c
@@ -700,9 +700,9 @@ static int ixp4xx_npe_probe(struct platform_device *pdev)
 	for (i = 0; i < NPE_COUNT; i++) {
 		struct npe *npe = &npe_tab[i];
 
-		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
-		if (!res)
-			return -ENODEV;
+		npe->regs = devm_platform_get_and_ioremap_resource(pdev, i, &res);
+		if (IS_ERR(npe->regs))
+			return PTR_ERR(npe->regs);
 
 		val = cpu_ixp4xx_features(rmap);
 
@@ -711,9 +711,6 @@ static int ixp4xx_npe_probe(struct platform_device *pdev)
 				 i, res);
 			continue; /* NPE already disabled or not present */
 		}
-		npe->regs = devm_ioremap_resource(dev, res);
-		if (IS_ERR(npe->regs))
-			return PTR_ERR(npe->regs);
 		npe->rmap = rmap;
 
 		if (npe_reset(npe)) {
-- 
2.39.0

