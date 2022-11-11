Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F07462609C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 18:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbiKKRms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 12:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiKKRmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 12:42:46 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593FD5BD76;
        Fri, 11 Nov 2022 09:42:45 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id 13so14225443ejn.3;
        Fri, 11 Nov 2022 09:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VKiFDFrGvFY7jf7NE0czH/WKiEwUDB9a+xmGwXkQe2c=;
        b=B+8WQ1QS9KNtMyYldqdTnFOsi+HOaE98nhS8N+nuIyPteS4fvPkofHsVLRq1/P2MFf
         03iSNwIm3cjngQjsoAp/Z/fzXjSjDoa0ADU3i69k6rD0OmNBqaQwzWTdF+vbgoeKymnD
         o7Si7RwqQl+m3Zuznq8qQuNoozQEY63BYu92G7oEi1F633c6FweYpQzSeuwKAk5yvSat
         cJUidRrYvFtcr7hPa7/xmGiBweMllENe9Cee8yAXp37uqIUnmijzeb2ZPtsPqHoeJYZX
         I0hTaEnzHuGdU7afvu0Vvx3677wCEbV1lp9kkfm5ClBzEdjABdY1yFEH4iztvwdWZuFt
         0MWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VKiFDFrGvFY7jf7NE0czH/WKiEwUDB9a+xmGwXkQe2c=;
        b=SE+oP084csUfgRvO6Bc/74bToxZ3h5EQC5J32ysj9KakI/UN2/a6JfSUb0tZFXAMUt
         wfZId7Z/hfhkEviwPBhpVEuEy0exW9iseWwe83DQlZ2FcvWX2/XdlfR0w5g9GOMkq6cK
         KdYKWY5zTpbeJvPEWu2BJcc8ZS/ETNLTwT+hgmRDbsnDiA+9OlzLfFdhaqSwbosv9MMB
         XKqX4JarUkq5uFao7a5Nj4/iCXFmkNCJQZ+YaZzgxD8dG8rdjIvbWzaJ+DJCCnIMjuym
         SDlCN7cMsRb7LAXtdD0sYXBEia5Ywa3QjB8Va+vU3BalX9+XBVe54b5Q+eEE6F35OO4I
         K4xg==
X-Gm-Message-State: ANoB5pndfYhV40YFxIVChiY4kO3nN9R9a88NWSOAYte5gaSAayQTp/8G
        4c1iDwmbSjtneqVhuKcTShjzs1OIkDLyBWQ2dILapiplywCeyw==
X-Google-Smtp-Source: AA0mqf57PNb1MFPBM8DzG5GIeAQIxnTNLRRX67K7+9R9zxppEzKWBMl+qlMUgbu01Lr5xf9f07mOPRiwbDlEiRQfuP8=
X-Received: by 2002:a17:907:98d0:b0:7ac:2e16:a8d3 with SMTP id
 kd16-20020a17090798d000b007ac2e16a8d3mr2835829ejc.667.1668188563688; Fri, 11
 Nov 2022 09:42:43 -0800 (PST)
MIME-Version: 1.0
References: <20221110010726.235601-1-dongchenchen2@huawei.com>
In-Reply-To: <20221110010726.235601-1-dongchenchen2@huawei.com>
From:   Jagath Jog J <jagathjog1996@gmail.com>
Date:   Fri, 11 Nov 2022 23:12:32 +0530
Message-ID: <CAM+2EuLVr3ncC3FomFMxQnBzdVnEU+gcjJ9Q9cKwz6W8OX5H=w@mail.gmail.com>
Subject: Re: [Patch] iio: accel: bma400: Fix memory leak in bma400_get_steps_reg()
To:     Dong Chenchen <dongchenchen2@huawei.com>
Cc:     dan@dlrobertson.com, jic23@kernel.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 6:37 AM Dong Chenchen <dongchenchen2@huawei.com> wrote:
>
> When regmap_bulk_read() fails, it does not free steps_raw,
> which will cause a memory leak issue, this patch fixes it.
>
> Fixes: d221de60eee3 ("iio: accel: bma400: Add separate channel for step counter")
> Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>

Reviewed-by: Jagath Jog J <jagathjog1996@gmail.com>

Thanks for catching this

Regards,
Jagath

> ---
>  drivers/iio/accel/bma400_core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> index ad8fce3e08cd..43976cf5a91b 100644
> --- a/drivers/iio/accel/bma400_core.c
> +++ b/drivers/iio/accel/bma400_core.c
> @@ -805,8 +805,10 @@ static int bma400_get_steps_reg(struct bma400_data *data, int *val)
>
>         ret = regmap_bulk_read(data->regmap, BMA400_STEP_CNT0_REG,
>                                steps_raw, BMA400_STEP_RAW_LEN);
> -       if (ret)
> +       if (ret) {
> +               kfree(steps_raw);
>                 return ret;
> +       }
>         *val = get_unaligned_le24(steps_raw);
>         kfree(steps_raw);
>         return IIO_VAL_INT;
> --
> 2.25.1
>
