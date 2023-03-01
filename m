Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDF76A6CB5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 14:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjCANA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 08:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjCANAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 08:00:15 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2051.outbound.protection.outlook.com [40.107.105.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06283E0A8
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 05:00:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grpRgph0de6/JdKuc+nyugSJega/mY2nUsYPtxciGet7CCaXRVTkxZ5jMgbAn5B5ghof7PYZOZWaiOq4yIHMviOsqM8LySfifak6YIy9tKE7TjGsQKiqy98SZ8seEgMq/ax7od8cCEYsBgAQ95e1GeIC8tmc5NlXsn5HpJ+PskXo0yo+xsEeVAF49xEtWbjbgBFuysVQW9NLSvR+zwb9NXY6owg0mleIHZHJqzDs2nY9qh2xigwcFh+JgRmfroZkt516xAGLgXFiL0Yb+aUBzVfhEgf3m60Iwdmn+hJV/0m7Lntzwg0XfTN0Npp8I29P+ee71X6AnXFeb/MFavEb5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcHJ4G6Sm+H9d36x+KMUCrhEZPsqWkoZ1Fii3amcth8=;
 b=GNAeo9FZgDLRADGycnpUMSuY5ifWOom/EuYZ7QixBKSVrTRiz0lzP5k4wugsRZBoiig1YAu2V4L8GUiYsMqSDJRXeSXfwior1bf3m/LhiT1FOtZKyb2ZAdinanipP/q5VBqDW9WpD52Z08lvjCXAaLabUp1eXvx3P7QICAWFTDrYxwaYI/kzGCcab3tqTn2Nru5xlzCnaNDK9WQCaLvL/H1ZfyiaQGIYbowQ5Vni/ttTxPePACCriaPrnOgv9KbJan4vhg/LOeG1YdEnF4uXMgJBsAUCOHsK0w9vpym0LoWFJWIAaAkXLKFVW9SX3FJALf9t7lvbv6KKUQd2rT66cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcHJ4G6Sm+H9d36x+KMUCrhEZPsqWkoZ1Fii3amcth8=;
 b=lCrfx/bEVqI/5Ql25gR+mU7n3iznmG1lCG8kLz3zYaB7WYnil2W61lCN69l/C7eSRwJwH6+U8N1ybbpn9dTx/bSJ4diF7pbBmmbGoHa/+tUR7ftDIIZ3Mm0Qv0sT0sSMjLUVIykGzpaLCXSNl6VB0NcksAFUlQvHeu2TB1VhSDI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com (2603:10a6:150:27::9)
 by AS1PR04MB9335.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.20; Wed, 1 Mar
 2023 12:59:37 +0000
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36]) by GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36%6]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 12:59:37 +0000
From:   Jindong Yue <jindong.yue@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, l.stach@pengutronix.de,
        peng.fan@nxp.com, linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, m.felsch@pengutronix.de,
        jindong.yue@nxp.com
Subject: [PATCH v3 4/7] soc: imx: imx8m-blk-ctrl: Use dev_pm_domain_attach_by_name
Date:   Wed,  1 Mar 2023 21:05:54 +0800
Message-Id: <20230301130557.3949285-5-jindong.yue@nxp.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20230301130557.3949285-1-jindong.yue@nxp.com>
References: <20230301130557.3949285-1-jindong.yue@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To GV1PR04MB9183.eurprd04.prod.outlook.com
 (2603:10a6:150:27::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9183:EE_|AS1PR04MB9335:EE_
X-MS-Office365-Filtering-Correlation-Id: ccf256e0-c67e-4dd6-95f5-08db1a54cf7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3hFVZS9HxcLvBs4lQ20i/xL5qhQM7S+y1wh+DhWmszXqAQsHB3UBWQIihD3SLh1TsNNCxDEdW9j7OS9Ykc1lXvREGPnIa02KdUp/YfvyEt4+gR95Arfx3OJm+cX4kpBb8pbDMUISTa6xAz4jAc8qN+ggbRbe+hMMhHoKe+aZFI2bvcoRu2hsNudqxUSzY6AhPy2oNHUkIwzKfgqXFl70ZTuZhn2h4/jo43YHpzTps5SS//LX9PFNft6OZJ9WZliNTJDIP2SHH1yCOaWWuFWvr8RGjIlQTdMgkJIabvQ6aMEQCWNXLPIphgrgnRX0Oj0z+eAmjfIPg8C1P4AHH0sFucBH3bV1VoSLd7rKKeHfO4ZpLjSzmPpTC8KEpOlojzIWYHUlwmlcpQ8HfsvpOnRuF/b0ie4ZAh4lLzzWlf7XkY4OlzacpB8BhX6pnc7q11S/2LXsG1C/AEYAIOJ5aXxJx1Troc08Ri/neFcJZESVEMSNP2tsZTDHduR7ZLdIwFwnqjFz4rs6e9tRgt5MozTtr4J92TbKiqRZbUmsys/lZp+XX8YFbYf/CiSxYKhGBW+pcM7vl6bhpW4gHCXcgUR8529kiTqjIKtYcpg/6TRu234xBzrjDW5s0Wqba9e2SuQLTjQnUOol8qHD5AA2SVXLUMA8Fk0MZtb72zZxsoFVD2JjJTIBbtMMyp4u8Hu2GVeq43dm6jA6Xud2IcaS43bmYTRBtrc8GwJJEroF6gkJQWw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9183.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199018)(36756003)(44832011)(2906002)(5660300002)(83380400001)(6666004)(186003)(2616005)(26005)(4326008)(1076003)(38100700002)(38350700002)(66946007)(8676002)(66476007)(316002)(41300700001)(6486002)(6506007)(86362001)(478600001)(6512007)(66556008)(52116002)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AteAHOJJnWllySCsxf5nTI0+9NUoogAQwcR/r2vXZS8DkwETSpYicofuS/HM?=
 =?us-ascii?Q?J2x0y0zURwir3uso5/4UjoAkX87pBphnNEfkt7u0OA/dbf7MJdyu30qOPLlv?=
 =?us-ascii?Q?h+zmZI3sRR+2gHuQxrWtmlO0Rn/LpQf/UEtihfYNTikXpYO6xITRRWMAq4XK?=
 =?us-ascii?Q?Disv87umR5Lje/X/CXSYiJ4vLXhbPiEEur45nbGTJeF0QdWhSx1thqkqF00E?=
 =?us-ascii?Q?Wnit1I9cpV6DfUjhnIpEya76Av91/qaVsOHqLIhvDk1N9+a+PBylu5BjXmWT?=
 =?us-ascii?Q?w29piM7eUXriF/kVEd+5aE1YJR0vcQLyAW8Xt3h5DyzGi7jmxDt1VRvfWhfP?=
 =?us-ascii?Q?h+NGpRYab2yDuk/hsL74sZ+vw5J4pfpsw+MGezH3n2gFQIpqbfHDR8HZ3mak?=
 =?us-ascii?Q?FjRxIiL8Bd+cl5WG0xgnuCKzX3zWGREHiKl2ck7oqUw+wVRHEm1GVNTBJHlG?=
 =?us-ascii?Q?L7q5iU8hHIoydG5adsmI1bs2X+uu3Q1GSHbb22q1flXlHY3EWzRktPi7rFNw?=
 =?us-ascii?Q?eVpYNPnJQjfyXpD4DeVnXAZe6d8n+Wt+oiZoPOsOo9jcNIjL3mQ5YJEK92fY?=
 =?us-ascii?Q?q4T5ak3EltKqSC54WTv8KUPmA5wr22uWzOKvSBPgDwBmNiAMDZ4HORrUokf6?=
 =?us-ascii?Q?SkMYhYoZuBpT5pAZ8tYDoXLlniq5isGY1YBvDWtZf2A9Hqu4dTxaJ80CqY11?=
 =?us-ascii?Q?M4L78mYWgYU98xnUOzAVYbEzw5cBk2fSfOsd3rjS4R6zgK4uXht7iIzbTn/l?=
 =?us-ascii?Q?b/xZn8Mn9J/bcxDh+IF2FBtcpw/p3bYe3TNqnTQ908Th7EQyKyryTC3zWuKw?=
 =?us-ascii?Q?I9IxLs3VnXHzsMilhpoWWWleNiQepk7k8YMJRMuW0YO41zSopJC+hS3ShAlX?=
 =?us-ascii?Q?2mmUAphwnKSp7TRmhajTfJ0sp1uhSrIf8STDj0RB6c2W2zajUBh4aIPgFtuu?=
 =?us-ascii?Q?eVtGiiFMcg1CE3z40Zdjh2PufRP7EQK+L2uxXAq1iNNd9y1JPhfmYUFXZwoO?=
 =?us-ascii?Q?QDHI8pKlIraZ8Vf+rN2OXDs897/eHVVkiFrQgdn90QZNxHU6cXqvS+iuZTTH?=
 =?us-ascii?Q?3745R6cOtEhOoHqJEwVSGgzgMtxnKLo9rzJ91pxE0BO6Pj01oa/ZAJ3E4WH5?=
 =?us-ascii?Q?uGCkbg9/hLhky4a8ANYvRTObNpDhpAuP4+HhLYGoUtVGOrazAlwKdhXt14Fc?=
 =?us-ascii?Q?u0QH+5icJ6LJykx1L/6mWk17t+d9ErAR+xfOby/ZIQTQp4EMOqrbMSv6AXQS?=
 =?us-ascii?Q?W9i68px1IIrmOS8G5+XRFjjoSeg0HrGVuDwbxcRwRD+oJQQ0D5CLeUW8amg9?=
 =?us-ascii?Q?Z6y8TaR43FGrsZzPj3+FX18zhl32zkUgFA9Y5W3utHPZSziNTg44TSmbbh+1?=
 =?us-ascii?Q?M0rWHAUWGgdLQ8Vlsp5rAq5EGvsAwFUMY2Oz8JhJbiKgDynZlymKs4EWSEt1?=
 =?us-ascii?Q?m2xuMELjv1QwDRWlTf7mXT9tl7yZHF7bFMxCRMhf1UHbxrY056Udw9uNfdRJ?=
 =?us-ascii?Q?2mnlSJq24G4Ro2CZxj09QXuKUa77GMpnaDCOktRdCWjHkl+BU1FYy8ghLVqZ?=
 =?us-ascii?Q?Olqnaadiel9i5ir5OS2zHiKBhX4/+N0S5pw2vIY7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf256e0-c67e-4dd6-95f5-08db1a54cf7c
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9183.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 12:59:36.9307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: py9hstbWicsOEAof99MkRTO/EfwdWezZYYuC4UCvfhIZzcvK1Rf29WY2Cew1gyrqKXlIMwxy56zDCvU2px9TOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9335
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The genpd_dev_pm_attach_by_name() is not exported, following error
occurs when building imx8m-blk-ctrl as a module:

ERROR: modpost: "genpd_dev_pm_attach_by_name" [drivers/soc/imx/imx8m-blk-ctrl.ko] undefined!

Fix this by using dev_pm_domain_attach_by_name() instead.

Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
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

