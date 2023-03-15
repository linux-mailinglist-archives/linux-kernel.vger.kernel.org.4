Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E016BB900
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjCOQEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjCOQDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:03:30 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7693D936;
        Wed, 15 Mar 2023 09:02:58 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id s7so2992502ilv.12;
        Wed, 15 Mar 2023 09:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678896178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRz/HSIpijcdIS7EAx/rH+emYIVog1BleYIOJz3yCDA=;
        b=n2+4Zg0ywjblhdc4TgC2ZkT8MSD58Ub8tdekflwI7COtFuQOL37HsaU3PoS1ySWHwC
         w93SLcgIK5nWxlfu8hIDE479eCzRBN0weYm/OO+2iMNcENQX66xk01prC80LGT4D3nnQ
         0DC6k0F2sKe9R150SZKKdJMGVhln2Nx550iOSXXFh8fon3RPwJZdIBdFhieaplNkdVdu
         A9LXf1I2kizqFUZPZY5RDUJWko/stAPQ5EImnFgkLYtTPnhHEwcuXhU+Oml0CyMbPYuK
         lzs9FyI+fQiCxYDR7ujLj7OswVtL/DAQeQIggH96e0I305ly026hnVOUJQLajPl5353A
         K9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678896178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRz/HSIpijcdIS7EAx/rH+emYIVog1BleYIOJz3yCDA=;
        b=nojGYgBE+YytADlNWylW7trR8VWmARdj/6yDKBDNYu+mZgYYmWFmwp4rB/54iy9UTE
         FiGjUkurQ1ycExDJAzC8M7OHX+oA9KSh1vIRdXIsV80ThWLTGzH1l+nkpUKrRoo+OqRV
         WzHH0xjpRezgQug4y5nH/MUW4ruBpuP4tN03LnZhjkky0O9aEecM6QcgKo0rFxuiPBcV
         4NbfI7e9lqsPN6gfBKCNoUv3tM77e8pCoQnpv5KZHehVH6CynwPshDvBdcZOjBotmqgc
         gHD0OWn2MSlojxaeQJ4JQ1tG/QrUWf7lryUHQxwxV8kXxUjFI9W9FkBb3zkUTeVnqJZL
         SM+g==
X-Gm-Message-State: AO0yUKXik7qKOwOxcP5OMeT4uJPIrP/kO5W5JqFrfwM3HzKGqAfrM8os
        ifdbBkLhTmZfFZZRMFINSkA=
X-Google-Smtp-Source: AK7set9XPptg+3RJGT4hYzH5sV/zhxw6eSuTRF1kBECbAXdXVGwoiEHP06XLHG4jqEVWYwsfIuCmLA==
X-Received: by 2002:a92:cb90:0:b0:318:a974:ab52 with SMTP id z16-20020a92cb90000000b00318a974ab52mr4847649ilo.21.1678896178065;
        Wed, 15 Mar 2023 09:02:58 -0700 (PDT)
Received: from localhost.localdomain (tunnel785484-pt.tunnel.tserv9.chi1.ipv6.he.net. [2001:470:1f10:aed::2])
        by smtp.googlemail.com with ESMTPSA id l2-20020a92d942000000b00313fa733bcasm1730725ilq.25.2023.03.15.09.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 09:02:57 -0700 (PDT)
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
Subject: [PATCH 4/5] arm64: dts: rockchip: fix gmac support for NanoPi R5S
Date:   Thu, 16 Mar 2023 00:02:27 +0800
Message-Id: <20230315160228.2362-5-cnsztl@gmail.com>
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

- Changed phy-mode to rgmii.

- Fixed pull type in pinctrl for gmac0.

- Removed duplicate properties in mdio node.
  These properties are defined in the gmac0 node already.

Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
index e9adf5e66529..2a1118f15c29 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
@@ -57,7 +57,7 @@
 	assigned-clock-rates = <0>, <125000000>;
 	clock_in_out = "output";
 	phy-handle = <&rgmii_phy0>;
-	phy-mode = "rgmii-id";
+	phy-mode = "rgmii";
 	pinctrl-names = "default";
 	pinctrl-0 = <&gmac0_miim
 		     &gmac0_tx_bus2
@@ -79,9 +79,6 @@
 		reg = <1>;
 		pinctrl-0 = <&eth_phy0_reset_pin>;
 		pinctrl-names = "default";
-		reset-assert-us = <10000>;
-		reset-deassert-us = <50000>;
-		reset-gpios = <&gpio0 RK_PC4 GPIO_ACTIVE_LOW>;
 	};
 };
 
@@ -115,7 +112,7 @@
 &pinctrl {
 	gmac0 {
 		eth_phy0_reset_pin: eth-phy0-reset-pin {
-			rockchip,pins = <0 RK_PC4 RK_FUNC_GPIO &pcfg_pull_down>;
+			rockchip,pins = <0 RK_PC4 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
 
-- 
2.17.1

