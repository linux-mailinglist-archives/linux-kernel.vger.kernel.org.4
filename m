Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701575B4147
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 23:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiIIVII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 17:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiIIVHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 17:07:31 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3FD14997A;
        Fri,  9 Sep 2022 14:07:01 -0700 (PDT)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 289L6lgP011950;
        Sat, 10 Sep 2022 06:06:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 289L6lgP011950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662757608;
        bh=DvVjZAUBnzPdzYN9rjZzo+TIJCdrmJ3YhUlFxpG7vGI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U2JFcjwV5YL62vzETSjjXzSL7xXv1l5nwQZMpsL2CZa1RDg153qvR+MXB9kqQDjZn
         MsCL02yPUkz1RpHa2BcJXrUcxjewxbD0Lc+WvONW7qedyceWc2I0COSCZLMzM+adlv
         L22PYEv+MW5IP09VA2iJiiiEhQ3LKR6zOKvaGfoJJy8+ONcS3ab/1hXI4/6UhlLX9V
         p/Mc9umZWIQuIaVWd5kFsNQ5Z3p4/QgxZ3GEUDQksroWZEztTS+zeq7+P8GQUdr5Y5
         bRK46ub9Zsh3c1AhrlzKW9LC/nOnqEqsbRIEa8HhfJk8Cw7Fa7CjpjOCvpDcqF9fzr
         /hS913z6AiMvg==
X-Nifty-SrcIP: [209.85.160.49]
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1278624b7c4so7149902fac.5;
        Fri, 09 Sep 2022 14:06:47 -0700 (PDT)
X-Gm-Message-State: ACgBeo3FBb9ZCsZHU1OAG3NgFnE3SHg1Oqj8WshpnER8KziTf2spmfRk
        fL9ba0EdAPXtcQCWO/CVKoQerNlra32/Tif1H2s=
X-Google-Smtp-Source: AA6agR4y2JcV0EsyjVkDa6p8pvwM4sY7V8jOR09Bz5w0m7vWO0Itq4SKFTWHNC0vbVHJ/VE4SXL8VeOx9uH4eMX5lOo=
X-Received: by 2002:a05:6870:f626:b0:10d:a798:f3aa with SMTP id
 ek38-20020a056870f62600b0010da798f3aamr5974490oab.194.1662757606749; Fri, 09
 Sep 2022 14:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220907045907.484043-1-ndesaulniers@google.com> <20220907045907.484043-3-ndesaulniers@google.com>
In-Reply-To: <20220907045907.484043-3-ndesaulniers@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 10 Sep 2022 06:06:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR0e2sA4QMssbMf8B0459_LoB9ykfTmFmFVXOjqBea4-w@mail.gmail.com>
Message-ID: <CAK7LNAR0e2sA4QMssbMf8B0459_LoB9ykfTmFmFVXOjqBea4-w@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] Makefile.compiler: Use KBUILD_AFLAGS for as-option
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
        Greg Thelen <gthelen@google.com>
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
> as-instr uses KBUILD_AFLAGS, but as-option uses KBUILD_CFLAGS.  This can
> cause as-option to fail unexpectedly when CONFIG_WERROR is set, because
> clang will emit -Werror,-Wunused-command-line-argument for various -m
> and -f flags for assembler sources.
>
> Callers of as-option (and as-instr) likely want to be adding flags to
> KBUILD_AFLAGS/aflags-y, not KBUILD_CFLAGS/cflags-y.
>
> Also, change as-option and as-instr to use -x assembler-with-cpp since
> kernel sources are .S files that use the compiler as the driver. And
> then add -Werror as well.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1699
> Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---



01 and 02, applied to linux-kbuild/fixes.
Thanks.




> Changes v2 -> v1:
> * Add -x assembler-with-cpp -Werror to both as-option and (new)
>   as-instr, as per Masahiro.
> * Add Masahiro's SB tag.
>
> Changes v1 -> v2:
> * Split off changes to arch/x86/boot/compressed/Makefile into parent
>   patch, as per Masahiro.
>
>  scripts/Makefile.compiler | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
> index 94d0d40cddb3..a66638b5f4a5 100644
> --- a/scripts/Makefile.compiler
> +++ b/scripts/Makefile.compiler
> @@ -29,16 +29,16 @@ try-run = $(shell set -e;           \
>         fi)
>
>  # as-option
> -# Usage: cflags-y += $(call as-option,-Wa$(comma)-isa=foo,)
> +# Usage: aflags-y += $(call as-option,-Wa$(comma)-isa=foo,)
>
>  as-option = $(call try-run,\
> -       $(CC) $(KBUILD_CFLAGS) $(1) -c -x assembler /dev/null -o "$$TMP",$(1),$(2))
> +       $(CC) -Werror $(KBUILD_AFLAGS) $(1) -c -x assembler-with-cpp /dev/null -o "$$TMP",$(1),$(2))
>
>  # as-instr
> -# Usage: cflags-y += $(call as-instr,instr,option1,option2)
> +# Usage: aflags-y += $(call as-instr,instr,option1,option2)
>
>  as-instr = $(call try-run,\
> -       printf "%b\n" "$(1)" | $(CC) $(KBUILD_AFLAGS) -c -x assembler -o "$$TMP" -,$(2),$(3))
> +       printf "%b\n" "$(1)" | $(CC) -Werror $(KBUILD_AFLAGS) -c -x assembler-with-cpp -o "$$TMP" -,$(2),$(3))
>
>  # __cc-option
>  # Usage: MY_CFLAGS += $(call __cc-option,$(CC),$(MY_CFLAGS),-march=winchip-c6,-march=i586)
> --
> 2.37.2.789.g6183377224-goog
>


-- 
Best Regards
Masahiro Yamada
