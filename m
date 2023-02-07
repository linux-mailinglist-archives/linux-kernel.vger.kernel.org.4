Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C8B68E136
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 20:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjBGTaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 14:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjBGT3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 14:29:47 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772B83EFE0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 11:29:21 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ba1so10575961wrb.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 11:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8w0MpZ2V4rLYFppvKGuA9m6PNERjPDODLlDLq+kfjPs=;
        b=woz3ID5u3YeS4AXaGqdutfXO9eSzuXNOLyF41ssaOAEufE0kNsS7bUpAFGyGgpjxLe
         WZDFzfdrIX7h1KW9flxdSs4Br6vTZXw5mzKNcP2mhKfiOd0MqN3f/mTB3bkjcv5WH+6I
         UCLx77fWQkMqeXO0Mh6o37OsY7D9/M7trF9GFJ/HsylJ3PFJNGep88m4kQExYGnLTEoU
         nuDL779dgdLlpnLHsKz5Uk+yBrOLzZYLDdu4KT6OGflkYGuVISrSl4VaT7kZTZb+NZO0
         MNHH6z25P9Zx4RAeLrqy9JleX+epp6urvAtQfTe4pTlESBDld2Ptql1h3BGU4flOKYgh
         Rcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8w0MpZ2V4rLYFppvKGuA9m6PNERjPDODLlDLq+kfjPs=;
        b=j9ARrpgpyvB6ZdPd/G5xsvzCMdnmOs+/LKqj5GP/OpoZHyrCx/ewnjCkMWlI0oLmdp
         OvbPXFj6fo+8T9OASbb4AvkEmWV0xvMxDxg2SZVH/+zHd3QikzsEulD+xKfbsy4HFfea
         zNYCHsIs/Sv4sLZbKwuFIXbfKKu4k7qH6jZcQgcF5PSHoKziAftnLXHBGlvGawCyadpU
         tLj38qPBzt90NA2XcCh25u4BVhQC472ha5CS4pN+LHFPpkL0wXMU4SV/xuIi7SyeW8lu
         BXTaLX+anBH5Jy/7rTa2Eix2YdMyvRMR2GKSYa+MKvuBlTj3di2nbbj7UYA2gUnEwOaV
         Gh9w==
X-Gm-Message-State: AO0yUKWohVWLizWbjuGjIhAWRy+K/pqIKG1Tt8EZtpFkhKHAkLSxlwLM
        9YgbHMUT3Nzyhqhio7d5OXNF1aPQus3Ak/Oh
X-Google-Smtp-Source: AK7set+fKDoZgdl0m3cHJ1U/S0ylQq/28w1ACr5wlTWMsE+Xd2BplfMkuCaDRrTX7zGGg4M/ccU6pQ==
X-Received: by 2002:a5d:4cc6:0:b0:242:800:9a7f with SMTP id c6-20020a5d4cc6000000b0024208009a7fmr3911742wrt.65.1675798159433;
        Tue, 07 Feb 2023 11:29:19 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id bd16-20020a05600c1f1000b003db0ee277b2sm19858623wmb.5.2023.02.07.11.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 11:29:19 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] media: dt-bindings: samsung-fimc: drop simple-bus
Date:   Tue,  7 Feb 2023 20:29:14 +0100
Message-Id: <20230207192914.549309-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230207192914.549309-1-krzysztof.kozlowski@linaro.org>
References: <20230207192914.549309-1-krzysztof.kozlowski@linaro.org>
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

The FIMC camera node wrapper is not a bus, so using simple-bus fallback
compatible just to instantiate its children nodes was never correct.
Drop the simple-bus compatible and expect driver to explicitly populate
children devices.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/media/samsung-fimc.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/samsung-fimc.txt b/Documentation/devicetree/bindings/media/samsung-fimc.txt
index 20447529c985..f90267f1180e 100644
--- a/Documentation/devicetree/bindings/media/samsung-fimc.txt
+++ b/Documentation/devicetree/bindings/media/samsung-fimc.txt
@@ -15,7 +15,7 @@ Common 'camera' node
 
 Required properties:
 
-- compatible: must be "samsung,fimc", "simple-bus"
+- compatible: must be "samsung,fimc"
 - clocks: list of clock specifiers, corresponding to entries in
   the clock-names property;
 - clock-names : must contain "sclk_cam0", "sclk_cam1", "pxl_async0",
@@ -156,8 +156,8 @@ Example:
 		};
 	};
 
-	camera {
-		compatible = "samsung,fimc", "simple-bus";
+	camera@11800000 {
+		compatible = "samsung,fimc";
 		clocks = <&clock 132>, <&clock 133>, <&clock 351>,
 			 <&clock 352>;
 		clock-names = "sclk_cam0", "sclk_cam1", "pxl_async0",
@@ -166,6 +166,7 @@ Example:
 		clock-output-names = "cam_a_clkout", "cam_b_clkout";
 		pinctrl-names = "default";
 		pinctrl-0 = <&cam_port_a_clk_active>;
+		ranges;
 		#address-cells = <1>;
 		#size-cells = <1>;
 
-- 
2.34.1

