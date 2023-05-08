Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCCE6F9F4B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 07:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbjEHFxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 01:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjEHFxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 01:53:39 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B6A18FEE;
        Sun,  7 May 2023 22:53:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKZSi0Ksuc1QhIiJ+ZPvU4j80I7OwkmGcSP074KrLvLCv9sCrcvHaA3poCfU63lFd90Qp046PqcP5yz/nPu6D/P7Q8J5YEyIgleM9YC0F6KLe2K5oL3BVZ+jl+RTbCHiUBpBiMo0VH/NTDV05Hn+dCALpQBEYuv+vLqW/QorRfesRfMCWmgvkCkpetMhyopGIaLNdjKPoEwYIj8/F8gpuFRlCued1h2WA5TEaHbBYhPfWNPb++qKGRFGyfJPW/6cfjthu2+MvGi5weIfUnYFeXsTdf5T+zflPj5qwqIZbb/qR0fl67kl6QoJWR/d4jAx0oKmWu0d5orqbcYENeUP4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3NIRcgyyGTK4xWE3hKpBxefpObjD++6U5Pt6ulOiE4=;
 b=USGdmst07aucnFZG89hdRyONeiEI1QSgMGBvihqoc0G83Gpx7XBX51NK9y+xtz5jYJvy9UijDn57a9iufKumFW6WAhYgJwLOCQeVXmol5QykmodYVYJR6xWo95pwoDgsRQ7pappZbR6kl9YhZQiLD2PCIiWYKF3Zy4OtZqkvO3XGLrFqLTLaLXNJftx2klpalSeGJhpfc3ZXh+CtFs1DioMf2naNb1qJZ619kQYHfXuwe6WGstI7fGGmVZcyWQzxroapGEzEF1z7fLyvUm+xbRxx6TScj1D+l8lUvOnRZvNXWz6G3bHiALI2/EsE9IQwt9fTNtRzFkoDd6r/9HMUGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3NIRcgyyGTK4xWE3hKpBxefpObjD++6U5Pt6ulOiE4=;
 b=e2laNdjX2q9+YzdSFjc+WuQmGhNpgRp6WNp2SPvxY9ixM8ON/+ZGFjuI7xmfwfd6ZhDp3WQ2lnXxk9JnCPwwlwRVLqiqZvwkDTG1B1aembGiyiMZ+Suhi8s8xL8qWGXmjAH3/eiUCev531ymw0vvAM84xBrHw17qVDq+ul1znSc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AM9PR04MB8523.eurprd04.prod.outlook.com (2603:10a6:20b:432::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 05:53:28 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::60e3:2297:61f1:4d1d]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::60e3:2297:61f1:4d1d%4]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 05:53:28 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     marex@denx.de, stefan@agner.ch, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        krzysztof.kozlowski@linaro.org, LW@karo-electronics.de,
        alexander.stein@ew.tq-group.com
Subject: [PATCH v5 4/6] drm: lcdif: Check consistent bus format and flags across first bridges
Date:   Mon,  8 May 2023 13:57:38 +0800
Message-Id: <20230508055740.635256-5-victor.liu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230508055740.635256-1-victor.liu@nxp.com>
References: <20230508055740.635256-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|AM9PR04MB8523:EE_
X-MS-Office365-Filtering-Correlation-Id: 9404ddd5-4b98-4d6b-21a7-08db4f888bd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pb3n3d0MvwRbS2eYyGIeK4CPUFFdTlWH2RKHiB/wm6Gm2I71dem3B0DrIMQ1MMF2sbyvNMqmvG1PUv+aCS+pmWO/Pis/ZoKsaWwq0wLfwrzqkViu845yKeVk814oQ4RTcXzGr/HlyORPt0HsmJFmPhkwZG41+8Lm/4Z34zxTYV4gOKodTv9MKtzPUbtFM2a6PACcWqzR563gE2Tumh/rXrFGpAPLV5d4IKKm5WH7oeyH2+2uoGlBV3cm8QZ/9hX08KiQFnPiztjrwZn5Wg7Kywc9li5JyZlgQTxrdRXAZ7tIkCaKDNBUv+foxvyd620xDk+l13RFAyW/sto9QO6KRd9ZMZQK06+nXBhFC6d9L75xqPnU5hsngF3HNQM0/OuvKeNhQryAQx8A5w1KnOPXaKLytYRLhah1ADJfP+3XjD5447+c0CrAOGROyEt0UD91LdNpQx3cTPRVJMfj1p7qcNmLd8tATWETeDT6r7trMky/QcQ/4QIExZJXm4+ryDAzMaZdbrOCKMHIeANURftvrewxNXMetaMkaa5s4asC8zQcBK5OAL33O6fyq5ucX0Iqd0lSNXiYaCXqUdrmi8DLOqDRycurHn3Qan7CLEKp6Zn8oS3kQKoY93yjwyNg9DB1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199021)(83380400001)(6666004)(52116002)(6486002)(478600001)(2616005)(6512007)(6506007)(1076003)(26005)(186003)(2906002)(7416002)(36756003)(38100700002)(38350700002)(66476007)(66556008)(66946007)(4326008)(41300700001)(8676002)(8936002)(86362001)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ikmts7ucYTd0XcaqYMeotxvlNtqml8que6joUAtWJhnej29cqblGewl/0T6F?=
 =?us-ascii?Q?5BzGzrU1McSNYnBpO3vK0jZRKiej3I+8oIi3BiRVnJ5EHauKud4564x6m8d/?=
 =?us-ascii?Q?JSdpLqDtpjwLAGwzEw8pQtP4EZVsXhfYO2VXe2T/LifZ29LUCOVx+UBi3TBA?=
 =?us-ascii?Q?thhiXirz+j+a8UuRE1m9mitDyUy8fSeTDanYK3hkwRMxXv3toeO26r6OUt6U?=
 =?us-ascii?Q?jiAfGKejKCQxnxubH7Au/feucYvhZmnXO1aAhjSRese21t+IjS6hRTgbDuM1?=
 =?us-ascii?Q?+TZpOKi+QJQ/v+PkqhlMIX3qmyyWWI8/AtlDz6kYSexzCBmEWvHrMRSB4avV?=
 =?us-ascii?Q?SwSIaFqCdDDwg31n55KH1FIYly6u5UwBkf9cKVxDMeajRuvG+Z/JPtWVn2Pl?=
 =?us-ascii?Q?fjTC2A6fwMf3Ghajdk8BcvRu6q3+uqF0m7+4Bgn572q85Pj7nZ+9dabl6cmO?=
 =?us-ascii?Q?KGFKJDpACTPP0MmhA3ByU7HhH8zwnNnBT5rjGLMCxu5hNB4X6av1+3TPEAua?=
 =?us-ascii?Q?xYtRPntyo1JRUj+/Rg4zs7No8yQR2h+kaDKNdS8X9buzDeG/CCajFDVdDqX/?=
 =?us-ascii?Q?aV10tiedxnbA9fjeHwyrPg6wx7kCfX7uXIunHUNwY4gc9EgfAQh32riFNW5s?=
 =?us-ascii?Q?kVtmZvfZt++zQdgRUOJ7fQVyS7NbsqF/eChSM1R8RASQ2ovQJiTQw1tcm6DH?=
 =?us-ascii?Q?x+T6eaMgY1y5UtGf9N8/DoWfC4D4f5LhrpxGFU7kigaM7rFTakd26rUnBPX3?=
 =?us-ascii?Q?OtT40vsPTpo3GUXVaQGE54o22IJsmhERv8cTVUFMlR+OyQMnH/W7My5M0KI6?=
 =?us-ascii?Q?7S9J6d7ukIlDODPH7s/zCkZTjW0HMSLO1xyLgcdgaWHqZ3DRRek7SbSigWNI?=
 =?us-ascii?Q?Ngf/dtAg4Ti6nCYW/e5rA3mlfKCpxjTgYwJXUsZDeUgezBKcVYcOZ/K8aOos?=
 =?us-ascii?Q?MBHa1socokUwwwq+DFDc1g1IsX4WpQzF9jPUVVqCGfdIJfgjKPC2eDsNuMxQ?=
 =?us-ascii?Q?OCBUZNyPS4akIyfb9h6b2VvGLK9OwQ4NZ19zVrj94naIKo12q4aRwV6Rq+fi?=
 =?us-ascii?Q?yEeBvrFrU26wtVnT3cVcqklTzxa2hFUuEvm0mBEZjOBpNvPopkoHa8Uaqwf4?=
 =?us-ascii?Q?X5y7sq4B3rMprCYzeXt2P9LKkZpmEQizyKML02T0Izdz/DRbKCN4PQK9Hex3?=
 =?us-ascii?Q?pE9s0ECpFl9jL00lwSKU4xMNqkoxs48e988Kbhfp8PdOIGv/FQ1c3yPgnnIZ?=
 =?us-ascii?Q?EyxmyMmoyW+yZEhm/bnijf2UxjMoutroCu6HcF67r2e+ZV3oVE8F893XcYEn?=
 =?us-ascii?Q?/6Tk/wx7TbJ0OXnHKxg6sMknV5FZw3roQNpuOTu6X8AnKJws6c31U85GxQ9V?=
 =?us-ascii?Q?4MWFHLJS5gc2XpCmeiRVeUxNU0Pjd5SKXbpvTuLy9AW5wKsv2BKA9LGRv1CX?=
 =?us-ascii?Q?VSdMtl2uOMv1l1/6k0MjMgtEvvXx8RduNi1MVpMghpM8fZucFrQfRD+QZ5Cz?=
 =?us-ascii?Q?mmCWyMBP9W9EZKbHPSUZMpH0l4E6dcIVBeG410fN9y7DrEyl+xN+mnXbQQmM?=
 =?us-ascii?Q?1Ft2tlUcuK/t40Dh6pVW1WB7IvcLlMmdo1+Al5jZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9404ddd5-4b98-4d6b-21a7-08db4f888bd5
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 05:53:28.5042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KIBbZ9IB2ZIcISSBHRyf7/c8kTNYrfXKTJynXaOnQhzYp3zBYZbjsL+j9fXUCrmRLN25DOhr/y+UaWUiiIxEww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8523
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The single LCDIF embedded in i.MX93 SoC may drive multiple displays
simultaneously.  Check bus format and flags across first bridges in
->atomic_check() to ensure they are consistent.  This is a preparation
for adding i.MX93 LCDIF support.

Acked-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v4->v5:
* Add Alexander's A-b and T-b tags.

v3->v4:
* No change.

v2->v3:
* No change.

v1->v2:
* Split from patch 2/2 in v1. (Marek, Alexander)
* Drop a comment about bridge input bus format from lcdif_crtc_atomic_check().

 drivers/gpu/drm/mxsfb/lcdif_drv.c |  2 -
 drivers/gpu/drm/mxsfb/lcdif_drv.h |  1 -
 drivers/gpu/drm/mxsfb/lcdif_kms.c | 76 ++++++++++++++++++++++---------
 3 files changed, 55 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mxsfb/lcdif_drv.c
index 6fb5b469ee5a..e816f87828fb 100644
--- a/drivers/gpu/drm/mxsfb/lcdif_drv.c
+++ b/drivers/gpu/drm/mxsfb/lcdif_drv.c
@@ -52,8 +52,6 @@ static int lcdif_attach_bridge(struct lcdif_drm_private *lcdif)
 	if (ret)
 		return dev_err_probe(drm->dev, ret, "Failed to attach bridge\n");
 
-	lcdif->bridge = bridge;
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.h b/drivers/gpu/drm/mxsfb/lcdif_drv.h
index 6cdba6e20c02..aa6d099a1897 100644
--- a/drivers/gpu/drm/mxsfb/lcdif_drv.h
+++ b/drivers/gpu/drm/mxsfb/lcdif_drv.h
@@ -31,7 +31,6 @@ struct lcdif_drm_private {
 	} planes;
 	struct drm_crtc			crtc;
 	struct drm_encoder		encoder;
-	struct drm_bridge		*bridge;
 };
 
 static inline struct lcdif_drm_private *
diff --git a/drivers/gpu/drm/mxsfb/lcdif_kms.c b/drivers/gpu/drm/mxsfb/lcdif_kms.c
index d46de433cd8e..d6009b353a16 100644
--- a/drivers/gpu/drm/mxsfb/lcdif_kms.c
+++ b/drivers/gpu/drm/mxsfb/lcdif_kms.c
@@ -17,6 +17,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_color_mgmt.h>
+#include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_fb_dma_helper.h>
@@ -424,15 +425,19 @@ static int lcdif_crtc_atomic_check(struct drm_crtc *crtc,
 				   struct drm_atomic_state *state)
 {
 	struct drm_device *drm = crtc->dev;
-	struct lcdif_drm_private *lcdif = to_lcdif_drm_private(drm);
 	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
 									  crtc);
 	struct lcdif_crtc_state *lcdif_crtc_state = to_lcdif_crtc_state(crtc_state);
 	bool has_primary = crtc_state->plane_mask &
 			   drm_plane_mask(crtc->primary);
+	struct drm_connector_state *connector_state;
+	struct drm_connector *connector;
+	struct drm_encoder *encoder;
 	struct drm_bridge_state *bridge_state;
-	struct drm_bridge *bridge = lcdif->bridge;
-	int ret;
+	struct drm_bridge *bridge;
+	u32 bus_format, bus_flags;
+	bool format_set = false, flags_set = false;
+	int ret, i;
 
 	/* The primary plane has to be enabled when the CRTC is active. */
 	if (crtc_state->active && !has_primary)
@@ -442,26 +447,55 @@ static int lcdif_crtc_atomic_check(struct drm_crtc *crtc,
 	if (ret)
 		return ret;
 
-	bridge_state = drm_atomic_get_new_bridge_state(state, bridge);
-	if (!bridge_state)
-		lcdif_crtc_state->bus_format = MEDIA_BUS_FMT_FIXED;
-	else
-		lcdif_crtc_state->bus_format = bridge_state->input_bus_cfg.format;
-
-	if (lcdif_crtc_state->bus_format == MEDIA_BUS_FMT_FIXED) {
-		dev_warn_once(drm->dev,
-			      "Bridge does not provide bus format, assuming MEDIA_BUS_FMT_RGB888_1X24.\n"
-			      "Please fix bridge driver by handling atomic_get_input_bus_fmts.\n");
-		lcdif_crtc_state->bus_format = MEDIA_BUS_FMT_RGB888_1X24;
+	/* Try to find consistent bus format and flags across first bridges. */
+	for_each_new_connector_in_state(state, connector, connector_state, i) {
+		if (!connector_state->crtc)
+			continue;
+
+		encoder = connector_state->best_encoder;
+
+		bridge = drm_bridge_chain_get_first_bridge(encoder);
+		if (!bridge)
+			continue;
+
+		bridge_state = drm_atomic_get_new_bridge_state(state, bridge);
+		if (!bridge_state)
+			bus_format = MEDIA_BUS_FMT_FIXED;
+		else
+			bus_format = bridge_state->input_bus_cfg.format;
+
+		if (bus_format == MEDIA_BUS_FMT_FIXED) {
+			dev_warn(drm->dev,
+				 "[ENCODER:%d:%s]'s bridge does not provide bus format, assuming MEDIA_BUS_FMT_RGB888_1X24.\n"
+				 "Please fix bridge driver by handling atomic_get_input_bus_fmts.\n",
+				 encoder->base.id, encoder->name);
+			bus_format = MEDIA_BUS_FMT_RGB888_1X24;
+		}
+
+		if (!format_set) {
+			lcdif_crtc_state->bus_format = bus_format;
+			format_set = true;
+		} else if (lcdif_crtc_state->bus_format != bus_format) {
+			DRM_DEV_DEBUG_DRIVER(drm->dev, "inconsistent bus format\n");
+			return -EINVAL;
+		}
+
+		if (bridge->timings)
+			bus_flags = bridge->timings->input_bus_flags;
+		else if (bridge_state)
+			bus_flags = bridge_state->input_bus_cfg.flags;
+		else
+			bus_flags = 0;
+
+		if (!flags_set) {
+			lcdif_crtc_state->bus_flags = bus_flags;
+			flags_set = true;
+		} else if (lcdif_crtc_state->bus_flags != bus_flags) {
+			DRM_DEV_DEBUG_DRIVER(drm->dev, "inconsistent bus flags\n");
+			return -EINVAL;
+		}
 	}
 
-	if (bridge->timings)
-		lcdif_crtc_state->bus_flags = bridge->timings->input_bus_flags;
-	else if (bridge_state)
-		lcdif_crtc_state->bus_flags = bridge_state->input_bus_cfg.flags;
-	else
-		lcdif_crtc_state->bus_flags = 0;
-
 	return 0;
 }
 
-- 
2.37.1

