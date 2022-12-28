Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970286582B4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 17:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbiL1QkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 11:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235060AbiL1Qjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 11:39:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B1D1E3E9;
        Wed, 28 Dec 2022 08:34:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46C4CB816F4;
        Wed, 28 Dec 2022 16:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CDAC433D2;
        Wed, 28 Dec 2022 16:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672245291;
        bh=BO5gC5UrGzz4zyaWHSE8ij4gl/d9i03g/+qNNL4Jqmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WJnyKdaH1auJkyOMSMBKg6YYuFY3x71fQrKcspJuXqc0RYOlTCP2SOjx/N8I7CAot
         IKOPKkv+nCTy59Y2Mj2HvDiCmrEb7mC4KvXnu4ELMxZeEhf4x6llD1NNS90QGY3od0
         BDUmQ/H1KJpLXAI5B/AqO9mqp9U4RDCSw0Pr7klG/aJ+KCqnFto8oC2UC9JLXCd+5z
         iAn4NzI1WGUBLPHLvCkdNxZ1lAf503B/nrDpheprGNQ6PRmg0iLCBWXnqE/dSrUJzw
         Oj/qNFpQJDAHIh58gey6SYSu7WAC6WIdrg0R342/rjtjdWN1tPlUyIe615nBbDwApH
         IjBkwGzgMaCvg==
Date:   Wed, 28 Dec 2022 09:34:48 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: Fix running modpost with musl libc
Message-ID: <Y6xwKFwtTrZ4Uzqk@dev-arch.thelio-3990X>
References: <20221227214821.16495-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221227214821.16495-1-samuel@sholland.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 03:48:21PM -0600, Samuel Holland wrote:
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

Seems reasonable to me.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> 
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
>  	$(if $(missing-input), \
> -- 
> 2.37.4
> 
