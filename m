Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77325BADDD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiIPNM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiIPNM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:12:26 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAE393502;
        Fri, 16 Sep 2022 06:12:18 -0700 (PDT)
Received: from [89.101.193.70] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oZB8d-00035v-NI; Fri, 16 Sep 2022 15:12:11 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alessandro Carminati <alessandro.carminati@gmail.com>
Subject: Re: [PATCH 2/2] Add sata version of the quartz64-a board
Date:   Fri, 16 Sep 2022 15:12:10 +0200
Message-ID: <2385186.jE0xQCEvom@phil>
In-Reply-To: <YyRxx4zovhMMeQYV@lab.hqhome163.com>
References: <YyRxx4zovhMMeQYV@lab.hqhome163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alessandro,

Am Freitag, 16. September 2022, 14:53:27 CEST schrieb Alessandro Carminati:
> The Quartz64 board is built upon Rockchip RK3566.
> Rockchip RK3566 has two combo phys.
> The first connects USB3 and SATA ctrl1, and the second PCIe lane and SATA
> ctrl2.
> The second combo phy is hardwired to the PCIe slot, where for the first,
> the hardware on the board provides both the USB3 connector and the SATA
> connector.
> This DT allows the users to switch the combo phy to the SATA connector.
> 
> Signed-off-by: Alessandro Carminati <alessandro.carminati@gmail.com>

I'm not really sure what the best way to do this is.

For one, this is mainly a configuration thing, so I was more thinking
about a devicetree-overlay as the right thing to use.

On the other hand this is touches essential a device you may want to
boot from. Though an initramfs may be able to solve this.

So I'm really not sure - maybe the dt-maintainers can provide some
direction :-)


Some more general stuff below (and here):

Please always use prefixes in your patch subject matching
the subsystem - can be found by just using "git log" on the directory.

Here it would be "arm64: dts: rockchip: foo"

> ---
>  arch/arm64/boot/dts/rockchip/Makefile                   | 1 +
>  arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.sata.dts | 9 +++++++++
>  2 files changed, 10 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.sata.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 97ec6c156346..5c82881a92d3 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -60,6 +60,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399pro-rock-pi-n10.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.1.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.2.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-a.usb3.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-a.sata.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-b.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-roc-pc.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-soquartz-cm4.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.sata.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.sata.dts
> new file mode 100644
> index 000000000000..8620df7ec01e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.sata.dts
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +
> +#include "rk3566-quartz64-a.dtsi"
> +
> +&sata1 {
> +	status = "okay";
> +};

I guess you may want to disable the now unused usb controller?


Heiko






