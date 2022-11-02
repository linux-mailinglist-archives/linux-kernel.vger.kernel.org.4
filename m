Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD3E616A17
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiKBRKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiKBRKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:10:21 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C81E1707A;
        Wed,  2 Nov 2022 10:10:19 -0700 (PDT)
Received: (Authenticated sender: kory.maincent@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id F03D210000B;
        Wed,  2 Nov 2022 17:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667409017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MV9j9Bu5TXuRkblIFDbUBZYqzjooHXJ8S9umIGNR0lE=;
        b=l5MiST3b7TjEP/Jwk5lnDNZVIU/J3RGUY2aVgpeb4zuzS85/k4xHlHaR82bH7/cWUb8wox
        ZyvvOaM9DyxM3avB78UIho+ZCh5jHRxH+D/sYXzTTtMsn7WFtNytovE3WZSGl4Lbyg/rtW
        Gqf5PBYOEt6QrONMGhtljv0yJf8EZcAxkyZlYtYJQhEfBXpHVZR6TSXBGKNNTb0xKtBKzg
        34Lf88kYQlXSz0++22OZVHOCvJuMtyvAz6LnpAK9aT2+v28hYgS2C3R9/h5GzOCYqEgCnh
        lBj8seKJCqAt9xLMu16el/KW3L0Czh4GRYCEPLPe4v+c0+8rMuGW4wewlCvKPA==
From:   =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>
To:     viresh.kumar@linaro.org,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Vipin Kumar <vipin.kumar@st.com>,
        Vijay Kumar Mishra <vijay.kumar@st.com>,
        Deepak Sikri <deepak.sikri@st.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Kory Maincent <kory.maincent@bootlin.com>,
        thomas.petazzoni@bootlin.com, Viresh Kumar <vireshk@kernel.org>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Rajeev Kumar <rajeev-dlh.kumar@st.com>,
        Vipul Kumar Samar <vipulkumar.samar@st.com>
Subject: [PATCH v2 0/6] Support new features to the SPEAr600
Date:   Wed,  2 Nov 2022 18:10:04 +0100
Message-Id: <20221102171012.49150-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kory Maincent <kory.maincent@bootlin.com>

This patches series adds two features of the SPEAr600 SOC:

- Enable the display controller

- Enable the SPI buses using the SSP controller

Changes in v2:
- Keep the I2C_CONFIG in the spear6xx_defconfig while enabling DRM.
- Send cover letter which was not sent in v1 due to a mistake in my git
  mail config.

Viresh, will you take the patches and submit a pull request to the ARM SoC
maintainers?

Kory Maincent (6):
  arm: configs: spear6xx: Refresh defconfig
  arm: dts: spear600: Fix clcd interrupt
  arm: configs: spear6xx: Enable PL110 display controller
  clk: spear: Fix CLCD clock definition on SPEAr600
  arm: dts: spear600: Add ssp controller nodes
  clk: spear: Fix SSP clock definition on SPEAr600

 arch/arm/boot/dts/spear600.dtsi     | 32 ++++++++++++++++++++++++++++-
 arch/arm/configs/spear6xx_defconfig |  7 ++-----
 drivers/clk/spear/spear6xx_clock.c  |  8 ++++----
 3 files changed, 37 insertions(+), 10 deletions(-)

-- 
2.25.1

