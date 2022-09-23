Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8CF5E78A6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 12:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbiIWKtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 06:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiIWKtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 06:49:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC041162F4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:49:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AE42616DA
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B854BC433B5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:49:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="i09TvaXH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1663930140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g5BvvWn/c9J8DtEiYiWxSvAf3bCW8cJkf2I6iaXDLvo=;
        b=i09TvaXHY5OGcaQ/soqd/tqkZ9LQohDI4QIiRxAEx+sTCLZpowaYfG46+DP8y49VNgv3lx
        QN9Zd8rnejCFyg9PFUPQzCIPHPrFHenglVY6MAoK5Pjl1gQcLRf8ZuZzlSmUen++HKElSY
        h5xcTZ8NLnOF1gfy0XJfDI6VvLn0ncc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 29ac7f10 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 23 Sep 2022 10:49:00 +0000 (UTC)
Received: by mail-vs1-f51.google.com with SMTP id k2so13222480vsk.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:48:59 -0700 (PDT)
X-Gm-Message-State: ACrzQf0EAhe0l2KWH/KIG64AqVjW3Afn9UR0Vq2lgRdZC9AFRiUdbpWh
        F455vjVdZuyBI9KsNwRecTvGA0xonUHJQaz6Tms=
X-Google-Smtp-Source: AMsMyM4AmtUGWDcJ69P3APwiFbOIO+3oYByDQpOjEMcykoaLJ5BH7bLoemcEC4f5HVxbvBPzMjT20NkajQmY7uX1XAw=
X-Received: by 2002:a67:c289:0:b0:398:cdc:c3ef with SMTP id
 k9-20020a67c289000000b003980cdcc3efmr3354381vsj.76.1663930139018; Fri, 23 Sep
 2022 03:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220923100621.3888015-1-Jason@zx2c4.com> <Yy2MDWCHTW0M3Z6i@smile.fi.intel.com>
 <CAHmME9osJiKg8-o-OdfCPS6t_fZ=zgGKZdy0CgybaK2NDv8XLA@mail.gmail.com>
In-Reply-To: <CAHmME9osJiKg8-o-OdfCPS6t_fZ=zgGKZdy0CgybaK2NDv8XLA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 23 Sep 2022 12:48:48 +0200
X-Gmail-Original-Message-ID: <CAHmME9p+SKTHzniw=TsC=vnQsyCuBa08+LcK-CsFcjA58K+ifA@mail.gmail.com>
Message-ID: <CAHmME9p+SKTHzniw=TsC=vnQsyCuBa08+LcK-CsFcjA58K+ifA@mail.gmail.com>
Subject: Re: [PATCH] minmax: clamp more efficiently by avoiding extra comparison
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
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

Hey again,

On Fri, Sep 23, 2022 at 12:40 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Andy,
>
> On Fri, Sep 23, 2022 at 12:36 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Fri, Sep 23, 2022 at 12:06:21PM +0200, Jason A. Donenfeld wrote:
> > > Currently the clamp algorithm does:
> > >
> > >       if (val > hi)
> > >               val = hi;
> > >       if (val < lo)
> > >               val = lo;
> > >
> > > But since hi > lo by definition, this can be made more efficient with:
> >
> > It's strongly speaking, but we have to proof that, right?
> > So, while I haven't checked the code, this change should also
> > include (does it?) the corresponding compile-time checks (for
> > constant arguments) in similar way how it's done for GENMASK().
> >
> > Otherwise I have no objections.
>
> I think most cases are with compile time constants, but some cases are
> with variables. What should we do in that case? Checking variables at
> runtime incurs the same cost as the old code. I guess we could do this
> fast thing for constants and the slower old thing for non-constants?
> Or not do either, keep this commit as is, and just accept that if you
> pass bogus bounds to clamp, you're going to end up with something
> weird, which is already the case now so not a big deal?

Actually, yea, I think we should keep this commit as-is and not add
additional checking becauseeeee not only is hi>lo by definition, but
both for the old code and for the new code, the result of lo>hi is
total nonsense:

Assuming hi > lo, these snippets all yield the same result:

        if (val > hi)
                val = hi;
        if (val < lo)
                val = lo;

        if (val > hi)
                val = hi;
        else if (val < lo)
                val = lo;

        if (val < lo)
                val = lo;
        if (val > hi)
                val = hi;

        if (val < lo)
                val = lo;
        else if (val > hi)
                val = hi;

Assuming lo > hi, and the first condition triggers, these snippets all
yield different results, all of which are undefined nonsense:

        if (val > hi)
                val = hi;
        if (val < lo)
                val = lo;
--> val is lo

        if (val > hi)
                val = hi;
        else if (val < lo)
                val = lo;
--> val is hi

        if (val < lo)
                val = lo;
        if (val > hi)
                val = hi;
--> val is hi

        if (val < lo)
                val = lo;
        else if (val > hi)
                val = hi;
--> val is lo

Jason
