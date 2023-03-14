Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619E86BA0F3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 21:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjCNUoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 16:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjCNUoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 16:44:44 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3D5F750;
        Tue, 14 Mar 2023 13:44:43 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id fd5so33392356edb.7;
        Tue, 14 Mar 2023 13:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678826682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0F87m94ibj5BbWan5aojgmhq+wBUFnl+QKEcaFZCdV0=;
        b=gxf/72SsrSMbLFOqatSqFflVgNt1bbnS4+ok3reZFnlxYwbj3yInQ75d4sHWLgRoWO
         L/FfRqKco5fsXDQjSMbbxxZKu1NVdu5FxKJ/D3FuRkXWQJTc5OdaHJN6lM11LgLONoG2
         wO5RmrthdftggE/vw43pKxRU8IuRtB+sNjHSvjaVWdISM+t9nQdHMJcK7ANDHGFsvQ8t
         GmsVlmCSgLyBmfRbsIxbbNr6hfol60zqqjnzg4SZyZ+8h7So4R7iNuIUi/yJoROGwDh9
         /nM8YXT8NFV1DWNN+q69s6y69XmZJR2127XJ3nsNOJtp43M+CbfGzLcKccU3StkX5q32
         16ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678826682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0F87m94ibj5BbWan5aojgmhq+wBUFnl+QKEcaFZCdV0=;
        b=zv172eoTft369aDbQPiEbTgFphOnWTcknnKBvi8S5A3TpaNpV7hOpgsMSn3ZkXHwxp
         d/N485maU3aqJuGcwTK4GWHsy7jPmSpx4G4Xhkxb+Y2yJoEc+qPVVF98H4xOQEzYHrrb
         l0SeexoRIA68ofidYI0TxJ0F6BrlO9fhkaEqaxcs6AHi4YJlD159JlejE3+XYMgNBDkQ
         U5LFGPfhrmAen0ZbFkXNI2Rb+4sV/exeUnwKnmkEjcWcfhXRoqDZS/4ExqLNQQcm0ju3
         +LBbvphkWdcEqObVdznYw1+pY1ddV1htUnrpwtERfRkW8+ZAVT3EQ5zCikfT0XolIQUW
         s/GQ==
X-Gm-Message-State: AO0yUKXzSTH5CMvBrM2ae3M6/2ZU5Y0ibJoy2HB0LYV+HgUjrgTOr3ZU
        MrTJGWOQiZ1SB8JRh0ZKr0G3DRDf/LHzhmyJ
X-Google-Smtp-Source: AK7set+FjvdA2a7hcaGhydj/SDHPqvn+qyMA9hZ9eH7e5PKlEoMwB4q6/wpeL8xinWadVWDhw9g0lw==
X-Received: by 2002:aa7:cc92:0:b0:4fc:7352:1131 with SMTP id p18-20020aa7cc92000000b004fc73521131mr318382edt.41.1678826681783;
        Tue, 14 Mar 2023 13:44:41 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id hd31-20020a170907969f00b0092d58e24e11sm1081680ejc.137.2023.03.14.13.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 13:44:41 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Trevor Woerner <twoerner@gmail.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v3 2/2] riscv: dts: nezha-d1: add gpio-line-names
Date:   Tue, 14 Mar 2023 21:44:40 +0100
Message-ID: <2337214.NG923GbCHz@jernej-laptop>
In-Reply-To: <20230210025132.36605-2-twoerner@gmail.com>
References: <20230210025132.36605-1-twoerner@gmail.com>
 <20230210025132.36605-2-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 10. februar 2023 ob 03:51:32 CET je Trevor Woerner napisal(a):
> Add descriptive names so users can associate specific lines with their
> respective pins on the 40-pin header according to the schematics.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> Link:
> http://dl.linux-sunxi.org/D1/D1_Nezha_development_board_schematic_diagram_2
> 0210224.pdf

Applied, but next time please make sure e-mails are not linked together, as 
Conor said.

Best regards,
Jernej

> ---
> changes since v2:
> - (no changes, skip to a v3 to align with the other patch in this group)
> 
> changes since v1:
> - this patch needs to be placed in order, and come second, after a patch to
>   update the schema for the nxp,pcf8575, put this patch in a group where it
>   wasn't previously
> - use a Link: to point to the schematic
> - add a comment section describing the rational behind the naming that was
>   used
> - make the spacing of each line name uniform, don't try to "line them up"
>   vertically
> ---
>  .../boot/dts/allwinner/sun20i-d1-nezha.dts    | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts
> b/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts index
> a0769185be97..4ed33c1e7c9c 100644
> --- a/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts
> +++ b/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts
> @@ -1,6 +1,25 @@
>  // SPDX-License-Identifier: (GPL-2.0+ or MIT)
>  // Copyright (C) 2021-2022 Samuel Holland <samuel@sholland.org>
> 
> +/*
> + * gpio line names
> + *
> + * The Nezha-D1 has a 40-pin IO header. Some of these pins are routed
> + * directly to pads on the SoC, others come from an 8-bit pcf857x IO
> + * expander. Therefore, these line names are specified in two places:
> + * one set for the pcf857x, and one set for the pio controller.
> + *
> + * Lines which are routed to the 40-pin header are named as follows:
> + *	<pin#> [<pin name>]
> + * where:
> + *	<pin#>		is the actual pin number of the 40-pin 
header
> + *	<pin name>	is the name of the pin by function/gpio#
> + *
> + * For details regarding pin numbers and names see the schematics (under
> + * "IO EXPAND"):
> + *
> http://dl.linux-sunxi.org/D1/D1_Nezha_development_board_schematic_diagram_2
> 0210224.pdf + */
> +
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
> 
> @@ -90,6 +109,15 @@ pcf8574a: gpio@38 {
>  		gpio-controller;
>  		#gpio-cells = <2>;
>  		#interrupt-cells = <2>;
> +		gpio-line-names =
> +			"pin13 [gpio8]",
> +			"pin16 [gpio10]",
> +			"pin18 [gpio11]",
> +			"pin26 [gpio17]",
> +			"pin22 [gpio14]",
> +			"pin28 [gpio19]",
> +			"pin37 [gpio23]",
> +			"pin11 [gpio6]";
>  	};
>  };
> 
> @@ -164,3 +192,47 @@ &usbphy {
>  	usb1_vbus-supply = <&reg_vcc>;
>  	status = "okay";
>  };
> +
> +&pio {
> +	gpio-line-names =
> +		/* Port A */
> +		"", "", "", "", "", "", "", "",
> +		"", "", "", "", "", "", "", "",
> +		"", "", "", "", "", "", "", "",
> +		"", "", "", "", "", "", "", "",
> +		/* Port B */
> +		"pin5 [gpio2/twi2-sck]",
> +		"pin3 [gpio1/twi2-sda]",
> +		"",
> +		"pin38 [gpio24/i2s2-din]",
> +		"pin40 [gpio25/i2s2-dout]",
> +		"pin12 [gpio7/i2s-clk]",
> +		"pin35 [gpio22/i2s2-lrck]",
> +		"",
> +		"pin8 [gpio4/uart0-txd]",
> +		"pin10 [gpio5/uart0-rxd]",
> +		"",
> +		"",
> +		"pin15 [gpio9]",
> +		"", "", "", "",
> +		"", "", "", "", "", "", "", "",
> +		"", "", "", "", "", "", "", "",
> +		/* Port C */
> +		"",
> +		"pin31 [gpio21]",
> +		"", "", "", "", "", "",
> +		"", "", "", "", "", "", "", "",
> +		"", "", "", "", "", "", "", "",
> +		"", "", "", "", "", "", "", "",
> +		/* Port D */
> +		"", "", "", "", "", "", "", "",
> +		"", "",
> +		"pin24 [gpio16/spi1-ce0]",
> +		"pin23 [gpio15/spi1-clk]",
> +		"pin19 [gpio12/spi1-mosi]",
> +		"pin21 [gpio13/spi1-miso]",
> +		"pin27 [gpio18/spi1-hold]",
> +		"pin29 [gpio20/spi1-wp]",
> +		"", "", "", "", "", "",
> +		"pin7 [gpio3/pwm]";
> +};




