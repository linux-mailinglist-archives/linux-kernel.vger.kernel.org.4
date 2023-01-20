Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FBB675B88
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjATRbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjATRbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:31:39 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B219EDBE0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:31:23 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso4854085wmn.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyAO0ggLkugTbmjL8T0rTpiHk71ZjtlH8av65wk9BAQ=;
        b=m6tsvSeI4ao0UUTKLDkiByuqXXc2FaQGEzVB9V8E7aqstGcCXgnCGbkAkH0K+EFvgi
         f1y52Lv5vIIo2rH+6keNv+OplditcWJfumyNsk6xEv1ljPFzbtQxoTZon2qi2FJs0Zt4
         VAdvL20Dj6PK3L6so+67nt8e2j3sgDMvNi62NH0NYQLiVZUhSXrnS92o1sKr10AtMEVi
         50SYzQ+l5wPgXaf+B92pb/JUGVPyckOgwpq7rCLct/5cojOJv7sRe8wo4S3hCvNo7lfn
         1dWXdDngtgxMXN0EjiQtp/ZnUzpWWuxgNPP0VvTgXNqgqDMBKrztrMZ/dSy5QbpAN9qi
         VTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KyAO0ggLkugTbmjL8T0rTpiHk71ZjtlH8av65wk9BAQ=;
        b=7Bav83INpyIsJ+hyq5sO5CuKM1HZYlYaN36KWc3mDiu0HVpDPxDj0oSPWy3+BFOLmq
         EnRbqhENBIDR7aTN0HI2SiLUgS5BYolMOEZQR9vPhxKm4xN0tTT/Rdm+jMvOG43p9VXG
         +6LrrS/B0JCm4qoeB8ML38PURc/ywnA2MxtncF5ejOUanvT5dlVofMHSbW+ILbGtrzs7
         emly5mE/+8qhzhyVEDSoqgL0gfUtdGC2wmuQelf/e2ghiw2nKoizXMP3o1qbwGinwpeC
         jKi7fjqHuI4gZX62wSr06cMPy8XLQOU9ZWp59kSsa82J523LXYPLJotzCpI39zxBH8nB
         wj7w==
X-Gm-Message-State: AFqh2kqzKttlTONs8Vy10NHEXQaPjg/3mY9Hzjdze8nfIxRY2FAeaWnX
        p6Qk8rnbXA3Dv/hF4AIoGys9AQ==
X-Google-Smtp-Source: AMrXdXskZLKqyM0OBnAZtcD8h/EPC2ylTQFXkugT8TggR3ynJAOHqiZHz9cmQ72VKbksu9/gjkHOqA==
X-Received: by 2002:a7b:c4d7:0:b0:3db:2fc6:e124 with SMTP id g23-20020a7bc4d7000000b003db2fc6e124mr3624107wmk.7.1674235883284;
        Fri, 20 Jan 2023 09:31:23 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id d22-20020a1c7316000000b003db0dbbea53sm2819179wmb.30.2023.01.20.09.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 09:31:22 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/6] arm64: dts: exynos: correct Bluetooth LED triger on E850-96
Date:   Fri, 20 Jan 2023 18:31:13 +0100
Message-Id: <20230120173116.341270-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230120173116.341270-1-krzysztof.kozlowski@linaro.org>
References: <20230120173116.341270-1-krzysztof.kozlowski@linaro.org>
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

Switch source of LED activity to hci0-power from RX, to match bindings
(same effect expected):

  exynos850-e850-96.dtb: leds: led-5:linux,default-trigger: 'oneOf' conditional failed, one must be fixed:
    'hci0rx' is not one of ['backlight', 'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer', 'pattern']
    'hci0rx' does not match '^cpu[0-9]*$'
    'hci0rx' does not match '^hci[0-9]+-power$'
    'hci0rx' does not match '^mmc[0-9]+$'
    'hci0rx' does not match '^phy[0-9]+tx$'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on:
https://lore.kernel.org/all/a85c256af01f64389a078c2b37c3b72a27d97536.1668005062.git.geert+renesas@glider.be/
---
 arch/arm64/boot/dts/exynos/exynos850-e850-96.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts b/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
index f52a55f644f7..6ed38912507f 100644
--- a/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
+++ b/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
@@ -106,7 +106,7 @@ bt_active_led: led-5 {
 			gpios = <&gpg2 7 GPIO_ACTIVE_HIGH>;
 			color = <LED_COLOR_ID_BLUE>;
 			function = LED_FUNCTION_BLUETOOTH;
-			linux,default-trigger = "hci0rx";
+			linux,default-trigger = "hci0-power";
 			default-state = "off";
 		};
 	};
-- 
2.34.1

