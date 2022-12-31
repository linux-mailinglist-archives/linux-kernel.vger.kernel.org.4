Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1A165A302
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 07:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiLaGt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 01:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiLaGtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 01:49:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C88562E8;
        Fri, 30 Dec 2022 22:49:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BB5760907;
        Sat, 31 Dec 2022 06:49:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04822C433EF;
        Sat, 31 Dec 2022 06:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672469373;
        bh=fnRYgVKMoABU+4Ag+jvUfIngNPTfPy9gyioYbQfxmZg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OWbqu1OsxXWlitVjEjQ3chupXVHwpdCztR0F+Z9dYdHilOBJ7OKf/wx0w/EZzpRnh
         C3TM/R2oUKo6rGuJNLtepwWAKj5btI+4KEJjcLcRe0RivwZ4ufokcj4qRpugKxDBac
         VOUbOJ9498SHXUK/jFZkqCMjhyDLO3f+ofeFVD+R/0owkaUmGXGkfgWapvwue767zw
         ZdZrfWMreS91DA4wU12NqrSAPKQwS99DBFyvl6XHIj/k1mzS//yK2Q6MgwKfmJJIH1
         nG6MrzhiGvT1l9aPPkNFo75TLA1qpJ/NGbqX4hhgdtP/dV/qW76io7SYQyJkjfB+fl
         N4zExTHUnsxmQ==
Date:   Sat, 31 Dec 2022 14:49:24 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Nikolaus Voss <nikolaus.voss@haag-streit.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, nv@vosn.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] imx6qdl.dtsi: use MAC-address from nvmem
Message-ID: <20221231064923.GD6112@T480>
References: <20221128084749.5F10D1D73@mail.steuer-voss.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128084749.5F10D1D73@mail.steuer-voss.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 03:27:19PM +0100, Nikolaus Voss wrote:
> IMX6QDL has fuse locations specified for storing the MAC for the
> built-in ethernet (Table 5-8 in Reference Manual).
> Define the fuse location in ocotp and refer to them in fec-ethernet.
> 
> If the cells are not flashed, the driver behavior is unchanged, i.e.
> other MAC sources will be probed and a random MAC will be used as a
> last resort.
> 
> Signed-off-by: Nikolaus Voss <nikolaus.voss@haag-streit.com>
> ---
>  arch/arm/boot/dts/imx6qdl.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 4f7fefc14d0ac..7449d554ef1aa 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -1053,6 +1053,8 @@ fec: ethernet@2188000 {
>  					 <&clks IMX6QDL_CLK_ENET_REF>;
>  				clock-names = "ipg", "ahb", "ptp", "enet_out";
>  				fsl,stop-mode = <&gpr 0x34 27>;
> +				nvmem-cells = <&fec_mac_addr>;
> +				nvmem-cell-names = "mac-address";

May I ask where is the support of FEC driver for this?

Shawn

>  				status = "disabled";
>  			};
>  
> @@ -1186,6 +1188,10 @@ tempmon_calib: calib@38 {
>  				tempmon_temp_grade: temp-grade@20 {
>  					reg = <0x20 4>;
>  				};
> +
> +				fec_mac_addr: mac-addr@88 {
> +					reg = <0x88 6>;
> +				};
>  			};
>  
>  			tzasc@21d0000 { /* TZASC1 */
> -- 
> 2.34.1
> 
