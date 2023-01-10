Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCA0664E68
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 23:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbjAJWAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 17:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbjAJWAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 17:00:01 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BA85E67C
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:59:59 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id v6so19638189edd.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0A+/pPY0W2OxmXPlRQSeFoMNoHET+WW3usLT6qwTWY=;
        b=aIpvCIGAwOgQjufdkkd5GSNKjB+lf9wFH6o0d1WaYDrRosC5hOLLtnLqnfxO9KpnxX
         v8An28tZ4VLFpOuwxwNrK0l3IwNEmI//2nmOP7I9fyBBOk4F4GozRBb4duQnfjqcBq6b
         jvFuzxh4HJm5MiKcMsKWzOh9W0VZqQOk4ecAUVtHUpN92rHlGcl4ZDZCtOfOhLSxFRoO
         Ge/4NTaCTW1Vbo4uezonVtRcnr+o+De1aMqDs4hmAS61UDC3LehNtAWnl12G73hyFjQ0
         oviRoIDpTOWX1PmfjyBI9iZygUk+twQuHnAh1qbgjb4NVkYXQF5ms0puvfCvYtuwW+D0
         LMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q0A+/pPY0W2OxmXPlRQSeFoMNoHET+WW3usLT6qwTWY=;
        b=GY+4lAgm0bqjNau1aNXNyNRJAkyeg9m0ypZ86290WVAizUsQhDpOW9SpoL7tD7EGbn
         omS/CkQkFwRnqxD2e/lseImokQDPxLFLX25P4vMZH2kRMsYd6yKJKsiq9iDdpdQDLI+M
         pHbHFQPLcvg93m33Gku1+yYENxj8M1PGFhOQw9J5yO+KC5GUUk1/B8RDoFEn/xVxFbQw
         wfp6F9NXlbsIiKqOTw1qlhgJZyJFg+qtWN+ZLKMx4PStqBiwoaDwiPaMeGXR0VXAGNKC
         BpyyAMg1m5ilv99ddXZk0+NXxvyJ/WS+WDkbjSaN+NMGOtcddJz9xODZndp6R2iMxzu5
         xvlQ==
X-Gm-Message-State: AFqh2kq6zUlsdx5/3333Brfo8YEBMh8VdQCbM4vOrWuyH02LJvSQKBZ/
        nguHvSdwVkcyvlpHbV0LhK8=
X-Google-Smtp-Source: AMrXdXuRHK1VxAGfGdIkJTw+9270rhsZ6x/sWQPH/c4KLwONK8PwwroGF4w0l9X3gKmACLCMDfGoaQ==
X-Received: by 2002:a05:6402:1f89:b0:47b:16c7:492c with SMTP id c9-20020a0564021f8900b0047b16c7492cmr68452406edc.25.1673387998327;
        Tue, 10 Jan 2023 13:59:58 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-7880-b900-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:7880:b900::e63])
        by smtp.googlemail.com with ESMTPSA id cz26-20020a0564021cba00b0048ea96cb900sm5404408edb.23.2023.01.10.13.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 13:59:57 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        adeep@lexina.in, khilman@baylibre.com, neil.armstrong@linaro.org,
        jbrunet@baylibre.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] arm64: dts: meson-gxl: jethub-j80: Fix WiFi MAC unit address
Date:   Tue, 10 Jan 2023 22:59:26 +0100
Message-Id: <20230110215926.1296650-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unit addresses should be written using lower-case hex characters. Use
wifi_mac@c to fix a yaml schema validation error once the eFuse
dt-bindings have been converted to a yaml schema:
  efuse: Unevaluated properties are not allowed ('wifi_mac@C' was
  unexpected)

Fixes: abfaae24ecf3 ("arm64: dts: meson-gxl: add support for JetHub H1")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts     | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
index 6831137c5c10..4f742e1b9301 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
@@ -90,7 +90,7 @@ bt_mac: bt_mac@6 {
 		reg = <0x6 0x6>;
 	};
 
-	wifi_mac: wifi_mac@C {
+	wifi_mac: wifi_mac@c {
 		reg = <0xc 0x6>;
 	};
 };
-- 
2.39.0

