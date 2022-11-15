Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7105629676
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237888AbiKOKzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbiKOKzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:55:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0702870B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668509576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G+3H+2hzN7lJcNAvjVxjjbaUf8WWh3Exbczi8rLOvfU=;
        b=Bg/uGQTZSFBovpy2CZfZqLTYKWmSze8YDRGMGvz+ht2NMxN591MonGJsAYzyOmpTVBd8eA
        Z6BB3uU6brEqWI6J6i4PETnF+40Z1FCwXgOloMhflgf9tULqvWF2B60K/BrxmWs56vydaf
        QthmHkh7paY8YsdBZ7DaASXDIuI13X4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-572-Ieo5CfSuPnuGkaKQIZTjug-1; Tue, 15 Nov 2022 05:52:54 -0500
X-MC-Unique: Ieo5CfSuPnuGkaKQIZTjug-1
Received: by mail-wm1-f70.google.com with SMTP id bg25-20020a05600c3c9900b003cf3ed7e27bso8152792wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:52:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G+3H+2hzN7lJcNAvjVxjjbaUf8WWh3Exbczi8rLOvfU=;
        b=Ky9qZrGui2YOgPRlq3UPefVhxYk3bsjeci4ZWwmQFtfjeUkJ7FMUJQPZIDkaF+Uw1h
         iJxtEseQiuNsZH9ZnQqEkkCczhpUD7JNRxqJbsBeqgcxQ5oNhi86RJaRoA85XkGV4Rcb
         vvh1XiN31gIYiAN/Snom2PhcIQFi3TT+UZQoHtsIxOCFSuzCge8q8ZHkathS9NqnVrn3
         6GXsR5pGVkuu6siOuqO7QhpjDe51W27HrTO8LDD+SYj0LznWMVHnyKPewtNWf0KQLeAZ
         HJ5W8vkAg+/IejG4XegnPD2q9SxCBGLi9sOTCOuqQZ9ECdU681z5VjjLkSBRKFYoM0iA
         hDuA==
X-Gm-Message-State: ANoB5pkrVx1/32lvW6ZAxcoYGBIaAW5kPDoe6wtZ+bQ8qtOUMsPxiTDG
        wOFFlVAl0xuBxgJMFpJDt3AqEKBwPyEwSKPae+N8ophCHwkQGKjdqNuVxuy5y+Umhgu761mYpmt
        CrH9IIUCWN5gsU5ROA7Cb+DBd
X-Received: by 2002:adf:fc0a:0:b0:22d:6988:30de with SMTP id i10-20020adffc0a000000b0022d698830demr10112885wrr.186.1668509573416;
        Tue, 15 Nov 2022 02:52:53 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6OhS6rVvGUNUlN2zRO0Y6Bj18I4r4O4vrmOHjgX6PMnuZ/lCOnX9UtCiSOiqwlR3M0flTj5g==
X-Received: by 2002:adf:fc0a:0:b0:22d:6988:30de with SMTP id i10-20020adffc0a000000b0022d698830demr10112859wrr.186.1668509572959;
        Tue, 15 Nov 2022 02:52:52 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r2-20020a5d6942000000b0022e47b57735sm12176078wrw.97.2022.11.15.02.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 02:52:52 -0800 (PST)
Message-ID: <b3f51e18-0a38-10f6-8072-bc2c5c2c6102@redhat.com>
Date:   Tue, 15 Nov 2022 11:52:51 +0100
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
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CANDhNCrSO_kByOCEHUyrdnbmaypt+u2Fw86iASDAjwbTNU3j3Q@mail.gmail.com>
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

Hello John,

Thanks for the detailed response.

On 11/15/22 10:33, John Stultz wrote:
> On Mon, Nov 14, 2022 at 2:43 AM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>>
>> The driver_deferred_probe_timeout value has a long story. It was first set
>> to -1 when it was introduced by commit 25b4e70dcce9 ("driver core: allow
>> stopping deferred probe after init"), meaning that the driver core would
>> defer the probe forever unless a subsystem would opt-in by checking if the
>> initcalls where done using the driver_deferred_probe_check_state() helper,
>> or if a timeout was explicitly set with a "deferred_probe_timeout" param.
> 
> Indeed, it is a long history, I appreciate your archaeology here and
> I'm sorry for my part in adding complexity to it.
>
> That said, I don't believe the above is quite right (but the logic was
> quite confusing, so it's easy to get wrong - and it's late here so
> forgive me if I muck up my own explanation).
>

Sorry if I didn't get all the details correct. I tried to be accurate on my
explanation but as you said, the logic is complex.
 
> As I mentioned in c8c43cee29f6 ("driver core: Fix
> driver_deferred_probe_check_state() logic"):
> "
>     driver_deferred_probe_check_state() has some uninituitive behavior.
> 
>     * From boot to late_initcall, it returns -EPROBE_DEFER
> 
>     * From late_initcall to the deferred_probe_timeout (if set)
>       it returns -ENODEV
> 
>     * If the deferred_probe_timeout it set, after it fires, it
>       returns -ETIMEDOUT
> 
>     This is a bit confusing, as its useful to have the function
>     return -EPROBE_DEFER while the timeout is still running. This
>     behavior has resulted in the somwhat duplicative
>     driver_deferred_probe_check_state_continue() function being
>     added.
> "
> 
> Looking at the code before this change, at late_initcall time, we'd
> run deferred_probe_initcall():
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/dd.c?id=e94f62b7140fa3da4c69a685b2e73ef52dd32c51#n321
> Which sets:  initcalls_done = true;
> 
> Then in __driver_deferred_probe_check_state():
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/dd.c?id=e94f62b7140fa3da4c69a685b2e73ef52dd32c51#n238
> 
> We check initcalls_done, and after its set, we stop returning
> -EPROBE_DEFER. If deferred_probe_timeout was not set, it would then
> return 0.
> 
> But then in driver_deferred_probe_check_state()
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/dd.c?id=e94f62b7140fa3da4c69a685b2e73ef52dd32c51#n262
> 
> When we see the 0 back from from __driver_deferred_probe_check_state()
> we'll return -ENODEV.
>

Yes, agreed that commit c8c43cee29f6 was correct and that's why I
didn't mention that one in my commit message.
 
> So I don't think it's true that before the change the driver core
> would defer the probe forever when there was no timeout.
>

I see. I thought that the driver_deferred_probe_check_state_continue()
function would check for the return value and return -EPROBE_DEFER if
if __driver_deferred_probe_check_state() returned 0.

But probably there was code calling driver_deferred_probe_check_state()
and not returning -EPROBE_DEFER after initcalls_done.

In any case, what I tried to say is that originally the semantics of the
deferred_probe_timeout= parameter was that it was disabled by default
and that it had to be explicitly set. But at some point that default was
switched and it became enabled by default unless is explicitly disabled.
 
> The problem we had at the time was that there were dts optional links
> (like iommus that may be in the dts but may not have a kernel driver),
> so if there is no module to load, we don't want to defer probing
> forever. The cutoff point was originally set to late_initcall time
> with a timeout option to extend it further.  However, with Android,
> modules often wouldn't get a chance to load until much after
> late_initcall time.
>

But do we need to tie the probe deferral to the optional links? Now both
driver_deferred_probe_timeout = 0 and fw_devlink_drivers_done() are done
in the deferred_probe_timeout_work_func() worker function handler.

Could we untangle the two? That is, have a timeout to relax the links but
still keep the probe deferral mechanism so that drivers with required
dependencies have an opportunity to re-probe if deferred once the modules
are loaded by user-land later in the boot?

> But setting the timeout didn't actually help to extend the probe time,
> because it would return -ENODEV after late_initcall. -  That's what my
> patch was trying to address.
> 

Yes. I don't think that having a 0 by default makes sense. As mentioned
in my commit message, if a system wants a 0 (no probe deferral after the
initcalls are done) then should either disable modules (since basically
makes module loading a no-op) or set deferred_probe_timeout=0 in cmdline.

What I'm arguing is that a default of -1 (don't timeout probe deferral)
is what should be the default.

> I also tried to move the default to 30 so we'd not need to set a boot
> parameter to get modules to load on a normal boot, but that caused
> some trouble w/ with NFS root systems and the fix there would mean
> that they'd have to wait 30 seconds before the rootfs would mount.
>

Right. I saw that in the git log history too. But I believe that's a corner
case that in any case should be handled separately. For example, the probe
deferral worker could be canceled if wait_for_init_devices_probe() is called?

Something like the following (pseudo-code):

diff --git a/drivers/base/core.c b/drivers/base/core.c
index d02501933467..d2cc04fef1f5 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1737,6 +1737,12 @@ void __init wait_for_init_devices_probe(void)
        if (!fw_devlink_flags || fw_devlink_is_permissive())
                return;
 
+       /*
+        * Cancel deferred probe to allow drivers with optional suppliers to
+        * be probed, even if those optional dependencies are still missing.
+        */
+       deferred_probe_cancel_timeout();
+
        /*
         * Wait for all ongoing probes to finish so that the "best effort" is
         * only applied to devices that can't probe otherwise.
 
>> Only the power domain, IOMMU and MDIO subsystems currently opt-in to check
>> if the initcalls have completed with driver_deferred_probe_check_state().
>>
>> Commit c8c43cee29f6 ("driver core: Fix driver_deferred_probe_check_state()
>> logic") then changed the driver_deferred_probe_check_state() helper logic,
>> to take into account whether modules have been enabled or not and also to
>> return -EPROBE_DEFER if the probe deferred timeout was still running.
>>
>> Then in commit e2cec7d68537 ("driver core: Set deferred_probe_timeout to a
>> longer default if CONFIG_MODULES is set"), the timeout was increased to 30
>> seconds if modules are enabled. Because seems that some of the subsystems
>> that were opt-in to not return -EPROBE_DEFER after the initcall where done
>> could still have dependencies whose drivers were built as a module.
>>
>> This commit did a fundamental change to how probe deferral worked though,
>> since now the default was not to attempt probing for drivers indefinitely
>> but instead it would timeout after 30 seconds unless a different timeout
>> was set using the "deferred_probe_timeout" parameter.
>>
>> The behavior was changed even mere with commit ce68929f07de ("driver core:
>> Revert default driver_deferred_probe_timeout value to 0"), since the value
>> was set to 0 by default. Meaning that the probe deferral would be disabled
>> after the initcalls where done. Unless a timeout was set in the cmdline.
>>
>> Notice that the commit said that it was reverting the default value to 0,
>> but this was never 0. The default was -1 at the beginning and then changed
>> to 30 in a later commit.
> 
> Hrm.  So -1 sort of changed meaning after my initial
> change(c8c43cee29f6), because after that it did indeed change to being
> indefinite EPROBE_DEFER.

Yes, but that was also the case for the original commit from Rob (25b4e70dcce9)
since driver_deferred_probe_check_state() was just:

int driver_deferred_probe_check_state(struct device *dev)
{
       if (initcalls_done) {
               if (!deferred_probe_timeout) {
                       dev_WARN(dev, "deferred probe timeout, ignoring dependency");
                       return -ETIMEDOUT;
               }
               dev_warn(dev, "ignoring dependency for device, assuming no driver");
               return -ENODEV;
       }
       return -EPROBE_DEFER;
}

So -1 being indefinite -EPROBE_DEFER was the original semantic and the default.

> For !modules systems, it was ok to use -1 before, because the check
> here would catch it:
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/dd.c?id=ce68929f07de#n255
> 
> But for modular systems, probing forever would break systems that have
> optional links in their DTS with no matching drivers, as the dependent
> drivers will never load.
>

And I think that is what should had been addressed. That is, relax the
link so that optional suppliers would not cause a probe deferral. But
not disable the whole probe deferral mechanism only for this case.
 
> So setting the default to 0 was done to match the earlier behavior
> (with probing ending at late_initcall time).
>

Yes, but that earlier behavior wasn't the original. That's what I tried
to say in the commit message.
 
>> This default value of 0 was reverted again by commit f516d01b9df2 ("Revert
>> "driver core: Set default deferred_probe_timeout back to 0."") and set to
>> 10 seconds instead. Which was still less than the 30 seconds that was set
>> at some point to allow systems with drivers built as modules and loaded by
>> user-land to probe drivers that were previously deferred.
>>
>> The 10 seconds timeout isn't enough for the mentioned systems, for example
>> general purpose distributions attempt to build all the possible drivers as
>> a module to keep the Linux kernel image small. But that means that in very
>> likely that the probe deferral mechanism will timeout and drivers won't be
>> probed correctly.
>>
>> So let's change the default again to -1 as it was at the beginning. That's
>> how probe deferral always worked. In fact, it could even be that users can
>> load modules manually after the system has already booted so it is better
>> to not assume when it can be safe to just timeout instead of probe defer.
> 
> So I worry setting it to -1 by default will cause regressions on
> systems with optional dts links.
> But maybe I'm still missing something?
>

It may be. I've to admit that I'm not that familiar with the device links
logic and may be missing some details. But as mentioned I believe that if
that's a problem, we should attempt to relax the links and allow drivers
with optional suppliers to be probed, while still allow drivers with links
that are required to be deferred in case that a driver is provided later.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

