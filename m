Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B61745BCE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjGCMDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjGCMDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:03:36 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A69109
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 05:03:35 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-978a991c3f5so327925866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 05:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688385814; x=1690977814;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t1v+YrLrrXSIOQf8bz1T6Uql4EJXsDtCQkkzaYmbuCA=;
        b=FUejcNSnRZ7m/03Jf1mqtKvjb50HqpeYWuZTR07jnKvM6WjmwvJfPuBbYfByz6wAqX
         2ccuZ/1FRGaF2Cqe5S4rn8dBIQh/9wUESH6ZPhOsoxYiobdeuxyAswhTl0331O0WHXUH
         /8YlTwweOWcndDF6e4sUrCgyna4ehXzpkfg7w+RV6iktnbIW1CmD8UwTn22y428Uw287
         rFRlphtxNPfTzfrQyK72Yv29IjoIXQPe5jJ3HiYDcSImvPqK70OXO5IWdkenE3jOenfV
         adyILTeopp83fyYSYyaFsLPluDWCPTUFyF28ZjIALZPKsOxdvOW0D8TSsKV3wsUnS8IX
         CBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688385814; x=1690977814;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t1v+YrLrrXSIOQf8bz1T6Uql4EJXsDtCQkkzaYmbuCA=;
        b=Jl7gMTmVAl33DWmqe5CtJUEyd8v6WnzzyVWSe0nbNxeQYEQ6uPjC6b23H+uCGyivQ/
         0bOuTqhetspMXzNtMW/gRJZ3Il54/fhkgbGj9qQcCIQ4LQAzUXWU6TTSLAXmuZU5og6i
         /KjmIEFcMz9EXcpjIYvDqqFBc7eZyFpdfMBmv8cUbtjjGjwwE4rPlazCXXCMwF2Umb98
         pOWPbAQLr0sTtWoTCssHrjD/lulIGrGZcRN2C1xQKLeNvx3EQ40b62Bifu4MwRTYr+pa
         JFaG5IJ01JlUFZmCjRNU5OsmxcqVikr5nt1SsyD/Zno2V1tUeVCiJomREdqRDHj+khHM
         xnfg==
X-Gm-Message-State: ABy/qLZ5ektCG7tK8mMLx5iaXY9fnouG1xZFA6BsNAKGEXuGof59IiFH
        TPM6vh4EcAbOcu79waQmz/WbTa8OXhezJjU=
X-Google-Smtp-Source: APBJJlH7LEH6KcScCZGItqnGPStgrwoa6mSsEXPWW5ygRZ3eSyaSxhfyPQVmVtx9Yc8HFCT8L9/B1f9r2ajUT+I=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:907:62a2:b0:990:88bf:c9e5 with SMTP
 id nd34-20020a17090762a200b0099088bfc9e5mr28112ejc.15.1688385814137; Mon, 03
 Jul 2023 05:03:34 -0700 (PDT)
Date:   Mon,  3 Jul 2023 12:03:31 +0000
In-Reply-To: <20230624092330.157338-6-benno.lossin@proton.me>
Mime-Version: 1.0
References: <20230624092330.157338-6-benno.lossin@proton.me>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230703120331.2384427-1-aliceryhl@google.com>
Subject: [PATCH 6/7] rust: init: Add functions to create array initializers
From:   Alice Ryhl <aliceryhl@google.com>
To:     benno.lossin@proton.me
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        lina@asahilina.net, linux-kernel@vger.kernel.org, nmi@metaspace.dk,
        ojeda@kernel.org, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benno Lossin <benno.lossin@proton.me> writes:
> Add two functions `pin_init_array_from_fn` and `init_array_from_fn` that
> take a function that generates initializers for `T` from usize, the added
> functions then return an initializer for `[T; N]` where every element is
> initialized by an element returned from the generator function.
> 
> Suggested-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
> +/// Initializes an array by initializing each element via the provided initializer.
> +///
> +/// # Examples
> +///
> +/// ```rust
> +/// let array: Box<[usize; 1000_000_000]>= Box::init(init_array_from_fn(|i| i)).unwrap();
> +/// println!("{array:?}");
> +/// ```
> +pub fn init_array_from_fn<I, const N: usize, T, E>(
> +    mut make_init: impl FnMut(usize) -> I,
> +) -> impl Init<[T; N], E>
> +where
> +    I: Init<T, E>,
> +{
> +    let init = move |slot: *mut [T; N]| {
> +        let slot = slot.cast::<T>();
> +        for i in 0..N {
> +            let init = make_init(i);
> +            // SAFETY: since 0 <= `i` < N, it is still in bounds of `[T; N]`.
> +            let ptr = unsafe { slot.add(i) };
> +            // SAFETY: The pointer is derived from `slot` and thus satisfies the `__init`
> +            // requirements.
> +            match unsafe { init.__init(ptr) } {
> +                Ok(()) => {}
> +                Err(e) => {
> +                    // We now free every element that has been initialized before:
> +                    for j in 0..i {
> +                        let ptr = unsafe { slot.add(j) };
> +                        // SAFETY: The value was initialized in a previous iteration of the loop
> +                        // and since we return `Err` below, the caller will consider the memory at
> +                        // `slot` as uninitialized.
> +                        unsafe { ptr::drop_in_place(ptr) };
> +                    }

The loop can be simplified like this:

ptr::drop_in_place(ptr::slice_from_raw_parts(slot, i));

Yes, this actually works and will run the destructor of each value.

Alice

