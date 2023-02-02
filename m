Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7950A687884
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjBBJOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjBBJOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:14:37 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588DE4EDC;
        Thu,  2 Feb 2023 01:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3qXO+M5wFBWI1Pw05uK8ySjcFWN056MI3EF4ABkf0lE=; b=NvqzAMDdCQkbYF1S9S0L7mLPgM
        /L5uQhBySWQc4R9y+ghq84GFHHazEhVw0F8Y6GlHlWhEw1H3gArd9A+9aMaoQ9bZZPpNPY7CxwZ7/
        rGnOLr81nnaKA24aE5uESaT1y9hwf98qRpafp8t/7/AOOEUWSnWmXBZ63CWld4TjxodTIk75NycNH
        d466F2Xz0TqooM2V3g6n86KQi6tivXeZ+02DiD0tYXRS97YgawmayBreRWEFndXBQ0zpleRBj8/5g
        URBc5/A8xbtKfTmVRJFSS9vSvEoJ0BMsZHZVgtgKwDvwBbc9tzId4yQxwmW2sk5LSf/E/YxNOs7Ih
        PztD46EA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pNVev-0056Tl-1z;
        Thu, 02 Feb 2023 09:13:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 41F223001E5;
        Thu,  2 Feb 2023 10:14:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F0ECA23F2C5B0; Thu,  2 Feb 2023 10:14:06 +0100 (CET)
Date:   Thu, 2 Feb 2023 10:14:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Subject: Re: [RFC 2/5] rust: sync: Arc: Introduces ArcInner::count()
Message-ID: <Y9t+3u+2UcAFQc+r@hirez.programming.kicks-ass.net>
References: <20230201232244.212908-1-boqun.feng@gmail.com>
 <20230201232244.212908-3-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201232244.212908-3-boqun.feng@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 03:22:41PM -0800, Boqun Feng wrote:
> This allows reading the current count of a refcount in an `ArcInner`.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  rust/helpers.c          | 6 ++++++
>  rust/kernel/sync/arc.rs | 9 +++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 09a4d93f9d62..afc5f1a39fef 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -46,6 +46,12 @@ bool rust_helper_refcount_dec_and_test(refcount_t *r)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_refcount_dec_and_test);
>  
> +unsigned int rust_helper_refcount_read(refcount_t *r)
> +{
> +	return refcount_read(r);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_refcount_read);
> +
>  /*
>   * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
>   * as the Rust `usize` type, so we can use it in contexts where Rust
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index fc680a4a795c..fbfceaa3096e 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -127,6 +127,15 @@ struct ArcInner<T: ?Sized> {
>      data: T,
>  }
>  
> +impl<T: ?Sized> ArcInner<T> {
> +    /// Returns the current reference count of [`ArcInner`].
> +    fn count(&self) -> u32 {
> +        // SAFETY: `self.refcount.get()` is always a valid pointer, and `refcount_read()` is a
> +        // normal atomic read (i.e. no data race) only requiring on the address is valid.
> +        unsafe { bindings::refcount_read(self.refcount.get()) }
> +    }
> +}

This is completely unsafe vs concurrency. In order to enable correct
tracing of refcount manipulations we have the __refcount_*(.oldp) API.

Admittedly, I have no idea how to sanely wire that up in this thing, but
it seems odd to me to have this 'safe' language display fundamentally
unsafe data like this.
