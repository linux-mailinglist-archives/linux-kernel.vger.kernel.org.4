Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B79673E4E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjASQMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjASQM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:12:29 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD4C526D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:12:24 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id m18-20020a05683026d200b0068661404380so1482913otu.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ix0HYju2644lJeEFjn0uwm9YLx3O/+NSlZGnG+d6HAI=;
        b=J80F8KTkDzqm+ERJgwDg2VP8YqIf0xf2GTLAIjbhbBP7vFDIT5pJJC4tLhIkwflqeO
         JoSsfNUGTzH8Se2d8d0yFlcwavRc5nqdqiH/Tys3gKk+4KJp32Y+u7xRp8zQkeOqYVCM
         0gEluAdrique81bzfZ3hab82l2kbV+MvARzknCNLy2PG44P86yzIJT5d45aDoXAzmbG/
         GbQRZbANaFLUFUEUDZ51LtVHSlE2O85k6wlX4Br7T6edq+AcmxyNRlNdg+B+MbT8HH2F
         /Y24pJv4B4ANoyIpJQHest8buU1OKZajlWzcjzNN36iklc8+WOUAdAVDRDIJuOAjAoXB
         x0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ix0HYju2644lJeEFjn0uwm9YLx3O/+NSlZGnG+d6HAI=;
        b=Mt4RVDmvbnfwWEUkJTw7o6uJ9uCRWPvLBFnxxIYnFrA129qvXwFruVfing0HYtPWTk
         qSqKdi9CTQIT4iwMZSAXi7kDMUMxrVvg7+tF5zXTapvoFkqnu/PMq1bfA00/63JH9FxG
         mCTPI8dIfI7BndEqC3Oaqg6thYIQvg1v3u7bJ48fX1xu/pAi4TX9ze+8146D91o9s9kq
         EZfDdiybCC7Y0X0Py/ghvk+cxpNS0VT5TwctfR8/8HN5nwCwnAN/40utf5xzeAsNgPBd
         zvdM9nr3rWx6vDXgr/ar4bKkTplf6AJGYb+NHx3/0iz8cIRGExEgRHso468wJmnLpe5c
         R9lw==
X-Gm-Message-State: AFqh2kpbyNVrEr9mKdSamPVWjiee41Avffdfhj8OclzSZNOmmgRM2t8Q
        JDu+wluSbRuy84CIXLGeDk8=
X-Google-Smtp-Source: AMrXdXvBCxTcVurfiTvWquGMP3Q6SipQnVDQvr34r79lPOxYpgvH8yAJg0rKi3OAm0MHfCIGMs1dXQ==
X-Received: by 2002:a9d:7849:0:b0:670:a19c:211f with SMTP id c9-20020a9d7849000000b00670a19c211fmr5980826otm.2.1674144743497;
        Thu, 19 Jan 2023 08:12:23 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t11-20020a9d590b000000b00677714a440fsm19978688oth.81.2023.01.19.08.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 08:12:22 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 19 Jan 2023 08:12:21 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     David Rau <david.rau.zg@renesas.com>
Cc:     David Rau <we730128@gmail.com>, "perex@perex.cz" <perex@perex.cz>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "support.opensource@diasemi.com" <support.opensource@diasemi.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: da7219: Fix pole orientation detection on OMTP
 headsets when playing music
Message-ID: <20230119161221.GA981953@roeck-us.net>
References: <20221121050744.2278-1-david.rau.zg@renesas.com>
 <20230117195645.GA83401@roeck-us.net>
 <OS3PR01MB66416CEF9F6E5AE62D194BACCDC49@OS3PR01MB6641.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS3PR01MB66416CEF9F6E5AE62D194BACCDC49@OS3PR01MB6641.jpnprd01.prod.outlook.com>
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

On Thu, Jan 19, 2023 at 11:02:25AM +0000, David Rau wrote:
> Would you please provide me the related error messages when hung task crashes in da7219_aad_irq_thread()?
> BTW, "gnd_switch_delay = 256" is an unusual use case of the longer jack detection latency. 
> 

Here is a typical traceback.

<3>[ 246.919057] INFO: task irq/105-da7219-:2854 blocked for more than 122 seconds.
<3>[ 246.919065] Not tainted 5.10.159-20927-g317f62e2494d #1
<3>[ 246.919068] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
<6>[ $PHONE_NUMBER] task:irq/105-da7219- state:D stack: 0 pid: 2854 ppid: 2 flags:0x00004080
<6>[ 246.919075] Call Trace:
<6>[ 246.919084] __schedule+0x3b0/0xdaf
<6>[ 246.919090] schedule+0x44/0xa8
<6>[ 246.919093] schedule_timeout+0xb6/0x290
<6>[ 246.919098] ? run_local_timers+0x4e/0x4e
<6>[ 246.919102] msleep+0x2c/0x38
<6>[ 246.919108] da7219_aad_irq_thread+0x66/0x2b0 [snd_soc_da7219 cd5a76eef6e777074216b9d61f7918f7561bf7ec]
<6>[ 246.919113] ? irq_forced_thread_fn+0x5f/0x5f
<6>[ 246.919116] irq_thread_fn+0x22/0x4d
<6>[ 246.919120] irq_thread+0x120/0x19d
<6>[ 246.919123] ? irq_thread_fn+0x4d/0x4d
<6>[ 246.919128] kthread+0x142/0x153
<6>[ 246.919132] ? irq_forced_secondary_handler+0x21/0x21
<6>[ 246.919135] ? kthread_blkcg+0x31/0x31
<6>[ 246.919139] ret_from_fork+0x1f/0x30

The underlying question is if it really appropriate to have an
msleep() of any kind in an interrupt handler. If this is about
debouncing a signal, it should be handled with a delayed timer.

Guenter

> -----Original Message-----
> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> Sent: Wednesday, January 18, 2023 03:57
> To: David Rau <we730128@gmail.com>
> Cc: perex@perex.cz; lgirdwood@gmail.com; broonie@kernel.org; tiwai@suse.com; support.opensource@diasemi.com; alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org; David Rau <david.rau.zg@renesas.com>
> Subject: Re: [PATCH] ASoC: da7219: Fix pole orientation detection on OMTP headsets when playing music
> 
> On Mon, Nov 21, 2022 at 05:07:44AM +0000, David Rau wrote:
> > The OMTP pin define headsets can be mis-detected as line out instead 
> > of OMTP, causing obvious issues with audio quality.
> > This patch is to put increased resistances within the device at a 
> > suitable point.
> > 
> > To solve this issue better, the new mechanism setup ground switches 
> > with conditional delay control and these allow for more stabile 
> > detection process to operate as intended. This conditional delay 
> > control will not impact the hardware process but use extra system 
> > resource.
> > 
> > This commit improves control of ground switches in the AAD logic.
> > 
> > Signed-off-by: David Rau <david.rau.zg@renesas.com>
> > ---
> >  sound/soc/codecs/da7219-aad.c | 42 
> > ++++++++++++++++++++++++++++++-----
> >  sound/soc/codecs/da7219-aad.h |  1 +
> >  2 files changed, 37 insertions(+), 6 deletions(-)
> > 
> > diff --git a/sound/soc/codecs/da7219-aad.c 
> > b/sound/soc/codecs/da7219-aad.c index bba73c44c219..08200ec259f9 
> > 100644
> > --- a/sound/soc/codecs/da7219-aad.c
> > +++ b/sound/soc/codecs/da7219-aad.c
> > @@ -352,9 +352,14 @@ static irqreturn_t da7219_aad_irq_thread(int irq, void *data)
> >  	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
> >  	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
> >  	u8 events[DA7219_AAD_IRQ_REG_MAX];
> > -	u8 statusa;
> > +	u8 statusa, srm_st;
> >  	int i, report = 0, mask = 0;
> >  
> > +	srm_st = snd_soc_component_read(component, DA7219_PLL_SRM_STS) & DA7219_PLL_SRM_STS_MCLK;
> > +	msleep(da7219_aad->gnd_switch_delay * ((srm_st == 0x0) ? 2 : 1) - 
> > +4);
> 
> Ever since this patch was applied to ChromeOS, we have observed hung task crashes in da7219_aad_irq_thread().
> 
> Is it really appropriate to sleep up to (256 * 2) - 4 = 508 ms in an interrupt handler ?
> 
> Thanks,
> Guenter
> 
> > +	/* Enable ground switch */
> > +	snd_soc_component_update_bits(component, 0xFB, 0x01, 0x01);
> > +
> >  	/* Read current IRQ events */
> >  	regmap_bulk_read(da7219->regmap, DA7219_ACCDET_IRQ_EVENT_A,
> >  			 events, DA7219_AAD_IRQ_REG_MAX);
> > @@ -454,8 +459,8 @@ static irqreturn_t da7219_aad_irq_thread(int irq, void *data)
> >  			snd_soc_dapm_disable_pin(dapm, "Mic Bias");
> >  			snd_soc_dapm_sync(dapm);
> >  
> > -			/* Enable ground switch */
> > -			snd_soc_component_update_bits(component, 0xFB, 0x01, 0x01);
> > +			/* Disable ground switch */
> > +			snd_soc_component_update_bits(component, 0xFB, 0x01, 0x00);
> >  		}
> >  	}
> >  
> > @@ -831,6 +836,32 @@ static void da7219_aad_handle_pdata(struct snd_soc_component *component)
> >  	}
> >  }
> >  
> > +static void da7219_aad_handle_gnd_switch_time(struct 
> > +snd_soc_component *component) {
> > +	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
> > +	struct da7219_aad_priv *da7219_aad = da7219->aad;
> > +	u8 jack_det;
> > +
> > +	jack_det = snd_soc_component_read(component, DA7219_ACCDET_CONFIG_2)
> > +		& DA7219_JACK_DETECT_RATE_MASK;
> > +	switch (jack_det) {
> > +	case 0x00:
> > +		da7219_aad->gnd_switch_delay = 32;
> > +		break;
> > +	case 0x10:
> > +		da7219_aad->gnd_switch_delay = 64;
> > +		break;
> > +	case 0x20:
> > +		da7219_aad->gnd_switch_delay = 128;
> > +		break;
> > +	case 0x30:
> > +		da7219_aad->gnd_switch_delay = 256;
> > +		break;
> > +	default:
> > +		da7219_aad->gnd_switch_delay = 32;
> > +		break;
> > +	}
> > +}
> >  
> >  /*
> >   * Suspend/Resume
> > @@ -908,9 +939,6 @@ int da7219_aad_init(struct snd_soc_component *component)
> >  	snd_soc_component_update_bits(component, DA7219_ACCDET_CONFIG_1,
> >  			    DA7219_BUTTON_CONFIG_MASK, 0);
> >  
> > -	/* Enable ground switch */
> > -	snd_soc_component_update_bits(component, 0xFB, 0x01, 0x01);
> > -
> >  	INIT_WORK(&da7219_aad->btn_det_work, da7219_aad_btn_det_work);
> >  	INIT_WORK(&da7219_aad->hptest_work, da7219_aad_hptest_work);
> >  
> > @@ -928,6 +956,8 @@ int da7219_aad_init(struct snd_soc_component *component)
> >  	regmap_bulk_write(da7219->regmap, DA7219_ACCDET_IRQ_MASK_A,
> >  			  &mask, DA7219_AAD_IRQ_REG_MAX);
> >  
> > +	da7219_aad_handle_gnd_switch_time(component);
> > +
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(da7219_aad_init);
> > diff --git a/sound/soc/codecs/da7219-aad.h 
> > b/sound/soc/codecs/da7219-aad.h index f48a12012ef3..21fdf53095cc 
> > 100644
> > --- a/sound/soc/codecs/da7219-aad.h
> > +++ b/sound/soc/codecs/da7219-aad.h
> > @@ -187,6 +187,7 @@ enum da7219_aad_event_regs {  struct 
> > da7219_aad_priv {
> >  	struct snd_soc_component *component;
> >  	int irq;
> > +	int gnd_switch_delay;
> >  
> >  	u8 micbias_pulse_lvl;
> >  	u32 micbias_pulse_time;
> > --
> > 2.17.1
> > 
