Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1786C3AF3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCUTrB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Mar 2023 15:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjCUTqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:46:51 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7A2580F7;
        Tue, 21 Mar 2023 12:46:20 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id cn12so18509491edb.4;
        Tue, 21 Mar 2023 12:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679427840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eVY2bCbzUOo/p7S7OEi2ht4GUnDgKAs6VyB8tC8Oe8k=;
        b=22a+7nVziU8bhcwOaN/46pbr7gS6G03xOU5jC7hB0tDdBEfEhpcnDhvbt28H25nJGf
         xfc9cVYHViltQQGXXJxXNesielacB1DFmuAOSAsxXYLv6eLd+uRVcO2iZxdVJGHGIeR+
         08OmbOU9O4xFHjBt18tvsJMwyOom3VJpEwLa7H1gXpuHVMUYrnYKjgu3kQ5ZxQ5QnCxB
         N+zXpV/NYp+FWlkyIRs/g8yHEIqp32Kr2rBDnLO8d25B7kYsu0wy9oUdNMVAr1rgety6
         mFXRhl3gctyMn19RRntjX7mM/fwXVmv0oJ2hm8a3G3rjjhY6ZIp2Ppn67NPyai8WZ+o3
         /Eig==
X-Gm-Message-State: AO0yUKV/N8uqAFQEjfwbYrUr8BSyvNrO5z6lR0bzYeBA5onHNiXQnQ0L
        lGv+4/zIxBziF7DWLjExPryS78fSEADYNOPapPPJzwMrV4k=
X-Google-Smtp-Source: AK7set8ZxxSpLDDzdZnzsWdnytwLxHh3DXH/bs7YD5S/d1HcHR+UgtAmfvhF3xL8COLWn/3Qg2/MdUA15Xqf1EC8Spk=
X-Received: by 2002:a50:c3cf:0:b0:4fb:2593:846 with SMTP id
 i15-20020a50c3cf000000b004fb25930846mr2214262edf.3.1679427840205; Tue, 21 Mar
 2023 12:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230321154627.17787-1-rui.zhang@intel.com>
In-Reply-To: <20230321154627.17787-1-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 21 Mar 2023 20:43:49 +0100
Message-ID: <CAJZ5v0hof_Hb0awv8-MkTwcKVQvrWvVvu-yBcFFw8C67Hzr6=A@mail.gmail.com>
Subject: Re: [PATCH] thermal/core: update cooling device during thermal zone unregistration
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 4:46 PM Zhang Rui <rui.zhang@intel.com> wrote:
>
> When unregistering a thermal zone device, update the cooling device in
> case the cooling device is activated by the current thermal zone.

I think that all cooling devices bound to the thermal zone being
removed need to be updated at this point?  Which is what the patch
really does IIUC.

It also avoids unbinding cooling devices that have not been bound to that zone.

> This fixes a problem that the frequency of ACPI processors are still
> limited after unloading ACPI thermal driver while ACPI passive cooling
> is activated.
>

Cc: stable@vger ?

> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/thermal/thermal_core.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index cfd4c1afeae7..9f120e3c9bf0 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1477,6 +1477,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>         const struct thermal_zone_params *tzp;
>         struct thermal_cooling_device *cdev;
>         struct thermal_zone_device *pos = NULL;
> +       struct thermal_instance *ti;
>
>         if (!tz)
>                 return;
> @@ -1497,9 +1498,22 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>

I would rearrange the code as follows.

>         /* Unbind all cdevs associated with 'this' thermal zone */
>         list_for_each_entry(cdev, &thermal_cdev_list, node) {
                    struct thermal_instance *ti;

> +               mutex_lock(&tz->lock);
> +               list_for_each_entry(ti, &tz->thermal_instances, tz_node) {

                            if (ti->cdev == cdev) {
                                    mutex_unlock(&tz->lock);
                                    goto unbind;
                            }
                    }
                    /* The cooling device is not used by this thermal zone. */
                    mutex_unlock(&tz->lock);
                    continue;

unbind:

>                 if (tz->ops->unbind) {
>                         tz->ops->unbind(tz, cdev);

                            /*
                             * The thermal instance for current
thermal zone has been
                             * removed, so update the cooling device
in case it has been
                             * activated by the thermal zone device going away.
                             */
                            mutex_lock(&cdev->lock);
                            __thermal_cdev_update(cdev);
                            mutex_unlock(&cdev->lock);

                            continue;
>                 }
>
>                 if (!tzp || !tzp->tbp)
