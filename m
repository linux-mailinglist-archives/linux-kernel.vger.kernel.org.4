Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD8166E87C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 22:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjAQVdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 16:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjAQVbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:31:31 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9E53B0E3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:56:47 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id r205so26863581oib.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1r34vlVPPJlCz7kXUzuG7RWl/bEcAwSTX4qTwdtJXkQ=;
        b=ivW/sZY7Q/afkdOIX8rvPKtg5EqA6DG9Vu6HPUQ2BNU2t9Pz+/WtVU/C9c7gKMBjC5
         DXny994r2jSYMe3xKbLqM8f5N2z/UVaQWB3nhkR5iK7yrruVbpx/j2ef93v6Ja85VVCT
         0eFLotMxxgbn/AKqQh1rSO615qmXz9cTSKhlvuvs3LBK0QtDJCzsNFgjmkFpy8NfM/Rw
         Xl8M6BtNZKrJIwO19qPQWuVTmbo30ewnMhWdMgJ4LKGUgIhIyaCu08Ojq4KffqNv7JrF
         Solh7BTM34EQcwlGkGUle+l0OLOCXr4TldUd5bJpXkOF8zlBMtNOwPRUT9Tp5d0w5Ydx
         MaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1r34vlVPPJlCz7kXUzuG7RWl/bEcAwSTX4qTwdtJXkQ=;
        b=lhbWqpfBlJYUO/7eqp76It3F6+OxV0/1vzao/gvt3gnICbn6mZf01laQhfwvEeIdr0
         4PL7nbzMZ8h3i4aI4ip2rvRKR5jU8az3PA7A2jTgpgLU36BDDfBk/l0n1GZhxnefEtI4
         ZpXnI2u51ZHD8ANIqEhcR9uOf867E9cEFMHicu93lcyYnEGAAdKVdMCzqCwfB8B8VR2/
         lSt8lLeAU5Y3ypIEd0HKbe2Hc8EB6+wipGUqP5NM4skuNTPT2m4ONstrNftwx2XQk5Z1
         NJhQfUcAfTdTIe/vABVCSSCR7xVFtfqwZ9hyvsD49kSh+xVNwKnlwz+OWwA5Q8h4kOxs
         dN6A==
X-Gm-Message-State: AFqh2koqenycvrhs2167rsDvZN84iAmP+KEplAJGrqfZhuxqs5NMeTx/
        pnPKHrARsOp2WWuJp9mhJHI=
X-Google-Smtp-Source: AMrXdXvDrCpT81inVb5UT2EG0soUWxCONCUFF77+pkM8Z6dsHYb/v737stXS8+JP1Ncl4OLkpaQvPg==
X-Received: by 2002:a54:438d:0:b0:360:e1dc:8b18 with SMTP id u13-20020a54438d000000b00360e1dc8b18mr1834727oiv.20.1673985407138;
        Tue, 17 Jan 2023 11:56:47 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id db11-20020a0568306b0b00b006391adb6034sm17032016otb.72.2023.01.17.11.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 11:56:46 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 17 Jan 2023 11:56:45 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     David Rau <we730128@gmail.com>
Cc:     perex@perex.cz, lgirdwood@gmail.com, broonie@kernel.org,
        tiwai@suse.com, support.opensource@diasemi.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        David Rau <david.rau.zg@renesas.com>
Subject: Re: [PATCH] ASoC: da7219: Fix pole orientation detection on OMTP
 headsets when playing music
Message-ID: <20230117195645.GA83401@roeck-us.net>
References: <20221121050744.2278-1-david.rau.zg@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121050744.2278-1-david.rau.zg@renesas.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 05:07:44AM +0000, David Rau wrote:
> The OMTP pin define headsets can be mis-detected as line out
> instead of OMTP, causing obvious issues with audio quality.
> This patch is to put increased resistances within
> the device at a suitable point.
> 
> To solve this issue better, the new mechanism setup
> ground switches with conditional delay control
> and these allow for more stabile detection process
> to operate as intended. This conditional delay control
> will not impact the hardware process
> but use extra system resource.
> 
> This commit improves control of ground switches in the AAD logic.
> 
> Signed-off-by: David Rau <david.rau.zg@renesas.com>
> ---
>  sound/soc/codecs/da7219-aad.c | 42 ++++++++++++++++++++++++++++++-----
>  sound/soc/codecs/da7219-aad.h |  1 +
>  2 files changed, 37 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
> index bba73c44c219..08200ec259f9 100644
> --- a/sound/soc/codecs/da7219-aad.c
> +++ b/sound/soc/codecs/da7219-aad.c
> @@ -352,9 +352,14 @@ static irqreturn_t da7219_aad_irq_thread(int irq, void *data)
>  	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
>  	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
>  	u8 events[DA7219_AAD_IRQ_REG_MAX];
> -	u8 statusa;
> +	u8 statusa, srm_st;
>  	int i, report = 0, mask = 0;
>  
> +	srm_st = snd_soc_component_read(component, DA7219_PLL_SRM_STS) & DA7219_PLL_SRM_STS_MCLK;
> +	msleep(da7219_aad->gnd_switch_delay * ((srm_st == 0x0) ? 2 : 1) - 4);

Ever since this patch was applied to ChromeOS, we have observed hung
task crashes in da7219_aad_irq_thread().

Is it really appropriate to sleep up to (256 * 2) - 4 = 508 ms in
an interrupt handler ?

Thanks,
Guenter

> +	/* Enable ground switch */
> +	snd_soc_component_update_bits(component, 0xFB, 0x01, 0x01);
> +
>  	/* Read current IRQ events */
>  	regmap_bulk_read(da7219->regmap, DA7219_ACCDET_IRQ_EVENT_A,
>  			 events, DA7219_AAD_IRQ_REG_MAX);
> @@ -454,8 +459,8 @@ static irqreturn_t da7219_aad_irq_thread(int irq, void *data)
>  			snd_soc_dapm_disable_pin(dapm, "Mic Bias");
>  			snd_soc_dapm_sync(dapm);
>  
> -			/* Enable ground switch */
> -			snd_soc_component_update_bits(component, 0xFB, 0x01, 0x01);
> +			/* Disable ground switch */
> +			snd_soc_component_update_bits(component, 0xFB, 0x01, 0x00);
>  		}
>  	}
>  
> @@ -831,6 +836,32 @@ static void da7219_aad_handle_pdata(struct snd_soc_component *component)
>  	}
>  }
>  
> +static void da7219_aad_handle_gnd_switch_time(struct snd_soc_component *component)
> +{
> +	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
> +	struct da7219_aad_priv *da7219_aad = da7219->aad;
> +	u8 jack_det;
> +
> +	jack_det = snd_soc_component_read(component, DA7219_ACCDET_CONFIG_2)
> +		& DA7219_JACK_DETECT_RATE_MASK;
> +	switch (jack_det) {
> +	case 0x00:
> +		da7219_aad->gnd_switch_delay = 32;
> +		break;
> +	case 0x10:
> +		da7219_aad->gnd_switch_delay = 64;
> +		break;
> +	case 0x20:
> +		da7219_aad->gnd_switch_delay = 128;
> +		break;
> +	case 0x30:
> +		da7219_aad->gnd_switch_delay = 256;
> +		break;
> +	default:
> +		da7219_aad->gnd_switch_delay = 32;
> +		break;
> +	}
> +}
>  
>  /*
>   * Suspend/Resume
> @@ -908,9 +939,6 @@ int da7219_aad_init(struct snd_soc_component *component)
>  	snd_soc_component_update_bits(component, DA7219_ACCDET_CONFIG_1,
>  			    DA7219_BUTTON_CONFIG_MASK, 0);
>  
> -	/* Enable ground switch */
> -	snd_soc_component_update_bits(component, 0xFB, 0x01, 0x01);
> -
>  	INIT_WORK(&da7219_aad->btn_det_work, da7219_aad_btn_det_work);
>  	INIT_WORK(&da7219_aad->hptest_work, da7219_aad_hptest_work);
>  
> @@ -928,6 +956,8 @@ int da7219_aad_init(struct snd_soc_component *component)
>  	regmap_bulk_write(da7219->regmap, DA7219_ACCDET_IRQ_MASK_A,
>  			  &mask, DA7219_AAD_IRQ_REG_MAX);
>  
> +	da7219_aad_handle_gnd_switch_time(component);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(da7219_aad_init);
> diff --git a/sound/soc/codecs/da7219-aad.h b/sound/soc/codecs/da7219-aad.h
> index f48a12012ef3..21fdf53095cc 100644
> --- a/sound/soc/codecs/da7219-aad.h
> +++ b/sound/soc/codecs/da7219-aad.h
> @@ -187,6 +187,7 @@ enum da7219_aad_event_regs {
>  struct da7219_aad_priv {
>  	struct snd_soc_component *component;
>  	int irq;
> +	int gnd_switch_delay;
>  
>  	u8 micbias_pulse_lvl;
>  	u32 micbias_pulse_time;
> -- 
> 2.17.1
> 
