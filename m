Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA806D0543
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 14:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjC3Mt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 08:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjC3Mtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 08:49:52 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFF5A6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 05:49:51 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso13398610wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 05:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112; t=1680180590;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=9+K5/0WWDeVeEe+OTVzrXk5PiHrboI0Tjgq0g0AOhqY=;
        b=5yrrhu0VweMt6Y3/KG3eiBCU7L/Ncld4Yj1Q9vbwylygiYJJp37Y3Yl9ZYbOARjBR/
         Uqnvrm9o266KXf5oiCGk5Y+79SMIZR4Xw76rnVYg+bI8T1wyW2UdJlf/+1K86rPDOG1S
         wSgUtYC0o1iQFAKJg1RWG6D+5BfRhb61YmR6/6vXgYILDxy9u/BMX7Day95N/DB9Ia44
         eTSgQ8M8sDk8BMfmiwpI8sSGJlGIkVh5q0Par+BJP43CMnEW1RgqbojWzOVYJBCxNsbY
         uYthcb8eV04lThKYQNhenWK5KI2lgyRO0Y37Aji3sII21IrL0OH0GqPft0Qaq0siR9Mk
         ZOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680180590;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+K5/0WWDeVeEe+OTVzrXk5PiHrboI0Tjgq0g0AOhqY=;
        b=vrJqC6a7UzCRDU/hPNPPiGWgD3XnEtSsZfuGLo/zNRvAaJ8KnAwKxKHZ6+mFr9Zv7f
         O+AcyXgs1qxGNuIx+e+k2kfEtVuFmjt9pnymntQOBqAAUDeBox8e8vlGZellCeM0TPBX
         DeADV2fqHyZ6Wjm/HNnjI2Z+/4D5vP2tZOVoS4WACvL65CuIDwoRxjJjV0lPCR0xqMaz
         cbuIfR4t4xLRnHXfDggn8/X7Sti2J1TNH1fmyfDLsAmnItsLYJ+IekBU98iFTy6rY7qU
         SH9uyCQfQTTPQB0ToPI5TTaYaUJ7mr9bmBSoNmB6smURjITR26YjiXq3pBCd0N4PmCPh
         uWrw==
X-Gm-Message-State: AAQBX9cAoR8GB5Am5EeBmB1+attlbHUlcv/b63q61Ng/RBlScaLUxT0t
        cJXUIPrWaFPpBOPDYvbd3qZ7TQ==
X-Google-Smtp-Source: AKy350YVrGbxE3Bd4v1m+F3ok9Nrusg2V+E0fusX9dtc6+f5OdSxphjAN8y5r7KCDqNoGUKoYKHcGw==
X-Received: by 2002:a1c:f20e:0:b0:3ef:6ae7:89bd with SMTP id s14-20020a1cf20e000000b003ef6ae789bdmr11318687wmc.6.1680180589697;
        Thu, 30 Mar 2023 05:49:49 -0700 (PDT)
Received: from localhost ([194.62.217.4])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c315000b003eda46d6792sm6175846wmo.32.2023.03.30.05.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 05:49:49 -0700 (PDT)
References: <20230329223239.138757-1-y86-dev@protonmail.com>
 <20230329223239.138757-4-y86-dev@protonmail.com>
User-agent: mu4e 1.9.18; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     y86-dev@protonmail.com
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: Re: [PATCH v3 03/13] rust: types: add `Opaque::raw_get`
Date:   Thu, 30 Mar 2023 14:32:19 +0200
In-reply-to: <20230329223239.138757-4-y86-dev@protonmail.com>
Message-ID: <87leje4d5f.fsf@metaspace.dk>
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


y86-dev@protonmail.com writes:

> From: Benno Lossin <y86-dev@protonmail.com>
>
> This function mirrors `UnsafeCell::raw_get`. It avoids creating a
> reference and allows solely using raw pointers.
> The `pin-init` API will be using this, since uninitialized memory
> requires raw pointers.
>
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> ---

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>

>  rust/kernel/types.rs | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 9d0fdbc55843..ff2b2fac951d 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -238,6 +238,14 @@ impl<T> Opaque<T> {
>      pub fn get(&self) -> *mut T {
>          UnsafeCell::raw_get(self.0.as_ptr())
>      }
> +
> +    /// Gets the value behind `this`.
> +    ///
> +    /// This function is useful to get access to the value without creating intermediate
> +    /// references.
> +    pub const fn raw_get(this: *const Self) -> *mut T {
> +        UnsafeCell::raw_get(this.cast::<UnsafeCell<T>>())
> +    }
>  }
>
>  /// A sum type that always holds either a value of type `L` or `R`.

