Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5D06455C6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 09:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiLGIuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 03:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiLGIuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 03:50:16 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C873C6D2;
        Wed,  7 Dec 2022 00:47:08 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id o12so12211875qvn.3;
        Wed, 07 Dec 2022 00:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V30zag4jGb0ZpXyhwdO8YgSZcVeVVW3c/teWpK3rRf4=;
        b=pFnwWZBxCtc1w/um5Vhzmy2cpQiPZE9TWMnsW29vdudN5IysoV5F5IMK5G98Vrb4Tb
         vCD+6VsKKqV2gXtaGsQ8ydrb+zhLvSWpmLf9AA1HXVtds/hMBSl86hI/gRaCXot7wtLk
         ZKqCkeIYAJ6nmrDk9vOBeIKz9styWzTnkw6WBIs2EdaWwXdi4r5J1bHrLR2TbyQvCHf/
         QamcNRt2IWLDNHuGeUp95PS2UkTNxIGrDjSF+Ar2KiBEbvza/8N28sFoz4SQBQheFIY6
         2n33mWta5erCxRrz2eR753YAPWo6PFBmX6QAwHPwsKvpUBFQzOIXI3kJdLwjX11Yd8oW
         O3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V30zag4jGb0ZpXyhwdO8YgSZcVeVVW3c/teWpK3rRf4=;
        b=Xv/vnXAEhPzZlcppCfT+oYNKdvVf8+KaFkt5K2eKrDJBzhQyrtci1BYdxzXkIIERvM
         toIDYaksEhzpsmdm5GpcnVXZGCTiYtQmI+/R7wd5mYvkpmvOg3p7n51oAbM3/2IlLDbK
         sOHkowu+3Ockdgvt9QUClSXnCPST+RsUjIttNQP9QGw88QrETOIu8+geNZoKcVEUdHUT
         kURsgJchn3Tks9aRywmabPS2ok8PRmsnIXRpLa39h6SaIReE3OdME65IEPGcVm+HDRk6
         r/t2vAlB/m3/dfEmH1sUn5lfTZaDfoxh8SEoHha8kGgrGxKyKOEjiQK9wiBvANVQXMmA
         uopA==
X-Gm-Message-State: ANoB5pnWLNDhfwMFn0Vww3BqTlCWmpSIYLSnLq8YBZzmW3lUBlhBNiq5
        HC4mOp0ishLkrreVzz80tn2bO2wThWvcv5yE3JH+b4s06Ntazg==
X-Google-Smtp-Source: AA0mqf533yYEBWN/Kcf0G3MeIrTwMbNZyuL8AZ+Wg1/KIbkU95UJv5O9jvKKfK6Geoc2vemFieaxVM3AIPlisMlSZms=
X-Received: by 2002:a05:6214:5cc2:b0:4c6:a622:cb4f with SMTP id
 lk2-20020a0562145cc200b004c6a622cb4fmr72362090qvb.97.1670402809707; Wed, 07
 Dec 2022 00:46:49 -0800 (PST)
MIME-Version: 1.0
References: <202212071549349412843@zte.com.cn>
In-Reply-To: <202212071549349412843@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 7 Dec 2022 10:46:14 +0200
Message-ID: <CAHp75VfJx84-J2GdOWQAPAtMhPVS3X-dEuHYQqyP4a0WjDsgdQ@mail.gmail.com>
Subject: Re: [PATCH] iio: magnetometer: bmc150_magn: Convert to use
 sysfs_emit_at() API
To:     ye.xingchen@zte.com.cn
Cc:     jic23@kernel.org, lars@metafoo.de, linmq006@gmail.com,
        u.kleine-koenig@pengutronix.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 7, 2022 at 9:49 AM <ye.xingchen@zte.com.cn> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmai.com>

> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/iio/magnetometer/bmc150_magn.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
> index 06d5a1ef1fbd..1398684a7f30 100644
> --- a/drivers/iio/magnetometer/bmc150_magn.c
> +++ b/drivers/iio/magnetometer/bmc150_magn.c
> @@ -598,8 +598,7 @@ static ssize_t bmc150_magn_show_samp_freq_avail(struct device *dev,
>         for (i = 0; i < ARRAY_SIZE(bmc150_magn_samp_freq_table); i++) {
>                 if (bmc150_magn_samp_freq_table[i].freq > data->max_odr)
>                         break;
> -               len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
> -                                bmc150_magn_samp_freq_table[i].freq);
> +               len += sysfs_emit_at(buf, len, "%d ", bmc150_magn_samp_freq_table[i].freq);
>         }
>         /* replace last space with a newline */
>         buf[len - 1] = '\n';
> --
> 2.25.1



-- 
With Best Regards,
Andy Shevchenko
