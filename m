Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1726455C4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 09:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiLGIuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 03:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiLGItp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 03:49:45 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4858F48740;
        Wed,  7 Dec 2022 00:46:48 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id j16so238947qtv.4;
        Wed, 07 Dec 2022 00:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2BID/s2nTzoU7gNYqmQYkWu5p1iupYkuNutSdWuRs2M=;
        b=MycO8Zdu9gSKF/jTVFk7Xq5h+NImGEcjs5rnTLGxFAypfrGSwo/ksJALEo82wLrTNa
         DAk4vlpVquoHcQ68X4NrKswWH3Lf+UnWuL3xMv6Du4fEWbUUtJuHhI35qrI8EPYloS6r
         0umlIDkZinyBvw0QTy8smXJoRtKS47UxTS1w4AigN4PGooIlVZS/hzbRA03rFlq0NZJH
         3WIgWUc8SY/Xjv/xZqaWQNw6YDHcJywuWv6GSg5h7zpuA1dYcW+QWZnx8yOfhFLvNLTP
         pqdS+VrCC20BzmWguaPsHveT9WVPjN2NTSBscG/CQeMcsiyjd8DDOEhpaX0gKM8iBIor
         EDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2BID/s2nTzoU7gNYqmQYkWu5p1iupYkuNutSdWuRs2M=;
        b=6tDuGVLXfcdMZPg/jmwcuOAoTD/5maGVx6v3GKa2A2t0shBpqQaW8SS9fSbhm+CEHM
         +856lrs0DEO3kbd8CijV9YKV/gAQdptJhLAzDiLa6UMmXXU0VQwc6DSxwsffgl8B5xyH
         iDlcP7gdNgQR4DzvdnOy3qWmrIMgj3iq9FIa+/l0fLLgJ2vgVJmeiEaw6WZq4GS5M9t2
         HnZk8ICqkhjFY0Ebp4MZjiz/zbwuGtpfkhF/hMK4M5VAQAdsX+YSFfZjAlI9o5aCdFZ4
         104jrnIJUartdD4hnlsITN2V+Tm/FsI+5CvHdnRwjQDT/UaF4+7kNV2pB1vnD5WlTGCi
         K0RA==
X-Gm-Message-State: ANoB5pk2X2CIwfZzc3QhGqnxRo8UYfOmBfP0hgJ/sqDPbOpv178KtZru
        qz1XpjV3SYV2Rf8GUH1uz+BbdMZQRkjkOupbSmc=
X-Google-Smtp-Source: AA0mqf66nlSIIi+EqAGzHnusGYVfUMKFrSv76XNOmScR/p/uOWXAdyrAqYmN4UgouEBpINELH3v9ISeC1g6runEZGB8=
X-Received: by 2002:ac8:738c:0:b0:3a7:f3f8:2bea with SMTP id
 t12-20020ac8738c000000b003a7f3f82beamr655463qtp.195.1670402795558; Wed, 07
 Dec 2022 00:46:35 -0800 (PST)
MIME-Version: 1.0
References: <202212071551017192888@zte.com.cn>
In-Reply-To: <202212071551017192888@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 7 Dec 2022 10:45:59 +0200
Message-ID: <CAHp75Vf7Z-ggKryNjHynCo6XgEy=qXq9JY5sXq4Mi_3TiUwhRQ@mail.gmail.com>
Subject: Re: [PATCH] iio: magnetometer: hmc5843: Convert to use
 sysfs_emit_at() API
To:     ye.xingchen@zte.com.cn
Cc:     jic23@kernel.org, lars@metafoo.de, jiangjian@cdjrlc.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Dec 7, 2022 at 9:51 AM <ye.xingchen@zte.com.cn> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmai.com>

> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/iio/magnetometer/hmc5843_core.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/magnetometer/hmc5843_core.c b/drivers/iio/magnetometer/hmc5843_core.c
> index c5521d61da29..134f6045e24a 100644
> --- a/drivers/iio/magnetometer/hmc5843_core.c
> +++ b/drivers/iio/magnetometer/hmc5843_core.c
> @@ -274,9 +274,9 @@ ssize_t hmc5843_show_samp_freq_avail(struct device *dev,
>         int i;
>
>         for (i = 0; i < data->variant->n_regval_to_samp_freq; i++)
> -               len += scnprintf(buf + len, PAGE_SIZE - len,
> -                       "%d.%d ", data->variant->regval_to_samp_freq[i][0],
> -                       data->variant->regval_to_samp_freq[i][1]);
> +               len += sysfs_emit_at(buf, len, "%d.%d ",
> +                                    data->variant->regval_to_samp_freq[i][0],
> +                                    data->variant->regval_to_samp_freq[i][1]);
>
>         /* replace trailing space by newline */
>         buf[len - 1] = '\n';
> @@ -335,8 +335,7 @@ static ssize_t hmc5843_show_scale_avail(struct device *dev,
>         int i;
>
>         for (i = 0; i < data->variant->n_regval_to_nanoscale; i++)
> -               len += scnprintf(buf + len, PAGE_SIZE - len,
> -                       "0.%09d ", data->variant->regval_to_nanoscale[i]);
> +               len += sysfs_emit_at(buf, len, "0.%09d ", data->variant->regval_to_nanoscale[i]);
>
>         /* replace trailing space by newline */
>         buf[len - 1] = '\n';
> --
> 2.25.1



-- 
With Best Regards,
Andy Shevchenko
