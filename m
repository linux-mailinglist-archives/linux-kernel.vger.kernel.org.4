Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CE1706CA1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbjEQP0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjEQP0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:26:10 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525D31B7;
        Wed, 17 May 2023 08:26:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Slab9hqcpWLBJpSvBOnk+/NYu3xe8xdaMWWfYH5YkZPH+Sh7+xzBZNYqAFlDJWVDmNMb911Vr68hzAT7ZJ+PgchnwyqUUKB8YX5vQBL14skBMnNtvnSn3EJYzRXmDo18bve/wjy9YXDlZy5mT8q/GyZPtrQvDNtwAet2WZy/eIOFEjJnXPbw0p/wuJDM1YGl+sp7KkSd1ii3qmu5lBZwg4P0BYDgpz+3YZiCNFZ9DnCTIlhqf6kGUf/0KmRsOCCuvQWv0peZ3zxh6Q2hn8p1Y22NOlohrV2lS9lCi5NbPsSBRADL3THNcwRC4UgIJKKtzHMLcRT/g8VcBXgtFcDrsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMjol5UHOl/NbR7CySQsP3RvcqPp0o7UgZD9PtNiwEI=;
 b=XoeHtfTk0l41Bp/aNBtEZjq4QHJ+mFTxz/D5cn01s6xubcauXgecFm9N+tDO7Q+8z6Pct9cRrDR3P6wcyT01+KDbGIapWvezxXI3mo+I4USNM/MR+b1rVG2OajBbHxCwYmzJHpTAxHuTy7lLJ8xleP+BF/IMn2Adpg0k2JiRls3R7Ggw3oegRbrnolC8WTOS2F0P2+R5Po29VPZfID2gHizuoIqkDWXjDHDcC0OcJCs7FmIULWoOPVcuDLbMY9+6PMwpXg2N2gdItl0QwoNIjquYdVYfrXxsB8cDVgdw+j/B1HOFbgOfeRu5nvzmNxqPyUKLyVqZUy3NHMdmJTOuMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMjol5UHOl/NbR7CySQsP3RvcqPp0o7UgZD9PtNiwEI=;
 b=HTjqf/OaVEE81OZpmbRhArDiwgsGAqavu3KOUQGCv1Yt/IMntkdpuUVm7eTplzupeG8rhso8xqcVJZoLffX+AlkVMBSwkE8GYKLdLkIGA+kk30qAHhU9lZrYETvgXDRkjlt8xCAk7joVH5SttQAqZqNv5X3+/rqXcfJV4bmba78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS1PR04MB9697.eurprd04.prod.outlook.com (2603:10a6:20b:480::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.32; Wed, 17 May
 2023 15:26:06 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 15:26:06 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        peter.chen@kernel.org, pawell@cadence.com, rogerq@kernel.org,
        a-govindraju@ti.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: [PATCH 1/2] usb: cdns3: imx: simplify clock name usage
Date:   Wed, 17 May 2023 11:25:44 -0400
Message-Id: <20230517152545.3404508-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:a03:254::35) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS1PR04MB9697:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f805a98-ee3f-4e3c-d8db-08db56eb083a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BG/k6FrExXHwOjwd0lAZ3/Q+tp8KaPxknJBh/ch47FjcdcCEnKOe4WAaZ4PvCG54yn3wIByfL3SX9Zn3YPLBnJgJUZBcIch7P2P4ZtJnzXlnhJjA7+CZc+ppZfElJuZa3LSbEdoEFOggvjyt+9Tcehdn8tKpKK1b4ojZkdzTOIMBfhkgPomOLPjDSFvk8kmFV0IyIwLw0/MAjCeuHj4gsNlmHAM4wCZ4sEM7aTWGswpj15/KdUQv53yW7+B+dmcQZ/y4e/yZlMzuzEUKGekW8udZldHuwmhvog6wqQc1FyHbpcjwWGD7M8ycIXcoJaUGw4xdLUqDemNs8/Q00RnHLP3u9hqE/WJDU0lMmQo247YAGauXhGOEtjZbp4BrL5ZgmgrRem3kjgZzEB51jy8Pj8aGKHVhBmkqMj0qz9ys+fMgoBlCeR37W1S7nSBcYqTipENwdDqmQBhFBerVOWzKP5Lwg7urSc0DLgJ6kO9M7Z0LzrNgysQUxBHZRuMvxdkurmePDVfnYJObR4rO3HjB2Mz+RtpGX11+C3MYi8x9ZZLYmB3dFNxxlsOSpdNRWUANMRAZYsC2LTYvxX70rO9LpZijVgAxcBZdNirpOIicy2g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199021)(478600001)(38100700002)(38350700002)(1076003)(83380400001)(6506007)(6512007)(2616005)(26005)(52116002)(6666004)(6486002)(36756003)(186003)(966005)(316002)(41300700001)(86362001)(4326008)(66476007)(66556008)(2906002)(5660300002)(66946007)(8676002)(8936002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OXUxKSxGzAI5eFzRFeUzbX2+htwkezWfqNHaczB4k7a0IjlU1P58XFJVyYEQ?=
 =?us-ascii?Q?ckLl7aRDqnLd0IhS5Tgy3bU+3Jjym1pn926O3kFRX0sscVZqS5LB8jARRMQ4?=
 =?us-ascii?Q?f++wVn9iV7qb/GOFDwyv9KuOgAcbgLd/cOSGs8+DznDDJr7HR5FxWBWWxZLa?=
 =?us-ascii?Q?Y6mcHevCT0JmQfOBGh0Ul21ntTjIPF81pcyxps1nrpJXz94H24yd5jyvdoev?=
 =?us-ascii?Q?vWjQiBQnL/MzxumECxvaxuLA9omo2G/nvC4V904cP4zNlA6qJveIjwg89d/D?=
 =?us-ascii?Q?pU6172cMWxQJjB9ohKuhiYc8l5YGFH2hCe/7xN/HyGhpPI/XcAASiCxr4m1X?=
 =?us-ascii?Q?yj0p8bl7Wdthe4JkxFwdPMjXlJy433xh8q11BiSLezDcAQ+ayzzpwKdnWeXp?=
 =?us-ascii?Q?ZbCddcVqvsroKXH6RrWprHluxZUSQDK7m9ft6GYVu9NZ1NcFYJwXQ9zqXbQA?=
 =?us-ascii?Q?WxAkmBcLPWfJGNNh+BppusOV5YR3OZ3gEnUCr9si9SJ0Xz9oEZ1/omgIQbe8?=
 =?us-ascii?Q?NJEKP0JoY8m9voL8qF4oLyRcWFw4+6HHjxFr4AiWDTGFTaw2Y5f8mjZYdyh/?=
 =?us-ascii?Q?eTaVxyJjn6cwMw9YgbjHv4tjP5Ad7nw65c7566MQdMrc1G3et+5/aQJH/vkb?=
 =?us-ascii?Q?vlxnumvfNmR5MititMp77WGvdDVCZrpWC+4BZvZGguZzq5UPcGL2C+JR2/Wd?=
 =?us-ascii?Q?DknhRLdEHDyJrMb/dUMevHu9zXE9NlJb0xP73PSNIaNQPR4qtPG6N0mUr4iQ?=
 =?us-ascii?Q?m7gh63HglxnKWdQ7tp9fo2tcnJ6kQ8x9JX4QJkDNr1H6tU9VJsWcCIwAY5uD?=
 =?us-ascii?Q?6sRWWD0yPWY5qVBDyHwlYK3YL6hgIJbyv1ItJQFPm0GIlPFtXyZ16uRRialA?=
 =?us-ascii?Q?U+TOLGi4l79T2GBot4FLV04bgOdZeGDxRFCn0RH8XkakWwo6JpBo+mZuZkMf?=
 =?us-ascii?Q?uSxmMK5wfKFYJVKhT71oPx6geoWITpd1JRV8gqo3DMQ+nIcLbKZwqpkWLiRQ?=
 =?us-ascii?Q?lJ+VZNKypIJuyZCD7hQkgzUAHOSwWGu6V46YXGOWjGDmVpnvoPAtmm00RKSy?=
 =?us-ascii?Q?BOmI03W+4S+8uyz3KAyUjUxZXoy/ukiQOU4UG+wMQwPHJGzDbSgZh61l9kXH?=
 =?us-ascii?Q?w2Zg37vXu8zv+3BfdlykGQ3gYBpvPQS2KJ6P8wz8+PGnum5T9Y4JfksrZest?=
 =?us-ascii?Q?n8cC7cyISrg//5IksYDseiEUIrGBOCcP7/QZ7/NY+/XPnJ02ZmPZPU++eCqg?=
 =?us-ascii?Q?62chtuXIcOmn1FOLxvxl3H/r8oJpUuJQLdKtRUSS6zVwfzBDGLacILUMXZOk?=
 =?us-ascii?Q?CkSO0tFWiK2KnU0Fp5LYNJ7hFuH0lx0N7W2fcz7fNj9ZrI5pgvun1suxTiIx?=
 =?us-ascii?Q?LZXZEt7RhdlgbDA9aEz+A0f2OVX0CDaO906tHpAcI/r8BFHLSutaT5jH0BkC?=
 =?us-ascii?Q?SSBgnm2QisZcp7Urs7//VVcO0HnJm5ZZDsZxIIcu56vw4YUw8hOYc29BQ1Sl?=
 =?us-ascii?Q?3/gqrNwbskfIZIvVVXEhQ4O7DHZ337Xf5/AiAlVs0Rf1IjXroTVhp0Ny+/eh?=
 =?us-ascii?Q?HtzODvJ4SdGE4ng2p0c=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f805a98-ee3f-4e3c-d8db-08db56eb083a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 15:26:06.1455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5YpFsYgrwBn5zCuRMp2nRlOsfDbP/G2oSfhaoZfsq++MFLHm9TyQyDducGxYMKYxklZga/psiUQq3LSAEjA1+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9697
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplifies the clock names in imx_cdns3_core_clks[]. Such as, renaming
"usb3_lpm_clk" to "lpm". The "usb3" prefix and "clk" suffix were
redundant.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

This patch was missed at
https://lore.kernel.org/imx/20230327145523.3121810-1-Frank.Li@nxp.com/

 drivers/usb/cdns3/cdns3-imx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-imx.c b/drivers/usb/cdns3/cdns3-imx.c
index 59860d1753fd..5d9ca3c3c71d 100644
--- a/drivers/usb/cdns3/cdns3-imx.c
+++ b/drivers/usb/cdns3/cdns3-imx.c
@@ -105,11 +105,11 @@ static inline void cdns_imx_writel(struct cdns_imx *data, u32 offset, u32 value)
 }
 
 static const struct clk_bulk_data imx_cdns3_core_clks[] = {
-	{ .id = "usb3_lpm_clk" },
-	{ .id = "usb3_bus_clk" },
-	{ .id = "usb3_aclk" },
-	{ .id = "usb3_ipg_clk" },
-	{ .id = "usb3_core_pclk" },
+	{ .id = "lpm" },
+	{ .id = "bus" },
+	{ .id = "aclk" },
+	{ .id = "ipg" },
+	{ .id = "core" },
 };
 
 static int cdns_imx_noncore_init(struct cdns_imx *data)
-- 
2.34.1

