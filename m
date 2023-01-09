Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C5B661F0D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 08:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjAIHO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 02:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbjAIHOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 02:14:22 -0500
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CE61209F
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 23:14:19 -0800 (PST)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-4b6255ce5baso101683367b3.11
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 23:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3P4KpMYHjMcRtTeC0AGN2bMbTWe/Y4tWuNNHyqRwN1E=;
        b=V3hc4ur2h4YdudQTRZKZttR04YLioc5r5aUVh6R+g28fMuw/uplM7DDGwhHVPCeBxL
         YbdfYJSnaFkRqUOKJBl8L0ygw5QTfvHxTRAjWkMn9CdLAf4fN1/l9yyHaF+cfeQYCMTh
         ikLS+0HGPp3eLPFHtrc0lQGdDm62uGICct44I3vVxbegEPvCZT/ruBvHcSWmDOT5X+4l
         QK/RCxuNKTNR9Iq1sH1iENfmz5uJpcZkuZSbUFTLyXa4EUXzyTRZ+dN/KJUzmpXtwF6M
         g7/9uNiXfTEEVqyuUr6bB9zdHCHUs+bUcQ0d5KQQ/Mvoyft/fYItsDI85VBfKafjM49c
         UDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3P4KpMYHjMcRtTeC0AGN2bMbTWe/Y4tWuNNHyqRwN1E=;
        b=2AhhNk4GeK3zCVa7xKgrHVHwac/DKHBLlXXFgIPolT9ZfKysIKvD8Jt5N5Xb7gT0Iw
         B5bxwL8Suq9rTaEz4KJruSbgnUnPLrMYEaaWEYn4i+4UEa/8AvLDsMwU54GdEU5NrtkD
         D4hgn7s7rjGfLft+WVRybr2Nv3FzSlQI/GVJOg87yOplD/CqLBHp3+KfVSbo8+POqtvc
         K5YJ9T00v3fy01ns8XCKBB3Dk1AfickcBlguFOvVAEnIoyzevtaqbjCzKnRVSeCLW3ch
         TF83sWP0drpD8bigfX1K/hrxCVTI3zwi1Dgs+Stz2THYGHkPCOphMpl+tcONriaXJb0M
         y7/w==
X-Gm-Message-State: AFqh2kol3Qd5jkJgStm3FwmaG8lnK2SuY2nRubRJiO431JtbJtpg/8it
        7ZBtJgWZkQApz5voPsXRgVumPXDwqfWLgKUEpqA=
X-Google-Smtp-Source: AMrXdXv9N2vVXMRaifK/p1uDqFHsnj5NTh/v836yUSUymb573TTsgjXtKjNPZ9wKAx5F3enzeE9vWoLbZcKzC+RB5i0=
X-Received: by 2002:a81:c30e:0:b0:4b2:72:d8ee with SMTP id r14-20020a81c30e000000b004b20072d8eemr2946003ywk.272.1673248459052;
 Sun, 08 Jan 2023 23:14:19 -0800 (PST)
MIME-Version: 1.0
References: <20221110082443.4069161-1-zhanggenjian@kylinos.cn> <20230106145331.GS4028633@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230106145331.GS4028633@paulmck-ThinkPad-P17-Gen-1>
From:   genjian zhang <zhanggenjian123@gmail.com>
Date:   Mon, 9 Jan 2023 15:13:06 +0800
Message-ID: <CAOd03ySSrC996R_=xxC4M7s=X-V-jC1D-5rTsixWorg_qQmTLA@mail.gmail.com>
Subject: Re: [PATCH] context_tracking: Use arch_atomic_*() in __ct_user_enter
 and __ct_user_exit
To:     paulmck@kernel.org
Cc:     frederic@kernel.org, linux-kernel@vger.kernel.org,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 6, 2023 at 10:53 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Thu, Nov 10, 2022 at 04:24:43PM +0800, Genjian wrote:
> > From: Genjian Zhang <zhanggenjian@kylinos.cn>
> >
> > vmlinux.o: warning: objtool: __ct_user_enter+0x45: call to
> > __kasan_check_write() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: __ct_user_exit+0x3f: call to
> > __kasan_check_write() leaves .noinstr.text section
> >
> > noinstr cannot have atomic_*() functions.because they have explicit
> > instrumentation.Switch to arch_ prefixed atomic operation functions to
> > avoid the explicit instrumentation.
> >
> > Reported-by: k2ci <kernel-bot@kylinos.cn>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
>
> Apologies for the delay, but finally queued, thank you!  Frederic gave
> his ack off-list, which I have included in the wordsmithed version below.
> Could you please check to make sure that I did not mess anything up?
>
>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit 936acd859f4a7b2b0f9900e26bc972385286df6e
> Author: Genjian Zhang <zhanggenjian@kylinos.cn>
> Date:   Thu Nov 10 16:24:43 2022 +0800
>
>     context_tracking: Use arch_atomic_*() in __ct_user_enter and __ct_user_exit
>
>     The following diagnostics are issued by objtool:
>
>     vmlinux.o: warning: objtool: __ct_user_enter+0x45: call to
>     __kasan_check_write() leaves .noinstr.text section
>     vmlinux.o: warning: objtool: __ct_user_exit+0x3f: call to
>     __kasan_check_write() leaves .noinstr.text section
>
>     The reason for these diagnostics is that code marked noinstr if prohibited
>     from using atomic_*() functions, which have explicit instrumentation.
>     Therefore, switch to arch_ prefixed atomic operation functions to avoid
>     the explicit instrumentation.
>
>     Reported-by: k2ci <kernel-bot@kylinos.cn>
>     Reported-by: kernel test robot <lkp@intel.com>
>     Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
>     Acked-by: Frederic Weisbecker <frederic@kernel.org>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
> diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
> index 77978e3723771..a09f1c19336ae 100644
> --- a/kernel/context_tracking.c
> +++ b/kernel/context_tracking.c
> @@ -510,7 +510,7 @@ void noinstr __ct_user_enter(enum ctx_state state)
>                          * In this we case we don't care about any concurrency/ordering.
>                          */
>                         if (!IS_ENABLED(CONFIG_CONTEXT_TRACKING_IDLE))
> -                               atomic_set(&ct->state, state);
> +                               arch_atomic_set(&ct->state, state);
>                 } else {
>                         /*
>                          * Even if context tracking is disabled on this CPU, because it's outside
> @@ -527,7 +527,7 @@ void noinstr __ct_user_enter(enum ctx_state state)
>                          */
>                         if (!IS_ENABLED(CONFIG_CONTEXT_TRACKING_IDLE)) {
>                                 /* Tracking for vtime only, no concurrent RCU EQS accounting */
> -                               atomic_set(&ct->state, state);
> +                               arch_atomic_set(&ct->state, state);
>                         } else {
>                                 /*
>                                  * Tracking for vtime and RCU EQS. Make sure we don't race
> @@ -535,7 +535,7 @@ void noinstr __ct_user_enter(enum ctx_state state)
>                                  * RCU only requires RCU_DYNTICKS_IDX increments to be fully
>                                  * ordered.
>                                  */
> -                               atomic_add(state, &ct->state);
> +                               arch_atomic_add(state, &ct->state);
>                         }
>                 }
>         }
> @@ -630,12 +630,12 @@ void noinstr __ct_user_exit(enum ctx_state state)
>                          * In this we case we don't care about any concurrency/ordering.
>                          */
>                         if (!IS_ENABLED(CONFIG_CONTEXT_TRACKING_IDLE))
> -                               atomic_set(&ct->state, CONTEXT_KERNEL);
> +                               arch_atomic_set(&ct->state, CONTEXT_KERNEL);
>
>                 } else {
>                         if (!IS_ENABLED(CONFIG_CONTEXT_TRACKING_IDLE)) {
>                                 /* Tracking for vtime only, no concurrent RCU EQS accounting */
> -                               atomic_set(&ct->state, CONTEXT_KERNEL);
> +                               arch_atomic_set(&ct->state, CONTEXT_KERNEL);
>                         } else {
>                                 /*
>                                  * Tracking for vtime and RCU EQS. Make sure we don't race
> @@ -643,7 +643,7 @@ void noinstr __ct_user_exit(enum ctx_state state)
>                                  * RCU only requires RCU_DYNTICKS_IDX increments to be fully
>                                  * ordered.
>                                  */
> -                               atomic_sub(state, &ct->state);
> +                               arch_atomic_sub(state, &ct->state);
>                         }
>                 }
>         }

Seems good to me.

Thanks,

Genjian.
