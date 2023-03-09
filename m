Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD48A6B1B28
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 07:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjCIGL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 01:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCIGLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 01:11:52 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4448C70BC;
        Wed,  8 Mar 2023 22:11:51 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id m10so697390vso.4;
        Wed, 08 Mar 2023 22:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678342311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DOzTOu7edVtxvcJFXb3EsqSUZ93p9slEkC3iI88cKoI=;
        b=N30kyudSkCl3/te0Vn30Yn5Qu/oKErDE/QG0ofKinWC0NYLlcWzUagCP7fZZxpwpcs
         ZIzjUnPO/18w0yiW4R868/2X0RJ14TPVNDPufKvQ/mPDQ5z4BtscMdyRuqQWVXyEa603
         4tAdhqbRGHwBEBbbM9c9LCG74SyuSN4ifDJnajKWa47eU7ONQWi3x7tZNmD4PlgrlnqT
         cuypy95LQVMKf/SOGvJNOncoK7H0SXAuNCxdIFpQPLOJdqSZefU+gQ15LNuKFKUeoW3o
         8BMpU2jNQyV4DS/D1YHzfGb0To3j8MrD+okeVigtRwL5fvsdTNWANN/FFWP0h4jOowsD
         h7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678342311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DOzTOu7edVtxvcJFXb3EsqSUZ93p9slEkC3iI88cKoI=;
        b=jH4j1xhnnZd6p51S1w9h8ac1/uzUpbOemXhE9YLN09r6qR/QIwxMj0RD+Puk8yPdJO
         dsDQTZfBH7rZ/y2D+HyBQxEteGdARs2B1veD447KnZeDB3c5GYB31qpOupM3pwnZCgGd
         xtbcAjsChdmibTZWwpCbOyHt5Rub5M/t+rztN3xO7k1bNv0GVSt8qMUsJCB9QIIqql4K
         MV++R/nWsvVSAhaSYX/gJaW7FUoRyeOjMh4jp8m2jnF6Xq25+CQsnqYmANh7WzG6yRSF
         E9TckxuQCJ3g0jEwDgNTQq/7OOqpbO8V3ZDysM1MldHGuhiRLMy6CTRavONsnoJnofT6
         5QLQ==
X-Gm-Message-State: AO0yUKUtBA8jJXZ3jFeEHZkPzlSsBes2KZPflY3pLlyCXmm05vHRTiqf
        gs+z47CcK3WXBXaLgcFOCyaSBWrROsn0EJGRk3Y=
X-Google-Smtp-Source: AK7set+pChHLpiXzjFwd9oKRlK2Hl+8a6uJ9CpwuwrCWNy+dbs7lk2te8UfH2A6eoG2JZv0/neHDZ4xE1qFYn3K+vOw=
X-Received: by 2002:a67:7302:0:b0:414:2d02:6c96 with SMTP id
 o2-20020a677302000000b004142d026c96mr13522386vsc.7.1678342310849; Wed, 08 Mar
 2023 22:11:50 -0800 (PST)
MIME-Version: 1.0
References: <20230307130856.2295182-1-harperchen1110@gmail.com> <123a52d8-baf0-e32b-3262-1e8619b1c3ad@gmx.de>
In-Reply-To: <123a52d8-baf0-e32b-3262-1e8619b1c3ad@gmx.de>
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Thu, 9 Mar 2023 14:11:14 +0800
Message-ID: <CAO4mrfem6K99Qnj7F-2Yqf25gG5zLSqumaz0N176j_Ekn+m-nA@mail.gmail.com>
Subject: Re: [PATCH] fbdev: tgafb: Fix potential divide by zero
To:     Helge Deller <deller@gmx.de>
Cc:     javierm@redhat.com, tzimmermann@suse.de,
        wsa+renesas@sang-engineering.com, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Helge,

Thank you for the kind words. My real name is Wei Chen.

Please apply this patch to fbdev git tree if it is correct.

Best,
Wei

On Thu, 9 Mar 2023 at 06:05, Helge Deller <deller@gmx.de> wrote:
>
> On 3/7/23 14:08, harperchen wrote:
> > fb_set_var would by called when user invokes ioctl with cmd
> > FBIOPUT_VSCREENINFO. User-provided data would finally reach
> > tgafb_check_var. In case var->pixclock is assigned to zero,
> > divide by zero would occur when checking whether reciprocal
> > of var->pixclock is too high.
> >
> > Similar crashes have happened in other fbdev drivers. There
> > is no check and modification on var->pixclock along the call
> > chain to tgafb_check_var. We believe it could also be triggered
> > in driver tgafb from user site.
> >
> > Signed-off-by: harperchen <harperchen1110@gmail.com>
>
> Could you provide a real name?
> Otherwise applied to fbdev git tree.
>
> Thanks!
> Helge
>
> > ---
> >   drivers/video/fbdev/tgafb.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/video/fbdev/tgafb.c b/drivers/video/fbdev/tgafb.c
> > index 14d37c49633c..b44004880f0d 100644
> > --- a/drivers/video/fbdev/tgafb.c
> > +++ b/drivers/video/fbdev/tgafb.c
> > @@ -173,6 +173,9 @@ tgafb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
> >   {
> >       struct tga_par *par = (struct tga_par *)info->par;
> >
> > +     if (!var->pixclock)
> > +             return -EINVAL;
> > +
> >       if (par->tga_type == TGA_TYPE_8PLANE) {
> >               if (var->bits_per_pixel != 8)
> >                       return -EINVAL;
>
