Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1C960CC4C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 14:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbiJYMpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 08:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbiJYMpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:45:34 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF9D18F0DB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 05:43:51 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l14so13394554wrw.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 05:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4bB9DG6I4yQg1VaBFFskr0kCoybfjGK9a489xozqbQ=;
        b=CGWd9EGmlJFK+YEPgI0l2hwe3QK0ZhOT+JHvVsiZC12bo+c4Jl/FAYJrdHvAalOpGt
         tllbwPXcjRHsXQblFv5wBCsA+ty066EcfLUUp3vq6jrgpqnCqf5fS8/J1FkAml46w5yQ
         tGseitrCIP8oromfF0eRIfZdWQWi2HtjVV0Dkq9KDifUwNdXpfMbqoiGOSksX7lTAln9
         bLuFQYXiUwWkd/i6dJqmss6GUSSdrz/4sDW9ZpmRhAlNVYZ+yjvTlyCsYz2IfUoCLaTa
         kjMSP2GYVCuZOnYOe03eK2yd8xVrU4sjiIjmnirDbhaLGlIfyZ2JIE6LdJzGBTV9bPVK
         +Fng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4bB9DG6I4yQg1VaBFFskr0kCoybfjGK9a489xozqbQ=;
        b=qu7p4PsLyy4PHWUbSHpFYyryg+3ZTwqYgc3aAmCrx6yBaVaQrLmbjnjcYS9aPoihUb
         Yl0gf98B7nH1b7R+fKAZR6SYIMtN3Bj/y0tNR1pyW/9091GdgRrwT0+ZzdYjYUl6PyKq
         dLv5ngWN+QNm/Jdt9Q8okhbntfJ+R3lWxGajB7KBOOJs4M3BubXgafsg7icLf7s5+hbb
         9jdTxeRe3814FX3r9lAPQ6NouVDD5TBYqV/A992gWRAdTzWkrQ/XvmQyuMY397jmdf9/
         W5PXfVtKB5WPU03BqL2noRkp/II7g5+5obRX9JEgM2g3iq67qW69wgHhSW6hAia7onq4
         SHkA==
X-Gm-Message-State: ACrzQf2nngEGY/6R03kT9iVrk8kbpnID7MgJnURE0UdIJw61CYZxYaij
        QleNDBOU1WOrOx5I3QfZps4=
X-Google-Smtp-Source: AMsMyM5SL1IRETz58Y983NAHYtT70ugOevrG0yz5LC3UXysNz92AImLC0KI/69prTy1jTOu7poogHw==
X-Received: by 2002:adf:e985:0:b0:236:6a53:3a16 with SMTP id h5-20020adfe985000000b002366a533a16mr8737605wrm.501.1666701827348;
        Tue, 25 Oct 2022 05:43:47 -0700 (PDT)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id bp4-20020a5d5a84000000b0022e57e66824sm3163700wrb.99.2022.10.25.05.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 05:43:46 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] ASoC: rockchip: i2s_tdm: Add support for RK3588
Date:   Tue, 25 Oct 2022 14:43:45 +0200
Message-ID: <3478206.uukdV1xfrs@archbook>
In-Reply-To: <20221025124132.399729-5-frattaroli.nicolas@gmail.com>
References: <20221025124132.399729-1-frattaroli.nicolas@gmail.com> <20221025124132.399729-5-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dienstag, 25. Oktober 2022 14:41:32 CEST Nicolas Frattaroli wrote:
> This adds support for the RK3588 SoC to the I2S/TDM driver.
> ---
>  sound/soc/rockchip/rockchip_i2s_tdm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/rockchip/rockchip_i2s_tdm.c b/sound/soc/rockchip/rockchip_i2s_tdm.c
> index 917f17107891..08b90ec5cc80 100644
> --- a/sound/soc/rockchip/rockchip_i2s_tdm.c
> +++ b/sound/soc/rockchip/rockchip_i2s_tdm.c
> @@ -1318,6 +1318,7 @@ static const struct of_device_id rockchip_i2s_tdm_match[] = {
>  	{ .compatible = "rockchip,rk1808-i2s-tdm", .data = &rk1808_i2s_soc_data },
>  	{ .compatible = "rockchip,rk3308-i2s-tdm", .data = &rk3308_i2s_soc_data },
>  	{ .compatible = "rockchip,rk3568-i2s-tdm", .data = &rk3568_i2s_soc_data },
> +	{ .compatible = "rockchip,rk3588-i2s-tdm" },
>  	{ .compatible = "rockchip,rv1126-i2s-tdm", .data = &rv1126_i2s_soc_data },
>  	{},
>  };
> @@ -1556,7 +1557,7 @@ static int rockchip_i2s_tdm_probe(struct platform_device *pdev)
>  	i2s_tdm->dev = &pdev->dev;
>  
>  	of_id = of_match_device(rockchip_i2s_tdm_match, &pdev->dev);
> -	if (!of_id || !of_id->data)
> +	if (!of_id)
>  		return -EINVAL;
>  
>  	spin_lock_init(&i2s_tdm->lock);
> 
Oops, forgot the signoff on this one.
For this purpose:

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>

My apologies.


