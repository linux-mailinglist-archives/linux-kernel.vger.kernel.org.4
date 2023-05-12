Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0056C7008C9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 15:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241196AbjELNMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 09:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241075AbjELNMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 09:12:02 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4851712EB1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 06:12:00 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f315712406so321519895e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 06:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683897120; x=1686489120;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z2u4iA556Q3YLEzTDMSIWMB9153khMSJN9i27z6trtw=;
        b=UIqCieSWYin+oz7auJGatVSLrMXRlfI0zD77cvuETRm9Sek6lJ8Liof7+r3WSkCAeZ
         cmkN0Pknbc+9VD0MGtDqwD5ykfUdJ1+U2MTrceMwfZvj4X63vrUoBAkLTbsPS5QT2r+q
         Yf0DcpGJzqqVuWyl9Gsw7Jpzm+t8jzan5aZBkrdVLZUDZUH8kzchGM15V9DKz9nTHtTE
         wtTDqAZvbDrYjtXG0lGh6YA28042KBdSrCbQ60U0YpawPAwtjLmUkXJkW1wEHAdsrQH1
         7BAMPCbYSckLhcD7TlmXVCcdq3ePnLNK7w/k5/OCPQpcyFYMFiRro20FLqw4rE28r3jJ
         Fd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683897120; x=1686489120;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2u4iA556Q3YLEzTDMSIWMB9153khMSJN9i27z6trtw=;
        b=ZFz4VhzIYR6pnFT7mOs5slvOJx3m04DpRPqbCkICjQ5I8ROFjD12skRI+qx9s9nUZF
         7a1SovXByBX14jyeeEF/xt+hDpd80g2hv/tOimF0kyA86wILXjKj151x2vul/Z/KiKk3
         X34XLohgcGRsx6+zc552DqFyV+HYU6Izt5hGih9/d8KKBBX/Q+zRp3Hy1ySon7p7Zm72
         PCAWe2t6xEQJ3+vc2dqjlncoDQ+ebK8E1U4m+b9Ck9v6l0WNBmPQD6PTguYK1JLFMm4z
         lrHG3WUgJSjd+oe0R/w7ijhRKcqTIkvbHxEPipu+RqQZwrRptCVdSTxoYFaLXvmmw4HM
         bPvQ==
X-Gm-Message-State: AC+VfDybHO0oH2vqwqaRO/OOohoEcy7d/iL4jr8DIuYolvfqXKPxrGj8
        OTKFIWe4h1lksaOTz/MKG+C6rw==
X-Google-Smtp-Source: ACHHUZ4Lpk6BMX1cUJbI+yBItJVI1j+yCCvXCZzw7+9gNnPJg3syKo8+U4tcTOu7JpVmH1Zi5RRfmA==
X-Received: by 2002:a7b:cb93:0:b0:3f4:2374:3511 with SMTP id m19-20020a7bcb93000000b003f423743511mr13961936wmi.10.1683897119822;
        Fri, 12 May 2023 06:11:59 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id v10-20020a5d610a000000b0030647449730sm23461965wrt.74.2023.05.12.06.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 06:11:59 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 12 May 2023 15:11:37 +0200
Subject: [PATCH v4 06/13] drm/meson: fix unbind path if HDMI fails to bind
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-6-2592c29ea263@linaro.org>
References: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-0-2592c29ea263@linaro.org>
In-Reply-To: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-0-2592c29ea263@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Nicolas Belin <nbelin@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-phy@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2139;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=wXntKS2MMfbFGVJHEKvTbL5c60ujsPIrzZFwFPZkQn0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkXjsUe2Bl34Y1X3oYbjtzCiQcgLvemuSQ6t+LekDO
 xNWliTuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZF47FAAKCRB33NvayMhJ0SyLEA
 CJbVHW7/fL6lQG5TdpE4H3PQA+IisR16XaLpnTihPM0NgB8lHdrDxpzS3OHp0RyypkLUzfWqjb45Ns
 iuTpf4zgdW9Diou+fZuBOgOdhrKKRF7F4MNzCU1C8HSPTv7ZxhMvOpHLps5eXd6GwCd/N9Y7QMWnRn
 sumQ/pV3R+yl3knCPdKvCbNjR2dHMEbfQq9MvPWo45MwXSXGnV0jXmX0ZbXiC08vLPBQDnKlse4VeS
 8+hDOW8c/NG7xOpnVLO51YWrQblNWBl7ZqeVVX85DKUFkQ9/L9G9BrAy9WP395oAe6AhBWzh8ilUIS
 Zz3amS2N9WWigj3k/1a+RXLzlizOuoRXTZT144Q/y3+caNLnzbwP3Uag41YtLmxGuw4wqc1n/qSBCl
 bE960wuDbE2VaqoTKiH/bLCqUCwC7ytpMOgRC2r6jlbduGQwmyZf+LUStJx9KHVt6XAqycBfjoilXU
 Lx3QgqtqVFEQOMWwhIypsE1/cY8Pg09299hheyNtQ225CaQGHIQN//dq3KDp/EBptUHa0FlKuWiaY3
 qD7iobfzR+Cm1nz1gz0Tlfm427bSmxQTySUahYcW0fztQgCCuFkbmC5dKJrpawjcnDDNYMqPaLjngt
 lIy0v4JZ+3OiiXMWgkoYdtDoVkXxxtF2ydKv6pYykjslmWkIIG2QMovNrcrQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the case the HDMI controller fails to bind, we try to unbind
all components before calling drm_dev_put() which makes drm_bridge_detach()
crash because unbinding the HDMI controller frees the bridge memory.

The solution is the unbind all components at the end like in the remove
path.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/meson/meson_drv.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index bb72fda9106d..a30d61f1c817 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -316,32 +316,34 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 		goto exit_afbcd;
 
 	if (has_components) {
-		ret = component_bind_all(drm->dev, drm);
+		ret = component_bind_all(dev, drm);
 		if (ret) {
 			dev_err(drm->dev, "Couldn't bind all components\n");
+			/* Do not try to unbind */
+			has_components = false;
 			goto exit_afbcd;
 		}
 	}
 
 	ret = meson_encoder_hdmi_init(priv);
 	if (ret)
-		goto unbind_all;
+		goto exit_afbcd;
 
 	ret = meson_plane_create(priv);
 	if (ret)
-		goto unbind_all;
+		goto exit_afbcd;
 
 	ret = meson_overlay_create(priv);
 	if (ret)
-		goto unbind_all;
+		goto exit_afbcd;
 
 	ret = meson_crtc_create(priv);
 	if (ret)
-		goto unbind_all;
+		goto exit_afbcd;
 
 	ret = request_irq(priv->vsync_irq, meson_irq, 0, drm->driver->name, drm);
 	if (ret)
-		goto unbind_all;
+		goto exit_afbcd;
 
 	drm_mode_config_reset(drm);
 
@@ -359,15 +361,18 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 
 uninstall_irq:
 	free_irq(priv->vsync_irq, drm);
-unbind_all:
-	if (has_components)
-		component_unbind_all(drm->dev, drm);
 exit_afbcd:
 	if (priv->afbcd.ops)
 		priv->afbcd.ops->exit(priv);
 free_drm:
 	drm_dev_put(drm);
 
+	meson_encoder_hdmi_remove(priv);
+	meson_encoder_cvbs_remove(priv);
+
+	if (has_components)
+		component_unbind_all(dev, drm);
+
 	return ret;
 }
 

-- 
2.34.1

