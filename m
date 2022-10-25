Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA7960C0ED
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbiJYBWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiJYBWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:22:10 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD7054CB4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:49:49 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ot12so8910490ejb.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/J+E57FepHa+VPoHH/vCuYiisEoXCo25k1eOwk+X83Q=;
        b=LT4xjotEAQR+rhahuuC7tR5xBqJe9l3UB1hAIpYccMggPOooSk4KhuAaRudbslGZ9O
         q+Bi3Z/UsVAZ7vS4NyzfUydTnIt6ntqcgJ9O3pk2xZkcp1u2mriPc4Eb+65LxBjyVP4W
         kbUnb6o6ie3vaTcKX+BW3LO94wVzl2CJ7Z8j8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/J+E57FepHa+VPoHH/vCuYiisEoXCo25k1eOwk+X83Q=;
        b=Farwgg0bUiSQrAzE3AbaphAJSQaSmjf01eIgQT3Ut5mlIHpaEabNoPAOD+QUwpx2f1
         EpHdaM8SSzR2/p84URVVjOOq8mZlhOH9Nmo1uOU8+XI5nD0UCiCL2ogd+xkHLZHJi0Ja
         AXtIbiFc4XSC39YePRBFfhpSzsr+5KFHl2i+VXL2Qej5U2NyoxwI7YvzKIOj32yUUIyN
         h7LE4YLdNpwLrn4wI1L8HKhL0PqgS6sRj2NYCMgflWV6A5h6CUvy5n+01+KyvRzam7hf
         8asPGLsO0MYuVUn3X/IVOSmd0wT24UML/UOi41d6OWz/4oUQJVffHJjOyV6KUHQcjmUu
         aIWw==
X-Gm-Message-State: ACrzQf39qWVwxcsdCtRflBR/B59pJ86Q9A1Y3utJMkc8P8K7TG6BDTeP
        DwEKO9NyTGE3EDceafcHq/DDi1gDMvYopDXy
X-Google-Smtp-Source: AMsMyM4VNo4PeJzqNpDW00vZNEndLd7ejGMGOZIsf0O1ktxGs7pkQCgyVN4EyfkP/3CYdfJuAZ1ZFA==
X-Received: by 2002:a17:907:8a0a:b0:78d:b87d:e68a with SMTP id sc10-20020a1709078a0a00b0078db87de68amr28760082ejc.301.1666658987308;
        Mon, 24 Oct 2022 17:49:47 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id hb31-20020a170907161f00b007803083a36asm557704ejc.115.2022.10.24.17.49.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 17:49:46 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id z14so4988950wrn.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:49:46 -0700 (PDT)
X-Received: by 2002:adf:f641:0:b0:236:737f:8e00 with SMTP id
 x1-20020adff641000000b00236737f8e00mr4396527wrp.659.1666658985935; Mon, 24
 Oct 2022 17:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-13-john.ogness@linutronix.de> <CAD=FV=VFxKL=sOMdhyHrgy2JOtzKJdOe4euwZRRAK7P-rNVjuQ@mail.gmail.com>
In-Reply-To: <CAD=FV=VFxKL=sOMdhyHrgy2JOtzKJdOe4euwZRRAK7P-rNVjuQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 Oct 2022 17:49:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WF2S9wQ6uR+VKU4EfDTVd0JnKkuU3Wyfo6P8E_FouebQ@mail.gmail.com>
Message-ID: <CAD=FV=WF2S9wQ6uR+VKU4EfDTVd0JnKkuU3Wyfo6P8E_FouebQ@mail.gmail.com>
Subject: Re: [PATCH printk v2 12/38] tty: serial: kgdboc: use console_is_enabled()
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
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 24, 2022 at 3:46 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, Oct 19, 2022 at 7:56 AM John Ogness <john.ogness@linutronix.de> wrote:
> >
> > Replace (console->flags & CON_ENABLED) usage with console_is_enabled().
> >
> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
> > ---
> >  drivers/tty/serial/kgdboc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> > index e76f0186c335..b17aa7e49894 100644
> > --- a/drivers/tty/serial/kgdboc.c
> > +++ b/drivers/tty/serial/kgdboc.c
> > @@ -533,7 +533,7 @@ static int __init kgdboc_earlycon_init(char *opt)
> >         console_lock();
> >         for_each_console(con) {
> >                 if (con->write && con->read &&
> > -                   (con->flags & (CON_BOOT | CON_ENABLED)) &&
> > +                   (console_is_enabled(con) || (con->flags & CON_BOOT)) &&
>
> <shrug>. I guess this is OK, but it feels a little pointless. If we're
> still directly looking at the CON_BOOT bit in con->flags it seems
> weird to be accessing CON_ENABLED through a special wrapper that's
> marked as a `data_race`. In our case it's _not_ a data race, right,
> since this function continues to hold the console_lock() even at the
> end of the series? I personally would drop this patch but if you
> really want it I won't object.

I realized that my statement isn't quite true. It actually only holds
console_list_lock() even at the end of the series. Still, it seems
weird that we're declaring the `data_race` on CON_ENABLED but not
CON_BOOT ?
