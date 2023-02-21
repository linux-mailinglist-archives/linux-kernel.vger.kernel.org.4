Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB7169E85C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 20:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjBUTc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 14:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBUTcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 14:32:52 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A921BE5;
        Tue, 21 Feb 2023 11:32:50 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id o4so5630557wrs.4;
        Tue, 21 Feb 2023 11:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z1BKzb50vau0QIAXVcTGeHLKNWSnhlGapYli6cdXKzI=;
        b=VQjwqdLmqVCn6kaX2voaXpTvFU81kOgGm15ZqXT792b1eaYJMq0twiAJWUS6oW0cBp
         YrYwSGCjB8a4Pe0m5cXLvsl1WnefnzR2dnUQTg2UhL92ELk4rhWo87Sr0fJIquTrkpcP
         T3ZCTmD2A5hEL1h7/r1yg6aPaZ4D9M0FpyLoEvRbxDcPoMZqrZXn5MNDHElDNgpTLaMH
         lus4Un6rqzqA4naeAHeXdcUolbrqYAtaoGAhPLr03xH5QjnlmeNXSyYBezeeuWXvCsr8
         QsomYq+PX3UznzPmv/BOnxbQw9oHXGTQNiNLUdC11gouh+zuHeK94PtpUEIXCWSgf8IS
         NoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1BKzb50vau0QIAXVcTGeHLKNWSnhlGapYli6cdXKzI=;
        b=xxWVUweKjVPocgTrwqqb5Cw7SjmhrSiNmY5pPV7ntpesdTtM/44f6XkEJ7vtkpB1NH
         kKK4dfBr4Rwu/kcO5vLAQSm3J6QX8zBHi/+AokijlZNgW4F6J33biQ1+SZn65m40VECH
         TULovgpFq+aLfKn9xY2XPyMYI1V8Bg4F1yFwRpWzGrtP4YyYQTs4gpn+4vwyPeYGNiju
         8VslUkUnE18qveBvdGEfmJdpKzQ7IolKtgabuLfI6EiBbsEtnQDQPkAyDowJgz/uvg70
         fN3UJiP8Aq/svQv8xjBLHebzbBYfXhihwqkL5Ge5F3lTd2dH6dulHDhFGLpuUkv2wev0
         hHkA==
X-Gm-Message-State: AO0yUKUxGsQj5E24yWGCXsEZAPblZ8FPJSZkT3meq+WAiAvV5OZcvjJ7
        q+U9k2DWSQYXkMbZOwHLua8=
X-Google-Smtp-Source: AK7set81qqkpf6ljR3tBGipC+kP/rYvPLJGM4XwsvqdTfos+aVHiNmd2lGCE1Z2uiPE+maz3/n5NEw==
X-Received: by 2002:a5d:4a86:0:b0:2c5:6cfe:aab4 with SMTP id o6-20020a5d4a86000000b002c56cfeaab4mr4773550wrq.12.1677007968809;
        Tue, 21 Feb 2023 11:32:48 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600001cd00b002c6d0462163sm4106685wrx.100.2023.02.21.11.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 11:32:48 -0800 (PST)
Date:   Tue, 21 Feb 2023 22:32:44 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v1 04/10] ASoC: tegra: Support RT5631 by machine driver
Message-ID: <Y/UcXNueAmrrhWG0@kadam>
References: <20230221183211.21964-1-clamor95@gmail.com>
 <20230221183211.21964-5-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221183211.21964-5-clamor95@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 08:32:05PM +0200, Svyatoslav Ryhel wrote:
> diff --git a/sound/soc/tegra/tegra_asoc_machine.c b/sound/soc/tegra/tegra_asoc_machine.c
> index 78faa8bcae27..607800ec07a6 100644
> --- a/sound/soc/tegra/tegra_asoc_machine.c
> +++ b/sound/soc/tegra/tegra_asoc_machine.c
> @@ -51,6 +51,17 @@ static struct snd_soc_jack_gpio tegra_machine_headset_jack_gpio = {
>  };
>  
>  /* Mic Jack */

This comment doesn't make sense now.  It was never super useful, though.
Just delete it.

> +static int headset_check(void *data)
> +{
> +	struct tegra_machine *machine = (struct tegra_machine *)data;
> +
> +	/* Detect mic insertion only if 3.5 jack is in */
> +	if (gpiod_get_value_cansleep(machine->gpiod_hp_det) &&
> +	    gpiod_get_value_cansleep(machine->gpiod_mic_det))
> +		return SND_JACK_MICROPHONE;
> +
> +	return 0;
> +}
>  
>  static struct snd_soc_jack tegra_machine_mic_jack;
>  
> @@ -183,8 +194,15 @@ int tegra_asoc_machine_init(struct snd_soc_pcm_runtime *rtd)

regards,
dan carpenter
