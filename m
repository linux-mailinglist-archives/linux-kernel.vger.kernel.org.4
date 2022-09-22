Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B290F5E69BD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 19:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbiIVRiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 13:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiIVRh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 13:37:58 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EB4EFA6B;
        Thu, 22 Sep 2022 10:37:57 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id y2so6806265qtv.5;
        Thu, 22 Sep 2022 10:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6pAvVwOh4ZfT/Ucve1wlzLE+jEzpV7GwW5c9s60CJWs=;
        b=kXK0A6cYEwOO+exNlZ8/rhUEnao+cVpxAwytmXszf59qJ/aPLpOIpZnlSG/3kjCCPD
         CYZtX2J8uocflMK/DGNgI0nuAsXOsfEeOVpsTlWy1/5NzKAHtwxE/xX5xfCGL5qVhLyb
         l3M9gD4k1fi4l2A52rVsdsozdnLvDALtsSHzxWSjeEBnZpdCScylYqWiMFw0IyQyuO/8
         i+O/1jNnZGW3hHkRwHB2b0kB5LNFmwphvxd6M/t1hvGBZnngI5Hw7C8M6kGjq6woAdCQ
         ZdheNC3wRW0K7rKu7aenXKKYUf1P4KZs+FQh7KXXeUOj/w/l0OBbg0ey1YpGi+KL6arS
         VH/Q==
X-Gm-Message-State: ACrzQf33jJnOcLhJEjRhRAEVQUQy1z7COPb4/MCP8IA1B4TXFf7J0ZTU
        WACtIZAxXInqtrKzMiBN7TI3cPJrSdXafVKB/9k=
X-Google-Smtp-Source: AMsMyM7oJUv/e5eLNmYRYH9UIAPBgONumGMf9ftsxHabwEuRhRQxJkefuSMppjDfDY8cdMwfaNo5SX/iiTJaraJFhKw=
X-Received: by 2002:a05:622a:620a:b0:35c:bf9e:8748 with SMTP id
 hj10-20020a05622a620a00b0035cbf9e8748mr3892292qtb.494.1663868276478; Thu, 22
 Sep 2022 10:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220922154354.2486595-1-dianders@chromium.org> <20220922084322.RFC.1.Iaa18b24fef0c8e88f0b82502f7fa0a70565b64d2@changeid>
In-Reply-To: <20220922084322.RFC.1.Iaa18b24fef0c8e88f0b82502f7fa0a70565b64d2@changeid>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 22 Sep 2022 19:37:45 +0200
Message-ID: <CAJZ5v0j+5ZJ3Za5pTiPe9NCRa3CV_KpaBX833vL=WH0tsTBF1g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] PM: runtime: Add pm_runtime_try_put_sync() and pm_runtime_try_get_sync()
To:     Douglas Anderson <dianders@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 5:44 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> In some cases, a caller may wish to synchronously get or put the PM
> Runtime state of a device but the caller may also be holding a
> resource that the runtime suspend or runtime resume of the device
> needs. Obviously this can lead to deadlock.
>
> A case in point is the clock framework. While running
> clk_disable_unused() the clock framework holds the global clock
> "prepare" lock. The clock framework then goes through and does PM
> Runtime actions. It should be no surprise to anyone that some devices
> need to prepare or unprepare clocks are part of their PM Runtime
> actions. Things generally work OK because of the "recursive" nature of
> the global clock "prepare" lock, but if we get unlucky and the PM
> Runtime action is happening in another task then we can end up
> deadlocking.
>
> Let's add a "try" version of the synchronous PM Runtime routines.
> This version will return -EINPROGRESS rather than waiting. To
> implement this we'll add a new flag: RPM_TRY.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/base/power/runtime.c |  7 +++++--
>  include/linux/pm_runtime.h   | 28 ++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 997be3ac20a7..67cc6a620b12 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -609,7 +609,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
>         if (dev->power.runtime_status == RPM_SUSPENDING) {
>                 DEFINE_WAIT(wait);
>
> -               if (rpmflags & (RPM_ASYNC | RPM_NOWAIT)) {
> +               if (rpmflags & (RPM_ASYNC | RPM_NOWAIT | RPM_TRY)) {
>                         retval = -EINPROGRESS;
>                         goto out;
>                 }
> @@ -791,7 +791,10 @@ static int rpm_resume(struct device *dev, int rpmflags)
>             || dev->power.runtime_status == RPM_SUSPENDING) {
>                 DEFINE_WAIT(wait);
>
> -               if (rpmflags & (RPM_ASYNC | RPM_NOWAIT)) {
> +               if (rpmflags & RPM_TRY) {
> +                       retval = -EINPROGRESS;

Returning -EINPROGRESS from here may be misleading, because the device
may not be resuming.

Besides, I'm not sure why a new flag is needed.  What about using
RPM_NOWAIT instead?



> +                       goto out;
> +               } else if (rpmflags & (RPM_ASYNC | RPM_NOWAIT)) {
>                         if (dev->power.runtime_status == RPM_SUSPENDING)
>                                 dev->power.deferred_resume = true;
>                         else
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 0a41b2dcccad..c68baa63f0e7 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -21,6 +21,8 @@
>  #define RPM_GET_PUT            0x04    /* Increment/decrement the
>                                             usage_count */
>  #define RPM_AUTO               0x08    /* Use autosuspend_delay */
> +#define RPM_TRY                        0x10    /* Try to be synchronous but fail
> +                                           with an error if we can't. */
>
>  /*
>   * Use this for defining a set of PM operations to be used in all situations
> @@ -425,6 +427,19 @@ static inline int pm_runtime_get_sync(struct device *dev)
>         return __pm_runtime_resume(dev, RPM_GET_PUT);
>  }
>
> +/**
> + * pm_runtime_try_get_sync - Like pm_runtime_get_sync() but err if blocking
> + * @dev: Target device.
> + *
> + * This function works just like pm_runtime_get_sync() except that if the
> + * device in question is currently in the process of suspending or resuming
> + * that it will return with -EINPROGRESS instead of blocking.
> + */
> +static inline int pm_runtime_try_get_sync(struct device *dev)
> +{
> +       return __pm_runtime_resume(dev, RPM_GET_PUT | RPM_TRY);
> +}
> +
>  /**
>   * pm_runtime_resume_and_get - Bump up usage counter of a device and resume it.
>   * @dev: Target device.
> @@ -489,6 +504,19 @@ static inline int pm_runtime_put_sync(struct device *dev)
>         return __pm_runtime_idle(dev, RPM_GET_PUT);
>  }
>
> +/**
> + * pm_runtime_try_put_sync - Like pm_runtime_put_sync() but err if blocking
> + * @dev: Target device.
> + *
> + * This function works just like pm_runtime_put_sync() except that if the
> + * device in question is currently in the process of suspending that it will
> + * return with -EINPROGRESS instead of blocking.
> + */
> +static inline int pm_runtime_try_put_sync(struct device *dev)
> +{
> +       return __pm_runtime_idle(dev, RPM_GET_PUT | RPM_TRY);
> +}
> +
>  /**
>   * pm_runtime_put_sync_suspend - Drop device usage counter and suspend if 0.
>   * @dev: Target device.
> --
> 2.37.3.968.ga6b4b080e4-goog
>
