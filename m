Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E0E6C97DD
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 22:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjCZUpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 16:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjCZUpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 16:45:33 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F085FF0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 13:45:24 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r11so27966865edd.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 13:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679863523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0i+V8G7VdrK/84+XZ0FJoiVtupVc5YlW2vczBepMrk=;
        b=N4d0IndMuyD4ayxxCiLuUSkQOXoR+pdQhWDyB2S/LO++7YRb/1nBCVGWgUUcENLFFP
         rJ45zYpBmlA4cLr1AgOL8lPYtrovKYY45nBNXQsIHZJ+nwZndhMY5GE0QuX5u5mh9kUK
         /P2TaF7atG3fldx5Yew/xw9RXAG+VYjdg1ePjG18jdVHeOuc6jb0vu34CRZvmJ83/RVE
         MCSmKQPxMh5XsrjZ5goHoF52U6B/ayMozmYtpShO0ZUhDB1lvFkUlD1Zp20Ial+EtBJJ
         wOAKTF+hSboQvl5NyNtxgj9/M4AEobruZNbIxDch0ZAN14gB9ATMOC/zy2p+TcPNn3TV
         VqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679863523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0i+V8G7VdrK/84+XZ0FJoiVtupVc5YlW2vczBepMrk=;
        b=KLdBk5VH0ILolaQ9E55K8cjM/5vPxZ/PNaUSxRhkyNKpajlkPt/AblMM5Gc77mYBAs
         IaDbLQBmVX0cyZYhYM09sqEwXzUOE+M7QsXzneqHHLAyzU3M7gxouNssc/Z2V7KnxE0a
         cslLtYZZR6okQaT80e1wIGj9iPdH9cI7g42GMYgPGjAN4j+6gqPgMFtrTYpFHdSwRRpX
         pku9kkbWvD00G8+EeveXASshMmRtqOxmy0Y+xV3+5xXszdijkbdoQ1PfTgYk9pOJC5x/
         DNB+dsfN6/+oY1WJC04ppTH5Y7llTH6nonmX+BVxjJgwvTH/mcvdUQDQ/pgmm04bdEhQ
         19Pw==
X-Gm-Message-State: AAQBX9cAEkkBQh6wJeZlritn8943QlTBLyRHEDPdzu2gwklUx8qQwG0s
        ItjLcQAXThYI4QL/8YsV+q3Nu8sZTEsaZdw2ur8=
X-Google-Smtp-Source: AKy350ZVWzfpQH3Vv3fya5+Swd9/DQof6OEiE4x/vV5J3lMabZeCVhLRbM1KfCFu1xvTRqLTtZAwPA==
X-Received: by 2002:a17:906:2bc9:b0:939:e870:2b37 with SMTP id n9-20020a1709062bc900b00939e8702b37mr10695350ejg.70.1679863523176;
        Sun, 26 Mar 2023 13:45:23 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6b51:4748:3f3f:ffcf])
        by smtp.gmail.com with ESMTPSA id ga5-20020a170906b84500b0093e23d03d72sm4090982ejb.177.2023.03.26.13.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 13:45:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] arm64: dts: rockchip: use just "port" in panel on Pinebook Pro
Date:   Sun, 26 Mar 2023 22:45:19 +0200
Message-Id: <20230326204520.80859-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230326204520.80859-1-krzysztof.kozlowski@linaro.org>
References: <20230326204520.80859-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The panel bindings expect to have only one port, thus they do not allow
to use "ports" node:

  rk3399-pinebook-pro.dtb: edp-panel: 'ports' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../boot/dts/rockchip/rk3399-pinebook-pro.dts    | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
index 54bb0398128f..ddd45de97950 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
@@ -50,19 +50,9 @@ edp_panel: edp-panel {
 		pinctrl-0 = <&panel_en_pin>;
 		power-supply = <&vcc3v3_panel>;
 
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@0 {
-				reg = <0>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				panel_in_edp: endpoint@0 {
-					reg = <0>;
-					remote-endpoint = <&edp_out_panel>;
-				};
+		port {
+			panel_in_edp: endpoint {
+				remote-endpoint = <&edp_out_panel>;
 			};
 		};
 	};
-- 
2.34.1

