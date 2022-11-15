Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E060D628E1B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 01:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236635AbiKOAQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 19:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbiKOAQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 19:16:19 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9DE1CB2A;
        Mon, 14 Nov 2022 16:16:18 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id v3-20020a17090ac90300b00218441ac0f6so365461pjt.0;
        Mon, 14 Nov 2022 16:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4v7OYMMAc0zCH8SqUBKlRfNwf0qE0V9KHmyK1/essTg=;
        b=pAqott4Bq5dl3rdIc4adqOK5knz8TnKfxoZTH+2b9qe71cEEAH4T/0fvzqiF2aWtDW
         P8xUtXSGUiuJ0gm0ZbZgn9V/cNH5nATQFwNKTr4tSngxZRjoX9tnmnlfLp0oI+1I/mFJ
         Y26vHwNuPbf+tc2JZJ3z5cS2AR2lpNpbJHE04/fY4qFtqi7J6pnyVlSdZpSFAq80Nwiw
         YI329wVzJWUQxgXaYTRsgFG77PGeHbR8UX3CTlDf2Z5EbHOOOVTkGbG/ZM4z0FsO3I70
         XqtgNXWk/DXHNdxlad06k6KJCCw7TXqdlGDbCm5CZvkMvscWi4li3lHue/nUqG+TexZq
         k+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4v7OYMMAc0zCH8SqUBKlRfNwf0qE0V9KHmyK1/essTg=;
        b=uquG77Y48r1WpZSH3KuHDVdRyeFoF/znS280SmxHVAHxkg/xH5LYQrEDjIhU2gT7XJ
         gHqtayFcDVKOEbhSlVszuB2AZ92gTdZ0Cd4t+1zXOKQqB3mlp619s0GWMLeGX8qC4+Zy
         r6DfQYj/Y3PyPlJ9O/nRjOlynuQQM5F2BLFuNzowDqtlBt20RLDZInIur36M33NoErrV
         yHLbCe4zCuGKroCfDariP7tthuYE6+x8xUn5pGVrubd/9TNQUgxdl2iRBo31Qk6iue2c
         7SRF9O0YIK7yPu3+/L81MmuXXvP9LoizL9GZMiVNPEnTaG/JHnelzFgtB8YjqYFeaZvR
         CthA==
X-Gm-Message-State: ANoB5plxLuuv6HuhSMOXB12aPE6pYtIWLSM1eOOGuGiLo+j0l/yRcyLK
        TFh+wMUDgn8l0qlJ4RZRQFI=
X-Google-Smtp-Source: AA0mqf4cr49ah0pai6zTD2+5A/8zltwpW9bVFF9eBvRF53ojwUVdgw9cIDv+GZ3MnHhOznEilalJug==
X-Received: by 2002:a17:903:3292:b0:17d:5e67:c523 with SMTP id jh18-20020a170903329200b0017d5e67c523mr1534029plb.115.1668471377451;
        Mon, 14 Nov 2022 16:16:17 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:718:95ee:2678:497])
        by smtp.gmail.com with ESMTPSA id om15-20020a17090b3a8f00b00213c7cf21c0sm7149531pjb.5.2022.11.14.16.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 16:16:16 -0800 (PST)
Date:   Mon, 14 Nov 2022 16:16:13 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        linux-input@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] macintosh/mac_hid.c: don't load by default
Message-ID: <Y3LaTeMxTa/7Rv7H@google.com>
References: <20221113033022.2639-1-linux@weissschuh.net>
 <Y3KJ6SOD5PEwj1oe@google.com>
 <9255deb3-6c66-444d-940d-77e721d950e5@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9255deb3-6c66-444d-940d-77e721d950e5@t-8ch.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 12:54:41AM +0100, Thomas Weiﬂschuh wrote:
> Cc Franz who wrote the driver originally.
> (I hope I got the correct one)
> 
> Hi Dmitry,
> 
> On 2022-11-14 10:33-0800, Dmitry Torokhov wrote:
> > On Sun, Nov 13, 2022 at 04:30:22AM +0100, Thomas Weiﬂschuh wrote:
> >> There should be no need to automatically load this driver on *all*
> >> machines with a keyboard.
> >> 
> >> This driver is of very limited utility and has to be enabled by the user
> >> explicitly anyway.
> >> Furthermore its own header comment has deprecated it for 17 years.
> > 
> > I think if someone does not need a driver they can either not enable it
> > or blacklist it in /etc/modprobe.d/... There is no need to break
> > module loading in the kernel.
> 
> But nobody needs the driver as it is autoloaded in its current state.
> Without manual configuration after loading the driver does not provide any
> functionality.
> 
> Furthermore the autoloading should load the driver for a specific
> hardware/resource that it can provide additional functionality for.
> Right now the driver loads automatically for any system that has an input
> device with a key and then just does nothing.
> 
> It only wastes memory and confuses users why it is loaded.
> 
> If somebody really needs this (fringe) driver it should be on them to load it
> it instead of everybody else having to disable it.

The driver is not enabled by default, so somebody has to enable it in
the first place. How did you end up with it?

> 
> Furthermore the file has the following comment since the beginning of the git
> history in 2005:
> 
>     Copyright (C) 2000 Franz Sirl
> 
>     This file will soon be removed in favor of an uinput userspace tool.

OK, that is a separate topic, if there are no users we can remove the
driver. Do we know if this tool ever came into existence?

What I do not want is to break the autoload for one single driver
because somebody enabled it without intending to use and now tries to
implement a one-off.

> 
> >> Fixes: 99b089c3c38a ("Input: Mac button emulation - implement as an input filter")
> >> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> >> ---
> >>  drivers/macintosh/mac_hid.c | 2 --
> >>  1 file changed, 2 deletions(-)
> >> 
> >> diff --git a/drivers/macintosh/mac_hid.c b/drivers/macintosh/mac_hid.c
> >> index d8c4d5664145..d01d28890db4 100644
> >> --- a/drivers/macintosh/mac_hid.c
> >> +++ b/drivers/macintosh/mac_hid.c
> >> @@ -149,8 +149,6 @@ static const struct input_device_id mac_hid_emumouse_ids[] = {
> >>  	{ },
> >>  };
> >>  
> >> -MODULE_DEVICE_TABLE(input, mac_hid_emumouse_ids);
> >> -
> >>  static struct input_handler mac_hid_emumouse_handler = {
> >>  	.filter		= mac_hid_emumouse_filter,
> >>  	.connect	= mac_hid_emumouse_connect,
> >> 
> >> base-commit: fef7fd48922d11b22620e19f9c9101647bfe943d
> >> -- 
> >> 2.38.1

Thanks.

-- 
Dmitry
