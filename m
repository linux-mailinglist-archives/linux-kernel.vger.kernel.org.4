Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E705F96B6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 04:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiJJCCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 22:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiJJCCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 22:02:42 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5AA53D17;
        Sun,  9 Oct 2022 19:02:40 -0700 (PDT)
Received: from kwepemi500022.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Mm2B72QLdz1P70Y;
        Mon, 10 Oct 2022 09:58:07 +0800 (CST)
Received: from huawei.com (10.67.175.34) by kwepemi500022.china.huawei.com
 (7.221.188.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 10 Oct
 2022 10:02:38 +0800
From:   Ren Zhijie <renzhijie2@huawei.com>
To:     <laurent.pinchart@ideasonboard.com>,
        <tomi.valkeinen+renesas@ideasonboard.com>, <airlied@gmail.com>,
        <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Ren Zhijie <renzhijie2@huawei.com>
Subject: [PATCH -next] drm/rcar-du: Fix undefined reference error
Date:   Mon, 10 Oct 2022 01:58:56 +0000
Message-ID: <20221010015856.248029-1-renzhijie2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.34]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500022.china.huawei.com (7.221.188.64)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If DRM_RCAR_MIPI_DSI=m and DRM_RCAR_DU=y,
gcc complained about undefined reference :

drivers/gpu/drm/rcar-du/rcar_du_crtc.o: In function `rcar_du_crtc_atomic_enable':
rcar_du_crtc.c:(.text+0x1958): undefined reference to `rcar_mipi_dsi_pclk_enable'
drivers/gpu/drm/rcar-du/rcar_du_crtc.o: In function `rcar_du_crtc_atomic_disable':
rcar_du_crtc.c:(.text+0x3cf4): undefined reference to `rcar_mipi_dsi_pclk_disable'

To fix this error, add select DRM_RCAR_MIPI_DSI dependency to config DRM_RCAR_DU.

Fixes: 957fe62d7d15 ("drm: rcar-du: Fix DSI enable & disable sequence")
Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
---
 drivers/gpu/drm/rcar-du/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rcar-du/Kconfig b/drivers/gpu/drm/rcar-du/Kconfig
index c959e8c6be7d..23f6aa70f4cf 100644
--- a/drivers/gpu/drm/rcar-du/Kconfig
+++ b/drivers/gpu/drm/rcar-du/Kconfig
@@ -7,6 +7,7 @@ config DRM_RCAR_DU
 	select DRM_KMS_HELPER
 	select DRM_GEM_DMA_HELPER
 	select VIDEOMODE_HELPERS
+	select DRM_RCAR_MIPI_DSI
 	help
 	  Choose this option if you have an R-Car chipset.
 	  If M is selected the module will be called rcar-du-drm.
-- 
2.17.1

