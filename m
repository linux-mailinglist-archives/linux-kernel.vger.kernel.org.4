Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459E373CB84
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 17:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbjFXPDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 11:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjFXPD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 11:03:29 -0400
X-Greylist: delayed 271 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 24 Jun 2023 08:03:28 PDT
Received: from mail-4324.protonmail.ch (mail-4324.protonmail.ch [185.70.43.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5870510DB
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 08:03:28 -0700 (PDT)
Date:   Sat, 24 Jun 2023 15:03:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1687619006; x=1687878206;
        bh=0g0U1QkNwFfGzmOITXba0UjVRvJchVE09IDi9mDLtQY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=dFcm1Hd26UpL8ML+j5iaiTYos7PMncEz/Y8oGpa25NznikBKTmDI0UohPYgjID3Zr
         APVxk2XgdUTtTZpIPW1YUdibSeQaGoHIfytI+nazFHUh24n2je119aYX5lPqm0CdYq
         72WQoZzqnIKcn0FZdehWB34YXnlg5z0p1vcBRz5Mz3tklzq6RqCdeYMlQ++03M2SCv
         JF40SiJXEuzT32P7GQlIN+2wqYQFlrZq8il8p2p8oo7kuvMw7GM9iY5pMhZx0yjErK
         pMX3KY3nQaP6pya+G5ID1NGHD5h5GdrDmHiUiWDLpd+aZubwSgTMXHqrx7qbrPUP+T
         qPAT/1qkzqtHw==
To:     Benno Lossin <benno.lossin@proton.me>
From:   =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH 4/7] rust: init: wrap type checking struct initializers in a closure
Message-ID: <zLJ2TSszsTrjSQ39Y8JsZLnZQ2qe8JLp_dK7vSArkClDKOzaCzO94OXwYdco6FLBNTr-MeRp0c75a-aKm_8wKlb9aPgfvf9nz2Ha5XbrutE=@protonmail.com>
In-Reply-To: <20230624092330.157338-4-benno.lossin@proton.me>
References: <20230624092330.157338-1-benno.lossin@proton.me> <20230624092330.157338-4-benno.lossin@proton.me>
Feedback-ID: 27884398:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, June 24th, 2023 at 11:25, Benno Lossin <benno.lossin@proton.me=
> wrote:

> In the implementation of the init macros there is a `if false` statement
> that type checks the initializer to ensure every field is initialized.
> Since the next patch has a stack variable to store the struct, the
> function might allocate too much memory on debug builds. Putting the
> struct into a closure ensures that even in debug builds no stack
> overflow error is caused. In release builds this was not a problem since
> the code was optimized away due to the `if false`.
>=20
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
>  rust/kernel/init/macros.rs | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>=20
> diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
> index df4281743175..1e0c4aca055a 100644
> --- a/rust/kernel/init/macros.rs
> +++ b/rust/kernel/init/macros.rs
> @@ -1037,14 +1037,18 @@ macro_rules! __init_internal {
>                      // We use unreachable code to ensure that all fields=
 have been mentioned exactly
>                      // once, this struct initializer will still be type-=
checked and complain with a
>                      // very natural error message if a field is forgotte=
n/mentioned more than once.
> -                    #[allow(unreachable_code, clippy::diverging_sub_expr=
ession)]
> +                    #[allow(unreachable_code,
> +                            clippy::diverging_sub_expression,
> +                            clippy::redundant_closure_call)]
>                      if false {
> -                        $crate::__init_internal!(make_initializer:
> -                            @slot(slot),
> -                            @type_name($t),
> -                            @munch_fields($($fields)*,),
> -                            @acc(),
> -                        );
> +                        (|| {
> +                            $crate::__init_internal!(make_initializer:
> +                                @slot(slot),
> +                                @type_name($t),
> +                                @munch_fields($($fields)*,),
> +                                @acc(),
> +                            );
> +                        })();

Is it necessary to call this closure? Typechecking of the closure should ha=
ppen even without calling it.

>                      }
>                  }
>                  Ok(__InitOk)
> --
> 2.41.0

Cheers,
Bj=C3=B6rn
