Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D285BD007
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 17:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiISPGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 11:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiISPGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:06:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406632A244;
        Mon, 19 Sep 2022 08:06:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FC94B81C88;
        Mon, 19 Sep 2022 15:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8740C43140;
        Mon, 19 Sep 2022 15:06:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DTemwdZG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1663599957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zKkl3xs4dw9Lj94MomA5+nV3PBnjgpv2vQC+E9dtRb0=;
        b=DTemwdZG2NWKTArNvqDEty4lsvTYPeqccgWfm4uOUcZdI+X5XgGDhxRw3fcLxHsuDmRYzP
        +aAo9H2Ej6mPRpJSwdttRXAnDa+6IIZruvUJmY5vlKmyFCGQ38akyEPaHP6udMZRUOr7MW
        Vx3at90n9QEQke9/wFxdNDHJ/838lzc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c802ce19 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 19 Sep 2022 15:05:56 +0000 (UTC)
Received: by mail-vs1-f46.google.com with SMTP id h1so30193492vsr.11;
        Mon, 19 Sep 2022 08:05:56 -0700 (PDT)
X-Gm-Message-State: ACrzQf0yA3cJtP0Lo7RM67yJNzqdQcVgN6s2/j3bVEgE52wmVp/ZWDpd
        jXhu8j9v25nBv9niwwzk0BS2eWwLS7NLdAgafaA=
X-Google-Smtp-Source: AMsMyM567j3Pj5pr8wh9Nv9BjTKNZ26smjhrXY029BSGlw07mcfnzhEdyT9CaygUAEd3qOg24KoPZzpRJvw+fOYZ1SM=
X-Received: by 2002:a67:e401:0:b0:398:89f1:492f with SMTP id
 d1-20020a67e401000000b0039889f1492fmr6927638vsf.21.1663599954306; Mon, 19 Sep
 2022 08:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220915002235.v2.1.I7c0a79e9b3c52584f5b637fde5f1d6f807605806@changeid>
 <CAHmME9rhunb05DEnc=UfGr8k9_LBi1NW2Hi0OsRbGwcCN2NzjQ@mail.gmail.com> <CAM7w-FXHWzcN1Y7pwb6+1KA6A2oZRrfpOJdWFVWjRvjbp+DEOg@mail.gmail.com>
In-Reply-To: <CAM7w-FXHWzcN1Y7pwb6+1KA6A2oZRrfpOJdWFVWjRvjbp+DEOg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 19 Sep 2022 17:05:41 +0200
X-Gmail-Original-Message-ID: <CAHmME9qmiNcs6iye=Yjnpfx7vy6QMd8t8nuVOg7omOhOdkN-Hw@mail.gmail.com>
Message-ID: <CAHmME9qmiNcs6iye=Yjnpfx7vy6QMd8t8nuVOg7omOhOdkN-Hw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] random: move add_hwgenerator_randomness()'s wait
 outside function
To:     Sven van Ashbrook <svenva@chromium.org>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Olivia Mackall <olivia@selenic.com>,
        Alex Levin <levinale@google.com>,
        Andrey Pronin <apronin@google.com>,
        Stephen Boyd <swboyd@google.com>,
        Rajat Jain <rajatja@google.com>,
        Eric Biggers <ebiggers@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-crypto@vger.kernel.org
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

On Mon, Sep 19, 2022 at 5:03 PM Sven van Ashbrook <svenva@chromium.org> wrote:
>
> On Fri, Sep 16, 2022 at 10:51 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > The other thing that occurred to me when reading this patch in context
> > of the other one is that this sleep you're removing here is not the
> > only sleep in the call chain. Each hwrng driver can also sleep, and
> > many do, sometimes for a long time, blocking until there's data
> > available, which might happen after minutes in some cases. So maybe
> > that's something to think about in context of this patchset -- that
> > just moving this to a delayed worker might not actually fix the issue
> > you're having with sleeps.
> >
>
> This is an excellent point. A look at tpm2_calc_ordinal_duration()
> reveals that tpm_transmit() may block for 300s at a time. So when
> we are using a WQ_FREEZABLE delayed_work, the PM may have to wait
> for up to 300s when draining the wq on suspend. That will introduce
> a lot of breakage in suspend/resume.
>
> Dominik: in light of this, please proceed with your patch, without
> rebasing it onto mine.
>
> + tpm maintainers Peter Huewe and Jarkko Sakkinen, a quick recap of
> the problem:
>
> - on ChromeOS we are seeing intermittent suspend/resume errors+warnings
>   related to activity of the core's hwrng_fillfn. this kthread keeps
>   runningduring suspend/resume. if this happens to kick off an bus (i2c)
>   transaction while the bus driver is in suspend, this triggers
>   a "Transfer while suspended" warning from the i2c core, followed by
>   an error return:
>
> i2c_designware i2c_designware.1: Transfer while suspended
> tpm tpm0: i2c transfer failed (attempt 1/3): -108
> [ snip 10s of transfer failed attempts]
>
> - in 2019, Stephen Boyd made an attempt at fixing this by making the
>   hwrng_fillfn kthread freezable. But a freezable thread requires
>   different API calls for scheduling, waiting, and timeout. This
>   generated regressions, so the solution had to be reverted.
>
> https://patchwork.kernel.org/project/linux-crypto/patch/20190805233241.220521-1-swboyd@chromium.org/
>
> - the current patch attempts to halt hwrng_fillfn during suspend by
>   converting it to a self-rearming delayed_work. The PM drains all
>   work before going into suspend. But, the potential minute-long
>   blocking delays in tpm make this solution infeasible.
>
> Peter and Jarkko, can you think of a possible way forward to eliminate
> the warnings+errors?
>
> -Sven


By the way, there was a recent ath9k patch that kind of went to a
similar tune. The solution was to make ath9k's hwrng driver sleep
using a hwrng-specific sleep function that allowed the core framework
to cancel that sleep. Maybe that's a potential solution here, or
something similar to it. Might be worth taking a look at that patch. I
think it's in one of Herbert's trees.

Jason
