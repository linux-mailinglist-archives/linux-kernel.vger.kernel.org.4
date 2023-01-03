Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D1D65C7CE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjACUDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 15:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjACUDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:03:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737BD6244;
        Tue,  3 Jan 2023 12:03:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECB5C614B4;
        Tue,  3 Jan 2023 20:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC1AC433EF;
        Tue,  3 Jan 2023 20:03:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="XVatXkuo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1672776190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZdGBYtenf9KxXkGsFOfF/k2UzSaOBjlov7xbIEO1hqo=;
        b=XVatXkuoV0uGA2AaTjRQihENTEl8P/ghrbSfd+C52hahB6oZ3eSLyNshSJamr1HuVuUgO0
        8garo777KMimsXexIpTlMxIpPKCNXANL7cp3WG5cMav2S3Ga3r9HKBjmkXVDnSOvXfdnwM
        QLN9+/SNe7BjC5yoNesisS2nMDH+uiI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id eb8698a6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 3 Jan 2023 20:03:10 +0000 (UTC)
Date:   Tue, 3 Jan 2023 21:03:07 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH v14 2/7] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
Message-ID: <Y7SJ+/axonTK0Fir@zx2c4.com>
References: <20230101162910.710293-1-Jason@zx2c4.com>
 <20230101162910.710293-3-Jason@zx2c4.com>
 <Y7QIg/hAIk7eZE42@gmail.com>
 <CALCETrWdw5kxrtr4M7AkKYDOJEE1cU1wENWgmgOxn0rEJz4y3w@mail.gmail.com>
 <CAHk-=wg_6Uhkjy12Vq_hN6rQqGRP2nE15rkgiAo6Qay5aOeigg@mail.gmail.com>
 <Y7SDgtXayQCy6xT6@zx2c4.com>
 <CAHk-=whQdWFw+0eGttxsWBHZg1+uh=0MhxXYtvJGX4t9P1MgNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whQdWFw+0eGttxsWBHZg1+uh=0MhxXYtvJGX4t9P1MgNw@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Tue, Jan 03, 2023 at 11:54:35AM -0800, Linus Torvalds wrote:
> So 99% of the time, the solution really is just "getrandom()",
> generally with the usual buffering ("read more than you need, so that
> you don't do it all the time").\

That buffering cannot be done safely currently -- VM forks, reseeding
semantics, and so forth. Again, discussed in the cover letter of the
patch if you'd like to engage with those ideas.

> just using your own rng in user space entirely.

This is the thing that isn't quite safe.

> Let me guess: the people you talked to who were excited about this are
> mainly just library people?

No, actually. Mainly people deploying production network-facing things
that need a lot of randomness often. e.g. CBC nonces in TLS, or random
sequence numbers in UDP-based protocols.

> So when you say that this isn't about micro-optimizations, I really
> say "humbug". It's *clearly* about micro-optimization of an area that
> very few people care about, since the alternative is just our existing
> "getrandom()" that is not at all horribly slow.

The alternative is what people currently do, which is attempt to
implement a userspace RNG, which cannot be done safely. Again, -->
cover letter.

> Because the people who actually *use* the random numbers and are *so*
> performance-critical about them already have their own per-thread
> buffers or what-not

...which are not safe.

Anyway, if you're NACK'ing the whole getrandom() vDSO project, just
please outright say so, so I don't spend another 14 revisions in vain.

Jason
