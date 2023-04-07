Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53966DB24B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjDGSAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjDGSAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:00:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880C8AF0D;
        Fri,  7 Apr 2023 11:00:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2346C611F2;
        Fri,  7 Apr 2023 18:00:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36645C433D2;
        Fri,  7 Apr 2023 18:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680890440;
        bh=i0oEMy2DxwTYLK52sMMBZD09NEUManBUj+WPu18WnMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hdB8NQ0vg5aGsWS9837iR8Kl8onPriiSEQEuhat5qym8UICpNuN5c28wGRCwmS5NL
         XL2k10/wrfPNGb0WwJZ2mnhM8uObvcsaFfvi4bfKIHlKczlE8lp+Kc6pQeXlUX9R/k
         p3DokyxbssHZt6GjV8+DegRAcxAjD/nXWgMucoCPOuAV0ZF2Wg9dqR63m0Rh1uOsB1
         NIHMLR3NqDVx2EPhNDBT2JLr4+lEhA+grxZeDIt9gi34tR3IM3LUNrjcWNJfXVCymH
         3+fgbFc0lvMkbwEvgpskwMX/Y7EqeD2ecrJ1/uGLd0Hg5aYHyrwRtZMhuZ68hQVaqu
         +0jVEUmcR4G1A==
Date:   Fri, 7 Apr 2023 11:00:38 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH 1/3] kbuild: merge cmd_archive_linux and cmd_archive_perf
Message-ID: <20230407180038.GB1018455@dev-arch.thelio-3990X>
References: <20230407101629.1298051-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407101629.1298051-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 07:16:27PM +0900, Masahiro Yamada wrote:
> The two commands, cmd_archive_linux and cmd_archive_perf, are similar.
> Merge them to make it easier to add more changes to the git-archive
> command.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> 
>  scripts/Makefile.package | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> index 61f72eb8d9be..a205617730c6 100644
> --- a/scripts/Makefile.package
> +++ b/scripts/Makefile.package
> @@ -57,16 +57,17 @@ check-git:
>  		false; \
>  	fi
>  
> +quiet_cmd_archive = ARCHIVE $@
> +      cmd_archive = git -C $(srctree) archive \
> +                    --output=$$(realpath $@) --prefix=$(basename $@)/ $(archive-args)
> +
>  # Linux source tarball
>  # ---------------------------------------------------------------------------
>  
> -quiet_cmd_archive_linux = ARCHIVE $@
> -      cmd_archive_linux = \
> -	git -C $(srctree) archive --output=$$(realpath $@) --prefix=$(basename $@)/ $$(cat $<)
> -
>  targets += linux.tar
> +linux.tar: archive-args = $$(cat $<)
>  linux.tar: .tmp_HEAD FORCE
> -	$(call if_changed,archive_linux)
> +	$(call if_changed,archive)
>  
>  # rpm-pkg
>  # ---------------------------------------------------------------------------
> @@ -180,16 +181,14 @@ quiet_cmd_perf_version_file = GEN     $@
>  .tmp_perf/PERF-VERSION-FILE: .tmp_HEAD $(srctree)/tools/perf/util/PERF-VERSION-GEN | .tmp_perf
>  	$(call cmd,perf_version_file)
>  
> -quiet_cmd_archive_perf = ARCHIVE $@
> -      cmd_archive_perf = \
> -	git -C $(srctree) archive --output=$$(realpath $@) --prefix=$(basename $@)/ \
> -	--add-file=$$(realpath $(word 2, $^)) \
> +perf-archive-args = --add-file=$$(realpath $(word 2, $^)) \
>  	--add-file=$$(realpath $(word 3, $^)) \
>  	$$(cat $(word 2, $^))^{tree} $$(cat $<)
>  
>  targets += perf-$(KERNELVERSION).tar
> +perf-$(KERNELVERSION).tar: archive-args = $(perf-archive-args)
>  perf-$(KERNELVERSION).tar: tools/perf/MANIFEST .tmp_perf/HEAD .tmp_perf/PERF-VERSION-FILE FORCE
> -	$(call if_changed,archive_perf)
> +	$(call if_changed,archive)
>  
>  PHONY += perf-tar-src-pkg
>  perf-tar-src-pkg: perf-$(KERNELVERSION).tar
> -- 
> 2.37.2
> 
