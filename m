Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04CC726181
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239102AbjFGNkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235381AbjFGNkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:40:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F841993;
        Wed,  7 Jun 2023 06:40:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4ECE063608;
        Wed,  7 Jun 2023 13:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E0AC4339C;
        Wed,  7 Jun 2023 13:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686145215;
        bh=SNCVxE2wrdQKzyySHbHvUG+bSoAJiX15ywJ8wsEKhGU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UpOYu5F+ysiBloC09ECUTMARBl5FodyCioP6hcWfuE9CXFfrRXpViAKZiD3LlNexq
         eWuzSRPPMqM3Y1t/5534mE8X8DRIyO+D4VggTBXmjrUzF78trhZRVwLdj6Mek9Bd+1
         1STbY6pp0G9YFjrb5BfWqv2HTEzPcMcpZlTyJC5An3xW/NxcYVJLjno5flwzlmLEXb
         uAQ3qcm9mKr8GhNN/wkfxrSz7d0wm58XDSyZj2YWYV9NieXrF1jTCILtEyRFqOC7F1
         b/pk374IKozc7CVugv3jn2jbXnFgZNq6QqNg9rVrF0gkNbKm8WxLucmTuL3nUgha0w
         lxkgw1sNlBC+A==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-39aa825c299so406144b6e.0;
        Wed, 07 Jun 2023 06:40:15 -0700 (PDT)
X-Gm-Message-State: AC+VfDyRIfD5UQU3XvAaDUlzCD3am2/adgKjJHBx+3qE4zew8KHEzow6
        Ouhe5yLWXPXpJw1Wq2xJcqgoTpxq/5Et58oyqvA=
X-Google-Smtp-Source: ACHHUZ4/GXwyywl7SpLOvRacOyzGB77x6C4lOebtqwbMKWUbtBOpqojrapAP9u2lQMYGmCAAGxRYELO0iegYuJ6INhI=
X-Received: by 2002:aca:efd5:0:b0:39a:4170:6840 with SMTP id
 n204-20020acaefd5000000b0039a41706840mr6804736oih.21.1686145214823; Wed, 07
 Jun 2023 06:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230606-fix-as-option-after-clang_flags-move-v1-1-a7f7b23a35e3@kernel.org>
In-Reply-To: <20230606-fix-as-option-after-clang_flags-move-v1-1-a7f7b23a35e3@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 7 Jun 2023 22:39:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNARAnyYo-Xdx9c528=Pw7cVbt1peWTTCu6LQkLmeMsp+hA@mail.gmail.com>
Message-ID: <CAK7LNARAnyYo-Xdx9c528=Pw7cVbt1peWTTCu6LQkLmeMsp+hA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Add KBUILD_CPPFLAGS to as-option invocation
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     naresh.kamboju@linaro.org, ndesaulniers@google.com,
        nicolas@fjasle.eu, trix@redhat.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev,
        Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 7:40=E2=80=AFAM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> After commit feb843a469fb ("kbuild: add $(CLANG_FLAGS) to
> KBUILD_CPPFLAGS"), there is an error while building certain PowerPC
> assembly files with clang:
>
>   arch/powerpc/lib/copypage_power7.S: Assembler messages:
>   arch/powerpc/lib/copypage_power7.S:34: Error: junk at end of line: `0b0=
1000'
>   arch/powerpc/lib/copypage_power7.S:35: Error: junk at end of line: `0b0=
1010'
>   arch/powerpc/lib/copypage_power7.S:37: Error: junk at end of line: `0b0=
1000'
>   arch/powerpc/lib/copypage_power7.S:38: Error: junk at end of line: `0b0=
1010'
>   arch/powerpc/lib/copypage_power7.S:40: Error: junk at end of line: `0b0=
1010'
>   clang: error: assembler command failed with exit code 1 (use -v to see =
invocation)
>
> as-option only uses KBUILD_AFLAGS, so after removing CLANG_FLAGS from
> KBUILD_AFLAGS, there is no more '--target=3D' or '--prefix=3D' flags. As =
a
> result of those missing flags, the host target
> will be tested during as-option calls and likely fail, meaning necessary
> flags may not get added when building assembly files, resulting in
> errors like seen above.
>
> Add KBUILD_CPPFLAGS to as-option invocations to clear up the errors.
> This should have been done in commit d5c8d6e0fa61 ("kbuild: Update
> assembler calls to use proper flags and language target"), which
> switched from using the assembler target to the assembler-with-cpp
> target, so flags that affect preprocessing are passed along in all
> relevant tests. as-option now mirrors cc-option.
>
> Fixes: feb843a469fb ("kbuild: add $(CLANG_FLAGS) to KBUILD_CPPFLAGS")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/CA+G9fYs=3DkoW9WardsTtora+nMgLR3raHz-LSLr=
58tgX4T5Mxag@mail.gmail.com/
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---

Applied to linux-kbuild.
Thanks.



>  scripts/Makefile.compiler | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
> index 437013f8def3..e31f18625fcf 100644
> --- a/scripts/Makefile.compiler
> +++ b/scripts/Makefile.compiler
> @@ -32,7 +32,7 @@ try-run =3D $(shell set -e;             \
>  # Usage: aflags-y +=3D $(call as-option,-Wa$(comma)-isa=3Dfoo,)
>
>  as-option =3D $(call try-run,\
> -       $(CC) -Werror $(KBUILD_AFLAGS) $(1) -c -x assembler-with-cpp /dev=
/null -o "$$TMP",$(1),$(2))
> +       $(CC) -Werror $(KBUILD_CPPFLAGS) $(KBUILD_AFLAGS) $(1) -c -x asse=
mbler-with-cpp /dev/null -o "$$TMP",$(1),$(2))
>
>  # as-instr
>  # Usage: aflags-y +=3D $(call as-instr,instr,option1,option2)
>
> ---
> base-commit: feb843a469fb0ab00d2d23cfb9bcc379791011bb
> change-id: 20230606-fix-as-option-after-clang_flags-move-be88e993cbaa
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>


--=20
Best Regards
Masahiro Yamada
