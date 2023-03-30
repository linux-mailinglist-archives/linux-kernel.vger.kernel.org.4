Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7556D12ED
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 01:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjC3XUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 19:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjC3XUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 19:20:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F21510A82
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 16:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680218370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Lx021jiSXTc6pYyl7LmIv03tfyJDHewW1CEauW0rIQw=;
        b=HdP7ivvFtuavef/65yYWZ25hyRexJIqhdGxbBdwRl7PaKBjxK99tfxwEIeuSMKYim+SnCW
        5V9wnkNnaTW8dKcRyGaLg+m8fdbTTXuegxowpvLh8f4LW06YfXA44EqYhiVegfIW0+dEt/
        ezREHuK9+YQzcLkkum2KqaJm21RPi2I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-7qbQ7D3RPAucQBC1YsWNEg-1; Thu, 30 Mar 2023 19:19:28 -0400
X-MC-Unique: 7qbQ7D3RPAucQBC1YsWNEg-1
Received: by mail-wm1-f70.google.com with SMTP id bg33-20020a05600c3ca100b003ef6d684105so6807292wmb.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 16:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680218367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lx021jiSXTc6pYyl7LmIv03tfyJDHewW1CEauW0rIQw=;
        b=wsTE9gFWtjqVyEmYiRk1pfsus6sLB74cIEz27GBxg0lVMWkUjCptPk1AFuEUp6S5/9
         FFvEP2HRb8vKwCvooT66KHlZwjci4iGV8hPlSivbb7lUITtZrnHzK4uf2Dh/QBU+0QSJ
         6OZ89PHK1qv3hJKNn4iVyMrbf6lDbjQfzT7CaBkbaMzqCeo4qdzPa5o+OcDL4wveEIAM
         pqENBEt6RKLU7yVYTt1qLU1HR28/AsDTEt8FqTb4mVvpoEouvbeQakBec9TSQ7Z1qj5M
         wcutsx2eSl7931AryQZs2SuxaelASC4G1aywEIeSTVOE+ilt9BTzaSZmtj/fOEOFyIHj
         YWow==
X-Gm-Message-State: AAQBX9f5cSWb2GjDWsCizv9QgZsWQbMQEKzjScRRFQ08EVBTGx79aFNb
        M8qkKUnrTHPXITfmlvpggby9K2N65IME6UxcRcuSvlVHsHRu63QpOqhGiCYWshL2m7Iah2Jl6mw
        Y0w9RllJGC3eMGZhU8hvxGw4J6x4HG15+sCDdeJpKVXXyUety2npp3H+HwBD1QxcOx+HUJ5H8sX
        doDyTZaks=
X-Received: by 2002:adf:d4cc:0:b0:2d0:2d4:958c with SMTP id w12-20020adfd4cc000000b002d002d4958cmr18784585wrk.60.1680218367437;
        Thu, 30 Mar 2023 16:19:27 -0700 (PDT)
X-Google-Smtp-Source: AKy350YIJANJD5ndsOw5e6X1tNl3/XEP4RjGZCkemP4f0WMNIUtUXUh4J/Z7TRhR6CnBmTTGwrSw1g==
X-Received: by 2002:adf:d4cc:0:b0:2d0:2d4:958c with SMTP id w12-20020adfd4cc000000b002d002d4958cmr18784568wrk.60.1680218367087;
        Thu, 30 Mar 2023 16:19:27 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f9-20020adfe909000000b002c7163660a9sm536059wrm.105.2023.03.30.16.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 16:19:26 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Brian Norris <briannorris@chromium.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <eballetbo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lin Huang <hl@rock-chips.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, zain wang <wzz@rock-chips.com>
Subject: [PATCH v2] arm64: dts: rockchip: Remove non-existing pwm-delay-us property
Date:   Fri, 31 Mar 2023 01:19:23 +0200
Message-Id: <20230330231924.2404747-1-javierm@redhat.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is neither a driver that parses this nor a DT binding schema that
documents it, so let's remove from the DTS files that make use of this.

The properties that exist are post-pwm-on-delay-ms and pwm-off-delay-ms,
defined in the pwm-backlight DT binding. If the delays are really needed
then those properties should be used instead.

Brian Norris mentioned though that looking at the first downstream usage
of the pwm-delay-us property for RK3399 Gru systems in ChromiumOS tree,
he couldn't find a spec reference that said that this was really needed.

So perhaps it was unnecessary added and a simple removal would be enough.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
- Update commit message with the information provided by Brian Norries.
- Add Reviewed-by tag from Brian Norries.

 arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi            | 1 -
 arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi | 1 -
 arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi    | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi b/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi
index 083452c67711..e47d1398aeca 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi
@@ -61,7 +61,6 @@ backlight: backlight {
 		pinctrl-names = "default";
 		pinctrl-0 = <&bl_en>;
 		pwms = <&pwm0 0 1000000 PWM_POLARITY_INVERTED>;
-		pwm-delay-us = <10000>;
 	};
 
 	emmc_pwrseq: emmc-pwrseq {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
index ee6095baba4d..5c1929d41cc0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
@@ -198,7 +198,6 @@ backlight: backlight {
 		power-supply = <&pp3300_disp>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&bl_en>;
-		pwm-delay-us = <10000>;
 	};
 
 	gpio_keys: gpio-keys {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
index a47d9f758611..c5e7de60c121 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
@@ -167,7 +167,6 @@ backlight: backlight {
 		pinctrl-names = "default";
 		pinctrl-0 = <&bl_en>;
 		pwms = <&pwm1 0 1000000 0>;
-		pwm-delay-us = <10000>;
 	};
 
 	dmic: dmic {

base-commit: b2bc47e9b2011a183f9d3d3454a294a938082fb9
-- 
2.40.0

