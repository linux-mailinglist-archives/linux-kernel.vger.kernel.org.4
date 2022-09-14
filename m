Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E14B5B8AE0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiINOnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiINOnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:43:09 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A615D0D9;
        Wed, 14 Sep 2022 07:43:07 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id f76so7553057vkf.7;
        Wed, 14 Sep 2022 07:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=/BuJ/UVgBZg0KoMiE0f7vztkQf6+5F6R5wUukoFwPwE=;
        b=abPtSG4ayt1PhK/DZYj6r9K+38U1TyULoLkqpvp0jryo8xMHpr43l8P+QMJYqmbZvc
         nJlNjwUmeoEMcDG7sqCc7uybRG8ruMdhV4GQsigkcwiPL2IKGoPgq4aa+9J3/0N8rBce
         /P6UAxFtYiS0A9DKh4FLPqbsCRo17xtVx8SYg9WfPxf2G6aHzTksQX7iRIst+drRcsog
         fnqxnQ2EAYT+PUYY4UlwF7VNRqg/xuUB0od4CurKE3GZYOMaBRI4+rgsYIKduHIge/xQ
         ou5XoryFL9QhUG4A6IPD4LTMowBh1oo/6XWVI66FmH0FGWhqBXm487PXCHKtJPBCXsXA
         5l7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/BuJ/UVgBZg0KoMiE0f7vztkQf6+5F6R5wUukoFwPwE=;
        b=wbiPE92hFHxYPQmJvm9fmYwbEVxhaPA6xqxhitmGUbUlbMg9PUDrjjG5EJw/gu2VXc
         DoTz9+scTkOo9kXRK4jyeKAJFpMSLapadCc2COe4MyqGHyoxkKccALYgxJaSOuYrT6Yp
         L9DHLnHDU8e3eKAv2r5+l0CHZFWw/MA6G77oNu/+tykG4hiL+Nooyewxkv58VlRJa+IK
         +b1dnYI7WYzFBmJeht0z8de3zmwQl4sVC+K2yqdDM0w52AA/qAzPsNBzTnyvc5ZpWdmQ
         Dn8fByOeM4+m8rvb1mT+JqBu6ba7g41snabbk0HgYsIkvxQ9xbSPeUq6Wi9GVAu9quAX
         xBSA==
X-Gm-Message-State: ACgBeo2v44H6xrOskHZLd9U8g6rgtNcdEjDqH7x3+6r4rMDgxrXgJ7qu
        slsPxv5Ls4XuWJq4XyBl3urlX6ElBdwIyxlOc7q8Mb1CDX+KrA==
X-Google-Smtp-Source: AA6agR6MaaAXJd+E7WtLGVtNZ9o1zJTysPUSatM1eZOCOWx4oFbuJgQGa6qeUlZ5H7qjETSWSmlC3FpZmtfceQrEOyA=
X-Received: by 2002:a1f:26d8:0:b0:39e:e116:59b8 with SMTP id
 m207-20020a1f26d8000000b0039ee11659b8mr4553411vkm.36.1663166586481; Wed, 14
 Sep 2022 07:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAB7eexKfentLRraPRR8kwqY3NRN9WTTijLW8SrKwAPzOzouxDg@mail.gmail.com>
 <YyHe8dBI5ERbK+sL@kroah.com>
In-Reply-To: <YyHe8dBI5ERbK+sL@kroah.com>
From:   Rondreis <linhaoguo86@gmail.com>
Date:   Wed, 14 Sep 2022 22:42:55 +0800
Message-ID: <CAB7eexK2uUcC-9qw15FRLen7uLL3gTOkU3iGC5oYzH5SrGCpjw@mail.gmail.com>
Subject: Re: possible deadlock in f_midi_transmit
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     balbi@kernel.org, john@metanate.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Happy to receive your reply! I will double-check its validity. If
there is still a problem, I will contact the midi development team.

Best wishes!
Rondreis

On Wed, Sep 14, 2022 at 10:02 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Sep 14, 2022 at 08:49:49PM +0800, Rondreis wrote:
> > Hello,
> >
> > When fuzzing the Linux kernel driver v6.0-rc4, the following crash was
> > triggered.
> >
> > HEAD commit: 7e18e42e4b280c85b76967a9106a13ca61c16179
> > git tree: upstream
> >
> > kernel config: https://pastebin.com/raw/xtrgsXP3
> > C reproducer: https://pastebin.com/raw/C1xYEf7Q
> > console output: https://pastebin.com/raw/3RLhvQHE
> >
> > Basically, in the c reproducer, we use the gadget module to emulate
> > attaching a USB device(vendor id: 0x403, product id: 0xff3d, with the
> > midi function) and executing some simple sequence of system calls.
> > To reproduce this crash, we utilize a third-party library to emulate
> > the attaching process: https://github.com/linux-usb-gadgets/libusbgx.
> > Just clone this repository, install it, and compile the c
> > reproducer with ``` gcc crash.c -lusbgx -lconfig -o crash ``` will do
> > the trick.
> >
> > I would appreciate it if you have any idea how to solve this bug.
> >
> > The crash report is as follows:
> >
> >
> > ============================================
> > WARNING: possible recursive locking detected
> > 6.0.0-rc4+ #20 Not tainted
> > --------------------------------------------
> > kworker/0:1H/9 is trying to acquire lock:
> > ffff888057ed9228 (&midi->transmit_lock){....}-{2:2}, at:
> > f_midi_transmit+0x18c/0x1460 drivers/usb/gadget/function/f_midi.c:683
> >
> > but task is already holding lock:
> > ffff888057ed9228 (&midi->transmit_lock){....}-{2:2}, at:
> > f_midi_transmit+0x18c/0x1460 drivers/usb/gadget/function/f_midi.c:683
> >
> > other info that might help us debug this:
> >  Possible unsafe locking scenario:
> >
> >        CPU0
> >        ----
> >   lock(&midi->transmit_lock);
> >   lock(&midi->transmit_lock);
> >
> >  *** DEADLOCK ***
> >
> >  May be due to missing lock nesting notation
>
> That's a lockdep warning, is this really deadlocking?
>
> If so, I'd recommend asking the midi developers...
>
> thanks,
>
> greg k-h
