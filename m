Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142896DB283
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjDGSLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjDGSLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:11:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFF4AD02;
        Fri,  7 Apr 2023 11:11:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C31365055;
        Fri,  7 Apr 2023 18:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A6CC433D2;
        Fri,  7 Apr 2023 18:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680891067;
        bh=BWzBViVw+Sgief90El4Js+Vc5AfQh5Kawzk2O+ZsBxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CTCJ3vFMIo7YXyvsP7o0rn8wFKWxX3/XR0XGX0uR9Ga/OIDh3Yd57UNnkGyqRIciB
         Ej1rcv+4Ijw4urVEz93S2ZInfaZRRqaqPEQ0hUKIT4vkMZdReUDuTA96ocFWHtq8GC
         AaMq/J+oafcVulPJR/9cr05+784kNu9BfVXzcMLM3wB1J/DClUzmhzMekNfrW41n53
         hb0aOLPaCdscGPGD3gvMdGzjygjVL8hlrECkjsFPRlIcqROvlnFAwFk10bPWiSJk7C
         QhD+j6AmIqM9J4e2j7NooOR6/+UUzCjcEOUE9W4rc1erVwS2I04kqTSOB74Pt2NMt1
         hy0/qpXyoGvmA==
Date:   Fri, 7 Apr 2023 11:11:05 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH 2/3] kbuild: do not create intermediate *.tar for source
 tarballs
Message-ID: <20230407181105.GC1018455@dev-arch.thelio-3990X>
References: <20230407101629.1298051-1-masahiroy@kernel.org>
 <20230407101629.1298051-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407101629.1298051-2-masahiroy@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 07:16:28PM +0900, Masahiro Yamada wrote:
> Since commit 05e96e96a315 ("kbuild: use git-archive for source package
> creation"), source tarballs are created in two steps; create *.tar file
> then compress it. I split the compression as a separate rule because I
> just thought 'git archive' supported only gzip for compression. I admit
> the unneeded *.tar file is annoying.
> 
> For other compression algorithms, I could pipe the two commands:
> 
>   $ git archive HEAD | xz > linux.tar.xz
> 
> I read git-archive(1) carefully, and I realized GIT had provided a
> more elegant way:

Hooray for documentation :)

>   $ git -c tar.tar.xz.command=xz archive -o linux.tar.xz HEAD
> 
> This commit uses 'tar.tar.*.command' configuration to specify the
> compression backend so we can create a compressed tarball directly.
> 
> GIT commit 767cf4579f0e ("archive: implement configurable tar filters")
> is more than a decade old, so it should be available on almost all build
> environments.

git 1.7.7 it seems, certainly ancientware in my opinion. If people have
issues with this, they can just upgrade git; even RHEL7 has git 1.8.x.

> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> 
>  scripts/Makefile.package | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> index a205617730c6..7707975f729b 100644
> --- a/scripts/Makefile.package
> +++ b/scripts/Makefile.package
> @@ -57,16 +57,23 @@ check-git:
>  		false; \
>  	fi
>  
> +archive-config-tar.gz  = -c tar.tar.gz.command="$(KGZIP)"
> +archive-config-tar.bz2 = -c tar.tar.bz2.command="$(KBZIP2)"
> +archive-config-tar.xz  = -c tar.tar.xz.command="$(XZ)"
> +archive-config-tar.zst = -c tar.tar.zst.command="$(ZSTD)"
> +
>  quiet_cmd_archive = ARCHIVE $@
> -      cmd_archive = git -C $(srctree) archive \
> +      cmd_archive = git -C $(srctree) $(archive-config-tar$(suffix $@)) archive \
>                      --output=$$(realpath $@) --prefix=$(basename $@)/ $(archive-args)
>  
>  # Linux source tarball
>  # ---------------------------------------------------------------------------
>  
> -targets += linux.tar
> -linux.tar: archive-args = $$(cat $<)
> -linux.tar: .tmp_HEAD FORCE
> +linux-tarballs := $(addprefix linux, .tar.gz)

Is there any reason not to allow other compression formats for linux
like you do for perf?

> +
> +targets += $(linux-tarballs)
> +$(linux-tarballs): archive-args = $$(cat $<)
> +$(linux-tarballs): .tmp_HEAD FORCE
>  	$(call if_changed,archive)
>  
>  # rpm-pkg
> @@ -185,9 +192,12 @@ perf-archive-args = --add-file=$$(realpath $(word 2, $^)) \
>  	--add-file=$$(realpath $(word 3, $^)) \
>  	$$(cat $(word 2, $^))^{tree} $$(cat $<)
>  
> -targets += perf-$(KERNELVERSION).tar
> -perf-$(KERNELVERSION).tar: archive-args = $(perf-archive-args)
> -perf-$(KERNELVERSION).tar: tools/perf/MANIFEST .tmp_perf/HEAD .tmp_perf/PERF-VERSION-FILE FORCE
> +
> +perf-tarballs := $(addprefix perf-$(KERNELVERSION), .tar .tar.gz .tar.bz2 .tar.xz .tar.zst)
> +
> +targets += $(perf-tarballs)
> +$(perf-tarballs): archive-args = $(perf-archive-args)
> +$(perf-tarballs): tools/perf/MANIFEST .tmp_perf/HEAD .tmp_perf/PERF-VERSION-FILE FORCE
>  	$(call if_changed,archive)
>  
>  PHONY += perf-tar-src-pkg
> -- 
> 2.37.2
> 
