Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F0670BB19
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjEVLF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjEVLFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:05:24 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3C830F2;
        Mon, 22 May 2023 04:00:20 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-75b0df81142so94240985a.2;
        Mon, 22 May 2023 04:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684753140; x=1687345140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fvYEEaFxIdJ1ctjBoNsSe7YJW7m1yyULGgSkldRgms=;
        b=bV+gk4w01kvKXq3uxQ1aw/ILIKqaedH4DBgplPDtCAPc8RAEjRhKPQpuNUzgXluDkW
         eyiO6NjXhsc41pP8IpfTkuz9aFlzA+mEODb5EkY74LZtUDrU/6BdXkkiV5cw+vzFfSSy
         RR7uzvljrxGrWWK3WyyUDfVulzB1avH+5tvXDwuw6PoMAFsUgdDMOp7x4g/HQ09Nnh9S
         ChwE5xpXV/kDp60/OSBGp/81sPXQRy98Mkz76OaTMA9rKf1T+4VLYUlK42L26YYPsUZD
         oP70Vn0TWgKK/Oocs5pNd7J04wDePClWEc/7fkEqbjJB2w9/5o4w7k3kEqTHvwR8X+Hf
         TuUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684753140; x=1687345140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5fvYEEaFxIdJ1ctjBoNsSe7YJW7m1yyULGgSkldRgms=;
        b=HO2Ya9+uuahr6TcKosy+DcW3m2f0FvIgZXUVYdtfNuMHDRR8Gu3xe0Ilf69oU9SDM1
         gZRQpF0L9pslBepycBuYeHAhmxXuJl4qMxbAzQSYnJbf0CGCKQceeLl0xj7d9vDT/xr3
         REio8PALdgn+G9rs4Y+vtodwytigURAV3zQFMR/Ds1r7J/NQaqkU2iz258OqA2pY/8Os
         lDZR9/PaZvSo6SQkSkijpvbk7LskivJeHUAOTKeE7r0Kzxk/hfbAX+HzteB+t/8xPtlq
         Tknicw1tZNSoih3Scji2dJ1D6cZu8SW2OpwdM1fH3tzzptv4MsoAttGjc2zupgm3OLpv
         9Ybg==
X-Gm-Message-State: AC+VfDwFH1N8TJNUaVzc5F1ImSKy9SJFAFfxZ7ysgCOMH0VXv3++9Ho+
        mC10k+GBxuIQuDcCLN4NtJKldvgNo/mHVdw+ff3D4XexUzY=
X-Google-Smtp-Source: ACHHUZ4IhOsWxTmHezMj1Zil6Ulgdl4RITYTYZi9OkO6+om0HV48MoRQRYTN+Hvs67DNKz/f1qsWrZQWm6uoqzOA4Os=
X-Received: by 2002:a05:620a:2b95:b0:75b:23a0:de92 with SMTP id
 dz21-20020a05620a2b9500b0075b23a0de92mr124875qkb.16.1684753139687; Mon, 22
 May 2023 03:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230521225901.388455-1-contact@artur-rojek.eu> <20230521225901.388455-3-contact@artur-rojek.eu>
In-Reply-To: <20230521225901.388455-3-contact@artur-rojek.eu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 22 May 2023 13:58:23 +0300
Message-ID: <CAHp75Vfj_2WJdcn4TC2SesUrWFmyhXHujS9P8O3JXdFcAb=WeQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] input: joystick: Fix buffer data parsing
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        linux-mips@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 1:59=E2=80=AFAM Artur Rojek <contact@artur-rojek.eu=
> wrote:
>
> Don't try to access buffer data of a channel by its scan index. Instead,
> calculate its offset in the buffer.
>
> This is necessary, as the scan index of a channel does not represent its
> position in a buffer - the buffer will contain data for enabled channels
> only, affecting data offsets and alignment.
>
> While at it, also fix minor style issue in probe.

a minor
the probe

> Reported-by: Chris Morgan <macromorgan@hotmail.com>
> Closes: https://lore.kernel.org/linux-input/20220408212857.9583-1-macroal=
pha82@gmail.com/

What is this tag? Anything documented? Otherwise use BugLink or Link.

...

>         struct adc_joystick_axis *axes;
>         struct iio_channel *chans;
> +       int *offsets;

Why not unsigned? I.o.w. is there any meaning for negative values?

>         int num_chans;
>         bool polled;

...

> +               off =3D joy->offsets[i];

> +

Move this blank line to be before the previous line.

> +               if (off < 0)
> +                       return -EINVAL;

...

>                 case 1:
> -                       val =3D ((const u8 *)data)[idx];
> +                       val =3D *chan_data;

Might be also

   get_unaligned((const u8 *)chan_data);

And with all this (see below) the chan_data actually can be declared
as const void *.

>                         break;
>                 case 2:
> -                       data_u16 =3D (const u16 *)data + idx;
> -
>                         /*
>                          * Data is aligned to the sample size by IIO core=
.
>                          * Call `get_unaligned_xe16` to hide type casting=
.
>                          */
>                         if (endianness =3D=3D IIO_BE)
> -                               val =3D get_unaligned_be16(data_u16);
> +                               val =3D get_unaligned_be16(chan_data);
>                         else if (endianness =3D=3D IIO_LE)
> -                               val =3D get_unaligned_le16(data_u16);
> +                               val =3D get_unaligned_le16(chan_data);
>                         else /* IIO_CPU */
> -                               val =3D *data_u16;
> +                               val =3D *(const u16 *)chan_data;

This probably needs to be

   get_unaligned((const u16 *)chan_data);

for the sake of consistency with the above.

>                         break;
>                 default:
>                         return -EINVAL;

...

> +static int adc_joystick_si_cmp(const void *a, const void *b, const void =
*priv)
> +{
> +       const struct iio_channel *chans =3D priv;
> +
> +       return chans[*(int *)a].channel->scan_index -
> +              chans[*(int *)b].channel->scan_index;

Discarding const?

> +}

...

> +       offsets =3D kmalloc_array(count, sizeof(int), GFP_KERNEL);

sizeof(*offsets)

> +       if (!offsets)
> +               return ERR_PTR(-ENOMEM);

...

> +       si_order =3D kmalloc_array(count, sizeof(int), GFP_KERNEL);

sizeof(*si_order)

> +       if (!si_order) {
> +               kfree(offsets);
> +               return ERR_PTR(-ENOMEM);
> +       }

...

> +       /* Channels in buffer are ordered by scan index. Sort to match th=
at. */

the buffer

> +       sort_r(si_order, count, sizeof(int), adc_joystick_si_cmp, NULL, c=
hans);

sizeof(*si_order) ?

sizeof(int) is a bit odd, the above will tell better without even
knowing the sort_r() parameters what it is about.

...

> +       for (i =3D 0; i < count; ++i) {
> +               idx =3D si_order[i];
> +               ch =3D chans[idx].channel;
> +               si =3D ch->scan_index;
> +
> +               if (si < 0 || !test_bit(si, indio_dev->active_scan_mask))=
 {
> +                       offsets[idx] =3D -1;
> +                       continue;
> +               }
> +
> +               /* Channels sharing scan indices also share the samples. =
*/
> +               if (idx > 0 && si =3D=3D chans[idx - 1].channel->scan_ind=
ex) {
> +                       offsets[idx] =3D offsets[idx - 1];
> +                       continue;
> +               }
> +
> +               offsets[idx] =3D offset;

> +               length =3D ch->scan_type.storagebits / 8;

BITS_PER_BYTE ?

> +               if (ch->scan_type.repeat > 1)
> +                       length *=3D ch->scan_type.repeat;

> +               /* Account for channel alignment. */
> +               if (offset % length)
> +                       offset +=3D length - (offset % length);

Would one of ALIGN() / rounddown / etc work here?

> +               offset +=3D length;
> +       }

...

> +       joy->offsets =3D adc_joystick_get_chan_offsets(joy->chans,
> +                                                    joy->num_chans);
> +       if (IS_ERR(joy->offsets)) {
> +               dev_err(devp, "Unable to allocate channel offsets\n");

> +               return PTR_ERR(joy->offsets);
> +       }
> +
> +       return 0;

return PTR_ERR_OR_ZERO() ?

...

>                 error =3D devm_add_action_or_reset(dev, adc_joystick_clea=
nup,
>                                                  joy->buffer);
> -               if (error)  {
> +               if (error) {
>                         dev_err(dev, "Unable to add action\n");
>                         return error;
>                 }

Unrelated change.

--=20
With Best Regards,
Andy Shevchenko
