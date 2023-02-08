Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F6468F00F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 14:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjBHNoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 08:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjBHNn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 08:43:57 -0500
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4F236680;
        Wed,  8 Feb 2023 05:43:33 -0800 (PST)
Date:   Wed, 08 Feb 2023 13:43:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1675863809; x=1676123009;
        bh=RE1Mtu5hUESEYjkdG+RqP2aIW0mtd84xeu6wYHWjxLg=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=yK1VjFC+8kkmKCYjLneS0SGwziDJD+/zvlFR9hO6QA1hmtU2Y37mSNafOAn7fT102
         CKzUeipBfvBZlE/NywE8iWkYnnwlHHUTLdStgMsuc70gyR4cMkftnb85kCqBpfyz5R
         VDOkg7RxSeedpkgrOH9lSi3M6O8x+5L48hFrTb4JW83e/KOIfm1Jk7ayq0Q+QjF4mS
         UI2Ce6coKUAUe2JUmCRNaFOHgpBIpQyTztepjUUL3nruCLEGaqU7yicAW52CIZEQgA
         V0mJhL5eoRhEfjDfQTsXhvIE+v4wyWOXUT+WR5w9B2Hno4YyQXOqEX6zc8dnkySRG0
         wLFFSEoAvS2yQ==
To:     Boqun Feng <boqun.feng@gmail.com>
From:   =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?utf-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>,
        Finn Behrens <fin@nyantec.com>
Subject: Re: [PATCH v2 1/2] rust: sync: impl {Debug,Display} for {Unique,}Arc
Message-ID: <-sv884vbS5p8t4Nc-WGNIRL5C3pUfwkNCv3qQd0d4scRGs2H_98imfPdveRaANkv7l122nZXpXIw2wcgKDtpULHr7u1i6qd4Tr3b_PO9OL4=@protonmail.com>
In-Reply-To: <20230207185216.1314638-2-boqun.feng@gmail.com>
References: <20230207185216.1314638-1-boqun.feng@gmail.com> <20230207185216.1314638-2-boqun.feng@gmail.com>
Feedback-ID: 27884398:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, February 7th, 2023 at 19:52, Boqun Feng <boqun.feng@gmail.com> =
wrote:

> This allows printing the inner data of `Arc` and its friends if the
> inner data implements `Display` or `Debug`. It's useful for logging and
> debugging purpose.
>=20
> Signed-off-by: Boqun Feng boqun.feng@gmail.com
>=20
> Reviwed-by: Vincenzo Palazzo vincenzopalazzodev@gmail.com

Reviewed-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>

>=20
> ---
>  rust/kernel/sync/arc.rs | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 519a6ec43644..e6176d9b5b29 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -22,6 +22,7 @@ use crate::{
>  };
>  use alloc::boxed::Box;
>  use core::{
> +    fmt,
>      marker::{PhantomData, Unsize},
>      mem::{ManuallyDrop, MaybeUninit},
>      ops::{Deref, DerefMut},
> @@ -522,3 +523,27 @@ impl<T: ?Sized> DerefMut for UniqueArc<T> {
>          unsafe { &mut self.inner.ptr.as_mut().data }
>      }
>  }
> +
> +impl<T: fmt::Display + ?Sized> fmt::Display for UniqueArc<T> {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        fmt::Display::fmt(self.deref(), f)
> +    }
> +}
> +
> +impl<T: fmt::Display + ?Sized> fmt::Display for Arc<T> {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        fmt::Display::fmt(self.deref(), f)
> +    }
> +}
> +
> +impl<T: fmt::Debug + ?Sized> fmt::Debug for UniqueArc<T> {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        fmt::Debug::fmt(self.deref(), f)
> +    }
> +}
> +
> +impl<T: fmt::Debug + ?Sized> fmt::Debug for Arc<T> {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        fmt::Debug::fmt(self.deref(), f)
> +    }
> +}
> --
> 2.39.1
