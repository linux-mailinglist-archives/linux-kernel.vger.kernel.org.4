Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F156B60BF7A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiJYAXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiJYAWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:22:54 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC6B7F084
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:46:38 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z97so33739624ede.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oIHl2iCS5umkUQOttHMwOxT4DU4dTXsnDaz+mZRAMKc=;
        b=oZyDNuZZ8bs6Dd/+bmcm0ORHJLVHkh6oX/lOWkQd7odI9UAqCD7O/wCA/hDvorihH3
         N9+QLewwBtMtqshKTjtsp9e5sf8Q8V9IMkMUcxglNK13SVPGIcxHiUROeBAQPe//FtdZ
         MC3KWgqs6B/AegdXOlxhnQfyBH4y0fiqdEFFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oIHl2iCS5umkUQOttHMwOxT4DU4dTXsnDaz+mZRAMKc=;
        b=41MESTygh9QYaEls21oAt+w236OQHBA6zvbPEUST5mXubMcEfkfePsYgp1dTrMLzS/
         b5qrv1OV3LIFEQxjOTPq4CniQIpQXulsxhBKwhIALjkQa8GUl4Ly9A7vKptWANyQnx3x
         aTgew9F2wo1tirlLjpX9sVSEWo84vDgVzQhbs4+t4itUjOPPbdxrWxs6tGCizEddQikM
         7qy5R1T1Ndl7soO2nw/YbVuSZCJzAJoaE38iUz83CLU41e8rU85gpxfT91Yol7u9PUaA
         Rv0ElaIA7rc9x2aTQQNl5BzWv9c4AZB4R+hpwf1ai61640BvhW2Se+VDXatE8H3nXWm3
         RF2g==
X-Gm-Message-State: ACrzQf0C0UixciOvELMTO3y1mhN6xv7wPsqVvaRFMcxS6Ti5vTNQp/RN
        XfkH8xMmWTQMVEqQzB18wcarPhbCIcRXU6AQ
X-Google-Smtp-Source: AMsMyM7lhR2fNp4T+AplBhVaRtmUMJrMnufSq2JaVWXPoYKZ7DQAus+SN3YxKR2FW743tbhmknE2dw==
X-Received: by 2002:a05:6402:370c:b0:453:9fab:1b53 with SMTP id ek12-20020a056402370c00b004539fab1b53mr33631530edb.28.1666651596721;
        Mon, 24 Oct 2022 15:46:36 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id ks23-20020a170906f85700b0078d175d6dc5sm440044ejb.201.2022.10.24.15.46.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 15:46:35 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id g12so5448307wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:46:35 -0700 (PDT)
X-Received: by 2002:a5d:6488:0:b0:22b:3b0b:5e72 with SMTP id
 o8-20020a5d6488000000b0022b3b0b5e72mr23635683wri.138.1666651584545; Mon, 24
 Oct 2022 15:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221019145600.1282823-1-john.ogness@linutronix.de> <20221019145600.1282823-13-john.ogness@linutronix.de>
In-Reply-To: <20221019145600.1282823-13-john.ogness@linutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 Oct 2022 15:46:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VFxKL=sOMdhyHrgy2JOtzKJdOe4euwZRRAK7P-rNVjuQ@mail.gmail.com>
Message-ID: <CAD=FV=VFxKL=sOMdhyHrgy2JOtzKJdOe4euwZRRAK7P-rNVjuQ@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 19, 2022 at 7:56 AM John Ogness <john.ogness@linutronix.de> wrote:
>
> Replace (console->flags & CON_ENABLED) usage with console_is_enabled().
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  drivers/tty/serial/kgdboc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index e76f0186c335..b17aa7e49894 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -533,7 +533,7 @@ static int __init kgdboc_earlycon_init(char *opt)
>         console_lock();
>         for_each_console(con) {
>                 if (con->write && con->read &&
> -                   (con->flags & (CON_BOOT | CON_ENABLED)) &&
> +                   (console_is_enabled(con) || (con->flags & CON_BOOT)) &&

<shrug>. I guess this is OK, but it feels a little pointless. If we're
still directly looking at the CON_BOOT bit in con->flags it seems
weird to be accessing CON_ENABLED through a special wrapper that's
marked as a `data_race`. In our case it's _not_ a data race, right,
since this function continues to hold the console_lock() even at the
end of the series? I personally would drop this patch but if you
really want it I won't object.

-Doug
