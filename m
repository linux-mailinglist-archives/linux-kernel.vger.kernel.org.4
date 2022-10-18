Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22F6602774
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiJRIsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiJRIs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:48:29 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF43220F67
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:48:28 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id a13so19493852edj.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eoRiuU9V2WhvCPPrdX4BURCWAuCZBmpxPF9L89jLsOQ=;
        b=gUmSCUCJbOcxJXEEgGaETNcA07Tv9Z/WeSqkgNfjCccoOupnpdmXsDO2JVMUbmEuut
         rBPlCkB5uuPqgqgjMvdMEXqn8+MEpcpNsDX8JXOwd8o1uyPHmyjK0L9Fe1FU700xg6n/
         fqRDbwucSCpw8P8EWxE3ZJb8TBSgoQTtNz4f8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eoRiuU9V2WhvCPPrdX4BURCWAuCZBmpxPF9L89jLsOQ=;
        b=MyfV1FbnGM7TWB4C3eb+f5r0mcVr7Bg3CSBU528jY7dOdxwrrsgSJDPv3FfQE2w17w
         +Ft5R+GHRFl14zc9lhvcpx/UWfrNNgFPEUwGoqX775JAj9LEpQpeBBclIS8EW3Y+eypg
         /aTtYmSJaDdB1KBUqwZPJd7jwGF2CIAvW11sEIGcP9W9XD3sVXBofX2h6qESsA35gCsl
         Js6Z/yftBxsVMrDyfaSmDwbZ6/Nx3nJbdxkQ0o9XM6pVsLev+j8Iz+iGZe39uBhESz1J
         rVc/TpVXnntDdLpN0NgqipyQYaFYdNHyYCKJ4g6t5um5vaknDqZLJKhj3t4NBapcK7K1
         qxYA==
X-Gm-Message-State: ACrzQf3wNUqhtHdUlQz5LGY4sEaSkQM3AOSiVSDI53ecb/imFFWNuXC2
        flFDHFDL3ftzSRPIKSg7i1KB5/FQZT8Azr+nuaDmpw==
X-Google-Smtp-Source: AMsMyM6G5inBCr/z7iG+g0Z+flcQJMNmqRamCOm5Tzqd2zDPrn2EokhnBWOdwzjFn3Gml4KaX6OBMno8a3y7+1QHTs4=
X-Received: by 2002:a05:6402:3896:b0:45c:93c3:3569 with SMTP id
 fd22-20020a056402389600b0045c93c33569mr1659759edb.37.1666082907394; Tue, 18
 Oct 2022 01:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220922224027.59266-1-ivan@cloudflare.com> <20221017184700.e1e6944e743bfc38e9abd953@linux-foundation.org>
 <CABWYdi1UJsi1iGOAME1tW5eJdqvo3XJidWyO97ksxS85w3ZUPQ@mail.gmail.com>
 <CABEBQineydLjdHcc84+JuQnvEbGqkiXuVRXvcmk58bO=9X901Q@mail.gmail.com> <57b146037b5744d4877fd77b1e4db262@AcuMS.aculab.com>
In-Reply-To: <57b146037b5744d4877fd77b1e4db262@AcuMS.aculab.com>
From:   Frank Hofmann <fhofmann@cloudflare.com>
Date:   Tue, 18 Oct 2022 09:48:15 +0100
Message-ID: <CABEBQimNm_Ba6j=2cAc8Gw68K_8nVccrT=10LsSkMnTMbo9s3g@mail.gmail.com>
Subject: Re: [PATCH v2] proc: report open files as size in stat() for /proc/pid/fd
To:     David Laight <David.Laight@aculab.com>
Cc:     Ivan Babrou <ivan@cloudflare.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@cloudflare.com" <kernel-team@cloudflare.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Theodore Ts'o" <tytso@mit.edu>, Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Mike Rapoport <rppt@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 9:25 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Frank Hofmann
> > Sent: 18 October 2022 09:13
> >
> > On Tue, Oct 18, 2022 at 6:02 AM Ivan Babrou <ivan@cloudflare.com> wrote:
> > >
> > > On Mon, Oct 17, 2022 at 6:47 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > > > +
> > > > > +             fdt = files_fdtable(p->files);
> > > > > +             size = fdt->max_fds;
> > > > > +
> > > > > +             for (i = size / BITS_PER_LONG; i > 0;)
> > > > > +                     open_fds += hweight64(fdt->open_fds[--i]);
> > > >
> > > > Could BITMAP_WEIGHT() or __bitmap_weight() or bitmap_weight() be used here?
> > >
> > > That's a great suggestion. I tested it with bitmap_weight() and it
> > > looks much cleaner while providing the same result.
> > >
> > > I just sent the v3 with this suggestion applied.
> >
> > +1 from me on using bitmap_weight() - good spotting that.
>
> Does that have the optimisations for the value being 0, ~0u
> or 2**n-1 all of which are likely for the fd table.
> (Especially if there is no 'popcnt' instruction.)
>
>         David

bitmap_weight() uses hweight_*() under the hood, which then falls
through to platform-specific popcnt where available.
Re, lib/bitmap.c and arch/.../asm/bitops.h or arch/.../hweight.S, for
the impl details.

FrankH.

>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
