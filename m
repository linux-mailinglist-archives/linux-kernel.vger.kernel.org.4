Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1706D11FB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjC3WH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjC3WG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:06:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E2910A82
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 15:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680213782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+accSwBqAoktxjFKHOVQ5nhVitWw2RmW/ogboNO6PkE=;
        b=D2MY4CNg1LzM7uQi68ImNX8NLfEOpVWqsQbkXpgnrwCCFQy+MAeDBqYgI+f7mGh3NVvuza
        r1eXhnaAZT2sIRwugp4mYPTqXR3sImA3w71O7FBFYDTEiwbCwsE57pxSc2L7hoa72248VQ
        879syhp4xJH5Y3vmdfE/jclYAPHtv7Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-nJqCHhk0O5quwqbvGSahqA-1; Thu, 30 Mar 2023 18:03:00 -0400
X-MC-Unique: nJqCHhk0O5quwqbvGSahqA-1
Received: by mail-wm1-f69.google.com with SMTP id r11-20020a05600c458b00b003eea8d25f06so10488807wmo.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 15:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680213779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+accSwBqAoktxjFKHOVQ5nhVitWw2RmW/ogboNO6PkE=;
        b=aFKKZr45npelm4O/WjtBxaubUjtgJ7mHnCXh5YPdWdFLOG1Nc4PWrBS7bTeiz9djWb
         nuiITKbtdv/rIEW+y2I7qfQ4Erez3VzKywi/qoQrc/As4ssaH7Ghp+qzs4mTDV5jZNaJ
         3MHSxKhuXfOjKzWpEYqIyEZlR5KC8eLfFhgHBrCazl67Hm45B1LdsSSBrBWlrd+yK5PK
         A+g03hSqcaqERfk9ELoakCRu+j6p1czLq1pJMsxCmIJTbnbxGg5AZ75RY4astyiO6rZt
         XNVMIoxx0L+hO6RWXD4Aucbq/X3h5T9r35zJ0+xjQYvpCVhZ9oEa3UVfvKxMeOWms0oA
         t9yA==
X-Gm-Message-State: AAQBX9eDG5g1BB5EbDBlQH2JqNj51/VIKYdz+kOR0wTAqZR+mTBn7XMY
        1M683oqMmXyCAZB/VwTPm5GW528T2AY5FnOKkqg7fZZ7F9X9QhUr960fG+kGsgyZFXCruo8aF2m
        29K26u3IJF/+9PU8gAGoTyd9b2msmm+kS3oDDDpzOFKsVSgxjgPzJOiTmgnoK1XbYvlgYMMOaZI
        6w3DpDbao=
X-Received: by 2002:adf:e70c:0:b0:2ce:9f35:59c7 with SMTP id c12-20020adfe70c000000b002ce9f3559c7mr17075852wrm.45.1680213779152;
        Thu, 30 Mar 2023 15:02:59 -0700 (PDT)
X-Google-Smtp-Source: AKy350b31TNBPqPj39e+fe++ArpC9hrzqebqcnE01Owm77OMMqIbVzdWSh+zdJEPLJOUUvu9L4ZKRQ==
X-Received: by 2002:adf:e70c:0:b0:2ce:9f35:59c7 with SMTP id c12-20020adfe70c000000b002ce9f3559c7mr17075830wrm.45.1680213778776;
        Thu, 30 Mar 2023 15:02:58 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y11-20020adffa4b000000b002c7066a6f77sm449363wrr.31.2023.03.30.15.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 15:02:58 -0700 (PDT)
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
Subject: [PATCH] arm64: dts: rockchip: Remove non-existing pwm-delay-us DT property
Date:   Fri, 31 Mar 2023 00:02:51 +0200
Message-Id: <20230330220251.2388494-1-javierm@redhat.com>
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

There is no neither a driver that parses this nor a DT binding schema that
documents it so let's remove it from the DTS files that make use of this.

The properties that exist are post-pwm-on-delay-ms and pwm-off-delay-ms,
defined in the pwm-backlight DT binding. So probably what these DTS want
is something like following:

        backlight: backlight {
                compatible = "pwm-backlight";
                enable-gpios = <&gpio4 21 GPIO_ACTIVE_HIGH>;
                pinctrl-names = "default";
                pinctrl-0 = <&bl_en>;
                pwms = <&pwm1 0 1000000 0>;
                post-pwm-on-delay-ms = <10>;
                pwm-off-delay-ms = <10>;
        };

But that should be follow-up change if that is the case. Because otherwise
it would be change in behaviour, since currently pwm-delay-us is a no-op.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

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

base-commit: ffe78bbd512166e0ef1cc4858010b128c510ed7d
prerequisite-patch-id: ab73fde77786baf8fa44882125c5ce864771371c
-- 
2.40.0

