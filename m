Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE36F74A9AE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 06:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjGGEHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 00:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjGGEGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 00:06:52 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2136.outbound.protection.outlook.com [40.107.117.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA421FE5
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 21:06:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdhbN3fS2E5q6N5XFW5tNpxBzsAVlVVaDDeUOMN5Lh9u4diqSnl74RyDz/8+JPNNqsdIGYEFAlrla0amD+2OXubfLidNbHIphwTlBKF8L8mvGmpyGv8DobKFlkZcO1uXlIslYfTPXX7vzFDhBtgV0lf8cgB7mSR1ieFo0x8tvumZHx9BwwC2b2Joz7qyLSNfNW2jJm5CCJ+m5Chae1Gz2AZVsKfEjZXn7EeYuzpanOu65VINlf3DA+1xfVaO5iIEGipQnkbKZDI5RvmpPPUyaMLsqYPKtAEblEKYy4XSGr0d75Vvd7c7VqrAXL8BQTH2c+ozmr2KMH0psi87x4dy6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgm7eE2bmKEI5fpeOmzp4sqjc2lZD0DlhNw0jAUyOzI=;
 b=NrXjW1ShELyOlghPggHOn2cpSrXnM2AdlMyPScXiUefY83ucZsDEP+RaddgMpMtudSH896um9yKVEGWnNBIA3rREQxXPGkTjAzhrHQTVjCT/gUPjjvApctr3BQ1Vn1D03z07ybvdf5wiXrvNS80HhAqTWvpVhYiWZUrldzlK/hMa1ZekeW1X/hUcsmLpI6u46NjzD48CJqLZVrHTqJjGb2nhzTBMJ2zE0UHet3e+eH+vJm0z0kvRNaFpkmHhR4ejOy0LtCj7fRnJJeEOHP98XKDewTMyO4yNZglHsUmI45OcfOebyYrfbKOfLvjZvC6b4AU5IK+w4RpjWw0Pqm7FvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgm7eE2bmKEI5fpeOmzp4sqjc2lZD0DlhNw0jAUyOzI=;
 b=R7lFxEbBuTCjdyuYXzSPThVlDoXzcQQchCxW1Q+ZyEc8UTyvb7cTvQuK1Qve0nr6gqQIzV5CiQ0hZlHrm3h+MJKvbNiR0Xww3sade/fz494lDoNzR4ddcDGU1Qo+dyq8oWShkP1mB7tZTg/g3f0yQi+qvYiPA8Z3JA0gwtkXJ/Jn22JKnLNGgdBUTvf/+JIkzBNl36dHmIBHp9OD27bCMZAlPsFwboB0J9AxNfpLv//fKKBNbwIQYxG40Pk9GxnGuqMfSoIOTiB93EN45qaZPlVinx13k1qxOW/QnbUx2BkkZSAYx1hGM0uWITqZBnJw7GyQsFDaWrpKHmFVRyGk1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5470.apcprd06.prod.outlook.com (2603:1096:400:264::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 04:06:46 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 04:06:46 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vladimir Zapolskiy <vz@mleia.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/18] mtd: rawnand: lpc32xx_mlc: Use devm_platform_get_and_ioremap_resource()
Date:   Fri,  7 Jul 2023 12:06:11 +0800
Message-Id: <20230707040622.78174-7-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230707040622.78174-1-frank.li@vivo.com>
References: <20230707040622.78174-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0112.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::16) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5470:EE_
X-MS-Office365-Filtering-Correlation-Id: 615bddec-fd8e-4f6a-4865-08db7e9f94cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NLSpasnDCy2t3lQ8+0S8/w2PHH+UjcNH1dT+HwaEbm2gUSMjtwc0WW068wkUAY+3KrpZfw+aWvrFo5lJMGdL9RxFgZalOq3/LQVHCLcZRSSfxPnp2bF8fTcxv6w1JfyBIdyV85MqnA6Ya8dj/jcrSHTzcKZQVPn2VdAf7oZIbV4WxkcIpYcSwraaDzBw1ITaFVRypi2cKQica4T025pDU0yaAwgurAK6ceOb45QOGvO+h8QVQqvlT75UprM1PVx0b94fB9SN+ZUHxIOIX9rC8niB8LHUjn9uztEVdSj/ln0aQ6i6NPut2fPjaLWV8dLPzgEtZLupyL/RIwVMbiPoelkWqxGMG6qcPs2kqnIkOMNWvA/K19eULr0asO1ttnr263WYuAIfB+D+G/zLV8B21lH+cHnhvByBDa4dmDjfVD4NSTSY/5/h2vbo9Qhe9O3l+tLcJQ+nWdLGghK5tOZ7OTKSqwsk6I0D9QraP2jHGiH/rIe9As0rXNCAADh03SJIS30iT//2AM3N9o9WRxI1U12Q18KFtqdIqrdtE3cAcp0KclT40sl5/mQ08wmPK5LN+UmK0N3avHyCEzMFOYQaneh4brXUoNz73N/+HaxqaYEsx8Ox3skvEyAi4LX1SSsW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199021)(478600001)(6486002)(52116002)(6666004)(110136005)(26005)(186003)(6506007)(1076003)(6512007)(2906002)(4744005)(316002)(4326008)(41300700001)(66946007)(66476007)(8936002)(5660300002)(8676002)(66556008)(38350700002)(38100700002)(86362001)(36756003)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D8SnOpo4kQqf0aNCirXSU7R5dniL1myJIYG/sxzgvuxKfx/qPTBokbb2Y6Pe?=
 =?us-ascii?Q?Cqp0wtxjd5Q0EPaAQEBytqTGLjGqz+TuZNR4H1TMj54/CRu88uqOFw2duwmX?=
 =?us-ascii?Q?gH7dPcsfti83CIATtoXnmjNY3+7UgN+2FNrr2NOGUiJj4trsecez774UUg2S?=
 =?us-ascii?Q?ax0WlEguPMue9sUzXoN+2PpCbtLmegUtV5dKByniTyektIGeu4nChKZQ/UKY?=
 =?us-ascii?Q?ydpq4NccvK5FWa13+m8z6DwEZyDa4CJoOI4gjNQjBGP7wlBDcquH8jt31dZV?=
 =?us-ascii?Q?hZyzLz+5uXeOWjAeEo7gu6NH/LRlsL89MEcZOaV6XWjOEYw9kNtFok5xbcrY?=
 =?us-ascii?Q?Df8NbzyP0P2OrBpWi2d7WMI5tcKFsAo/8ZJ8q9NkHrDYACxQoah7cAlGCocc?=
 =?us-ascii?Q?CR2stJ2pY76MWuAKlxd6pM9oTAttCBnbRYXttWlyofv36CqSI5XIJQ8nUXZp?=
 =?us-ascii?Q?XHy+Hz5QdI3EdWfqOFjw+CsoAxX5lNmOyMjB8wv8gB9kfupe5KOdE/fZKyFF?=
 =?us-ascii?Q?TfcbstVo5WzOIbZXjXWEC1b8va3GkO1rnMvzPBXzKJK5orKxZUKsOmQq4eqQ?=
 =?us-ascii?Q?mqaEKkTkoPdT52vPb0jeJ9BM/xaqbDR+Q9JDBNCyMR/mdlDrNBFMyli2SdNu?=
 =?us-ascii?Q?KfFkS9OPEzrCkfIEGR1IXHES66ss9ByysTIPyzLigM4nUK6wQeiKIxlaAoun?=
 =?us-ascii?Q?UTwaFqA0DiDVagm1qUrld4MghQVOlkz6Saf4uxgZRAfDv98nlRhJTeJqnaOl?=
 =?us-ascii?Q?So2HaMHX8yRcGyDzTn9eiIM8MsuU7awYZIhU91OQ3qq/S/hK/K5JZ9hdCAwv?=
 =?us-ascii?Q?DDwt+/nAnzwfTvCOEa7Q8sb53t1QUbRuZLLrEKvK9QLHwZ+HCowkQW2nrcWF?=
 =?us-ascii?Q?iubsaL0vXzCjS4XX0GkEi7pd6q3eZ+6l8anPt4IlhlAJVGS6AMsYI6pCQ6+2?=
 =?us-ascii?Q?K2gRbU7wHTL/OHGeF6KrqHHJ1o46OLZJPvaTukPkU4cH1vylJdykCIPL/RsJ?=
 =?us-ascii?Q?z508KzJ5SRIY4q+U75trDvARwTHLpdKYogJs7t6LjRfkNi2laUKmQVsl8C7A?=
 =?us-ascii?Q?xG2sEdzhlmK9TDCDClChIy7V9tg3xxw66cn7JeULrk/4l24Jv5abHzOf0+cH?=
 =?us-ascii?Q?aa/yTxq457T/KcR8BTe9Ejt3fnYWZ1EckPP3F8pUPeoKqBejC1u6L0ugxIVB?=
 =?us-ascii?Q?lnhfhweI19LfZHwgU9rcbi9cvzCDN3eUHMgtlAGJGvi6Nh8v7WtefkERVx9C?=
 =?us-ascii?Q?lV2NHv/rabYpM0jGC2vWb3iGNFA3pZ7I49S6ofLqs8CSzvSB2hOnfUKm9Lzz?=
 =?us-ascii?Q?oEc+YclRszb4XR0t+2gJa7JSgpZ5dRMyMYd0CmP5yJg3Yv18LcB57fcvwBAz?=
 =?us-ascii?Q?eHWap7UZsxomSragooeeC7PGXxUs+MQYfoBqU9jt9RFkWOs8UcR2YAIqXpU1?=
 =?us-ascii?Q?z5EcUU+4XpcSyrpQLjiE+bw0JYu8MKcrXF2EcPnD3brXomZ3UeCr+PEU5A4Q?=
 =?us-ascii?Q?Y31qbxUob46OORE1Ipfd0Gh2inX6yW7fFfTnOKv4BXzH9JdjE6OTaxm5Az6g?=
 =?us-ascii?Q?ALuloEVpqG585rYYMT0xHu92kVARlpnJ8tQQXpxF?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 615bddec-fd8e-4f6a-4865-08db7e9f94cc
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 04:06:46.7237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zeZuty42X5GDQMdNttLnt6NU5nrllTEUUOuRGsQp+m5jQPGKF1cDPd/75P53MJxrqDekrE+jGxFRqvu0lEeO3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5470
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
 drivers/mtd/nand/raw/lpc32xx_mlc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/lpc32xx_mlc.c b/drivers/mtd/nand/raw/lpc32xx_mlc.c
index b3136ae6f4e9..488fd452611a 100644
--- a/drivers/mtd/nand/raw/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_mlc.c
@@ -695,8 +695,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 
 	host->pdev = pdev;
 
-	rc = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	host->io_base = devm_ioremap_resource(&pdev->dev, rc);
+	host->io_base = devm_platform_get_and_ioremap_resource(pdev, 0, &rc);
 	if (IS_ERR(host->io_base))
 		return PTR_ERR(host->io_base);
 
-- 
2.39.0

