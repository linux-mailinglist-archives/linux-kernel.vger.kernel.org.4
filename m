Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6A460B5F6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbiJXSoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbiJXSnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:43:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E036F147074;
        Mon, 24 Oct 2022 10:25:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 401551477;
        Mon, 24 Oct 2022 07:17:12 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 243153F792;
        Mon, 24 Oct 2022 07:17:04 -0700 (PDT)
Date:   Mon, 24 Oct 2022 15:17:01 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Icenowy Zheng <uwu@icenowy.me>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        soc@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 02/10] dt-bindings: phy: add binding document for
 Allwinner F1C100s USB PHY
Message-ID: <20221024151701.3dff5794@donnerap.cambridge.arm.com>
In-Reply-To: <20221012055602.1544944-3-uwu@icenowy.me>
References: <20221012055602.1544944-1-uwu@icenowy.me>
        <20221012055602.1544944-3-uwu@icenowy.me>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Oct 2022 13:55:54 +0800
Icenowy Zheng <uwu@icenowy.me> wrote:

> Allwinner F1C100s has the most simple USB PHY among all Allwinner SoCs,
> because it has only one OTG USB controller, no host-only OHCI/EHCI
> controllers.
> 
> Add a binding document for it. Following the current situation of one
> YAML file per SoC, this one is based on
> allwinner,sun8i-v3s-usb-phy.yaml, but with OHCI/EHCI-related bits
> removed. (The same driver in Linux, phy-sun4i-usb, covers all these
> binding files now.)
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes in v2:
> - Clarify the relation with other phy-sun4i-usb bindings.
> - Added Rob's ACK.
> 
>  .../phy/allwinner,suniv-f1c100s-usb-phy.yaml  | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/allwinner,suniv-f1c100s-usb-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/allwinner,suniv-f1c100s-usb-phy.yaml b/Documentation/devicetree/bindings/phy/allwinner,suniv-f1c100s-usb-phy.yaml
> new file mode 100644
> index 000000000000..22ff8e0f2331
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/allwinner,suniv-f1c100s-usb-phy.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/allwinner,suniv-f1c100s-usb-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner F1C100s USB PHY Device Tree Bindings

I see that commit dd3cb467ebb56 [1] discourages the redundant "Device Tree
Bindings" suffix in the title name, so I think you should remove that.

The rest looks alright to me, compared against the manual and what the
driver expects, so with that fixed:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dd3cb467ebb56

> +
> +maintainers:
> +  - Chen-Yu Tsai <wens@csie.org>
> +  - Maxime Ripard <mripard@kernel.org>
> +
> +properties:
> +  "#phy-cells":
> +    const: 1
> +
> +  compatible:
> +    const: allwinner,suniv-f1c100s-usb-phy
> +
> +  reg:
> +    maxItems: 1
> +    description: PHY Control registers
> +
> +  reg-names:
> +    const: phy_ctrl
> +
> +  clocks:
> +    maxItems: 1
> +    description: USB OTG PHY bus clock
> +
> +  clock-names:
> +    const: usb0_phy
> +
> +  resets:
> +    maxItems: 1
> +    description: USB OTG reset
> +
> +  reset-names:
> +    const: usb0_reset
> +
> +  usb0_id_det-gpios:
> +    maxItems: 1
> +    description: GPIO to the USB OTG ID pin
> +
> +  usb0_vbus_det-gpios:
> +    maxItems: 1
> +    description: GPIO to the USB OTG VBUS detect pin
> +
> +  usb0_vbus_power-supply:
> +    description: Power supply to detect the USB OTG VBUS
> +
> +  usb0_vbus-supply:
> +    description: Regulator controlling USB OTG VBUS
> +
> +required:
> +  - "#phy-cells"
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - reg
> +  - reg-names
> +  - resets
> +  - reset-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/clock/suniv-ccu-f1c100s.h>
> +    #include <dt-bindings/reset/suniv-ccu-f1c100s.h>
> +
> +    phy@1c13400 {
> +        compatible = "allwinner,suniv-f1c100s-usb-phy";
> +        reg = <0x01c13400 0x10>;
> +        reg-names = "phy_ctrl";
> +        clocks = <&ccu CLK_USB_PHY0>;
> +        clock-names = "usb0_phy";
> +        resets = <&ccu RST_USB_PHY0>;
> +        reset-names = "usb0_reset";
> +        #phy-cells = <1>;
> +        usb0_id_det-gpios = <&pio 4 2 GPIO_ACTIVE_HIGH>;
> +    };

