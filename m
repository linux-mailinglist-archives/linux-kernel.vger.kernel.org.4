Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80156C9EA7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 10:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbjC0Iyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 04:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjC0Ixy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:53:54 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BF361A8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:49:22 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so6785361wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1679906960;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=UDSqP7fpfKlKQVx/rVKsTS5+4DHlxYXGctzY/lz+9Ho=;
        b=5UJ/GXirQ7wgMEFINuifffVu8CODx5qLiO9QZwxXCtKEKM+75oZAu25XvAjTf3Mukd
         lVDHLQTo0AOOQcN5NlWIUSvcKvN32YA5hJUWuvNjyFXAByF1uiR2VcvlikFKLYKEBmOn
         eDx+RS9fSjaPFpSvMY1eVdj5AlrPgGKU31/9RH/tg2j1jU4AbH43wXOmYH7I2SbnW74s
         7py0fyyDHwvalOsnobnGpmz4MyKAxZWgrhDqMGcGyEgoifsfAdrikkoSAaPvNKx7TImx
         qNZcc3t1JrP9dMg1sXC70lpblPv+C9p97e4IDNGsXPmZvdqFu1e0O8EuVXhAqEIk+Pst
         rXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679906960;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDSqP7fpfKlKQVx/rVKsTS5+4DHlxYXGctzY/lz+9Ho=;
        b=XZ0m7284h8ikr4EcJYu0inSrqiI6RNaSdhBr7TOeCbBqJ1VK1+mYyaEaZ4yWbPpVzY
         g/mI68HSIEIsmmNEWSbZ7mCSOSApEf1KVSyxZV4m1Pkuau38V7Z3SCbS/ojoNAJGdUTj
         DndRWr+7DXxDYg6Mv1KwmRT9A69R1Bw20qe2WO2nzEfDPT1dc5PBK0JNCoE+0fiqsMQV
         GWsC7QofMpokjwhmBamisfh5TLohGojTvvq35AV6NOpppue1qk75ykbiWmy0UDyS0aCR
         JjEp0gWTmLlyKfIaEeCbl/JzcxhLNg39+WnyVB9DuBXQYpAa8wWHg93dY4fg3gUQ0qYA
         e5GQ==
X-Gm-Message-State: AAQBX9dVH9NcSeCAQpih4oOP60UEuy2uP4juu+Zqc4+rGFilNybwBVGS
        OiZQVVHpZ6FWunkA3wgIKT0ZrCUnCdTBUnFRmhU=
X-Google-Smtp-Source: AKy350a1+/eDpxejUWxQfz4ZUV5XMrdV2fNL9j9I2+FCSXACd1jk3wa03RjMGPX4FF4onxWuoaOJcA==
X-Received: by 2002:a7b:c852:0:b0:3ef:64b4:b081 with SMTP id c18-20020a7bc852000000b003ef64b4b081mr4840082wml.39.1679906960535;
        Mon, 27 Mar 2023 01:49:20 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c444900b003ef5deb4188sm8001026wmn.17.2023.03.27.01.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 01:49:20 -0700 (PDT)
References: <8dab942d6ce47657a9c038295959be80bb2ee09e.1679834598.git.christophe.jaillet@wanadoo.fr>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH] ASoC: meson: Use the devm_clk_get_optional() helper
Date:   Mon, 27 Mar 2023 10:45:44 +0200
In-reply-to: <8dab942d6ce47657a9c038295959be80bb2ee09e.1679834598.git.christophe.jaillet@wanadoo.fr>
Message-ID: <1jy1nio9yo.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun 26 Mar 2023 at 14:43, Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Use devm_clk_get_optional() instead of hand writing it.
> This saves some loC and improves the semantic.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Thx.

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>


> ---
>  sound/soc/meson/axg-tdm-interface.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/sound/soc/meson/axg-tdm-interface.c b/sound/soc/meson/axg-tdm-interface.c
> index 7624aafe9009..5e5e4c56d505 100644
> --- a/sound/soc/meson/axg-tdm-interface.c
> +++ b/sound/soc/meson/axg-tdm-interface.c
> @@ -496,7 +496,7 @@ static int axg_tdm_iface_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct snd_soc_dai_driver *dai_drv;
>  	struct axg_tdm_iface *iface;
> -	int ret, i;
> +	int i;
>  
>  	iface = devm_kzalloc(dev, sizeof(*iface), GFP_KERNEL);
>  	if (!iface)
> @@ -533,14 +533,9 @@ static int axg_tdm_iface_probe(struct platform_device *pdev)
>  	 * At this point, ignore the error if mclk is missing. We'll
>  	 * throw an error if the cpu dai is master and mclk is missing
>  	 */
> -	iface->mclk = devm_clk_get(dev, "mclk");
> -	if (IS_ERR(iface->mclk)) {
> -		ret = PTR_ERR(iface->mclk);
> -		if (ret == -ENOENT)
> -			iface->mclk = NULL;
> -		else
> -			return dev_err_probe(dev, ret, "failed to get mclk\n");
> -	}
> +	iface->mclk = devm_clk_get_optional(dev, "mclk");
> +	if (IS_ERR(iface->mclk))
> +		return dev_err_probe(dev, PTR_ERR(iface->mclk), "failed to get mclk\n");
>  
>  	return devm_snd_soc_register_component(dev,
>  					&axg_tdm_iface_component_drv, dai_drv,

