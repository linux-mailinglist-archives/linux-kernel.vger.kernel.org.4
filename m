Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B486805C6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 06:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbjA3Fzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 00:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbjA3Fzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 00:55:44 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BCD18B2A;
        Sun, 29 Jan 2023 21:55:43 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-16332831ed0so13752529fac.10;
        Sun, 29 Jan 2023 21:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pb1DZ5HyR6ozcWWMySi1L96mmW2RSwsZOaJZCjMwx1A=;
        b=Lj1/HuR/STv0Mz/5/u+/Yft1AEkDjEab97tPf/LJi9Hc5WLK0VyUeCsmKpebtgcMnY
         6cTjglZjUFhxappvT9cZLyaifLpY1QmrsFTBnYX5HjV1lqNv6dDWTKB5g1UmSnFBqozy
         yw+X4IU83o6+DR/DZY1KkAnlYwj9scmxfHf7eL7REEQRRX2N283VJLNhER2FawhuMXSy
         dN15YOYc9S0FXdCUMy53P3nIkwGmRYRObykXu6Rd+9ssqpb4FYaqv/9Eql/KhQ5ONbk5
         ZMVARNiGB2LRspoCIsiPnaqoopVRw2vkVFvbzbmF79hHI781zKUTae3BAdieb4EPUpz/
         4gFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pb1DZ5HyR6ozcWWMySi1L96mmW2RSwsZOaJZCjMwx1A=;
        b=nyR9fR+OAIpwRn8JanIHr8bFAua5mS+7WS/m8p+VRs+fwtO0Ss3moZ/0h38wZhM8Xr
         0Agw3eF6UV/KiwsVhWM4/xs/4C5ZZabSRuI4vqFXiK5CoIHYPLdtirHNfRcKvlowUOw6
         K8Vl/KuKElRBcH5PAi4IDCZsK7/O87Xuc+11EGpqYbDpepKmQwBsdS5bXU/lDpk3NtAg
         gA+eGCzXOLdN6jW0UoelmCHvwrQWn6b9UWiHNqGMI7zfqVE4VgelPLCxH2dtzsuuVlKm
         NuGI0H0hiID2vWvmc3l5SHnmPVzWeyzgHGDlZ8W9qHODkb1p/ib5fNNXQQTdLnRb9jZO
         YYtg==
X-Gm-Message-State: AO0yUKVnn7d7Z5qkFCU2RXLaI4DjVVuFCsbcaoYkCBrCgGm2IC/9o53i
        c4xXoKIMPV3CZG5iivlMR/9O+Qp6+YpnxLLK5KcCyw4/KTg=
X-Google-Smtp-Source: AK7set+eZjxbQT4kboTeEq5/wxnLeObUwp/w11P3+AsLSTe27OUyFwRtAl4/vm1euPEl6GS+8vdfTTrxdDychd6Iv9Q=
X-Received: by 2002:a05:6870:1790:b0:163:3c39:d0d5 with SMTP id
 r16-20020a056870179000b001633c39d0d5mr1305076oae.215.1675058142846; Sun, 29
 Jan 2023 21:55:42 -0800 (PST)
MIME-Version: 1.0
References: <20230119174036.64046-1-wedsonaf@gmail.com> <20230119174036.64046-4-wedsonaf@gmail.com>
 <20230127140319.22af6060.gary@garyguo.net>
In-Reply-To: <20230127140319.22af6060.gary@garyguo.net>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Mon, 30 Jan 2023 02:55:31 -0300
Message-ID: <CANeycqpUaKuKCjZyw1PiPzMo3rqZQXiFONZOKq1hbhVUA25+tQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] rust: types: implement `ForeignOwnable` for the unit type
To:     Gary Guo <gary@garyguo.net>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
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

On Fri, 27 Jan 2023 at 11:03, Gary Guo <gary@garyguo.net> wrote:
>
> On Thu, 19 Jan 2023 14:40:35 -0300
> Wedson Almeida Filho <wedsonaf@gmail.com> wrote:
>
> > This allows us to use the unit type `()` when we have no object whose
> > ownership must be managed but one implementing the `ForeignOwnable`
> > trait is needed.
> >
> > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > ---
> >  rust/kernel/types.rs | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> > index e037c262f23e..8f80cffbff59 100644
> > --- a/rust/kernel/types.rs
> > +++ b/rust/kernel/types.rs
> > @@ -85,6 +85,19 @@ impl<T: 'static> ForeignOwnable for Box<T> {
> >      }
> >  }
> >
> > +impl ForeignOwnable for () {
> > +    type Borrowed<'a> = ();
> > +
> > +    fn into_foreign(self) -> *const core::ffi::c_void {
> > +        // We use 1 to be different from a null pointer.
> > +        1usize as _
>
> this should really be `core::ptr::invalid(1)`. That's currently
> unstable, but can be equivalently written as
> `NonNull::<()>::dangling().as_ptr()`.

This has the wrong type, but I agree with the spirit of the
suggestion. I'll add it to V2.

> This has a different semantic meaning from `as` since it explicitly
> suggests an invalid provenance and thus will not alias with other
> pointers. (Although I don't think compiler currently can take advantage
> of this fact yet)
>
> > +    }
> > +
> > +    unsafe fn borrow<'a>(_: *const core::ffi::c_void) -> Self::Borrowed<'a> {}
> > +
> > +    unsafe fn from_foreign(_: *const core::ffi::c_void) -> Self {}
> > +}
> > +
> >  /// Runs a cleanup function/closure when dropped.
> >  ///
> >  /// The [`ScopeGuard::dismiss`] function prevents the cleanup function from running.
>
