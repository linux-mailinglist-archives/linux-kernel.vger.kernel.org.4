Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018D570DBDE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 13:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbjEWL7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 07:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbjEWL7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 07:59:32 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304DD118
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 04:59:26 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-96f7bf3cf9eso860770466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 04:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1684843164; x=1687435164;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=QR1MUsbPkF8iaQNWtY/LtUVVkhUDmli1/tIye2VFdbE=;
        b=qvuLsz9FjN+Ow6wPHmpPN9sq2xFW9UaiuZI8/RpzQTI46zGMjP+7RZAHi5FzfnzJSS
         hMlsWys/2phDu/pqehttwGb9aySSa8jbSxaTcbAPy7Mp1e5GuDioXy939L7T+V94S2ZA
         WIqthatCBC4qzoA5rPWm2W5kSwpTqIzNnC4IxUnuv5tz5nNEmE4T+Xsbu7quBpCUWkUP
         BOmC1G57K4/Jon8MuFyGFjeubHVzPCgyXDykRd00TrdEUnDvWXY5Zyy6A33txfd8Zfye
         u206w72qGadaHLfEI64LE8stqTZ4PIiN+HpE1ShYEM2Wd2uGI0aTyxStrXta5mlf1Ckc
         1isA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684843164; x=1687435164;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QR1MUsbPkF8iaQNWtY/LtUVVkhUDmli1/tIye2VFdbE=;
        b=TEJs1oi/AEcwOOVkRkvoixAF6KOFORFnMvM4HVan4VqiryrzlGgy5/h+8guK8dH8b3
         Bi99vAvp8IDP2iuZ4eH/qVRhRUkP/yT93RnBJBNEbMLxPUH4m2WvEYZgk+vG22XkdTV3
         MOPGOQP26TOrk/Z3pzDnQeTRmpzScukLdbrkU5WDUXAZagGppU8V9dTfkVrO3+S9Dx3e
         UMitfkH3DKfwAWcftGyOIo+xCEpJsoSGji6hXISIx+4hyA8Cfv9EDJ7at2KvHWVMEc+K
         Iy4aBOLp8j/u9vNvEVcAfk+Z92AYprARj9iqu3J0MtkNnsbAIliVJ4ZPmNP00oP4NSID
         esYQ==
X-Gm-Message-State: AC+VfDz25oyXL1T860bSyqCqQTpeu4fmM+Z+WmmwEFfO+ondzET9nwhI
        0q+sWHFDMiqSvP5F9E89ZUCb7w==
X-Google-Smtp-Source: ACHHUZ6mkY0TKM+w8HpDdJk16/geAD+v7LsqjoH7WywHI/OOlQ7m+A1qRTyVyO7jMKHN8tgQAS7z7g==
X-Received: by 2002:a17:907:8a12:b0:93e:fa12:aa1a with SMTP id sc18-20020a1709078a1200b0093efa12aa1amr14084404ejc.1.1684843164632;
        Tue, 23 May 2023 04:59:24 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id cf11-20020a170906b2cb00b0094ee700d8e4sm4321311ejb.44.2023.05.23.04.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 04:59:24 -0700 (PDT)
References: <20230517200814.3157916-1-aliceryhl@google.com>
 <20230517200814.3157916-2-aliceryhl@google.com>
User-agent: mu4e 1.10.3; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH v1 2/2] rust: sync: implement `AsRef<T>` for `Arc<T>`
Date:   Tue, 23 May 2023 13:59:00 +0200
In-reply-to: <20230517200814.3157916-2-aliceryhl@google.com>
Message-ID: <877cszfeck.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alice Ryhl <aliceryhl@google.com> writes:

> This trait lets you use `Arc<T>` in code that is generic over smart
> pointer types.
>
> The `AsRef` trait should be implemented on all smart pointers. The
> standard library also implements it on the ordinary `Arc`.
>
> Co-developed-by: Wedson Almeida Filho <walmeida@microsoft.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>

> ---
>  rust/kernel/sync/arc.rs | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 274febe3bb06..9ec911e4a0c7 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -264,6 +264,12 @@ impl<T: ?Sized> Deref for Arc<T> {
>      }
>  }
>  
> +impl<T: ?Sized> AsRef<T> for Arc<T> {
> +    fn as_ref(&self) -> &T {
> +        self.deref()
> +    }
> +}
> +
>  impl<T: ?Sized> Clone for Arc<T> {
>      fn clone(&self) -> Self {
>          // INVARIANT: C `refcount_inc` saturates the refcount, so it cannot overflow to zero.

