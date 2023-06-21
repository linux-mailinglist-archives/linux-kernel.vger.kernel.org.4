Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC23739146
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 23:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjFUVHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 17:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjFUVH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 17:07:27 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0F51988
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:07:25 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b4790ff688so58938191fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687381644; x=1689973644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7RHhO8mVnpgh8ODJ94LK5sLSRpLLBu7IaMuXHBaJqM=;
        b=oMDwhcZ8ZGSlcM2I39/I4R5qMkYyTMTGiOFUbnvyBWsrsEIbFlMp0hzPnQqNr2wqGF
         hjSNs/QY8Ep5oNtZFRF2RX0bmYChUg4BbJiSQ3e4o4UAEJHCDwyaZuxCF3ieiPioVZLn
         QdwmdbakA38YGrhVNC+B350zs6fNxA8TiSXeRv2QKkF8f0AHdHwm7LVvwrCbXCni71yC
         y6m6PNzQvWR7+Th8x7vbDfzHelDyK0WP2/zaTSlk+cD3dk5JARe3JEGRL57tGO0KtWR9
         SotarOck7deRjGRMdFeDLQ7GDdPdroJDHCeUQr+J8nyLjNMhuForPvGQ4WwcyH3DITcH
         9+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687381644; x=1689973644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7RHhO8mVnpgh8ODJ94LK5sLSRpLLBu7IaMuXHBaJqM=;
        b=E6UyPCxDOPp/qU513KVU9Hjdn67OoWm+yz6HOd0U/VpjKWyCgN+CS+DwimUuFgtw/J
         TwvlzoHOqwddc2ZyIFXv0uyTg8zuHS5/Lf7CoQQUv0TkeZy7TQ52b2r0o95OY1ZDx2kn
         xd5OfcuutQ0/utxWjNuxIEDE7ZVyvD/pQNyAB+ffDLDeB8jUcdcT0LHwDmvC9cPdIKXT
         zT6sm+cFvMdGl9k9frjZob1C2Nfo/Ds3y8P4SDRRBfdKXBETNzxaviSQ9N+iCiiCEvUA
         5BitYW2jIFuYUKpaxf0RfL4tjVwcBKFqtCo2z7cHDV2NneT4CsLqIIzl3UlZXnbVD667
         pgZA==
X-Gm-Message-State: AC+VfDzV2JeWBqIzy217rpDg+7hDWgoBzAv79KBnAWp0RhMiJhCrQivg
        tJdnq7ZOo799OgAm67NjSvs7KCTLbiDJThEhfQ==
X-Google-Smtp-Source: ACHHUZ4kWe1ytiro9pZcB8j7bXK9dfkxCFGP6cRoZ6O60k8eOri7mgD26ZGO9z7VcIUoP/z8zW80TiGHaF0hRgAIpIM=
X-Received: by 2002:a05:6512:3292:b0:4f8:5bbf:d195 with SMTP id
 p18-20020a056512329200b004f85bbfd195mr8628199lfe.20.1687381643766; Wed, 21
 Jun 2023 14:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230615193546.949657149@infradead.org> <20230615193722.127844423@infradead.org>
In-Reply-To: <20230615193722.127844423@infradead.org>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Wed, 21 Jun 2023 17:07:11 -0400
Message-ID: <CAMzpN2j2Okm1BPrQcrd7=Duo286RqZ-AKvy=NoJOBQ0sLJLhAw@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/cfi: Fix ret_from_fork indirect calls
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, alyssa.milburn@linux.intel.com,
        linux-kernel@vger.kernel.org, samitolvanen@google.com,
        keescook@chromium.org, jpoimboe@kernel.org,
        joao@overdrivepizza.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 3:56=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> The ret_from_fork stub does an indirect call to the kthread function,
> but only knows about Retpolines. Instead of making the asm more
> complicated, punt to C and let the compiler figure it out.
>
> Specifically, this makes it a proper kCFI indirect call when needed (in
> fact, it is nearly impossible to code a kCFI indirect call in asm).
>
> This was the only callsite that was still calling func()+0 on regular
> indirect functions.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/entry/entry_64.S        |    6 ++++--
>  arch/x86/include/asm/switch_to.h |    2 ++
>  arch/x86/kernel/process_64.c     |    5 +++++
>  3 files changed, 11 insertions(+), 2 deletions(-)
>
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -304,8 +304,10 @@ SYM_CODE_START_NOALIGN(ret_from_fork)
>  1:
>         /* kernel thread */
>         UNWIND_HINT_END_OF_STACK
> -       movq    %r12, %rdi
> -       CALL_NOSPEC rbx
> +       movq    %rbx, %rdi
> +       movq    %r12, %rsi
> +       call    kthread_from_fork
> +
>         /*
>          * A kernel thread is allowed to return here after successfully
>          * calling kernel_execve().  Exit to userspace to complete the ex=
ecve()
> --- a/arch/x86/include/asm/switch_to.h
> +++ b/arch/x86/include/asm/switch_to.h
> @@ -74,6 +74,8 @@ static inline void update_task_stack(str
>  #endif
>  }
>
> +extern void kthread_from_fork(int (*fn)(void *), void *);
> +
>  static inline void kthread_frame_init(struct inactive_task_frame *frame,
>                                       int (*fun)(void *), void *arg)
>  {
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -544,6 +544,11 @@ void compat_start_thread(struct pt_regs
>  }
>  #endif
>
> +__visible noinstr void kthread_from_fork(int (*fn)(void *), void *arg)
> +{
> +       fn(arg);
> +}
> +
>  /*
>   *     switch_to(x,y) should switch tasks from x to y.
>   *

I think this makes a case for converting all of ret_from_fork() to C
(other than some minimal asm glue).  Patches coming soon.

Brian Gerst
