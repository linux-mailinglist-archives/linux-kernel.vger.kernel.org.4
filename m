Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF978692611
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 20:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbjBJTGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 14:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbjBJTGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 14:06:43 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4B97D3E4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 11:06:41 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id b1so4105740pft.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 11:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0X3/n7/A3PNJZ8jZ8dVcNSR9WNlUKR8kt+0R8RsIS+I=;
        b=j39WWB84ZEJ6nBQwen5FJIoUqsORXqEcNFES8EWG0YtMpZrjHM96f7RjBAPQ+JDsJG
         3u7EWAxijHOfV0E4/AyEt5PIKduwsIm6TL3Zy9dOcsf49sUQaIQSgDmoufdde8n67DOR
         0h2eY3ciTD1yALLQqjrT9sbHgfjkc04QOWVTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0X3/n7/A3PNJZ8jZ8dVcNSR9WNlUKR8kt+0R8RsIS+I=;
        b=bcwngPkijkaYgklDsPJdQz/VktdwQbAMwCg4rySg2RKn8pfVbYXSURS0W+8Ckxbq2V
         +622mtIv/gQ3M6Og8DOJox3PF9bfRGsqHvrvRkRC51LWEISQ7X6kVfDrMS4rgKLCKJ7R
         KgymmnkHtpBZZIYnuzoln4DQjU4tOnBR4oLWzwkCLhuAIiyDmv7eTS9jx2pi+nfGkCBs
         pv63S38aTJRMbaDhdw7VZmyHK/CzTYIj5wOIXR2WV0C6VUARV5vq8/rA0L3IV50qudmg
         SR5PcqWRrs7UPMLoNR9V1SWpJhUjg3VvvCYVGMmPNJRiFPBIlwxOoj+XNXftNCZi/XWV
         JNMg==
X-Gm-Message-State: AO0yUKUz271uN1+0YkvViKOcHeMIMDk3bCk8pRJZwupafbnBZVra2rov
        VZsxxEuzCy2VsmkKUGvhYqpJvQ==
X-Google-Smtp-Source: AK7set/PmQSV8PsNJ5/Q5QKIBZDr28wVDC62O7GllUpJ4GDZE0hTRfK4cvrK8Bht08Iw93IjrZK9Kg==
X-Received: by 2002:a62:1b4d:0:b0:593:ea06:7fd with SMTP id b74-20020a621b4d000000b00593ea0607fdmr14083024pfb.13.1676056001372;
        Fri, 10 Feb 2023 11:06:41 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l22-20020a62be16000000b005943bd7c72bsm3595216pff.190.2023.02.10.11.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 11:06:40 -0800 (PST)
Message-ID: <63e695c0.620a0220.f69b1.6eec@mx.google.com>
X-Google-Original-Message-ID: <202302101104.@keescook>
Date:   Fri, 10 Feb 2023 11:06:40 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Sasa Ostrouska <casaxa@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ASoC: Intel: Skylake: Replace 1-element array with
 flex-array
References: <20230210051447.never.204-kees@kernel.org>
 <54d4ffb1-1488-1a4f-58b2-8b3471389729@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54d4ffb1-1488-1a4f-58b2-8b3471389729@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 02:10:56PM +0100, Amadeusz Sławiński wrote:
> On 2/10/2023 6:14 AM, Kees Cook wrote:
> > The kernel is globally removing the ambiguous 0-length and 1-element
> > arrays in favor of flexible arrays, so that we can gain both compile-time
> > and run-time array bounds checking[1]. In this instance, struct
> > skl_cpr_cfg contains struct skl_cpr_gtw_cfg, which defined "config_data"
> > as a 1-element array.
> > 
> > Normally when switching from a 1-element array to a flex-array, any
> > related size calculations must be adjusted too. However, it seems the
> > original code was over-allocating space, since 1 extra u32 would be
> > included by the sizeof():
> > 
> >                  param_size = sizeof(struct skl_cpr_cfg);
> >                  param_size += mconfig->formats_config[SKL_PARAM_INIT].caps_size;
> > 
> > But the copy uses caps_size bytes, and cap_size / 4 (i.e. sizeof(u32))
> > for the length tracking:
> > 
> >          memcpy(cpr_mconfig->gtw_cfg.config_data,
> >                          mconfig->formats_config[SKL_PARAM_INIT].caps,
> >                          mconfig->formats_config[SKL_PARAM_INIT].caps_size);
> > 
> >          cpr_mconfig->gtw_cfg.config_length =
> >                          (mconfig->formats_config[SKL_PARAM_INIT].caps_size) / 4;
> > 
> > Therefore, no size calculations need adjusting. Change the struct
> > skl_cpr_gtw_cfg config_data member to be a true flexible array, which
> > also fixes the over-allocation, and silences this memcpy run-time false
> > positive:
> > 
> >    memcpy: detected field-spanning write (size 100) of single field "cpr_mconfig->gtw_cfg.config_data" at sound/soc/intel/skylake/skl-messages.c:554 (size 4)
> > 
> > [1] For lots of details, see both:
> >      https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
> >      https://people.kernel.org/kees/bounded-flexible-arrays-in-c
> > 
> > Reported-by: Sasa Ostrouska <casaxa@gmail.com>
> > Link: https://lore.kernel.org/all/CALFERdwvq5day_sbDfiUsMSZCQu9HG8-SBpOZDNPeMdZGog6XA@mail.gmail.com/
> > Cc: Cezary Rojewski <cezary.rojewski@intel.com>
> > Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> > Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> > Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
> > Cc: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> > Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Jaroslav Kysela <perex@perex.cz>
> > Cc: Takashi Iwai <tiwai@suse.com>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: "Amadeusz Sławiński" <amadeuszx.slawinski@linux.intel.com>
> > Cc: alsa-devel@alsa-project.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >   sound/soc/intel/skylake/skl-topology.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
> > index 6db0fd7bad49..ad94f8020c27 100644
> > --- a/sound/soc/intel/skylake/skl-topology.h
> > +++ b/sound/soc/intel/skylake/skl-topology.h
> > @@ -115,7 +115,7 @@ struct skl_cpr_gtw_cfg {
> >   	u32 dma_buffer_size;
> >   	u32 config_length;
> >   	/* not mandatory; required only for DMIC/I2S */
> > -	u32 config_data[1];
> > +	u32 config_data[];
> >   } __packed;
> >   struct skl_dma_control {
> 
> This fails in our validation.

Ah, okay. Thanks for checking!

> Maybe we can use the union workaround, to
> leave the size as is?
> 
> Following seems to work in manual test:
> diff --git a/sound/soc/intel/skylake/skl-topology.h
> b/sound/soc/intel/skylake/skl-topology.h
> index 6db0fd7bad49..ffbd2e60fede 100644
> --- a/sound/soc/intel/skylake/skl-topology.h
> +++ b/sound/soc/intel/skylake/skl-topology.h
> @@ -115,7 +115,10 @@ struct skl_cpr_gtw_cfg {
>         u32 dma_buffer_size;
>         u32 config_length;
>         /* not mandatory; required only for DMIC/I2S */
> -       u32 config_data[1];
> +       union {
> +               u32 x;
> +               u32 config_data[0];
> +       };

Yeah, that could work, though the last member would be:
	DECLARE_FLEX_ARRAY(u32, config_data);
otherwise the array is 0 length (rather than a proper flex array).

But before that, let me see if I can track down where the size is being
used, in case we can avoid adding the padding.

-- 
Kees Cook
