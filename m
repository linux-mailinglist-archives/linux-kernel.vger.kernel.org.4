Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354D762945F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbiKOJd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiKOJdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:33:54 -0500
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBD3B2A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:33:52 -0800 (PST)
Received: by mail-vk1-xa30.google.com with SMTP id e2so6267970vkd.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DE9d79AS1YMkaccoxQZzrzy0MfNYJI9aE16Q5MLOSDQ=;
        b=YgnFDUPV4BkOQUN0Eehi4aiZjYK0zsyd7h68IKHwUysnm5ZHAeVYqS5IF7VXe0EAKF
         agINo5+r/uMv6dvCyuET6LGfbnZc/Megh5XPlsBY1AYB2eWHsMyz+QJ4t8iEef5BLzpE
         O5PnhGGEz9KmwOmQS2dt2L8xxSBB/xb6CCINB6f7pEWss3X5btSbhYkCCOLdE+Yc44Yb
         e6DD2AEK2a0CfEKnghVdXJ85t5sBqJyJeI/fJXv9aRx0jD8OV+7je138bLxXv95sp78c
         pRghooAy/0+TXoVS5GZwh0Gkjbyggdh+fjUqFIgktOA2TI/1Uu0epNwBl5p+ALCEYaNo
         UWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DE9d79AS1YMkaccoxQZzrzy0MfNYJI9aE16Q5MLOSDQ=;
        b=GMkGiPowiIhOxtrEFDPm+xh3n/PyPbY70TCFy7hzCC/AKWyXANnFbb3s2IqlLJ14O2
         7PcxBOc3Di73A0rfkQRwOpxUDeUikcRWB/Z7ddpQxl29VtSs8usAboEH1Lbo6YtHRewK
         TFsXEdCRqBRXAoixPj4giUt7K2hER2CZFEF/natY/gGlpuiKw9mLd9tBQ+OS2DSUaTpV
         /T8at5CpqhLrSg9Edr1j9DqyMVamEPJKxl6pE9ih4Iy6kW5z2UHfej+YOrh2Q5yxFLWK
         db3jpEAZ819neIawMaJeulbc61CivKx5EA73Ynb+HtKLj7GPlhW8J2lV7r3aWxaFWtHH
         3Quw==
X-Gm-Message-State: ANoB5plo2JmTf/5PW+ojxeLfuNOI7bPVM2zgP8FHFt/NNvajiOcGIB00
        1MzbwmxsyJBSqVSsYu7h0bxF2N/C4v/GKaDcOrv7
X-Google-Smtp-Source: AA0mqf4PGFV9ImYOhOjSrezvc5tPBPXWcfirBp0aMfuAYj0zs1Iehn083e3lLUurERadb3rbGgLvOfl7F1OecamO2Ik=
X-Received: by 2002:a05:6122:2304:b0:3b8:42bd:5807 with SMTP id
 bq4-20020a056122230400b003b842bd5807mr8737673vkb.39.1668504831734; Tue, 15
 Nov 2022 01:33:51 -0800 (PST)
MIME-Version: 1.0
References: <20221114104333.3695531-1-javierm@redhat.com>
In-Reply-To: <20221114104333.3695531-1-javierm@redhat.com>
From:   John Stultz <jstultz@google.com>
Date:   Tue, 15 Nov 2022 01:33:40 -0800
Message-ID: <CANDhNCrSO_kByOCEHUyrdnbmaypt+u2Fw86iASDAjwbTNU3j3Q@mail.gmail.com>
Subject: Re: [PATCH] driver core: Disable driver deferred probe timeout by default
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        Peter Robinson <pbrobinson@redhat.com>,
        Steev Klimaszewski <steev@kali.org>,
        Rob Herring <robh@kernel.org>,
        Sergio Lopez Pascual <slp@redhat.com>,
        Enric Balletbo i Serra <eballetbo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 2:43 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> The driver_deferred_probe_timeout value has a long story. It was first set
> to -1 when it was introduced by commit 25b4e70dcce9 ("driver core: allow
> stopping deferred probe after init"), meaning that the driver core would
> defer the probe forever unless a subsystem would opt-in by checking if the
> initcalls where done using the driver_deferred_probe_check_state() helper,
> or if a timeout was explicitly set with a "deferred_probe_timeout" param.

Indeed, it is a long history, I appreciate your archaeology here and
I'm sorry for my part in adding complexity to it.

That said, I don't believe the above is quite right (but the logic was
quite confusing, so it's easy to get wrong - and it's late here so
forgive me if I muck up my own explanation).

As I mentioned in c8c43cee29f6 ("driver core: Fix
driver_deferred_probe_check_state() logic"):
"
    driver_deferred_probe_check_state() has some uninituitive behavior.

    * From boot to late_initcall, it returns -EPROBE_DEFER

    * From late_initcall to the deferred_probe_timeout (if set)
      it returns -ENODEV

    * If the deferred_probe_timeout it set, after it fires, it
      returns -ETIMEDOUT

    This is a bit confusing, as its useful to have the function
    return -EPROBE_DEFER while the timeout is still running. This
    behavior has resulted in the somwhat duplicative
    driver_deferred_probe_check_state_continue() function being
    added.
"

Looking at the code before this change, at late_initcall time, we'd
run deferred_probe_initcall():
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/dd.c?id=e94f62b7140fa3da4c69a685b2e73ef52dd32c51#n321
Which sets:  initcalls_done = true;

Then in __driver_deferred_probe_check_state():
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/dd.c?id=e94f62b7140fa3da4c69a685b2e73ef52dd32c51#n238

We check initcalls_done, and after its set, we stop returning
-EPROBE_DEFER. If deferred_probe_timeout was not set, it would then
return 0.

But then in driver_deferred_probe_check_state()
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/dd.c?id=e94f62b7140fa3da4c69a685b2e73ef52dd32c51#n262

When we see the 0 back from from __driver_deferred_probe_check_state()
we'll return -ENODEV.

So I don't think it's true that before the change the driver core
would defer the probe forever when there was no timeout.

The problem we had at the time was that there were dts optional links
(like iommus that may be in the dts but may not have a kernel driver),
so if there is no module to load, we don't want to defer probing
forever. The cutoff point was originally set to late_initcall time
with a timeout option to extend it further.  However, with Android,
modules often wouldn't get a chance to load until much after
late_initcall time.

But setting the timeout didn't actually help to extend the probe time,
because it would return -ENODEV after late_initcall. -  That's what my
patch was trying to address.

I also tried to move the default to 30 so we'd not need to set a boot
parameter to get modules to load on a normal boot, but that caused
some trouble w/ with NFS root systems and the fix there would mean
that they'd have to wait 30 seconds before the rootfs would mount.

> Only the power domain, IOMMU and MDIO subsystems currently opt-in to check
> if the initcalls have completed with driver_deferred_probe_check_state().
>
> Commit c8c43cee29f6 ("driver core: Fix driver_deferred_probe_check_state()
> logic") then changed the driver_deferred_probe_check_state() helper logic,
> to take into account whether modules have been enabled or not and also to
> return -EPROBE_DEFER if the probe deferred timeout was still running.
>
> Then in commit e2cec7d68537 ("driver core: Set deferred_probe_timeout to a
> longer default if CONFIG_MODULES is set"), the timeout was increased to 30
> seconds if modules are enabled. Because seems that some of the subsystems
> that were opt-in to not return -EPROBE_DEFER after the initcall where done
> could still have dependencies whose drivers were built as a module.
>
> This commit did a fundamental change to how probe deferral worked though,
> since now the default was not to attempt probing for drivers indefinitely
> but instead it would timeout after 30 seconds unless a different timeout
> was set using the "deferred_probe_timeout" parameter.
>
> The behavior was changed even mere with commit ce68929f07de ("driver core:
> Revert default driver_deferred_probe_timeout value to 0"), since the value
> was set to 0 by default. Meaning that the probe deferral would be disabled
> after the initcalls where done. Unless a timeout was set in the cmdline.
>
> Notice that the commit said that it was reverting the default value to 0,
> but this was never 0. The default was -1 at the beginning and then changed
> to 30 in a later commit.

Hrm.  So -1 sort of changed meaning after my initial
change(c8c43cee29f6), because after that it did indeed change to being
indefinite EPROBE_DEFER.
For !modules systems, it was ok to use -1 before, because the check
here would catch it:
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/dd.c?id=ce68929f07de#n255

But for modular systems, probing forever would break systems that have
optional links in their DTS with no matching drivers, as the dependent
drivers will never load.

So setting the default to 0 was done to match the earlier behavior
(with probing ending at late_initcall time).

> This default value of 0 was reverted again by commit f516d01b9df2 ("Revert
> "driver core: Set default deferred_probe_timeout back to 0."") and set to
> 10 seconds instead. Which was still less than the 30 seconds that was set
> at some point to allow systems with drivers built as modules and loaded by
> user-land to probe drivers that were previously deferred.
>
> The 10 seconds timeout isn't enough for the mentioned systems, for example
> general purpose distributions attempt to build all the possible drivers as
> a module to keep the Linux kernel image small. But that means that in very
> likely that the probe deferral mechanism will timeout and drivers won't be
> probed correctly.
>
> So let's change the default again to -1 as it was at the beginning. That's
> how probe deferral always worked. In fact, it could even be that users can
> load modules manually after the system has already booted so it is better
> to not assume when it can be safe to just timeout instead of probe defer.

So I worry setting it to -1 by default will cause regressions on
systems with optional dts links.
But maybe I'm still missing something?

thanks
-john
