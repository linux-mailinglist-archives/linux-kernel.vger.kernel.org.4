Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D615B5DF5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 18:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiILQPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 12:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiILQPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 12:15:15 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B84F12613
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 09:15:14 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e20so16141297wri.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 09:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=M0xmdgrmwbDBhsKXm8W2iTCB3o2g5k9UR6WS8CgTgAc=;
        b=Oxw61ItYOZEFE3R9dscWj0YuzCJ7CCVcOrfiBfKNEDsx/Aq5ErBXBfqZbtvfWuPX++
         i2mEGSZ0rWDJAjlRdBKMC8BZ62bIvCziS/Es4XF0lhgcdQwWC6L/OPhmn69JU3ttZAsI
         9cVmlIdvu/F965sUahklPfNqgAjA6e5Q63oZ15mvA7U7ExYUlF1bIxpJPc7pC0JWw5ty
         GLQs9oBo4z8LYnpw4VhiY0AbUYwQdhgV9t7bYpBkELDCW6CWThwbEaN4UseBm6BhakFw
         44wQuMX0ozZjSAvtzBdqncTB2L/7M404U0QQ89tU9gN6Qk8vgLF0AohgO8It/rvmRI2p
         LKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=M0xmdgrmwbDBhsKXm8W2iTCB3o2g5k9UR6WS8CgTgAc=;
        b=TQq8lW5xGObHH2Kcfjg02y6i0dOviDrykWHCIeox4RdSytF7SB08jVf/X/33Ztke/x
         VRTAh4Uv8JaGl3nQkqUhwyVJI9oQKS9TwP8doMiQW/1gRivHmzuMYnNGNtr+nncB/M3v
         ngEX6e10JFno/ALLhatG0XkQu2gRHqPZ4CA8KOKGAlJKyJT7nqlUvj6H4Zw2D9UuL27t
         VQ+RP3j7pIPgNhXRqQcPipwk9qBRBb4zg36S6/UYcyvnanroW0xQLttlljQrjw4NLFs9
         X+fJtBnoufhdvz8NmosrC659dg25D3lJRv47UFlua9RSVMDlRQhm1kRWUGPF7Q8Ljyqy
         GqgA==
X-Gm-Message-State: ACgBeo3q9HvnaefwCReuwWczQhlFUn3t7SA99PlrZUMvFT1ELZK37yva
        IKrsKONA9gyZrnq5/+5tiFE=
X-Google-Smtp-Source: AA6agR7iIstenSIVzqPRm91CXrgAFC5OzE2haezdyWa1MRmbRFznZs+R7yo6gnPmDP2SRl48i3jbAw==
X-Received: by 2002:adf:d1c2:0:b0:22a:66ad:2669 with SMTP id b2-20020adfd1c2000000b0022a66ad2669mr4996100wrd.468.1662999312594;
        Mon, 12 Sep 2022 09:15:12 -0700 (PDT)
Received: from jernej-laptop.localnet ([89.101.193.71])
        by smtp.gmail.com with ESMTPSA id bo23-20020a056000069700b0022a3517d3besm8549700wrb.5.2022.09.12.09.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 09:15:12 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mikhail Rudenko <mike.rudenko@gmail.com>
Cc:     Mikhail Rudenko <mike.rudenko@gmail.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: sunxi: sun4i-codec: set debugfs_prefix for CPU DAI component
Date:   Mon, 12 Sep 2022 18:15:11 +0200
Message-ID: <4766008.31r3eYUQgx@jernej-laptop>
In-Reply-To: <20220911145713.55199-2-mike.rudenko@gmail.com>
References: <20220911145713.55199-1-mike.rudenko@gmail.com> <20220911145713.55199-2-mike.rudenko@gmail.com>
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

Dne nedelja, 11. september 2022 ob 16:57:12 CEST je Mikhail Rudenko 
napisal(a):
> At present, succesfull probing of H3 Codec results in an error
> 
>     debugfs: Directory '1c22c00.codec' with parent 'H3 Audio Codec' already
> present!
> 
> This is caused by a directory name conflict between codec
> components. Fix it by setting debugfs_prefix for the CPU DAI
> component.
> 
> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  sound/soc/sunxi/sun4i-codec.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
> index 01b461c64d68..4d118f271e8c 100644
> --- a/sound/soc/sunxi/sun4i-codec.c
> +++ b/sound/soc/sunxi/sun4i-codec.c
> @@ -1253,6 +1253,7 @@ static const struct snd_soc_component_driver
> sun8i_a23_codec_codec = {
> 
>  static const struct snd_soc_component_driver sun4i_codec_component = {
>  	.name = "sun4i-codec",
> +	.debugfs_prefix = "dai",
>  };
> 
>  #define SUN4I_CODEC_RATES	SNDRV_PCM_RATE_CONTINUOUS




