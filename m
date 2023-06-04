Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFEC721568
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 09:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjFDH5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 03:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjFDH52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 03:57:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A360FC1
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 00:57:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FCA26125E
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 07:57:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5D1C433A0;
        Sun,  4 Jun 2023 07:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685865446;
        bh=XiSFINADjkUDmu+qcRcfsnLeAcqgKHZ9Wa515Osz/sg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YXTwAPzi5CsfeBMeF5IUlsSsggm0Pv46OYwv+rV3pwo4w0bWfE0tqO2K2QiNPxuFI
         i6eSDr7+w3prjA2eQVej++FNY/t4oM30Uyi/6c9Hod5yrrsWHrdvLnagZicceDGYMz
         QxLjsZjIMuafzEkdYcDMrW94IFh8y1K2E/IezlZFKTSXqX1FaQJiYkyqkyvHwEfeh+
         trHja77VU94yTFEGA+T1hgFrAsXuuHJW2w/ym4h5wPMeRLdx1xumEOUcOycrCBFx5B
         ck0iOtnT9r+B8JnMQZ/xDOIERm/RLFDGiaigfIaUtX5VJfVy/E2Yh9O4PI1Oetd0Gv
         D7Ozlwz4I1BJA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Liu Ying <victor.liu@nxp.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] drm/bridge: imx: turn imx8{qm,qxp}-ldb into single-object modules
Date:   Sun,  4 Jun 2023 16:57:13 +0900
Message-Id: <20230604075713.1027261-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230604075713.1027261-1-masahiroy@kernel.org>
References: <20230604075713.1027261-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the previous fix, these modules are built from a single C file.

Rename the source files so they match the module names.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v1)

 drivers/gpu/drm/bridge/imx/Makefile                           | 4 ----
 drivers/gpu/drm/bridge/imx/{imx8qm-ldb-drv.c => imx8qm-ldb.c} | 0
 .../gpu/drm/bridge/imx/{imx8qxp-ldb-drv.c => imx8qxp-ldb.c}   | 0
 3 files changed, 4 deletions(-)
 rename drivers/gpu/drm/bridge/imx/{imx8qm-ldb-drv.c => imx8qm-ldb.c} (100%)
 rename drivers/gpu/drm/bridge/imx/{imx8qxp-ldb-drv.c => imx8qxp-ldb.c} (100%)

diff --git a/drivers/gpu/drm/bridge/imx/Makefile b/drivers/gpu/drm/bridge/imx/Makefile
index 5fc821278693..8e2ebf3399a1 100644
--- a/drivers/gpu/drm/bridge/imx/Makefile
+++ b/drivers/gpu/drm/bridge/imx/Makefile
@@ -1,10 +1,6 @@
 obj-$(CONFIG_DRM_IMX_LDB_HELPER) += imx-ldb-helper.o
-imx8qm-ldb-objs := imx8qm-ldb-drv.o
 obj-$(CONFIG_DRM_IMX8QM_LDB) += imx8qm-ldb.o
-
-imx8qxp-ldb-objs := imx8qxp-ldb-drv.o
 obj-$(CONFIG_DRM_IMX8QXP_LDB) += imx8qxp-ldb.o
-
 obj-$(CONFIG_DRM_IMX8QXP_PIXEL_COMBINER) += imx8qxp-pixel-combiner.o
 obj-$(CONFIG_DRM_IMX8QXP_PIXEL_LINK) += imx8qxp-pixel-link.o
 obj-$(CONFIG_DRM_IMX8QXP_PIXEL_LINK_TO_DPI) += imx8qxp-pxl2dpi.o
diff --git a/drivers/gpu/drm/bridge/imx/imx8qm-ldb-drv.c b/drivers/gpu/drm/bridge/imx/imx8qm-ldb.c
similarity index 100%
rename from drivers/gpu/drm/bridge/imx/imx8qm-ldb-drv.c
rename to drivers/gpu/drm/bridge/imx/imx8qm-ldb.c
diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-ldb-drv.c b/drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c
similarity index 100%
rename from drivers/gpu/drm/bridge/imx/imx8qxp-ldb-drv.c
rename to drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c
-- 
2.39.2

