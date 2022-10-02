Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C906A5F2199
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 08:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiJBGqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 02:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiJBGpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 02:45:53 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123C92EF08
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 23:45:52 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id sd10so16586445ejc.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 23:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=gtEJxbrwC/UQVf48sJy2NN3O3k5LpfsDQAoSkyusABE=;
        b=omdSgHFqEeX0hz1EWZZH2RbIMxysW7X/8zVjSEW3VJR+LCkBpPE1odjPVGPcB0lmXL
         5PJDNgHjB0mFXedPPBGByQdvcpVTTIQqvLpluO80BG3siD9Ih2PB8ZIkB6EHqPAuoGBZ
         BMd1fJ7hXzIUUDLgy6PF9mV9Ss/a4NsufzCvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=gtEJxbrwC/UQVf48sJy2NN3O3k5LpfsDQAoSkyusABE=;
        b=pl/6iDizsiODix8w6zUTM9tfT2tYLlMXswNErzjzrx7kEdDPVFr6oy9tCRsVdfax0U
         YS+KwfjTvLzy/FRs/yZ2Hke4kMED9v2/YboTMCwHofdC42gYzfpY97LM4fKa0u0V5FHz
         TsstBpkAOdHwlKq4QGXWbgqUe0mLOkaU91MEkqiIs0cM450qk1B8BNDHHisQhuuvyafH
         jRCNIQnwBZqSICg4jm9Tjfw6sksceAUL0hHjFxotjV1LMcJvarNJ4CFi2CRGt0kgm6cc
         jYlxBiS9tg3qAqRj6Vof6bEiivcngvlrKsozJnjtkQ0Z3hT4MeqQdx38A4qfOLU4cm2y
         YhlQ==
X-Gm-Message-State: ACrzQf3ippVX4L6i0oYFdBNzfSwyJHBBkyUywO9tj4Wp/aFeq3zAzmlf
        ZemAi1fH6X6v0a7Xn04V22Zu3Q==
X-Google-Smtp-Source: AMsMyM4nEOYig64C0tZ3Z7ad76GYPRbuqYMOi4q6qDnpwgFsU96JrriTtL5fgxNnqfSki698dg6/Lw==
X-Received: by 2002:a17:907:3205:b0:770:8554:c4ee with SMTP id xg5-20020a170907320500b007708554c4eemr11785485ejb.39.1664693150522;
        Sat, 01 Oct 2022 23:45:50 -0700 (PDT)
Received: from panicking.. ([109.52.206.103])
        by smtp.gmail.com with ESMTPSA id 26-20020a170906329a00b0077f5e96129fsm3569894ejw.158.2022.10.01.23.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 23:45:50 -0700 (PDT)
From:   Michael Trimarchi <michael@amarulasolutions.com>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-amarula@amarulasolutions.com
Subject: [RFC PATCH 4/4] drm/rockchip: rgb: Add dphy connection to rgb output
Date:   Sun,  2 Oct 2022 08:45:40 +0200
Message-Id: <20221002064540.2500257-5-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221002064540.2500257-1-michael@amarulasolutions.com>
References: <20221002064540.2500257-1-michael@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dispite the commit 1f0f015151727, the rgb output has an option
to allow to sent the output pin using the dsi/lvds/ttl logic.
The only way to do and stay on the same design is let the
rockchip_rgb block to grab the handle if it is present and
enable it. The present of this handle depends on dts configuration

I have a full working example with an hardware with mixed lines
on direct logic and using the phy, with the follow dts example:

panel: panel {
	compatible = "panel-dpi";
	...
	panel-timing {
		clock-frequency = <30000000>;
		...
	};

	port {
		panel_rgb_in: endpoint {
			remote-endpoint = <&vopb_out_rgb>;
		};
	};
};

&vopb_out {
        vopb_out_rgb: endpoint@2 {
                reg = <2>;
                remote-endpoint = <&panel_rgb_in>;
        };
};

&vopb {
        status = "okay";
        pinctrl-names = "default", "sleep";
        pinctrl-0 = <&lcdc_rgb_pins>;
        pinctrl-1 = <&lcdc_sleep_pins>;

        phys = <&dsi_dphy>;
        phy-names = "dphy";
};

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 drivers/gpu/drm/rockchip/rockchip_rgb.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_rgb.c b/drivers/gpu/drm/rockchip/rockchip_rgb.c
index 75eb7cca3d82..c725774a0f40 100644
--- a/drivers/gpu/drm/rockchip/rockchip_rgb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_rgb.c
@@ -8,6 +8,7 @@
 #include <linux/component.h>
 #include <linux/media-bus-format.h>
 #include <linux/of_graph.h>
+#include <linux/phy/phy.h>
 
 #include <drm/display/drm_dp_helper.h>
 #include <drm/drm_atomic_helper.h>
@@ -30,6 +31,7 @@ struct rockchip_rgb {
 	struct drm_bridge *bridge;
 	struct drm_encoder encoder;
 	struct drm_connector connector;
+	struct phy *dphy;
 	int output_mode;
 };
 
@@ -168,6 +170,22 @@ struct rockchip_rgb *rockchip_rgb_init(struct device *dev,
 		goto err_free_connector;
 	}
 
+	/* PHY */
+	rgb->dphy = devm_phy_get(dev, "dphy");
+	if (!IS_ERR(rgb->dphy)) {
+		ret = phy_init(rgb->dphy);
+		if (ret)
+			return ERR_PTR(ret);
+
+		ret = phy_set_mode(rgb->dphy, PHY_MODE_TTL);
+		if (ret)
+			return ERR_PTR(ret);
+
+		ret = phy_power_on(rgb->dphy);
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
 	return rgb;
 
 err_free_connector:
-- 
2.34.1

