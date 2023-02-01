Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5331E68633D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 10:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjBAJ7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 04:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjBAJ7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 04:59:12 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EB532517
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 01:59:11 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id me3so49764512ejb.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 01:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=1SL9T3aYS6IFbexB1JuHREwm+6T3mP2MZTJ1gO4rfD8=;
        b=JLMtddu8szNLSJZLkW9ydSH98s7vymptf8mo+LrPH+7xSLZs7MWOHlZpVOuapE6pne
         +n0FVXyXbBJ372+UrAdqSAELmVDfie7c1OcvIRosaZF8sYjjygjN2gDMde5p8R5zrryt
         8xMy5OAdjPU3KMPDvE2Nj7b9Fj8fyp/ikHGD79pOiVokqUsYifCjW+y7k5utHkUa8aRs
         2mNgkBhnkOeI9K++AAaNYq/R8Hb9gJt4cvysEiuGfVEm+yNCwY8TeWjWBwqfB1mm2wvo
         xja/wZBAw7vSVUy3xClcaNHGHtAWoT4RTBBpifYT3kIL5RV1jzzwswDTd1Mmrt4ZLt/A
         tiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SL9T3aYS6IFbexB1JuHREwm+6T3mP2MZTJ1gO4rfD8=;
        b=UWFXOpJ0kuHYqp/ZhPeWQEt4jof9CXLzDT6dmV+vWdIvrmW2SYDgktbChg3xVBqV+0
         FLcn9yclTHcRh73hMhYoaHjvgUSNiT+34Ov5VUnJxyAY+ZljQGw66oJ9xUugfA9KV/Tb
         V23Zw0AtFw5e0wfjRfS6Wdo4O23ZEnRYDDn8GYCqK1xZPk1rKxcG5qHfMx4ctvIpsoIU
         n098DfxXbNorzSLygak3TM7YrRURG6kb6wFW3Rm1WaEhp9HS18OTKSkWaf2xlz9LExVo
         PMtNK5p1pf9f3nnU20oJ0NijULP3bSaubeSfrwncUv+5FoPzkKn9cFLlVoK2AYdYf6+S
         u9bg==
X-Gm-Message-State: AO0yUKUdjOL5+GPL8/SRYWRgabhryKwJIvFL6EdFkcN7soZBMCMLI5jq
        8CjFliYrwyOamfbj9/rGIgHr2g==
X-Google-Smtp-Source: AK7set/Lz63IZfgfOEQQvMMBr8y1TLVqn7Fh8Arg6FsBJWPglWOg6nc4cnXcx/TRA7AxEmRn0d+Xdw==
X-Received: by 2002:a17:906:d8ce:b0:87b:f7dd:792f with SMTP id re14-20020a170906d8ce00b0087bf7dd792fmr5638272ejb.8.1675245549817;
        Wed, 01 Feb 2023 01:59:09 -0800 (PST)
Received: from localhost ([79.142.230.49])
        by smtp.gmail.com with ESMTPSA id g9-20020a170906394900b00872a726783dsm9736926eje.217.2023.02.01.01.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 01:59:09 -0800 (PST)
References: <20230130064404.744600-1-wedsonaf@gmail.com>
 <20230130064404.744600-4-wedsonaf@gmail.com>
User-agent: mu4e 1.9.18; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: Re: [PATCH v2 4/5] rust: types: implement `ForeignOwnable` for the
 unit type
Date:   Wed, 01 Feb 2023 10:58:27 +0100
In-reply-to: <20230130064404.744600-4-wedsonaf@gmail.com>
Message-ID: <87h6w5k8pf.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Wedson Almeida Filho <wedsonaf@gmail.com> writes:

> This allows us to use the unit type `()` when we have no object whose
> ownership must be managed but one implementing the `ForeignOwnable`
> trait is needed.
>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
> ---

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>

> v1 -> v2: use `NonNull::dangling` to generate pointer
>
>  rust/kernel/types.rs | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 411655eca3e9..9d0fdbc55843 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -85,6 +85,18 @@ impl<T: 'static> ForeignOwnable for Box<T> {
>      }
>  }
>  
> +impl ForeignOwnable for () {
> +    type Borrowed<'a> = ();
> +
> +    fn into_foreign(self) -> *const core::ffi::c_void {
> +        core::ptr::NonNull::dangling().as_ptr()
> +    }
> +
> +    unsafe fn borrow<'a>(_: *const core::ffi::c_void) -> Self::Borrowed<'a> {}
> +
> +    unsafe fn from_foreign(_: *const core::ffi::c_void) -> Self {}
> +}
> +
>  /// Runs a cleanup function/closure when dropped.
>  ///
>  /// The [`ScopeGuard::dismiss`] function prevents the cleanup function from running.

