Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311FB6D8399
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjDEQZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDEQZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:25:25 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B80135;
        Wed,  5 Apr 2023 09:25:24 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id E99FD8003E;
        Wed,  5 Apr 2023 18:25:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1680711922;
        bh=abitu08+QMjnVXwXPewZ20kjKAOARX4XPvA74FQpR3s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QNNlx0N8XY7j0STYlSetL19R1p20KFh0b/vpujh5MMirrLBCuw7NX5enY+sNzVlNG
         Cox9fzKZgoKhXEgfn1ifTSQBWixd8XG6j0NQ1ydi/K95dJYAlx1wWAp5uQZ8yszgsy
         4PsqhsHoaEke/e7psvHioeuLco2SiF6GVYOWD+2wWk0yaacsuekOImSTx38RMKgUXM
         6Fgycwe3jV4H2bkhbot7JFIx8nQOwzUiw0U0QJ8LvynzcRum5t+9LFgzWQjn0kwSav
         dunDck93qUomoEE8bRrMneVfRCcsflsKZ0veUW+uTJ4UoBaQky93CIuLWvRyyw11bD
         d2nBnZzeqJM3g==
Message-ID: <05fa147c-116b-59b4-d14b-760bbefd7602@denx.de>
Date:   Wed, 5 Apr 2023 18:25:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] ARM: dts: imx6ull-dhcor: Add Marantec maveo box
Content-Language: en-US
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        kernel@dh-electronics.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230405160258.46998-1-cniedermaier@dh-electronics.com>
 <20230405160258.46998-2-cniedermaier@dh-electronics.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230405160258.46998-2-cniedermaier@dh-electronics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-3.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/23 18:02, Christoph Niedermaier wrote:

[...]

> +/ {
> +	model = "DH electronics i.MX6ULL DHCOR on maveo box";
> +	compatible = "dh,imx6ull-dhcor-maveo-box", "dh,imx6ull-dhcor-som",
> +		     "fsl,imx6ull";
> +
> +	aliases {
> +		/delete-property/ mmc0; /* Avoid double definitions */
> +		/delete-property/ mmc1;
> +		mmc2 = &usdhc2; /* eMMC should be mmc2 */

Why not mmc0 ?

Use root=PARTUUID= when booting to avoid any dependency on 
root=/dev/mmcblk2pN enumeration.

> +		spi0 = &ecspi4;
> +		spi3 = &ecspi1;
> +	};

[...]

> +&iomuxc {
> +	pinctrl-0 = <&pinctrl_hog_maveo_box>;
> +	pinctrl-names = "default";
> +
> +	pinctrl_hog_maveo_box: hog-maveo-box-grp {
> +		fsl,pins = <
> +			MX6UL_PAD_GPIO1_IO05__GPIO1_IO05	0x400120b0 /* BUTTON_USER */
> +			MX6UL_PAD_GPIO1_IO08__GPIO1_IO08	0x400120b0 /* BUTTON_RESET */
> +			MX6UL_PAD_CSI_PIXCLK__GPIO4_IO18	0x400120b0 /* LED_G */
> +			MX6UL_PAD_CSI_DATA02__GPIO4_IO23	0x400120b0 /* LED_B */

Should the "SION(1 << 30): Software Input On Field." bit really be set 
on GPIOs which are OUTPUT (like LEDs) ?

[...]
