Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6E46BB902
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjCOQEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjCOQDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:03:35 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934FD2798D;
        Wed, 15 Mar 2023 09:03:01 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id r4so10618847ila.2;
        Wed, 15 Mar 2023 09:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678896179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSxNm+bUgPUb4H+sIffmK7Q4FmvZdx2WQnaN/QkWhH0=;
        b=E6i4Pf9zY6+mScQK49sIfooB8l07lxCfCOl0/67fiQsVPNxIjEUMab2QtP+6nLtgDj
         UrGiuuKHMsApLL2dosmQJ5r0KOM6hkp2T6oiXXh9yfedkiIXePQw2OB0+1Vc1po8G87O
         YP6PO5fvkPObdlxiBcH8nxs+qwqM7JdH65PHllN15+rb4eKj7Q5ZvNfIrN7AV6U3bcs/
         U5FiZTUQdnFoCm7GxtLzsqj8JVvgqKruVFrUl2i9T4L9UbXkkVOAFusz45y5VLdpCULw
         4f2XAbmMUSIvqcNVgeXg088Kj5plrhr/s1FQ4bUewH6bFbT4TbMKhfFBKNzTEZE3Qn99
         pTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678896179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sSxNm+bUgPUb4H+sIffmK7Q4FmvZdx2WQnaN/QkWhH0=;
        b=O1UtIuzxYesi7vaQdjqHoNiqWlIJwYZijITW43V9q71f6VpFNRT8XLhn+OLHrsqmr3
         CSYbL263CMAO5jzScZ/7RedbfKqq/qhp7b7V5E/0SuEWEHQT8lbtgNGBcPWYw/gGu7+M
         Z2CsI/ZERdnyAw+wfaws/MsI6uDD/ByiXihAQ/Qmc+5EUnLnT6a6DCjh80GosqF3kfdB
         e7edU3JbOqpnGpvpVJygP/hw483kGijYhmsiOyx3NZ+noPpK6bb9RO5PEYkZZxAdZTnc
         uwJUF29dZ8N1CvakGgpMVDJTZ8RcvWLEcEkOZosl9YAn+a31plQZ49hiJXU2rH94mKos
         pZzg==
X-Gm-Message-State: AO0yUKVh3BZ94FEymKdDYZwGI2lfiMWJQJ1sGAr9PzOzjVxaUs1Y1bh3
        mWupL/GfgxBbMxywhPNuIdk=
X-Google-Smtp-Source: AK7set/ewpG/bOS7jQOWCH2zYl+AJIwzSqGX6Wgh1gULbkMUBsOPPOvjhZ/GU5x36rBCCtG+VLF7Lw==
X-Received: by 2002:a05:6e02:13c5:b0:323:e84:138 with SMTP id v5-20020a056e0213c500b003230e840138mr5285958ilj.15.1678896179648;
        Wed, 15 Mar 2023 09:02:59 -0700 (PDT)
Received: from localhost.localdomain (tunnel785484-pt.tunnel.tserv9.chi1.ipv6.he.net. [2001:470:1f10:aed::2])
        by smtp.googlemail.com with ESMTPSA id l2-20020a92d942000000b00313fa733bcasm1730725ilq.25.2023.03.15.09.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 09:02:59 -0700 (PDT)
From:   Tianling Shen <cnsztl@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Peter Geis <pgwipeout@gmail.com>, Andy Yan <andyshrk@163.com>,
        Tianling Shen <cnsztl@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Andrew Powers-Holmes <aholmes@omnom.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] arm64: dts: rockchip: enable rk809 audio codec on the NanoPi R5 series
Date:   Thu, 16 Mar 2023 00:02:28 +0800
Message-Id: <20230315160228.2362-6-cnsztl@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230315160228.2362-1-cnsztl@gmail.com>
References: <20230315160228.2362-1-cnsztl@gmail.com>
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

Enable the Rockchip RK809 audio codec on the NanoPi R5 series.

Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 .../boot/dts/rockchip/rk3568-nanopi-r5s.dtsi      | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi
index dd9a7907a1c5..8e1a118ae2e3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi
@@ -35,6 +35,21 @@
 		};
 	};
 
+	rk809-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "Analog RK809";
+		simple-audio-card,mclk-fs = <256>;
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s1_8ch>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&rk809>;
+		};
+	};
+
 	vdd_usbc: vdd-usbc-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_usbc";
-- 
2.17.1

