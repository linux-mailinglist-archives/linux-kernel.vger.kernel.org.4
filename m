Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CC4715744
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjE3HnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjE3HnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:43:01 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFF11BB
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:42:33 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-565ca65e7ffso24822177b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685432468; x=1688024468;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q1cf9BwhoNeWlUyQ+nRhOtzcn4y84LDXQwm01y+BcxQ=;
        b=cWfjTtF3eAelv3C0ENFRpilS3qbt07DvmrCqafiN2BQ5mSGuK+rXqw7q1W9TMU91Cw
         kTx8IdlR/9ogPHQCzgkZonT8uJPC7eG6eaBriPBfuy0Mv/eeP5+CuHlqXBxV2sQZn00V
         +LUtJFuUSIxoND5gpaK7qFjTUlNzIje46EGH6yd5WhLRCdqhuGLI19OiQPEPWC7jKNDc
         Pu/S5kwz3oqUvJx7p23iCmkmL4FBDyZQTbxqVjPgKhwuDXazg8HVKfC8rJ13v12Jxq62
         UUUKsE0B55q04oH5AuOivLr9Xklo5zNRbFaFGvtC0HHVkHHPYCF10uieFRqrzj+XlXLG
         UsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685432468; x=1688024468;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q1cf9BwhoNeWlUyQ+nRhOtzcn4y84LDXQwm01y+BcxQ=;
        b=dIre6KRMxK5WkOAH6SuLItEbI1xrNcXpTcFXyenNOOrz/OK1l4MCMUaxKhgJW4rbi9
         +Lxjq9OXouR0Ay+jpbE++uwyzF6e83Wp22xvcO/9mwK0nAAgaYIBhpzQCWelKDvE6gUn
         wxyM+fwgVo7Pz2Asd9HSYoLj4GztvuZYsBFZzBWUi0qA220aSn+8+llP1uO1lQUT5qnb
         jGAACzuIGyMl9BvBFPP75gT0rcUobVT6cpZ0kMtvQfnw9lN7GZNImHcvHOlin/HPvOJp
         /CuD7HGy8Hxj8Hsb/X3eIKRtNWikl7gFzr7061t8+/Z6wH83Yi/OT7P84lve8PjlTwVd
         E9Dw==
X-Gm-Message-State: AC+VfDxg5DsHbpgJuSptmgKJdYoXKUV3OwY/eMut0597810UGWnAopZD
        YScLexSgxsv2pzSH/K+PIl1/rbYChzTz17blf0kJzQ==
X-Google-Smtp-Source: ACHHUZ603orwKZkVGYfp9uAmXCpHTLV8nAJhcQyIN1J6v3KEBTcBB92yafeVksSEOXAmPqmWMc/rbwWURv0ZWzslyrM=
X-Received: by 2002:a25:b290:0:b0:ba8:2889:3b8a with SMTP id
 k16-20020a25b290000000b00ba828893b8amr1752504ybj.30.1685432468007; Tue, 30
 May 2023 00:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <57834a703dfa5d6c27c9de0a01329059636e5ab7.1685080579.git.christophe.leroy@csgroup.eu>
In-Reply-To: <57834a703dfa5d6c27c9de0a01329059636e5ab7.1685080579.git.christophe.leroy@csgroup.eu>
From:   Marco Elver <elver@google.com>
Date:   Tue, 30 May 2023 09:40:31 +0200
Message-ID: <CANpmjNN1VWdwEVouVfPHZqYYszPNo=TbmXt6na9q+DuOkXY3xA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/kcsan: Properly instrument arch_spin_unlock()
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2023 at 17:50, Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> The following boottime error is encountered with SMP kernel:
>
>   kcsan: improperly instrumented type=(0): arch_spin_unlock(&arch_spinlock)
>   kcsan: improperly instrumented type=(0): spin_unlock(&test_spinlock)
>   kcsan: improperly instrumented type=(KCSAN_ACCESS_WRITE): arch_spin_unlock(&arch_spinlock)
>   kcsan: improperly instrumented type=(KCSAN_ACCESS_WRITE): spin_unlock(&test_spinlock)
>   kcsan: improperly instrumented type=(KCSAN_ACCESS_WRITE | KCSAN_ACCESS_COMPOUND): arch_spin_unlock(&arch_spinlock)
>   kcsan: improperly instrumented type=(KCSAN_ACCESS_WRITE | KCSAN_ACCESS_COMPOUND): spin_unlock(&test_spinlock)
>   kcsan: selftest: test_barrier failed
>   kcsan: selftest: 2/3 tests passed
>   Kernel panic - not syncing: selftests failed
>
> Properly instrument arch_spin_unlock() with kcsan_mb().
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Acked-by: Marco Elver <elver@google.com>

> ---
>  arch/powerpc/include/asm/simple_spinlock.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/simple_spinlock.h b/arch/powerpc/include/asm/simple_spinlock.h
> index 9dcc7e9993b9..4dd12dcb9ef8 100644
> --- a/arch/powerpc/include/asm/simple_spinlock.h
> +++ b/arch/powerpc/include/asm/simple_spinlock.h
> @@ -15,6 +15,7 @@
>   * (the type definitions are in asm/simple_spinlock_types.h)
>   */
>  #include <linux/irqflags.h>
> +#include <linux/kcsan-checks.h>
>  #include <asm/paravirt.h>
>  #include <asm/paca.h>
>  #include <asm/synch.h>
> @@ -126,6 +127,7 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
>
>  static inline void arch_spin_unlock(arch_spinlock_t *lock)
>  {
> +       kcsan_mb();
>         __asm__ __volatile__("# arch_spin_unlock\n\t"
>                                 PPC_RELEASE_BARRIER: : :"memory");
>         lock->slock = 0;
> --
> 2.40.1
>
