Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECED968F63F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjBHR6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjBHR6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:58:32 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F205FEF96
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:58:30 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id t5so8664056oiw.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 09:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TgLgOCji2dZHQhls7vSUZNVdRziEGATWNkzFOavtl7k=;
        b=fOCnLzkbcKGLOcFK7OOpRjsO/u5lhIFi5402KJzUU0RIdwDScGAT4a5RnQfTK+yaT5
         Bg0IUgtDJpnBD/0YgfYqO0kMPETgjpxly47Af/KDh/J3CvntI8802BcHtygrsWTRJcMG
         o7RxKdUzR5oH9FV9RkO1p5SuaJ+uujqH6zk6kGBqmLdBV2b6BRzMYn3tKn6jkcLQdxJs
         5wUed+2YWAWB7gpfxPQI2vqHl4zOFdxVAk5xSKxjrnjqgKSfb30ChOcfbl4s6XYjKHgN
         Y1dsfQHb03aQfNiBPEgIeZ5e7WUR4oRCSbgDt8QqOfg577W1FW9G7zHWCS43eX74kkA6
         DoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TgLgOCji2dZHQhls7vSUZNVdRziEGATWNkzFOavtl7k=;
        b=xFBQ8l7g7ILSEzKufq56MKqmKx1pbobDE0is/eFBn5HyMEbPl4jX046Gmnfz/Cw9J/
         mqHa0VnDXNJ0mGhqmWwwki0QkKCkcKoQ5XJTI1G2gcrOdAVI27vJv2jmsj5uzBYoENhI
         4XYcztHgGP0osk+/WjlQAQWO0Jns5Fu/A7Tmi6ODHAgXaeqpZuVNHa3sgQYE50+F0Eut
         l4lfpFAK9F8BL7kfKMLFPNJUS2v8yMZMJ7oIKCzaX6u0XdOa0pXk667GEGj0Knmt7d6s
         8MpJqZiJ1LRC7xIfKJFUSpUPPPx1jCL6Xb/PyzMkB0zffCTXR7EVu2SvgsyKkD0CMGPY
         kpew==
X-Gm-Message-State: AO0yUKU+yd6NeQ28CbYY+oyhabHAGG8oWJ1/icnOg/sZBtYt9CqYYEYk
        fGs3EUWANcoljGCRle/eBsfugwMwf20r1ES/DS3v2w==
X-Google-Smtp-Source: AK7set+6iqbUGkOSFPuPRA48hsKX5OEWbfcgbLkap8EeSLkkwks4o7YMriShi19kVRN8iLT1Kjp0Q/LIETiwvYTWu1g=
X-Received: by 2002:aca:4107:0:b0:378:979:518b with SMTP id
 o7-20020aca4107000000b003780979518bmr259808oia.82.1675879108824; Wed, 08 Feb
 2023 09:58:28 -0800 (PST)
MIME-Version: 1.0
References: <20230208163418.342210-1-jassisinghbrar@gmail.com> <Y+PafyViJMb6OOAn@kroah.com>
In-Reply-To: <Y+PafyViJMb6OOAn@kroah.com>
From:   Jassi Brar <jaswinder.singh@linaro.org>
Date:   Wed, 8 Feb 2023 11:58:18 -0600
Message-ID: <CAJe_ZhcuTX282zkkoa8ihnmNBpiXHWE7sTw2K+uB5OVkVU=P+Q@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: udc: max3420_udc: fix serialized access
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jassisinghbrar@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, error27@gmail.com,
        stern@rowland.harvard.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2023 at 11:23, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Feb 08, 2023 at 10:34:18AM -0600, jassisinghbrar@gmail.com wrote:
> > From: Jassi Brar <jaswinder.singh@linaro.org>
> >
> >  The mutex 'spi_bus_mutex' should be used, instead of the spin-lock,
> > while changing the state of the kernel-thread.
>
> You forgot to say why this is the case.
>
It was 'inherited' (my fault) from  drivers/usb/host/max3421-hcd.c
which has the same issue.
OK, I will also add to the log why that is a bad idea.

> > Also changing the
> > usb-gadget state need not be protected by a spin-lock.
>
> Why not?  Why isn't this a separate change?
>
Because other low-level spi changes are protected by spin-lock and it
seems ok to not to have to worry about such a race.
I don't have the h/w anymore to actually test it, so it is just a
patch from looking.
I just got lazy to break it into two patches, will do that.

> >  This should fix the Smatch static checker warning
> >     warn: sleeping in atomic context
> >
> > Fixes: 48ba02b2e2b1 ("usb: gadget: add udc driver for max3420")
> > Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> > ---
> >  drivers/usb/gadget/udc/max3420_udc.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
>
> You forgot a "Reported-by:" line, right?
>
Yes, I forgot.

thanks.
