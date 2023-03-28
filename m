Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829D56CB843
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 09:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjC1He4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 03:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjC1HeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:34:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9C135A5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679988800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nNdM7KSyRgCrr4mbIGjnmBDUe48JVTbvN2evKlFTHYo=;
        b=f41Ho/HE/6AR+eNMByiUdffxM3nSOt/4aKn9kGWPk8ZMOgfkeVsYAmS2XoMfed9/pZTrmE
        085ZFHGYmeE+4PSCs0AOqLjG1szVU/rLcllJBEIqykHRjZFfw8b71c7e0OreFMqFnnmUZH
        x8ZqXmIeM8VtQhaQ3xgYG917FfqynT4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-4iKo5mxyMeKxmij-_ygjgg-1; Tue, 28 Mar 2023 03:33:19 -0400
X-MC-Unique: 4iKo5mxyMeKxmij-_ygjgg-1
Received: by mail-wm1-f72.google.com with SMTP id q21-20020a05600c46d500b003ee570749f7so5979397wmo.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:33:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679988798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNdM7KSyRgCrr4mbIGjnmBDUe48JVTbvN2evKlFTHYo=;
        b=rHXI6khunStqdekIZFTengT4WLdWd77DY1Ql7xd5RrIH1Vp/bbzYOJzc3zVn82qqHN
         72kiQBh8Z3gnM35V+f/713OJEGK0vQzwxnk9fro9gjrScyiduRSLakgCPF+g0MjPBFXU
         unOf2icSn6ci/VT5DtVOakp0Px8/25PmI+vqP+16M3vwID3zhHlJKZuct5QtVzAPpYMY
         +dVBzlew6FC/2rD2zLZVt+pohuhhU4WayaBhsM3kky8aMQkw1OJudjwWRhR6aqU6NNA+
         2dy/IVOvwJPanBRWxWMjCDfKQXf8zcNAWkPMSfO07tsfbwmRP9ahQAlSnjOzLr/SQ7No
         Nqtw==
X-Gm-Message-State: AO0yUKWqlWgoOt6manXwEAH4Jg95ekoivjdTF976tx7WFX1XQpoHKJpS
        OhKxgIjrwwQKAtIVXB0RVlViK5V6gsnNDo9MWLkAfaFCUhbKIi0zweUH2n3Cz/gUtqHZHyafmj7
        bROulBWEPXToB0asnQluoh65P6BR9OMmk+ebGD3GFtN0eXlhn9RGMh40DEGIJzsLMe1q3Es4FMM
        rEP5/Mipg=
X-Received: by 2002:a05:600c:c6:b0:3ef:df3:1693 with SMTP id u6-20020a05600c00c600b003ef0df31693mr11393770wmm.32.1679988798138;
        Tue, 28 Mar 2023 00:33:18 -0700 (PDT)
X-Google-Smtp-Source: AK7set98gCyXpnG4Ha5cE59btAVfSKxfqXI1RJYKrRZnSKKWGrx+Oi6U2VNaI7A9EVKO8nI+cTTlEQ==
X-Received: by 2002:a05:600c:c6:b0:3ef:df3:1693 with SMTP id u6-20020a05600c00c600b003ef0df31693mr11393735wmm.32.1679988797783;
        Tue, 28 Mar 2023 00:33:17 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c190600b003ef6bc71cccsm7527075wmq.27.2023.03.28.00.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 00:33:17 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        Tom <tom@tom-fitzhenry.me.uk>,
        Robert Mader <robert.mader@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Martijn Braam <martijn@brixit.nl>, Ondrej Jirman <megi@xff.cz>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        =?UTF-8?q?Kamil=20Trzci=C5=84ski?= <ayufan@ayufan.eu>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Caleb Connolly <kc@postmarketos.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jarrah Gosbell <kernel@undef.tools>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v3 2/2] arm64: dts: rk3399-pinephone-pro: Add touchscreen support
Date:   Tue, 28 Mar 2023 09:33:09 +0200
Message-Id: <20230328073309.1743112-3-javierm@redhat.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230328073309.1743112-1-javierm@redhat.com>
References: <20230328073309.1743112-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Martijn Braam <martijn@brixit.nl>

The phone has a Goodix GT1158 touchscreen, add a DT node for it.

Signed-off-by: Martijn Braam <martijn@brixit.nl>
Co-developed-by: Kamil Trzciński <ayufan@ayufan.eu>
Signed-off-by: Kamil Trzciński <ayufan@ayufan.eu>
Co-developed-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v3:
- Use the correct "goodix,gt1158" compatible string (Ondrej Jirman).
- Remove "poweroff-in-suspend" not supported in mainline (Ondrej Jirman).

 .../dts/rockchip/rk3399-pinephone-pro.dts     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
index 539b36e8bff5..475ba78acc09 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
@@ -367,6 +367,25 @@ regulator-state-mem {
 	};
 };
 
+&i2c3 {
+	i2c-scl-rising-time-ns = <450>;
+	i2c-scl-falling-time-ns = <15>;
+	status = "okay";
+
+	touchscreen@14 {
+		compatible = "goodix,gt1158";
+		reg = <0x14>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <RK_PB5 IRQ_TYPE_EDGE_RISING>;
+		irq-gpios = <&gpio3 RK_PB5 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio3 RK_PB4 GPIO_ACTIVE_HIGH>;
+		AVDD28-supply = <&vcc3v0_touch>;
+		VDDIO-supply = <&vcc3v0_touch>;
+		touchscreen-size-x = <720>;
+		touchscreen-size-y = <1440>;
+	};
+};
+
 &cluster0_opp {
 	opp04 {
 		status = "disabled";
-- 
2.40.0

