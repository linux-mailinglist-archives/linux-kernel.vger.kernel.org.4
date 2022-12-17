Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493B164F8DC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 12:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiLQLoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 06:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLQLoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 06:44:19 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B8713E86;
        Sat, 17 Dec 2022 03:44:17 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id z12so4729073qtv.5;
        Sat, 17 Dec 2022 03:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lB8JW0XG9L04FrmEfB+XTkr4c7bEVDxGvwgTSNbUoEw=;
        b=mghHDdgAnnsgxvGgaP7rrvrwQUQw5EO03iSFLZ32EvIVmRHV10rXNz1h+57ORw09EQ
         HubrwFgmNsCJKL2WHg47trOmu6FgxM8wlf85HK9YNbu18COWrSeE3BXAVFOm7NDRjJe9
         oP/CTaG+JZvsmyTsJ2T+ijORpZ8s8neUSAHFIloe0sCn3GxDVY+jYxI/WqSt2S618+1i
         xbTCju0+zRiuotQkd2uVQuZuEiJ1yhuXqahEuBl+8GpRQaE/0/8vawiJcI4B8mc4HUUD
         Y2SzHB2QVfBSzUqTpOsq1asaaDvIw0OPz0yYeUKDMUZmdxMSJd/W8rz+ZaLe2CihkDGW
         L/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lB8JW0XG9L04FrmEfB+XTkr4c7bEVDxGvwgTSNbUoEw=;
        b=yvcihB7NTt6vHWrQB6JjZgA/pMaodQanCw1jAQtxC6wdMMUxThwp7JJPgJCVFBSqnU
         3ECVBZ7k16IibFcYU1Yuh92jwVB7URtfBKcgW+gPYHB88G5jDxnuaxpT11jS6yi/vqtc
         NbmKCZpow7MVDQIyymkdoiDKsRNVOfHOt/fFKeFwMG3JHjrWhD1/cKQBwnpOUKzVVs7e
         u4sm1o09oEP3eLo6eHL/xyj3Cynyzf15ywHXGN99RSo5mA5FKLFf4n4Vo4Dygg7X07va
         4rdmJgVOupzxD+GauQFQJdRsAsNEaziq9269uSqVfd7sLNR6bDN6J2qqbLpQDFAH5v/M
         cQew==
X-Gm-Message-State: ANoB5pmVfkN9OklMF+YESRDdzhffdp8PFSyEEtZAAIJIkt9FT/6/lQ3m
        FE4K9Nw6iz6AsZqCqyeNbK9Xzo7ZhFsUukuqYfqdT1AL9WY0X7vN
X-Google-Smtp-Source: AA0mqf5aU4y2ms+Gj8NLQJsj3yg4gwh+yfuzMG/wMwuMaWT6z9kPDBmnna1KKVe6/IlKgkUdPTDU99534S74VFzkd3w=
X-Received: by 2002:ac8:44a9:0:b0:3a7:ed31:1b2e with SMTP id
 a9-20020ac844a9000000b003a7ed311b2emr9899847qto.429.1671277456558; Sat, 17
 Dec 2022 03:44:16 -0800 (PST)
MIME-Version: 1.0
References: <Y5uN9Rr3v1uWH765@mail.google.com> <Y5z4Og3XmCGQwTO9@mail.google.com>
In-Reply-To: <Y5z4Og3XmCGQwTO9@mail.google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 17 Dec 2022 13:43:40 +0200
Message-ID: <CAHp75VeNcPjngJcF96Y9hV=Y+NeaGadSMGMvgCTD6kdBi=+9fg@mail.gmail.com>
Subject: Re: [PATCH v3] [next] pcmcia: synclink_cs: replace 1-element array
 with flex-array member
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Haowen Bai <baihaowen@meizu.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
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

On Sat, Dec 17, 2022 at 12:59 AM Paulo Miguel Almeida
<paulo.miguel.almeida.rodenas@gmail.com> wrote:
>
> One-element arrays are deprecated, and we are replacing them with
> flexible array members instead. So, replace one-element array with
> flexible-array member in struct RXBUF and refactor the rest of the code
> accordingly. While at it, fix an edge case which could cause
> rx_buf_count to be 0 when max_frame_size was set to the maximum
> allowed value (65535).
>
> It's worth mentioning that struct RXBUF was allocating 1 byte "too much"
> for what is required (ignoring bytes added by padding).
>
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].

...

>  static int rx_alloc_buffers(MGSLPC_INFO *info)
>  {
>         /* each buffer has header and data */
> -       info->rx_buf_size = sizeof(RXBUF) + info->max_frame_size;
> +       if (check_add_overflow(sizeof(RXBUF), info->max_frame_size, &info->rx_buf_size))
> +               return -EINVAL;
>
> -       /* calculate total allocation size for 8 buffers */
> -       info->rx_buf_total_size = info->rx_buf_size * 8;

> +       /* try to alloc as many buffers that can fit within RXBUF_MAX_SIZE (up to 8) */
> +       if (check_mul_overflow(info->rx_buf_size, 8, &info->rx_buf_total_size))
> +               return -EINVAL;

This check is implied by kcalloc(). But to make it effective we
probably need to get a count first.

> -       /* limit total allocated memory */
> -       if (info->rx_buf_total_size > 0x10000)
> -               info->rx_buf_total_size = 0x10000;
> +       if (info->rx_buf_total_size > RXBUF_MAX_SIZE)
> +               info->rx_buf_total_size = RXBUF_MAX_SIZE;

If max_frame_size > 8192 - sizeof(RXBUF), we bump into this condition...

>         /* calculate number of buffers */
>         info->rx_buf_count = info->rx_buf_total_size / info->rx_buf_size;

...which means that rx_buf_count < 8...
(and if max_frame_size > RXBUF_MAX_SIZE - sizeof(RXBUF), count becomes
0, I don't know if below clamp_val() is the only place to guarantee
that)

> -       info->rx_buf = kmalloc(info->rx_buf_total_size, GFP_KERNEL);
> +       info->rx_buf = kcalloc(info->rx_buf_count, info->rx_buf_size, GFP_KERNEL);

...hence rx_buf size will be less than rx_buf_total_size.

That is probably not an issue per se, but I'm wondering if the
(bigger) value of rx_buf_total_size is the problem further in the
code.

>         if (info->rx_buf == NULL)
>                 return -ENOMEM;

Maybe something like

static int rx_alloc_buffers(MGSLPC_INFO *info)
{
    /* Prevent count from being 0 */
    if (->max_frame_size > MAX_FRAME_SIZE)
        return -EINVAL;
    ...
   count = ...;
   ...
   rx_total_size = ...
   rx_buf = kcalloc(...);

Then you don't need to check overflow with check_add_overflow() and
check_mul_overflow() will be inside the kcalloc.

...

> -       if (info->max_frame_size < 4096)
> -               info->max_frame_size = 4096;
> -       else if (info->max_frame_size > 65535)
> -               info->max_frame_size = 65535;
> +       if (info->max_frame_size < MGSLPC_MIN_FRAME_SIZE)
> +               info->max_frame_size = MGSLPC_MIN_FRAME_SIZE;
> +       else if (info->max_frame_size > MGSLPC_MAX_FRAME_SIZE)
> +               info->max_frame_size = MGSLPC_MAX_FRAME_SIZE;

You can use clamp_val() macro here.

-- 
With Best Regards,
Andy Shevchenko
