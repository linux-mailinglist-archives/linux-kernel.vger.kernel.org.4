Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05A16F1E21
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 20:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346500AbjD1Siv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 14:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjD1Sit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 14:38:49 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537171BEB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 11:38:48 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-546de76c23eso130319eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 11:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682707127; x=1685299127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6b+Htt6CLQb89zu+TCed4Uelo19IvsWFLMs9XiUa7MQ=;
        b=fu45N3qU9YtD8VGGP9MFC2YqwcPCE/WQUJN6O/kveVsVfV0kr5P5qeU3r9o8tK58a9
         Jr76FCQqdD1bG2PUjPeqWeIFKfpGInorn/CuL5ryX3COAgbmpWvkv64p/S1r7SHO5M+U
         4ZNYCgp4NI4urSCgEzbDreZl1WSR+C5YVLkBlO2oxqgKsNPAb4L0LsNDE9oM8YcgnRBs
         eqFBSBZW7pXXHQT6tgVo1vKKUJISevpmveyibFTx4LbYuuou/D6t/IL/oHtQgung/b4j
         9iKl9lpc9yZJuLiQn+vUgzMRSTW/9gX5u6/UDyAeuVPoNKsjhU4SKFIRyK5G1/Yz31I6
         FPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682707127; x=1685299127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6b+Htt6CLQb89zu+TCed4Uelo19IvsWFLMs9XiUa7MQ=;
        b=lfxl8ytufXeJWU2UdckU3EA7is94yW0E8GpjfvxMWCpEouQPNZUTXZU008on10ndZJ
         g60ORkTSLNiR687KizqGnuzGB9m/zW1LpS1nze9aTYUjxVu23zbHY8Xzl7AnfvEkLDQi
         eI1lkiDeh0v0NjTp1BrcNeGPzp7egK+avORV1IOkYDCF01rUGKS3DpRiYSjcUyZr7uWa
         LEFHoJ5GvOKNO8wPpEHXjkLDpJuX8V8i4iTKe9DPvya+8nPh/zhS0+9bj6TR1Z66Q2I/
         iLl8xx/OvsCWVT7TmNAUfMoZGteZ9I0qlupnXKC2cQ+spoIrPd5qolXjU6R+V1sBlxm/
         jkJQ==
X-Gm-Message-State: AC+VfDwt8V/OqleWjYESJBM7em9zZZ3uO7ok0mFX9oFrJeBW7sxE0tKZ
        G92XslF8VPwU7YkgT1O8jd+2qYbE6ajS9Qytqik3QQ==
X-Google-Smtp-Source: ACHHUZ5C6UXIJImJC7x2BnIsepKsnuk8WixladYssB3eQmybOMYqJHcy2LP6lv5R4CyJFwMBkelofvcgzUPBWzyZHDg=
X-Received: by 2002:a05:6820:1b15:b0:547:8545:acaf with SMTP id
 bv21-20020a0568201b1500b005478545acafmr3192957oob.7.1682707127442; Fri, 28
 Apr 2023 11:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230427000152.1407471-1-biswarupp@google.com>
In-Reply-To: <20230427000152.1407471-1-biswarupp@google.com>
From:   Siarhei Vishniakou <svv@google.com>
Date:   Fri, 28 Apr 2023 11:38:36 -0700
Message-ID: <CAKF84v2Rw8xQv=m+ciL+n_uXhyAZWFmhYpgA63Q=DnVh5sbOsw@mail.gmail.com>
Subject: Re: [PATCH] Call input_set_timestamp for events injected using uinput
To:     Biswarup Pal <biswarupp@google.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        kernel-team@android.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Biswarup!

Just to add a bit of context: we were concerned with  breaking the
existing uinput usages where the caller might be setting an incorrect
value (since previously, that had no effect).
So the 10 second guard was added to fall back to the default behaviour
for those devices.

Reviewed-by: Siarhei Vishniakou <svv@google.com>

On Wed, Apr 26, 2023 at 5:03=E2=80=AFPM Biswarup Pal <biswarupp@google.com>=
 wrote:
>
> Currently, uinput doesn't use the input_set_timestamp API, so any
> event injected using uinput is not accurately timestamped in terms of
> measuring when the actual event happened. Hence, call the
> input_set_timestamp API from uinput in order to provide a more
> accurate sense of time for the event. Propagate only the timestamps
> which are a) positive, b) within a pre-defined offset (10 secs) from
> the current time, and c) not in the future.
>
> Signed-off-by: Biswarup Pal <biswarupp@google.com>
> ---
>  drivers/input/misc/uinput.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
> index f2593133e524..d98212d55108 100644
> --- a/drivers/input/misc/uinput.c
> +++ b/drivers/input/misc/uinput.c
> @@ -33,6 +33,7 @@
>  #define UINPUT_NAME            "uinput"
>  #define UINPUT_BUFFER_SIZE     16
>  #define UINPUT_NUM_REQUESTS    16
> +#define UINPUT_TIMESTAMP_ALLOWED_OFFSET_SECS 10
>
>  enum uinput_state { UIST_NEW_DEVICE, UIST_SETUP_COMPLETE, UIST_CREATED }=
;
>
> @@ -569,11 +570,40 @@ static int uinput_setup_device_legacy(struct uinput=
_device *udev,
>         return retval;
>  }
>
> +/*
> + * Returns true if the given timestamp is valid (i.e., if all the follow=
ing
> + * conditions are satisfied), false otherwise.
> + * 1) given timestamp is positive
> + * 2) it's within the allowed offset before the current time
> + * 3) it's not in the future
> + */
> +static bool is_valid_timestamp(const ktime_t timestamp)
> +{
> +       ktime_t zero_time;
> +       ktime_t current_time;
> +       ktime_t min_time;
> +       ktime_t offset;
> +
> +       zero_time =3D ktime_set(0, 0);
> +       if (ktime_compare(zero_time, timestamp) >=3D 0)
> +               return false;
> +
> +       current_time =3D ktime_get();
> +       offset =3D ktime_set(UINPUT_TIMESTAMP_ALLOWED_OFFSET_SECS, 0);
> +       min_time =3D ktime_sub(current_time, offset);
> +
> +       if (ktime_after(min_time, timestamp) || ktime_after(timestamp, cu=
rrent_time))
> +               return false;
> +
> +       return true;
> +}
> +
>  static ssize_t uinput_inject_events(struct uinput_device *udev,
>                                     const char __user *buffer, size_t cou=
nt)
>  {
>         struct input_event ev;
>         size_t bytes =3D 0;
> +       ktime_t timestamp;
>
>         if (count !=3D 0 && count < input_event_size())
>                 return -EINVAL;
> @@ -588,6 +618,10 @@ static ssize_t uinput_inject_events(struct uinput_de=
vice *udev,
>                 if (input_event_from_user(buffer + bytes, &ev))
>                         return -EFAULT;
>
> +               timestamp =3D ktime_set(ev.input_event_sec, ev.input_even=
t_usec * NSEC_PER_USEC);
> +               if (is_valid_timestamp(timestamp))
> +                       input_set_timestamp(udev->dev, timestamp);
> +
>                 input_event(udev->dev, ev.type, ev.code, ev.value);
>                 bytes +=3D input_event_size();
>                 cond_resched();
> --
> 2.40.1.495.gc816e09b53d-goog
>
