Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FE162D4DC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239494AbiKQIP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239326AbiKQIPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:15:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E4F19295
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668672899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qB0iHmy8qsjIKAPLew8PAASkvgtR+4YgyUv39en5Sjg=;
        b=c1EspAMgI46SpmXfdfrkCNWDY+ATAXNBMk3J/l61FRu7YaMLvJpvQWUplaBn2+uAOD/Dka
        ApjSoDHbGzbhzlw1aJo4fNokGjFCAWRwaPyq9h7fe47BfqeZhPORYzo7cmi79VaBXUuoLw
        MdnC2vdcm6/cI5raAOKsWZnidN2na0A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-107-whrujKAOO02CMiy1JqhwWA-1; Thu, 17 Nov 2022 03:14:58 -0500
X-MC-Unique: whrujKAOO02CMiy1JqhwWA-1
Received: by mail-wm1-f69.google.com with SMTP id ay40-20020a05600c1e2800b003cf8aa16377so294616wmb.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:14:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qB0iHmy8qsjIKAPLew8PAASkvgtR+4YgyUv39en5Sjg=;
        b=BFX2uY2MrdNbR7jW2ZFHV3ODemGBF2rZ2EInVisPr0BMXMl7ovmflt92To7Z1nrtTV
         5h0A8+fQao4GlbHYGMbmPIeyJSDQvPkcqF4mtKJ+Xik5o5ZeGcrKP6GyEkAprq6tH95+
         CdhpJZlRQ9zQ+JvS4byOkfgBxm8vtunwrwn/7qEOwAyWY3OH5M/F/IDNzYDc19pHCSp/
         Xy/BbcaxWMmTFIrsgpt5eawsOnIZI8zcqm6VUQ4mUOqONm3b8byzgK/4FaldNpjDaWJO
         qnZl/e7FJz7lero9Dxffy2dE7vBiUK93tda7BR0ZLoz3T+ZJdlB+S7P2NuGXMXR/KvqE
         vDAQ==
X-Gm-Message-State: ANoB5pkZEDRrP9ozRCTC//7Y2dzroIBH/IBGp4RIK32avuq30MX12dH8
        WYUlfdi01cQXn0Uwqv3C1nzvRBZwp3JMvRuVPJj5h3jQrJodS+vPDak1dvnYm5nj1LW8w1BB3nq
        dTtDRy26xPewZ/yRLeCxRoc+4
X-Received: by 2002:a7b:ca53:0:b0:3cf:74ef:3313 with SMTP id m19-20020a7bca53000000b003cf74ef3313mr894459wml.41.1668672897039;
        Thu, 17 Nov 2022 00:14:57 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4pciFRpSoc7JBNA1XSElGZiClC/6TGgcGJRXbrv9ETnAaHxLH31r5qadZto5qshWhgah6R/Q==
X-Received: by 2002:a7b:ca53:0:b0:3cf:74ef:3313 with SMTP id m19-20020a7bca53000000b003cf74ef3313mr894437wml.41.1668672896708;
        Thu, 17 Nov 2022 00:14:56 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j39-20020a05600c1c2700b003cf57329221sm5302757wms.14.2022.11.17.00.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 00:14:56 -0800 (PST)
Message-ID: <d990f737-e18a-c294-3490-5e3f4eb4da85@redhat.com>
Date:   Thu, 17 Nov 2022 09:14:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] driver core: Disable driver deferred probe timeout by
 default
Content-Language: en-US
To:     John Stultz <jstultz@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        Peter Robinson <pbrobinson@redhat.com>,
        Steev Klimaszewski <steev@kali.org>,
        Rob Herring <robh@kernel.org>,
        Sergio Lopez Pascual <slp@redhat.com>,
        Enric Balletbo i Serra <eballetbo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20221114104333.3695531-1-javierm@redhat.com>
 <CANDhNCrSO_kByOCEHUyrdnbmaypt+u2Fw86iASDAjwbTNU3j3Q@mail.gmail.com>
 <b3f51e18-0a38-10f6-8072-bc2c5c2c6102@redhat.com>
 <CANDhNCrTk09RF=4OwS_yj=DeDRcz34xRmbUj_-+isJtnvWZTwg@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CANDhNCrTk09RF=4OwS_yj=DeDRcz34xRmbUj_-+isJtnvWZTwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/22 21:49, John Stultz wrote:
>  On Tue, Nov 15, 2022 at 2:53 AM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> On 11/15/22 10:33, John Stultz wrote:
>>> So I don't think it's true that before the change the driver core
>>> would defer the probe forever when there was no timeout.
>>>
>>
>> I see. I thought that the driver_deferred_probe_check_state_continue()
>> function would check for the return value and return -EPROBE_DEFER if
>> if __driver_deferred_probe_check_state() returned 0.
> 
> Yes, but that was only used by the pinctrl driver, I think mostly as a
> result of the confusing semantics of the
> driver_deferred_probe_check_state() behavior.
> After the semantics were improved (at least in my view - again
> apologies for any trouble I've caused you looking over all this :) it
> was switched it back.
> But yes, in that case, it would absorb the results and return
> -EPROBE_DEFER indefinitely if modules were enabled.
> 
>> But probably there was code calling driver_deferred_probe_check_state()
>> and not returning -EPROBE_DEFER after initcalls_done.
> 
> I'm not sure I recall any other than the pinctrl case.
> 
> 

I don't see pinctrl using it anymore, currently these are the callers:

$ git grep driver_deferred_probe_check_state | grep -v "drivers/base/dd.c"
drivers/base/power/domain.c:            return driver_deferred_probe_check_state(base_dev);
drivers/iommu/of_iommu.c:               return driver_deferred_probe_check_state(dev);
drivers/net/mdio/fwnode_mdio.c:         rc = driver_deferred_probe_check_state(&phy->mdio.dev);
include/linux/device/driver.h:int driver_deferred_probe_check_state(struct device *dev)

ah, pinctrl and PM usage was deleted by commits:

24a026f85241 ("pinctrl: devicetree Delete usage of driver_deferred_probe_check_state()")
5a46079a9645 ("PM: domains: Delete usage of driver_deferred_probe_check_state()")

>> In any case, what I tried to say is that originally the semantics of the
>> deferred_probe_timeout= parameter was that it was disabled by default
>> and that it had to be explicitly set. But at some point that default was
>> switched and it became enabled by default unless is explicitly disabled.
> 
> True, I tried to set it to 30, then to zero and Saravana has set it to 10.
> But I believe that the timeout of zero was functionally identical to
> that of -1 behavior before my patches.

You mean before c8c43cee29f6 ("driver core: Fix driver_deferred_probe_check_state()
logic") right?

> The only difference is before w/ -1 you'd get -ENODEV at
> late_initcall, whereas with my changes (after ce68929f07de) and the
> default value set to 0, you get -ETIMEDOUT after late_initcall.
>
> To my understanding, in neither case did you ever get -EPROBE_DEFER
> after late_initcall.
> 

Yes, you are correct. I got confused by the current logic after your
c8c43cee29f6 commit and the original logic when the helper was added.

> 
>>> The problem we had at the time was that there were dts optional links
>>> (like iommus that may be in the dts but may not have a kernel driver),
>>> so if there is no module to load, we don't want to defer probing
>>> forever. The cutoff point was originally set to late_initcall time
>>> with a timeout option to extend it further.  However, with Android,
>>> modules often wouldn't get a chance to load until much after
>>> late_initcall time.
>>>
>>
>> But do we need to tie the probe deferral to the optional links? Now both
>> driver_deferred_probe_timeout = 0 and fw_devlink_drivers_done() are done
>> in the deferred_probe_timeout_work_func() worker function handler.
>>
>> Could we untangle the two? That is, have a timeout to relax the links but
>> still keep the probe deferral mechanism so that drivers with required
>> dependencies have an opportunity to re-probe if deferred once the modules
>> are loaded by user-land later in the boot?
>>
> 
> Potentially? I'd defer to Saravana, as the fwdevlink effort was in a
> large part resolving the dependency links in a sane way, which allowed
> for not having to set the deferred_probe_timeout boot option in order
> to get modules to load on devices.
> 

Yes, but then that's only before late_initcall() because after that the
links are relaxed to allow drivers to probe with optional links. But it
also means that drivers probe are not deferred anymore. That's why I
think that we should untangle the two.

>>> But setting the timeout didn't actually help to extend the probe time,
>>> because it would return -ENODEV after late_initcall. -  That's what my
>>> patch was trying to address.
>>>
>>
>> Yes. I don't think that having a 0 by default makes sense. As mentioned
>> in my commit message, if a system wants a 0 (no probe deferral after the
>> initcalls are done) then should either disable modules (since basically
>> makes module loading a no-op) or set deferred_probe_timeout=0 in cmdline.
>>
>> What I'm arguing is that a default of -1 (don't timeout probe deferral)
>> is what should be the default.
> 
> I don't think that's really an option. I'm not a fan of the deferred
> probe timeout, but it resolved the optional links and at least my
> efforts to change to a longer timeout value weren't able to work
> without causing regressions to someone. And until the fwdevlink stuff
> landed, some devices I dealt with just required booting with the
> deferred_probe_timeout=30 boot option set.

Yeah, but that was before the work from Saravana on fwdevlinks so maybe
now we can make it work. AFAIK is on PTO until the 28th so I'll wait for
feedback on the latest v2 patch-series once is back.

> I'm pretty sure that defaulting to indefinite probe deferral will
> cause regressions.
> 

It may well be but I still think that we could make it work and avoid the
probe deferral timeout.

> 
>>> I also tried to move the default to 30 so we'd not need to set a boot
>>> parameter to get modules to load on a normal boot, but that caused
>>> some trouble w/ with NFS root systems and the fix there would mean
>>> that they'd have to wait 30 seconds before the rootfs would mount.
>>>
>>
>> Right. I saw that in the git log history too. But I believe that's a corner
>> case that in any case should be handled separately. For example, the probe
>> deferral worker could be canceled if wait_for_init_devices_probe() is called?
>>
>> Something like the following (pseudo-code):
>>
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index d02501933467..d2cc04fef1f5 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -1737,6 +1737,12 @@ void __init wait_for_init_devices_probe(void)
>>         if (!fw_devlink_flags || fw_devlink_is_permissive())
>>                 return;
>>
>> +       /*
>> +        * Cancel deferred probe to allow drivers with optional suppliers to
>> +        * be probed, even if those optional dependencies are still missing.
>> +        */
>> +       deferred_probe_cancel_timeout();
>> +
> 
> 
> Potentially? I'd defer to Saravana as I've not kept up with recent
> changes. Though it seems sort of similar to the initcalls_done
> semantics?
>

Indeed. It is redundant since ip_auto_config() that ends calling this
function is also a late_initcall function. That's why I didn't include
this in my v2.
 
> One of the foggy ideas I had was that it seemed like instead of a boot
> timer, we sort of really wanted a per-driver-probe timer, so that
> after init, if a module load happens, there's a new timer that gives a
> 30 seconds or so window for any dependent drivers to be loaded before
> continuing on. But I hadn't time to fully think it out.

That may work but I still have the gut feeling that we are making it more
complicated than necessary. The probe deferral mechanism albeit inefficient
it was highly effective on allowing drivers to re-probe until the deps were
available. I always thought that was a simple and elegant design.

> 
> 
>>> Hrm.  So -1 sort of changed meaning after my initial
>>> change(c8c43cee29f6), because after that it did indeed change to being
>>> indefinite EPROBE_DEFER.
>>
>> Yes, but that was also the case for the original commit from Rob (25b4e70dcce9)
>> since driver_deferred_probe_check_state() was just:
>>
>> int driver_deferred_probe_check_state(struct device *dev)
>> {
>>        if (initcalls_done) {
>>                if (!deferred_probe_timeout) {
>>                        dev_WARN(dev, "deferred probe timeout, ignoring dependency");
>>                        return -ETIMEDOUT;
>>                }
>>                dev_warn(dev, "ignoring dependency for device, assuming no driver");
>>                return -ENODEV;
>>        }
>>        return -EPROBE_DEFER;
>> }
>>
>> So -1 being indefinite -EPROBE_DEFER was the original semantic and the default.
> 
> I think you're misreading this? In the code above, as soon as
> initcalls_done is set (at late_initcall), it returns -ENODEV.
> So even with deferred_probe_timeout = -1, after late_initcall, it will
> return -ENODEV and probing will stop.
>

I did indeed misread, sorry about that. As mentioned I conflated the
logic after your fix by c8c43cee29f6 with the original logic. I will
update the commit message if after review Saravana considers that is
worth to keep pursuing this.
 
> I sadly can't respond to all your points, but hopefully the above
> helps clarify some details.  I do agree the deferred_probe_timeout and
> optional links logic is unfortunate, and by providing a working
> solution for optional links, it creates hardships for late module
> loading on other systems. But once it landed, fixing the latter would
> break for the former, (and sometimes fixing the latter would break
> other use cases) and we were sort of stuck with having to require
> devices that do later module loading to specify the timeout boot
> option.  I think Saravana's immense fwdevlink efforts have improved
> things greatly, but I'm glad others are looking for better solutions
> as well, so I look forward to your proposals (hopefully I can read
> over your patches from last night soon).
> 

Thanks a lot for your time and the detailed responses. In the meantime
I'll just built-in the clock drivers in the fedora kernel to allow the
arm-smmu to probe before late_initcall, but consider that a workaround.

My motivation was to fix it properly in the device core because I know
that will be an issue down the road for other platforms as well.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

