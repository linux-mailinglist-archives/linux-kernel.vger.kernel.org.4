Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7296E8459
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjDSWDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDSWDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:03:45 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A30210A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:03:44 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1a92369761cso4128625ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681941823; x=1684533823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zh5e890yF5vPU5jFDEQlJGrwn7FtrHqnTGkDM3PEhGk=;
        b=nYVR6pd5ohHan4cvMM25Oc7l0XYFR7FKSc+MZWSm47m/oOsn4bUdrLtiApb2BMvn9W
         WMcUClzdzEaRKUhQqYcVkdaaXR7KftttiGhQ7uahIeMcUbgwCNxXOFoRc0bqdUzsQNhH
         TNIgJE1vhzIYwtrMizt4qj93JwRprxsgCnHVpqaBaO8fnbOpHZOl6pX9icRFTPPabgWH
         AspQ5jLPqr23bvNYBUnbbxE6dz4gJfQw9RdJkVEwTGJ1vMBdxoV9soEmxUrCqrFDZaYs
         5JTEhKZT+WcDaVg3XI73+vIz4c16Lv6VGec0UOth4LxNfXZuXXhJIDLO0/ERPMvIbgGy
         4C2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681941823; x=1684533823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zh5e890yF5vPU5jFDEQlJGrwn7FtrHqnTGkDM3PEhGk=;
        b=cOlSjUxLzz0xt6Y2VoBqQk4B/cWpTE0kI7LoqHEzpBr1Owj8hpppObrJFBcrFdQKUv
         uvCC13udkaXu4JkDn7KQ1xIUZDMXONGT5/kYg1aFVG5vv9Rwk5S6U2JhLYYVsCGBjEAF
         lSeTqEGo3o0+5W41dCB6CRuseEiAceFxI3QyaKVNGuYRcICqlTfYHexTU5+HXRt75iNa
         pfeDbq75U75yIfrU6QFQ1daU7fURoNdoPJuP/s4sSwf6bg7n5WukDNcBINXXYRsTsUtB
         QU+Gx//oUl4pUTQOes9u65Wrm10ZUUNNXd+2/Ez0Jgnt80huZH885EXL39ZrC36RfX6q
         mlmw==
X-Gm-Message-State: AAQBX9dvdk8AScZdv6oKfj/Rl4UGLMCT3P+ycQJL3Ch0t8TIr0CRNpxE
        Uy4g1jD83vm2eosTq/rqgu/8KeytWyHl3vZVG68jJw==
X-Google-Smtp-Source: AKy350Y2Z2JjZ2qaX/ON4uPm2q//KaaWuchhgDJWWtGCJjwBgwDhMMx5Eo7igcV2qq6xRhf+gjVMj3nsuoCURnpIxZM=
X-Received: by 2002:a17:902:f78c:b0:1a2:94bb:e104 with SMTP id
 q12-20020a170902f78c00b001a294bbe104mr6667157pln.39.1681941823522; Wed, 19
 Apr 2023 15:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230419-mips-check_bugs-init-attribute-v1-1-91e6eed55b89@kernel.org>
In-Reply-To: <20230419-mips-check_bugs-init-attribute-v1-1-91e6eed55b89@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 19 Apr 2023 15:03:31 -0700
Message-ID: <CAKwvOdmuQBnZR_pB5bUdsF+OoB_4pxBT9TNFF83fZhzwZ1gbxw@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Mark check_bugs{,_early}() as __init
To:     Nathan Chancellor <nathan@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     jpoimboe@kernel.org, peterz@infradead.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Apr 19, 2023 at 11:43=E2=80=AFAM Nathan Chancellor <nathan@kernel.o=
rg> wrote:
>
> After commit ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING
> forcibly"), a compiler may choose not to inline a function marked with
> just 'inline'. If check_bugs() is not inlined into start_kernel(), which
> occurs when building with clang after commit 9ea7e6b62c2b ("init: Mark
> [arch_call_]rest_init() __noreturn"), modpost complains with:
>
>   WARNING: modpost: vmlinux.o: section mismatch in reference: check_bugs =
(section: .text) -> check_bugs32 (section: .init.text)
>
> check_bugs() is only called from start_kernel(), which itself is marked
> __init, so mark check_bugs() as __init as well to clear up the warning
> and make everything work properly.
>
> While there is currently no warning about check_bugs_early(), it could
> have the same problem, as it is called from arch_setup() and calls
> check_bugs64_early(), both marked __init. Mark it as __init for the same
> reason as above.
>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> NOTE: This is based on v6.3-rc7, as the issue shows up due to a patch in
> the tip tree, but this appears to be an ancient issue that could have
> showed up at any point (hence why no explicit Fixes tag), so I chose a
> base that should allow either the MIPS or tip folks to apply this patch.

Probably for the MIPS tree.

>
> Additionally, I was tempted to remove the explicit 'inline' since the
> compiler is free to do whatever it wants anyways but this is a static
> function in a header so we would need to add '__maybe_unused', which is
> already added with 'inline' in a normal build so I just left it alone.
> ---
>  arch/mips/include/asm/bugs.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/include/asm/bugs.h b/arch/mips/include/asm/bugs.h
> index d72dc6e1cf3c..9b9bf9bc7d24 100644
> --- a/arch/mips/include/asm/bugs.h
> +++ b/arch/mips/include/asm/bugs.h
> @@ -24,13 +24,13 @@ extern void check_bugs64_early(void);
>  extern void check_bugs32(void);
>  extern void check_bugs64(void);
>
> -static inline void check_bugs_early(void)
> +static inline void __init check_bugs_early(void)
>  {
>         if (IS_ENABLED(CONFIG_CPU_R4X00_BUGS64))
>                 check_bugs64_early();
>  }

If the only call site is in arch/mips/kernel/setup.c, then perhaps we
can move the definition of check_bugs_early there and mark it static
__init and drop inline?

Unless we foresee other callers potentially in the future?  Patch
otherwise LGTM.  Thanks for the patch!

>
> -static inline void check_bugs(void)
> +static inline void __init check_bugs(void)
>  {
>         unsigned int cpu =3D smp_processor_id();
>
>
> ---
> base-commit: 6a8f57ae2eb07ab39a6f0ccad60c760743051026
> change-id: 20230419-mips-check_bugs-init-attribute-026103bdb255
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>


--=20
Thanks,
~Nick Desaulniers
