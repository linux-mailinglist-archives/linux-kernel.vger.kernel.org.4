Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699F6674140
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 19:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjASSt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 13:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjASStg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 13:49:36 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBEB94CA0;
        Thu, 19 Jan 2023 10:49:29 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id w11so877197lfu.11;
        Thu, 19 Jan 2023 10:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whMWYQfGzaJPnTeJPhhjcLAVFGOi1DqjOoYU7lBrbEw=;
        b=E2T2D6DACq3966VESzWpx8PhFIHol1jPrku6s4cUp6lTE2hNExogTwiraPMFBdYmi4
         eeOuM2hw4Hwl53fTpWWHq4LhCyIuMjqYZe1uRMC45MXLZo40vX/jpMtqv7wN9fAG73FW
         uDsMQaX+Fq56W6q5iVMdfdu1N1VTkWQKREEbwkpIKm67BXjEzS8DqaiQdszp95LwCk4E
         aNbMAU6njxaomNOH7Ma0UZFq20W1ApDJs+VsbQtXvUeVps6RrzrpGT245Oo3EOng4kAZ
         SQCvPUSQiUYcHxllnIcUe3EDHtMoPxVXjWBT/ASG8cQ7QuDjHNV4hUq8S0oXL/vf6ucw
         FxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whMWYQfGzaJPnTeJPhhjcLAVFGOi1DqjOoYU7lBrbEw=;
        b=CmH7EH8dZPzIsxcds2qTQbr+bNOVWDb3rTKN/oq7QeC3RNRbS6FKaZJ6tHOxdvayH4
         PhOWOXPksjgiqiL8hXg2xIDIMd9INgbwU2avUJb6/XNFXvyRJh0ZujxrdBAMeXn0h/Ak
         qb8Vv5uxUahOhBmU8nmzaZn9ZgbNt5wE8NZ1duLYo5qTRswpw/EddWIIomztEUJtTvop
         xfDnPkEvtpeotD1iNMPcymLoViBUU8MNdhd+4C2RfJ+43B9DCleOyPCjNrnCZd+bWQwU
         +/75E5ZVfj2KoAjd8q8KL8XQD/e3G9qi/UboiaBzy8VIzm/lbPwEu8mN+EqqY3oLQxdp
         YAMA==
X-Gm-Message-State: AFqh2kqTnN+FYxDK1rcCgHRhkYpDtMQeGvBFTXEKhMF63UoI7ZiZjVC7
        VBmChj1D/pSlttDC32Q0h2M=
X-Google-Smtp-Source: AMrXdXudzU4h7M6LO0PZkeIfHC/mW9RojDp0JElKBbO6CrK/AO11pQaR5TWVFRGk5TwTG4YmA8FvxA==
X-Received: by 2002:ac2:4c97:0:b0:4b6:fdc3:a668 with SMTP id d23-20020ac24c97000000b004b6fdc3a668mr2754311lfl.31.1674154168187;
        Thu, 19 Jan 2023 10:49:28 -0800 (PST)
Received: from U19.ag.local (static.187.76.181.135.clients.your-server.de. [135.181.76.187])
        by smtp.gmail.com with ESMTPSA id b31-20020a0565120b9f00b004d30752a561sm2112737lfv.298.2023.01.19.10.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 10:49:27 -0800 (PST)
From:   Alibek Omarov <a1ba.omarov@gmail.com>
Cc:     a1ba.omarov@gmail.com, alexander.sverdlin@siemens.com,
        macromorgan@hotmail.com, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Peter Geis <pgwipeout@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Frank Wunderlich <frank-w@public-files.de>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: rockchip: rk356x: add LVDS bindings
Date:   Thu, 19 Jan 2023 21:48:04 +0300
Message-Id: <20230119184807.171132-3-a1ba.omarov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230119184807.171132-1-a1ba.omarov@gmail.com>
References: <20230119184807.171132-1-a1ba.omarov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exposes ports for VOP2 and for panel

Tested-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Link: https://patchwork.kernel.org/project/linux-rockchip/patch/20220923160115.2946615-3-a1ba.omarov@gmail.com/#25097661
Signed-off-by: Alibek Omarov <a1ba.omarov@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 25 ++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 5706c3e24f0a..34d1b943f312 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -827,6 +827,31 @@ hdmi_out: port@1 {
 		};
 	};
 
+	lvds: lvds {
+		compatible = "rockchip,rk3568-lvds";
+		clocks = <&cru PCLK_DSITX_0>;
+		clock-names = "pclk_lvds";
+		phys = <&dsi_dphy0>;
+		phy-names = "dphy";
+		power-domains = <&power RK3568_PD_VO>;
+		rockchip,grf = <&grf>;
+		rockchip,output = "lvds";
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			lvds_in: port@0 {
+				reg = <0>;
+			};
+
+			lvds_out: port@1 {
+				reg = <1>;
+			};
+		};
+	};
+
 	qos_gpu: qos@fe128000 {
 		compatible = "rockchip,rk3568-qos", "syscon";
 		reg = <0x0 0xfe128000 0x0 0x20>;
-- 
2.34.1

