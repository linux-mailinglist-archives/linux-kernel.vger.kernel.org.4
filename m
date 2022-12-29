Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D60F658894
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 03:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbiL2CPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 21:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiL2CPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 21:15:36 -0500
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE44B2E;
        Wed, 28 Dec 2022 18:15:34 -0800 (PST)
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 2BT2FHcG020403;
        Thu, 29 Dec 2022 11:15:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 2BT2FHcG020403
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1672280118;
        bh=D0ejBf8WyInMfQalWKUmD1ZMmj0FCuKBe2PAsgtwA7g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E8T7Nj2dzfrM5NL+0Ia3taFfGuekRjNiXmc0OVKqXMfAmcKofD7ICLuTqwnBhDZvu
         MTdCim8j2vBNTBL66sVRpnAy+Egu1LZ48zNgXnWHVQ8vAdyx2jqBnG3r44fiGNJ34t
         dpsxeZfnVz75CzlyTTVpPJwrvbdeZVB0jQbI/1AGE9n9rKsSlC8FVhVnQ6EG7VVJJi
         I3c77kitHkJGJNyA24RfvxfdTsdKCa6fbY0BlautuyteV5ENZ9RP5JSgqENz3v0/Kr
         4p2M+Oj8j383ktaiO0f5+BeHLfYuBn/sFQuuviKanFD+cwl2sFdBhtEIO+ClXSoTUs
         BDBV1Lacbi6uA==
X-Nifty-SrcIP: [209.85.160.48]
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1442977d77dso20433826fac.6;
        Wed, 28 Dec 2022 18:15:18 -0800 (PST)
X-Gm-Message-State: AFqh2krp4VTwk4mlGN6KHGw5g4QvHEFp+6MmWlp/YM7TV90nR1l6gsrY
        pcAXW+0GCXWGgQZt/G3NYzCSiL2DymwVfxUACBo=
X-Google-Smtp-Source: AMrXdXtJkxjfdPMzu5p/q6qGmEppMC3iIqZQ+qLAKMPWBD21yVaKFLpAy18RiZDYPZu1TVYbDBJWFqMcQQ/0jMjQBek=
X-Received: by 2002:a05:6870:4c0e:b0:144:a2de:1075 with SMTP id
 pk14-20020a0568704c0e00b00144a2de1075mr1323170oab.194.1672280116731; Wed, 28
 Dec 2022 18:15:16 -0800 (PST)
MIME-Version: 1.0
References: <20221227214821.16495-1-samuel@sholland.org>
In-Reply-To: <20221227214821.16495-1-samuel@sholland.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 29 Dec 2022 11:14:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQc-gEY_v-5f99r=Zeq0oQ3R7apdrc-3M14akhHBp_GoA@mail.gmail.com>
Message-ID: <CAK7LNAQc-gEY_v-5f99r=Zeq0oQ3R7apdrc-3M14akhHBp_GoA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Fix running modpost with musl libc
To:     Samuel Holland <samuel@sholland.org>
Cc:     linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 6:48 AM Samuel Holland <samuel@sholland.org> wrote:
>
> commit 3d57e1b7b1d4 ("kbuild: refactor the prerequisites of the modpost
> rule") moved 'vmlinux.o' inside modpost-args, possibly before some of
> the other options. However, getopt() in musl libc follows POSIX and
> stops looking for options upon reaching the first non-option argument.
> As a result, the '-T' option is misinterpreted as a positional argument,
> and the build fails:
>
>   make -f ./scripts/Makefile.modpost
>      scripts/mod/modpost   -E   -o Module.symvers vmlinux.o -T modules.order
>   -T: No such file or directory
>   make[1]: *** [scripts/Makefile.modpost:137: Module.symvers] Error 1
>   make: *** [Makefile:1960: modpost] Error 2
>
> The fix is to move all options before 'vmlinux.o' in modpost-args.
>
> Fixes: 3d57e1b7b1d4 ("kbuild: refactor the prerequisites of the modpost rule")
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>



Applied to linux-kbuild/fixes. Thanks.


>  scripts/Makefile.modpost | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> index 5eb5e8280379..0ee296cf520c 100644
> --- a/scripts/Makefile.modpost
> +++ b/scripts/Makefile.modpost
> @@ -55,6 +55,17 @@ ifneq ($(findstring i,$(filter-out --%,$(MAKEFLAGS))),)
>  modpost-args += -n
>  endif
>
> +ifneq ($(KBUILD_MODPOST_WARN)$(missing-input),)
> +modpost-args += -w
> +endif
> +
> +# Read out modules.order to pass in modpost.
> +# Otherwise, allmodconfig would fail with "Argument list too long".
> +ifdef KBUILD_MODULES
> +modpost-args += -T $(MODORDER)
> +modpost-deps += $(MODORDER)
> +endif
> +
>  ifeq ($(KBUILD_EXTMOD),)
>
>  # Generate the list of in-tree objects in vmlinux
> @@ -113,17 +124,6 @@ modpost-args += -e $(addprefix -i , $(KBUILD_EXTRA_SYMBOLS))
>
>  endif # ($(KBUILD_EXTMOD),)
>
> -ifneq ($(KBUILD_MODPOST_WARN)$(missing-input),)
> -modpost-args += -w
> -endif
> -
> -ifdef KBUILD_MODULES
> -modpost-args += -T $(MODORDER)
> -modpost-deps += $(MODORDER)
> -endif
> -
> -# Read out modules.order to pass in modpost.
> -# Otherwise, allmodconfig would fail with "Argument list too long".
>  quiet_cmd_modpost = MODPOST $@
>        cmd_modpost = \
>         $(if $(missing-input), \
> --
> 2.37.4
>


-- 
Best Regards
Masahiro Yamada
