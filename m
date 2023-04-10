Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519A86DCA91
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 20:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjDJSO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 14:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjDJSOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 14:14:23 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DEB1BF8;
        Mon, 10 Apr 2023 11:14:21 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id cj22so6408911qtb.3;
        Mon, 10 Apr 2023 11:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681150461; x=1683742461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgswBvjvPVN9EODWp24b5y7J/5TVQZ53Ui2VNPSM2t0=;
        b=f0TzmAHcGI1a8pEJQrld2hDmHAvYpBa13m61ZjIPEQly/FYWTybSgywtTR/zqjepSt
         UYoG3uynRj9B3jpwCdWLHzB4OZbvqKi3XdjwLpAUipDOgvLj0Gt7hfF5ynIHZaHkMrzN
         3jEWEIEEMy8BQCl6/w+ckTn9vuGe6e2v18mPmHVbAFUIQ5Qq5c2A7YrH/c3mgYmmWmNT
         mzoRXAgVBKJX4Beu2k61Ku8rBGmBBaid0bu9wSNhVLhGCyHdnZ5eIP9zqf4JK1+GP+ei
         lv/fPEWlkAzTRuBIkQFxzpSRXvYTyDsfzWXlvRqLDG32RXWZgOVy5j6UV+6uijLDY9+e
         hJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681150461; x=1683742461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgswBvjvPVN9EODWp24b5y7J/5TVQZ53Ui2VNPSM2t0=;
        b=p4xU9D+l+W8Kxb81Hm4JMm/Sdb+qbIRVSzX0qfwCi8GBBBFShT7Bl59yetAuu79xw6
         T5ZljbmJ/nUhW0HDVGHarwbio2kIVisMbLIy0O4jiGxRa7tHKxtHyTSp5AeZ06abmqDZ
         rKmW0zgPIbwa6agWHev7DnNqYmycYtJLnqrOl4GpF5qxJdZlBAiU7Uu/P0O+fPSvJuH8
         NwVkTrXvt6Us01/iWHcS94ZA4YzVZHS8TqnmLlWmcGQR4toHwxAA5AF1NpuRG+0MGY4a
         qMz2Sw2wNhS/MXHu5Me8A5KqpyoCrrmfj1V9mqOkunVIvZQGAtCi9xKHHEDYvYEFUbIW
         s9Yg==
X-Gm-Message-State: AAQBX9cuQx3KNeEqibrjdzvC8Jpiqqk22ztNKHGjaMjvxGPXmh1Mq+/E
        3jAPCPV+2LBZtcSiv5Cp6o6Gce6Z2SY=
X-Google-Smtp-Source: AKy350YZyyHC+BdnkNOp6zIPGk3yJVwnPCrViCa3+pGl4na8+pUJHxzlFnAM++4kCrPskpywtjm2Og==
X-Received: by 2002:a05:622a:1911:b0:3e4:eb8f:8a7b with SMTP id w17-20020a05622a191100b003e4eb8f8a7bmr29881478qtc.29.1681150460718;
        Mon, 10 Apr 2023 11:14:20 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id dm6-20020a05620a1d4600b00741a984943fsm3416726qkb.40.2023.04.10.11.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 11:14:19 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9B50327C0054;
        Mon, 10 Apr 2023 14:14:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 10 Apr 2023 14:14:19 -0400
X-ME-Sender: <xms:-1E0ZCdbnxHA8Taf3Blp99-BaNCIBjbhU8ChWOn4tVGWLsXpI60Uiw>
    <xme:-1E0ZMP1qM78QT3RoByQiVnjCsOLX8sk5eDz6JfZ9SLZs7wKDPRDjHbPfUYyDqwSK
    1-i7Aw6LtevxxID1w>
X-ME-Received: <xmr:-1E0ZDgu4muTxn4OmczjoDlgJGkZkmP871NT4TevBW1qPjoUoD-XQ3E7SNGnMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekvddguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:-1E0ZP9pV5U7jlGq-Wd2Kr0NHcyiDI7uOwUz3T2aHotjLv8596THew>
    <xmx:-1E0ZOv_yjSRor9QXk3wdu4ClCXAB6-F2D7edAPtQwEkBmgGs_ZhAg>
    <xmx:-1E0ZGG15hMA-D8-rH4jDMN3DXUN8f683As9ccAa48ZJIEhZgcXIxQ>
    <xmx:-1E0ZL92lzkEqAm9O2UA-sHKhZyAfN640J7uxFLXTgNrSBY4j5vtdg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Apr 2023 14:14:18 -0400 (EDT)
Date:   Mon, 10 Apr 2023 11:13:02 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH v3 13/13] rust: sync: introduce `LockedBy`
Message-ID: <ZDRRrnPZ0cAfEPTW@boqun-archlinux>
References: <20230408075340.25237-1-wedsonaf@gmail.com>
 <20230408075340.25237-13-wedsonaf@gmail.com>
 <ZDRLaDEnrLhQmW+F@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDRLaDEnrLhQmW+F@boqun-archlinux>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 10:46:16AM -0700, Boqun Feng wrote:
> On Sat, Apr 08, 2023 at 04:53:40AM -0300, Wedson Almeida Filho wrote:
> > From: Wedson Almeida Filho <walmeida@microsoft.com>
> > 
> > This allows us to have data protected by a lock despite not being
> > wrapped by it. Access is granted by providing evidence that the lock is
> > held by the caller.
> > 
> > Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> > ---
> > v1 -> v2: Added build_assert to rule out zero-sized types
> > v2 -> v3: Improve comments around panics and support for ZSTs
> > 
> >  rust/kernel/sync.rs           |   2 +
> >  rust/kernel/sync/lock.rs      |   2 +-
> >  rust/kernel/sync/locked_by.rs | 147 ++++++++++++++++++++++++++++++++++
> >  3 files changed, 150 insertions(+), 1 deletion(-)
> >  create mode 100644 rust/kernel/sync/locked_by.rs
> > 
> > diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> > index 431402180aa8..d219ee518eff 100644
> > --- a/rust/kernel/sync.rs
> > +++ b/rust/kernel/sync.rs
> > @@ -10,10 +10,12 @@ use crate::types::Opaque;
> >  mod arc;
> >  mod condvar;
> >  pub mod lock;
> > +mod locked_by;
> >  
> >  pub use arc::{Arc, ArcBorrow, UniqueArc};
> >  pub use condvar::CondVar;
> >  pub use lock::{mutex::Mutex, spinlock::SpinLock};
> > +pub use locked_by::LockedBy;
> >  
> >  /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
> >  #[repr(transparent)]
> > diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> > index c365bc909dff..84d8d7d01aaa 100644
> > --- a/rust/kernel/sync/lock.rs
> > +++ b/rust/kernel/sync/lock.rs
> > @@ -111,7 +111,7 @@ pub struct Lock<T: ?Sized, B: Backend> {
> >      _pin: PhantomPinned,
> >  
> >      /// The data protected by the lock.
> > -    data: UnsafeCell<T>,
> > +    pub(crate) data: UnsafeCell<T>,
> >  }
> >  
> >  // SAFETY: `Lock` can be transferred across thread boundaries iff the data it protects can.
> > diff --git a/rust/kernel/sync/locked_by.rs b/rust/kernel/sync/locked_by.rs
> > new file mode 100644
> > index 000000000000..ab0ecb013f54
> > --- /dev/null
> > +++ b/rust/kernel/sync/locked_by.rs
> > @@ -0,0 +1,147 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! A wrapper for data protected by a lock that does not wrap it.
> > +
> > +use super::{lock::Backend, lock::Lock};
> > +use core::{cell::UnsafeCell, ptr};
> > +
> > +/// Allows access to some data to be serialised by a lock that does not wrap it.
> > +///
> > +/// In most cases, data protected by a lock is wrapped by the appropriate lock type, e.g.,
> > +/// [`super::Mutex`] or [`super::SpinLock`]. [`LockedBy`] is meant for cases when this is not
> > +/// possible. For example, if a container has a lock and some data in the contained elements needs
> > +/// to be protected by the same lock.
> > +///
> > +/// [`LockedBy`] wraps the data in lieu of another locking primitive, and only allows access to it
> > +/// when the caller shows evidence that the 'external' lock is locked. It panics if the evidence
> > +/// refers to the wrong instance of the lock.
> > +///
> > +/// # Examples
> > +///
> > +/// The following is an example for illustrative purposes: `InnerDirectory::bytes_used` is an
> > +/// aggregate of all `InnerFile::bytes_used` and must be kept consistent; so we wrap `InnerFile` in
> > +/// a `LockedBy` so that it shares a lock with `InnerDirectory`. This allows us to enforce at
> > +/// compile-time that access to `InnerFile` is only granted when an `InnerDirectory` is also
> > +/// locked; we enforce at run time that the right `InnerDirectory` is locked.
> > +///
> > +/// ```
> > +/// use kernel::sync::{LockedBy, Mutex};
> > +///
> > +/// struct InnerFile {
> > +///     bytes_used: u64,
> > +/// }
> > +///
> > +/// struct File {
> > +///     _ino: u32,
> > +///     inner: LockedBy<InnerFile, InnerDirectory>,
> > +/// }
> > +///
> > +/// struct InnerDirectory {
> > +///     /// The sum of the bytes used by all files.
> > +///     bytes_used: u64,
> > +///     _files: Vec<File>,
> > +/// }
> > +///
> > +/// struct Directory {
> > +///     _ino: u32,
> > +///     inner: Mutex<InnerDirectory>,
> > +/// }
> > +///
> > +/// /// Prints `bytes_used` from both the directory and file.
> > +/// fn print_bytes_used(dir: &Directory, file: &File) {
> > +///     let guard = dir.inner.lock();
> > +///     let inner_file = file.inner.access(&guard);
> > +///     pr_info!("{} {}", guard.bytes_used, inner_file.bytes_used);
> > +/// }
> > +///
> > +/// /// Increments `bytes_used` for both the directory and file.
> > +/// fn inc_bytes_used(dir: &Directory, file: &File) {
> > +///     let mut guard = dir.inner.lock();
> > +///     guard.bytes_used += 10;
> > +///
> > +///     let file_inner = file.inner.access_mut(&mut guard);
> > +///     file_inner.bytes_used += 10;
> > +/// }
> > +///
> > +/// /// Creates a new file.
> > +/// fn new_file(ino: u32, dir: &Directory) -> File {
> > +///     File {
> > +///         _ino: ino,
> > +///         inner: LockedBy::new(&dir.inner, InnerFile { bytes_used: 0 }),
> > +///     }
> > +/// }
> > +/// ```
> > +pub struct LockedBy<T: ?Sized, U: ?Sized> {
> > +    owner: *const U,
> > +    data: UnsafeCell<T>,
> > +}
> > +
> > +// SAFETY: `LockedBy` can be transferred across thread boundaries iff the data it protects can.
> > +unsafe impl<T: ?Sized + Send, U: ?Sized> Send for LockedBy<T, U> {}
> > +
> > +// SAFETY: `LockedBy` serialises the interior mutability it provides, so it is `Sync` as long as the
> > +// data it protects is `Send`.
> > +unsafe impl<T: ?Sized + Send, U: ?Sized> Sync for LockedBy<T, U> {}
> > +
> > +impl<T, U: ?Sized> LockedBy<T, U> {
> > +    /// Constructs a new instance of [`LockedBy`].
> > +    ///
> > +    /// It stores a raw pointer to the owner that is never dereferenced. It is only used to ensure
> > +    /// that the right owner is being used to access the protected data. If the owner is freed, the
> > +    /// data becomes inaccessible; if another instance of the owner is allocated *on the same
> > +    /// memory location*, the data becomes accessible again: none of this affects memory safety
> > +    /// because in any case at most one thread (or CPU) can access the protected data at a time.
> > +    pub fn new(owner: &Lock<U, impl Backend>, data: T) -> Self {
> > +        Self {
> > +            owner: owner.data.get(),
> 
> Given we use the address of the `data` as a key to verify holding a
> lock, I think we should use `Pin<_>` in the function signature, i.e.
> 
> 	pub fn new(owner: Pin<&Lock<U, impl Backend>, data: T) -> Self {
> 	    Self {
> 	        owner: owner.get_ref().data.get()
> 		data: UnsafeCell::new(data),
> 	    }
> 	}
> 
> Thoughts?
> 

Nevermind for now, since `Lock` is a pin-inited type, we can revisit
this later.

Regards,
Boqun

> Regards,
> Boqun
> 
> > +            data: UnsafeCell::new(data),
> > +        }
> > +    }
> > +}
> > +
> > +impl<T: ?Sized, U> LockedBy<T, U> {
> > +    /// Returns a reference to the protected data when the caller provides evidence (via a
> > +    /// reference) that the owner is locked.
> > +    ///
> > +    /// `U` cannot be a zero-sized type (ZST) because there are ways to get an `&U` that matches
> > +    /// the data protected by the lock without actually holding it.
> > +    ///
> > +    /// # Panics
> > +    ///
> > +    /// Panics if `owner` is different from the data protected by the lock used in
> > +    /// [`new`](LockedBy::new).
> > +    pub fn access<'a>(&'a self, owner: &'a U) -> &'a T {
> > +        // Detect the usage of SZTs, which are supported, at compile time.
> > +        crate::build_assert!(core::mem::size_of::<U>() > 0);
> > +        if !ptr::eq(owner, self.owner) {
> > +            panic!("mismatched owners");
> > +        }
> > +
> > +        // SAFETY: `owner` is evidence that the owner is locked.
> > +        unsafe { &*self.data.get() }
> > +    }
> > +
> > +    /// Returns a mutable reference to the protected data when the caller provides evidence (via a
> > +    /// mutable owner) that the owner is locked mutably.
> > +    ///
> > +    /// `U` cannot be a zero-sized type (ZST) because there are ways to get an `&mut U` that
> > +    /// matches the data protected by the lock without actually holding it.
> > +    ///
> > +    /// Showing a mutable reference to the owner is sufficient because we know no other references
> > +    /// can exist to it.
> > +    ///
> > +    /// # Panics
> > +    ///
> > +    /// Panics if `owner` is different from the data protected by the lock used in
> > +    /// [`new`](LockedBy::new).
> > +    pub fn access_mut<'a>(&'a self, owner: &'a mut U) -> &'a mut T {
> > +        // Detect the usage of SZTs, which are supported, at compile time.
> > +        crate::build_assert!(core::mem::size_of::<U>() > 0);
> > +        if !ptr::eq(owner, self.owner) {
> > +            panic!("mismatched owners");
> > +        }
> > +
> > +        // SAFETY: `owner` is evidence that there is only one reference to the owner.
> > +        unsafe { &mut *self.data.get() }
> > +    }
> > +}
> > -- 
> > 2.34.1
> > 
