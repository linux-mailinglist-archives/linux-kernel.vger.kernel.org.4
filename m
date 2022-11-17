Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA9862D04C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 01:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbiKQA7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 19:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbiKQA7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 19:59:32 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346171C131
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:59:30 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id t25so1317218ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5z9QLYoOFm95pMVOnKF25qs3Hcqgci3miwbsOY+I7C0=;
        b=aoSgoXP2zY/ZjfphtaJ/kTepLvpy5D+9DdGupsf/12+gXXehkXjkHUg6wn2VSX8VwU
         bPsEpBCjmTno6sKngL1LHpPiYZymT1EQwM8fJ3Qu9ZEn83R3dKrXfbpX1BBzBd4FTO67
         V5zSbzQ7arcbflqVfWpaHTBo8VouN+J2TfYCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5z9QLYoOFm95pMVOnKF25qs3Hcqgci3miwbsOY+I7C0=;
        b=tfHkEcWqXvWc2vfhsq9nVPW/smoru0HRAROFBbs+x19mcmqyW02uN8HgJorihBDr/J
         RgFo57OJdHThSVJ28a5ZtwaB7n4iMiKiLEhE5+3cQzsajbjsnNfdpXypHRxVeBKqxFqF
         hJI+Llfwy1/dbT7vQGOlg60uJZtPxe4UbdifecQnbIrJbz1bKw+UBhlusgPvIbTrqF8F
         SOGusMP46F3tjlqwCFpYCT5tuWTo+ndjaGR3oupLKop7zXbT6my6ly2qCRlkcB4ZkoTk
         /vZ3qptxoLokHAjVs7pYW66U3JSwNfax8uVFgSG3ZMnOP6BIrgH5dOOdHtUvBRy3zLCK
         oXyQ==
X-Gm-Message-State: ANoB5pkPFRf67SXYAskDn5NQOU7WqN8ufHwqymklR6GLGdfwM+aa/r+L
        X0PbquVdXrjTIxSgIEfsDiJbq4vHIqcmmX3a
X-Google-Smtp-Source: AA0mqf5zHpz/+mJ8h4uNP8fBkjbJNXaRSk/2Ue7BJZEYy6r8C/69JwMMe63zG5v0l3db5E9cA5Dx4g==
X-Received: by 2002:a17:906:f6da:b0:7ad:86f9:1d70 with SMTP id jo26-20020a170906f6da00b007ad86f91d70mr287476ejb.179.1668646762852;
        Wed, 16 Nov 2022 16:59:22 -0800 (PST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id r10-20020a17090609ca00b0078d3f96d293sm7466116eje.30.2022.11.16.16.59.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 16:59:20 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id r127-20020a1c4485000000b003cfdd569507so2271726wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:59:20 -0800 (PST)
X-Received: by 2002:a1c:cc04:0:b0:3cf:7716:8954 with SMTP id
 h4-20020a1ccc04000000b003cf77168954mr157185wmb.57.1668646760151; Wed, 16 Nov
 2022 16:59:20 -0800 (PST)
MIME-Version: 1.0
References: <20221116162152.193147-1-john.ogness@linutronix.de> <20221116162152.193147-38-john.ogness@linutronix.de>
In-Reply-To: <20221116162152.193147-38-john.ogness@linutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 16 Nov 2022 16:59:08 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WWZAAhw7rWjCvtqz6VGh-PzG_zMnugX_KkG7gZ+a9Qpw@mail.gmail.com>
Message-ID: <CAD=FV=WWZAAhw7rWjCvtqz6VGh-PzG_zMnugX_KkG7gZ+a9Qpw@mail.gmail.com>
Subject: Re: [PATCH printk v5 37/40] tty: serial: kgdboc: synchronize
 tty_find_polling_driver() and register_console()
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 16, 2022 at 8:22 AM John Ogness <john.ogness@linutronix.de> wrote:
>
> Calling tty_find_polling_driver() can lead to uart_set_options() being
> called (via the poll_init() callback of tty_operations) to configure the
> uart. But uart_set_options() can also be called by register_console()
> (via the setup() callback of console).
>
> Take the console_list_lock to synchronize against register_console() and
> also use it for console list traversal. This also ensures the console list
> cannot change until the polling console has been chosen.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> ---
>  drivers/tty/serial/kgdboc.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index 82b4b4d67823..8c2b7ccdfebf 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -189,12 +189,20 @@ static int configure_kgdboc(void)
>         if (kgdboc_register_kbd(&cptr))
>                 goto do_register;
>
> +       /*
> +        * tty_find_polling_driver() can call uart_set_options()
> +        * (via poll_init) to configure the uart. Take the console_list_lock
> +        * in order to synchronize against register_console(), which can also
> +        * configure the uart via uart_set_options(). This also allows safe
> +        * traversal of the console list.
> +        */
> +       console_list_lock();
> +
>         p = tty_find_polling_driver(cptr, &tty_line);
> -       if (!p)
> +       if (!p) {
> +               console_list_unlock();
>                 goto noconfig;
> -
> -       /* For safe traversal of the console list. */
> -       console_list_lock();
> +       }

Seems OK to me, though I guess I would have moved console_lock() up
too just because this isn't a case we need to optimize and then we can
be extra certain that nobody else is messing with console structures
while we're looking at them.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
