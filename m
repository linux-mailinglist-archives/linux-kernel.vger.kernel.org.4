Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051FD6E32FE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 19:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjDORrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 13:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjDORrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 13:47:20 -0400
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF4EE41;
        Sat, 15 Apr 2023 10:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
        s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=V3hC1iXMftqNHVVjf9y/IQOJAn+pUeg8MBrKjF7zyEU=; b=tWlUdvEX04DAJTh9v4VGMcRyTc
        fdQsu33b9RCx1TGq9nNTnuaxVm9lB5EnIT71Qaih2vSe73a+8R9xl5d8c1OXQiKgUSezj+3aCLpxa
        TWbicTc6fjQwP/KxuHblsdSjBqOZ3CVy4kyQRVVcLrQSiUmC6Pdnme1vVptmUaHDK4dXYjcqPXPxi
        GYXwb/9GBh6t0FNxAmPRaDTbPXZRWJw/+7RJ6tx8JLYrb4ySKrC35nY10Wworvekm1HzSt7ao0osK
        3ffQuXXxBdlCxF/MJMYGZ+aYX3NZgqUkDA45pYedbs6oWNMjqdZ1cNR3wYj0aKjIAWYzsLLbqSJuq
        cOy4/sSA==;
Received: from [2001:4d48:ad59:1403::16a3] (helo=earth.li)
        by the.earth.li with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <noodles@earth.li>)
        id 1pnjzS-00FJpt-5k; Sat, 15 Apr 2023 18:47:10 +0100
Date:   Sat, 15 Apr 2023 18:47:05 +0100
From:   Jonathan McDowell <noodles@earth.li>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ARM: dts: axp209: Add iio-hwmon node for internal
 temperature
Message-ID: <a40b6d46209f9b5626cd5a147c31daf5d19c9439.1681580558.git.noodles@earth.li>
References: <cover.1681580558.git.noodles@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1681580558.git.noodles@earth.li>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a DT node to hook up the internal temperature ADC to the
iio-hwmon driver. The various voltage + current ADCs are consumed and
exposed by their respective drivers, but this is not and is always
available. Naming chosen to match the axp20x_ prefix the power sensors
use.

Signed-off-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/axp209.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp209.dtsi
index ca240cd6f6c3..f00b5a7ec106 100644
--- a/arch/arm/boot/dts/axp209.dtsi
+++ b/arch/arm/boot/dts/axp209.dtsi
@@ -48,6 +48,13 @@
  * http://dl.linux-sunxi.org/AXP/AXP209%20Datasheet%20v1.0_cn.pdf
  */
 
+/ {
+	axp20x_temp {
+		compatible = "iio-hwmon";
+		io-channels = <&axp_adc 4>; /* Internal temperature */
+	};
+};
+
 &axp209 {
 	compatible = "x-powers,axp209";
 	interrupt-controller;
-- 
2.39.2

