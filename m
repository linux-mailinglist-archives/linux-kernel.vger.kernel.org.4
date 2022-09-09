Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29DAB5B4144
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 23:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbiIIVHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 17:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiIIVHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 17:07:20 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ADC1473B2;
        Fri,  9 Sep 2022 14:06:48 -0700 (PDT)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 289L6MgA009528;
        Sat, 10 Sep 2022 06:06:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 289L6MgA009528
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662757583;
        bh=vtdLXG6t3z02oyL9Z4xJ/HoU0JT/liNiaOARtmBE8QQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Pu3PhikW33ISolb4kwO0EjazvMY+tLIvUd0LBLPcnZMst0LnNmlRyPW8nUziPHRVf
         B8d7z1PJqBmiP8rOHR6gEhzVfPV6wspuwGjkU0fEjucswCn5aOTAsCO4a3NjprNvo1
         9fLOm9WYoi3FAo4uZsktJcS7Qwgu+NJYDcpwEav630T0DNkEUyjnYYSnRs8BxW8wis
         hZ/bJr/3xeDkHuO0J7LxeDBt9zvDnB3l98oLKy4UFhQj+YbTh4CcBbdA/oXZIlqYiz
         QAyGbPTV4UkwqfqwfbTLtNgRQh9HzZaP244KqPb6C0n06wvZBJn2CrFI9XEnhD8PzV
         IHL9GOP4CsdOA==
X-Nifty-SrcIP: [209.85.210.51]
Received: by mail-ot1-f51.google.com with SMTP id p15-20020a056830130f00b006544f5228e3so1858471otq.2;
        Fri, 09 Sep 2022 14:06:22 -0700 (PDT)
X-Gm-Message-State: ACgBeo2tEfx8K+M0WJQsu7S2B6DP5su1qywqtjgalpZeR7a7ZN4eSRsh
        W8VTxdh25ZU6CGXFs2trj4F77GILAIg2gfES5+A=
X-Google-Smtp-Source: AA6agR7cZxQ2PtL23Q1mwQ2M7VBr2nkH4CHIxcd+zzfk3Li7Z5jY5tsgHCcaGowLE2oMowZwalEsCiHr29uL5Ciurpk=
X-Received: by 2002:a9d:4806:0:b0:637:cdca:f8d3 with SMTP id
 c6-20020a9d4806000000b00637cdcaf8d3mr6389077otf.225.1662757581581; Fri, 09
 Sep 2022 14:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220907045907.484043-1-ndesaulniers@google.com> <20220907045907.484043-2-ndesaulniers@google.com>
In-Reply-To: <20220907045907.484043-2-ndesaulniers@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 10 Sep 2022 06:05:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNARqU4246yPxBr75464wbbnoxb-sLL+UO-fYrkhtFzPEqw@mail.gmail.com>
Message-ID: <CAK7LNARqU4246yPxBr75464wbbnoxb-sLL+UO-fYrkhtFzPEqw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] x86/boot/compressed: prefer cc-option for CFLAGS additions
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
        Arvind Sankar <nivedita@alum.mit.edu>
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
> as-option tests new options using KBUILD_CFLAGS, which causes problems
> when using as-option to update KBUILD_AFLAGS because many compiler
> options are not valid assembler options.
>
> This is being fixed in a follow up patch. Before doing so, move the
> assembler test for -Wa,-mrelax-relocations=no from using as-option to
> cc-option.
>
> Cc: Arvind Sankar <nivedita@alum.mit.edu>
> Cc: x86@kernel.org
> Link: https://lore.kernel.org/llvm/CAK7LNATcHt7GcXZ=jMszyH=+M_LC9Qr6yeAGRCBbE6xriLxtUQ@mail.gmail.com/
> Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>


01 and 02, applied to linux-kbuild/fixes.
Thanks.


> ---
> Changes v2 -> v3:
> * Reword commit message as per Nathan.
> * Pick up Nathan's RB/TB tags.
>
> Changes v1 -> v2:
> * Split off of v1 [1/3].
> * Use cc-option to update CFLAGS, as per Masahiro.
> * Add Masahiro's Suggested-by, Cc Arvind.
>
>  arch/x86/boot/compressed/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 35ce1a64068b..85934204d905 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -49,7 +49,7 @@ KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
>  KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
>  KBUILD_CFLAGS += -D__DISABLE_EXPORTS
>  # Disable relocation relaxation in case the link is not PIE.
> -KBUILD_CFLAGS += $(call as-option,-Wa$(comma)-mrelax-relocations=no)
> +KBUILD_CFLAGS += $(call cc-option,-Wa$(comma)-mrelax-relocations=no)
>  KBUILD_CFLAGS += -include $(srctree)/include/linux/hidden.h
>
>  # sev.c indirectly inludes inat-table.h which is generated during
> --
> 2.37.2.789.g6183377224-goog
>


-- 
Best Regards
Masahiro Yamada
