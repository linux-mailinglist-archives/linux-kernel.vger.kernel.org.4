Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CC271FA6A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 08:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbjFBG6B convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 2 Jun 2023 02:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbjFBG56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 02:57:58 -0400
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1356E18C;
        Thu,  1 Jun 2023 23:57:55 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2af189d323fso38158861fa.1;
        Thu, 01 Jun 2023 23:57:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685689072; x=1688281072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3yfrOJnAEtdE9WlO3Gt8PPHN7bIX3lR9BC9c57KaloY=;
        b=R2rVW+FnkwEdQRMl40aWTxm2z9/O8D4aEgAPIBqFC5+D4cyVKQESmbOdq3x9C8HVpY
         8xPuLG1VWoVvc42/lxKxvNRwjpF3u/oMun9cFmtyJM0koZGHaU8WFf6vDWw/N6XfqXq9
         YFbapRkKf0JfvGT0AJSkTKOCnhXdXclbJWo+PwDldnezH6XluEzTvmYsEx2xh4gnripe
         FBUvkxdrzA/ATxnObD4p5rby3W3tJTksvpDMW8dEEjukPOlFe9yvHJp8PFnyH7kETVkw
         cCnrlHMgS6ZsoX9slqzzJ/T90lU07rINwmKNhWYvnyfqweGbNCtO5b8IQ8T46Ap54qTQ
         BJ7Q==
X-Gm-Message-State: AC+VfDyy6lhhSafTKkg5uGeT5OuZINN0tKGzDEH25j+xZbLQY0ktekD/
        NuDZHWNh7ajsW3QZQ5YEB793RrJ3F6u1Tb+U
X-Google-Smtp-Source: ACHHUZ75DCPscSa/X3zlW/WfQIDY02e0JX8sYMVjwdkoNFcgQRiwXeL/JJ/R/fTaidnXMbvXWWlFhQ==
X-Received: by 2002:a2e:b989:0:b0:2a8:b792:d7cd with SMTP id p9-20020a2eb989000000b002a8b792d7cdmr466562ljp.4.1685689072001;
        Thu, 01 Jun 2023 23:57:52 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id v11-20020a2e924b000000b002a8e8c776e9sm108023ljg.56.2023.06.01.23.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 23:57:51 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4f4db9987f8so3751164e87.1;
        Thu, 01 Jun 2023 23:57:51 -0700 (PDT)
X-Received: by 2002:a05:6512:131e:b0:4eb:46c2:e771 with SMTP id
 x30-20020a056512131e00b004eb46c2e771mr776194lfu.14.1685689071688; Thu, 01 Jun
 2023 23:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220329091126.4730-1-wsa+renesas@sang-engineering.com>
 <20220329091126.4730-2-wsa+renesas@sang-engineering.com> <ZHkQDTvk6I2q-9CF@surfacebook>
 <CAMuHMdUaugQ5+Zhmg=oe=X2wvhazMiT=K-su0EJYKzD4Hdyn3Q@mail.gmail.com>
In-Reply-To: <CAMuHMdUaugQ5+Zhmg=oe=X2wvhazMiT=K-su0EJYKzD4Hdyn3Q@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 2 Jun 2023 08:57:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWhtVvA4=vh4imMtL+KssybzB57CNcLaNq9oVKkpeS1iA@mail.gmail.com>
Message-ID: <CAMuHMdWhtVvA4=vh4imMtL+KssybzB57CNcLaNq9oVKkpeS1iA@mail.gmail.com>
Subject: Re: [PATCH v8 1/1] gpio: add sloppy logic analyzer using polling
To:     andy.shevchenko@gmail.com
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 2, 2023 at 8:51 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Jun 1, 2023 at 11:40 PM <andy.shevchenko@gmail.com> wrote:
> > Tue, Mar 29, 2022 at 11:11:26AM +0200, Wolfram Sang kirjoitti:
> > > This is a sloppy logic analyzer using GPIOs. It comes with a script to
> > > isolate a CPU for polling. While this is definitely not a production
> > > level analyzer, it can be a helpful first view when remote debugging.
> > > Read the documentation for details.
> >
> > One note since I have done recent review and realize one issue with debugfs.
> >
> > ...
> >
> > > +     priv->debug_dir = debugfs_create_dir(devname, gpio_la_poll_debug_dir);
> >
> > If this fails with NULL...
> >
> > > +     debugfs_create_blob("meta_data", 0400, priv->debug_dir, &priv->meta);
> > > +     debugfs_create_ulong("delay_ns", 0600, priv->debug_dir, &priv->delay_ns);
> > > +     debugfs_create_ulong("delay_ns_acquisition", 0400, priv->debug_dir, &priv->acq_delay);
> > > +     debugfs_create_file_unsafe("buf_size", 0600, priv->debug_dir, priv, &fops_buf_size);
> > > +     debugfs_create_file_unsafe("capture", 0200, priv->debug_dir, priv, &fops_capture);
> > > +     debugfs_create_file_unsafe("trigger", 0200, priv->debug_dir, priv, &fops_trigger);
> >
> > ...and any of these is not, we will end up with the file in a root folder of debugfs...
> >
> > > +     dev_info(dev, "initialized");
> >
> > ...
> >
> > > +static int gpio_la_poll_remove(struct platform_device *pdev)
> > > +{
> > > +     struct gpio_la_poll_priv *priv = platform_get_drvdata(pdev);
> > > +
> > > +     mutex_lock(&priv->lock);
> > > +     debugfs_remove_recursive(priv->debug_dir);
> >
> > ...and this one won't remove it.
> >
> > > +     mutex_unlock(&priv->lock);
> > > +     mutex_destroy(&priv->lock);
> > > +
> > > +     return 0;
> > > +}
> >
> > ...
> >
> > However, I haven't checked if it's pure theoretical issue with the current code
> > base of debugfs or a potential problem. Easy fix is to check an error code and
>
> I think debugfs_create_dir() can only fail reasonably due to OOM.

Oops, you were talking about NULL, not an error code.
I don't think that can ever happen.
And if I did miss something, it would crash when dereferencing a NULL
pointer in d_really_is_positive() (as called in start_creating())...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
