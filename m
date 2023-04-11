Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F756DE65A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 23:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjDKVTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 17:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjDKVTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 17:19:00 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28AB49C6;
        Tue, 11 Apr 2023 14:18:31 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id cg4so1303783qtb.11;
        Tue, 11 Apr 2023 14:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681247911; x=1683839911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I72JI0HmuhcR/9S4kGdSzNF4b8LMw2MFqyRGVWooTqA=;
        b=NyfMUmdlup5japawUMWJP3+HCA+WxfOkdxSOrEgWCpHW5Tu1GO1zpvA0d6xRk/iKzh
         pRfMtOoVE9pzxhcfmlXdr9Ree4i68RKp2CZkyK58uLme6ogj+q31wp0RiGjKvFYqUwwq
         9Hrqjhix8wxli7YWMKsFuBs1j5334k1IgLqAlYLIgGYlZ9aDoIU7mhumYuacq5KAQv5q
         yLyXBi6m1yeJDVeFHyxeMY3U6e9XpzzNI3SR4GwhPngeBbFWBtzdjdiQwUtdqLHjKQwn
         8C/vAF92I2V2gvjY5+PwZ5xWrq7XAWtAEG3bsGSZ3FOFUQYyNBqCeMqIjtJXiQK0vAi+
         gLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681247911; x=1683839911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I72JI0HmuhcR/9S4kGdSzNF4b8LMw2MFqyRGVWooTqA=;
        b=aIwfNImOPILc1HtwZls0qKpxnpKF7hNX5ndz4/LuPeLMe1KzoVk3YNrRFZiXYRpe1I
         VKb3Czj0TZRm1Bsvu05RuHo2Y7asrukJSkutZWXlW51K8+d9SCe+0Q1PTOLbDwLVTzR1
         WhcJj6gPVbb0QPOn2ZUpAh7DhIYYPQQY8y5ReH5y8W2NcW3JursXyx53ICLgKcMiml0P
         2D7gWW5YhOBPug1ONyHb9i3H+U8MWJynzntbo9E6yOmezqVV1MrKBqNoP0Jg0NQzN+w8
         +fu0shNKRjY7zwderMry62X+UlvdQotxn+196g7YLCn9F7SuUhsYW3u46S7TYu7RrErI
         1g8g==
X-Gm-Message-State: AAQBX9enovOmRTjbeciv9v9iq9rG8wNaUkOjpEdghH9Iupwe5GUan8bg
        UwYWGggbXIU/IcpLyatgW3w=
X-Google-Smtp-Source: AKy350bzAcSBlkBP/1soVpvos54/6iaYEHKV3gd9RQABlIbmkfa7wCxxQxUsOGIxBdjdDWjDAj56dw==
X-Received: by 2002:a05:622a:144d:b0:3e6:6502:16a2 with SMTP id v13-20020a05622a144d00b003e6650216a2mr6526098qtx.38.1681247910708;
        Tue, 11 Apr 2023 14:18:30 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id r14-20020ac867ce000000b003b835e7e283sm3845148qtp.44.2023.04.11.14.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 14:18:30 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 80ABF27C0054;
        Tue, 11 Apr 2023 17:18:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 11 Apr 2023 17:18:29 -0400
X-ME-Sender: <xms:pc41ZKKokh0WKLBI0UERgPPkrK98lUI_FffWY0fX6O3XbkNL9b50aw>
    <xme:pc41ZCJ1QZRJ2eXGlKNcGItBn-R7wWt7KDKk9Tm7AG0YjvzhEYysc6ezEszU5Zibs
    EtdfAwxMyArKnCH5w>
X-ME-Received: <xmr:pc41ZKvD012Z8kCVEKSfxg-tQuJmLwNlEPGyPlob_lvWRm-rkgD4mwjcf_0LMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekgedgudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:pc41ZPZdfSVxzovzgOaAxtIUynbNVOf5CS7Zy4HbMUWXu9XCeTrjUw>
    <xmx:pc41ZBbK18cOcoQI2W50Fy1sadRb4reHLllc0xEcI91Sz5z116VrKQ>
    <xmx:pc41ZLBrn9eFbew3cAt4d-8IwyTS9E4MLerlsEsa_iRszINBicvfhQ>
    <xmx:pc41ZPPsdnttDoROyiVfbpsoVVIAtX8Aiac8IWsINh8k-I_tWv15lA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Apr 2023 17:18:28 -0400 (EDT)
Date:   Tue, 11 Apr 2023 14:17:09 -0700
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
Message-ID: <ZDXOVXFlq7eXRTIS@boqun-archlinux>
References: <20230411054543.21278-1-wedsonaf@gmail.com>
 <20230411054543.21278-11-wedsonaf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411054543.21278-11-wedsonaf@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 02:45:41AM -0300, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> It releases the lock, executes some function provided by the caller,
> then reacquires the lock. This is preparation for the implementation of
> condvars, which will sleep after between unlocking and relocking.
> 
> We need an explicit `relock` method for primitives like `SpinLock` that
> have an irqsave variant: we use the guard state to determine if the lock
> was originally acquired with the regular `lock` function or
> `lock_irqsave`.
> 
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
> v1 -> v2: No changes
> v2 -> v3: No changes
> v3 -> v4: No changes
> 
>  rust/kernel/sync/lock.rs          | 25 +++++++++++++++++++++++++
>  rust/kernel/sync/lock/spinlock.rs | 17 +++++++++++++++--
>  2 files changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index 819b8ea5ba2b..cde57756795f 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -22,6 +22,9 @@ pub mod spinlock;
>  ///
>  /// - Implementers must ensure that only one thread/CPU may access the protected data once the lock
>  /// is owned, that is, between calls to `lock` and `unlock`.
> +/// - Implementers must also ensure that `relock` uses the same locking method as the original
> +/// lock operation. For example, it should disable interrupts if [`IrqSaveBackend::lock_irqsave`]
> +/// is used.
>  pub unsafe trait Backend {
>      /// The state required by the lock.
>      type State;
> @@ -55,6 +58,17 @@ pub unsafe trait Backend {
>      ///
>      /// It must only be called by the current owner of the lock.
>      unsafe fn unlock(ptr: *mut Self::State, guard_state: &Self::GuardState);
> +
> +    /// Reacquires the lock, making the caller its owner.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `state` comes from a previous call to [`Backend::lock`] (or

I think you mean

"Callers must ensure that `guard_state` comes ..."

, right?

Regards,
Boqun

> +    /// variant) that has been unlocked with [`Backend::unlock`] and will be relocked now.
> +    unsafe fn relock(ptr: *mut Self::State, guard_state: &mut Self::GuardState) {
> +        // SAFETY: The safety requirements ensure that the lock is initialised.
> +        *guard_state = unsafe { Self::lock(ptr) };
> +    }
>  }
>  
>  /// The "backend" of a lock that supports the irq-save variant.
> @@ -164,6 +178,17 @@ pub struct Guard<'a, T: ?Sized, B: Backend> {
>  // SAFETY: `Guard` is sync when the data protected by the lock is also sync.
>  unsafe impl<T: Sync + ?Sized, B: Backend> Sync for Guard<'_, T, B> {}
>  
> +impl<T: ?Sized, B: Backend> Guard<'_, T, B> {
> +    #[allow(dead_code)]
> +    pub(crate) fn do_unlocked(&mut self, cb: impl FnOnce()) {
> +        // SAFETY: The caller owns the lock, so it is safe to unlock it.
> +        unsafe { B::unlock(self.lock.state.get(), &self.state) };
> +        cb();
> +        // SAFETY: The lock was just unlocked above and is being relocked now.
> +        unsafe { B::relock(self.lock.state.get(), &mut self.state) };
> +    }
> +}
> +
>  impl<T: ?Sized, B: Backend> core::ops::Deref for Guard<'_, T, B> {
>      type Target = T;
>  
> diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
> index 34dec09a97c0..e2a2f68e6d93 100644
> --- a/rust/kernel/sync/lock/spinlock.rs
> +++ b/rust/kernel/sync/lock/spinlock.rs
> @@ -4,6 +4,7 @@
>  //!
>  //! This module allows Rust code to use the kernel's `spinlock_t`.
>  
> +use super::IrqSaveBackend;
>  use crate::bindings;
>  
>  /// Creates a [`SpinLock`] initialiser with the given name and a newly-created lock class.
> @@ -95,7 +96,8 @@ pub type SpinLock<T> = super::Lock<T, SpinLockBackend>;
>  /// A kernel `spinlock_t` lock backend.
>  pub struct SpinLockBackend;
>  
> -// SAFETY: The underlying kernel `spinlock_t` object ensures mutual exclusion.
> +// SAFETY: The underlying kernel `spinlock_t` object ensures mutual exclusion. `relock` uses the
> +// same scheme as `unlock` to figure out which locking method was used originally.
>  unsafe impl super::Backend for SpinLockBackend {
>      type State = bindings::spinlock_t;
>      type GuardState = Option<core::ffi::c_ulong>;
> @@ -127,13 +129,24 @@ unsafe impl super::Backend for SpinLockBackend {
>              None => unsafe { bindings::spin_unlock(ptr) },
>          }
>      }
> +
> +    unsafe fn relock(ptr: *mut Self::State, guard_state: &mut Self::GuardState) {
> +        let _ = match guard_state {
> +            // SAFETY: The safety requiments of this function ensure that `ptr` has been
> +            // initialised.
> +            None => unsafe { Self::lock(ptr) },
> +            // SAFETY: The safety requiments of this function ensure that `ptr` has been
> +            // initialised.
> +            Some(_) => unsafe { Self::lock_irqsave(ptr) },
> +        };
> +    }
>  }
>  
>  // SAFETY: The underlying kernel `spinlock_t` object ensures mutual exclusion. We use the `irqsave`
>  // variant of the C lock acquisition functions to disable interrupts and retrieve the original
>  // interrupt state, and the `irqrestore` variant of the lock release functions to restore the state
>  // in `unlock` -- we use the guard context to determine which method was used to acquire the lock.
> -unsafe impl super::IrqSaveBackend for SpinLockBackend {
> +unsafe impl IrqSaveBackend for SpinLockBackend {
>      unsafe fn lock_irqsave(ptr: *mut Self::State) -> Self::GuardState {
>          // SAFETY: The safety requirements of this function ensure that `ptr` points to valid
>          // memory, and that it has been initialised before.
> -- 
> 2.34.1
> 
