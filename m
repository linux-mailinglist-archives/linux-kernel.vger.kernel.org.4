Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D584468245A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 07:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjAaGQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 01:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjAaGQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 01:16:14 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B9F3B641
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 22:16:11 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id g21-20020a9d6495000000b0068bb336141dso3324069otl.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 22:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=M09wqeeEf+1NphrueST4g9lXQm4nVLxM56ThmXrqNHI=;
        b=BMUZeD9ck6UfwOxp2b73TMtRN3NTo0sh/tQ4TV91CgIbduSde7qvkuTnAdRbO9FP0q
         0M4y67xj2L4iB9tWzhIH/7bkQe3VCl1BUnP1fb7CzTtM9sxl+6E/RnciF1SaoRLTZVxp
         5fi3bKtyduB7wce8dXceh9VSwY8stWdoLMjz++NOjsaiJ7a8mrJrQTS1IoYkqo4TT64H
         XQ7XZ83QXpV2BpnkgoZeu4b9+36uiXVLlu8IAp1qPgXKcyU5UYARype2LgEbj75AfrLC
         finHNBiysPXHfM7CAwQnrhDe7nZvQ0L6HKYlKYMZ8KVPI6crBQDFM4cJp31ThgV1vDKv
         02jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M09wqeeEf+1NphrueST4g9lXQm4nVLxM56ThmXrqNHI=;
        b=5ks8Xc0AmRGWnKRji6jCBSnnhuU1DiKeo91vHNQ9oQuTyC45g3BhYMcVDdvUwtpFBe
         VTAGpJU6epNt/toAJR6ftZEbgDwPcxg+stMI0jg8k37CYc7z2DuYt924z3XdZT0i79XZ
         C6g1tM/awawjUQ03kQZ0HGndwgHBimVJW8LDd+EDZQhLLBhcrWW1itIILc0JNe11JlmU
         BRrhpPaVXfFcLh2itzK9V3/2La9A/JLpQbR9PtmQetifWqKkc71nOs5+IpnqgNfHwCWW
         qcAREJ4uqd2SEDb7h+JVqi/fcqgAzh9ksLuSf1j/+eEsJ6fBplGlPFqZDB1a2GutJUs1
         pAwA==
X-Gm-Message-State: AO0yUKUgoCxR+EYiCmCDhhnDY5RYXokrlkmHBolcbo8ejk6u9qybYgmC
        dAcGGSGzJD66sI9Woz4Ct5ylrV9zA3c=
X-Google-Smtp-Source: AK7set/NkwL4qXnZXcNHXc4TKvH3nQA3SuxlR9sRFsEtllq2K6ZTDloe/d0QG72LOItaYzVzox3oaA==
X-Received: by 2002:a9d:825:0:b0:68b:ba93:6c11 with SMTP id 34-20020a9d0825000000b0068bba936c11mr6730650oty.23.1675145770822;
        Mon, 30 Jan 2023 22:16:10 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w12-20020a4aa98c000000b004a0ad937ccdsm5779570oom.1.2023.01.30.22.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 22:16:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <38f09c4d-70d1-f65f-6e9b-4ad84eda4059@roeck-us.net>
Date:   Mon, 30 Jan 2023 22:16:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] ASoC: da7219: Fix pole orientation detection on OMTP
 headsets when playing music
Content-Language: en-US
To:     David Rau <david.rau.zg@renesas.com>
Cc:     "perex@perex.cz" <perex@perex.cz>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "support.opensource@diasemi.com" <support.opensource@diasemi.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221121050744.2278-1-david.rau.zg@renesas.com>
 <20230117195645.GA83401@roeck-us.net>
 <OS3PR01MB66416CEF9F6E5AE62D194BACCDC49@OS3PR01MB6641.jpnprd01.prod.outlook.com>
 <20230119161221.GA981953@roeck-us.net>
 <OS3PR01MB66416C10BF8E6400C84DAD02CDD09@OS3PR01MB6641.jpnprd01.prod.outlook.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <OS3PR01MB66416C10BF8E6400C84DAD02CDD09@OS3PR01MB6641.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/23 19:58, David Rau wrote:
> Thanks for the kind feedback.
> Would you please let me know what kinds of environment such error appears you ever meet?
> Ex: da7219_aad->gnd_switch_delay = ?
> 

We are seeing the problem on various Chromebooks.

Never mind, though. I really don't have time to keep arguing about this.
I would have assumed that it is obvious that a long msleep() in an
interrupt handler is not appropriate, but obviously I was wrong.
I'll see if I can implement a downstream fix.

Guenter

> 
> -----Original Message-----
> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> Sent: Friday, January 20, 2023 00:12
> To: David Rau <david.rau.zg@renesas.com>
> Cc: David Rau <we730128@gmail.com>; perex@perex.cz; lgirdwood@gmail.com; broonie@kernel.org; tiwai@suse.com; support.opensource@diasemi.com; alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] ASoC: da7219: Fix pole orientation detection on OMTP headsets when playing music
> 
> On Thu, Jan 19, 2023 at 11:02:25AM +0000, David Rau wrote:
>> Would you please provide me the related error messages when hung task crashes in da7219_aad_irq_thread()?
>> BTW, "gnd_switch_delay = 256" is an unusual use case of the longer jack detection latency.
>>
> 
> Here is a typical traceback.
> 
> <3>[ 246.919057] INFO: task irq/105-da7219-:2854 blocked for more than 122 seconds.
> <3>[ 246.919065] Not tainted 5.10.159-20927-g317f62e2494d #1 <3>[ 246.919068] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> <6>[ $PHONE_NUMBER] task:irq/105-da7219- state:D stack: 0 pid: 2854 ppid: 2 flags:0x00004080 <6>[ 246.919075] Call Trace:
> <6>[ 246.919084] __schedule+0x3b0/0xdaf
> <6>[ 246.919090] schedule+0x44/0xa8
> <6>[ 246.919093] schedule_timeout+0xb6/0x290 <6>[ 246.919098] ? run_local_timers+0x4e/0x4e <6>[ 246.919102] msleep+0x2c/0x38 <6>[ 246.919108] da7219_aad_irq_thread+0x66/0x2b0 [snd_soc_da7219 cd5a76eef6e777074216b9d61f7918f7561bf7ec]
> <6>[ 246.919113] ? irq_forced_thread_fn+0x5f/0x5f <6>[ 246.919116] irq_thread_fn+0x22/0x4d <6>[ 246.919120] irq_thread+0x120/0x19d <6>[ 246.919123] ? irq_thread_fn+0x4d/0x4d <6>[ 246.919128] kthread+0x142/0x153 <6>[ 246.919132] ? irq_forced_secondary_handler+0x21/0x21
> <6>[ 246.919135] ? kthread_blkcg+0x31/0x31 <6>[ 246.919139] ret_from_fork+0x1f/0x30
> 
> The underlying question is if it really appropriate to have an
> msleep() of any kind in an interrupt handler. If this is about debouncing a signal, it should be handled with a delayed timer.
> 
> Guenter
> 
>> -----Original Message-----
>> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
>> Sent: Wednesday, January 18, 2023 03:57
>> To: David Rau <we730128@gmail.com>
>> Cc: perex@perex.cz; lgirdwood@gmail.com; broonie@kernel.org;
>> tiwai@suse.com; support.opensource@diasemi.com;
>> alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org; David Rau
>> <david.rau.zg@renesas.com>
>> Subject: Re: [PATCH] ASoC: da7219: Fix pole orientation detection on
>> OMTP headsets when playing music
>>
>> On Mon, Nov 21, 2022 at 05:07:44AM +0000, David Rau wrote:
>>> The OMTP pin define headsets can be mis-detected as line out instead
>>> of OMTP, causing obvious issues with audio quality.
>>> This patch is to put increased resistances within the device at a
>>> suitable point.
>>>
>>> To solve this issue better, the new mechanism setup ground switches
>>> with conditional delay control and these allow for more stabile
>>> detection process to operate as intended. This conditional delay
>>> control will not impact the hardware process but use extra system
>>> resource.
>>>
>>> This commit improves control of ground switches in the AAD logic.
>>>
>>> Signed-off-by: David Rau <david.rau.zg@renesas.com>
>>> ---
>>>   sound/soc/codecs/da7219-aad.c | 42
>>> ++++++++++++++++++++++++++++++-----
>>>   sound/soc/codecs/da7219-aad.h |  1 +
>>>   2 files changed, 37 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/sound/soc/codecs/da7219-aad.c
>>> b/sound/soc/codecs/da7219-aad.c index bba73c44c219..08200ec259f9
>>> 100644
>>> --- a/sound/soc/codecs/da7219-aad.c
>>> +++ b/sound/soc/codecs/da7219-aad.c
>>> @@ -352,9 +352,14 @@ static irqreturn_t da7219_aad_irq_thread(int irq, void *data)
>>>   	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
>>>   	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
>>>   	u8 events[DA7219_AAD_IRQ_REG_MAX];
>>> -	u8 statusa;
>>> +	u8 statusa, srm_st;
>>>   	int i, report = 0, mask = 0;
>>>   
>>> +	srm_st = snd_soc_component_read(component, DA7219_PLL_SRM_STS) & DA7219_PLL_SRM_STS_MCLK;
>>> +	msleep(da7219_aad->gnd_switch_delay * ((srm_st == 0x0) ? 2 : 1) -
>>> +4);
>>
>> Ever since this patch was applied to ChromeOS, we have observed hung task crashes in da7219_aad_irq_thread().
>>
>> Is it really appropriate to sleep up to (256 * 2) - 4 = 508 ms in an interrupt handler ?
>>
>> Thanks,
>> Guenter
>>
>>> +	/* Enable ground switch */
>>> +	snd_soc_component_update_bits(component, 0xFB, 0x01, 0x01);
>>> +
>>>   	/* Read current IRQ events */
>>>   	regmap_bulk_read(da7219->regmap, DA7219_ACCDET_IRQ_EVENT_A,
>>>   			 events, DA7219_AAD_IRQ_REG_MAX); @@ -454,8 +459,8 @@ static
>>> irqreturn_t da7219_aad_irq_thread(int irq, void *data)
>>>   			snd_soc_dapm_disable_pin(dapm, "Mic Bias");
>>>   			snd_soc_dapm_sync(dapm);
>>>   
>>> -			/* Enable ground switch */
>>> -			snd_soc_component_update_bits(component, 0xFB, 0x01, 0x01);
>>> +			/* Disable ground switch */
>>> +			snd_soc_component_update_bits(component, 0xFB, 0x01, 0x00);
>>>   		}
>>>   	}
>>>   
>>> @@ -831,6 +836,32 @@ static void da7219_aad_handle_pdata(struct snd_soc_component *component)
>>>   	}
>>>   }
>>>   
>>> +static void da7219_aad_handle_gnd_switch_time(struct
>>> +snd_soc_component *component) {
>>> +	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
>>> +	struct da7219_aad_priv *da7219_aad = da7219->aad;
>>> +	u8 jack_det;
>>> +
>>> +	jack_det = snd_soc_component_read(component, DA7219_ACCDET_CONFIG_2)
>>> +		& DA7219_JACK_DETECT_RATE_MASK;
>>> +	switch (jack_det) {
>>> +	case 0x00:
>>> +		da7219_aad->gnd_switch_delay = 32;
>>> +		break;
>>> +	case 0x10:
>>> +		da7219_aad->gnd_switch_delay = 64;
>>> +		break;
>>> +	case 0x20:
>>> +		da7219_aad->gnd_switch_delay = 128;
>>> +		break;
>>> +	case 0x30:
>>> +		da7219_aad->gnd_switch_delay = 256;
>>> +		break;
>>> +	default:
>>> +		da7219_aad->gnd_switch_delay = 32;
>>> +		break;
>>> +	}
>>> +}
>>>   
>>>   /*
>>>    * Suspend/Resume
>>> @@ -908,9 +939,6 @@ int da7219_aad_init(struct snd_soc_component *component)
>>>   	snd_soc_component_update_bits(component, DA7219_ACCDET_CONFIG_1,
>>>   			    DA7219_BUTTON_CONFIG_MASK, 0);
>>>   
>>> -	/* Enable ground switch */
>>> -	snd_soc_component_update_bits(component, 0xFB, 0x01, 0x01);
>>> -
>>>   	INIT_WORK(&da7219_aad->btn_det_work, da7219_aad_btn_det_work);
>>>   	INIT_WORK(&da7219_aad->hptest_work, da7219_aad_hptest_work);
>>>   
>>> @@ -928,6 +956,8 @@ int da7219_aad_init(struct snd_soc_component *component)
>>>   	regmap_bulk_write(da7219->regmap, DA7219_ACCDET_IRQ_MASK_A,
>>>   			  &mask, DA7219_AAD_IRQ_REG_MAX);
>>>   
>>> +	da7219_aad_handle_gnd_switch_time(component);
>>> +
>>>   	return 0;
>>>   }
>>>   EXPORT_SYMBOL_GPL(da7219_aad_init);
>>> diff --git a/sound/soc/codecs/da7219-aad.h
>>> b/sound/soc/codecs/da7219-aad.h index f48a12012ef3..21fdf53095cc
>>> 100644
>>> --- a/sound/soc/codecs/da7219-aad.h
>>> +++ b/sound/soc/codecs/da7219-aad.h
>>> @@ -187,6 +187,7 @@ enum da7219_aad_event_regs {  struct
>>> da7219_aad_priv {
>>>   	struct snd_soc_component *component;
>>>   	int irq;
>>> +	int gnd_switch_delay;
>>>   
>>>   	u8 micbias_pulse_lvl;
>>>   	u32 micbias_pulse_time;
>>> --
>>> 2.17.1
>>>

