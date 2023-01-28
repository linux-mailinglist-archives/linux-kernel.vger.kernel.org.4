Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEE367F760
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 11:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjA1Ku0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 05:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbjA1KuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 05:50:14 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8485222F7;
        Sat, 28 Jan 2023 02:50:06 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id vw16so19765632ejc.12;
        Sat, 28 Jan 2023 02:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRQuV4TaE8EzLcMmhyuz6iKDDEwNSHJvDz0W5JvrYzI=;
        b=Be65aRmazjbuYKgVYAZG3m7fCGL4LDUCjyHNXwDGfFDsJwBtRT0Vj68lFrrCxlelyo
         gmnAqJS36wTOuRfXqLTOpWYkPMWQbsnidOQ5LBt07XPXNCNyNjxtx0Vf63lDrjVFIVRZ
         2jowYeRvAwnjsbGy2IsaVisgjgEC5/V0hAGgiWnUPaFUEZMIZuA5MMZ+2fhXdhqGLiy7
         IVzbUPxgw4GonVkOTRkJNjjeqSA6RcpR3sTVgG2AMSZ6MAZIZW90U1H2bnQQAR6QihZZ
         YUFYi+G/ltOv8Ec7y5q4gf9xt+knH/aAsY/Zz1W/9XTjyxUmJcD8PmZhc0dUwfkBfvJ/
         ZsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mRQuV4TaE8EzLcMmhyuz6iKDDEwNSHJvDz0W5JvrYzI=;
        b=tpkZjZJLjt1K5tqz8P2pPwCGVZOhpbv7VVRbAMc6zAOSfn2AWYOuYxFKtGEE5dRYf0
         717iiHm20RwiqVctd2j90hHkk8w2EMcAUw2iXp8K8VBWLzXJaNOIH9fZPUfskCXxT26y
         4g7Cbrz6qyEb2bdWJXBcU2ypSdx8Flyc8uYru0FYsuocIAu9c6esgeaJw227/Gd3oDtg
         QrujdCjFZL7Eex9gWndXscITVaaoIdk00IDfovwYAI3cCr0VB423TWAAHYt028HMm5Nk
         zuHw6FRmRSmeONpb0x5lnZ8I0cQozy/j15BEmSht0qc/B/0H/u9XNm8vo1RJwH4UQie0
         fyaw==
X-Gm-Message-State: AO0yUKVTvltpFbjq9Efy/ERU9xpB0jt556gksXJNHgZ+k2kKbrO+dCuN
        /Q4s+jfxjd8XStCadXCchdbL20Bg0xI3ul+k
X-Google-Smtp-Source: AK7set+TB+OqpeANyl+bG/Pwg2v2bZWCFHYtfcjCmHK3JN0htFI9mUJNdGfZu287D4+fISAwvlpXRg==
X-Received: by 2002:a17:907:a42a:b0:84d:4be4:aa2b with SMTP id sg42-20020a170907a42a00b0084d4be4aa2bmr2625016ejc.68.1674903005366;
        Sat, 28 Jan 2023 02:50:05 -0800 (PST)
Received: from localhost ([2001:b07:5d37:537d:645c:8576:916a:8c99])
        by smtp.gmail.com with ESMTPSA id fy15-20020a1709069f0f00b0084c62b7b7d8sm3659732ejc.187.2023.01.28.02.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jan 2023 02:50:04 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 28 Jan 2023 11:50:03 +0100
Message-Id: <CQ3RK9MZV5SE.BYRDR31FD0NW@vincent>
Subject: Re: [PATCH 3/5] rust: types: implement `ForeignOwnable` for
 `Box<T>`
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        <rust-for-linux@vger.kernel.org>
Cc:     "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.8.2
References: <20230119174036.64046-1-wedsonaf@gmail.com>
 <20230119174036.64046-3-wedsonaf@gmail.com>
In-Reply-To: <20230119174036.64046-3-wedsonaf@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Jan 19, 2023 at 6:40 PM CET, Wedson Almeida Filho wrote:
> This allows us to hand ownership of Rust dynamically allocated
> objects to the C side of the kernel.
>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> ---
Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>

>  1 file changed, 22 insertions(+)
>
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 5475f6163002..e037c262f23e 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -63,6 +63,28 @@ pub trait ForeignOwnable {
>      unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self;
>  }
> =20
> +impl<T: 'static> ForeignOwnable for Box<T> {
> +    type Borrowed<'a> =3D &'a T;
> +
> +    fn into_foreign(self) -> *const core::ffi::c_void {
> +        Box::into_raw(self) as _
> +    }
> +
> +    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a T {
> +        // SAFETY: The safety requirements for this function ensure that=
 the object is still alive,
> +        // so it is safe to dereference the raw pointer.
> +        // The safety requirements of `from_foreign` also ensure that th=
e object remains alive for
> +        // the lifetime of the returned value.
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
> +        // SAFETY: The safety requirements of this function ensure that =
`ptr` comes from a previous
> +        // call to `Self::into_foreign`.
> +        unsafe { Box::from_raw(ptr as _) }
> +    }
> +}
> +
>  /// Runs a cleanup function/closure when dropped.
>  ///
>  /// The [`ScopeGuard::dismiss`] function prevents the cleanup function f=
rom running.
> --=20
> 2.34.1

