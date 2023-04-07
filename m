Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED596DB290
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjDGSMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjDGSM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:12:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B06AD38;
        Fri,  7 Apr 2023 11:12:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D1CD6537B;
        Fri,  7 Apr 2023 18:12:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B12C433EF;
        Fri,  7 Apr 2023 18:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680891146;
        bh=8TqxDvlOab8Vyg/3GCA+wbxFSTJBIH20PGcbx7cGego=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oOx8IsLH/tejlqd/prM/5eyW8dt9iE01YDizIoyu7T0J4Dfa3MI6IQ5V/+wvR/Krw
         dj7ACDI6/KEZ/jhZy9MyyV6N3y98AWCnzZ2bNxSibVNRuDPboQzRJsJyLV633995Jk
         8wwpKCfVr/KN0YEBXP9ed+LFR5cO24SO05EBubCaIPd3reLB4ncB2TDqIW5GMzgMFp
         Tolhb+NivywPi4emIEQQQX9EO/hb8960RHmmwkviUCuKoxZRnJoFTFhMrtlK72KXJi
         bWYTN3X+Zk4tlDMHi7NzxlU4zR2zmeVvEraKvULHJkW1RLPZKr/sIyb2u6k1gWDjtb
         2/2Dk1g5037NQ==
Date:   Fri, 7 Apr 2023 11:12:23 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Terrell <terrelln@fb.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH 3/3] kbuild: do not create intermediate *.tar for tar
 packages
Message-ID: <20230407181223.GD1018455@dev-arch.thelio-3990X>
References: <20230407101629.1298051-1-masahiroy@kernel.org>
 <20230407101629.1298051-3-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407101629.1298051-3-masahiroy@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 07:16:29PM +0900, Masahiro Yamada wrote:
> Commit 05e96e96a315 ("kbuild: use git-archive for source package
> creation") split the compression as a separate step to factor out
> the common build rules.
> 
> With the previous commit, we got back to the situation where
> compressed source tarballs are created by a single rule.
> There is no reason to keep the separate compression rules.
> 
> Generate the comressed tar packages directly.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> 
>  scripts/Makefile.package | 27 +++++++++------------------
>  1 file changed, 9 insertions(+), 18 deletions(-)
> 
> diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> index 7707975f729b..e0e18d7dfbd5 100644
> --- a/scripts/Makefile.package
> +++ b/scripts/Makefile.package
> @@ -2,7 +2,6 @@
>  # Makefile for the different targets used to generate full packages of a kernel
>  
>  include $(srctree)/scripts/Kbuild.include
> -include $(srctree)/scripts/Makefile.lib
>  
>  KERNELPATH := kernel-$(subst -,_,$(KERNELRELEASE))
>  KBUILD_PKG_ROOTCMD ?="fakeroot -u"
> @@ -27,21 +26,6 @@ fi ; \
>  tar -I $(KGZIP) -c $(RCS_TAR_IGNORE) -f $(2).tar.gz \
>  	--transform 's:^:$(2)/:S' $(TAR_CONTENT) $(3)
>  
> -# tarball compression
> -# ---------------------------------------------------------------------------
> -
> -%.tar.gz: %.tar
> -	$(call cmd,gzip)
> -
> -%.tar.bz2: %.tar
> -	$(call cmd,bzip2)
> -
> -%.tar.xz: %.tar
> -	$(call cmd,xzmisc)
> -
> -%.tar.zst: %.tar
> -	$(call cmd,zstd)
> -
>  # Git
>  # ---------------------------------------------------------------------------
>  
> @@ -153,10 +137,17 @@ tar-install: FORCE
>  	$(Q)$(MAKE) -f $(srctree)/Makefile
>  	+$(Q)$(srctree)/scripts/package/buildtar $@
>  
> +compress-tar.gz  = -I "$(KGZIP)"
> +compress-tar.bz2 = -I "$(KBZIP2)"
> +compress-tar.xz  = -I "$(XZ)"
> +compress-tar.zst = -I "$(ZSTD)"
> +
>  quiet_cmd_tar = TAR     $@
> -      cmd_tar = cd $<; tar cf ../$@ --owner=root --group=root --sort=name *
> +      cmd_tar = cd $<; tar cf ../$@ $(compress-tar$(suffix $@)) --owner=root --group=root --sort=name *
> +
> +dir-tarballs := $(addprefix linux-$(KERNELRELEASE)-$(ARCH), .tar .tar.gz .tar.bz2 .tar.xz .tar.zst)
>  
> -linux-$(KERNELRELEASE)-$(ARCH).tar: tar-install
> +$(dir-tarballs): tar-install
>  	$(call cmd,tar)
>  
>  PHONY += dir-pkg
> -- 
> 2.37.2
> 
