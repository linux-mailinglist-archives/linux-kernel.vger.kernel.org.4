Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16BC731AD3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344872AbjFOOHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344864AbjFOOHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:07:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329D8171C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 07:07:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB187629A6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 14:07:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD17C433C8;
        Thu, 15 Jun 2023 14:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686838043;
        bh=JaIPop+sKwnDzXNv4G1EJket6XuIM38qKa1hMH/9O2c=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LZQltmDr+fUclHzPFF9voyKNpL3CxvyYHO+xTFULKfDCG3AprKkNu4veCZEb1BtfD
         q9Leqmx2TAKuU/bEKYqhAX/0POg71OV1gn1Rw3o2vocTSLDcB2ULmCgpaB3V9qw1uK
         6AaD1bNYFBWQEsjERIYJ1Ihx+5pYLW6srP7xwvyBJOfd0xzAYmfbdR/U6+K+cE2cAR
         m7Yjen9PuIgfjsEDruCBWXV/6c2wvJyUecWq9tQfLpVPkIxIWvpDHQs6t30wSuau83
         lvLZGCeOY0/UF7T9bsRWAiliM+kNL6QiTeLMtdkg3ceMuqr3BGKbO9hxV+qCEPFnlB
         8kQ2MauJGOFcQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CF692CE0BAE; Thu, 15 Jun 2023 07:07:22 -0700 (PDT)
Date:   Thu, 15 Jun 2023 07:07:22 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        keescook@chromium.org, peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH] locking/atomic: scripts: fix ${atomic}_dec_if_positive()
 kerneldoc
Message-ID: <87501f01-f558-47a4-aebd-fbbdb62a6161@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230615132734.1119765-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615132734.1119765-1-mark.rutland@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 02:27:34PM +0100, Mark Rutland wrote:
> The ${atomic}_dec_if_positive() ops are unlike all the other conditional
> atomic ops. Rather than returning a boolean success value, these return
> the value that the atomic variable would be updated to, even when no
> update is performed.
> 
> We missed this when adding kerneldoc comments, and the documentation for
> ${atomic}_dec_if_positive() erroneously states:
> 
> | Return: @true if @v was updated, @false otherwise.
> 
> Ideally we'd clean this up by aligning ${atomic}_dec_if_positive() with
> the usual atomic op conventions: with ${atomic}_fetch_dec_if_positive()
> for those who care about the value of the varaible, and
> ${atomic}_dec_if_positive() returning a boolean success value.
> 
> In the mean time, align the documentation with the current reality.
> 
> Fixes: ad8110706f381170 ("locking/atomic: scripts: generate kerneldoc comments")
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  include/linux/atomic/atomic-arch-fallback.h | 6 +++---
>  include/linux/atomic/atomic-instrumented.h  | 8 ++++----
>  include/linux/atomic/atomic-long.h          | 4 ++--
>  scripts/atomic/kerneldoc/dec_if_positive    | 2 +-
>  4 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
> index 8cded57dd7a6f..18f5744dfb5d8 100644
> --- a/include/linux/atomic/atomic-arch-fallback.h
> +++ b/include/linux/atomic/atomic-arch-fallback.h
> @@ -2520,7 +2520,7 @@ raw_atomic_dec_unless_positive(atomic_t *v)
>   *
>   * Safe to use in noinstr code; prefer atomic_dec_if_positive() elsewhere.
>   *
> - * Return: @true if @v was updated, @false otherwise.
> + * Return: The old value of (@v - 1), regardless of whether @v was updated.
>   */
>  static __always_inline int
>  raw_atomic_dec_if_positive(atomic_t *v)
> @@ -4636,7 +4636,7 @@ raw_atomic64_dec_unless_positive(atomic64_t *v)
>   *
>   * Safe to use in noinstr code; prefer atomic64_dec_if_positive() elsewhere.
>   *
> - * Return: @true if @v was updated, @false otherwise.
> + * Return: The old value of (@v - 1), regardless of whether @v was updated.
>   */
>  static __always_inline s64
>  raw_atomic64_dec_if_positive(atomic64_t *v)
> @@ -4657,4 +4657,4 @@ raw_atomic64_dec_if_positive(atomic64_t *v)
>  }
>  
>  #endif /* _LINUX_ATOMIC_FALLBACK_H */
> -// 3916f02c038baa3f5190d275f68b9211667fcc9d
> +// 202b45c7db600ce36198eb1f1fc2c2d5268ace2d
> diff --git a/include/linux/atomic/atomic-instrumented.h b/include/linux/atomic/atomic-instrumented.h
> index ebfc795f921b9..d401b406ef7c4 100644
> --- a/include/linux/atomic/atomic-instrumented.h
> +++ b/include/linux/atomic/atomic-instrumented.h
> @@ -1570,7 +1570,7 @@ atomic_dec_unless_positive(atomic_t *v)
>   *
>   * Unsafe to use in noinstr code; use raw_atomic_dec_if_positive() there.
>   *
> - * Return: @true if @v was updated, @false otherwise.
> + * Return: The old value of (@v - 1), regardless of whether @v was updated.
>   */
>  static __always_inline int
>  atomic_dec_if_positive(atomic_t *v)
> @@ -3134,7 +3134,7 @@ atomic64_dec_unless_positive(atomic64_t *v)
>   *
>   * Unsafe to use in noinstr code; use raw_atomic64_dec_if_positive() there.
>   *
> - * Return: @true if @v was updated, @false otherwise.
> + * Return: The old value of (@v - 1), regardless of whether @v was updated.
>   */
>  static __always_inline s64
>  atomic64_dec_if_positive(atomic64_t *v)
> @@ -4698,7 +4698,7 @@ atomic_long_dec_unless_positive(atomic_long_t *v)
>   *
>   * Unsafe to use in noinstr code; use raw_atomic_long_dec_if_positive() there.
>   *
> - * Return: @true if @v was updated, @false otherwise.
> + * Return: The old value of (@v - 1), regardless of whether @v was updated.
>   */
>  static __always_inline long
>  atomic_long_dec_if_positive(atomic_long_t *v)
> @@ -5000,4 +5000,4 @@ atomic_long_dec_if_positive(atomic_long_t *v)
>  
>  
>  #endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
> -// 06cec02e676a484857aee38b0071a1d846ec9457
> +// 1568f875fef72097413caab8339120c065a39aa4
> diff --git a/include/linux/atomic/atomic-long.h b/include/linux/atomic/atomic-long.h
> index f6df2adadf997..c82947170ddc8 100644
> --- a/include/linux/atomic/atomic-long.h
> +++ b/include/linux/atomic/atomic-long.h
> @@ -1782,7 +1782,7 @@ raw_atomic_long_dec_unless_positive(atomic_long_t *v)
>   *
>   * Safe to use in noinstr code; prefer atomic_long_dec_if_positive() elsewhere.
>   *
> - * Return: @true if @v was updated, @false otherwise.
> + * Return: The old value of (@v - 1), regardless of whether @v was updated.
>   */
>  static __always_inline long
>  raw_atomic_long_dec_if_positive(atomic_long_t *v)
> @@ -1795,4 +1795,4 @@ raw_atomic_long_dec_if_positive(atomic_long_t *v)
>  }
>  
>  #endif /* _LINUX_ATOMIC_LONG_H */
> -// 029d2e3a493086671e874a4c2e0e42084be42403
> +// 4ef23f98c73cff96d239896175fd26b10b88899e
> diff --git a/scripts/atomic/kerneldoc/dec_if_positive b/scripts/atomic/kerneldoc/dec_if_positive
> index 7c742866fb6b6..04f1aed3cf830 100644
> --- a/scripts/atomic/kerneldoc/dec_if_positive
> +++ b/scripts/atomic/kerneldoc/dec_if_positive
> @@ -7,6 +7,6 @@ cat <<EOF
>   *
>   * ${desc_noinstr}
>   *
> - * Return: @true if @v was updated, @false otherwise.
> + * Return: The old value of (@v - 1), regardless of whether @v was updated.
>   */
>  EOF
> -- 
> 2.30.2
> 
