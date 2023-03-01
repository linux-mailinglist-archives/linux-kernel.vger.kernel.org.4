Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDDB6A6868
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 08:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjCAHvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 02:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCAHvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 02:51:15 -0500
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0212B615;
        Tue, 28 Feb 2023 23:51:13 -0800 (PST)
Received: from [192.168.0.2] (ip5f5aefed.dynamic.kabel-deutschland.de [95.90.239.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5291661CC457B;
        Wed,  1 Mar 2023 08:51:10 +0100 (CET)
Message-ID: <775059b1-4697-b745-4743-55f7f7a9143e@molgen.mpg.de>
Date:   Wed, 1 Mar 2023 08:51:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] ARM: dts: aspeed: mtmitchell: Enable NCSI
To:     Chanh Nguyen <chanh@os.amperecomputing.com>
References: <20230228102820.18477-1-chanh@os.amperecomputing.com>
Content-Language: en-US
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230228102820.18477-1-chanh@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Chanh,


Thank you for the patch.

Am 28.02.23 um 11:28 schrieb Chanh Nguyen:
> Support the mac3 (RGMII4) as an NC-SI stack instead of an MDIO PHY.
> 
> The OCP slot #0 and OCP slot #1 use a common the BMC_NCSI signal,

*the* seems a leftover.

> so we use only one of them at the same time. The OCP slot #0 will
> be enabled by PCA9539's setting by default.
> 
> Also, enable the OCP Auxiliary Power during booting.

Is there a reason not to make this a separate commit?


Kind regards,

Paul


> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
> ---
> Changes in v2:
>     - Change PCA9539APW node name.                     [Krzysztof]
> ---
>   .../boot/dts/aspeed-bmc-ampere-mtmitchell.dts | 37 ++++++++++++++++++-
>   1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> index 4b91600eaf62..1e0e88465254 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> @@ -251,6 +251,14 @@
>   	pinctrl-0 = <&pinctrl_rgmii1_default>;
>   };
>   
> +&mac3 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rmii4_default>;
> +	clock-names = "MACCLK", "RCLK";
> +	use-ncsi;
> +};
> +
>   &fmc {
>   	status = "okay";
>   	flash@0 {
> @@ -439,6 +447,26 @@
>   	status = "okay";
>   };
>   
> +&i2c8 {
> +	status = "okay";
> +
> +	gpio@77 {
> +		compatible = "nxp,pca9539";
> +		reg = <0x77>;
> +		gpio-controller;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		#gpio-cells = <2>;
> +
> +		bmc-ocp0-en-hog {
> +			gpio-hog;
> +			gpios = <7 GPIO_ACTIVE_LOW>;
> +			output-high;
> +			line-name = "bmc-ocp0-en-n";
> +		};
> +	};
> +};
> +
>   &i2c9 {
>   	status = "okay";
>   };
> @@ -530,13 +558,20 @@
>   	/*V0-V7*/	"s0-hightemp-n","s0-fault-alert","s0-sys-auth-failure-n",
>   			"host0-reboot-ack-n","host0-ready","host0-shd-req-n",
>   			"host0-shd-ack-n","s0-overtemp-n",
> -	/*W0-W7*/	"ocp-aux-pwren","ocp-main-pwren","ocp-pgood","",
> +	/*W0-W7*/	"","ocp-main-pwren","ocp-pgood","",
>   			"bmc-ok","bmc-ready","spi0-program-sel","spi0-backup-sel",
>   	/*X0-X7*/	"i2c-backup-sel","s1-fault-alert","s1-fw-boot-ok",
>   			"s1-hightemp-n","s0-spi-auth-fail-n","s1-sys-auth-failure-n",
>   			"s1-overtemp-n","s1-spi-auth-fail-n",
>   	/*Y0-Y7*/	"","","","","","","","host0-special-boot",
>   	/*Z0-Z7*/	"reset-button","ps0-pgood","ps1-pgood","","","","","";
> +
> +	ocp-aux-pwren-hog {
> +		gpio-hog;
> +		gpios = <ASPEED_GPIO(W, 0) GPIO_ACTIVE_HIGH>;
> +		output-high;
> +		line-name = "ocp-aux-pwren";
> +	};
>   };
>   
>   &gpio1 {
