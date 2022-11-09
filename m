Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3593E623340
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 20:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbiKITMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 14:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiKITMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 14:12:38 -0500
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D191FCE3;
        Wed,  9 Nov 2022 11:12:37 -0800 (PST)
Received: by mail-qv1-f49.google.com with SMTP id o8so12955644qvw.5;
        Wed, 09 Nov 2022 11:12:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ITcRl/8QQz+hLocoq0sl/MFdQo6RjgfiBVxNFpHYuY=;
        b=llfdEkBiS9VIKhEmVGQXb88IK2HE0G2GPOKuO27sJFWGmFw0kULz7fHRj5UY8jf0LM
         G0IkCh5Kiu6K/E/uTS7wNYPzN56+6I28fNnJlxisS95U6U+DEye0Fj5mNsHq7/S8RKWm
         lC3lNjIrUTQkWABaK2VYf8V/SB+q1zdXUMdUIHwXP1VAxivNB28DXpHb4ocGetv/+TzH
         efW9KWEGnNxu58iVnW59IKX6RcDQ5owtQ+wcIOdnPs5Z+kUVZJBbCw5kdm3/r8uS9fq4
         7Z9tmOCVw9T49+X5cuhZP2cckc3F+qkoiOUuvh8oCs+/nVw7sDx0bvmck34a/gcUWNEx
         k0bQ==
X-Gm-Message-State: ACrzQf0cJPoutgy1x9DNdJ+ec66q0D3rt9MnNnsZ1ftW8zvscb/mvXed
        3GppSDvX3kNnay+AXs9NbzqUT2aloWaPZCgxeq7EmBSz
X-Google-Smtp-Source: AMsMyM5cK0BAvTR9+Wm/DShnGZUULzmKjAgDlz8YmeriOq9eOow75PSvhjUZxHyuCPu6Js7uqSPfAvpRvYqS3Zy9Pkw=
X-Received: by 2002:a05:6214:f63:b0:4b8:c0bc:c43e with SMTP id
 iy3-20020a0562140f6300b004b8c0bcc43emr55978455qvb.119.1668021156462; Wed, 09
 Nov 2022 11:12:36 -0800 (PST)
MIME-Version: 1.0
References: <20221017130910.2307118-1-linux@roeck-us.net> <20221017130910.2307118-5-linux@roeck-us.net>
In-Reply-To: <20221017130910.2307118-5-linux@roeck-us.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Nov 2022 20:12:25 +0100
Message-ID: <CAJZ5v0i0gN-PnbAMDVxcGyWbWSTN0LCXvDNj_uhzYbSTxH=GGg@mail.gmail.com>
Subject: Re: [PATCH 4/9] thermal/core: Move parameter validation from
 __thermal_zone_get_temp to thermal_zone_get_temp
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
> All callers of __thermal_zone_get_temp() already validated the
> thermal zone parameters. Move validation to thermal_zone_get_temp()
> where it is actually needed.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/thermal/thermal_helpers.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
> index 3bac0b7a4c62..0161d5fb1cf2 100644
> --- a/drivers/thermal/thermal_helpers.c
> +++ b/drivers/thermal/thermal_helpers.c
> @@ -64,6 +64,20 @@ get_thermal_instance(struct thermal_zone_device *tz,
>  }
>  EXPORT_SYMBOL(get_thermal_instance);
>
> +/**
> + * __thermal_zone_get_temp() - returns the temperature of a thermal zone
> + * @tz: a valid pointer to a struct thermal_zone_device
> + * @temp: a valid pointer to where to store the resulting temperature.
> + *
> + * When a valid thermal zone reference is passed, it will fetch its
> + * temperature and fill @temp.
> + *
> + * Both tz and tz->ops must be valid pointers when calling this function,
> + * and the tz->ops->get_temp callback must be provided.
> + * The function must be called under tz->lock.
> + *
> + * Return: On success returns 0, an error code otherwise
> + */

I would mention adding the kerneldoc in the patch changelog.

>  int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
>  {
>         int ret = -EINVAL;
> @@ -73,9 +87,6 @@ int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
>
>         lockdep_assert_held(&tz->lock);
>
> -       if (!tz || IS_ERR(tz) || !tz->ops->get_temp)
> -               return -EINVAL;
> -
>         ret = tz->ops->get_temp(tz, temp);
>
>         if (IS_ENABLED(CONFIG_THERMAL_EMULATION) && tz->emul_temperature) {
> @@ -114,7 +125,16 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
>  {
>         int ret;
>
> +       if (!tz || IS_ERR(tz))

IS_ERR_OR_NULL() ?

> +               return -EINVAL;
> +
>         mutex_lock(&tz->lock);
> +
> +       if (!tz->ops->get_temp) {
> +               ret = -EINVAL;
> +               goto unlock;
> +       }
> +
>         if (!device_is_registered(&tz->device)) {
>                 ret = -ENODEV;
>                 goto unlock;
> --
