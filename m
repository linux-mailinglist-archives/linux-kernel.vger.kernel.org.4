Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BE472B2CC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 18:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjFKQKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 12:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjFKQKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 12:10:37 -0400
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B34C122
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 09:10:33 -0700 (PDT)
Date:   Sun, 11 Jun 2023 16:10:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1686499831; x=1686759031;
        bh=zxyFrqdpRxMRW9fbF7nGynBR2bPyNahwL3W/ZczMeg8=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=kMHtDsmLgAV7qBQf+NxbbuUW6ydtGPd5f0mNAVeBN62NXb/xcPqiNYh49/l4Pe0i3
         ZxCGYQbbNfsLA/2eMwK/gitrJNdCrVXmLC2w/wqN/lamjlg/4YnHdNBQ9v40BIoWwH
         KIl/jIlD59nvfw5gbgnY5EhHggU1NNxYYciKhuBCQ8kmHKwvzeVxfWc1350Y9yevuk
         1m/vPkif3VwEIBueJ4FGuawkiTXmoRvmt0irKlVtRvwOhah6oLXviuffZWgkXVnWUU
         kW6qkyWYYVglHTFouc6h+L3iCumW89f92Grb4qOApMmN/gPMtvu/t8ch47Tk8QGSzR
         tCzvkUb4QceDg==
To:     Alice Ryhl <aliceryhl@google.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v2 7/8] rust: workqueue: add `try_spawn` helper method
Message-ID: <vvA9i666LTf-ordh9xwNJ8sJY_rixVHDe7Lj0TNdrOovU5pLdlohCs26P4mtB5iw6PozHStl_rOnRPxbD6luPP60lvfAHW4Y_RhGEFMZpYU=@proton.me>
In-Reply-To: <20230601134946.3887870-8-aliceryhl@google.com>
References: <20230601134946.3887870-1-aliceryhl@google.com> <20230601134946.3887870-8-aliceryhl@google.com>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,PDS_OTHER_BAD_TLD,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.06.23 15:49, Alice Ryhl wrote:
> This adds a convenience method that lets you spawn a closure for
> execution on a workqueue. This will be the most convenient way to use
> workqueues, but it is fallible because it needs to allocate memory.
>=20
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--=20
Cheers,
Benno

> ---
>   rust/kernel/workqueue.rs | 43 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 43 insertions(+)
>=20
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index f06a2f036d8b..c302e8b8624b 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -29,6 +29,7 @@
>   //! C header: [`include/linux/workqueue.h`](../../../../include/linux/w=
orkqueue.h)
>=20
>   use crate::{bindings, prelude::*, sync::Arc, types::Opaque};
> +use alloc::alloc::AllocError;
>   use alloc::boxed::Box;
>   use core::marker::{PhantomData, PhantomPinned};
>   use core::pin::Pin;
> @@ -87,6 +88,44 @@ pub fn enqueue<W, const ID: u64>(&self, w: W) -> W::En=
queueOutput
>               })
>           }
>       }
> +
> +    /// Tries to spawn the given function or closure as a work item.
> +    ///
> +    /// This method can fail because it allocates memory to store the wo=
rk item.
> +    pub fn try_spawn<T: 'static + Send + FnOnce()>(&self, func: T) -> Re=
sult<(), AllocError> {
> +        let init =3D pin_init!(ClosureWork {
> +            work <- Work::new(),
> +            func: Some(func),
> +        });
> +
> +        self.enqueue(Box::pin_init(init).map_err(|_| AllocError)?);
> +        Ok(())
> +    }
> +}
> +
> +/// A helper type used in `try_spawn`.
> +#[pin_data]
> +struct ClosureWork<T> {
> +    #[pin]
> +    work: Work<ClosureWork<T>>,
> +    func: Option<T>,
> +}
> +
> +impl<T> ClosureWork<T> {
> +    fn project(self: Pin<&mut Self>) -> &mut Option<T> {
> +        // SAFETY: The `func` field is not structurally pinned.
> +        unsafe { &mut self.get_unchecked_mut().func }
> +    }
> +}
> +
> +impl<T: FnOnce()> WorkItem for ClosureWork<T> {
> +    type Pointer =3D Pin<Box<Self>>;
> +
> +    fn run(mut this: Pin<Box<Self>>) {
> +        if let Some(func) =3D this.as_mut().project().take() {
> +            (func)()
> +        }
> +    }
>   }
>=20
>   /// A raw work item.
> @@ -325,6 +364,10 @@ unsafe fn raw_get_work(ptr: *mut Self) -> *mut $crat=
e::workqueue::Work<$work_typ
>       )*};
>   }
>=20
> +impl_has_work! {
> +    impl<T> HasWork<Self> for ClosureWork<T> { self.work }
> +}
> +
>   unsafe impl<T, const ID: u64> WorkItemPointer<ID> for Arc<T>
>   where
>       T: WorkItem<ID, Pointer =3D Self>,
> --
> 2.41.0.rc0.172.g3f132b7071-goog
>=20

