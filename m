Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E5E6D8934
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 23:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbjDEVGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 17:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjDEVGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 17:06:06 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1BD40D3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 14:06:03 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id cn12so144396507edb.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 14:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112; t=1680728761;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=yFAlgWffno32FcbrALUWyEh6LfU3gBMZPzlIRM7ANTo=;
        b=maxKjtLQYPX6eXbdPZq6sxo3hW0dq5Gj9++WNfcAUyEgDoI8meVpr7Hm/BzgsrA4LW
         LxCfOqp1Ujz5OtFwsrACGuh4Sldi6JHX528OmrRvP11wTETGsrtFX3AJOJMRxmCLoNFI
         JBQTXFavM5jY7mNIINHu2g9vpI3XQLQfPjyuZWUhQB8Pm9Hy4GVOiBJgxsZ1xTX8tleu
         Hgxcs52UxrXHp82rTbWaTgeiJx1YQyGlbxXYgnYYxuj+/xN6FH2wsoexHzcsMNPVhkf6
         n+qXLlC4oc6MBav8u6YYYDhvYfMHwlr0W3vXxeGoxReds/coi+Rfv8l1wouX3oBzEc8K
         96aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680728761;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFAlgWffno32FcbrALUWyEh6LfU3gBMZPzlIRM7ANTo=;
        b=z2VePrhbeiF7P8q7CBMMk3UX9cSpFnF3irY+2JHtd4jVKxND6a11jp+aHJRywdV5qn
         12wApq5mvn0oFvn1bknpt/8+pouy9nJGtJKTfMrEilcj5jiQAarEJmOB1ml2kRU5QBTX
         P/ryiROjRcZGhBD3bQ5ITkGGRFK2shXufLD6y2Fs9acjTsgoAVJyD2qpphQFGc2fL33b
         2i0KjSeT8XCsI362Y8P8jS44vDWwa2O1Tbpf7dSozVkkCBfTL9lClnnDmhu1BPA4V9bQ
         9aYjMNd0BmcJQLPhSxLJY5XocUImrao95vghV5yXWLFFF+t7NEE0lfTebisW8gMLqCR7
         CDcw==
X-Gm-Message-State: AAQBX9d8xro2WGW7eGIT0qVxVTo0pmWGitmDcrxtqWCOxg9GdoPcMMoW
        JQzXudbVICqBknN5DUQ84tSY8w==
X-Google-Smtp-Source: AKy350a5TtnPI2gWFm+AhpjESgn/CztknT4pGw99WEAczqXxcLizKla2Q+SnBiuxwhFHZ94ae0ynaw==
X-Received: by 2002:a17:906:5902:b0:947:3af0:66c0 with SMTP id h2-20020a170906590200b009473af066c0mr4434021ejq.26.1680728761421;
        Wed, 05 Apr 2023 14:06:01 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id t20-20020a50d714000000b005021d17d896sm7747170edi.21.2023.04.05.14.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 14:06:01 -0700 (PDT)
References: <20230405193445.745024-1-y86-dev@protonmail.com>
 <20230405193445.745024-7-y86-dev@protonmail.com>
User-agent: mu4e 1.10.1; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Benno Lossin <y86-dev@protonmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: Re: [PATCH v6 06/15] rust: add pin-init API core
Date:   Wed, 05 Apr 2023 23:04:26 +0200
In-reply-to: <20230405193445.745024-7-y86-dev@protonmail.com>
Message-ID: <87bkk2t4xz.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Benno Lossin <y86-dev@protonmail.com> writes:

> This API is used to facilitate safe pinned initialization of structs. It
> replaces cumbersome `unsafe` manual initialization with elegant safe macro
> invocations.
>
> Due to the size of this change it has been split into six commits:
> 1. This commit introducing the basic public interface: traits and
>    functions to represent and create initializers.
> 2. Adds the `#[pin_data]`, `pin_init!`, `try_pin_init!`, `init!` and
>    `try_init!` macros along with their internal types.
> 3. Adds the `InPlaceInit` trait that allows using an initializer to create
>    an object inside of a `Box<T>` and other smart pointers.
> 4. Adds the `PinnedDrop` trait and adds macro support for it in
>    the `#[pin_data]` macro.
> 5. Adds the `stack_pin_init!` macro allowing to pin-initialize a struct on
>    the stack.
> 6. Adds the `Zeroable` trait and `init::zeroed` function to initialize
>    types that have `0x00` in all bytes as a valid bit pattern.
>
> --
>
> In this section the problem that the new pin-init API solves is outlined.
> This message describes the entirety of the API, not just the parts
> introduced in this commit. For a more granular explanation and additional
> information on pinning and this issue, view [1].
>
> Pinning is Rust's way of enforcing the address stability of a value. When a
> value gets pinned it will be impossible for safe code to move it to another
> location. This is done by wrapping pointers to said object with `Pin<P>`.
> This wrapper prevents safe code from creating mutable references to the
> object, preventing mutable access, which is needed to move the value.
> `Pin<P>` provides `unsafe` functions to circumvent this and allow
> modifications regardless. It is then the programmer's responsibility to
> uphold the pinning guarantee.
>
> Many kernel data structures require a stable address, because there are
> foreign pointers to them which would get invalidated by moving the
> structure. Since these data structures are usually embedded in structs to
> use them, this pinning property propagates to the container struct.
> Resulting in most structs in both Rust and C code needing to be pinned.
>
> So if we want to have a `mutex` field in a Rust struct, this struct also
> needs to be pinned, because a `mutex` contains a `list_head`. Additionally
> initializing a `list_head` requires already having the final memory
> location available, because it is initialized by pointing it to itself. But
> this presents another challenge in Rust: values have to be initialized at
> all times. There is the `MaybeUninit<T>` wrapper type, which allows
> handling uninitialized memory, but this requires using the `unsafe` raw
> pointers and a casting the type to the initialized variant.
>
> This problem gets exacerbated when considering encapsulation and the normal
> safety requirements of Rust code. The fields of the Rust `Mutex<T>` should
> not be accessible to normal driver code. After all if anyone can modify
> the fields, there is no way to ensure the invariants of the `Mutex<T>` are
> upheld. But if the fields are inaccessible, then initialization of a
> `Mutex<T>` needs to be somehow achieved via a function or a macro. Because
> the `Mutex<T>` must be pinned in memory, the function cannot return it by
> value. It also cannot allocate a `Box` to put the `Mutex<T>` into, because
> that is an unnecessary allocation and indirection which would hurt
> performance.
>
> The solution in the rust tree (e.g. this commit: [2]) that is replaced by
> this API is to split this function into two parts:
>
> 1. A `new` function that returns a partially initialized `Mutex<T>`,
> 2. An `init` function that requires the `Mutex<T>` to be pinned and that
>    fully initializes the `Mutex<T>`.
>
> Both of these functions have to be marked `unsafe`, since a call to `new`
> needs to be accompanied with a call to `init`, otherwise using the
> `Mutex<T>` could result in UB. And because calling `init` twice also is not
> safe. While `Mutex<T>` initialization cannot fail, other structs might
> also have to allocate memory, which would result in conditional successful
> initialization requiring even more manual accommodation work.
>
> Combine this with the problem of pin-projections -- the way of accessing
> fields of a pinned struct -- which also have an `unsafe` API, pinned
> initialization is riddled with `unsafe` resulting in very poor ergonomics.
> Not only that, but also having to call two functions possibly multiple
> lines apart makes it very easy to forget it outright or during refactoring.
>
> Here is an example of the current way of initializing a struct with two
> synchronization primitives (see [3] for the full example):
>
>     struct SharedState {
>         state_changed: CondVar,
>         inner: Mutex<SharedStateInner>,
>     }
>
>     impl SharedState {
>         fn try_new() -> Result<Arc<Self>> {
>             let mut state = Pin::from(UniqueArc::try_new(Self {
>                 // SAFETY: `condvar_init!` is called below.
>                 state_changed: unsafe { CondVar::new() },
>                 // SAFETY: `mutex_init!` is called below.
>                 inner: unsafe {
>                     Mutex::new(SharedStateInner { token_count: 0 })
>                 },
>             })?);
>
>             // SAFETY: `state_changed` is pinned when `state` is.
>             let pinned = unsafe {
>                 state.as_mut().map_unchecked_mut(|s| &mut s.state_changed)
>             };
>             kernel::condvar_init!(pinned, "SharedState::state_changed");
>
>             // SAFETY: `inner` is pinned when `state` is.
>             let pinned = unsafe {
>                 state.as_mut().map_unchecked_mut(|s| &mut s.inner)
>             };
>             kernel::mutex_init!(pinned, "SharedState::inner");
>
>             Ok(state.into())
>         }
>     }
>
> The pin-init API of this patch solves this issue by providing a
> comprehensive solution comprised of macros and traits. Here is the example
> from above using the pin-init API:
>
>     #[pin_data]
>     struct SharedState {
>         #[pin]
>         state_changed: CondVar,
>         #[pin]
>         inner: Mutex<SharedStateInner>,
>     }
>
>     impl SharedState {
>         fn new() -> impl PinInit<Self> {
>             pin_init!(Self {
>                 state_changed <- new_condvar!("SharedState::state_changed"),
>                 inner <- new_mutex!(
>                     SharedStateInner { token_count: 0 },
>                     "SharedState::inner",
>                 ),
>             })
>         }
>     }
>
> Notably the way the macro is used here requires no `unsafe` and thus comes
> with the usual Rust promise of safe code not introducing any memory
> violations. Additionally it is now up to the caller of `new()` to decide
> the memory location of the `SharedState`. They can choose at the moment
> `Arc<T>`, `Box<T>` or the stack.
>
> --
>
> The API has the following architecture:
> 1. Initializer traits `PinInit<T, E>` and `Init<T, E>` that act like
>    closures.
> 2. Macros to create these initializer traits safely.
> 3. Functions to allow manually writing initializers.
>
> The initializers (an `impl PinInit<T, E>`) receive a raw pointer pointing
> to uninitialized memory and their job is to fully initialize a `T` at that
> location. If initialization fails, they return an error (`E`) by value.
>
> This way of initializing cannot be safely exposed to the user, since it
> relies upon these properties outside of the control of the trait:
> - the memory location (slot) needs to be valid memory,
> - if initialization fails, the slot should not be read from,
> - the value in the slot should be pinned, so it cannot move and the memory
>   cannot be deallocated until the value is dropped.
>
> This is why using an initializer is facilitated by another trait that
> ensures these requirements.
>
> These initializers can be created manually by just supplying a closure that
> fulfills the same safety requirements as `PinInit<T, E>`. But this is an
> `unsafe` operation. To allow safe initializer creation, the `pin_init!` is
> provided along with three other variants: `try_pin_init!`, `try_init!` and
> `init!`. These take a modified struct initializer as a parameter and
> generate a closure that initializes the fields in sequence.
> The macros take great care in upholding the safety requirements:
> - A shadowed struct type is used as the return type of the closure instead
>   of `()`. This is to prevent early returns, as these would prevent full
>   initialization.
> - To ensure every field is only initialized once, a normal struct
>   initializer is placed in unreachable code. The type checker will emit
>   errors if a field is missing or specified multiple times.
> - When initializing a field fails, the whole initializer will fail and
>   automatically drop fields that have been initialized earlier.
> - Only the correct initializer type is allowed for unpinned fields. You
>   cannot use a `impl PinInit<T, E>` to initialize a structurally not pinned
>   field.
>
> To ensure the last point, an additional macro `#[pin_data]` is needed. This
> macro annotates the struct itself and the user specifies structurally
> pinned and not pinned fields.
>
> Because dropping a pinned struct is also not allowed to break the pinning
> invariants, another macro attribute `#[pinned_drop]` is needed. This
> macro is introduced in a following commit.
>
> These two macros also have mechanisms to ensure the overall safety of the
> API. Additionally, they utilize a combined proc-macro, declarative macro
> design: first a proc-macro enables the outer attribute syntax `#[...]` and
> does some important pre-parsing. Notably this prepares the generics such
> that the declarative macro can handle them using token trees. Then the
> actual parsing of the structure and the emission of code is handled by a
> declarative macro.
>
> For pin-projections the crates `pin-project` [4] and `pin-project-lite` [5]
> had been considered, but were ultimately rejected:
> - `pin-project` depends on `syn` [6] which is a very big dependency, around
>   50k lines of code.
> - `pin-project-lite` is a more reasonable 5k lines of code, but contains a
>   very complex declarative macro to parse generics. On top of that it
>   would require modification that would need to be maintained
>   independently.
>
> Link: https://rust-for-linux.com/the-safe-pinned-initialization-problem [1]
> Link: https://github.com/Rust-for-Linux/linux/tree/0a04dc4ddd671efb87eef54dde0fb38e9074f4be [2]
> Link: https://github.com/Rust-for-Linux/linux/blob/f509ede33fc10a07eba3da14aa00302bd4b5dddd/samples/rust/rust_miscdev.rs [3]
> Link: https://crates.io/crates/pin-project [4]
> Link: https://crates.io/crates/pin-project-lite [5]
> Link: https://crates.io/crates/syn [6]
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Cc: Andreas Hindborg <a.hindborg@samsung.com>
> Cc: Wedson Almeida Filho <wedsonaf@gmail.com>

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>

> ---
>  rust/kernel/init.rs            | 187 +++++++++++++++++++++++++++++++++
>  rust/kernel/init/__internal.rs |  33 ++++++
>  rust/kernel/lib.rs             |   7 ++
>  scripts/Makefile.build         |   2 +-
>  4 files changed, 228 insertions(+), 1 deletion(-)
>  create mode 100644 rust/kernel/init.rs
>  create mode 100644 rust/kernel/init/__internal.rs
>
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> new file mode 100644
> index 000000000000..d041f0daf71e
> --- /dev/null
> +++ b/rust/kernel/init.rs
> @@ -0,0 +1,187 @@
> +// SPDX-License-Identifier: Apache-2.0 OR MIT
> +
> +//! API to safely and fallibly initialize pinned `struct`s using in-place constructors.
> +//!
> +//! It also allows in-place initialization of big `struct`s that would otherwise produce a stack
> +//! overflow.
> +//!
> +//! Most `struct`s from the [`sync`] module need to be pinned, because they contain self-referential
> +//! `struct`s from C. [Pinning][pinning] is Rust's way of ensuring data does not move.
> +//!
> +//! # Overview
> +//!
> +//! To initialize a `struct` with an in-place constructor you will need two things:
> +//! - an in-place constructor,
> +//! - a memory location that can hold your `struct`.
> +//!
> +//! To get an in-place constructor there are generally two options:
> +//! - a custom function/macro returning an in-place constructor provided by someone else,
> +//! - using the unsafe function [`pin_init_from_closure()`] to manually create an initializer.
> +//!
> +//! Aside from pinned initialization, this API also supports in-place construction without pinning,
> +//! the macros/types/functions are generally named like the pinned variants without the `pin`
> +//! prefix.
> +//!
> +//! [`sync`]: kernel::sync
> +//! [pinning]: https://doc.rust-lang.org/std/pin/index.html
> +//! [structurally pinned fields]:
> +//!     https://doc.rust-lang.org/std/pin/index.html#pinning-is-structural-for-field
> +//! [`Arc<T>`]: crate::sync::Arc
> +//! [`impl PinInit<Foo>`]: PinInit
> +//! [`impl PinInit<T, E>`]: PinInit
> +//! [`impl Init<T, E>`]: Init
> +//! [`Opaque`]: kernel::types::Opaque
> +//! [`pin_data`]: ::macros::pin_data
> +//! [`UniqueArc<T>`]: kernel::sync::UniqueArc
> +//! [`Box<T>`]: alloc::boxed::Box
> +
> +use core::{convert::Infallible, marker::PhantomData, mem::MaybeUninit};
> +
> +#[doc(hidden)]
> +pub mod __internal;
> +
> +/// A pin-initializer for the type `T`.
> +///
> +/// To use this initializer, you will need a suitable memory location that can hold a `T`. This can
> +/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`].
> +///
> +/// Also see the [module description](self).
> +///
> +/// # Safety
> +///
> +/// When implementing this type you will need to take great care. Also there are probably very few
> +/// cases where a manual implementation is necessary. Use [`pin_init_from_closure`] where possible.
> +///
> +/// The [`PinInit::__pinned_init`] function
> +/// - returns `Ok(())` if it initialized every field of `slot`,
> +/// - returns `Err(err)` if it encountered an error and then cleaned `slot`, this means:
> +///     - `slot` can be deallocated without UB occurring,
> +///     - `slot` does not need to be dropped,
> +///     - `slot` is not partially initialized.
> +/// - while constructing the `T` at `slot` it upholds the pinning invariants of `T`.
> +///
> +/// [`Arc<T>`]: crate::sync::Arc
> +/// [`Arc::pin_init`]: crate::sync::Arc::pin_init
> +/// [`UniqueArc<T>`]: kernel::sync::UniqueArc
> +/// [`Box<T>`]: alloc::boxed::Box
> +#[must_use = "An initializer must be used in order to create its value."]
> +pub unsafe trait PinInit<T: ?Sized, E = Infallible>: Sized {
> +    /// Initializes `slot`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `slot` is a valid pointer to uninitialized memory.
> +    /// - the caller does not touch `slot` when `Err` is returned, they are only permitted to
> +    ///   deallocate.
> +    /// - `slot` will not move until it is dropped, i.e. it will be pinned.
> +    unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E>;
> +}
> +
> +/// An initializer for `T`.
> +///
> +/// To use this initializer, you will need a suitable memory location that can hold a `T`. This can
> +/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`]. Because [`PinInit<T, E>`] is a super trait, you can
> +/// use every function that takes it as well.
> +///
> +/// Also see the [module description](self).
> +///
> +/// # Safety
> +///
> +/// When implementing this type you will need to take great care. Also there are probably very few
> +/// cases where a manual implementation is necessary. Use [`init_from_closure`] where possible.
> +///
> +/// The [`Init::__init`] function
> +/// - returns `Ok(())` if it initialized every field of `slot`,
> +/// - returns `Err(err)` if it encountered an error and then cleaned `slot`, this means:
> +///     - `slot` can be deallocated without UB occurring,
> +///     - `slot` does not need to be dropped,
> +///     - `slot` is not partially initialized.
> +/// - while constructing the `T` at `slot` it upholds the pinning invariants of `T`.
> +///
> +/// The `__pinned_init` function from the supertrait [`PinInit`] needs to execute the exact same
> +/// code as `__init`.
> +///
> +/// Contrary to its supertype [`PinInit<T, E>`] the caller is allowed to
> +/// move the pointee after initialization.
> +///
> +/// [`Arc<T>`]: crate::sync::Arc
> +/// [`UniqueArc<T>`]: kernel::sync::UniqueArc
> +/// [`Box<T>`]: alloc::boxed::Box
> +#[must_use = "An initializer must be used in order to create its value."]
> +pub unsafe trait Init<T: ?Sized, E = Infallible>: Sized {
> +    /// Initializes `slot`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `slot` is a valid pointer to uninitialized memory.
> +    /// - the caller does not touch `slot` when `Err` is returned, they are only permitted to
> +    ///   deallocate.
> +    unsafe fn __init(self, slot: *mut T) -> Result<(), E>;
> +}
> +
> +// SAFETY: Every in-place initializer can also be used as a pin-initializer.
> +unsafe impl<T: ?Sized, E, I> PinInit<T, E> for I
> +where
> +    I: Init<T, E>,
> +{
> +    unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
> +        // SAFETY: `__init` meets the same requirements as `__pinned_init`, except that it does not
> +        // require `slot` to not move after init.
> +        unsafe { self.__init(slot) }
> +    }
> +}
> +
> +/// Creates a new [`PinInit<T, E>`] from the given closure.
> +///
> +/// # Safety
> +///
> +/// The closure:
> +/// - returns `Ok(())` if it initialized every field of `slot`,
> +/// - returns `Err(err)` if it encountered an error and then cleaned `slot`, this means:
> +///     - `slot` can be deallocated without UB occurring,
> +///     - `slot` does not need to be dropped,
> +///     - `slot` is not partially initialized.
> +/// - may assume that the `slot` does not move if `T: !Unpin`,
> +/// - while constructing the `T` at `slot` it upholds the pinning invariants of `T`.
> +#[inline]
> +pub const unsafe fn pin_init_from_closure<T: ?Sized, E>(
> +    f: impl FnOnce(*mut T) -> Result<(), E>,
> +) -> impl PinInit<T, E> {
> +    __internal::InitClosure(f, PhantomData)
> +}
> +
> +/// Creates a new [`Init<T, E>`] from the given closure.
> +///
> +/// # Safety
> +///
> +/// The closure:
> +/// - returns `Ok(())` if it initialized every field of `slot`,
> +/// - returns `Err(err)` if it encountered an error and then cleaned `slot`, this means:
> +///     - `slot` can be deallocated without UB occurring,
> +///     - `slot` does not need to be dropped,
> +///     - `slot` is not partially initialized.
> +/// - the `slot` may move after initialization.
> +/// - while constructing the `T` at `slot` it upholds the pinning invariants of `T`.
> +#[inline]
> +pub const unsafe fn init_from_closure<T: ?Sized, E>(
> +    f: impl FnOnce(*mut T) -> Result<(), E>,
> +) -> impl Init<T, E> {
> +    __internal::InitClosure(f, PhantomData)
> +}
> +
> +/// An initializer that leaves the memory uninitialized.
> +///
> +/// The initializer is a no-op. The `slot` memory is not changed.
> +#[inline]
> +pub fn uninit<T, E>() -> impl Init<MaybeUninit<T>, E> {
> +    // SAFETY: The memory is allowed to be uninitialized.
> +    unsafe { init_from_closure(|_| Ok(())) }
> +}
> +
> +// SAFETY: Every type can be initialized by-value.
> +unsafe impl<T> Init<T> for T {
> +    unsafe fn __init(self, slot: *mut T) -> Result<(), Infallible> {
> +        unsafe { slot.write(self) };
> +        Ok(())
> +    }
> +}
> diff --git a/rust/kernel/init/__internal.rs b/rust/kernel/init/__internal.rs
> new file mode 100644
> index 000000000000..08cbb5333438
> --- /dev/null
> +++ b/rust/kernel/init/__internal.rs
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: Apache-2.0 OR MIT
> +
> +//! This module contains API-internal items for pin-init.
> +//!
> +//! These items must not be used outside of
> +//! - `kernel/init.rs`
> +//! - `macros/pin_data.rs`
> +//! - `macros/pinned_drop.rs`
> +
> +use super::*;
> +
> +/// See the [nomicon] for what subtyping is. See also [this table].
> +///
> +/// [nomicon]: https://doc.rust-lang.org/nomicon/subtyping.html
> +/// [this table]: https://doc.rust-lang.org/nomicon/phantom-data.html#table-of-phantomdata-patterns
> +type Invariant<T> = PhantomData<fn(*mut T) -> *mut T>;
> +
> +/// This is the module-internal type implementing `PinInit` and `Init`. It is unsafe to create this
> +/// type, since the closure needs to fulfill the same safety requirement as the
> +/// `__pinned_init`/`__init` functions.
> +pub(crate) struct InitClosure<F, T: ?Sized, E>(pub(crate) F, pub(crate) Invariant<(E, T)>);
> +
> +// SAFETY: While constructing the `InitClosure`, the user promised that it upholds the
> +// `__init` invariants.
> +unsafe impl<T: ?Sized, F, E> Init<T, E> for InitClosure<F, T, E>
> +where
> +    F: FnOnce(*mut T) -> Result<(), E>,
> +{
> +    #[inline]
> +    unsafe fn __init(self, slot: *mut T) -> Result<(), E> {
> +        (self.0)(slot)
> +    }
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 4317b6d5f50b..821bd067151c 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -16,7 +16,9 @@
>  #![feature(coerce_unsized)]
>  #![feature(core_ffi_c)]
>  #![feature(dispatch_from_dyn)]
> +#![feature(explicit_generic_args_with_impl_trait)]
>  #![feature(generic_associated_types)]
> +#![feature(new_uninit)]
>  #![feature(pin_macro)]
>  #![feature(receiver_trait)]
>  #![feature(unsize)]
> @@ -26,11 +28,16 @@
>  #[cfg(not(CONFIG_RUST))]
>  compile_error!("Missing kernel configuration for conditional compilation");
>
> +#[allow(unused_extern_crates)]
> +// Allow proc-macros to refer to `::kernel` inside the `kernel` crate (this crate).
> +extern crate self as kernel;
> +
>  #[cfg(not(test))]
>  #[cfg(not(testlib))]
>  mod allocator;
>  mod build_assert;
>  pub mod error;
> +pub mod init;
>  pub mod prelude;
>  pub mod print;
>  mod static_assert;
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index ba4102b9d94d..7aafb5f1bc53 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -277,7 +277,7 @@ $(obj)/%.lst: $(src)/%.c FORCE
>  # Compile Rust sources (.rs)
>  # ---------------------------------------------------------------------------
>
> -rust_allowed_features := core_ffi_c,pin_macro
> +rust_allowed_features := core_ffi_c,pin_macro,explicit_generic_args_with_impl_trait
>
>  rust_common_cmd = \
>  	RUST_MODFILE=$(modfile) $(RUSTC_OR_CLIPPY) $(rust_flags) \

