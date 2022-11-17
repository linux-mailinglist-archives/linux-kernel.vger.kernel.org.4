Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7184D62D047
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 01:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbiKQA4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 19:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbiKQA4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 19:56:32 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0453368C79
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:56:32 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id bj12so1237315ejb.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1n9Efk70GF888Q8DxstqVav/EqXxYg0mmKjGntmJnKE=;
        b=jfAiRCbUBmzEJVryVoKrNvSRIVoS+m7YdWOdzKGdzU2SLFWxIZppc7/zdSDdZxS94A
         fSKXhPJgpc63X9youj+aXT15h+AF6oXExh9JstLh0qlntszrF2SdHhDIoGha0Vz4M3Qr
         zIOEF9lOEJmiQJRWePqZgcbAykhMpuRNHB9+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1n9Efk70GF888Q8DxstqVav/EqXxYg0mmKjGntmJnKE=;
        b=L4jZA5MjDtzLrfELdImHxcLIb+xyFWa09LLwoNR9OdzeNKNCu7Hl+qZHqKtCkXXhZl
         YDhSQh6f7ZfHKhKf4X8RIU7IW5d56IuS46ux4HnabI3O1U4NKcXdDwFDe1BRgjMgsBur
         CIdQVBDZ105uBRgRbeAffHBRykH5BAh/sDIWCVeuGx9bZ0JsFCr1jp8By9CptvqljL5L
         cpskpP/BCtQmmV84iD9x7GwSBtrV7cnghieFWqHs1nYpIwxsb9D8brjW8aQ89KilZDNb
         klMpntEJ+5ICBLzKtsfhtfrDFCFr5wjTqQpCsYct1yb1yP6XIrCucS9bo+FkRwLXs24O
         UjcA==
X-Gm-Message-State: ANoB5pmitqb9/8C4gRMnJ2No35rEHnD985R0ZvkSQ6LdMVN7lWU6yB68
        NRMo9UGxr/ldzhZyVnAnwFi2BpndyAOnZtby
X-Google-Smtp-Source: AA0mqf6KgpEw5Gx6UXqnvSC5hKiztuzW2GiVdrl8XoPkF9fDhqIX+8yGPufNz7GBr64LjjPbnOKt6A==
X-Received: by 2002:a17:906:8c4:b0:7ae:fbe6:e7ca with SMTP id o4-20020a17090608c400b007aefbe6e7camr276542eje.408.1668646588747;
        Wed, 16 Nov 2022 16:56:28 -0800 (PST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id e20-20020a170906315400b0077b2b0563f4sm7557502eje.173.2022.11.16.16.56.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 16:56:27 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id h9so496563wrt.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:56:26 -0800 (PST)
X-Received: by 2002:adf:cd82:0:b0:238:b29e:4919 with SMTP id
 q2-20020adfcd82000000b00238b29e4919mr37800wrj.583.1668646586474; Wed, 16 Nov
 2022 16:56:26 -0800 (PST)
MIME-Version: 1.0
References: <20221116162152.193147-1-john.ogness@linutronix.de> <20221116162152.193147-39-john.ogness@linutronix.de>
In-Reply-To: <20221116162152.193147-39-john.ogness@linutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 16 Nov 2022 16:56:14 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VouG3ihFCg4gC3dNFs7TqzpDgowHd38y8fR8qiTfRw_A@mail.gmail.com>
Message-ID: <CAD=FV=VouG3ihFCg4gC3dNFs7TqzpDgowHd38y8fR8qiTfRw_A@mail.gmail.com>
Subject: Re: [PATCH printk v5 38/40] tty: serial: kgdboc: use
 console_list_lock to trap exit
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
> kgdboc_earlycon_init() uses the console_lock to ensure that no consoles
> are unregistered until the kgdboc_earlycon is setup. The console_list_lock
> should be used instead because list synchronization responsibility will
> be removed from the console_lock in a later change.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> ---
>  drivers/tty/serial/kgdboc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index 8c2b7ccdfebf..a3ed9b34e2ab 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -558,13 +558,13 @@ static int __init kgdboc_earlycon_init(char *opt)
>          */
>
>         /*
> -        * Hold the console_lock to guarantee that no consoles are
> +        * Hold the console_list_lock to guarantee that no consoles are
>          * unregistered until the kgdboc_earlycon setup is complete.
>          * Trapping the exit() callback relies on exit() not being
>          * called until the trap is setup. This also allows safe
>          * traversal of the console list and race-free reading of @flags.
>          */
> -       console_lock();
> +       console_list_lock();
>         for_each_console(con) {
>                 if (con->write && con->read &&
>                     (con->flags & (CON_BOOT | CON_ENABLED)) &&

Officially don't we need both the list lock and normal lock here since
we're reaching into the consoles?

-Doug
