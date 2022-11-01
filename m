Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F556147A3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 11:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiKAKY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 06:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKAKYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 06:24:23 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1263DF9E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 03:24:22 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id p15-20020a17090a348f00b002141615576dso692750pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 03:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KeuyhC/yqWeMZ9A5XwFlrzKZ+ajBX1/kPKg5+DZQVrM=;
        b=btzAajd+q+JpmIQm13I5HOulVkqsIH1EJRGHuaPfS6MbvPOkEM2c/b6kvooZu+25YQ
         3qls0kUzH4K1pD6HZ1NuPel5a2CYtsOK5412oU3sdUMPdlMBp9lxrd39EtisslQIU4JR
         Nuh2W3/i8jOb4TKFQVuCeCGFhmsQbWR5K5MzZA1WxZaQkZSHTtTjCqd1z7R5Jjc9jcZ6
         bTKORRm9JXCKbq6CKTNMHCYGUgVyvU7JQTbUtqIjLa16n6lnjHTL/zJ8fEX996H/8OYT
         nTnvluVsYa0T/oe7uKJWGkO3atpwqPL2hpLwkTd1cylvT5p39qAXDD8n4RInw0NR06RM
         yH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KeuyhC/yqWeMZ9A5XwFlrzKZ+ajBX1/kPKg5+DZQVrM=;
        b=GUbCIHbwE+ydgC+m+0PVMVv4ESTzm4ze30j8gpfrDNzAm0VycB+ZAofv9sNGkK10tQ
         d28xCiaeVFZ2A2PQ0k+Pxn5BbCN8EurP2EtVevt2wuBGmNUfUT2fntDj7mIYIryJxKNy
         rmjpdAu1+bP0tLgzMsc1cvDj2KLc8maepYld07Y37LFq80JiiboBR06zYn21/oX50LNq
         9gV8H4Y0GAWrvDJPYN1CjPTEUPg74P8BSr4n3W3v7M4NiaiBEj8mhnyqHWiRi6Uqy+XG
         dSNxNnkUwkW8L3y48gdAxyXdNgncPWOiy14O8GsE5lXOHWWE4CxW1F2OMTFBQ0GNZusd
         sLrA==
X-Gm-Message-State: ACrzQf0101RtUelDVSH5SkRyZBOJvgFE84L9+sMi+ejaEY1Y6otf1mtA
        LlUS5QpPmhTutknCLDoYyYnmBDPGPQiWZlmhGy34kA==
X-Google-Smtp-Source: AMsMyM4pKvV+Qk2wQ7bCR6XhdiDx26u61Hppa6SqeDDgb8CInrWbtfF06Y9S7fpIlVG3UeuCB/ehTxZsxBr/L45xrDw=
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id
 mw7-20020a17090b4d0700b001ef521cf051mr37407934pjb.164.1667298262178; Tue, 01
 Nov 2022 03:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221101024736.1509207-1-shawn.guo@linaro.org> <20221101024736.1509207-3-shawn.guo@linaro.org>
In-Reply-To: <20221101024736.1509207-3-shawn.guo@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 1 Nov 2022 11:23:45 +0100
Message-ID: <CAPDyKFqjf3P8GDfNinEeO57peM=7qVVP_M4yu1vsQY6N2wNcqA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] PM: domains: Consolidate genpd_restore_noirq() and genpd_resume_noirq()
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Nov 2022 at 03:47, Shawn Guo <shawn.guo@linaro.org> wrote:
>
> Most of the logic between genpd_restore_noirq() and genpd_resume_noirq()
> are same except GENPD_STATE_OFF status reset for hibernation restore.
> The suspended_count decrement for restore should be the right thing to do
> anyway, considering there is an increment in genpd_finish_suspend() for
> hibernation.
>
> Consolidate genpd_restore_noirq() and genpd_resume_noirq() into
> genpd_finish_resume() and handle GENPD_STATE_OFF status reset for
> restore case specially.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

I have a comment, see more below.

Nevertheless, please add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/base/power/domain.c | 70 ++++++++++++++++++-------------------
>  1 file changed, 35 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 54f6b0dd35fb..b81baeb38d81 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1247,12 +1247,14 @@ static int genpd_suspend_noirq(struct device *dev)
>  }
>
>  /**
> - * genpd_resume_noirq - Start of resume of device in an I/O PM domain.
> + * genpd_finish_resume - Completion of resume of device in an I/O PM domain.
>   * @dev: Device to resume.
> + * @resume_noirq: Generic resume_noirq callback.
>   *
>   * Restore power to the device's PM domain, if necessary, and start the device.
>   */
> -static int genpd_resume_noirq(struct device *dev)
> +static int genpd_finish_resume(struct device *dev,
> +                              int (*resume_noirq)(struct device *dev))
>  {
>         struct generic_pm_domain *genpd;
>         int ret;
> @@ -1264,9 +1266,25 @@ static int genpd_resume_noirq(struct device *dev)
>                 return -EINVAL;
>
>         if (device_wakeup_path(dev) && genpd_is_active_wakeup(genpd))
> -               return pm_generic_resume_noirq(dev);
> +               return resume_noirq(dev);
>
>         genpd_lock(genpd);
> +
> +       /*
> +        * Special handling for hibernation restore:
> +        * At this point suspended_count == 0 means we are being run for the
> +        * first time for the given domain in the present cycle.
> +        */
> +       if (resume_noirq == pm_generic_restore_noirq &&
> +           genpd->suspended_count++ == 0) {
> +               /*
> +                * The boot kernel might put the domain into arbitrary state,
> +                * so make it appear as powered off to genpd_sync_power_on(),
> +                * so that it tries to power it on in case it was really off.
> +                */
> +               genpd->status = GENPD_STATE_OFF;

This has really never worked as intended. Resetting the status like
this, needs more careful actions.

For example, if the genpd->status was GENPD_STATE_ON, the parent
domain's ->sd_count have been increased - so that needs to be adjusted
too.

By looking at patch3/3, I wonder if we shouldn't try to align the
hibernation behaviors so the above hack can be dropped. Do you think
that could work?

> +       }
> +
>         genpd_sync_power_on(genpd, true, 0);
>         genpd->suspended_count--;
>         genpd_unlock(genpd);
> @@ -1281,6 +1299,19 @@ static int genpd_resume_noirq(struct device *dev)
>         return pm_generic_resume_noirq(dev);
>  }
>
> +/**
> + * genpd_resume_noirq - Start of resume of device in an I/O PM domain.
> + * @dev: Device to resume.
> + *
> + * Restore power to the device's PM domain, if necessary, and start the device.
> + */
> +static int genpd_resume_noirq(struct device *dev)
> +{
> +       dev_dbg(dev, "%s()\n", __func__);
> +
> +       return genpd_finish_resume(dev, pm_generic_resume_noirq);
> +}
> +
>  /**
>   * genpd_freeze_noirq - Completion of freezing a device in an I/O PM domain.
>   * @dev: Device to freeze.
> @@ -1366,40 +1397,9 @@ static int genpd_poweroff_noirq(struct device *dev)
>   */
>  static int genpd_restore_noirq(struct device *dev)
>  {
> -       struct generic_pm_domain *genpd;
> -       int ret = 0;
> -
>         dev_dbg(dev, "%s()\n", __func__);
>
> -       genpd = dev_to_genpd(dev);
> -       if (IS_ERR(genpd))
> -               return -EINVAL;
> -
> -       /*
> -        * At this point suspended_count == 0 means we are being run for the
> -        * first time for the given domain in the present cycle.
> -        */
> -       genpd_lock(genpd);
> -       if (genpd->suspended_count++ == 0) {
> -               /*
> -                * The boot kernel might put the domain into arbitrary state,
> -                * so make it appear as powered off to genpd_sync_power_on(),
> -                * so that it tries to power it on in case it was really off.
> -                */
> -               genpd->status = GENPD_STATE_OFF;
> -       }
> -
> -       genpd_sync_power_on(genpd, true, 0);
> -       genpd_unlock(genpd);
> -
> -       if (genpd->dev_ops.stop && genpd->dev_ops.start &&
> -           !pm_runtime_status_suspended(dev)) {
> -               ret = genpd_start_dev(genpd, dev);
> -               if (ret)
> -                       return ret;
> -       }
> -
> -       return pm_generic_restore_noirq(dev);
> +       return genpd_finish_resume(dev, pm_generic_restore_noirq);
>  }
>
>  /**

Kind regards
Uffe
