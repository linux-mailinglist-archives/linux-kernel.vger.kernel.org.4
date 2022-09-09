Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8987A5B4122
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 22:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiIIU5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 16:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiIIU5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 16:57:34 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D2DC59F4;
        Fri,  9 Sep 2022 13:57:32 -0700 (PDT)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 289KvJw1004258;
        Sat, 10 Sep 2022 05:57:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 289KvJw1004258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662757040;
        bh=uqz24ZSjysiHUZlmL5XaHf2ZhL6SzB9+49wyUsEx67Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BweEZeCLjEO3xjp9rjSb1j7Wn1RQaEjuczoyUfGU+LW3RPcEBOZuRacHEHeKVLIOD
         cYdZKvbxAohqLXWOsu/wacwUJSG9Rc/c7YI+AH+AcfX22brU/5zSUEhHJIV4xEy/cZ
         nr9ZYZn8NmAvVO+kognjgfxz1Q6lt7e+5S89SnKH+SRKW8yVjrYNzzoWeNcWkT0w7H
         uJikYJCj1f0hnpnn5kBf7Q1K31fSuIocfIHii/OsyyXvShUxypquucrB4g3xQ3iT1w
         Nx6JZtaDyRc5iFxSbM3ZQy7nGSlUNZuJkdlgnsk2phBqgU4MAL+MLjiCicU0KkkQzL
         6oTmxQszYInjg==
X-Nifty-SrcIP: [209.85.160.43]
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1225219ee46so7102128fac.2;
        Fri, 09 Sep 2022 13:57:20 -0700 (PDT)
X-Gm-Message-State: ACgBeo2l0VDFaL8bguvvkevRCJuo4L1YuLTs0MNVC/DT4yhxaMoWY2HJ
        U0nhpvbU3VUX8DnoW7bl8rYO056Q5c/zKWpZyvU=
X-Google-Smtp-Source: AA6agR66+XO9Ke2tjFAZRiZGfx7pHOR7RKRdiA3vlsCmufJS6NDQDpZTXaoqbZ/Ykghz+SYA4kk37sT798vD5adC45g=
X-Received: by 2002:a05:6870:f626:b0:10d:a798:f3aa with SMTP id
 ek38-20020a056870f62600b0010da798f3aamr5953724oab.194.1662757038871; Fri, 09
 Sep 2022 13:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220907045907.484043-1-ndesaulniers@google.com> <20220907045907.484043-6-ndesaulniers@google.com>
In-Reply-To: <20220907045907.484043-6-ndesaulniers@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 10 Sep 2022 05:56:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNARhKobLF4Lw0dqSMqW0SPwmrV9HRas=4L8NoahKTeMCgQ@mail.gmail.com>
Message-ID: <CAK7LNARhKobLF4Lw0dqSMqW0SPwmrV9HRas=4L8NoahKTeMCgQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] Makefile.debug: set -g unconditional on CONFIG_DEBUG_INFO_SPLIT
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        X86 ML <x86@kernel.org>,
        Dmitrii Bundin <dmitrii.bundin.a@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Alexey Alexandrov <aalexand@google.com>,
        Bill Wendling <morbo@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 7, 2022 at 1:59 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> Dmitrii, Fangrui, and Mashahiro note:
>
>   Before GCC 11 and Clang 12 -gsplit-dwarf implicitly uses -g2.
>
> Fix CONFIG_DEBUG_INFO_SPLIT for gcc-11+ & clang-12+ which now need -g
> specified in order for -gsplit-dwarf to work at all.
>
> -gsplit-dwarf has been mutually exclusive with -g since support for
> CONFIG_DEBUG_INFO_SPLIT was introduced in
> commit 866ced950bcd ("kbuild: Support split debug info v4")
> I don't think it ever needed to be.
>
> Link: https://lore.kernel.org/lkml/20220815013317.26121-1-dmitrii.bundin.a@gmail.com/
> Link: https://lore.kernel.org/lkml/CAK7LNARPAmsJD5XKAw7m_X2g7Fi-CAAsWDQiP7+ANBjkg7R7ng@mail.gmail.com/
> Link: https://reviews.llvm.org/D80391
> Cc: Andi Kleen <ak@linux.intel.com>
> Reported-by: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
> Reported-by: Fangrui Song <maskray@google.com>
> Reported-by: Masahiro Yamada <masahiroy@kernel.org>
> Suggested-by: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Changes v2 -> v3:
> * Pick up Nathan's RB tag.
>
> Changes v1 -> v2:
> * Add reference to 866ced950bcd, cc Andi, in commit message.
>
>  scripts/Makefile.debug | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/scripts/Makefile.debug b/scripts/Makefile.debug
> index 2845145c1220..c20f8f2e76bf 100644
> --- a/scripts/Makefile.debug
> +++ b/scripts/Makefile.debug
> @@ -1,10 +1,4 @@
> -DEBUG_CFLAGS   :=
> -
> -ifdef CONFIG_DEBUG_INFO_SPLIT
> -DEBUG_CFLAGS   += -gsplit-dwarf
> -else
> -debug-cflags-y += -g
> -endif
> +DEBUG_CFLAGS   := -g
>
>  debug-flags-$(CONFIG_DEBUG_INFO_DWARF4)        += -gdwarf-4
>  debug-flags-$(CONFIG_DEBUG_INFO_DWARF5)        += -gdwarf-5
> @@ -15,6 +9,8 @@ ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_AS_IS_GNU),yy)
>  KBUILD_AFLAGS  += $(addprefix -Wa$(comma), $(debug-flags-y))
>  endif
>
> +debug-flags-$(CONFIG_DEBUG_INFO_SPLIT) += -gsplit-dwarf
> +


This patch changes the behavior that is not mentioned in the commit log.




Previously, -gsplit-dwarf was passed only when compiling *.c files.
(DEBUG_CFLAGS).

Now it is passed also when compiling *.S files.
(debug-flags-y is appended to KBUILD_AFLAGS)


Please confirm if this makes sense, and if so,
please mention it in the commit log.



As far as I tested, I did not see this change was useful.

When *.S is compiled to *.o, *.dwo is also created,
but it does not contain any debug info.



>  ifdef CONFIG_DEBUG_INFO_REDUCED
>  DEBUG_CFLAGS   += -fno-var-tracking
>  ifdef CONFIG_CC_IS_GCC
> --
> 2.37.2.789.g6183377224-goog
>


-- 
Best Regards
Masahiro Yamada
