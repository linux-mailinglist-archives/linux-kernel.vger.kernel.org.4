Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33ED749644
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 09:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbjGFHVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 03:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbjGFHVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 03:21:09 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20701.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::701])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD1C1BD8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 00:21:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BshNQez/YrUwvJ7TPi6FShD81moIvimwCKFs3gTA9GoyHSaGpn5lIRmkaQ35FE9/4N1XkJAjHNdfG8xCx9rmKHr6NOc+T/U9/zK14zxc6uC0Qwk7XhnVGD3IWEBHjpD99fOrrdaPTgL+ukAjnssFWSAWvyc2JWmuGrPL3gWurVh2Awu3WhmDFrgei+mEVabqrrsUpvAGaIqpvP2TnQb/Z+++QwszNkZZ+jNEypIXqlwDJEI8s8MsnAonZc7ByD9UixwyrhDFqls6zJJM/yc4LDerJPJe8evWYNuDUJ3HsD1MBDQ88g9hL7aOwigLFneXjNxKrvKDyVHjTg4dr+Rtiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mn7Y8gyS6DbcWaU+KLaEu1BvTCoBv5ZPUTUyLt0Kcnc=;
 b=FuY00302zgRYRpOf2pzwQ7YCyVHa1JQLmj9iUSRqMOF4ajy5wzCZaDDezCGLrcQMBnhtmCMHjm5/7bjA+5+wm0rW89GF/Ve6IV8bSl7EUbCT2jfWtsELDjUXp1/9ctJnetTN8QXBCschq6QGKFlecNkmB84lLJFbEL0kke7CNe9EtQxCM/P5wwAVFSdfZP2qo+3kS5F4oYakGVKMJHg0zxokHNcWlldsw4Py+HPo9fxWjVov70r8GD1paoEL9Lhl1Yv398eZI9/nxugNpxQoURhTn28AFTB42YlNnG5bXjKDMvDMV6iaSWWsMFxbUT18sau3LWBN/rcvE3FMepF+6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mn7Y8gyS6DbcWaU+KLaEu1BvTCoBv5ZPUTUyLt0Kcnc=;
 b=GRomqLsSzlYmU2RfUwTTPH4uFawfZkYw3e6Gb6IzWhv6MUl4eMBycGmTmTcPFfQXzrkAlc4Z0pbjQXmirjIVukV05VDuo/nNDSCSpuTA0JcPhRqHhtisNV2WezQ3mjpJ9c4q0kWDlw475IQqdK8pLJ48XeJyRLZrv4ia2bGmjFz1B8bAbVKTjXY2Fzmk/fBjxQV1Tq2u7gMVap87UIygHbycUFEMsChiLQ4Ba98fQV2CoSo46cA6wZ6uKYCUwdo5iZsBqiG0QXrWgIC+gV+StSlu3nJvWxPN8cO9F9g2OULGOkNSU4iTPjtlOHn8m7hEgToH9q5Du2z4H4DjLeCa0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6081.apcprd06.prod.outlook.com (2603:1096:101:d6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 07:21:05 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 07:21:05 +0000
From:   Yangtao Li <frank.li@vivo.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] bus: omap_l3_noc: Convert to devm_platform_ioremap_resource()
Date:   Thu,  6 Jul 2023 15:20:42 +0800
Message-Id: <20230706072042.31296-7-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706072042.31296-1-frank.li@vivo.com>
References: <20230706072042.31296-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:4:188::19) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e3fd2dc-2e9c-4596-2cb5-08db7df18f12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ChZhd8/Z/ohA90dfzj9aNqizE8X3qn0/aOY1e+9vDW50F90Qc9COMM2aDpAjo+MV67o1RwC2nDtZXP/EO4NQ7Yk99sndOwyKKSkJCwEyKcg0uG++bArAdbLRQ5dWUzwCafSUzoIql2X1Lr3rz47f8A8T+ZUuNhrZMqYX5wJUuUTmxkEW/BJ1MefC4jEbrXh8OJVz1Am/1W3xqTBiiTni4MgERz07ampk7pZa23z8ykst+3fk14uiMYQD1Iagv8yX/+7UjS3my0J1wOV/lMmwidCsIiE65Dxluqsa4vMQ+H7OwuWDHCn5a/vsxR2n/ZThGyAaexWTLtP/+0zrtr9Z1g+/sovQ+V0sDil/PnPAJ6LzDJqO10WXzRJ+5ohpXRfOHvsVJbLokP7fsKOvjtNjXdh1dKWojjGfmP/fY2NSs2cJTYJMp8of3vYMaSiB/Yg3LHnL6XNhvp8Fy0awuQOur9VSPSpaYBnd1eP+rWWOpCP6022vZscxbpPo4XnULs6Ly3oSEK4/ytH99drB1b5zrWKqigU827CXSt5dfrI+u6CcYV3DNHgk9uAhLr7laIQZly1LHqHYPs3r9gwd/soNKPymRLKzHclZ64VlzQkCxOTGuUFNn/r88D0RrsWfBE0eafDPk7TcuODdNqdXyEzs+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(109986019)(451199021)(38100700002)(478600001)(66476007)(66946007)(52116002)(6486002)(2616005)(6666004)(66556008)(41300700001)(8676002)(8936002)(38350700002)(316002)(4326008)(186003)(83380400001)(6512007)(6506007)(1076003)(26005)(86362001)(5660300002)(2906002)(36756003)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PM+kpL6+hu6Kzx3qs3TUGueBiL/kRq+A5i9uL773SI6Z8Z1561FxwdP2N/bX?=
 =?us-ascii?Q?BCWO2Yt5s7LPsjfMYvl+OfCQPFsvJFXZsHHS1lya0s7WRBBPvfKlrMDiV2aS?=
 =?us-ascii?Q?SGd43GTwLGhLtk2ITYwn7iEz9juUBMBt0JRPnqcyk4oVNnV6VVb1YkEnfe2V?=
 =?us-ascii?Q?3sXIrdJYjpCMCh8IXb7tS7b2P5uXPDKSjGqLFZHhT/YNPXw6jOOfvrM577kM?=
 =?us-ascii?Q?1yyKpt0/Te4ZM/xBQtJpGBtJR7JtJtKWm8VMv5WUAL+CJAzfBQ3HvmnJU5+A?=
 =?us-ascii?Q?xW/ty3Yn84EfhBMUJz7HJB5+VReKA25YCoKqOFDs/csulMO/AwwmzSpHLW2D?=
 =?us-ascii?Q?gR6cNZD5Se/zLEbCiUnL+hcL4KarhMY7G0zcG5GZzBxrTjpKz/Dj0i3C4I1i?=
 =?us-ascii?Q?OJWczuItipixVjGWk6IBRv1cX8echukUy6HbmJaxczBl71t71HrPlbejv+FC?=
 =?us-ascii?Q?1Zd9o9b+U2B9exGhdpAWy46Ys1tbhO50t4U3nd5/ZG3K0d/UZruuiYY2yzCu?=
 =?us-ascii?Q?eGOpKL09ehnIQ9Wgs9yCuXnSs45LLpOtplNtnq9UeGDL8AkRxTcWFzp6OrB1?=
 =?us-ascii?Q?eSTzB20x1a2nAlh7/brE+RSrdlrUgWnySCUZvj4Yfd7f93smx6jlxOX0hclF?=
 =?us-ascii?Q?r+zK0n7X1LPdK0orjzRFjo64fahDUsE0Oseb8zSnUDTfpPce2ZGIp50wj/wZ?=
 =?us-ascii?Q?+NcXwcL1I/Hn/FbZ4WGfye2wNPC/UpHlFM/UZmphgWavmMj6YNXx9knU/cJL?=
 =?us-ascii?Q?U6Q/vHljHSHzGXEzh04+x3RzVyz7dOGSGzTkOdHKfp7psqVO+oG6OSOpty1I?=
 =?us-ascii?Q?gKBzmXxyWWNsAx/h+nYcE4fvcwACFZyCMj0B1cSkIzoaWIHKi4evs3l2HU+o?=
 =?us-ascii?Q?11Ri+oWZy6/3ZHZjmaDmZ/fIVXDup2/964T7T1XHJ92ZDkmaf6k7B8e2YOIG?=
 =?us-ascii?Q?YmxFH1Ddp2YABqNzxbO2loSyZsubOzxg1btV8uQcej4Rt0oYHKl1YY/6+/HO?=
 =?us-ascii?Q?z3PCqU4HTnlHeJ+1zZmQ+i+EZAMYZwXZ9AKhL6baoxooRIvQ0T4B3m5VyoTW?=
 =?us-ascii?Q?Q713ekOgtWL/z+1zSsX/PpRyZxbht6npbjWZbKJde3cNMrnOOvsyARUXQMxu?=
 =?us-ascii?Q?MPs+fkh5XjTbFTch/W6FVjYpu7bZseLZZes1TIE2veBb+MEvlY0MHeLu+rYr?=
 =?us-ascii?Q?Z4u2olSIBg/BeNpR8yujeXfN3/JZb0QbAwbSLoK9wSmK3PmDdJ8t2nKxQ8Mj?=
 =?us-ascii?Q?tEd5j8IjipLDnk/Km3b9ZPQCmVQjF9LBg3wLyBJ388iKE5iaAxjRy26xXmw3?=
 =?us-ascii?Q?GTS+KSnHHYIMgEuq/Bouqi+6aBkJkmstV7IQdXSJow+syNG+r+lHTkP5Gqj1?=
 =?us-ascii?Q?v31i8yF8HXYuGy5As+3jjWu+uoOl34zb2wedwwPkaeuKDoTkzuBxjAMlyEEN?=
 =?us-ascii?Q?jDjaV0NJfXJjNPlEMazZ92aLwW4+XcjxNCpSonOvDO9oHS+wi2W4R6O/A4LC?=
 =?us-ascii?Q?V6az0IutfABkMOBB34N1wro/dOZkF0XbhkKoz54kGL13NA/XoVZ+gmq6RnyT?=
 =?us-ascii?Q?BUKQhSJcRgDhGgAnwtgfC1XHSp3beEauAYg8vXuD?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3fd2dc-2e9c-4596-2cb5-08db7df18f12
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 07:21:04.6184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bEjhmilCXQJ8aqtuePpEkC4R/CKJnTEj50/wBrJIrnphQjljKsne+WxfDbJgGZgOH3hSG8ei74TvPVeus+zStQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/bus/omap_l3_noc.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
index eb1ba6319fda..0137e9ec577a 100644
--- a/drivers/bus/omap_l3_noc.c
+++ b/drivers/bus/omap_l3_noc.c
@@ -255,20 +255,15 @@ static int omap_l3_probe(struct platform_device *pdev)
 
 	/* Get mem resources */
 	for (i = 0, res_idx = 0; i < l3->num_modules; i++) {
-		struct resource	*res;
-
 		if (l3->l3_base[i] == L3_BASE_IS_SUBMODULE) {
 			/* First entry cannot be submodule */
 			BUG_ON(i == 0);
 			l3->l3_base[i] = l3->l3_base[i - 1];
 			continue;
 		}
-		res = platform_get_resource(pdev, IORESOURCE_MEM, res_idx);
-		l3->l3_base[i] = devm_ioremap_resource(&pdev->dev, res);
-		if (IS_ERR(l3->l3_base[i])) {
-			dev_err(l3->dev, "ioremap %d failed\n", i);
+		l3->l3_base[i] = devm_platform_ioremap_resource(pdev, res_idx);
+		if (IS_ERR(l3->l3_base[i]))
 			return PTR_ERR(l3->l3_base[i]);
-		}
 		res_idx++;
 	}
 
-- 
2.39.0

