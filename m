Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22878748494
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjGENEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjGENEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:04:37 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2102.outbound.protection.outlook.com [40.107.215.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031DCE3;
        Wed,  5 Jul 2023 06:04:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsRP8ff67lywLfBG+T5ZDDY+h2CljiS+Ib0A08t8wUR/bQvsjaQhL5QZ+QIRTmcJ+Yc3XMLiYDbmB9gt8sdgbapr24CaQOnnWQvd3aoj9gIc9qRHlgBlbLCfneLZDq3pmgiNwIsUGjBoImjT1/q8rtwGxj5mu8ysA7za0wWpw3fvjJWtoVStyfA3Uo+YNmgRZXOgjSw922LNeAdy+6KUZojHoe3ukyeMI+m3ctkTst5zJL/6aXOjfDw1z8UPOcdGzFKizRoDGkxVN/Mzl3RMbIySMuXfU3R3h+P9oYAF20F3zXqVt2oDMVQi+eV0vAMkV3EAwFfZpLO3BQ9AHuCtCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2vDKdTnYEZ2BkR7gpe8HiidFcsF9ao4hHyBZX9JBic=;
 b=A6ufcOMdqPrkYJ+YyJfqhGHOgyUfeVAZWIsZ624EjFcHmDJTeEeNaHPI6ejCwLEK0rutWVjE7KnGK6RcSFGvuGl2Zsw+gbEEU/nTKh9PIs7/37by4vdIwryBks4T5ZvTtSp4TVJjCneS/Y4IURuElU/ikBzWjUiRhdmjsnEn8nlMZjb9Zbp6y7Y5IwhKgwTxCxQbKzDKMwP5YedHc3nq1CjdifVqL45hw2ENwufZxpCaMpkNEyUqI9MVYWOhJuHhBujV0yItsJV9MEfc97UIs0PoJlxD4TcXJFterJ81AOsn6xKwM2G6uGWdH/OV5xwoBGBDK5W6cFYZaC8t5Jkigg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2vDKdTnYEZ2BkR7gpe8HiidFcsF9ao4hHyBZX9JBic=;
 b=C4SgY0ePnzHpVPIKcLrIwFdLEIDZB4G50b2gFAW+i5s40JosCvHq/yb8nVdCo2EoF3tZTcUhN7CfaR6hNExgVsnusn8hZ042SdYqHqcqeXtm4fQX7YNfOLdOVDA+RTE7P+Dp9VEV173Zn0OmTgBWTu/G2U5wMz2KAYVx3pWNCTKMt60IplVvla2Rnevl+wqWBRDfYfLyidEaUTA2BRd6k8HRVQZKPcDRvAsobhagn2uBqCBjhhsuxhiNBzzoFxpCAsX4YuPIu58BMReTgv/DNIrofsZGBHB37FGy/DBVQdKYShC2PEtzgQFTcKGxQqqCVK1x7VJ71F5E1WP5Tbv1Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5891.apcprd06.prod.outlook.com (2603:1096:101:d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 13:04:31 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 13:04:31 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] iommu/msm: do some cleanup
Date:   Wed,  5 Jul 2023 21:04:13 +0800
Message-Id: <20230705130416.46710-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230705130416.46710-1-frank.li@vivo.com>
References: <20230705130416.46710-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5891:EE_
X-MS-Office365-Filtering-Correlation-Id: 1070cd5f-4988-488a-7464-08db7d585f5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nqOmhLZe1CiQ9ZIFG1ZlOZjtBhiot6PcGs8zqcZZXRIJK0gjfiwBtzkBJCVAD9BziHih8kOEpRqhDvKYCnoF4zEPILx+ZTPlmMVw/o6ouPUlsSzgImK4p3mv+SFWaTSucCwwSXba2lcZ83n7xzZvEFSqPmC+8v4VzPcxEA1I7CfnrOHvsL3vRT9Bvb95JifdmwgOln0ckmVuTeAlV8o6lp4whuVN6eLJ99VrELE+OzbI27P18EtKOZjSkZVWMJgW7p41FPfAek2RK1M2Rgp81fBphN84F7qeEwx6WKFw+qOec2FppvOrbYo2YV8w2nRTC3+xAK4KYC+Al5OBP9ltxJIHWrzsGmKp4IE+IyousrfpR7Zsl4fiMww5oW+yp9vcMTOOQN8zrY7hDdU2h9L22a2VD8lWZJFvhIleRhQRmeHOQij+U+adimG6ts3VUMLVzGGBuAG3PQ7cFEX3YgsGy5Nov2a+u3PCP6x0lsUneADgWv4fOVNVf3R9lAEudecOQ2b88KtQMiK6eUG5Oy4/8jZ27Iv6ozpiLZvh/Bvj0qa62knMOyzrtTOLDuYtzlWF41aDDpQzGJTXCAF/qSYegPM53Jl/a0+HVuZ2s+0+al7scKCA3I7QXDm7Kefik+wp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199021)(478600001)(52116002)(6486002)(6666004)(110136005)(66946007)(186003)(6506007)(1076003)(26005)(6512007)(66556008)(2906002)(41300700001)(4326008)(66476007)(316002)(5660300002)(8936002)(8676002)(38100700002)(38350700002)(86362001)(36756003)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pIYm9A7JBM8BC/Mv+30WTXXq5+3g5Erajf/fgcvaqBAqzioWgWNKkztSHQ29?=
 =?us-ascii?Q?FszaXf9Du76hIREw20bo3lgDctB2goGaCNYypSpn27Bn1caYvEdVUJFxKUqZ?=
 =?us-ascii?Q?v5WhvZvfDoIu41ArEgunosWmyIV9JTrq/LzP6201zJXzPByAO6LDUO2Qha2z?=
 =?us-ascii?Q?Cg2HhViqcpz8eArkf+D4XvlL9VoY8ZTRoJVG9rlmHtK8FAFWkpPILpJIQGFz?=
 =?us-ascii?Q?m5k/T2OK8OtQI8mYW/2j1RxlSpYYlogcqjVTnFoQXpEoCpqKHhMRB8Rz/R3Q?=
 =?us-ascii?Q?yqQr4nwgM8FKJrjcl50zMYkI/kP+bfulViMvpOcjB5sKEvMhgHM4xi9Q3UE1?=
 =?us-ascii?Q?9Q8b2U3uglQoOTB6Kp4XJMKqwuOKxJvH/EXThZnaFkYTSbOyJt58EYecmJVk?=
 =?us-ascii?Q?2l56cNx2+WNvQmCedlt4WSq9VZM5PXhuuh6TZY0QNmKFN604h5vbp7HCYCYY?=
 =?us-ascii?Q?We5r2I63JlO8bdeIJLtrCMjJZlaTr0p1maZYE3jBMt4KOIpcFpoJwpQbTfOM?=
 =?us-ascii?Q?CFIlomS1GLXkXehim/perDcinPvjah7XoKU75MQhtUCX29a5zzzSpBfhJ5qQ?=
 =?us-ascii?Q?nq2QXjRn/jpgAt3Ay4cVTlV4dkqzLhbBbEIpbouAbFoedg0hMK9ROPfl6olO?=
 =?us-ascii?Q?NnwMf+QMK0T9qYc5sAZNDrG4cMiisaCkDhpT9nHDv4c570Xif82se4+cg5VA?=
 =?us-ascii?Q?svwxOcomy6kEFBjBj9SDRTsHXu8K/++Yy8LChEMvPY3Erhk77YKHEmpy/gi5?=
 =?us-ascii?Q?x1MqNNu6DZi+JZfqw/XOmIeZ3CJpxF0p3XUJrTuBeQPY/yAFuMUZRQJ8TX7e?=
 =?us-ascii?Q?eHp8oU2Vv0hov5cL6njvoO3bPqQ7iR6cD11w8qYT3t9DvZToa/YnbOlUfima?=
 =?us-ascii?Q?HZd5WUuXxdsNwPoaV4fYzQh0ePgZJYfLln6mGB/wHDdjgW+COHkWM8RrhtLy?=
 =?us-ascii?Q?xxK1uijZmeGagZQpEJlbLihGLqYoh/QIxNKwMemrnIixlKglP18IrIzkXQ3m?=
 =?us-ascii?Q?cTGuPF42SjaGtUxi/Jl8EUAOWgccAp83EBcYsBtHNT807oLbdchBM7dIgjzf?=
 =?us-ascii?Q?QkGa92jbMBUnaefJdgKldEqyDZUoeecbsXvp5ZnqP+MC3Gr7Ay8BNzkZBn5B?=
 =?us-ascii?Q?g6KOr187eUxLDdEvq8BiS2lF993RdcLv2hD1ygepQ0mnjRKa7vBi/zx2TSTh?=
 =?us-ascii?Q?utSSiRbJW9O0nczU+lulYO/m5d9nreNdDN2p6keIcFj2ROHTFDT7nEeu7MRy?=
 =?us-ascii?Q?H/XwOPPsRN+LkrwOOrHY83QH/4i7ID1cgDGo3LnEH7RB1EzHdpTEt5jCyu9c?=
 =?us-ascii?Q?Uc2QYfBHof5vpuMdE7SCminY8Of3tzey/zYcoIkaApxpKHXhUzaRktUZUjdL?=
 =?us-ascii?Q?4fPSR9miLguRE4DfxEK1RsqgKs8EV85b30xF4ZRgBP+MSEmZ2HJX8BdqZblw?=
 =?us-ascii?Q?99Mzo0GzeFukGOKt8f7/0outtif4y7MCYkasQRWgAZZvsJgOPllL3E1FX17f?=
 =?us-ascii?Q?6g1dRo+O8bhVTJzizAa8SF9KMJ63tknmP1IPOsOjiPcFN24ixm/xb56n6Lqf?=
 =?us-ascii?Q?gSGzZ2bzFrFsNKfqHIs7fgrE+7lnFcHAea9cdSEu?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1070cd5f-4988-488a-7464-08db7d585f5f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 13:04:31.5840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jvuy1nYgDe9VEGZ7Z5FfJaDK7LBZh283gZxMoG8eSYbkhz1RCHvg8P7dm1UIutw9TB9ULIbNSYH13B7N9OUejw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5891
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to devm_platform_get_and_ioremap_resource(), remove redundant msg
and fix return value when platform_get_irq fails.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/iommu/msm_iommu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 79d89bad5132..349b46b4b714 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -735,17 +735,16 @@ static int msm_iommu_probe(struct platform_device *pdev)
 		return dev_err_probe(iommu->dev, ret, "could not prepare iommu_clk\n");
 	}
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	iommu->base = devm_ioremap_resource(iommu->dev, r);
+	iommu->base = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
 	if (IS_ERR(iommu->base)) {
-		ret = dev_err_probe(iommu->dev, PTR_ERR(iommu->base), "could not get iommu base\n");
+		ret = PTR_ERR(iommu->base);
 		goto fail;
 	}
 	ioaddr = r->start;
 
 	iommu->irq = platform_get_irq(pdev, 0);
 	if (iommu->irq < 0) {
-		ret = -ENODEV;
+		ret = iommu->irq;
 		goto fail;
 	}
 
-- 
2.39.0

