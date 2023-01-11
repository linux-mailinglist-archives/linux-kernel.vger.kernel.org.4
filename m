Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8ECE666560
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 22:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjAKVOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 16:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjAKVOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 16:14:11 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DE43F106;
        Wed, 11 Jan 2023 13:14:10 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id i15so24255693edf.2;
        Wed, 11 Jan 2023 13:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yO8dFAy9lMaaw7MiruB5XRKNwqBVqDzEtNURhlDQIyg=;
        b=CkHbDQgssw9maLWDccwTm3a8+1oO50Yg+wcbWGvIKmM1Pz24pcOvvE1vYDfNa2Stec
         70aL+nl8mGNAYo/x+HhXp8MrnqJhypqAERDcRAnwhX723xIhspDj/N5XlP5V1naLG1Cu
         ekglZxKIkAqxU1TbxD1h7HFvMvRchLrE9ODzBYCMtfg/QxRWUZJNBIzzWNOuOdCaBdYk
         I3jZxAoH+3Kv7knmoT9Jc2y+qvjl5LcoWeVH9y0JxoLvys5wgZyN97m8FfrUeEfKhZsf
         zdFXNDy4Fo2flLDLpuJKSWx7z3YhbndbPp6dwKEfr0FimKsKIM+RmahwKPWr0DnmTSjN
         3U0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yO8dFAy9lMaaw7MiruB5XRKNwqBVqDzEtNURhlDQIyg=;
        b=mj2b9Y0GH8ND8xp/Wn5YMp+qB0YE2dKWtHePw6p5g+tUjutITR/sjkqwTlG/rhooSE
         DUmq3qkLjshhfBuKIcHAtgnAvDSapKjGGX2dySzOyLcu2NwjaGso/fy/lNPVo/kl1hGs
         xM1w6b1oSNfWc3DyQY0cBiy5JwrGtp5SrWjYZzwjMhBm0xLUZuSMCjJWtVSsaLQDSaKz
         gZf1tTG3OLycszwbnQmb9zPxFX6t9vw+qehOXhHQAdo83HTkKeTENmBNl77S/i0ZTG7M
         OfVUaABJQI7soGGjB6J9IO4Dxg3dsuf5WQP+UaHd843JqfeOGrWEy/I1hqK/u/jjgMHu
         SlVg==
X-Gm-Message-State: AFqh2kp2OfW4hhf+2PZ3arFSkwweaw3Gn0efc0Ay717m08lQf2AQHOJv
        Brv8RqSTKD2Xm9aS+sfxP1i3GzouvtM=
X-Google-Smtp-Source: AMrXdXsMaupXPk9MGcqylPAR4I7rmZ1B1hapevHU6JBFJhSZrLhk5VotR+euRXs8TGhuk2HkY1rqeg==
X-Received: by 2002:a05:6402:d51:b0:499:8849:5fac with SMTP id ec17-20020a0564020d5100b0049988495facmr11202794edb.40.1673471648883;
        Wed, 11 Jan 2023 13:14:08 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c22-7325-0300-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:7325:300::e63])
        by smtp.googlemail.com with ESMTPSA id l4-20020a056402344400b004822681a671sm6485079edc.37.2023.01.11.13.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 13:14:08 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, neil.armstrong@linaro.org,
        jbrunet@baylibre.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Vyacheslav Bocharov <adeep@lexina.in>
Subject: [PATCH v2 1/6] arm64: dts: meson-gxl: jethub-j80: Fix WiFi MAC address node
Date:   Wed, 11 Jan 2023 22:13:45 +0100
Message-Id: <20230111211350.1461860-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111211350.1461860-1-martin.blumenstingl@googlemail.com>
References: <20230111211350.1461860-1-martin.blumenstingl@googlemail.com>
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

Also node names should use hyphens instead of underscores as the latter
can also cause warnings.

Fixes: abfaae24ecf3 ("arm64: dts: meson-gxl: add support for JetHub H1")
Acked-by: Vyacheslav Bocharov <adeep@lexina.in>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
changes from v1 -> v2:
- Added Vyacheslav's Acked-by (originally given as "Vyachesav", but my
  understanding is that this was a typo
- Also replace the underscore in the node name with a hyphen

 .../boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts     | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
index 6831137c5c10..270483e007bc 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
@@ -90,7 +90,7 @@ bt_mac: bt_mac@6 {
 		reg = <0x6 0x6>;
 	};
 
-	wifi_mac: wifi_mac@C {
+	wifi_mac: wifi-mac@c {
 		reg = <0xc 0x6>;
 	};
 };
-- 
2.39.0

