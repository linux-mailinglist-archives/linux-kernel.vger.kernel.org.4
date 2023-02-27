Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B212C6A4126
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 12:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjB0LtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 06:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjB0Ls6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 06:48:58 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884FD1E280
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 03:48:49 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id i34so24586780eda.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 03:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=FrL5lYUkqDlmCEsBUKLgTEfbH9XDD8w+e14IRfNrUoc=;
        b=7rJVxVp/slSrMx5UlCYNy7nCehokTnlhjyxnBBsk6sQmT0bX/mUzeIIbqN4Qm7tEBB
         rentsmMLfqNGnWAaGcaiNRkaGIBNkMgbzZ5V2kTDW+983it6bpGtdDFEL7ggW/g3G6fi
         apmDnxQa7x+b062svrIi4FJUmBHWhLN6uKjXwSEdcTRPghB4eTweMz06byLYNSHztmEV
         k9GNRfGMwco94gGjVER/Il4JQZ9c01eBQJAchBfvEFOZyj8gv9izFTqhanXJxg/FCto3
         qbzRRejgV+biY6YF/pQnvV6jsoeiwLD3Tw80pwbeZqiD3J7PpsQgvLeGtka3yq2wFAyk
         QBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrL5lYUkqDlmCEsBUKLgTEfbH9XDD8w+e14IRfNrUoc=;
        b=v3C6/Ig0Gdh7/AxQSypTWbRSxVQti5OqnTYztcmpHALrOODY4RJPdxe5SvjZmmfSSY
         GLiR3BTjWP69CNyZmDxlsWbHxtUyXaf4lLMo9SX50iECRTv4aooZMtrHZIM8VdFIpXvl
         NXqL3UlrIFg6ameUUIqUq1yJsa4nBupR6bBx+SHievZTn0cX0KeNrkTcYHcWvcmC6eZf
         GniKcbnzftDCl/5HNPoK8LrRRSAtoRtm7O3Cloomh5zzKoz4Bd/rQO+fESI0QX60JptQ
         WK4kTq4Z61J7bc11MqlQRa0jz1yGQK3lzuNMZKyxyQbBxfzUfUWfN3TXgZZBVRF6qhxq
         Pkpw==
X-Gm-Message-State: AO0yUKWIls5fancXI0t5+jX0ADHN8Ee8CB3/Qz8vg7tCL5UL3uYTNw1G
        KTh00qBbMqeuFoszwDSj2qUgLw==
X-Google-Smtp-Source: AK7set+1Xufy3lZTLIWLc/LUY9FQT3FcF0q4uexR/2U7zd+hpwLiFESBhwLurbO+FFlq8cewx0M4Ig==
X-Received: by 2002:a17:907:6f0e:b0:8f9:ed75:f962 with SMTP id sy14-20020a1709076f0e00b008f9ed75f962mr7928483ejc.18.1677498527989;
        Mon, 27 Feb 2023 03:48:47 -0800 (PST)
Received: from localhost ([194.62.217.2])
        by smtp.gmail.com with ESMTPSA id jr6-20020a170906a98600b008b980c3e013sm3144257ejb.179.2023.02.27.03.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 03:48:47 -0800 (PST)
References: <20230224-rust-arc-v1-0-568eea613a41@asahilina.net>
 <20230224-rust-arc-v1-2-568eea613a41@asahilina.net>
User-agent: mu4e 1.9.18; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Subject: Re: [PATCH 2/2] rust: sync: arc: Add
 UniqueArc<MaybeUninit<T>::assume_init()
Date:   Mon, 27 Feb 2023 12:48:34 +0100
In-reply-to: <20230224-rust-arc-v1-2-568eea613a41@asahilina.net>
Message-ID: <87y1oj9vmp.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Asahi Lina <lina@asahilina.net> writes:

> We can already create `UniqueArc<MaybeUninit<T>>` instances with
> `UniqueArc::try_new_uninit()` and write to them with `write()`. Add
> the missing unsafe `assume_init()` function to promote it to
> `UniqueArc<T>`, so users can do piece-wise initialization of the
> contents instead of doing it all at once as long as they keep the
> invariants (the same requirements as `MaybeUninit::assume_init()`).
>
> This mirrors the std `Arc::assume_init()` function. In the kernel,
> since we have `UniqueArc`, arguably this only belongs there since most
> use cases will initialize it immediately after creating it, before
> demoting it to `Arc` to share it.
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>

>  rust/kernel/sync/arc.rs | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 752bd7c4699e..b8e9477fe865 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -512,6 +512,15 @@ impl<T> UniqueArc<MaybeUninit<T>> {
>      /// Converts a `UniqueArc<MaybeUninit<T>>` into a `UniqueArc<T>` by writing a value into it.
>      pub fn write(mut self, value: T) -> UniqueArc<T> {
>          self.deref_mut().write(value);
> +        // SAFETY: We have just written the contents fully.
> +        unsafe { self.assume_init() }
> +    }
> +
> +    /// Returns a UniqueArc<T>, assuming the MaybeUninit<T> has already been initialized.
> +    ///
> +    /// # Safety
> +    /// The contents of the UniqueArc must have already been fully initialized.
> +    pub unsafe fn assume_init(self) -> UniqueArc<T> {
>          let inner = ManuallyDrop::new(self).inner.ptr;
>          UniqueArc {
>              // SAFETY: The new `Arc` is taking over `ptr` from `self.inner` (which won't be

