Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3018772AB5A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 14:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbjFJMGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 08:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjFJMGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 08:06:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC8EF0;
        Sat, 10 Jun 2023 05:06:44 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686398803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f9vpJCOBmn1kjBZo6jMweDpG7dJUYQBav9b62qbm/4U=;
        b=b+1BCKEBeAMrQlSxMKQfFZZ8rZxMHwUzK5Dnj4B9/V4H9acAcmPx4vpgfHColQQm1077GK
        BsAQkoRDSSFgXCtyaP66+T4xwPXXJzoj5WpKf1iXz6CeVq7HzSMeyW82gNLqdXvLAxWNUj
        Q2u/SffraBTFhhadv20Lvi5dqSXZni8TA6AaJgEOWpduper39lGfS5Pvxbu9rdxq3zjfqp
        zst92Z7AUYF90RHm2SOgz+5myX8pnzXzgYk3cIPCBNKKxnQ4cQgZgRTZnw9eVQE88puyMJ
        jYaDZ0BNyMnAFmkYF/VWGGFZ8OLm/hRSoodgh0a5mCJyfnFYd35W8ucSQwLlyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686398803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f9vpJCOBmn1kjBZo6jMweDpG7dJUYQBav9b62qbm/4U=;
        b=8HR2GDgbKRZeHABXfPCtTuVbEXOHvgSTaMrXwWG/wJ4VTy69ODr85gl+ovj2r02i4QwaLm
        vwYr071+yYSgvqAQ==
To:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Borislav Petkov <bp@suse.de>, Jann Horn <jannh@google.com>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH] syscalls: add sys_ni_posix_timers prototype
In-Reply-To: <20230607142925.3126422-1-arnd@kernel.org>
References: <20230607142925.3126422-1-arnd@kernel.org>
Date:   Sat, 10 Jun 2023 14:06:42 +0200
Message-ID: <874jnfa5d9.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07 2023 at 16:28, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The sys_ni_posix_timers() definition causes a warning when
> the declaration is missing, so this needs to be added
> along with the normal syscalls, outside of the #ifdef.
>
> kernel/time/posix-stubs.c:26:17: error: no previous prototype for 'sys_ni_posix_timers' [-Werror=missing-prototypes]
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I missed sending this out in the initial submission of my Wmissing-prototype patches
> ---
>  arch/alpha/kernel/osf_sys.c | 2 --
>  include/linux/syscalls.h    | 1 +
>  kernel/time/posix-stubs.c   | 1 +
>  3 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
> index 2a9a877a05083..d98701ee36c6a 100644
> --- a/arch/alpha/kernel/osf_sys.c
> +++ b/arch/alpha/kernel/osf_sys.c
> @@ -1014,8 +1014,6 @@ SYSCALL_DEFINE2(osf_settimeofday, struct timeval32 __user *, tv,
>  	return do_sys_settimeofday64(tv ? &kts : NULL, tz ? &ktz : NULL);
>  }
>  
> -asmlinkage long sys_ni_posix_timers(void);
> -
>  SYSCALL_DEFINE2(osf_utimes, const char __user *, filename,
>  		struct timeval32 __user *, tvs)
>  {
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 4627b9cf4b4d9..712f4e1dc6a69 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -1286,6 +1286,7 @@ asmlinkage long sys_ni_syscall(void);
>  
>  #endif /* CONFIG_ARCH_HAS_SYSCALL_WRAPPER */
>  
> +asmlinkage long sys_ni_posix_timers(void);
>  
>  /*
>   * Kernel code should not call syscalls (i.e., sys_xyzyyz()) directly.
> diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
> index 828aeecbd1e8a..39769b2d1005e 100644
> --- a/kernel/time/posix-stubs.c
> +++ b/kernel/time/posix-stubs.c
> @@ -16,6 +16,7 @@
>  #include <linux/posix-timers.h>
>  #include <linux/time_namespace.h>
>  #include <linux/compat.h>
> +#include <linux/syscalls.h>

That's already included. I'll fix it up while applying.
