Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77936C9352
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 11:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjCZJMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 05:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCZJMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 05:12:10 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B84E10C9;
        Sun, 26 Mar 2023 02:12:06 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id p2so4294503uap.1;
        Sun, 26 Mar 2023 02:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679821925;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1YFcu3KqdhzqArr7G9NjmMcFFIaBTGLNEJI0GTpZLTY=;
        b=eba+x52kblNHYG4gxjJ1ybCwfGQd5MkF8WkhE9JgjgYX24Zyqi3EM49e4sE8f+3RVa
         LXEqkS0S4H3xTkj2YemxOJnyBr1H/pDEObYAX0z624txFGtts2G25AWf7d0ddXoqlOYJ
         WgmrjCmavqYzWrYwoLAbNFtsEC19N82sFyU/XlGLe/EwlPY1OLFPxCo5AzjCf03H2vJr
         g0X8EDI9D9nRjBhdWxhY7U5HGk5AWGHRw2y2sexk4bF8R1wbVjp0zs7s2VMTlBA/zAqQ
         QfcXTurCmkNHkbplIbGgIGcm7JyrHDGlrr2o26mWc0V4NzV6+bXFD9tfdW2EKUOchU4e
         bWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679821925;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1YFcu3KqdhzqArr7G9NjmMcFFIaBTGLNEJI0GTpZLTY=;
        b=Bc7rT3tG9rV8ydth+HbxUSHH8k+riDpJ500BtAErOK+JMnYxzsnebyA+VKyaPcfi7p
         hs3zn51CS6K+5rtJjPRKPOCKpzPT+/QLXzAuKSssqaZw6/HZCV4seCKzKtU+Bcu0shKc
         abPEVDN0RQYTFvKgLk51crhStHYc11bqm6K+fjhZ2hyULNqxjPuLDcMJb5oWjdBf2tNP
         y9wsfgCphRc8MKF8BL9oIIUZYlSVD2PyOjk22SO/1+pAkMACwrlYfzyp3nZ9BdmumDey
         okEeNpP2i2GlL6NekuRhsrP5t6JnsZO++qvdKLSCZ+obqbzbcNsO8mZ2gHJoXWIHycq4
         /GFQ==
X-Gm-Message-State: AAQBX9f95vJAwajCBex40ONLqUqfkYda67HHkUve9s1Yx7DYSBzlA92E
        5lVMD2k2Fkv52qmzsdP4xowvJ2hiyD3EoxoXOSu+y4wJhy8=
X-Google-Smtp-Source: AKy350b5nHber7fKY0Wvt8esTSoXb4rlG7uELmUbu91m2GEgVjRJmuJzccKwlverruWPygtBRm2XbyGqalnI7m0FD9o=
X-Received: by 2002:a1f:2fd8:0:b0:40c:4d1:b550 with SMTP id
 v207-20020a1f2fd8000000b0040c04d1b550mr4593988vkv.0.1679821924947; Sun, 26
 Mar 2023 02:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230324172427.3416342-1-harperchen1110@gmail.com> <4dcd261e56cf54eb409b6851128b63c5f7a2efcf.camel@posteo.de>
In-Reply-To: <4dcd261e56cf54eb409b6851128b63c5f7a2efcf.camel@posteo.de>
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Sun, 26 Mar 2023 17:11:29 +0800
Message-ID: <CAO4mrfdoAcLUH5VyQyskBiZZpqNS-dKMwddwvDfwP=Csw0EgmQ@mail.gmail.com>
Subject: Re: [PATCH] media: hi846: Fix memleak in hi846_init_controls()
To:     Martin Kepplinger <martink@posteo.de>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Martin,

Thanks for pointing out my mistake.

I cross-checked other implementations of drivers under media/i2c. I
agree with you. Let me send the second version of my patch.

Thanks,
Wei

On Sun, 26 Mar 2023 at 16:50, Martin Kepplinger <martink@posteo.de> wrote:
>
> Am Freitag, dem 24.03.2023 um 17:24 +0000 schrieb Wei Chen:
> > hi846_init_controls doesn't clean the allocated ctrl_hdlr
> > in case there is a failure, which causes memleak. Add
> > v4l2_ctrl_handler_free to free the resource properly.
> >
> > Signed-off-by: Wei Chen <harperchen1110@gmail.com>
> > ---
> >  drivers/media/i2c/hi846.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/media/i2c/hi846.c b/drivers/media/i2c/hi846.c
> > index 7c61873b7198..c45a6511d2c1 100644
> > --- a/drivers/media/i2c/hi846.c
> > +++ b/drivers/media/i2c/hi846.c
> > @@ -1472,6 +1472,7 @@ static int hi846_init_controls(struct hi846
> > *hi846)
> >         if (ctrl_hdlr->error) {
> >                 dev_err(&client->dev, "v4l ctrl handler error: %d\n",
> >                         ctrl_hdlr->error);
> > +               v4l2_ctrl_handler_free(ctrl_hdlr);
> >                 return ctrl_hdlr->error;
> >         }
> >
>
> hi Wei, thanks for the patch. It looks like I forgot that indeed, but
> to me it looks like the subsequent error paths of
> v4l2_fwnode_device_parse() and v4l2_ctrl_new_fwnode_properties() would
> leak the same thing.
>
> And since we only assign it to the subdev's ctrl_handler in the success
> case later, you could simply add an error label:
>
>
> @@ -1663,21 +1663,26 @@ static int hi846_init_controls(struct hi846
> *hi846)
>         if (ctrl_hdlr->error) {
>                 dev_err(&client->dev, "v4l ctrl handler error: %d\n",
>                         ctrl_hdlr->error);
> -               return ctrl_hdlr->error;
> +               ret = ctrl_hdlr->error;
> +               goto error;
>         }
>
>         ret = v4l2_fwnode_device_parse(&client->dev, &props);
>         if (ret)
> -               return ret;
> +               goto error;
>
>         ret = v4l2_ctrl_new_fwnode_properties(ctrl_hdlr,
> &hi846_ctrl_ops,
>                                               &props);
>         if (ret)
> -               return ret;
> +               goto error;
>
>         hi846->sd.ctrl_handler = ctrl_hdlr;
>
>         return 0;
> +
> +error:
> +       v4l2_ctrl_handler_free(ctrl_hdlr);
> +       return ret;
>  }
>
>
> what do you think? thanks!
>
>                               martin
>
>
