Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E2D6884E3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjBBQ4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjBBQ4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:56:18 -0500
X-Greylist: delayed 167 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Feb 2023 08:56:18 PST
Received: from mail-40135.protonmail.ch (mail-40135.protonmail.ch [185.70.40.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A0765EF4;
        Thu,  2 Feb 2023 08:56:17 -0800 (PST)
Date:   Thu, 02 Feb 2023 16:56:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1675356976; x=1675616176;
        bh=KTKd/DfSeMG+RDS1R75oSk6PP95+qG0nM4YE2HKPVxM=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=cSJDT6tIdL0uOFani6e+Y5UaS75/DT9DjS5Qxpzt1oOWn+RnPqfyqNRvYMfbxzsmR
         QhPdSHLEBV0RC9njwj5YdOqGtzCewSwsq6IljOJk5q+cFVBbar8CQFeQkL73BshS69
         z8rb+KSYLXFfOFru/VAsspkTFJ0Q1PDoKBPvfYdNKCYM01zAds/vkUbDiKvxe9CRmi
         XzzqYH9uDSRvdQKQ1G7VgGEmwGrXRxAty0wHpeubRZfznHOthG8YKxiRHRRoLkB4vr
         ApDtclTGD2NukUrT+JS3r6li1sgeNWMxfxR2ewxRaL698qouKRsfxZNRSHbZ1rlM7y
         gUdHMyNzcWqLQ==
To:     Boqun Feng <boqun.feng@gmail.com>
From:   =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Subject: Re: [RFC 5/5] sample: rust: print: Add sampe code for Arc printing
Message-ID: <GpS33r41srXb-5jSGsywYv1yCxEU8iHy3BmNkMTn0J2ahxiQoDVIzPiOTfzHqX7Qm0lRlqavDbsrmLKIMwl_7cMtCvF6IJ8kELjFPcKNifE=@protonmail.com>
In-Reply-To: <20230201232244.212908-6-boqun.feng@gmail.com>
References: <20230201232244.212908-1-boqun.feng@gmail.com> <20230201232244.212908-6-boqun.feng@gmail.com>
Feedback-ID: 27884398:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, February 2nd, 2023 at 00:22, Boqun Feng <boqun.feng@gmail.com>=
 wrote:

> This both demonstrates the usage of different print format in Rust and
> serves as a selftest for the `Display` and `Debug` implementation of
> `Arc` and its friends.
>=20
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Reviewed-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>

> ---
>  samples/rust/rust_print.rs | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/samples/rust/rust_print.rs b/samples/rust/rust_print.rs
> index 8b39d9cef6d1..165a8d7b1c07 100644
> --- a/samples/rust/rust_print.rs
> +++ b/samples/rust/rust_print.rs
> @@ -15,6 +15,30 @@ module! {
>=20
>  struct RustPrint;
>=20
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
>=20
> +        arc_print()?;
> +
>          Ok(RustPrint)
>      }
>  }
> --
> 2.39.1
