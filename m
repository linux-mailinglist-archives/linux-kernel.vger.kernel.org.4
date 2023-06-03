Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78312721154
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 19:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjFCRIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 13:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjFCRII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 13:08:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD0E135
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 10:08:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 938D960B4B
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 17:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF872C433A0;
        Sat,  3 Jun 2023 17:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685812087;
        bh=625V0iT5dcehfVt4qp+4KsunqsvUgaOhEkp64prztuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mh016dTw6+Ptz8S0odzfu5vqrTwHWrX7gPI3LWg8aJGRF3ES+70ahzjpvreYGtu3L
         3eAM6sA0I2sRRt/jT7wICaR7Fh5/kxX/J7yGOdSc1naXM5ekeQc/3FoYFxj74ekWJ7
         c9N1n1hg2QAuiDvBAyy+6CPGOSMzvZcXNhn848ET64ugNQydaSXi3hofcqIpYCPbH4
         LwAPFg/owy8d6bNbe86ro5BbF4NAeCbsifc55jpi5hhjTwCCNpJ8vKTF/4vQTS+mw+
         W2ICtXxbhYQw9WalBmCDrYXbpLyWzB82vjRrAD08V+sna0hUGiFDYoiL0ZKKsO6YXV
         NOgsweVlQ1kwg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liu Ying <victor.liu@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] drm/bridge: imx: turn imx8{qm,qxp}-ldb into single-object modules
Date:   Sun,  4 Jun 2023 02:07:47 +0900
Message-Id: <20230603170747.1753842-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230603170747.1753842-1-masahiroy@kernel.org>
References: <20230603170747.1753842-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

 drivers/gpu/drm/bridge/imx/Makefile                           | 4 ----
 drivers/gpu/drm/bridge/imx/{imx8qm-ldb-drv.c => imx8qm-ldb.c} | 0
 .../gpu/drm/bridge/imx/{imx8qxp-ldb-drv.c => imx8qxp-ldb.c}   | 0
 3 files changed, 4 deletions(-)
 rename drivers/gpu/drm/bridge/imx/{imx8qm-ldb-drv.c => imx8qm-ldb.c} (100%)
 rename drivers/gpu/drm/bridge/imx/{imx8qxp-ldb-drv.c => imx8qxp-ldb.c} (100%)

diff --git a/drivers/gpu/drm/bridge/imx/Makefile b/drivers/gpu/drm/bridge/imx/Makefile
index 64b93009376a..c102443f7286 100644
--- a/drivers/gpu/drm/bridge/imx/Makefile
+++ b/drivers/gpu/drm/bridge/imx/Makefile
@@ -1,9 +1,5 @@
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

