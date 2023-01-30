Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA10681B15
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237976AbjA3UI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbjA3UIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:08:22 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DCD29E3A
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:08:20 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ud5so35269174ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=HRBQoh6B7sYIybNlEBFtI8T4nCU7rmO2MKkpScOfGy4=;
        b=TRrxch5hIhM31zmQreuDt4jC8nRnoTUSCLUc7VaLQAA/I5Bpb7mG+waayszGE3b5fH
         TVnbhyYcfEJFBEld4bWV3pogocjsSvITMR7I9ltyEKqRfDCfnMgg0VvIUAa1IA2ugJSm
         tXy3phLsCcaKWd77dBHWNFVUOI6Lv8kGD8CCmzpvwbCslB9s55nQ0KCGugXv9AVJ7yaV
         PD/Lfq8KuLGhl3QTvL7n0dyetncSLkDaS7KHqk5TMDBMoO0vDy72Fn5piaN603sK55rM
         Pz9M9JaCQBhN1mdb9TGDhBOB6kj/6eDFaUgHkngCCaYrlAmKYlIsuMEebGq2uyGDgkfP
         D9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRBQoh6B7sYIybNlEBFtI8T4nCU7rmO2MKkpScOfGy4=;
        b=c1DmXG9Dy4FZGF+mJgoRK0SqAAz0UQ4+5jhqWECdz8/cI7W2MWuiG7VdDQmI4qjVX/
         73loeK/s5Exh8kRhPr/ij+amihwAtmvOvEutJv3VeF4UiNZdcXwFy/ieVaeGK4XClS2T
         SR5d9swZK/MiYF6kzI9wBRFMc20KD0+t4069u2F16Y53wtzntHPWMplasGymQAbcVwuO
         glrPyQoJNeCzFxU0PQytwY8i5vijoRap8KIOkcac8pYd5LHMk3cCi68NEfSYCOvXpchF
         BhL0A1DRQBNrXe/VXmP2tw1RRQQ+HzB11KYITvlrgefDg/afGO8vQFAxXr/DEkLxbrzy
         KL7A==
X-Gm-Message-State: AO0yUKVYmTeOhnv6ND2JXBARVUaJ9tkId9oMnukmzmT9syKadElknJQZ
        qGwMlDYdgKtXwFurLjUuivkxkQ==
X-Google-Smtp-Source: AK7set+rWb/b/YnRhyssTrsY0m2qSDuTMKItzlmnaDYmUn0ZqSPrtON0Tvy+SFsMZWK+TujtPV5OUA==
X-Received: by 2002:a17:907:8b95:b0:887:7871:2b2f with SMTP id tb21-20020a1709078b9500b0088778712b2fmr6581336ejc.61.1675109299034;
        Mon, 30 Jan 2023 12:08:19 -0800 (PST)
Received: from localhost ([79.142.230.49])
        by smtp.gmail.com with ESMTPSA id p6-20020a170906784600b0088ad82a8de4sm883045ejm.34.2023.01.30.12.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 12:08:18 -0800 (PST)
References: <20230130064404.744600-1-wedsonaf@gmail.com>
User-agent: mu4e 1.8.14; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: Re: [PATCH v2 1/5] rust: types: introduce `ScopeGuard`
Date:   Mon, 30 Jan 2023 21:07:07 +0100
In-reply-to: <20230130064404.744600-1-wedsonaf@gmail.com>
Message-ID: <87v8knlr9q.fsf@metaspace.dk>
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


Wedson Almeida Filho <wedsonaf@gmail.com> writes:

> This allows us to run some code when the guard is dropped (e.g.,
> implicitly when it goes out of scope). We can also prevent the
> guard from running by calling its `dismiss()` method.
>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
> ---

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>

> v1 -> v2: Simpler type for `ScopeGuard::new()` impl block
>
>  rust/kernel/types.rs | 126 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 125 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index e84e51ec9716..dd834bfcb57b 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -2,7 +2,131 @@
>  
>  //! Kernel types.
>  
> -use core::{cell::UnsafeCell, mem::MaybeUninit};
> +use core::{
> +    cell::UnsafeCell,
> +    mem::MaybeUninit,
> +    ops::{Deref, DerefMut},
> +};
> +
> +/// Runs a cleanup function/closure when dropped.
> +///
> +/// The [`ScopeGuard::dismiss`] function prevents the cleanup function from running.
> +///
> +/// # Examples
> +///
> +/// In the example below, we have multiple exit paths and we want to log regardless of which one is
> +/// taken:
> +/// ```
> +/// # use kernel::ScopeGuard;
> +/// fn example1(arg: bool) {
> +///     let _log = ScopeGuard::new(|| pr_info!("example1 completed\n"));
> +///
> +///     if arg {
> +///         return;
> +///     }
> +///
> +///     pr_info!("Do something...\n");
> +/// }
> +///
> +/// # example1(false);
> +/// # example1(true);
> +/// ```
> +///
> +/// In the example below, we want to log the same message on all early exits but a different one on
> +/// the main exit path:
> +/// ```
> +/// # use kernel::ScopeGuard;
> +/// fn example2(arg: bool) {
> +///     let log = ScopeGuard::new(|| pr_info!("example2 returned early\n"));
> +///
> +///     if arg {
> +///         return;
> +///     }
> +///
> +///     // (Other early returns...)
> +///
> +///     log.dismiss();
> +///     pr_info!("example2 no early return\n");
> +/// }
> +///
> +/// # example2(false);
> +/// # example2(true);
> +/// ```
> +///
> +/// In the example below, we need a mutable object (the vector) to be accessible within the log
> +/// function, so we wrap it in the [`ScopeGuard`]:
> +/// ```
> +/// # use kernel::ScopeGuard;
> +/// fn example3(arg: bool) -> Result {
> +///     let mut vec =
> +///         ScopeGuard::new_with_data(Vec::new(), |v| pr_info!("vec had {} elements\n", v.len()));
> +///
> +///     vec.try_push(10u8)?;
> +///     if arg {
> +///         return Ok(());
> +///     }
> +///     vec.try_push(20u8)?;
> +///     Ok(())
> +/// }
> +///
> +/// # assert_eq!(example3(false), Ok(()));
> +/// # assert_eq!(example3(true), Ok(()));
> +/// ```
> +///
> +/// # Invariants
> +///
> +/// The value stored in the struct is nearly always `Some(_)`, except between
> +/// [`ScopeGuard::dismiss`] and [`ScopeGuard::drop`]: in this case, it will be `None` as the value
> +/// will have been returned to the caller. Since  [`ScopeGuard::dismiss`] consumes the guard,
> +/// callers won't be able to use it anymore.
> +pub struct ScopeGuard<T, F: FnOnce(T)>(Option<(T, F)>);
> +
> +impl<T, F: FnOnce(T)> ScopeGuard<T, F> {
> +    /// Creates a new guarded object wrapping the given data and with the given cleanup function.
> +    pub fn new_with_data(data: T, cleanup_func: F) -> Self {
> +        // INVARIANT: The struct is being initialised with `Some(_)`.
> +        Self(Some((data, cleanup_func)))
> +    }
> +
> +    /// Prevents the cleanup function from running and returns the guarded data.
> +    pub fn dismiss(mut self) -> T {
> +        // INVARIANT: This is the exception case in the invariant; it is not visible to callers
> +        // because this function consumes `self`.
> +        self.0.take().unwrap().0
> +    }
> +}
> +
> +impl ScopeGuard<(), fn(())> {
> +    /// Creates a new guarded object with the given cleanup function.
> +    pub fn new(cleanup: impl FnOnce()) -> ScopeGuard<(), impl FnOnce(())> {
> +        ScopeGuard::new_with_data((), move |_| cleanup())
> +    }
> +}
> +
> +impl<T, F: FnOnce(T)> Deref for ScopeGuard<T, F> {
> +    type Target = T;
> +
> +    fn deref(&self) -> &T {
> +        // The type invariants guarantee that `unwrap` will succeed.
> +        &self.0.as_ref().unwrap().0
> +    }
> +}
> +
> +impl<T, F: FnOnce(T)> DerefMut for ScopeGuard<T, F> {
> +    fn deref_mut(&mut self) -> &mut T {
> +        // The type invariants guarantee that `unwrap` will succeed.
> +        &mut self.0.as_mut().unwrap().0
> +    }
> +}
> +
> +impl<T, F: FnOnce(T)> Drop for ScopeGuard<T, F> {
> +    fn drop(&mut self) {
> +        // Run the cleanup function if one is still present.
> +        if let Some((data, cleanup)) = self.0.take() {
> +            cleanup(data)
> +        }
> +    }
> +}
>  
>  /// Stores an opaque value.
>  ///

