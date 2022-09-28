Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938705EEA23
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 01:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbiI1XdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 19:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbiI1XdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 19:33:08 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E12EF08C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 16:33:07 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id l14so30179936eja.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 16:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=q74yArMABpzeLkr74sIBfXXMxk7/EMgQ3hoGRYitxYU=;
        b=U0Q8SQFHSkScbj4cM4pTg7Yzb04zm5WgomM/5gs7MQUTxOnAoEjVy5BjCW7Lo5/BUi
         xVGQd3n/TGijftlrmbedS+TIFC4PIQ4GVxgHSTo1Hxqh7rav4zS5xPPOiO0U6zV/NMl4
         5n8EmZnC9tTRHnX8rS/uqie8PD5M0KehiVHl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=q74yArMABpzeLkr74sIBfXXMxk7/EMgQ3hoGRYitxYU=;
        b=HHcKM2N26y1/LBA5bO31ggTNleaQWjM6xDwz+OUNSH3RBPvOFfnh4uhZoly/RuJ6NA
         uWkhImOrZU+puBX2vS4QwqrbQjg1FzpZgGBYjcMONhhXTUzbK/PDQBpAnl5cZDJfGHaD
         DOo9Nz4Z5j3CEZJnhpJdxeSdwNf2vPIXlJBZ2XBj6zw7CdAMF9gC2T9oRZrK1ZOCk6+G
         kRT+rLqfDcTGQD55jf1H1lpuqOfZMIcP3osRtv4OoMmuwdNG+xf943gu4PWbak+D9kvj
         vetHbBuji0DCfBrd+sj7CaF9iruUHe9wIkip4yPrDFGmOjvjblYaLh0lWHR3lZMCGJOv
         FbGA==
X-Gm-Message-State: ACrzQf1a92pTgBbQjtkeyg7BinM7Q2wkevCn8Ng2y3LRpYPTKJGEa3Zb
        eFH2pzUnuUVXaogjT41UzJjTm3GVvuEZCApZ
X-Google-Smtp-Source: AMsMyM469AUaa+mB2JIQZbVR8HV8iZwsYburPZr5MIxUjpb1o/msGJwlcBixgj18jYHZIDXKlvvITw==
X-Received: by 2002:a17:907:7202:b0:783:1bed:c5db with SMTP id dr2-20020a170907720200b007831bedc5dbmr315200ejc.124.1664407985511;
        Wed, 28 Sep 2022 16:33:05 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id kx9-20020a170907774900b0073dc8d0eabesm3023511ejc.15.2022.09.28.16.33.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 16:33:04 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id m4so7668113wrr.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 16:33:03 -0700 (PDT)
X-Received: by 2002:a5d:522f:0:b0:228:dc7f:b9a8 with SMTP id
 i15-20020a5d522f000000b00228dc7fb9a8mr145687wra.617.1664407983299; Wed, 28
 Sep 2022 16:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220924000454.3319186-1-john.ogness@linutronix.de> <20220924000454.3319186-10-john.ogness@linutronix.de>
In-Reply-To: <20220924000454.3319186-10-john.ogness@linutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 28 Sep 2022 16:32:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W5mnR6MH+KLK9VgUCvY0rsjkMdR7un=pHmtNBBup7w7g@mail.gmail.com>
Message-ID: <CAD=FV=W5mnR6MH+KLK9VgUCvY0rsjkMdR7un=pHmtNBBup7w7g@mail.gmail.com>
Subject: Re: [PATCH printk 09/18] serial: kgdboc: Lock console list in probe function
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 23, 2022 at 5:05 PM John Ogness <john.ogness@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Unprotected list walks are not necessarily safe.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  drivers/tty/serial/kgdboc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index 79b7db8580e0..af2aa76bae15 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -193,7 +193,8 @@ static int configure_kgdboc(void)
>         if (!p)
>                 goto noconfig;
>
> -       for_each_console(cons) {
> +       console_list_lock();
> +       for_each_registered_console(cons) {
>                 int idx;
>                 if (cons->device && cons->device(cons, &idx) == p &&
>                     idx == tty_line) {
> @@ -201,6 +202,7 @@ static int configure_kgdboc(void)
>                         break;
>                 }
>         }
> +       console_list_unlock();

Seems right to me, thanks!

Reviewed-by: Douglas Anderson <dianders@chromium.org>
