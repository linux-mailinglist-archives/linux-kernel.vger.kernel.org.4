Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0526D623354
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 20:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiKITT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 14:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiKITTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 14:19:25 -0500
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4433A1B3;
        Wed,  9 Nov 2022 11:19:24 -0800 (PST)
Received: by mail-qv1-f44.google.com with SMTP id w10so12973631qvr.3;
        Wed, 09 Nov 2022 11:19:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jrQi34q0LM/jTR2NDgEHPDmLWCBKJGinUDccPqdXWHU=;
        b=Up1sbGyJNBxWO+//y5q8mnIyXHUcud8smVX1Rj1dyIlxZX1D9XKdT0jHyLNNqM/6M5
         p9Anfg3GYi3s4Q2Qi/u/RWS/tGBnF0VIBIZuojfmTSwY2ZlIeiPSFBAfQJXTIrYJbPrZ
         Madh00eDH6wvuCX4B4x7OzdJxxbNmiyrLY87k91w04/ixAy0i54PN5P2Hcoi5UK0BJ7H
         NhB0dywZqSWQt2CI98QFeeWjNcw40RN2oYxD1mbxoqhP1sXpLoWChzy/COSGpTZExGbe
         Jg1SX0G0irtBJYrAQeNgYafiVFGJHeYlw/gWGIKkwIX2TTR71ztnDCF7Rb2X3yrxhBuY
         XnIA==
X-Gm-Message-State: ACrzQf1f++5YRi0CP8aVt6LfyX/qTMgYevH5r/LfGnr8NTVMA3dz4zQt
        W2+uqbbIMQHjXMlcj0uvBD5vDrYuBDUKQCeZjrs=
X-Google-Smtp-Source: AMsMyM4HHJ65z2pm+kE7cDgrVxcJl9RsLdlSFyrJPMX1bR9dvZjbdlJdotYGJwL+3bJGt2OLzgIJInNlX/ZI/nS44cw=
X-Received: by 2002:a0c:c684:0:b0:4bb:fc53:5ad9 with SMTP id
 d4-20020a0cc684000000b004bbfc535ad9mr47289132qvj.3.1668021563859; Wed, 09 Nov
 2022 11:19:23 -0800 (PST)
MIME-Version: 1.0
References: <20221017130910.2307118-1-linux@roeck-us.net> <20221017130910.2307118-7-linux@roeck-us.net>
In-Reply-To: <20221017130910.2307118-7-linux@roeck-us.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Nov 2022 20:19:13 +0100
Message-ID: <CAJZ5v0hMbzEdLecy_OWquOqdauBc1nsN7Q9mPkt2tOU4nEpHVw@mail.gmail.com>
Subject: Re: [PATCH 6/9] thermal/core: Protect hwmon accesses to thermal
 operations with thermal zone mutex
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, Oct 17, 2022 at 3:09 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> In preparation to protecting access to thermal operations against thermal
> zone device removal, protect hwmon accesses to thermal zone operations
> with the thermal zone mutex. After acquiring the mutex, ensure that the
> thermal zone device is registered before proceeding.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/thermal/thermal_hwmon.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
> index f53f4ceb6a5d..33bfbaed4236 100644
> --- a/drivers/thermal/thermal_hwmon.c
> +++ b/drivers/thermal/thermal_hwmon.c
> @@ -77,11 +77,19 @@ temp_crit_show(struct device *dev, struct device_attribute *attr, char *buf)
>         int temperature;
>         int ret;
>
> +       mutex_lock(&tz->lock);
> +
> +       if (!device_is_registered(&tz->device)) {
> +               ret = -ENODEV;
> +               goto unlock;
> +       }
> +
>         ret = tz->ops->get_crit_temp(tz, &temperature);

Again, I would do it this way:

        if (device_is_registered(&tz->device))
                ret = tz->ops->get_crit_temp(tz, &temperature);
        else
                ret = -ENODEV;

And I wouldn't change the code below (the ternary operator is out of
fashion in particular).

> -       if (ret)
> -               return ret;
>
> -       return sprintf(buf, "%d\n", temperature);
> +unlock:
> +       mutex_unlock(&tz->lock);
> +
> +       return ret ? ret : sprintf(buf, "%d\n", temperature);
>  }
>
>
> --
