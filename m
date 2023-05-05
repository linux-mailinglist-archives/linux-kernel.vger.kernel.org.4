Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A48C6F7B8B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 05:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjEED35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 23:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjEED3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 23:29:44 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE76393CB;
        Thu,  4 May 2023 20:29:42 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-192798cf019so1131479fac.3;
        Thu, 04 May 2023 20:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683257382; x=1685849382;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cO08HzmVk1n7d0QynKl12ITRwYajT1G6ollIJzLwnQ0=;
        b=c+S201u7ip3LT2u+haejjTccwQiG6Zo9aVmfX1GnNAVcrf3LzSROGKyERKOIiT6YUA
         Ry8TjYRyqB1u4JADhw5Ot7ysE5+MQchCuNfC1BGLkHVMYYgx6SQD1HA7hlI5vx1PbT89
         xuLU2X+NFiom25JZQc8lSBiDpd484e+CPIZsSGDiHdeUyRg5peYtn24BWEmaE6BXu8Fj
         lYSSxukhDLPTNGJ+A371KB2xTc6tFcbLCIp8nR/v93WjdSM4XiF09Jec2bjEKPsG/NJe
         WoAira6AtAfj4Vua3kJJMEuoOx8v7eiOC3WDAR2HF3TcIqg8y01oC40NIu3FEJU23Z2N
         99wg==
X-Gm-Message-State: AC+VfDy69aAEQtSmaLuEvJgdWAY5RC19XFRBXbD1unweqbhBsmIqlcyI
        aLNSZSnl+/tkkq358NSJhnJa4MHTYQ==
X-Google-Smtp-Source: ACHHUZ5dG/KV5t6GBZgbnTBt4RRfH6XJsLQcOegoUooL1M3JR9y6bvBwgGoVTHkorw1jCXtBTd5onw==
X-Received: by 2002:a05:6808:308f:b0:38c:3c53:9e15 with SMTP id bl15-20020a056808308f00b0038c3c539e15mr3141116oib.13.1683257381863;
        Thu, 04 May 2023 20:29:41 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w12-20020a056808090c00b0038c235e24fesm2259619oih.48.2023.05.04.20.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 20:29:41 -0700 (PDT)
Received: (nullmailer pid 1056850 invoked by uid 1000);
        Fri, 05 May 2023 03:29:31 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 04 May 2023 22:29:28 -0500
Subject: [PATCH 3/4] kbuild: Support flat DTBs install
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230504-arm-dts-mv-v1-3-2c8e51a2b6c4@kernel.org>
References: <20230504-arm-dts-mv-v1-0-2c8e51a2b6c4@kernel.org>
In-Reply-To: <20230504-arm-dts-mv-v1-0-2c8e51a2b6c4@kernel.org>
To:     soc@kernel.org, Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Antoine Tenart <atenart@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Lars Persson <lars.persson@axis.com>,
        Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Wei Xu <xuwei5@hisilicon.com>,
        Jean-Marie Verdun <verdun@hpe.com>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Peter Rosin <peda@axentia.se>, Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Daniel Palmer <daniel@thingy.jp>,
        Romain Perier <romain.perier@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Marek Vasut <marex@denx.de>, Qin Jian <qinjian@cqplus1.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Paul Barker <paul.barker@sancloud.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com
X-Mailer: b4 0.13-dev
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to move Arm .dts files into sub-directories grouped
by vendor/family, the current flat tree of DTBs generated by
dtbs_install needs to be maintained. Moving the installed DTBs to
sub-directories would break various consumers using 'make dtbs_install'.

This is a NOP until sub-directories are introduced.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/Kconfig         | 3 +++
 scripts/Makefile.dtbinst | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e24a9820e12f..7a3b1176f19d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1463,6 +1463,9 @@ config USE_OF
 	help
 	  Include support for flattened device tree machine descriptions.
 
+config ARCH_WANT_FLAT_DTB_INSTALL
+	def_bool y
+
 config ATAGS
 	bool "Support for the traditional ATAGS boot data passing"
 	default y
diff --git a/scripts/Makefile.dtbinst b/scripts/Makefile.dtbinst
index 2ab936e4179d..4405d5b67578 100644
--- a/scripts/Makefile.dtbinst
+++ b/scripts/Makefile.dtbinst
@@ -34,6 +34,6 @@ $(dst)/%.dtbo: $(obj)/%.dtbo
 
 PHONY += $(subdirs)
 $(subdirs):
-	$(Q)$(MAKE) $(dtbinst)=$@ dst=$(patsubst $(obj)/%,$(dst)/%,$@)
+	$(Q)$(MAKE) $(dtbinst)=$@ dst=$(if $(CONFIG_ARCH_WANT_FLAT_DTB_INSTALL),$(dst),$(patsubst $(obj)/%,$(dst)/%,$@))
 
 .PHONY: $(PHONY)

-- 
2.39.2

