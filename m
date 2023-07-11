Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5059274F7EE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 20:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjGKSTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 14:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjGKSTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 14:19:39 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069649C;
        Tue, 11 Jul 2023 11:19:38 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-314313f127fso6232462f8f.1;
        Tue, 11 Jul 2023 11:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689099576; x=1691691576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YGaaVLLljfwhL7I7pdePBXr9vIdDz36pjGnvHMvilI=;
        b=KHmTo/LYJBFDq+TnlOYbcz8G9El6xZsDW/OK2P08tqLF1t9npn0XrfSGSkiT26OKnQ
         hYDJFvqUYTQo8q1VAnAARl7qnhbBUwNmY8aIvRwK+U5zQTxmpjGjHg7q9a4dPZ5O5yMn
         gs9N72SFz6/mkstnvETHv564XOq569alNflXGlIVw/el5N1Tj2aOKimeNPkZ28rORzcp
         Xv0Q43+iLlcXqaC5nWvxzZbHnB3637AjPIdI9r54HsefCiYtM6TD43gbBofdZaMwKI6g
         lE1vDF/IWeb2dus7FP0RDgIa5BRsUvCOR9c5z1fPTNqByISN4gt5XCBn+DNUM5YszAck
         jvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689099576; x=1691691576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YGaaVLLljfwhL7I7pdePBXr9vIdDz36pjGnvHMvilI=;
        b=dDehB4fXyIzZF3FH1wOjo5axrwhfHEbF7UdMqYqv6QacKdxgNPhZEvl9AwDfYu6tFh
         3ZTASfk3Zsx0VM/w9m/Ge3jgDwPlbjzmIjTwIsEQidT7AEJY4miZZMxAKI+TKCgv4ipT
         RMOrPqfdOCsKNPGFD69oa8XNw64F6TyjR0JHFPEIs7QzXIKkxL7jYfMrMuqz6rdRTKI5
         kHdogocB/F0ohR9KxYyEVr9tdReSlKhCxGjgayHM7iVJnp1zbI+RN4yxHLofin0xQCNn
         xZZDOepsYK1ifS3085LyCluGUyltmEucfVTFZg/6XYKP9wLm4XXgg2LLn30xM1NURHpR
         Fvaw==
X-Gm-Message-State: ABy/qLYy0abuSUPcTykh+Ew1gqTjdGd5AcpBEsGQHO/CNrUTqKtDVgG1
        lOElXHMIxKUk4vc9kbE9rtSNue3uQHnWlg==
X-Google-Smtp-Source: APBJJlEWOC+0TIySzdwSSr1Jk0NFX4B0/RuaPAFShvurW/BJZQn5yPYcNHjdV2dkkJY3Wv6DIPIxQA==
X-Received: by 2002:a5d:6b4c:0:b0:313:f7bd:f0 with SMTP id x12-20020a5d6b4c000000b00313f7bd00f0mr16484738wrw.49.1689099576238;
        Tue, 11 Jul 2023 11:19:36 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d5182000000b003143aa0ca8asm2914790wrv.13.2023.07.11.11.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 11:19:35 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-iio@vger.kernel.org, Maksim Kiselev <bigunclemax@gmail.com>
Cc:     Maksim Kiselev <bigunclemax@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Leonard =?ISO-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Maxime Ripard <mripard@kernel.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 4/4] riscv: dts: allwinner: d1: Add GPADC node
Date:   Tue, 11 Jul 2023 20:19:32 +0200
Message-ID: <3238166.aeNJFYEL58@jernej-laptop>
In-Reply-To: <20230619154252.3951913-5-bigunclemax@gmail.com>
References: <20230619154252.3951913-1-bigunclemax@gmail.com>
 <20230619154252.3951913-5-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 19. junij 2023 ob 17:42:27 CEST je Maksim Kiselev napisal(a):
> This patch adds declaration of the general purpose ADC for D1
> and T113s SoCs.
> 
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi index
> 922e8e0e2c09..cb353d5805cb 100644
> --- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> +++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> @@ -138,6 +138,16 @@ ccu: clock-controller@2001000 {
>  			#reset-cells = <1>;
>  		};
> 
> +		gpadc: adc@2009000 {
> +			compatible = "allwinner,sun20i-d1-gpadc";
> +			reg = <0x2009000 0x400>;
> +			clocks = <&ccu CLK_BUS_GPADC>;
> +			resets = <&ccu RST_BUS_GPADC>;
> +			interrupts = <SOC_PERIPHERAL_IRQ(57) 
IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +			#io-channel-cells = <1>;
> +		};
> +
>  		dmic: dmic@2031000 {
>  			compatible = "allwinner,sun20i-d1-dmic",
>  				     "allwinner,sun50i-h6-dmic";




