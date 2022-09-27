Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94E35EBD67
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 10:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbiI0IfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 04:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiI0Ieh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:34:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BE91CB;
        Tue, 27 Sep 2022 01:34:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EABCC616C3;
        Tue, 27 Sep 2022 08:34:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02144C433B5;
        Tue, 27 Sep 2022 08:34:32 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BeuQ3Qnt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664267669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ls3g6qEVoyxJ/LRppKHOZrlHupBiDmkmlvpmcbvCVBg=;
        b=BeuQ3QntwPhr3dKqVxdDwUjrlGxCYXy6cgNvqsA3bYZGavIAh6kv44f+JYd6qCDunb2BPp
        Eh/DDxL6qQ/SeM4NV3xxGbp+oz0f4eKMjaRSz46jfJqdgvbcUBMq1bD+v1EOBynQz9nMvF
        1kdTBaM2t9QhG4LwqdXM4EJ0UgELQek=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f2e7f81e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 27 Sep 2022 08:34:28 +0000 (UTC)
Received: by mail-ua1-f42.google.com with SMTP id s2so964500uae.1;
        Tue, 27 Sep 2022 01:34:28 -0700 (PDT)
X-Gm-Message-State: ACrzQf1iGF/bF/qAKOt24JaZw17o/2sskckXvK7BIz4Am9unXZOXkCSL
        6X7FaVjlwzJO32ef3ufk4hXmfUCHPBF6iIJm2u4=
X-Google-Smtp-Source: AMsMyM5zZc0GSJoMj25i2Bh88A0n1LAxv8890igtLA6QhnkuCbHokR818i1MqXLf53Ved5KTqhIWgp66jBz7aAZiJM0=
X-Received: by 2002:ab0:758a:0:b0:3af:2b2d:dae7 with SMTP id
 q10-20020ab0758a000000b003af2b2ddae7mr11153931uap.24.1664267667770; Tue, 27
 Sep 2022 01:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220926160332.1473462-1-Jason@zx2c4.com> <202209261105.9C6AEEEE1@keescook>
 <CAHmME9pFDzyKJd5ixyB9E05jkZvHShFimbiQsGTcdQO1E5R0QQ@mail.gmail.com> <202209262017.D751DDC38F@keescook>
In-Reply-To: <202209262017.D751DDC38F@keescook>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 27 Sep 2022 10:34:16 +0200
X-Gmail-Original-Message-ID: <CAHmME9qTf+aDmBen2dFXPmbDGkn1E4=oXqqeBRiguLCo7K9EhQ@mail.gmail.com>
Message-ID: <CAHmME9qTf+aDmBen2dFXPmbDGkn1E4=oXqqeBRiguLCo7K9EhQ@mail.gmail.com>
Subject: Re: [PATCH] random: split initialization into early arch step and
 later non-arch step
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-hardening@vger.kernel.org
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

On Tue, Sep 27, 2022 at 5:23 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Sep 26, 2022 at 08:52:39PM +0200, Jason A. Donenfeld wrote:
> > On Mon, Sep 26, 2022 at 8:22 PM Kees Cook <keescook@chromium.org> wrote:
> > > Can find a way to get efi_get_random_bytes() in here too? (As a separate
> > > patch.) I don't see where that actually happens anywhere currently,
> > > and we should have it available at this point in the boot, yes?
> >
> > No, absolutely not. That is not how EFI works. EFI gets its seed to
> > random.c much earlier by way of add_bootloader_randomness().
>
> Ah! Okay, so, yes, it _does_ get entropy in there, just via a path I
> didn't see?

Yes.

> > Yes, we could maybe *change* to using init_utsname if we wanted. That
> > seems kind of different though. So I'd prefer that to be a different
> > patch, which would require looking at the interaction with early
> > hostname setting and such. If you want to do that work, I'd certainly
> > welcome the patch.
>
> Er, isn't that _WAY_ later? Like, hostname isn't set until sysctls up
> and running, etc. I haven't actually verified 100% but it looks like
> current->utsname is exactly init_utsname currently.

If init_utsname()==utsname() and all is fine, can you please send a
patch atop random.git adjusting that and explaining why? I would
happily take such a patch. If your suspicion is correct, it would make
a most welcome improvement.

> > > Was there a reason kfence_init() was happening before time_init()?
> >
> > Historically there was, I think, because random_init() used to make
> > weird allocations. But that's been gone for a while. At this point
> > it's a mistake, and removing it allows me to do this:
> >
> > https://groups.google.com/g/kasan-dev/c/jhExcSv_Pj4
>
> Cool. Is that true for all the -stable releases this is aimed at?

Yes.

Though I'll likely drop the stable@ tag for this, and instead visit
backporting it later in 6.1's cycle, or even after. There's no need to
rush it, and this is an area that has been historically temperamental.

Jason
