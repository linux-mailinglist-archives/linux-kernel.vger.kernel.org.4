Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1D170F949
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 16:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236234AbjEXOx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 10:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235990AbjEXOxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 10:53:44 -0400
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30788E70
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 07:53:13 -0700 (PDT)
Date:   Wed, 24 May 2023 14:52:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1684939988; x=1685199188;
        bh=eSrghzPVl/vMIb4NdzZs1ocOvP6Tdr8M0tKbZLF7eVs=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Rnu8bNMaBm93xHDRKTGpLoOO13wio9NMVOcEnC9UiYVEp4iwjoqaObiHpUVn/OW4e
         N58XCN7EgfSRJuPTpBKSZGQSCAaT5WSC20n4WYuWCF2bwyRNfORWDHo/hwX2NNsReP
         rvlgjkXYdXunSgTG7+C7IXo+cge1m5PGGe61fpF/sFG1+seG4RrQ8ctzJR6QMve2aJ
         ySzlsJTrMx5W9gWnsDTxkFB6Wl+hNdp7bx8wINQ4Z9P24YHzXGHZ+hEnBZJfwjYMa3
         eA9l2QHnt1j4Y4qg0sZqrxTG1Rcenjmf4G7khiC7EBKPuFBWBREv6v60ecawqPvgXC
         s1C8Tg67nHkCg==
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
Subject: Re: [PATCH v1 7/7] rust: workqueue: add `try_spawn` helper method
Message-ID: <xAv635eVJdklAFBXcwxhVWRvgkMs37YDjANEArFkcOdoyH27NSHwbBGgJ6b9Q1EvX8gACiNqkaDYNvwdMWy6YHbeGM4qz1xW54-02UjzzZA=@proton.me>
In-Reply-To: <20230517203119.3160435-8-aliceryhl@google.com>
References: <20230517203119.3160435-1-aliceryhl@google.com> <20230517203119.3160435-8-aliceryhl@google.com>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_PDS_OTHER_BAD_TLD,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, May 17th, 2023 at 22:31, Alice Ryhl <aliceryhl@google.com> wr=
ote:
> This adds a convenience method that lets you spawn a closure for
> execution on a workqueue. This will be the most convenient way to use
> workqueues, but it is fallible because it needs to allocate memory.
>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/workqueue.rs | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>=20
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index 007005ddcaf0..303b72efd95f 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -57,6 +57,42 @@ impl Queue {
>              })
>          }
>      }
> +
> +    /// Tries to spawn the given function or closure as a work item.
> +    ///
> +    /// This method can fail because it allocates memory to store the wo=
rk item.
> +    pub fn try_spawn<T: 'static + Send + Fn()>(&self, func: T) -> Result=
 {

Why is this `Fn()` instead of `FnOnce()`?

> +        let init =3D pin_init!(ClosureWork {
> +            work <- Work::new(),
> +            func: Some(func),
> +        });
> +
> +        self.enqueue(Box::pin_init(init)?);
> +        Ok(())
> +    }
> +}
> +
> +/// A helper type used in `try_spawn`.
> +#[pin_data]
> +struct ClosureWork<T> {
> +    #[pin]
> +    work: Work<Pin<Box<ClosureWork<T>>>>,
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
> +impl<T: FnOnce()> BoxWorkItem for ClosureWork<T> {
> +    fn run(mut self: Pin<Box<Self>>) {
> +        if let Some(func) =3D self.as_mut().project().take() {
> +            (func)()
> +        }
> +    }
>  }
>=20
>  /// A work item.
> @@ -280,6 +316,10 @@ macro_rules! impl_has_work {
>      )*};
>  }
>=20
> +impl_has_work! {
> +    impl<T> HasWork<Pin<Box<Self>>> for ClosureWork<T> { self.work }
> +}
> +
>  /// Declares that [`Arc<Self>`] should implement [`WorkItem`].
>  ///
>  /// # Examples
> --
> 2.40.1.606.ga4b1b128d6-goog
>=20

--
Cheers,
Benno
