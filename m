Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25B06635FF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 01:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237397AbjAJADF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 19:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237789AbjAJADC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 19:03:02 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8831DF18
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 16:03:01 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id w3so11400220ply.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 16:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j8xKmx/6dFVmm2efFsDSsl9YQyAJHEnSGQ2/e2NGlbw=;
        b=DkbmJFj9U2D2y8oYBC4N5/IBVDLBcLwjTVMrYSBWmD5dzn6FU7B4cK/V8k4Y4G1I7F
         UnijwFmcdv47bR79JuO5ugHbnNuuZkgQ9n9Cl7DUTJTNSxq7VUmm1CAT5LViY20XrIz3
         YWtE+5qKWQFKoIHXNm8CKICk5QQMvsxoJQDgX9s333sC7ym5GyI8Ek1x3miAvP7Q7+8E
         Aj3WakOz0ksfG17g+di82TP69xYDpWh+r6mUF9PP/aYejp/G60GkJvqPTv6RKg5eFYX8
         /0VKfVL5dsvY1RHyztck/Ct3d9eqKJfr0ZuBGuACyOtjldpLLRFv/dHCQN4KpQG3RV12
         p7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j8xKmx/6dFVmm2efFsDSsl9YQyAJHEnSGQ2/e2NGlbw=;
        b=Mc7coHfclRi4F2TzF1h7nYWIVyI1vJqG+RnaHfZejfkzloJmyKikH8+th6DmBvFDKH
         beHlDz2CF/LLih8ljpObuLehbEWK+y81XiKr29Fmws94e61AoMqN2IcJOAO37Z30BrQj
         729nzmvIAxwEzxnTsl/CtwfntJVpq9PYjzYdYSIero7vNlqcQjJ2J8TJl5hAq2v1+G6j
         yWscjTp/zub0Kc4ZEYrtGO0Awnzg5tqxqKqvwsluwfRQNCG4aFAtKRXmsZUDxfD8xa84
         +A71vUzJqfDf0Rt1NUDEnnWIL1mxwr0uWS3DkSfz5loXO/jFmPduginYjXXnluTIm2bF
         Vodw==
X-Gm-Message-State: AFqh2koz7zK648JivzsFfm/w1/tNf9C6Giirvcjt0QQMoTwIAnUIRRrh
        B6otFNbK7eUrFF/DuhwLj9ICDtLk/+GBnvYp4Ewucg==
X-Google-Smtp-Source: AMrXdXtjmBcgdv8YybRfNjAPG3T9XcOotaMhL9vqmkJ4YtqytQW7gQEGDz3m1wjCErdeiDno1GuPOPszf1xcTBopexM=
X-Received: by 2002:a17:902:c94d:b0:191:24d1:3b31 with SMTP id
 i13-20020a170902c94d00b0019124d13b31mr2872837pla.94.1673308980354; Mon, 09
 Jan 2023 16:03:00 -0800 (PST)
MIME-Version: 1.0
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1> <20230105003813.1770367-22-paulmck@kernel.org>
In-Reply-To: <20230105003813.1770367-22-paulmck@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 9 Jan 2023 16:02:48 -0800
Message-ID: <CAKwvOdmt7mnP_dfCMO_YUV792Zgtirk=NFqe8XH0z88-b0e23A@mail.gmail.com>
Subject: Re: [PATCH rcu 22/27] init: Remove "select SRCU"
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>, Tejun Heo <tj@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 4, 2023 at 4:38 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Now that the SRCU Kconfig option is unconditionally selected, there is
> no longer any point in selecting it.  Therefore, remove the "select SRCU"
> Kconfig statements.

Looks like that's the case as of
commit 0cd7e350abc4 ("rcu: Make SRCU mandatory")
in v6.2-rc1.

>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Aaron Tomlin <atomlin@redhat.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>

Patch LGTM
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Note that there's quite a few more of these though. Perhaps best to
remove them all together? Or perhaps you already have individual
patches out already for all of these?

$ grep -rn 'select SRCU'
mm/Kconfig:670: select SRCU
kernel/power/Kconfig:121: select SRCU
arch/mips/kvm/Kconfig:29: select SRCU
arch/riscv/kvm/Kconfig:30: select SRCU
arch/s390/kvm/Kconfig:34: select SRCU
arch/powerpc/kvm/Kconfig:25: select SRCU
arch/x86/kvm/Kconfig:49: select SRCU
arch/x86/Kconfig:286: select SRCU
arch/x86/Kconfig:1941: select SRCU
arch/arm64/kvm/Kconfig:31: select SRCU
init/Kconfig:1868: select SRCU
security/tomoyo/Kconfig:9: select SRCU
fs/btrfs/Kconfig:20: select SRCU
fs/dlm/Kconfig:7: select SRCU
fs/quota/Kconfig:9: select SRCU
fs/notify/Kconfig:4: select SRCU
drivers/md/Kconfig:9: select SRCU
drivers/clk/Kconfig:26: select SRCU
drivers/dax/Kconfig:4: select SRCU
drivers/devfreq/Kconfig:4: select SRCU
drivers/net/Kconfig:337: select SRCU
drivers/hwtracing/stm/Kconfig:5: select SRCU
drivers/cpufreq/Kconfig:6: select SRCU
drivers/opp/Kconfig:4: select SRCU

> ---
>  init/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 7e5c3ddc341de..af511c726d695 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1865,7 +1865,6 @@ config PERF_EVENTS
>         default y if PROFILING
>         depends on HAVE_PERF_EVENTS
>         select IRQ_WORK
> -       select SRCU
>         help
>           Enable kernel support for various performance events provided
>           by software and hardware.
> --
> 2.31.1.189.g2e36527f23
>


-- 
Thanks,
~Nick Desaulniers
