Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2C65B7894
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbiIMRpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbiIMRpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:45:01 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4916557F;
        Tue, 13 Sep 2022 09:41:09 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id s14-20020a17090a6e4e00b0020057c70943so16214955pjm.1;
        Tue, 13 Sep 2022 09:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=A2Rj9sS1Fjs/+fiIRS4OKQZgMWnN/d2vmPGQj8QoUOc=;
        b=JoxbvLwkdMyeGanYCTnaRBN2DRM/rPM8P6QeFl2hBucjmx5QFD+IBAOb5AlnDmCVWZ
         2mrTN3uilrdOUaEUHxWOxkPLJD32AGcC8WTtVbxtbbB/JgwczNJoF6JohCYAq+Qog00B
         UKl9dy+sY/mAhgB+CG0h/G1dpMLKvVKfMTvNKWm9LpWjz+bGce/Wf1SShTCo8vXAg8iJ
         5yl8Jxe02gHo5XL8P5fP2fFXgKvsQWAZ6KhIxUFrjozvb+TWWrnfTNH9YljiEnhpip8u
         EoEMc83Zeu9CKRPTG5X6Ll0dCKlH9HGrUxV9y1/krNA11TARNDE39MHs9sPiNXOM9TBv
         EJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=A2Rj9sS1Fjs/+fiIRS4OKQZgMWnN/d2vmPGQj8QoUOc=;
        b=kLr0BRjDchnytGdqGMYQt375Zk+Pa330ptw2MQLP2n9KmUYSE3KKdMmRi3CIRhBdzR
         S3gzirZlBLbo3dpo+jrL55J7abWLsC5Gaj8NfuspjuvjZl/DHadkKzkOlBwwa3xaB/P7
         Sb0U9bpr2Me8z+bDwGMUemwFYrArfYDUAz9hV+0Tq0c9N2GpDeH5D8vg/GahPRGtNKl1
         KQEFgXesB8hcGoP3EfDz0a0GtATJJhcSXhgn4V0heqR9s2raFZy1RnKIb1NehudqFuM4
         vKfls1cqRSFn+e/KG4ebrj2wlbGlZ0Hqt/Y6Z2A1xBU21tI7xDnoglUqvbhL8HG80UEs
         xiiQ==
X-Gm-Message-State: ACgBeo3Nz9teiPUXtAq5AmH9xYt2yHYktjiRgFCg8Mf1UPLKM73BH039
        BKt4y9GfN/CD/ie9auNwqUg=
X-Google-Smtp-Source: AA6agR5F+IVKnrECVDn3p+yIBcUysGjy3zydDPF8816rl1m7DIno6uJ83cFOyLfmocT/NP3Gff/JGA==
X-Received: by 2002:a17:902:8d8a:b0:16f:21fb:b97a with SMTP id v10-20020a1709028d8a00b0016f21fbb97amr32266273plo.160.1663087268831;
        Tue, 13 Sep 2022 09:41:08 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:b126:15e1:55ae:d9eb])
        by smtp.gmail.com with ESMTPSA id g3-20020aa79f03000000b005465ffaa89dsm1798449pfr.184.2022.09.13.09.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 09:41:08 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: exynos: correct s5k6a3 reset polarity on Midas family
Date:   Tue, 13 Sep 2022 09:41:03 -0700
Message-Id: <20220913164104.203957-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to s5k6a3 driver code, the reset line for the chip appears to
be active low. This also matches the typical polarity of reset lines in
general. Let's fix it up as having correct polarity in DTS is important
when the driver will be switched over to gpiod API.

Fixes: b4fec64758ab ("ARM: dts: Add camera device nodes for Exynos4412 TRATS2 board")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/boot/dts/exynos4412-midas.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
index b967397a46c5..8e1c19a8ad06 100644
--- a/arch/arm/boot/dts/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
@@ -586,7 +586,7 @@ image-sensor@10 {
 		clocks = <&camera 1>;
 		clock-names = "extclk";
 		samsung,camclk-out = <1>;
-		gpios = <&gpm1 6 GPIO_ACTIVE_HIGH>;
+		gpios = <&gpm1 6 GPIO_ACTIVE_LOW>;
 
 		port {
 			is_s5k6a3_ep: endpoint {
-- 
2.37.2.789.g6183377224-goog

