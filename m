Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E066D03C1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjC3Lql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbjC3LqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:46:25 -0400
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66349B743
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 04:46:00 -0700 (PDT)
Date:   Thu, 30 Mar 2023 11:45:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1680176732; x=1680435932;
        bh=dgiu3xs0UtWg8N/CQ9KvytVckw5AYUEZ2ZLbaBlSqBw=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=YLbF9EOLEIaYnAxBxL9QfwYcOrYZTZBVFjernRYSfgCjRNQIDLkXjUwl5z0TDG7Cp
         h9x4S33xR597WhxHeWQO2B57KIbpp9lwljVpYixnkrAm6k6I7r1ob7V9oitq7xHF4U
         cOnjAWZqBwJ/SzOuFViI6ZYTUfU4As5onY4WJGo0tnQUNTWFIJjpamjpfMm6mecSmz
         pzNJsQmYPR4HlWm8PAjH0N5rSkIDLScgi+5TJb+4g3ZyDREG62WJGW/FQ/uHHGyft1
         pGS1u0Us5y4meuxtsj4pfm92P67EIKWwkhmtstmUbBAEQbjM88xJSuTgx1omYaeVK6
         cuJni9q0tEUEw==
To:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org
From:   Benno Lossin <y86-dev@protonmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH 13/13] rust: sync: introduce `LockedBy`
Message-ID: <06a7c5e7-fc5f-3860-7f17-7f3609de669a@protonmail.com>
In-Reply-To: <04034640-2d89-dd63-07e5-29fa612aa458@protonmail.com>
References: <20230330043954.562237-1-wedsonaf@gmail.com> <20230330043954.562237-13-wedsonaf@gmail.com> <04034640-2d89-dd63-07e5-29fa612aa458@protonmail.com>
Feedback-ID: 40624463:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.03.23 13:28, Benno Lossin wrote:
> What happens if the the protected data `U` is a ZST? Then the address
> comparing will not work, since all ZST references have the same address.
> For example:
>
>       struct Outer {
>           mtx: Mutex<()>,
>           inners: Vec<Inner>,
>       }
>
>       struct Inner {
>           count: LockedBy<usize, ()>,
>       }
>
>       fn evil(inner: &Inner) {
>           // can create two mutable references at the same time:
>           let a =3D inner.count.access_mut(&mut ());
>           let b =3D inner.count.access_mut(&mut ());
>           core::mem::swap(a, b);
>       }

Sorry the example I provided does not actually work, since `&mut ()`
refers to a place on the stack. I found a new example that shows ZSTs
are still problematic:

     struct Outer {
         mtx1: Mutex<()>,
         mtx2: Mutex<()>,
         inners: Vec<Inner>,
     }

     struct Inner {
         count: LockedBy<usize, ()>,
     }

     fn new_inner(outer: &Outer) -> Inner {
         Inner { count: LockedBy::new(&outer.mtx1, 0) }
     }

     fn evil(outer: &Outer) {
         let inner =3D outer.inners.get(0).unwrap();
         let mut guard1 =3D outer.mtx1.lock();
         let mut guard2 =3D outer.mtx2.lock();
=09// The pointee of `guard1` and `guard2` have the same address.
         let ref1 =3D inner.count.access_mut(&mut *guard1);
         let ref2 =3D inner.count.access_mut(&mut *guard2);
         mem::swap(ref1, ref2);
     }

--
Cheers,
Benno


