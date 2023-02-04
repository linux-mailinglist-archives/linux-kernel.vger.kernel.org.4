Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8558568A978
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 11:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjBDKWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 05:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjBDKWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 05:22:31 -0500
Received: from mout-b-203.mailbox.org (mout-b-203.mailbox.org [195.10.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2FBE7;
        Sat,  4 Feb 2023 02:22:29 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4P87r16Krwz9tH7;
        Sat,  4 Feb 2023 11:22:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyantec.com; s=default;
        t=1675506145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DefcuSq0T8pqLwuQYpFNGZntYgo6EmnJiID7D6aEpl8=;
        b=fFvMcL+QXHke5NQ7s3HSBHlkGdlWlwju3jSpdtInfx3Pt3XNkkYlbK5OOPbbybhaBbtKI4
        DFCem3NgUCaNGVNiQX4w8ehBRY6z1WPfEo08qgP821qNtSikAMyBJGIBqnJNJ1H/r0MBmc
        gZrBaCWr7tmpZEyC6RJCyX1ini6p8a5zrYSm7e3j3Nq4FEsQSKeUaVUZ7P4QGV02t2Go4v
        eDBP8Lhd3hAgUi/Olr6HbWl4tGWUtcTSfAaBXlQ/95Y29TfKOeXJRcIJtqQ6T6hhvTxFue
        qgJP9pRILidC2zDhdKzP1RQLuIsG94MxYAg5t5/utv/2SUSutN345oRRboFFNg==
From:   Finn Behrens <fin@nyantec.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Subject: Re: [RFC 5/5] sample: rust: print: Add sampe code for Arc printing
Date:   Sat, 04 Feb 2023 11:22:23 +0100
Message-ID: <05A8F68D-F18B-42EA-B7D4-B6EAA9DF3718@nyantec.com>
In-Reply-To: <20230201232244.212908-6-boqun.feng@gmail.com>
References: <20230201232244.212908-1-boqun.feng@gmail.com>
 <20230201232244.212908-6-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2 Feb 2023, at 0:22, Boqun Feng wrote:

> This both demonstrates the usage of different print format in Rust and
> serves as a selftest for the `Display` and `Debug` implementation of
> `Arc` and its friends.
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Finn Behrens <fin@nyantec.com>

> ---
>  samples/rust/rust_print.rs | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/samples/rust/rust_print.rs b/samples/rust/rust_print.rs
> index 8b39d9cef6d1..165a8d7b1c07 100644
> --- a/samples/rust/rust_print.rs
> +++ b/samples/rust/rust_print.rs
> @@ -15,6 +15,30 @@ module! {
>
>  struct RustPrint;
>
> +fn arc_print() -> Result {
> +    use kernel::sync::*;
> +
> +    let a =3D Arc::try_new(1)?;
> +    let b =3D UniqueArc::try_new("hello, world")?;
> +
> +    // Prints the value of data in `a`.
> +    pr_info!("{}", a);
> +
> +    // Uses ":?" to print debug fmt of `b`.
> +    pr_info!("{:?}", b);
> +
> +    let a: Arc<&str> =3D b.into();
> +    let c =3D a.clone();
> +
> +    // Uses `dbg` to print, will move `c`.
> +    dbg!(c);
> +
> +    // Prints debug fmt with pretty-print "#" and number-in-hex "x".
> +    pr_info!("{:#x?}", a);
> +
> +    Ok(())
> +}
> +
>  impl kernel::Module for RustPrint {
>      fn init(_module: &'static ThisModule) -> Result<Self> {
>          pr_info!("Rust printing macros sample (init)\n");
> @@ -43,6 +67,8 @@ impl kernel::Module for RustPrint {
>          pr_cont!(" is {}", "continued");
>          pr_cont!(" with {}\n", "args");
>
> +        arc_print()?;
Wonder if it makes sense to also extract the other printing functions to =
group usage.
> +
>          Ok(RustPrint)
>      }
>  }
> -- =

> 2.39.1
