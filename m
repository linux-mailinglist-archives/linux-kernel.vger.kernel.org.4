Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1556D703D59
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 21:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243954AbjEOTJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 15:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243499AbjEOTJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 15:09:52 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3680F93C4
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 12:09:50 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-966287b0f72so2014830166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 12:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1684177789; x=1686769789;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=eFN3riFsUX1aJRke3gkBwMCKuLwmmi07T3ndOLDE1rE=;
        b=VOV8h1KkyY041gieBzFWVDYmm77Y0kEVHfmmBrRS94nWAjdcrIHJicpi5dpBL0RGtc
         apvToY3T3UaYZl4IxZjJPnRrHyst5B2jLO7YkD1ZDpmRswVNsdcEdA6DfYmcWa412HRF
         aIbxdqjMIQJ0Jtc7zWMywleKuM+kVXECqeNegXfkQML2Hk/gWA9qnxkXy8IxC1VFDFGh
         8waZS49PIiJZ/5PWc/sqyFer0kTJiaBnZexS++5In6HGJcxoDoKLyzSWsNXGHeGN3Bzi
         cUX1JL9Jwzg5sWMylB9MTpIMq+xOAPd4vvHGaMtmDIwia4ysgm10nCS3/5H526nMpzHa
         PPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684177789; x=1686769789;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFN3riFsUX1aJRke3gkBwMCKuLwmmi07T3ndOLDE1rE=;
        b=PZE3JlgsBHhTMBhS5pLRxYSZid4hormIrlerFBuP1kv3rfic53PKSa8b7UlH2CKVl7
         /J81Lz4yZGYHNuTEUFard4TBEBvj4h3Vbj9wseMAO+DEpGPsm7QruJw9hyfJoowe/5er
         7JM2bdlkkId5qPYVHIf0MHpD7QLDDXOo1R0gej54KWIG90sh06zNgnVSftB6QozplUaa
         eg/UklyslmjTBWp4TWGWRyHL+RrafdmZ5rRXkWW8KoJSOWwDl67LvYB2wFy/1MkgNOj4
         2QtlnAwxJyaBdGDjbcFaliV3X4/g4jce6sGG2fxfIXBynQc0DrJ1Ove9JeILZgfFpwfb
         UFSA==
X-Gm-Message-State: AC+VfDxGWAVXJ/la+QXbUwPYDquX9pdJkweBw090qsRrSRbOlofLVBtf
        p+JLPWnzScVlTRkhaZmranEc8Q==
X-Google-Smtp-Source: ACHHUZ6xoBq5iKbeuoQ9ODrTl6E57S/8BHMQ8gP6REFxuQcxS8sRjPcAEpK0ls47icDh8mQwvmJ1Pg==
X-Received: by 2002:a17:906:eeca:b0:965:d17b:292 with SMTP id wu10-20020a170906eeca00b00965d17b0292mr29875482ejb.60.1684177788655;
        Mon, 15 May 2023 12:09:48 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id v21-20020a1709060b5500b00965e68b8df5sm9898010ejg.76.2023.05.15.12.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 12:09:48 -0700 (PDT)
References: <20230502124015.356001-1-aliceryhl@google.com>
User-agent: mu4e 1.10.3; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH] rust: error: allow specifying error type on `Result`
Date:   Mon, 15 May 2023 21:09:20 +0200
In-reply-to: <20230502124015.356001-1-aliceryhl@google.com>
Message-ID: <877ct9o1hh.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alice Ryhl <aliceryhl@google.com> writes:

> Currently, if the `kernel::error::Result` type is in scope (which is
> often is, since it's in the kernel's prelude), you cannot write
> `Result<T, SomeOtherErrorType>` when you want to use a different error
> type than `kernel::error::Error`.
>
> To solve this we change the error type from being hard-coded to just
> being a default generic parameter. This still lets you write `Result<T>`
> when you just want to use the `Error` error type, but also lets you
> write `Result<T, SomeOtherErrorType>` when necessary.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>

>  rust/kernel/error.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 5f4114b30b94..01dd4d2f63d2 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -177,7 +177,7 @@ impl From<core::convert::Infallible> for Error {
>  /// Note that even if a function does not return anything when it succeeds,
>  /// it should still be modeled as returning a `Result` rather than
>  /// just an [`Error`].
> -pub type Result<T = ()> = core::result::Result<T, Error>;
> +pub type Result<T = (), E = Error> = core::result::Result<T, E>;
>  
>  /// Converts an integer as returned by a C kernel function to an error if it's negative, and
>  /// `Ok(())` otherwise.
>
> base-commit: ea76e08f4d901a450619831a255e9e0a4c0ed162

