Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AF56DF8A5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjDLOgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjDLOfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:35:55 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8686B903A;
        Wed, 12 Apr 2023 07:35:33 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id ld14so9576749qvb.13;
        Wed, 12 Apr 2023 07:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681310132; x=1683902132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHkcIU7rc3ebfaK8LBPNnKR0o/dDri4Ykk2Lt1sdDxc=;
        b=lnTFwKmjT4HteMYgDgpyDfifNh4fEwpWx1sGbpanoJvBVNU2usgiSQtu/1/FOgJjz8
         C3XfiGZtufrjKtNvlnTuH+AoLhvUqKylYk7Gds3Q22PmVHhf4fkFQ4dJOTAaNR85b+HQ
         BB6p1iWHoR1FtsS2Kr2+GdPfa40xolMUCvRnvAND7EMWTQ2K+pkwULMK8bKcKpHJLccf
         toKW1qexK1S4vDX7AbuFZ3jguuEOpZ+xoa9U3WZ/KFXgQTB+ltQ0HNigqIGLxjO0GoHK
         Gd9eO6/aeaCQKXWnevUN+JOuYVnSXDksB0RMMIE/kMFU8CXv6IqVNSDyMWck6PeffV2x
         mohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681310132; x=1683902132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHkcIU7rc3ebfaK8LBPNnKR0o/dDri4Ykk2Lt1sdDxc=;
        b=PbPPlmuQSn+o1soejC5USZ4HNv3LODVgRO0PNTr5SYWubtrkjlZprU4y9xe4BF7J7U
         +hcmDBGLSUdzjjN+0sS4h7AlkfXRT/Nh6pdEgGjPA/6LbAc/fcIyhP/qU+mE9DsAueLN
         2JyMSqN117u1RLJC0TkL8WnYz/50fOrN3eXwqkTNSe78F6mvJ1XRIUiR826LLbQ3IMGB
         1SZsCrrzIE79dEOPcsMkRqcWe+cEtgDhr7ipUZSQ99RsKGPIJuUGPxe35HNKXlP7sai/
         5RuBaMMHqnMQC6IASwbvO0brdUNvdXhjAWpkwV3wE/NqFw46BJz4rOJEzDbj7xz+4SiJ
         /hSA==
X-Gm-Message-State: AAQBX9evLvEWVi0YaMBGrokgzg85d/qlUqDfQ+u0JbluUld3DiYwdJ9b
        53Y0Y9XTM1eyQFFPb7v1vvU=
X-Google-Smtp-Source: AKy350YF5VGAX6u7avFkWoscCQE0TC9bRSdNMax3xT7GNZDlhSlwsDNUbxA8sxKQDtmMIg5w8aLHpg==
X-Received: by 2002:a05:6214:f2f:b0:5e6:aa6a:1b with SMTP id iw15-20020a0562140f2f00b005e6aa6a001bmr28302024qvb.49.1681310132522;
        Wed, 12 Apr 2023 07:35:32 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id mb4-20020a056214550400b005dd8b934585sm4870364qvb.29.2023.04.12.07.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 07:35:31 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4828727C0054;
        Wed, 12 Apr 2023 10:35:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 12 Apr 2023 10:35:31 -0400
X-ME-Sender: <xms:ssE2ZOHWm-D6f07-5N-6isWgKr9hqqrYnvDmwLSeEIiagFLmqRnHcg>
    <xme:ssE2ZPW_yiKF8w7yPzi7QnvJvfMto08y4nGc1uUPXndD2rbcU6Jra4oMcTr6lY4uM
    OYTVv6AvQ9lWgDQRQ>
X-ME-Received: <xmr:ssE2ZIIxBlzT1WmbsIiQoDqJbrrTGagKmJjbMlYh6fqH9fK_rqhO89ToTXBO0YYm1vup9y8RxlH_eE7V1rhqxvuAtJELEORUWjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekiedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeeitdefvefhteeklefgtefhgeelkeefffelvdevhfehueektdevhfettddv
    teevvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:ssE2ZIFM2WO5Y-um_ggwBVVpGwVwESHnCxUWyguYQ0NqxgOEN-TniA>
    <xmx:ssE2ZEU9cV-2Bcrx3oUUG3mwektPsUjyVF2TRP9y8BXJrTS66MH9tg>
    <xmx:ssE2ZLOwxTLu4fZ3AO_yV1gXh-uORnfOdCA_4c5XEikL0EOPrDde6g>
    <xmx:ssE2ZIp-jNDzlE_11AeAIzslqmo7d9wW5CPhYylVg7YRhmZItLycfg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Apr 2023 10:35:30 -0400 (EDT)
Date:   Wed, 12 Apr 2023 07:35:28 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v4 11/13] rust: lock: add `Guard::do_unlocked`
Message-ID: <ZDbBsBIZwMhbquRG@Boquns-Mac-mini.local>
References: <20230411054543.21278-1-wedsonaf@gmail.com>
 <20230411054543.21278-11-wedsonaf@gmail.com>
 <ZDZOzzMvvxr4rsW4@Boquns-Mac-mini.local>
 <CANeycqqpR6Gs5Qb_pc2j_QV-JAc8xR360vth6We8xWU1GU5ASA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANeycqqpR6Gs5Qb_pc2j_QV-JAc8xR360vth6We8xWU1GU5ASA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 08:07:40AM -0300, Wedson Almeida Filho wrote:
> On Wed, 12 Apr 2023 at 03:25, Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Tue, Apr 11, 2023 at 02:45:41AM -0300, Wedson Almeida Filho wrote:
> > [...]
> > > +
> > > +    unsafe fn relock(ptr: *mut Self::State, guard_state: &mut Self::GuardState) {
> > > +        let _ = match guard_state {
> > > +            // SAFETY: The safety requiments of this function ensure that `ptr` has been
> > > +            // initialised.
> > > +            None => unsafe { Self::lock(ptr) },
> > > +            // SAFETY: The safety requiments of this function ensure that `ptr` has been
> > > +            // initialised.
> > > +            Some(_) => unsafe { Self::lock_irqsave(ptr) },
> > > +        };
> > > +    }
> > >  }
> > >
> >
> > One thing I'm little worried about the above is that we don't store back
> > the new GuardState into `guard_state`, the particular case I'm worried
> > about is as follow:
> >
> >         // IRQ is enabled.
> >         // Disabling IRQ
> >         unsafe { bindings::local_irq_disable(); }
> >
> >         let mut g = unsafe { SpinLockBackend::lock(&mut lock as *mut _) };
> >         // `g` records irq state is "irq disabled"
> >
> >         unsafe { SpinLockBackend::unlock(&mut lock as *mut _, &g); }
> >         // restore into "irq disabled" mode.
> >         // IRQ is disabled.
> >
> >         // Enabling IRQ
> >         unsafe { bindings::local_irq_enable(); }
> >         // IRQ is enabled.
> >
> >         unsafe { SpinLockBackend::relock(&mut lock as *mut _, &mut g) }
> >         // `g` still records irq state is "irq disabled"
> 
> Yes, that's by design. If you want it to record the new "irq enabled"
> state, then you should call `lock()`, not `relock()`.
> 
> >         unsafe { SpinLockBackend::unlock(&mut lock as *mut _, &g); }
> >         // restore into "irq disabled" mode.
> >         // IRQ is disabled.
> >
> >
> > This looks pretty scary to me, I would expect `relock()` updates the
> > latest GuardState to the guard. Any reason it's implemented this way?
> 
> A `relock()` followed by an `unlock()` takes the state back to how it
> was when `lock()` was originally called: this is precisely why
> `relock()` exists.
> 
> Consider the following case:
> 
> ```
> local_disable_irq();
> let mut guard = spinlock.lock();

I think you meant `spinlock.lock_irqsave()` here, right?

> 
> guard.do_unlocked(|| {
>     local_irq_enable();
>     schedule();
> });
> 
> drop(guard);
> ```
> 
> What would you expect the state to be? It's meant to be the state

I understand your point but I would expect people to code like:

```
local_disable_irq();
let mut guard = spinlock.lock(); // or lock_irqsave(), doesn't matter

guard.do_unlocked(|| {
    local_irq_enable();
    schedule();
    local_irq_disable();
});

drop(guard);
```

And the closure in do_unlocked() can also be something like:
```
	guard.do_unlocked(|| {
	    local_irq_enabled();
	    let _g = ScopeGuard::new(|| {
	        local_irq_disabled();
	    });

	    schedule();

	    if (some_cond) {
	    	return; // return early
	    }

	    if (other_cond) {
	    	return;
	    }
	})

```

One benefit (other that code looks symmetric) is we can use the same
closure in other place. Also it helps klint since we keep the irq
enablement state change as local as possible: we can go ahead and
require irq enabled state should not be changed between the closure in
do_unlock().

Maybe I'm missing something, but the current `relock` semantics is
really tricky to get ;-)

Regards,
Boqun

> right before `spinlock.lock()` was called, that's what the guard
> represents.
> 
> If you want to preserve a new state, then you don't want `relock()`,
> you just want a new `lock()` call.
> 
> > Regards,
> > Boqun
> >
> > >  // SAFETY: The underlying kernel `spinlock_t` object ensures mutual exclusion. We use the `irqsave`
> > >  // variant of the C lock acquisition functions to disable interrupts and retrieve the original
> > >  // interrupt state, and the `irqrestore` variant of the lock release functions to restore the state
> > >  // in `unlock` -- we use the guard context to determine which method was used to acquire the lock.
> > > -unsafe impl super::IrqSaveBackend for SpinLockBackend {
> > > +unsafe impl IrqSaveBackend for SpinLockBackend {
> > >      unsafe fn lock_irqsave(ptr: *mut Self::State) -> Self::GuardState {
> > >          // SAFETY: The safety requirements of this function ensure that `ptr` points to valid
> > >          // memory, and that it has been initialised before.
> > > --
> > > 2.34.1
> > >
