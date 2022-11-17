Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCF962D055
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 02:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239004AbiKQBAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 20:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238704AbiKQA75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 19:59:57 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7A06AED4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:59:51 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id f18so1363761ejz.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7IItaZa/7I4VBu5cw0wrKUsh/hbQDFMwGlkpESbfAao=;
        b=HAD+QNbZhmm80gWWfMxazQiOdxU/8OoWGwpppi16ividblCxYrow2hz0E0zZ7AhQ0z
         cJqUTprf41aF4MbLXaLFlbvRQJVq6IL9gsK+Kqxa/h2queVIuT30rA6VyDlCgXIBzNyT
         qslBCis6l11GbiAG8lz7dScccivWN8QaYUE08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7IItaZa/7I4VBu5cw0wrKUsh/hbQDFMwGlkpESbfAao=;
        b=WrgqmdoB6xx6tUc6fVs97/EHR6SdTPwaOmgwkUuVtq8tJrMUCy7h5fc6wFjnptu1QF
         nL6b16KDnCw5K/g4WgQMWJ+v/tRwOGnZHUOTuHfARBbVhDOAb6cCx0xnIS8AomVeAMFI
         /UDSpwmRJqWzC0CRxuX0YznJW3hEkVJ0bXDIUsaiIJyCGr/FpLc3KHUpa2wGnwbazIb6
         1Gs4KlEpspwvwqsLT8EHMWZdw7YrJ9IECGNeRJ9TuonuhGNdK3qFLIFGS6x/2Zk8Ya58
         RN+alphoQ3FkBXKeI5WnHrgoWep9yPXtYleJU1aN6MHKKD3LRfEWiGtjDKgJ+H7ZdNp1
         TyGA==
X-Gm-Message-State: ANoB5pkL76NGUwpeysFtIPqGe5kaLnF0u2kxXwjKq2jwO0F++ffPsS/o
        V37mf37pHI+58Ji+MkvmZUoTR7itwoA3nakW
X-Google-Smtp-Source: AA0mqf6IlnzWW/ChDvuq+R1rg/xLpa1JolTaH+QAeF2Pod0XpJwBH6X7iHqDRgNiWJPiaOCrhYCP9g==
X-Received: by 2002:a17:906:a418:b0:7a5:e944:9e48 with SMTP id l24-20020a170906a41800b007a5e9449e48mr323674ejz.109.1668646789331;
        Wed, 16 Nov 2022 16:59:49 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id 13-20020a170906318d00b007822196378asm7574170ejy.176.2022.11.16.16.59.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 16:59:48 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id z14so410229wrn.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:59:47 -0800 (PST)
X-Received: by 2002:adf:fb4c:0:b0:236:5270:735e with SMTP id
 c12-20020adffb4c000000b002365270735emr35889wrs.659.1668646787360; Wed, 16 Nov
 2022 16:59:47 -0800 (PST)
MIME-Version: 1.0
References: <20221116162152.193147-1-john.ogness@linutronix.de> <20221116162152.193147-36-john.ogness@linutronix.de>
In-Reply-To: <20221116162152.193147-36-john.ogness@linutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 16 Nov 2022 16:59:35 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WHEjpL1VYnLRp9Vy300Xd3Tu=u3MOo_rvHCABDTsQFPA@mail.gmail.com>
Message-ID: <CAD=FV=WHEjpL1VYnLRp9Vy300Xd3Tu=u3MOo_rvHCABDTsQFPA@mail.gmail.com>
Subject: Re: [PATCH printk v5 35/40] tty: serial: kgdboc: use srcu console
 list iterator
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 16, 2022 at 8:22 AM John Ogness <john.ogness@linutronix.de> wrote:
>
> Use srcu console list iteration for safe console list traversal.
> Note that this is a preparatory change for when console_lock no
> longer provides synchronization for the console list.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> ---
>  drivers/tty/serial/kgdboc.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index 5be381003e58..c6df9ef34099 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -451,6 +451,7 @@ static void kgdboc_earlycon_pre_exp_handler(void)
>  {
>         struct console *con;
>         static bool already_warned;
> +       int cookie;
>
>         if (already_warned)
>                 return;
> @@ -463,9 +464,14 @@ static void kgdboc_earlycon_pre_exp_handler(void)
>          * serial drivers might be OK with this, print a warning once per
>          * boot if we detect this case.
>          */
> -       for_each_console(con)
> +       cookie = console_srcu_read_lock();
> +       for_each_console_srcu(con) {
>                 if (con == kgdboc_earlycon_io_ops.cons)
> -                       return;
> +                       break;
> +       }
> +       console_srcu_read_unlock(cookie);
> +       if (con)
> +               return;

Is there truly any guarantee that "con" will be NULL if
for_each_console_srcu() finishes naturally (AKA without a "break"
being executed)?

It looks as if currently this will be true but nothing in the comments
of for_each_console_srcu() nor hlist_for_each_entry_srcu() (which it
calls) guarantees this, right? It would be nice if that was
documented, but I guess it's not a huge deal.

 Also: wasn't there just some big issue about people using loop
iteration variables after the loop finished?

https://lwn.net/Articles/885941/

Ah, I guess that's a slightly different problem and probably not relevant here.

So it seems like this is fine.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
