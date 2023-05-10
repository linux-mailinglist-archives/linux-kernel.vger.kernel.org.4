Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22ACF6FDDEF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 14:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237131AbjEJMhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 08:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237098AbjEJMgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 08:36:35 -0400
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1FEAD22;
        Wed, 10 May 2023 05:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
        s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=qL5OwOHKWsGEJz5LBeBEW7MkLSt6oAOQjlwwT1NVmAE=; b=IXJjsg74s+hgDNm9yBKSa5Hcyn
        BKfy08wg9lHyXZBWy0eLO/F9bItUkyLMqeKqlaiSiItJ1L5381VNREpC5S5BkACtUBxGE1OD/aQdl
        jH899dZGGTz8mWR9YzTko2X7qqY07Uu5JmNG19Cg9zQjfGl0Y4EKu17Njh6+QnGHWaafmHDB0e8E1
        akZ/PT8dnbatOo7wgxKXTWnw7YL5pTUz4DqfQ00gsYhiNqOLQlBJW5PAGEvCuvIfmgtsqh4kPcHKp
        sRmt9571hgXxwyGCuyVC6/azdCAVEdvimaoDD9ATOfnnZPHjgTTvzvgravKkmozIp9fLC5MIxrF6Y
        8rT5Jtog==;
Received: from [2001:4d48:ad59:1403::16a3] (helo=earth.li)
        by the.earth.li with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <noodles@earth.li>)
        id 1pwiVB-007udb-3Z; Wed, 10 May 2023 13:01:01 +0100
Date:   Wed, 10 May 2023 13:00:55 +0100
From:   Jonathan McDowell <noodles@earth.li>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH v2 0/5] Minor device-tree additions for C.H.I.P
Message-ID: <cover.1683719613.git.noodles@earth.li>
References: <cover.1681580558.git.noodles@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1681580558.git.noodles@earth.li>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small patch series adds some improvements for the C.H.I.P DTS,
enabling bluetooth, exporting the PMIC temperature details via iio-hwmon
and finally adding the appropriate base pinmux info for an external MMC
card. As a pre-requisite for the Bluetooth it also adds support to the
AXP209 driver for GPIO3, which is the Bluetooth device wakeup line.

v2:
- Fix missing ; on bluetooth stanza in DTS
- Add device/host wake GPIOs for Bluetooth device
- Add omit-if-no-ref on the port E pinmux stanza
- Rename axp20x_temp to pmic-temp
- Add AXP209 GPIO3 support

Jonathan McDowell (5):
  dt-bindings: gpio: Add GPIO3 for AXP209 GPIO binding schema
  pinctrl: axp209: Add support for GPIO3 on the AXP209
  ARM: dts: sun5i: chip: Enable bluetooth
  ARM: dts: sun5i: Add port E pinmux settings for mmc2
  ARM: dts: axp209: Add iio-hwmon node for internal temperature

 .../bindings/gpio/x-powers,axp209-gpio.yaml   |  1 +
 arch/arm/boot/dts/axp209.dtsi                 |  7 ++++
 arch/arm/boot/dts/sun5i-r8-chip.dts           |  6 +++
 arch/arm/boot/dts/sun5i.dtsi                  |  9 ++++
 drivers/pinctrl/pinctrl-axp209.c              | 42 +++++++++++++++++++
 5 files changed, 65 insertions(+)

-- 
2.39.2

