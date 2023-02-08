Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD41868EC40
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjBHKCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjBHKCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:02:04 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24343423A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 02:02:04 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id jg8so10243668ejc.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 02:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pENRh59ONNUBe4kG875eVyzOAMbjZDxrD9e9swaSORw=;
        b=dzZ57QCEfIOIAlC9+jvgkXKzlyeHhn4pZyA01nHX3ZtrwWUdU8ybdEQr3kBn/Sll59
         mqg7JNmSwnZAmLzXDcTxFTPEPNTlgXoX5hFnGV+Z9vQxJFvxJ2nIDgPvD8LN3Sx+lRCI
         yDV+uOL1QCMrJ8K5bsNt/PRiaZJEzV4po2osXW0ABFRaY3LZ226UdSII+lxT7glhhh+a
         zTVZY5sm1Zzn/9TW+zFJuh5dqLyolmSwxCEB1OIu7t8uq9P9RfHUf008+a6gKCfs/XV9
         jagZC4Rr1Bip39FuMjQkCh7LFTgLseLUvQ3k5DwG86MVvk8hwFd1xg1gVvfj/8OG3+R9
         PguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pENRh59ONNUBe4kG875eVyzOAMbjZDxrD9e9swaSORw=;
        b=OtEDklwp4LPlbassejCY2fZRk8//iQwQTssYkDvADPYFPTkst8OaFPsIuQsVVCnuSv
         kkTWBib9TbKWoGQ4//6TPq60oMKAiKJPECxl5CH6rLiN2sAZqPQ8oyWt2YZ9gcQA6Nv6
         EUYCWteXooo/kMQOBZs9XcbAYphEXM4AJFY3Kl/kKWpNUnLptVCoNAVxqNLLotNi2qo9
         Phc6MjO7hRdbsui0ZsATd6A8PUKQNMWX2YWfuTTZ4nDzb4Iy6DeyhsHGd3WCN4UZysvU
         QzZCcRasFC7/nsfl5lwEXj2ctwTgCfP0lOvxzd4bZij2E+XCg8sXhj3BKxiKFGevVehc
         9oAg==
X-Gm-Message-State: AO0yUKVuqObzxGQjYqVwi1WXXcPtkMhQhYe55CUSxwsMRqEmPucQYTPa
        XaykDXjyquoGcAjzuZo4SBxj+g==
X-Google-Smtp-Source: AK7set87G8hDlBIhPstupcZ7boJjcZi2IXwcAef6+TKGnrQ+w45uCCfzuR9RsuZ8+DKwp+Wh/rpnxQ==
X-Received: by 2002:a17:907:9c0a:b0:8a9:e031:c49b with SMTP id ld10-20020a1709079c0a00b008a9e031c49bmr6278044ejc.4.1675850522601;
        Wed, 08 Feb 2023 02:02:02 -0800 (PST)
Received: from localhost ([194.62.217.4])
        by smtp.gmail.com with ESMTPSA id u10-20020a170906408a00b008aabf7faa17sm1207367ejj.67.2023.02.08.02.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 02:02:02 -0800 (PST)
References: <20230207185216.1314638-1-boqun.feng@gmail.com>
 <20230207185216.1314638-3-boqun.feng@gmail.com>
User-agent: mu4e 1.9.18; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergio =?utf-8?Q?Gonz=C3=A1le?= =?utf-8?Q?z?= Collado 
        <sergio.collado@gmail.com>, Finn Behrens <fin@nyantec.com>
Subject: Re: [PATCH v2 2/2] sample: rust: print: Add sampe code for Arc
 printing
Date:   Wed, 08 Feb 2023 11:01:36 +0100
In-reply-to: <20230207185216.1314638-3-boqun.feng@gmail.com>
Message-ID: <87y1p8h3vq.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Boqun Feng <boqun.feng@gmail.com> writes:

> This both demonstrates the usage of different print format in Rust and
> serves as a selftest for the `Display` and `Debug` implementation of
> `Arc` and its friends.
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Reviewed-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
> Reviewed-by: Finn Behrens <fin@nyantec.com>
> Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
> ---

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>


>  samples/rust/rust_print.rs | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/samples/rust/rust_print.rs b/samples/rust/rust_print.rs
> index 8b39d9cef6d1..165a8d7b1c07 100644
> --- a/samples/rust/rust_print.rs
> +++ b/samples/rust/rust_print.rs
> @@ -15,6 +15,30 @@ module! {
>=20=20
>  struct RustPrint;
>=20=20
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
>=20=20
> +        arc_print()?;
> +
>          Ok(RustPrint)
>      }
>  }

