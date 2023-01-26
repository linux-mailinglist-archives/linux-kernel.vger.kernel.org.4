Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1222467D8AE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbjAZWlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbjAZWkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:40:52 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09384EF7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:40:51 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id o5so2624205qtr.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7++FPNmCT11inHBtqfYJtM4/xAJgiLCvorUz1cWzIv4=;
        b=FfWgMmXFYEj9lPeH/Vdv0zqG9hIvMC3dzwgFaJPxJPBQ/Bl/fhkUfEOTaV64Fzy4TR
         QL4milXBTiVyIzRmgCFLJMQjMxFI1fXWYOI9uT/ooir+UY5FQDGo9KkaYI3vaz3v1iXc
         EyCoq6qPTHK1pNFQv/RSJj6ooLeQe1QU1BjuWnsmrXyltSIXYXbtK/AupdJMGD8ZP2X8
         ZE/ibew4ToAU5EzVKFkfnmcLGPIr1d4Y8tAW+5vpghVyZAJ+uWORKCxp1HhhNT7LLeHR
         4Kf4dv5h+c/akVW39GQ3PrMfnysFXSf04gax26PoX9/TEwPnXphQrgEPBYgWaoZbHx+6
         JooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7++FPNmCT11inHBtqfYJtM4/xAJgiLCvorUz1cWzIv4=;
        b=mvmjyjQHoQU8kjzV9uD5x619R5VNjZt3tmZpT0nPOJOT5b35uq3E7CWrvmatVEZmSz
         FNdpLhhbKDJu77zIOIiXSOhClOySVKJpryMFDrKgvpbbMJD/GY6vA7wja47j3HmZtyQV
         p2X0Yv2iZm0UOq2Qws0y3WacFqaIfMjGNnvW7M0bNxgSaDgn8ysqV9LiWGqOEWzvyo4B
         F1+AOcK32XrapXXNa4unf+4nR9cO8yqNYJJk8IrQkkNFiqiFjVKJy3VtYTmnxJkGoxrC
         bR9nMSnPAqv0vR1SfLp263Ut9klEvkacsilaOAbI/+q/OGNwz7jpE1ACKT6dMJ2oNj5+
         +P0Q==
X-Gm-Message-State: AFqh2kr7qfM0j047Bc51nAfPNh3Wm1sNgpYVIbFHZXcWd8pW+319DMsl
        GSiEaUQPmtHW+ruaSiy7Yi4mKQ==
X-Google-Smtp-Source: AMrXdXtNzkgpHvsmeAGerw4Q2mbncA0QO3CZexfZka0EC7XsZpNsJxDhm0PKWk2L8YK7E1xkZrVDbw==
X-Received: by 2002:a05:622a:178d:b0:3b6:35cb:b946 with SMTP id s13-20020a05622a178d00b003b635cbb946mr71952397qtk.14.1674772851400;
        Thu, 26 Jan 2023 14:40:51 -0800 (PST)
Received: from [127.0.1.1] (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id ek3-20020a05622a4fc300b003b68ea3d5c8sm1505678qtb.41.2023.01.26.14.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 14:40:51 -0800 (PST)
From:   Jonathan Cormier <jcormier@criticallink.com>
Date:   Thu, 26 Jan 2023 17:40:45 -0500
Subject: [PATCH v2 4/4] drm/bridge: tfp410: If connected, use I2C for
 polled HPD status.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-tfp410_i2c-v2-4-bf22f4dcbcea@criticallink.com>
References: <20230125-tfp410_i2c-v2-0-bf22f4dcbcea@criticallink.com>
In-Reply-To: <20230125-tfp410_i2c-v2-0-bf22f4dcbcea@criticallink.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Williamson <michael.williamson@criticallink.com>,
        Bob Duke <bduke@criticallink.com>,
        Jonathan Cormier <jcormier@criticallink.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1511;
 i=jcormier@criticallink.com; h=from:subject:message-id;
 bh=mnMRLzTQ5OvUKpoF4H4mdtxVS/UwcOVTBoA/DdsbVck=;
 b=owEBbQKS/ZANAwAKAdzX/S4LNuuqAcsmYgBj0wFuvXkSsXrMPuQIuaE7dqR3P3ABer3/DA77uFMa
 Kse6bIOJAjMEAAEKAB0WIQT/MozqCeZtYxNnVN/c1/0uCzbrqgUCY9MBbgAKCRDc1/0uCzbrqjH0EA
 CuMWARBsza9msRcHworH1ssy/nFvqzq4JbkaBvAIl0CJb4diN58Mnla1QqnkkqHuSAj/Wta4K9JmJB
 XPBdPdsr66l2JKinBGdLAJRJHN6r0BM66hlL5RuizDJHFhfU9WgWiQsz4KoidZh/rUcm2yvODPTR2y
 TS+c4JA5a8mNj6EELvH+dZG3MRdgAot6HEH9yDLjUXz7kMYb5Acz1YmpfKYHnyZUP9OsKopq+iAOs/
 oEB8kr36y6xylEkJfTZyHcAwKpD/5T3Nlk5FcMGQh5BrXqF9X51He1ns5V5fujw/N7Ybrhn+sAdwcB
 iA/w6dhTfeuyRRlyGJo7liNOUEVeu9Qx1EVE11AriFjxFxEC9muC2aVQPZT8OmU7ho9okGhDRkmA6K
 PI9f71y0dUHpZHPzyEoYlwAz/kEVd2U7VnPtJmA//l9AS2z/zk9gLghAMllvkkPgr5ye6khJd+v4O0
 V89ebxTpges+Kbd/oyShBYwRpSh4gYTM4w+RpKg1tB/3FlTempzoX//3/QMAthGRmygseCSDjWM6UD
 uUoHgcxV86Dzfnn2WEyQcRS89AXv4DIF45hiPtOpLd/X/ZSgTOhpkF/50WLKHDT7X1MTEKSYjDxii2
 ivTCGpZLsW6Qv3lF7PR3bbLSzeHEOmUh2MfoYtbMteNMElwBVsJsqY+PIP3g==
X-Developer-Key: i=jcormier@criticallink.com; a=openpgp;
 fpr=FF328CEA09E66D63136754DFDCD7FD2E0B36EBAA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Williamson <michael.williamson@criticallink.com>

If the I2C bus is connected on the TFP410, then use the register
status bit to determine connection state.  This is needed, in particular,
for polling the state when the Hot Plug detect is not connected to
a controlling CPU via GPIO/IRQ lane.

Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
---
 drivers/gpu/drm/bridge/ti-tfp410.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti-tfp410.c
index 41007d05d584..eeb7202452aa 100644
--- a/drivers/gpu/drm/bridge/ti-tfp410.c
+++ b/drivers/gpu/drm/bridge/ti-tfp410.c
@@ -28,6 +28,9 @@
 #define TFP410_BIT_BSEL BIT(2)
 #define TFP410_BIT_DSEL BIT(3)
 
+#define TFP410_REG_CTL_2_MODE	0x09
+#define TFP410_BIT_HTPLG BIT(1)
+
 static const struct regmap_config tfp410_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -105,6 +108,15 @@ static enum drm_connector_status
 tfp410_connector_detect(struct drm_connector *connector, bool force)
 {
 	struct tfp410 *dvi = drm_connector_to_tfp410(connector);
+	int ret;
+
+	if (dvi->i2c) {
+		ret = regmap_test_bits(dvi->regmap, TFP410_REG_CTL_2_MODE, TFP410_BIT_HTPLG);
+		if (ret < 0)
+			dev_err(dvi->dev, "%s failed to read HTPLG bit : %d\n", __func__, ret);
+		else
+			return ret ? connector_status_connected : connector_status_disconnected;
+	}
 
 	return drm_bridge_detect(dvi->next_bridge);
 }

-- 
2.25.1

