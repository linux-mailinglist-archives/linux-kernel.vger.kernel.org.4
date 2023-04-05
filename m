Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29086D88FE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 22:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbjDEUqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 16:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbjDEUqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 16:46:44 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6601A1B3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 13:46:41 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id ek18so144312037edb.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 13:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112; t=1680727600;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=PjVK3OcYLqF4e28UZO8WCt8ffeDwGmSl2Tba2xHUZTQ=;
        b=S+FdGx5OVDOWQ5NuClG6fFfByhM2/uoL0xdBSpNlIboO6AGKXYv1pvtR2kEIBF2v4w
         Uly2Hz01alFFO2T+djikpxMRSJnCd9IXU44uuX25AUrkgzYGL7zbRApowvRQzu8J5KNh
         kEzfSQHpHEZ5WJg25yd/d7auULoMB6ftWjkuWB9XgetRuRFLN1ej6aHCLAHSth0Uaf8p
         0ZmUWWUrsSMBHh8tTWLEIIZVC7S2W90Xpm4ad96OE9Td91v7frJfEV9QnzNXVBaBnc8G
         WY7ARbfUIYTwTJngzPviMkVSdp+c0w/j314svGS7lC3JIvE0PhsfyU37Qa33UvDD1d+g
         +7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680727600;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjVK3OcYLqF4e28UZO8WCt8ffeDwGmSl2Tba2xHUZTQ=;
        b=qpzdI6Cgwvi/Gm1SUpTlDHEmMFXGfdeJfD7llEccd0kwqUSDamAhP7WcHipn8TZ4nL
         aGfEYm2ULnx5qsmo3E/Z/s1RL4++Mu0RB08FfZnZwFohgtM5icQ+3ttxEHSMq8jl5jv+
         6pQyhK4tvTkmbAPEjjtdkn6HYpLZYW4QEhcTtjD0Fvu/m83WSpwK0LYtxA/iH7iY7QrS
         ehkid0qmJwXq9/XSKPY8Iky1o0Thg9KlTYLra/UKybYY5TkBH6M4SLrl5smeZDSIkCBa
         d6ALqM14Iud7wZFKuNENBKB//AIeCCDRgPktYA4ZC5Dl81RmPEu1AMJP5HWA/v39TIpj
         R31w==
X-Gm-Message-State: AAQBX9flBiXj03n0xnR1Kmkc44E/MiWusMWKPZGtH2MQMHQshojwg/KG
        k49d8JB7mYtlJOvjLJ3TfkU34g==
X-Google-Smtp-Source: AKy350aGDXTiJvSHX/YUEcY6IQZp4Bdeq9EFS0GjiPQShb4Gy7iz8du0uRkNAB08ACzio3QUcIPdCA==
X-Received: by 2002:a17:906:16c8:b0:933:3a22:8513 with SMTP id t8-20020a17090616c800b009333a228513mr4053369ejd.53.1680727599845;
        Wed, 05 Apr 2023 13:46:39 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id xb7-20020a170907070700b00948c2f245a9sm3928942ejb.110.2023.04.05.13.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 13:46:39 -0700 (PDT)
References: <20230405193445.745024-1-y86-dev@protonmail.com>
 <20230405193445.745024-2-y86-dev@protonmail.com>
User-agent: mu4e 1.10.1; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Benno Lossin <y86-dev@protonmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: Re: [PATCH v6 01/15] rust: enable the `pin_macro` feature
Date:   Wed, 05 Apr 2023 22:45:57 +0200
In-reply-to: <20230405193445.745024-2-y86-dev@protonmail.com>
Message-ID: <87fs9et5u8.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Benno Lossin <y86-dev@protonmail.com> writes:

> This feature enables the use of the `pin!` macro for the `stack_pin_init!`
> macro. This feature is already stabilized in Rust version 1.68.
>
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Acked-by: Boqun Feng <boqun.feng@gmail.com>
> Cc: Andreas Hindborg <a.hindborg@samsung.com>
> ---

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>

>  rust/kernel/lib.rs     | 1 +
>  scripts/Makefile.build | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 223564f9f0cc..4317b6d5f50b 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -17,6 +17,7 @@
>  #![feature(core_ffi_c)]
>  #![feature(dispatch_from_dyn)]
>  #![feature(generic_associated_types)]
> +#![feature(pin_macro)]
>  #![feature(receiver_trait)]
>  #![feature(unsize)]
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 76323201232a..ba4102b9d94d 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -277,7 +277,7 @@ $(obj)/%.lst: $(src)/%.c FORCE
>  # Compile Rust sources (.rs)
>  # ---------------------------------------------------------------------------
>
> -rust_allowed_features := core_ffi_c
> +rust_allowed_features := core_ffi_c,pin_macro
>
>  rust_common_cmd = \
>  	RUST_MODFILE=$(modfile) $(RUSTC_OR_CLIPPY) $(rust_flags) \

