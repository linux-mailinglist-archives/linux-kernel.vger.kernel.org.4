Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D606DF28A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjDLLHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDLLHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:07:53 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B56D6A60;
        Wed, 12 Apr 2023 04:07:52 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-54c061acbc9so351658207b3.11;
        Wed, 12 Apr 2023 04:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681297671;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+0tHhoLaNH21wv0oq5mHGI1fOn2fqnxMjXKIfupUAhY=;
        b=e+swkbxqpSikjMu4Ym4/TcQ6kqy9uQ3Geo9IvLWoYrR77zM4L1lJBhLSISGU5J1Sgm
         xHHk5vS38naiRIRK4WLlRLso1dMAh8h5c0NLaE9v7PEebn9niewxb4lncH+Mfakeycfq
         KL0vtdtS/kRHbpdpbqjimd21xhTMEzgy2EhKdZF0MsDxdTgdtkcjYA19jWkqJQ4Cvnul
         ty6NbM52DcuXqqunzXLQf1CemY2SPtUWkyrg8OE1VznNOtVh4/ElfBurpgG0UqEi4aeF
         OE6aTqxRoUA+338Vd5f75CbPj7l4nHx788g5QOxkPRd/G/eQHPQxMOwHmu2Ff3h7H+Jd
         R5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681297671;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+0tHhoLaNH21wv0oq5mHGI1fOn2fqnxMjXKIfupUAhY=;
        b=D5Jr0krUe0EoQfrmYG/QahSgcdsGn3ONtdMSSDKTlkqLCNxwARIRRnc7FIHdYT+zSm
         5Vsn1Ve3tKt4Siun6LkUSIV0PyKTSt2Nfsq+GLTNCOLz16cjWoD5Or1nIHTdPRZx6Ix7
         EvBmylw7zYGVro+L49A0bJqd/E2I8dvUPv1dt5Dc3WaObwD9SywJN96fbSVYk1lCS0K4
         VB7o6ulCSlXWDh7wPd9NI0S+dDP6lqgpkulV4ljEo5urxsUlPbVFQ/A3Lt0vqBQhaI7S
         aFVooOMm0oxz0QNd9Kb9dnuawScwyd/J77awU894RWfbT2P9W9awwHKpR0/I21qyIihG
         T5nA==
X-Gm-Message-State: AAQBX9dantb8yaUc/89VxtqeQOZwdD7/zLsNjYY4i4ug3BdLYVo2Qfzp
        H9w2vDFlkqJijZy99LBIU3esQx72AWvzKpWsPIE=
X-Google-Smtp-Source: AKy350Y6pqOnwZEL92tv7EI/FvQHD+G5n+I4rzULnolMOyCFbynl2b3l6MESX3o1NwyErd7LTsYLBRsNJdUaPe7qW3I=
X-Received: by 2002:a81:af0c:0:b0:54c:c979:7f95 with SMTP id
 n12-20020a81af0c000000b0054cc9797f95mr7858106ywh.9.1681297671489; Wed, 12 Apr
 2023 04:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230411054543.21278-1-wedsonaf@gmail.com> <20230411054543.21278-11-wedsonaf@gmail.com>
 <ZDZOzzMvvxr4rsW4@Boquns-Mac-mini.local>
In-Reply-To: <ZDZOzzMvvxr4rsW4@Boquns-Mac-mini.local>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Wed, 12 Apr 2023 08:07:40 -0300
Message-ID: <CANeycqqpR6Gs5Qb_pc2j_QV-JAc8xR360vth6We8xWU1GU5ASA@mail.gmail.com>
Subject: Re: [PATCH v4 11/13] rust: lock: add `Guard::do_unlocked`
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2023 at 03:25, Boqun Feng <boqun.feng@gmail.com> wrote:
>
> On Tue, Apr 11, 2023 at 02:45:41AM -0300, Wedson Almeida Filho wrote:
> [...]
> > +
> > +    unsafe fn relock(ptr: *mut Self::State, guard_state: &mut Self::GuardState) {
> > +        let _ = match guard_state {
> > +            // SAFETY: The safety requiments of this function ensure that `ptr` has been
> > +            // initialised.
> > +            None => unsafe { Self::lock(ptr) },
> > +            // SAFETY: The safety requiments of this function ensure that `ptr` has been
> > +            // initialised.
> > +            Some(_) => unsafe { Self::lock_irqsave(ptr) },
> > +        };
> > +    }
> >  }
> >
>
> One thing I'm little worried about the above is that we don't store back
> the new GuardState into `guard_state`, the particular case I'm worried
> about is as follow:
>
>         // IRQ is enabled.
>         // Disabling IRQ
>         unsafe { bindings::local_irq_disable(); }
>
>         let mut g = unsafe { SpinLockBackend::lock(&mut lock as *mut _) };
>         // `g` records irq state is "irq disabled"
>
>         unsafe { SpinLockBackend::unlock(&mut lock as *mut _, &g); }
>         // restore into "irq disabled" mode.
>         // IRQ is disabled.
>
>         // Enabling IRQ
>         unsafe { bindings::local_irq_enable(); }
>         // IRQ is enabled.
>
>         unsafe { SpinLockBackend::relock(&mut lock as *mut _, &mut g) }
>         // `g` still records irq state is "irq disabled"

Yes, that's by design. If you want it to record the new "irq enabled"
state, then you should call `lock()`, not `relock()`.

>         unsafe { SpinLockBackend::unlock(&mut lock as *mut _, &g); }
>         // restore into "irq disabled" mode.
>         // IRQ is disabled.
>
>
> This looks pretty scary to me, I would expect `relock()` updates the
> latest GuardState to the guard. Any reason it's implemented this way?

A `relock()` followed by an `unlock()` takes the state back to how it
was when `lock()` was originally called: this is precisely why
`relock()` exists.

Consider the following case:

```
local_disable_irq();
let mut guard = spinlock.lock();

guard.do_unlocked(|| {
    local_irq_enable();
    schedule();
});

drop(guard);
```

What would you expect the state to be? It's meant to be the state
right before `spinlock.lock()` was called, that's what the guard
represents.

If you want to preserve a new state, then you don't want `relock()`,
you just want a new `lock()` call.

> Regards,
> Boqun
>
> >  // SAFETY: The underlying kernel `spinlock_t` object ensures mutual exclusion. We use the `irqsave`
> >  // variant of the C lock acquisition functions to disable interrupts and retrieve the original
> >  // interrupt state, and the `irqrestore` variant of the lock release functions to restore the state
> >  // in `unlock` -- we use the guard context to determine which method was used to acquire the lock.
> > -unsafe impl super::IrqSaveBackend for SpinLockBackend {
> > +unsafe impl IrqSaveBackend for SpinLockBackend {
> >      unsafe fn lock_irqsave(ptr: *mut Self::State) -> Self::GuardState {
> >          // SAFETY: The safety requirements of this function ensure that `ptr` points to valid
> >          // memory, and that it has been initialised before.
> > --
> > 2.34.1
> >
