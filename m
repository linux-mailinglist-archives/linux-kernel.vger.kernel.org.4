Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD0960D1AA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 18:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiJYQd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 12:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiJYQdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 12:33:55 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37F4190461
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:33:54 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id 4so5519861pli.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w+K+VkJ5rF2bPWIuGGL1An2TDI1B6FPu0okQWTiFSFU=;
        b=dsyZlivveNQVAe1j5QfNUOZIGk20O2luReGls++tVaAj8fZ5uh1yeCb1fIOBCD8wJE
         xxhON/33ij5fIaKtr7QjqMbHMoNanvSy5gkaHzohavLSfYEpkvhGNdeZbX443uQK52az
         YSpS6/WAqPpz+U6P6DyNIBwdQ50imLhOzvwfPrWg4GxFzpq2gOgM2KOCm2bdt98MjkOu
         VQgN/xLhoPQsn98hAcdPgEdxFkSQ9DGlf0LfOrd1+lJVMD+xTibiVE+XY98uYKruH5T1
         KCSGVQ6aQa95VV8liCtXh9KVFSGc7zzF19BG1+qOhBORHzN+Y8ImHiq5VT1aXHk6C8BZ
         9pkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+K+VkJ5rF2bPWIuGGL1An2TDI1B6FPu0okQWTiFSFU=;
        b=G40RpunNxcphupXk62JMK+SCzUR97h2TvuyfIlVhae+BEewP7iWAPvI894PPv63pce
         WgDFYPSTkfgqSsF0eyqPTcyd0QpUVvDjQX3t3Nb6lDkOjK/XsL37slTeMBjR89vSHu6U
         3XHawDgsJoB+odLQYE5m7I8/rWJaxN3fZevXVE1/TLWQVwbUreWHwHn37fak6pcKag4k
         1deLJtYdhmpLztsbsoeIA/l/SvSQ09UYpMDPFuoVpUvY3g9pQT1lz/WhK2MGf1wUPvFR
         IfLIPJ3cwtstayeZgXGI6UhAzWjGAFrNh8DoWY/cWHl/FuzoXxazUy5OooZULgEMudYW
         0Oyw==
X-Gm-Message-State: ACrzQf3r/7XtLHp9GYY8sPS4ZyyXSPyJh6DzgbITMkGPNUvcIkqCY3sU
        rCew/Iy6THGZfwwCorx6gbbsfrW4EwrWTsmHAmnGqg==
X-Google-Smtp-Source: AMsMyM5PvDezoPVvWMiVxEXgTMcGPdWgPtRwNZzEj9dBODXIhNtJpUQjkPAVZ7oEegqxDc4BrgbyXQZr74AAcZKWbNk=
X-Received: by 2002:a17:90a:c24a:b0:213:13aa:3e2a with SMTP id
 d10-20020a17090ac24a00b0021313aa3e2amr12267189pjx.107.1666715633777; Tue, 25
 Oct 2022 09:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvGe+fHXw8RMeZuXB-rGVDjs81m9_RwDq73R+pnVpYjEw@mail.gmail.com>
In-Reply-To: <CA+G9fYvGe+fHXw8RMeZuXB-rGVDjs81m9_RwDq73R+pnVpYjEw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 25 Oct 2022 09:33:42 -0700
Message-ID: <CAKwvOd=kPA=FV9UQXLe1eyRwqDOYrRkB+_d+E+JdY4BpRUUaRA@mail.gmail.com>
Subject: Re: Clang Build warning detected - include/linux/memremap.h:258:9:
 error: expression which evaluates to zero treated as a null pointer constant
 of type 'struct folio *' [-Werror,-Wnon-literal-null-conversion]
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 9:19 PM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> Following build warning / errors noticed while building x86_64 with clang
> on Linux next-20221025 tag.
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Hi Naresh,
Thanks for the report. It looks like AKPM is already aware.
https://lore.kernel.org/llvm/20221022163356.f5e08eeefe66fc71845be861@linux-foundation.org/

Naresh, for future reports, can you use our newer mailing list
<llvm@lists.linux.dev> rather than our older one
(<clang-built-linux@googlegroups.com>).  I haven't actually closed the
old one, but the new one is syndicated on lore.
https://lore.kernel.org/llvm/

>
> ## Build
> * kernel: 6.1.0-rc1
> * git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
> * git branch: master
> * git commit: 76cf65d1377f733af1e2a55233e3353ffa577f54
> * git describe: next-20221024
> * test details:
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221024
>
> ## Test Regressions (compared to next-20221021)
> * i386, build
>   - clang-12-lkftconfig
>   - clang-13-lkftconfig
>   - clang-14-lkftconfig
>   - clang-nightly-lkftconfig
>
> * x86_64, build
>   - clang-12-lkftconfig
>   - clang-13-lkftconfig
>   - clang-14-lkftconfig
>   - clang-nightly-lkftconfig
>
>
> make --silent --keep-going --jobs=8
> O=/home/tuxbuild/.cache/tuxmake/builds/1/build LLVM=1 LLVM_IAS=1
> ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu- HOSTCC=clang CC=clang
> In file included from arch/x86/kernel/asm-offsets.c:13:
> In file included from include/linux/suspend.h:5:
> In file included from include/linux/swap.h:9:
> In file included from include/linux/memcontrol.h:20:
> In file included from include/linux/mm.h:31:
> include/linux/memremap.h:258:9: error: expression which evaluates to
> zero treated as a null pointer constant of type 'struct folio *'
> [-Werror,-Wnon-literal-null-conversion]
>         return false;
>                ^~~~~
> 1 error generated.
> make[2]: *** [scripts/Makefile.build:118: arch/x86/kernel/asm-offsets.s] Error 1
>
>
> --
> Linaro LKFT
> https://lkft.linaro.org
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/CA%2BG9fYvGe%2BfHXw8RMeZuXB-rGVDjs81m9_RwDq73R%2BpnVpYjEw%40mail.gmail.com.



-- 
Thanks,
~Nick Desaulniers
