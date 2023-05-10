Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E5F6FDAA0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 11:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236949AbjEJJVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 05:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236863AbjEJJV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 05:21:28 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2075.outbound.protection.outlook.com [40.107.21.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD1449CE;
        Wed, 10 May 2023 02:21:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSYzjcYw/Sb5GNkEGSsgRfZNTyt/p0hphWN4QF0sLlqif37Z8O0vtKovib1Xx595hOyRBE0z4W9bNWrqmFoHEaWQdmwaVInv5PlN4AVXJPj9HFx3M2ibOskfTE41rWoKKNxhn3lfKmXA/g1S+UBYRzhv2Fv+SYdAa05INNfFZYqZQrZZzf5UBoDFjINYXtjGsSoAcqF4+Ih1VW6+6svGd3SaUYdM+u8yKxMH305hC+6vaGXd0ajhgdGwkilEJZoPAjwAYSmK6+NR2T4JIfJIGAqB19YI5O7Xcj97iEnjMpEqs0ADhsAkIAivAlm8h56QdCFeB7PtvlJjvMKJ0ecqKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAlqnbTDPRhNNoQbdUlsUMRoO8LAmssJ0asyGwxTkVQ=;
 b=dHUzyCWI/jsPdlcvBs1V4kLiC/muNUUQqNNFDikhSRbnC1wX6HvcQVQVqxLfoF1XdRczNUzOzST6jzLc/wy/wBkOid28ggFMugfVk+QCy/UIOx8RF7L5UTOMT/QEB0jL0ueJBaDWqXLYqGny/rf8cAUS+nPVi4k2U1XwDCvMBC2lPqOqPyeiCa/mOkNfc5jyRNJdo22QI9FlIsH2ehrHFPiexd7onJRXSxj2Qk1kG55TKY5fYjACkkXRM/VkkGXGwkj17qXomuFCc8n4y5qiXAbqWOaHse6HmkUSOpU1oVR4Pcc3QYxDOuQBvuBBP2otIaEfTNEowNyWZ97SI1unKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAlqnbTDPRhNNoQbdUlsUMRoO8LAmssJ0asyGwxTkVQ=;
 b=UX8Dm6BNRqVwwu3VLVs0Rvqps60roowKMvmH74jkUc4eQ357rZClCb0TgAYMjG8kooWSTz1sxxTQ98R5OJCZcTIzvu10UHE+fHD1gze5teYtEmLtZwVkSrEY+BiKwyN6YsXMKipFSKv2BUW7Q+Xv0otJ5Nyn2ewTPqYHcYJwkYk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by PA4PR04MB7711.eurprd04.prod.outlook.com (2603:10a6:102:e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Wed, 10 May
 2023 09:20:47 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::60e3:2297:61f1:4d1d]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::60e3:2297:61f1:4d1d%4]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 09:20:46 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     marex@denx.de, stefan@agner.ch, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        krzysztof.kozlowski@linaro.org, LW@karo-electronics.de,
        alexander.stein@ew.tq-group.com
Subject: [PATCH v6 2/6] drm: lcdif: Drop unnecessary NULL pointer check on lcdif->bridge
Date:   Wed, 10 May 2023 17:24:46 +0800
Message-Id: <20230510092450.4024730-3-victor.liu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230510092450.4024730-1-victor.liu@nxp.com>
References: <20230510092450.4024730-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|PA4PR04MB7711:EE_
X-MS-Office365-Filtering-Correlation-Id: a8d3ccf7-990f-46fa-1003-08db5137d619
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5PTWz8jmorFtLlaHELgxiXpwyCVV8WRC7Eccfnqdo4YtHqiakl0M30tVCpuJvx2bHOtHm616NdTs0C0cZECgi5KqgFrGALIiC7ajq/rAzsDqjvZqQPkkSjEtgsUAcB2dtA0GtyxmYoEUSuBFg0kUEw4j5LYQRsGF3ANHyb7SVxNDbjoG9l81KKbEOtEamh5nc42NTM3CTRkZ7i+gGc1MDByBoGlmOD9NYIsEwO4mdUpysB/B4cMTWZsR54d5Ci2PJjozhsdvgxiGb6z0MaAW44mVjQC6UWTHYdUBF9dz1nUdUCiKlYbvOEhaAbSbH5S0NIO5tagfhOjU4jabwdqLJcHafDu2MDKvvTwJo8bcXoXfUQ8me+6XCvwDZZyXcO/48iJWWPXb644LpjjyR/v0CvYviOstQuAnKTkz3LC4JEENnaUtKpYdotlSBY0hTEswerDGWzrOcrKcQ/Ph/wu5pjnlG4XX0xfzcZZblmnKfXcuIhpS3K+6FPZHKSxBHF8zZrnuHMewsXW6yzc396SlDDuNupJK06u14TQIR880HKEgPvnNkHpc67lCysWinT9IdIKSNZnJ4fJ1K0YPClqRXqU7u9S1Z8eip8Q08GV2ySWCvfxS8/yLtEPHhy7PAUVb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199021)(4326008)(316002)(83380400001)(52116002)(36756003)(5660300002)(2906002)(41300700001)(66476007)(66556008)(86362001)(66946007)(6486002)(1076003)(26005)(6512007)(6506007)(38100700002)(38350700002)(2616005)(8936002)(8676002)(186003)(7416002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dzmwoUudQTvg1o53QY8Cfta09ynpMUUwWuWsKU5+KVc6H9VP2VqdB7vLA+NI?=
 =?us-ascii?Q?qRG4/CDXwQIBwfj/H6jCEUBMMhCtQ5s3byPf/1R0uIPu2dhOCm6b1X8jKFls?=
 =?us-ascii?Q?dE+di1QtRJfPG9hwn/78GaFziv622fwDQV1SVk63b93cH4EawsqfXWIQmsZM?=
 =?us-ascii?Q?RUuf315CTyzHvCENUtdzY+yNxT1xq8BgK9CvLOe2vW8ogWgn93kweGHqwFyu?=
 =?us-ascii?Q?eVIrzsGWUr32yzfK8PZFH7A2tw6+6bSYrjIYVx+RIXeDwVVfDWnL1olcou2N?=
 =?us-ascii?Q?rfax8TiIRGGpEzk5qAbBq5qVzNmlFz1cZBUuNtPQBv6xgkcHoOwzWjrvmDN3?=
 =?us-ascii?Q?VGK4+XKyswm37uMKAFKSkqGCE1morIuyTqm8SsJA/disvb2dOPdXL7z/iFnN?=
 =?us-ascii?Q?H30PatWCnBVD/Hr1VXBYNFcV02IavKL005OR/Ci6rKejxgKgTWntv5DUK6tY?=
 =?us-ascii?Q?/RtGyboWtSr4XEQYfc8DFkv2Nz9Tg6AutHO77tdyzWJvEqVuZzaiHvfvvW4n?=
 =?us-ascii?Q?Midsc4bBPRP7xzTm8UDzH+mJ9usLfMQOwqgZLu/0Hvy33ZDtw5jWqBLJKibC?=
 =?us-ascii?Q?slvILgDjahs6WU6oNeBPR+kJx1mmmBU2E4SS7z0EPKawfxEGendNQHR4+pwr?=
 =?us-ascii?Q?DLf26o7gpuC2SLJICg0TZM1V0tXJxYStYPOt5Lo8S+wvJVh8ZuKMyWgeO7i+?=
 =?us-ascii?Q?fIW/wuS1F+zSo17m8hU7UBYAYIT0wXscLt+J+urzd9wHrbjj5AmPG3cfho7D?=
 =?us-ascii?Q?jkIFcSQCMJUcE8woI3pZ8pxRmi7iXCr5oeVozcFsYY8XeM+W5+gkA3MOoLKL?=
 =?us-ascii?Q?6qNZhM6aitF/K6y5r6ZAZkbXn7MhThjdEqyo/MkyEJJ/KEvOCv3hb7ew9qRj?=
 =?us-ascii?Q?MbL/Sl3r3OixKbrp9Pj2VkDd5a2N7AVfIAPf+5OIHHpvTjFeBTalXdtARxRj?=
 =?us-ascii?Q?szu8QmWUE+dJgsYTj79MjFkZiVvJdbg2v87nCjQVuOS5WP3VaUe3NMVhMuTz?=
 =?us-ascii?Q?8y5ezwJECZe6tVL+ZMrEGCR/wZtG1iMd6cz5o3/1sbdbB+8D312MdpiiZhaP?=
 =?us-ascii?Q?/q93LbxU3emS511ib6AaR+GqQOD/Q6Uu85QsUYBirkIrVk5STrWtArek6vhi?=
 =?us-ascii?Q?54EeDzdgSgTWZg9frXirBHQZTtNy0qL8KNIxaNFCultfAgSRVkZOGQE3LqNe?=
 =?us-ascii?Q?vWunzYKTiS0q4mH3Df1ScueL8y2/4ZgYsvUSnNKZiORc2i9jTyCK2DYGjxTA?=
 =?us-ascii?Q?gzze7LFkIFKgDmMlWa7/ZbgSiDBOiSnCqhj2jcEV5Q4TwEpGlWjhJ7JDQd0t?=
 =?us-ascii?Q?ZYwdH5UKeldWReTfYc2ilLgiUCIsUATmW22oXk9sL5zItpCFmysLJ2GI10iw?=
 =?us-ascii?Q?MOgW9KuH3j1fuhzUlfo7TzXc5RJng/XyqawVxtmZFg3c7pPw55CoGgPdfv4I?=
 =?us-ascii?Q?wVzSi4dN5lazOHxg8Aq2RoeH7WooR9WOVDbxhKL08uUFyGoi5mdHvaEMzaXL?=
 =?us-ascii?Q?aYPRpDKWAlapR/h678xuUnPwvbfyFrihGyVjV73ZZ4wkclDQrOOOEkC1PMrO?=
 =?us-ascii?Q?VTXHdE7QpVUBHqFg4fAIsIrKXqY7skOiMdvFH4q+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d3ccf7-990f-46fa-1003-08db5137d619
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 09:20:46.1832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w27IvvXoSkNE/Yd8k/1WldgOYqktVO5XxPr0U+bzemOR9aA92Kc+eoLVbktzUxW9hxQjuA8Dp9x6OKuss5LMoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7711
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A valid bridge is already found in lcdif_attach_bridge() and set
to lcdif->bridge, so lcdif->bridge cannot be a NULL pointer. Drop
the unnecessary NULL pointer check in KMS stage.

Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v5->v6:
* Keep default MEDIA_BUS_FMT_RGB888_1X24 bus format in case
  bridge_state->input_bus_cfg.format is zero. (Marek)

v4->v5:
* Add Alexander's T-b tag.

v3->v4:
* Add Alexander's R-b tag.

v2->v3:
* No change.

v1->v2:
* Split from patch 2/2 in v1. (Marek, Alexander)

 drivers/gpu/drm/mxsfb/lcdif_kms.c | 36 +++++++++++++------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/lcdif_kms.c b/drivers/gpu/drm/mxsfb/lcdif_kms.c
index 262bc43b1079..ba00a155d9b6 100644
--- a/drivers/gpu/drm/mxsfb/lcdif_kms.c
+++ b/drivers/gpu/drm/mxsfb/lcdif_kms.c
@@ -394,7 +394,7 @@ static void lcdif_crtc_mode_set_nofb(struct lcdif_drm_private *lcdif,
 	struct drm_display_mode *m = &lcdif->crtc.state->adjusted_mode;
 	u32 bus_flags = 0;
 
-	if (lcdif->bridge && lcdif->bridge->timings)
+	if (lcdif->bridge->timings)
 		bus_flags = lcdif->bridge->timings->input_bus_flags;
 	else if (bridge_state)
 		bus_flags = bridge_state->input_bus_cfg.flags;
@@ -463,30 +463,24 @@ static void lcdif_crtc_atomic_enable(struct drm_crtc *crtc,
 	struct drm_display_mode *m = &lcdif->crtc.state->adjusted_mode;
 	struct drm_bridge_state *bridge_state = NULL;
 	struct drm_device *drm = lcdif->drm;
-	u32 bus_format = 0;
+	u32 bus_format;
 	dma_addr_t paddr;
 
-	/* If there is a bridge attached to the LCDIF, use its bus format */
-	if (lcdif->bridge) {
-		bridge_state =
-			drm_atomic_get_new_bridge_state(state,
-							lcdif->bridge);
-		if (!bridge_state)
-			bus_format = MEDIA_BUS_FMT_FIXED;
-		else
-			bus_format = bridge_state->input_bus_cfg.format;
-
-		if (bus_format == MEDIA_BUS_FMT_FIXED) {
-			dev_warn_once(drm->dev,
-				      "Bridge does not provide bus format, assuming MEDIA_BUS_FMT_RGB888_1X24.\n"
-				      "Please fix bridge driver by handling atomic_get_input_bus_fmts.\n");
-			bus_format = MEDIA_BUS_FMT_RGB888_1X24;
-		}
-	}
+	bridge_state = drm_atomic_get_new_bridge_state(state, lcdif->bridge);
+	if (!bridge_state)
+		bus_format = MEDIA_BUS_FMT_FIXED;
+	else
+		bus_format = bridge_state->input_bus_cfg.format;
 
-	/* If all else fails, default to RGB888_1X24 */
-	if (!bus_format)
+	if (bus_format == MEDIA_BUS_FMT_FIXED) {
+		dev_warn_once(drm->dev,
+			      "Bridge does not provide bus format, assuming MEDIA_BUS_FMT_RGB888_1X24.\n"
+			      "Please fix bridge driver by handling atomic_get_input_bus_fmts.\n");
 		bus_format = MEDIA_BUS_FMT_RGB888_1X24;
+	} else if (!bus_format) {
+		/* If all else fails, default to RGB888_1X24 */
+		bus_format = MEDIA_BUS_FMT_RGB888_1X24;
+	}
 
 	clk_set_rate(lcdif->clk, m->crtc_clock * 1000);
 
-- 
2.37.1

