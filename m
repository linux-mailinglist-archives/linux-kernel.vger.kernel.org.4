Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4C45EB255
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiIZUiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiIZUiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:38:24 -0400
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E1FA7ABC
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 13:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:From:Reply-To:Subject:Content-ID:
        Content-Description:In-Reply-To:References:X-Debbugs-Cc;
        bh=6mMntl/NSx3pI8k7cwocEGZTr8TFwyTDRITg/BPF9cE=; b=jsOYLfELogFtxXpumU7TR84MXy
        Eu1UFVHsGD3Cj6UmLrM/ZTUSNvZz/xc6ldsssTnH8FS6td7ee6m/LX31WwRxDiUukhQrcskxUWWkT
        VoPG1wrRFuybvausa2AhjVXJF8dX6aOJ6YQ47vA1lpmZCMp/kUCCS4hSkeY3RDcYntCEbgalmkvXm
        BGUZHDyOTnFsAsPuuxGwC8hDb+YB+3WDlK8eKaoECB53D6G2BeeeYOXlW/V7bdBM+laONV31EMmhv
        9YuLdNrFUlYxWTL81SdBPAz6d/d/i058J3xiyHd5I6RgnRbx8vv/mehnwKmO6yBVImUXYrcJSHKC/
        3ss+EE/Q==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1ocurd-00BDVl-KH; Mon, 26 Sep 2022 22:38:05 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1ocurd-0001Q2-0I;
        Mon, 26 Sep 2022 22:38:05 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     linux-kernel@vger.kernel.org
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR ROCKCHIP),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support)
Subject: [PATCH] drm/rockchip: dw_hdmi: filter regulator -EPROBE_DEFER error messages
Date:   Mon, 26 Sep 2022 22:37:52 +0200
Message-Id: <20220926203752.5430-1-aurelien@aurel32.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the avdd-0v9 or avdd-1v8 supply are not yet available, EPROBE_DEFER
is returned by rockchip_hdmi_parse_dt(). This causes the following error
message to be printed multiple times:

    dwhdmi-rockchip fe0a0000.hdmi: [drm:dw_hdmi_rockchip_bind [rockchipdrm]] *ERROR* Unable to parse OF data

Fix that by not printing the message when rockchip_hdmi_parse_dt()
returns -EPROBE_DEFER.

Fixes: ca80c4eb4b01 ("drm/rockchip: dw_hdmi: add regulator support")
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index c14f88893868..2f4b8f64cbad 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -565,7 +565,8 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 
 	ret = rockchip_hdmi_parse_dt(hdmi);
 	if (ret) {
-		DRM_DEV_ERROR(hdmi->dev, "Unable to parse OF data\n");
+		if (ret != -EPROBE_DEFER)
+			DRM_DEV_ERROR(hdmi->dev, "Unable to parse OF data\n");
 		return ret;
 	}
 
-- 
2.35.1

