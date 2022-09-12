Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7C45B5DEE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 18:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiILQOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 12:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiILQOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 12:14:49 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D106647D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 09:14:47 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so7524554wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 09:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=p2UuUVGgNeM7cWoN9co4RiFexO2JQRrTt6fDZRT2l6Q=;
        b=WjrnQt4bUeUHZEbDpxtLxWOhdOwi5lTqQ099s2SU4zwqBVZeCaJ99AWi+Lje4bC1nB
         O3tzwj3cB/y8uJIrxyAMmpAZZiZE1oAoe+CmU6tvH6uuu7kRH4qjFLTPX3X+w5dUwOFX
         o8co/TSCDVVOqEY+F9a2elNlGE789+JRJGg/2swqnsMphCm5dTxSs6un8KvwqrN4el9C
         w0tyhgDMmpoZdlDcn3+rt2sQ0+UJNLN3YSXLC/LCoofMNzJoj+5eLDxrmnRvgtE8+/mt
         XEj06YGEsdvvuzfqdQzL+utyOMeqWfZy+0ykcJCPkT0Rne+IksX8EnxcGIR/uJ517dRo
         zh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=p2UuUVGgNeM7cWoN9co4RiFexO2JQRrTt6fDZRT2l6Q=;
        b=BMBGgwmlNmJXo3S8k2zPPj0JxqEhWbfphpQkWVWj3fdz1HzJOgUYlJq8PjTL3Eb49A
         esV0MyOtIBU4sVWPd54R+lkRyLbJ5fI5gx3VKb9R2TlMrif+PYMNz93HGddA3FTLDGIr
         z8Vlqro0M952vNYgc4x+iFiCngOEx8zDtjx+8s1/8ZJtqi9kBXxeL8KDR3yovu/wTRkw
         /fRusihGD1tW6ZwxFk9FV8jNEvJk1wp6nwj5fQ5TUXQmS91dMaEHq5YUcDVjPZiyTKRp
         RJ5ccs4+HDi9UNzRbkYdgwOwSMWVi9owdC9WxnZTtJY1rOI5qrWfTRGnTuKOChgV76dJ
         bKUw==
X-Gm-Message-State: ACgBeo2Mvv98CPJtz7rGM0rsMBlIZn9NVZBBnpLDjD8psRKnAz04yY6e
        OACGTH8Mn26AHwVh76Q3T0bEJukksdNUxCwx
X-Google-Smtp-Source: AA6agR6TxM9HREIppAFy4INv7lrvGZZIc1xY0Z0z6Wz7xBGrYJrUQHdC7xeeaLg8OPCnLJ3WpI/YYw==
X-Received: by 2002:a05:600c:1c1f:b0:3b4:8330:5a46 with SMTP id j31-20020a05600c1c1f00b003b483305a46mr5102190wms.45.1662999285997;
        Mon, 12 Sep 2022 09:14:45 -0700 (PDT)
Received: from jernej-laptop.localnet ([89.101.193.71])
        by smtp.gmail.com with ESMTPSA id a6-20020a5d4d46000000b00228aea99efcsm7717117wru.14.2022.09.12.09.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 09:14:45 -0700 (PDT)
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
Subject: Re: [PATCH 1/2] ASoC: sunxi: sun4i-codec: silence misleading error in probe
Date:   Mon, 12 Sep 2022 18:14:44 +0200
Message-ID: <5600291.DvuYhMxLoT@jernej-laptop>
In-Reply-To: <20220911145713.55199-1-mike.rudenko@gmail.com>
References: <20220911145713.55199-1-mike.rudenko@gmail.com>
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

Dne nedelja, 11. september 2022 ob 16:57:11 CEST je Mikhail Rudenko 
napisal(a):
> In the case when a codec device is probed before codec analog
> controls, snd_soc_register_card() returns -EPROBE_DEFER, resulting in
> a misleading error message
> 
>     sun4i-codec 1c22c00.codec: Failed to register our card
> 
> even if the device is probed successfully later. Use dev_err_probe()
> to demote the above error to a debug message.
> 
> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  sound/soc/sunxi/sun4i-codec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
> index 60712f24ade5..01b461c64d68 100644
> --- a/sound/soc/sunxi/sun4i-codec.c
> +++ b/sound/soc/sunxi/sun4i-codec.c
> @@ -1825,7 +1825,7 @@ static int sun4i_codec_probe(struct platform_device
> *pdev)
> 
>  	ret = snd_soc_register_card(card);
>  	if (ret) {
> -		dev_err(&pdev->dev, "Failed to register our card\n");
> +		dev_err_probe(&pdev->dev, ret, "Failed to register our 
card\n");
>  		goto err_assert_reset;
>  	}




