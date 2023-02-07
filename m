Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778A868E279
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 21:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjBGU6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 15:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjBGU6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 15:58:46 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11C813DE7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 12:58:42 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id f23-20020a05600c491700b003dff4480a17so1422649wmp.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 12:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PoMfks5Pi2TAoCgRVsoQ1C6g7O43cRdI/G6Mr7ISRn4=;
        b=rqB6aQWQXXK0ao4JHOkfgdGuPUpCbCE2deHTaQQffNIrwCaCjse2g8b0W9RZzk5DYF
         4OPSf2Ny5DW3A5rqDgqk2VfPJSlS8NQ5iOs/s/md60pjpOqm3Wv5lGN+opgQAz055zbZ
         dEsY6iu27kXRwanAzT7WfUT1kp0AhEvXZB/9T7QR72HhHO0odF9VHXV3jWTr2Ydo98zf
         thLTDWrNHOWPciBFNe1eMzLrJ0NPqw7s1s08/STrDABCE/qdy79Vf0DdSl2pXVMpsjSh
         H8s8X8tfvknB180sxMePHNAkDigo0kbZ9Y3yFpxIgf2wGE/dSaNN4wC0cmVHbnViguta
         hcOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PoMfks5Pi2TAoCgRVsoQ1C6g7O43cRdI/G6Mr7ISRn4=;
        b=LoS/xnCPt62EM/TfVkb4tniRAG3QmnsLc2HuZohBFZkhR60y2Z6qfT0TRqAk4+H4QV
         2XPIKjZ425qrO7LTAp5/m5Y0p4UNbAOOMG8yNHiaFlQwi1yWnH7F1EAmYM95OzZnXl/d
         BnW5gIE5mDe/nGQSLpiBX9WMmPRML10Kcmx1bGgX75yNaa/QMUAGgYwnf/eac+m03NwR
         7kI1WKAXoOUzh+13KwGwdsMjQMJuEAgG/5aY65rFYhTCEYYkhvKBeZfSwDY4rXnw6zdm
         XBSpqE8FMaZHSz1qPq5N2kE7vSx2iABQyn5HAUOPI6mw2iVhtpyer+1zQQak+XcK7OzL
         AsoA==
X-Gm-Message-State: AO0yUKUWX90VKXB00FQHxpIcz7o7jLYOCSgeO2wOnu6uOSb3Qh0lR/JI
        HTsKz/N4b14LA+6UGS8gfuKBPg==
X-Google-Smtp-Source: AK7set8Q72ioTFcT19F9jM5+EYeJZLiNJr2rD2fLqftya65j/IfRY0HWMv1i/xlLir0XRTm0WZEADg==
X-Received: by 2002:a05:600c:3d0e:b0:3df:efdd:9dc7 with SMTP id bh14-20020a05600c3d0e00b003dfefdd9dc7mr281774wmb.10.1675803521352;
        Tue, 07 Feb 2023 12:58:41 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h27-20020a05600c2cbb00b003db12112fcfsm16555649wmc.4.2023.02.07.12.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 12:58:41 -0800 (PST)
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
Subject: [PATCH v2 1/4] media: dt-bindings: samsung-fimc: drop simple-bus
Date:   Tue,  7 Feb 2023 21:58:31 +0100
Message-Id: <20230207205834.673163-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Changes since v1:
1. None
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

