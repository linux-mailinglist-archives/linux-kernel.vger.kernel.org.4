Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09F96A2A9F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 17:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjBYQDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 11:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBYQDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 11:03:04 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5288113ED
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 08:03:02 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so4304289wmb.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 08:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/2HES7YJYG6wdjYxPV+3ewSssuf+BgawA5HJPMTCWY=;
        b=Bd9lZESTgYO9OWlWOtNgDM/TuKjeeH2cyc2TzDdOWHZLPyVyfUwJ+c3MhlDO02y0e0
         KN10IsntPQuRIYRoPXGIj8eJFOLC/VY0h4TjpspWoz/gl9faN+orqft6idcWGQtQoLsU
         QSwd5a5fk7P6p8AvN9r+veMXUeC+XHA/za/epqDZpy2zqm2AKDQqetZE1GKdx+s0SOq8
         pyXW6ywBmfaYj911hI/i1N0HGU49LkU6/1tsXHhWbTFs4LXCeCTOfJIP25n28cl/H77V
         VVhpSn8K5YbaM66ZKXXefQjXUk07YJYhv2I50fA1X0ZCOy1S5hbwFdVf3Hxn1MxihAaE
         B61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/2HES7YJYG6wdjYxPV+3ewSssuf+BgawA5HJPMTCWY=;
        b=44ztMiNbVyMVIUOmY+j2xPlrBXM5DyqiI62kYRihUITS2vyH4mDcsBgU2sB4OyOFCT
         4TDf0NDiiTWunSIHM82TpiOSwNlAmvv4bFNUDt849zbx2ZznLok+7ohEegKkhebyecB4
         fsgLFQbGKDu8j4mSkT1vubcxRUgSqw+MOCmK01/OJzdWAATlL4igwvsBwwIXJ4W7bkPL
         5cfZmQHAUyMpG1MYJl2+Y7Nl9Gjt3UHUoe1esSUjJQvGEXqOt6LstlrGh/530EHEjXPZ
         scZO0+GY0zgV1Ir2WkhdrPt+iddqI1s2L9ZKJ/SNiMkp1HQLHkmzugZzHnhl45pehEI2
         fMZQ==
X-Gm-Message-State: AO0yUKVC6NnzgJ4/ZrPQnkuK+wMJk5O9V9nbHUIZ603ncsC574kkWouQ
        S+ywujqCXS7IB/mADHIQX619rg==
X-Google-Smtp-Source: AK7set/nFgtU44u0s2ZGliuMXyDDD4aNmehE54BeMxWYYIi+ECKVGKMkEvFNRexR38HlOZYgBw6DLg==
X-Received: by 2002:a05:600c:3413:b0:3eb:2de9:d01 with SMTP id y19-20020a05600c341300b003eb2de90d01mr3382674wmp.18.1677340981217;
        Sat, 25 Feb 2023 08:03:01 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id fc19-20020a05600c525300b003e215a796fasm3266868wmb.34.2023.02.25.08.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 08:03:00 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ARM: dts: exynos: add ports to TC358764 bridge on Arndale
Date:   Sat, 25 Feb 2023 17:02:52 +0100
Message-Id: <20230225160252.18737-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230225160252.18737-1-krzysztof.kozlowski@linaro.org>
References: <20230225160252.18737-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Toshiba TC358764 bridge binding expect up two ports as it is a
bridge, thus add ports property to encapsulate them.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/exynos5250-arndale.dts | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index 2e3da5670bc2..c03bb436bfed 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -192,12 +192,15 @@ bridge@0 {
 		vddio-supply = <&vcc_1v8_reg>;
 		vddlvds-supply = <&vcc_3v3_reg>;
 		reset-gpios = <&gpd1 6 GPIO_ACTIVE_LOW>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		port@1 {
-			reg = <1>;
-			bridge_out_ep: endpoint {
-				remote-endpoint = <&panel_ep>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			port@1 {
+				reg = <1>;
+				bridge_out_ep: endpoint {
+					remote-endpoint = <&panel_ep>;
+				};
 			};
 		};
 	};
-- 
2.34.1

