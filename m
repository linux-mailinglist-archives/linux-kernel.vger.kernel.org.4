Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AEC630C47
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 06:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbiKSFvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 00:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiKSFvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 00:51:23 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5BA8FB27
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 21:51:21 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id i9so4861185qki.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 21:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NYADKFfUKiUYt9pKWaup4dX2bzMkM0QGRAT1eGPqno=;
        b=HGRTPj9vM9aXazwb3zKhh5+QGoBJEBkl1pusx1Vc7lmJdwNDAhsYSgmDY3v3vXUgTG
         9lMhUXG3a+IS/MEsnO8YxC7CA9zTwUsb6p3KhMKRWWWJSoxFynmPwNtImbOxfIld8RGD
         9NO/PTV9QDtfUZV8MMmMF1yBqPDqBWT+QjUkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+NYADKFfUKiUYt9pKWaup4dX2bzMkM0QGRAT1eGPqno=;
        b=KZKK9nFHl4zxSMQFCYon34WI9hHrJpUBdzaE0wqAY6z+nN/beOdwg6DUL/DZ11pzwV
         H2qJUbh/ZU0tuOTIIdoq6o8i+LR6IZhJ7Cx3Z9Q1Q+ChWVDDVlIliUdAjgKOLhJC18gv
         0oj/dFpGu9PomVWY+F610jIGXK7J8KvK/XD1I7wbm1ymBrGXwT/pX90QkDoN3QCLo7Vb
         +iz2S2OtGlEPVdkdPHyFvKAEJ1FCL9NtOhY0SyjFggFmr87LGhZt++zZFacNKvRRBica
         HMxu2N4mZz4OUErNIlJ2F5nMcR/gH0MXbC/7QNtSFPmsf1e706LuuWZGxWc5Ql9l9lTd
         Glbg==
X-Gm-Message-State: ANoB5pmPMz1pCHfxxeMpA2NqZC8+yuvwKYI3xqOCvPEctyGWCevNj9YP
        +gR9CILyZ7/lvTnmg9/KC228r7Jb8Rrh0NGe2FJKM7YhtN6k5hDh
X-Google-Smtp-Source: AA0mqf5FYax0IOSEUurOeDD3qfk4TmY/gSXgXJaM8ZFQDcp9oSPrmb1hFazcYXxZGD8hJpmsI1FcWXPJBXDOyjmEBcw=
X-Received: by 2002:a05:620a:219c:b0:6fa:cbd7:6103 with SMTP id
 g28-20020a05620a219c00b006facbd76103mr92424qka.235.1668837081109; Fri, 18 Nov
 2022 21:51:21 -0800 (PST)
MIME-Version: 1.0
References: <20221118224540.619276-1-uwe@kleine-koenig.org> <20221118224540.619276-391-uwe@kleine-koenig.org>
In-Reply-To: <20221118224540.619276-391-uwe@kleine-koenig.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Sat, 19 Nov 2022 13:51:09 +0800
Message-ID: <CAJCx=g=7RMZyzmOecGG0F5ctArFa8Qsvyton8+2e1TaQ2gVg=g@mail.gmail.com>
Subject: Re: [PATCH 390/606] media: i2c/video-i2c: Convert to i2c's .probe_new()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Grant Likely <grant.likely@linaro.org>,
        Wolfram Sang <wsa@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-i2c@vger.kernel.org, kernel@pengutronix.de,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2022 at 6:47 AM Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.or=
g> wrote:
>
> From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>
> .probe_new() doesn't get the i2c_device_id * parameter, so determine
> that explicitly in the probe function.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Looks good to me.

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> ---
>  drivers/media/i2c/video-i2c.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/media/i2c/video-i2c.c b/drivers/media/i2c/video-i2c.=
c
> index f15ef2d13059..dddf9827b314 100644
> --- a/drivers/media/i2c/video-i2c.c
> +++ b/drivers/media/i2c/video-i2c.c
> @@ -757,9 +757,9 @@ static void video_i2c_release(struct video_device *vd=
ev)
>         kfree(data);
>  }
>
> -static int video_i2c_probe(struct i2c_client *client,
> -                            const struct i2c_device_id *id)
> +static int video_i2c_probe(struct i2c_client *client)
>  {
> +       const struct i2c_device_id *id =3D i2c_client_get_device_id(clien=
t);
>         struct video_i2c_data *data;
>         struct v4l2_device *v4l2_dev;
>         struct vb2_queue *queue;
> @@ -959,7 +959,7 @@ static struct i2c_driver video_i2c_driver =3D {
>                 .of_match_table =3D video_i2c_of_match,
>                 .pm     =3D &video_i2c_pm_ops,
>         },
> -       .probe          =3D video_i2c_probe,
> +       .probe_new      =3D video_i2c_probe,
>         .remove         =3D video_i2c_remove,
>         .id_table       =3D video_i2c_id_table,
>  };
> --
> 2.38.1
>
