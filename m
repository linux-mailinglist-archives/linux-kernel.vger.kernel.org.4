Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F9973D161
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 16:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjFYOSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 10:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjFYOSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 10:18:00 -0400
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047DCE54
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 07:17:56 -0700 (PDT)
Date:   Sun, 25 Jun 2023 14:17:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1687702674; x=1687961874;
        bh=inMyYrOTZsqu+PuRu8d57Qiq8p3tOvJbGALKqIAke6I=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=nWmcbiPcF+KrhUXh5wyp5V46TYfMXv6kItl9dia5OypB2Ps1ksl9NG2V/w8VOJfd5
         JegCvE0pTbT2m1UFoUuXI78YSE9MwN3ULj8PZz7Aj9eK6pGhv5aZ/Zm+rEg2wgG8/V
         RIZWhbLvl3B8ciuiMWSZ++2h8CNa9ubdJO2mFzvGaJ+B7wMlDoqn7AtfHRJpehN1jF
         hvMd7TyY1f38DtdQKMmxoj4brQOfx8PWrxG6jU5lxlgXED45VcGuCaOWA8nh1kjtHW
         T1qAxLWqJLUM+app+ftODyh97umBEQm81lfoqbdQtX0l8PwrwmiVbY6/VRJUMj58mo
         863jN9exy7tjQ==
To:     Benno Lossin <benno.lossin@proton.me>
From:   =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH 5/7] rust: init: add `..Zeroable::zeroed()` syntax for zeroing all missing fields
Message-ID: <8lCE3SyChVVb2HphigkwKsxv7etgmS0N3AzcDyYtCEoqcFEKvY-5ILkOrWUr_vnWrvsWrAHXVfwcWARfsiMHC8Yc03sND-PuuK-2z9j4z6I=@protonmail.com>
In-Reply-To: <6f4e1d68-f828-8990-4859-8ab24907fa46@proton.me>
References: <20230624092330.157338-1-benno.lossin@proton.me> <20230624092330.157338-5-benno.lossin@proton.me> <W1fY0aa_v9j7lJNWXk_WNaxY2qruJo1R6k7u0g-X5L5Rxuod-VMBMmByICDwjF_fFGvNJTV41QapW0WeVduNYqxgo9S243gnNGXbexq6P3Q=@protonmail.com> <f4bcd952-1ad9-42b7-6e0b-72a115dcbe8e@proton.me> <we7PHkrpBV6kIgFZojiBFerqlXtSJB9HWkj129OGUWUVyVFwtuoirr3gVybgLzW2hmpUqqSAAQUPsdfL9QC2JyNKOLRNX0mSTfgD8llSJKE=@protonmail.com> <6f4e1d68-f828-8990-4859-8ab24907fa46@proton.me>
Feedback-ID: 27884398:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, June 25th, 2023 at 15:07, Benno Lossin <benno.lossin@proton.me> =
wrote:
> On 25.06.23 14:56, Bj=C3=B6rn Roy Baron wrote:
> > On Saturday, June 24th, 2023 at 23:14, Benno Lossin <benno.lossin@proto=
n.me> wrote:
>=20
> >>>> +                        // Ensure that the struct is indeed `Zeroab=
le`.
> >>>> +                        is_zeroable(slot);
> >>>> +                        // SAFETY:  The type implements `Zeroable` =
by the check above.
> >>>> +                        unsafe { ::core::ptr::write_bytes(slot, 0, =
1) };
> >>>> +                        $init_zeroed // this will be `()` if set.
> >>>
> >>> How does this work? Shouldn't there be a ; after $init_zeroed to cons=
ume the () value?
> >>
> >> It is the last expression of a block and since it is `()` it is ok
> >> (adding a ; would also be ok, but it is not necessary).
> >
> > I'm surprised it is considered the last expression of a block. Unlike w=
ith {} using $()? will still
> > allow variables defined inside this as if they were outside of it. Also=
 I can't reproduce this
> > behavior with:
> >
> >      macro_rules! foo {
> >          ($($a:expr)?) =3D> {
> >              $($a)?
> >              bar();
> >          }
> >      }
> >
> >      fn main() {
> >          foo!(());
> >      }
> >
> > Is there something I'm missing?
> >
> > Cheers,
> > Bj=C3=B6rn
>=20
> Not sure what you mean with "allow variables defined inside this
> as if they were outside of it". But note that in the macro `$init_zeroed`
> is the last expression of a block. Here is a small example:

$(let $this =3D unsafe { ::core::ptr::NonNull::new_unchecked(slot) };)? com=
es after
this code in the same block that contains struct __InitOk;. And after that =
another
$crate::__init_internal!() invocation. That is why I don't get that this is=
 allowed
at all.

>=20
> ```
> macro_rules! foo {
>      ($($a:expr)?) =3D> {{
>          $(
>              bar();
>              $a
>          )?
>      }};
> }
>=20
> fn bar() {}
>=20
> fn main() {
>      foo!(());
>      foo!();
> }
> ```
>=20
> it expands to this:
> ```
> fn main() {
>      {
>          bar();
>          ()
>      };
>      {};
> }
> ```
>=20
> --
> Cheers,
> Benno
> 
