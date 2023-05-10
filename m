Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117FA6FD778
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 08:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbjEJGyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 02:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbjEJGy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 02:54:29 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5552711;
        Tue,  9 May 2023 23:54:28 -0700 (PDT)
Received: from pendragon.ideasonboard.com (softbank126090219015.bbtec.net [126.90.219.15])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B8606547;
        Wed, 10 May 2023 08:54:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1683701659;
        bh=rfTXcWN2v7WbqgO1wFmE1HPPEOFBTwIEbnS+0CguvK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bT2CVwOWdkHjguWk2h4qe9qT/Fz7aWLnSWiOUKuM0Y7BGJGTLp2lmCRxHgFeGgShM
         iUHElVASsUTIt/k64BddeSYI5z6GEnusS330/VLVfbJTvlDbTmJtQO3rHeJ5gu6LWz
         v4+JYdqbHn0Bbq2tzoEB2gJ22iRXY7sHpjeRuGeo=
Date:   Wed, 10 May 2023 09:54:21 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Andrew Davis <afd@ti.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vishal Sagar <vishal.sagar@amd.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 02/23] arm64: zynqmp: Fix usb node drive strength and
 slew rate
Message-ID: <20230510065421.GB11711@pendragon.ideasonboard.com>
References: <cover.1683034376.git.michal.simek@amd.com>
 <1b2914e5e6010b174c14603f92626ac3b11a2263.1683034376.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b2914e5e6010b174c14603f92626ac3b11a2263.1683034376.git.michal.simek@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

Thank you for the patch.

On Tue, May 02, 2023 at 03:35:30PM +0200, Michal Simek wrote:
> From: Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>
> 
> As per design, all input/rx pins should have fast slew rate and 12mA
> drive strength.

Why does the slow rate and drive strength matter for input pins ?

> Rest all pins should be slow slew rate and 4mA drive
> strength. Fix usb nodes as per this and remove setting of slow slew rate
> for all the usb group pins.
> 
> Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>  .../arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso |  8 ++++++--
>  .../arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso |  8 ++++++--
>  .../boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts     |  8 ++++++--
>  .../boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts     |  8 ++++++--
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts   | 13 ++++++++++---
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts   |  5 ++++-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts   |  6 ++++--
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts   |  6 ++++--
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts   |  5 ++++-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts   |  5 ++++-
>  10 files changed, 54 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
> index b610e65e0cdf..2f7a17ec58b4 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
> @@ -2,7 +2,8 @@
>  /*
>   * dts file for KV260 revA Carrier Card
>   *
> - * (C) Copyright 2020 - 2021, Xilinx, Inc.
> + * (C) Copyright 2020 - 2022, Xilinx, Inc.
> + * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
>   *
>   * SD level shifter:
>   * "A" – A01 board un-modified (NXP)
> @@ -259,19 +260,22 @@ mux {
>  	pinctrl_usb0_default: usb0-default {
>  		conf {
>  			groups = "usb0_0_grp";
> -			slew-rate = <SLEW_RATE_SLOW>;
>  			power-source = <IO_STANDARD_LVCMOS18>;
>  		};
>  
>  		conf-rx {
>  			pins = "MIO52", "MIO53", "MIO55";
>  			bias-high-impedance;
> +			drive-strength = <12>;
> +			slew-rate = <SLEW_RATE_FAST>;
>  		};
>  
>  		conf-tx {
>  			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
>  			"MIO60", "MIO61", "MIO62", "MIO63";
>  			bias-disable;
> +			drive-strength = <4>;
> +			slew-rate = <SLEW_RATE_SLOW>;
>  		};
>  
>  		mux {
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
> index a52dafbfd59e..4695e0e3714f 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
> @@ -2,7 +2,8 @@
>  /*
>   * dts file for KV260 revA Carrier Card
>   *
> - * (C) Copyright 2020 - 2021, Xilinx, Inc.
> + * (C) Copyright 2020 - 2022, Xilinx, Inc.
> + * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
>   *
>   * Michal Simek <michal.simek@xilinx.com>
>   */
> @@ -242,19 +243,22 @@ mux {
>  	pinctrl_usb0_default: usb0-default {
>  		conf {
>  			groups = "usb0_0_grp";
> -			slew-rate = <SLEW_RATE_SLOW>;
>  			power-source = <IO_STANDARD_LVCMOS18>;
>  		};
>  
>  		conf-rx {
>  			pins = "MIO52", "MIO53", "MIO55";
>  			bias-high-impedance;
> +			drive-strength = <12>;
> +			slew-rate = <SLEW_RATE_FAST>;
>  		};
>  
>  		conf-tx {
>  			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
>  			"MIO60", "MIO61", "MIO62", "MIO63";
>  			bias-disable;
> +			drive-strength = <4>;
> +			slew-rate = <SLEW_RATE_SLOW>;
>  		};
>  
>  		mux {
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
> index f89ef2afcd9e..5fa9604f05d1 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
> @@ -2,7 +2,8 @@
>  /*
>   * dts file for Xilinx ZynqMP zc1751-xm015-dc1
>   *
> - * (C) Copyright 2015 - 2021, Xilinx, Inc.
> + * (C) Copyright 2015 - 2022, Xilinx, Inc.
> + * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
>   *
>   * Michal Simek <michal.simek@xilinx.com>
>   */
> @@ -187,19 +188,22 @@ mux {
>  
>  		conf {
>  			groups = "usb0_0_grp";
> -			slew-rate = <SLEW_RATE_SLOW>;
>  			power-source = <IO_STANDARD_LVCMOS18>;
>  		};
>  
>  		conf-rx {
>  			pins = "MIO52", "MIO53", "MIO55";
>  			bias-high-impedance;
> +			drive-strength = <12>;
> +			slew-rate = <SLEW_RATE_FAST>;
>  		};
>  
>  		conf-tx {
>  			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
>  			       "MIO60", "MIO61", "MIO62", "MIO63";
>  			bias-disable;
> +			drive-strength = <4>;
> +			slew-rate = <SLEW_RATE_SLOW>;
>  		};
>  	};
>  
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
> index 938b76bd0527..a2031187d9b3 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
> @@ -2,7 +2,8 @@
>  /*
>   * dts file for Xilinx ZynqMP zc1751-xm016-dc2
>   *
> - * (C) Copyright 2015 - 2021, Xilinx, Inc.
> + * (C) Copyright 2015 - 2022, Xilinx, Inc.
> + * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
>   *
>   * Michal Simek <michal.simek@xilinx.com>
>   */
> @@ -281,19 +282,22 @@ mux {
>  
>  		conf {
>  			groups = "usb1_0_grp";
> -			slew-rate = <SLEW_RATE_SLOW>;
>  			power-source = <IO_STANDARD_LVCMOS18>;
>  		};
>  
>  		conf-rx {
>  			pins = "MIO64", "MIO65", "MIO67";
>  			bias-high-impedance;
> +			drive-strength = <12>;
> +			slew-rate = <SLEW_RATE_FAST>;
>  		};
>  
>  		conf-tx {
>  			pins = "MIO66", "MIO68", "MIO69", "MIO70", "MIO71",
>  			       "MIO72", "MIO73", "MIO74", "MIO75";
>  			bias-disable;
> +			drive-strength = <4>;
> +			slew-rate = <SLEW_RATE_SLOW>;
>  		};
>  	};
>  
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> index c74bc3ff703b..2dd552cf51fb 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> @@ -2,7 +2,8 @@
>  /*
>   * dts file for Xilinx ZynqMP ZCU100 revC
>   *
> - * (C) Copyright 2016 - 2021, Xilinx, Inc.
> + * (C) Copyright 2016 - 2022, Xilinx, Inc.
> + * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
>   *
>   * Michal Simek <michal.simek@xilinx.com>
>   * Nathalie Chan King Choy
> @@ -423,19 +424,22 @@ mux {
>  
>  		conf {
>  			groups = "usb0_0_grp";
> -			slew-rate = <SLEW_RATE_SLOW>;
>  			power-source = <IO_STANDARD_LVCMOS18>;
>  		};
>  
>  		conf-rx {
>  			pins = "MIO52", "MIO53", "MIO55";
>  			bias-high-impedance;
> +			drive-strength = <12>;
> +			slew-rate = <SLEW_RATE_FAST>;
>  		};
>  
>  		conf-tx {
>  			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
>  			       "MIO60", "MIO61", "MIO62", "MIO63";
>  			bias-disable;
> +			drive-strength = <4>;
> +			slew-rate = <SLEW_RATE_SLOW>;
>  		};
>  	};
>  
> @@ -447,19 +451,22 @@ mux {
>  
>  		conf {
>  			groups = "usb1_0_grp";
> -			slew-rate = <SLEW_RATE_SLOW>;
>  			power-source = <IO_STANDARD_LVCMOS18>;
>  		};
>  
>  		conf-rx {
>  			pins = "MIO64", "MIO65", "MIO67";
>  			bias-high-impedance;
> +			drive-strength = <12>;
> +			slew-rate = <SLEW_RATE_FAST>;
>  		};
>  
>  		conf-tx {
>  			pins = "MIO66", "MIO68", "MIO69", "MIO70", "MIO71",
>  			       "MIO72", "MIO73", "MIO74", "MIO75";
>  			bias-disable;
> +			drive-strength = <4>;
> +			slew-rate = <SLEW_RATE_SLOW>;
>  		};
>  	};
>  };
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> index c193579400cf..78043d9de7cc 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> @@ -783,19 +783,22 @@ mux {
>  
>  		conf {
>  			groups = "usb0_0_grp";
> -			slew-rate = <SLEW_RATE_SLOW>;
>  			power-source = <IO_STANDARD_LVCMOS18>;
>  		};
>  
>  		conf-rx {
>  			pins = "MIO52", "MIO53", "MIO55";
>  			bias-high-impedance;
> +			drive-strength = <12>;
> +			slew-rate = <SLEW_RATE_FAST>;
>  		};
>  
>  		conf-tx {
>  			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
>  			       "MIO60", "MIO61", "MIO62", "MIO63";
>  			bias-disable;
> +			drive-strength = <4>;
> +			slew-rate = <SLEW_RATE_SLOW>;
>  		};
>  	};
>  
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> index 11c1eaef9f53..c1779c88ec34 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> @@ -410,20 +410,22 @@ mux {
>  
>  		conf {
>  			groups = "usb0_0_grp";
> -			slew-rate = <SLEW_RATE_SLOW>;
>  			power-source = <IO_STANDARD_LVCMOS18>;
> -			drive-strength = <12>;
>  		};
>  
>  		conf-rx {
>  			pins = "MIO52", "MIO53", "MIO55";
>  			bias-high-impedance;
> +			drive-strength = <12>;
> +			slew-rate = <SLEW_RATE_FAST>;
>  		};
>  
>  		conf-tx {
>  			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
>  			       "MIO60", "MIO61", "MIO62", "MIO63";
>  			bias-disable;
> +			drive-strength = <4>;
> +			slew-rate = <SLEW_RATE_SLOW>;
>  		};
>  	};
>  };
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> index c06c138fa3e5..b857c1950496 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> @@ -422,20 +422,22 @@ mux {
>  
>  		conf {
>  			groups = "usb0_0_grp";
> -			slew-rate = <SLEW_RATE_SLOW>;
>  			power-source = <IO_STANDARD_LVCMOS18>;
> -			drive-strength = <12>;
>  		};
>  
>  		conf-rx {
>  			pins = "MIO52", "MIO53", "MIO55";
>  			bias-high-impedance;
> +			drive-strength = <12>;
> +			slew-rate = <SLEW_RATE_FAST>;
>  		};
>  
>  		conf-tx {
>  			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
>  			       "MIO60", "MIO61", "MIO62", "MIO63";
>  			bias-disable;
> +			drive-strength = <4>;
> +			slew-rate = <SLEW_RATE_SLOW>;
>  		};
>  	};
>  };
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> index 52cdec33f190..e4e09afbdc1a 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> @@ -794,19 +794,22 @@ mux {
>  
>  		conf {
>  			groups = "usb0_0_grp";
> -			slew-rate = <SLEW_RATE_SLOW>;
>  			power-source = <IO_STANDARD_LVCMOS18>;
>  		};
>  
>  		conf-rx {
>  			pins = "MIO52", "MIO53", "MIO55";
>  			bias-high-impedance;
> +			drive-strength = <12>;
> +			slew-rate = <SLEW_RATE_FAST>;
>  		};
>  
>  		conf-tx {
>  			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
>  			       "MIO60", "MIO61", "MIO62", "MIO63";
>  			bias-disable;
> +			drive-strength = <4>;
> +			slew-rate = <SLEW_RATE_SLOW>;
>  		};
>  	};
>  
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> index 699cc9ce7898..791b2ac9fbdb 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> @@ -660,19 +660,22 @@ mux {
>  
>  		conf {
>  			groups = "usb0_0_grp";
> -			slew-rate = <SLEW_RATE_SLOW>;
>  			power-source = <IO_STANDARD_LVCMOS18>;
>  		};
>  
>  		conf-rx {
>  			pins = "MIO52", "MIO53", "MIO55";
>  			bias-high-impedance;
> +			drive-strength = <12>;
> +			slew-rate = <SLEW_RATE_FAST>;
>  		};
>  
>  		conf-tx {
>  			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
>  			       "MIO60", "MIO61", "MIO62", "MIO63";
>  			bias-disable;
> +			drive-strength = <4>;
> +			slew-rate = <SLEW_RATE_SLOW>;
>  		};
>  	};
>  

-- 
Regards,

Laurent Pinchart
