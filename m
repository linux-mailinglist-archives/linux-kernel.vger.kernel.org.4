Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D9C6BF90E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 09:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjCRIiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 04:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjCRIiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 04:38:07 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4E5AFBB7;
        Sat, 18 Mar 2023 01:37:56 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id d14so448715ion.9;
        Sat, 18 Mar 2023 01:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679128676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ieG7L9msYA/7lhUnPh05XbQYvh9ea1Tc8rd619ZsgQ=;
        b=d5Jmz/4FBL6d+7r7Y7GwenCb+4EgG6JMg97ed/mqotPa/wVddpfWwlNAkkvWrtgpbW
         phAlK1urY3kUsWzeTCQA6CfaKd+WEwt/MZ5e0TOFEXGbIlZaTE70UeNoUTnLsWNmgIU6
         MI7QafQ8P8ccnOpFQpWJdgS1vlotiYEIRV+U8nkZWphxdDzr2EgfPKxcDbBgFGOvqoJw
         WYWCr0J0N4g0i4iTaetmBrV4OQZ8XQA6rrRXIVCc4syJI7nVjTtP6Pgy3uy2eINzn202
         mhl8tXl7aIGe9SKhQnPkHsRX3hPwByXriNw3MC6oK/D/oqwsYPcTUe7DZqtujWULD8aA
         Pp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679128676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ieG7L9msYA/7lhUnPh05XbQYvh9ea1Tc8rd619ZsgQ=;
        b=Hshd0YzyViJoocYAlGvSWTq71SVs7KmTrAEVINoe1DD8w0lLEVNr5sH002v9XCWyuD
         75y3bocc+pGpIUAS2W3lEjoTHMkV+GjNgXn762zf7dCsVpZFttK+eFK7SRHhko47l1tr
         QO1qD7N4yTYZxdbGSk1TFOdu3IckUeiyTHxwL7tBQArMok4JRXhvggEZiub3ziGgTU78
         EKzBwMhz5jz1+BqCC0bFeS20jM6iO4h5telqp0+8TZtvkZC9ZHoaOP0qJAHKvH0NsvoE
         AaeDYdS8z2sYuK/x8fGNe/EPIMTapoF6/SB2m0Iuln0TrAnZL7WjVnz6F+fOdUiebia5
         brLQ==
X-Gm-Message-State: AO0yUKUmhhJhWGO301E+qrmYERSOtiunGHLZBhV0G6mDTdoqMyaof8rv
        xNCY0Kn4GpA4+1vryrNsgAI=
X-Google-Smtp-Source: AK7set9FGB4F1uRNXAX0Pk/2KXzDRt5VIXEaOZtMbjLEJaLnLm3z4gatwEwLDItxcVLd8R8Up8yo5Q==
X-Received: by 2002:a05:6602:1c4:b0:74c:8dc7:aa1 with SMTP id w4-20020a05660201c400b0074c8dc70aa1mr1012004iot.17.1679128676172;
        Sat, 18 Mar 2023 01:37:56 -0700 (PDT)
Received: from localhost.localdomain (tunnel785484-pt.tunnel.tserv9.chi1.ipv6.he.net. [2001:470:1f10:aed::2])
        by smtp.googlemail.com with ESMTPSA id h8-20020a6b7a08000000b00746041ecbf9sm1174834iom.39.2023.03.18.01.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 01:37:55 -0700 (PDT)
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
Subject: [PATCH v2 5/5] arm64: dts: rockchip: remove I2S1 TDM node for the NanoPi R5 series
Date:   Sat, 18 Mar 2023 16:37:45 +0800
Message-Id: <20230318083745.6181-6-cnsztl@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230318083745.6181-1-cnsztl@gmail.com>
References: <20230318083745.6181-1-cnsztl@gmail.com>
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

This is for the audio output which does not exist on the boards.
Also disable regulator-always-on for vccio_acodec since it's only
used by the audio output.

Fixes: c6629b9a6738 ("arm64: dts: rockchip: Add FriendlyElec Nanopi R5S")

Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi
index dd9a7907a1c5..58ba328ea782 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi
@@ -330,7 +330,6 @@ regulator-state-mem {
 
 			vccio_acodec: LDO_REG4 {
 				regulator-name = "vccio_acodec";
-				regulator-always-on;
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 
@@ -441,11 +440,6 @@ &i2s0_8ch {
 	status = "okay";
 };
 
-&i2s1_8ch {
-	rockchip,trcm-sync-tx-only;
-	status = "okay";
-};
-
 &pcie30phy {
 	data-lanes = <1 2>;
 	status = "okay";
-- 
2.40.0

