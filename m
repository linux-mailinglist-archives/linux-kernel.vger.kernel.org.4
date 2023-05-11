Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465766FF6D3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238697AbjEKQMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237852AbjEKQL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:11:58 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69217E5E;
        Thu, 11 May 2023 09:11:53 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9619095f479so1415898766b.1;
        Thu, 11 May 2023 09:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683821512; x=1686413512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWK7qDz8RPMSviiiyfY3G5jruaPWYFOFowQ8o3R6mq8=;
        b=omJKwP23WFR5KuQff4NgapjomKQAFdT7hovJKKJfj6juTL7gGiotD2u1rCDtvSGdMv
         iYAx+he6azKGvyO+DKsnm5+lhF+5h2xAfBw4rh9ygDVAVEKKFCbDMGY5oyuzcney19zg
         MESGtElAM0O8bVjtq9IJ7XxJFCJTVx29y5tWYNw5QeQEM/eJKmmjyVeH9lIPcqFGCup2
         3kMeLU8NjmyNtwc7PMK0rzgaombuKw+HhjDIpLHTzZ63mkjoBbyPeFQtqIGdD698RwDu
         mTTkb72bPAR6IhhSG7NbEYWst0nzwXacYO62eAqkaIT3CLD75pLoYdWT6EOFE1AJe8Zz
         J+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683821512; x=1686413512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uWK7qDz8RPMSviiiyfY3G5jruaPWYFOFowQ8o3R6mq8=;
        b=ElucKTSj843rna6dQvL//4PDjfpoAiE0bMf57kHASczdGOMKLpt3NBNZowO3wHl4Sv
         zwOMZ+hhVIdHmlBfMQ5Gun5UOXHPGxFiG+2a+oZtz0JLgi2ViIpsA+8WCW1Y+Xj90m+V
         z18FsXlwUEbXsx+djU46SvdCVf++N6adtxvBW8oW1o656DJMuB7WS7rHSD7eHfkfeaKT
         dDtl86c6J0UEHk632b2VW1nOrI2Ze7r1Wio55cnDyTo1vKZlE6qTPQCIcSgfBnxT+rWC
         oFrHl48NNk6CxTdHMavh05E3z4AsEeiyTvJOio/cjpLNxlY38ENJyJUQ+Ue8Fc6egcTK
         isXg==
X-Gm-Message-State: AC+VfDwqxy5E35Ek0tLkvCHl90XmmEYMc3mKr3g9kfR1gHm0+Zu5r6BS
        EoyRUwRyYGALjiaVUNtBNxw=
X-Google-Smtp-Source: ACHHUZ6Lmc3sardBsQBIfPjvoITG/uJxmxJi4Pt78kdGUOrIxAirKu3/SHWWN/4TwxIWq3sUTaAJOA==
X-Received: by 2002:a17:906:fe01:b0:94f:322d:909d with SMTP id wy1-20020a170906fe0100b0094f322d909dmr19150863ejb.63.1683821511528;
        Thu, 11 May 2023 09:11:51 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id i18-20020a1709067a5200b009661afd3b86sm4256577ejo.171.2023.05.11.09.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 09:11:51 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan McDowell <noodles@earth.li>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 5/5] ARM: dts: axp209: Add iio-hwmon node for internal
 temperature
Date:   Thu, 11 May 2023 18:11:49 +0200
Message-ID: <3421275.QJadu78ljV@jernej-laptop>
In-Reply-To: <2a9bd53a65c4a154cccba622c60cbffcdceaeb95.1683719613.git.noodles@earth.li>
References: <cover.1681580558.git.noodles@earth.li>
 <cover.1683719613.git.noodles@earth.li>
 <2a9bd53a65c4a154cccba622c60cbffcdceaeb95.1683719613.git.noodles@earth.li>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 10. maj 2023 ob 14:02:28 CEST je Jonathan McDowell napisal(a):
> This adds a DT node to hook up the internal temperature ADC to the
> iio-hwmon driver. The various voltage + current ADCs are consumed and
> exposed by their respective drivers, but this is not and is always
> available. Naming chosen to match the axp20x_ prefix the power sensors
> use.

Sorry for maybe obvious thing, but where are other ADC channels exposed?

Best regards,
Jernej

> 
> Signed-off-by: Jonathan McDowell <noodles@earth.li>
> ---
>  arch/arm/boot/dts/axp209.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp209.dtsi
> index ca240cd6f6c3..469d0f7d5185 100644
> --- a/arch/arm/boot/dts/axp209.dtsi
> +++ b/arch/arm/boot/dts/axp209.dtsi
> @@ -48,6 +48,13 @@
>   * http://dl.linux-sunxi.org/AXP/AXP209%20Datasheet%20v1.0_cn.pdf
>   */
> 
> +/ {
> +	pmic-temp {
> +		compatible = "iio-hwmon";
> +		io-channels = <&axp_adc 4>; /* Internal temperature */
> +	};
> +};
> +
>  &axp209 {
>  	compatible = "x-powers,axp209";
>  	interrupt-controller;




