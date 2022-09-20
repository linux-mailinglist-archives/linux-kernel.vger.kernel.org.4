Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B96E5BE8C0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiITOXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbiITOW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:22:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007061115;
        Tue, 20 Sep 2022 07:22:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E71C6204E;
        Tue, 20 Sep 2022 14:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4568C4347C;
        Tue, 20 Sep 2022 14:22:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="X2L/pZ7L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1663683719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eAFMvr0uN4pEiPJeHRaNx8VoWQp+qnmXgnVisuTo3XQ=;
        b=X2L/pZ7L6j1WQNpk33ZKOo99n9zwesyEvNkUoPSJ6NO8IjRI/rjhrb+/52UsPCsPzQvk9P
        kIHITIBIzfJ/mqALie6ZYfJW11eaq39HS2PNnFDgF900+/rNmzZzcfnJvxlDgVm5rFUH6k
        EzIljyF8z1q95ZoOpGv1/GGbgaRzCbE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 763cec8b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 20 Sep 2022 14:21:58 +0000 (UTC)
Received: by mail-ua1-f53.google.com with SMTP id b7so1133144uas.2;
        Tue, 20 Sep 2022 07:21:58 -0700 (PDT)
X-Gm-Message-State: ACrzQf1OTlA1+n7tHx9neRJvRJigGqqoDUE0z+jbCDlxZOSqAJGIuEnV
        ZvS/gkgNIT4Pxmy9GkKAQ+qyVwVjHeW3NP2NF3Q=
X-Google-Smtp-Source: AMsMyM5U9OdjHhD9hRLrBdQvnPilyOJmKzVebRHySYrdstlVc47SUfNjrITsT8ba6EcN0+EjNe4LsZKhVml/B7hd+hA=
X-Received: by 2002:ab0:5a24:0:b0:3af:fbb1:2dfb with SMTP id
 l33-20020ab05a24000000b003affbb12dfbmr8893357uad.27.1663683717649; Tue, 20
 Sep 2022 07:21:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220904080247.7890-1-linux@dominikbrodowski.net> <Yxg7WQ1UuskDrBVj@gondor.apana.org.au>
In-Reply-To: <Yxg7WQ1UuskDrBVj@gondor.apana.org.au>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 20 Sep 2022 16:21:46 +0200
X-Gmail-Original-Message-ID: <CAHmME9oVKzJtAaBmtrrUT1n2f0_41wu2VF295ONKV3WUotbYxw@mail.gmail.com>
Message-ID: <CAHmME9oVKzJtAaBmtrrUT1n2f0_41wu2VF295ONKV3WUotbYxw@mail.gmail.com>
Subject: Re: [PATCH] random / hw_random: core: start hwrng kthread also for
 untrusted sources
To:     herbert@gondor.apana.org.au
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 7, 2022 at 8:34 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> >
> > diff --git a/drivers/char/random.c b/drivers/char/random.c
> > index 79d7d4e4e582..b360ed4ece03 100644
> > --- a/drivers/char/random.c
> > +++ b/drivers/char/random.c
> > @@ -867,9 +867,9 @@ void add_hwgenerator_randomness(const void *buf, size_t len, size_t entropy)
> >
> >        /*
> >         * Throttle writing to once every CRNG_RESEED_INTERVAL, unless
> > -        * we're not yet initialized.
> > +        * we're not yet initialized or this source isn't trusted.
> >         */
> > -       if (!kthread_should_stop() && crng_ready())
> > +       if (!kthread_should_stop() && (crng_ready() || !entropy))
> >                schedule_timeout_interruptible(CRNG_RESEED_INTERVAL);
> > }
> > EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
>
> Couldn't you split this bit out?

It's been two weeks and Dominik hasn't posted anything new, so I'm
going to do that for him. Patch incoming (retaining his authorship).

Jason
