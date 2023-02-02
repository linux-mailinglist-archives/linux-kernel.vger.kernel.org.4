Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5306886CE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 19:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjBBSlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 13:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjBBSlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 13:41:11 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45711F913
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 10:40:32 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-169ba826189so3693022fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 10:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0iQTxPvvHgGFpXzg5jYGYDQguwxIKatIb2kx0yBrFd4=;
        b=b01gByBTK4JtlziYSxiyk2IWVquBg9v1PW0C3V2cKFtDcrCRjIa7Cr4ByMZUOVcvO4
         8FFbHcKURJcsAVXLj1x/gFtyYUJRVruGeOrIdDtwFRuHZ1AuFCyDTiZlO3U76e8X6ECh
         xAKsv6EFq+RKiHeqMHM9F8sE10oFYgr9rdFk7WDJ6GC18Y0CRJuHhNY/sMXKoddgI3ER
         ntHhXIHlcjOvE/eODkiczkwKiBcok6bi7MfkaQ+F6gLeJj5fraa78SRBeh25lDoZO9QV
         KZYRMd+FtXwYYiBOgEwvOMHZfyOEyfH4KxL+LDtapYb8WcUskOUfc6Fb1EpKgNqQDq5l
         q0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0iQTxPvvHgGFpXzg5jYGYDQguwxIKatIb2kx0yBrFd4=;
        b=z8Buc9kL/MzUurbv0LKCqpOG2cmLn26AZgtcj63oue7cfjZY9fpCatkSc0+EkEjgJa
         psi7msyhN2XOzSl+NN/2M7U15DyIvu3Qrii1HbKOw9VSAiyeGFuGlceq1cZx+zFRKqWj
         rNURR9X/46XVGtCRcuZyV0xSaqKo6geNVhCVSA8JKrdG3kX7b9OVa0PwT71KVMtd/3/d
         nFCxWC28TvtBJofUIEfDw0bHZOTspr3LWrK61kUa8mmeCHgO5ulLkcM3gHek5lRxP1Xj
         z+94s0Hq/vX/Eq34tTxn9PZPoaR+hBf7JOPkyi0UcPbbtPOKfb8rpO7ZToDH16G+OtL9
         7Dwg==
X-Gm-Message-State: AO0yUKVh+Fr/VGX8CV2MywLJSbv15MTsRQ3mXe6sPFwamrGJPjPIow/n
        QmzFienn46GJeVqL8aStVCk=
X-Google-Smtp-Source: AK7set9hY+74Jj5ZVi4xaB9SbvMGHbNwV52nGeQh+zcQT7xkpXoXuoWJLxt9dxELarKmk4g9E+PArA==
X-Received: by 2002:a05:6870:d62b:b0:163:9403:4d0c with SMTP id a43-20020a056870d62b00b0016394034d0cmr3544341oaq.47.1675363194050;
        Thu, 02 Feb 2023 10:39:54 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l6-20020a4a2706000000b004a3527e8279sm150072oof.0.2023.02.02.10.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 10:39:53 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8f89eeac-b3ef-4137-80df-6cf044873b05@roeck-us.net>
Date:   Thu, 2 Feb 2023 10:39:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     David Rau <david.rau.zg@renesas.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "support.opensource@diasemi.com" <support.opensource@diasemi.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221121050744.2278-1-david.rau.zg@renesas.com>
 <20230117195645.GA83401@roeck-us.net>
 <OS3PR01MB66416CEF9F6E5AE62D194BACCDC49@OS3PR01MB6641.jpnprd01.prod.outlook.com>
 <20230119161221.GA981953@roeck-us.net>
 <OS3PR01MB66416C10BF8E6400C84DAD02CDD09@OS3PR01MB6641.jpnprd01.prod.outlook.com>
 <38f09c4d-70d1-f65f-6e9b-4ad84eda4059@roeck-us.net>
 <Y9kE1cSUg2CQM5vq@sirena.org.uk> <20230202155101.GB1373010@roeck-us.net>
 <Y9vtIISfmpICi+9u@sirena.org.uk>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] ASoC: da7219: Fix pole orientation detection on OMTP
 headsets when playing music
In-Reply-To: <Y9vtIISfmpICi+9u@sirena.org.uk>
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

On 2/2/23 09:04, Mark Brown wrote:
> On Thu, Feb 02, 2023 at 07:51:01AM -0800, Guenter Roeck wrote:
>> On Tue, Jan 31, 2023 at 12:08:53PM +0000, Mark Brown wrote:
>>> On Mon, Jan 30, 2023 at 10:16:06PM -0800, Guenter Roeck wrote:
> 
>>>> I'll see if I can implement a downstream fix.
> 
>>> If you implement something I don't see a reason not to post it upstream.
> 
>> I had a look into the code, and concluded that it is too complex for anyone
>> who doesn't know it to find a proper fix. For example, for an outsider it
> 
> It's definitely unclear, there's a datasheet at [1] which does appear to
> explicitly call for a 512ms delay though (see figure 20 on page 50).  It
> does look like it should only be applied in the case where an inserted
> jack is detected (ie, when identifying an accessory or button press) and
> not when removal is detected though.
> 

The datasheet doesn't really suggest that a delay shall be applied using
msleep (ie in the code). The chip presumably debounces internally (see
jackdet_debounce and jackdet_rem_deb), and there is also jack_detect_rate
to configure the detection rate. The table seems to suggest (to me) that
there is an e_jack_insertion event, which would then be followed 64-512 ms
later with an e_jack_detect_complete event.

Whatever is done in software is on top of that, or at least that is my
understanding, and not explained by anything in the datasheet.

Given that the chip itself supports debouncing internally, it is not clear
to me what the delay is actually supposed to accomplish. Soft debounce
on top of chip debounce ? I don't see that explained anywhere, though of
course I might be missing it.

>> is not conceivable (or explained) why the ground switch is enabled only
>> to be disabled immediately afterwards if a jack was removed.
> 
> It smells like there's a power benefit to leaving it disabled when
> unplugged (which seems plausible), and possibly like the detection is
> more stable with the ground switch enabled.  The ground switch is not
> documented AFAICT (it's in register 0xfb which isn't named and doesn't
> appear to appear in the datsheet from a quick search).  The code is
> leaving the switch enabled so long as an accessory is plugged.
> 

I understand. What I don't understand is that it is always enabled
in the interrupt handler, no matter if a jack was inserted or not,
only to be disabled immediately if the jack was disabled or after
insertion detection work is complete.

Overall it is not clear what the impact of enabling ground switch
actually is. What is really odd is that the original code only enabled
ground switch once during initialization and disabled it either
after a disconnect or after insertion detection was complete,
but never re-enabled it. Now it is briefly enabled in the interrupt
handler, but only after sleeping.

>> This is now the top crash reason on affected Chromebooks (so far I
>> identified Asus C424, HP SeaStar, and HP StingRay) with this patch
>> applied. I am inclined to revert it from all ChromeOS kernel branches.
>> At least for us the cure for the problem is much worse than the problem
>> itself.
> 
> Are you saying this is actually crashing, or just that you're getting
> warnings about threads being blocked for too long (that was what was
> posted earlier in the thread)?  The only things I can see that look like

ChromeOS is configured to crash after stalled threads are detected (ie
after 120 seconds), so this is actually causing crashes.

> they have the potential to actually lock up are the cancel_work_sync()
> calls but they were unchanged and the backtrace you showed was showing
> the thread in the msleep().  My guess would be that you've got systems
> where there are very frequent jack detection events (potentiallly with
> broken accessories, or possibly due to the ground switch putting things
> into the wrong priority) and that the interrupt is firing again as soon
> as the thread unmasks the primary interrupt which means it never
> actually stops running.
> 

That is what I strongly suspect is happening. I don't know why exactly
the interrupt is firing continuously, but the hang is always in msleep().
One possibility might be that the event is actually a disconnect event,
and that enabling and immediately disabling the ground switch causes
another interrupt, which is then handled immediately, causing the hang.

> It's possible that reordering things so that the delay is only applied
> if DA7219_JACK_INSERTION_STS_MASK is set would help, that'd need some
> motion of the interrupt acking as well.  That's probably a good idea in
> general, it's what the datasheet seems to call for and would lead to
> prompter removal detection.  However if the issue is systems with broken
> accessories constantly firing spurious button events they'd still be
> seeing the delay.
> 
> My other guess would be that moving the delay that's been added to a
> delayed work would avoid the warnings, though you might want to manually
> keep the physical interrupt disabled while that's running which is fun.
> Possibly also tuning down the delay given that as you say 500ms is
> rather a long potential delay even in the context of jack debounces,
> though if it is bad accessories then there's probably a bit of luck
> involved in the original code not triggering issues and any debounce is
> likely to cause fun, and like I say the datasheet does seem to say that
> this is the appropriate delay.
> 
> You'd end up with something along the lines of
> 
> 	disable_irq();
> 	schedule_delayed_work(delay, current_irq_code);
> 

I am not sure if that would fix anything. The current code sleeps, then
enables the ground switch and does the rest of the detection. I'd somewhat
understand the code if it would enable the ground switch after an "insertion
detected" interrupt, then wait for some amount of time and handle the rest
of the detection after waiting (even though that should really be handled by
the "detection complete" interrupt). But that isn't what it does.
If we were to implement the above, I suspect the result would be that the
interrupt still happens all the time, and the only difference would be that
it would be "silenced" while the delayed work is waiting to be scheduled.
That doesn't really fix the problem, it only works around it. But, sure,
it would be much better than the current situation.

My "wild shot" fix would be to enable the ground switch after an insertion
event and to drop the software sleep entirely.

However, it is really impossible to know what the delay is for in the
first place. Looking into the code further, the sleep time actually matches
the configured jack detection rate. I have no idea why it would make sense
to wait for a detection cycle after an event, then enable the ground switch
and actually handle the event (which by then probably reports that jack
detection is complete after an insertion). I really don't understand
the logic behind that.

Guenter

> in the IRQ handler then call enable_irq() on the way out of the new
> delayed_work.  That would keep the same flow but not look like the task
> is running which should avoid setting off the hung task alarm.
> 
> [1] https://www.renesas.com/us/en/document/dst/da7219-datasheet?r=1563341

