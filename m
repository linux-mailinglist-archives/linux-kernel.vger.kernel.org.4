Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB4067C3D5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 05:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjAZEYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 23:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjAZEYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 23:24:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48E73B0F1;
        Wed, 25 Jan 2023 20:24:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B5A7B81CC6;
        Thu, 26 Jan 2023 04:24:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2071C4339C;
        Thu, 26 Jan 2023 04:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674707071;
        bh=sWbjQTRCxadlbLQUn48rYhAzqa6RuEwbYlxB2uDoP2g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UwapKS2vrsI7ZOzOY5TofHCbFKrUlciDFa9tN6TEiMdx7KUG8QhImE+8styYe5LrF
         KWw8Wbq4InPm/slYsE+49hdnc/i4gxclZXc4yvTxOd524CO4YwmUCz3/xEY6Ez5Yz9
         bF5ZVpx3MBxPfsrbclYAQnutqTS7/NRjsQLG+PGAGZknEKCvzQtW5P9tkwMLmFCeAk
         oz6RBiq6BWWB8PuxVl0FXiZibxDL8emUgfKohrysRkKx2kht9JibKnbGz9YfRyH2t9
         ERC5LJVGox+5KPDx4mvwnp1tguJ9M293x3l2Uzv41Rk1FJMXzIGYF7M1s4rqWAD34g
         ASwx/zKw+nvNA==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-15085b8a2f7so1125302fac.2;
        Wed, 25 Jan 2023 20:24:30 -0800 (PST)
X-Gm-Message-State: AFqh2krkajT1F597mdG8zLTiL8tbwl8xyn6hvcLwVSQ7Rbe4T6NDTEXp
        t/+zUBj1nSyzfIK/LxWwk2ePF/1H/ln7TTpsVe8=
X-Google-Smtp-Source: AK7set/PNYPvPP/GjRjIRGJzYjSEmyoUNcXyniROhcp8vnAKH6317MZroWIjsXCLu1JuqdqIc9JD2eMm+ul9pJnsLE8=
X-Received: by 2002:a05:6870:110f:b0:160:3296:a9b9 with SMTP id
 15-20020a056870110f00b001603296a9b9mr850092oaf.287.1674707070213; Wed, 25 Jan
 2023 20:24:30 -0800 (PST)
MIME-Version: 1.0
References: <20230123-qunused-argument-auto-var-init-v1-1-ec06051f0d87@kernel.org>
In-Reply-To: <20230123-qunused-argument-auto-var-init-v1-1-ec06051f0d87@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 26 Jan 2023 13:23:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNAThyrFRH22f8pdKyh0ypgCkEhnF9kUJ3XM3C=B2XGF-9A@mail.gmail.com>
Message-ID: <CAK7LNAThyrFRH22f8pdKyh0ypgCkEhnF9kUJ3XM3C=B2XGF-9A@mail.gmail.com>
Subject: Re: [PATCH] powerpc/vdso: Filter clang's auto var init zero enabler
 when linking
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     ndesaulniers@google.com, nicolas@fjasle.eu, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu, trix@redhat.com,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 1:20 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> After commit 7bbf02b875b5 ("kbuild: Stop using '-Qunused-arguments' with
> clang"), the PowerPC vDSO shows the following error with clang-13 and
> older when CONFIG_INIT_STACK_ALL_ZERO is enabled:
>
>   clang: error: argument unused during compilation: '-enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang' [-Werror,-Wunused-command-line-argument]
>
> clang-14 added a change to make sure this flag never triggers
> -Wunused-command-line-argument, so it is fixed with newer releases. For
> older releases that the kernel still supports building with, just filter
> out this flag, as has been done for other flags.
>
> Fixes: b174f4c26aa3 ("powerpc/vdso: Improve linker flags")
> Fixes: 7bbf02b875b5 ("kbuild: Stop using '-Qunused-arguments' with clang")
> Link: https://github.com/llvm/llvm-project/commit/ca6d5813d17598cd180995fb3bdfca00f364475f
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> This should be the last flag that needs to be filtered (famous last
> words...) but if any more come up, we should really just explore
> switching the PowerPC vDSO to linking with $(LD) like every other part
> of the kernel; for now, I hope this is fine.
>
> Cheers,
> Nathan


Applied to linux-kbuild. Thanks.

Since I rebased the branch, the tags have been updated
accordingly.





    powerpc/vdso: Filter clang's auto var init zero enabler when linking

    After commit 8d9acfce3332 ("kbuild: Stop using '-Qunused-arguments' with
    clang"), the PowerPC vDSO shows the following error with clang-13 and
    older when CONFIG_INIT_STACK_ALL_ZERO is enabled:

      clang: error: argument unused during compilation:
'-enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang'
[-Werror,-Wunused-command-line-argument]

    clang-14 added a change to make sure this flag never triggers
    -Wunused-command-line-argument, so it is fixed with newer releases. For
    older releases that the kernel still supports building with, just filter
    out this flag, as has been done for other flags.

    Fixes: f0a42fbab447 ("powerpc/vdso: Improve linker flags")
    Fixes: 8d9acfce3332 ("kbuild: Stop using '-Qunused-arguments' with clang")
    Link: https://github.com/llvm/llvm-project/commit/ca6d5813d17598cd180995fb3bdfca00f364475f
    Signed-off-by: Nathan Chancellor <nathan@kernel.org>
    Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>



-- 
Best Regards
Masahiro Yamada
