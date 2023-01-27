Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEB667EE27
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbjA0T3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbjA0T3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:29:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B471DBBE;
        Fri, 27 Jan 2023 11:29:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 853B361D7D;
        Fri, 27 Jan 2023 19:29:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F62BC433EF;
        Fri, 27 Jan 2023 19:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674847756;
        bh=bGAoISE/E9fNk+5iNwmYvhDOVrcppu7Rp8Qgvkfp190=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ec9m8CJ8RtCe8xm4RAnd8Pvbt1gbsoMh1IO1Q2Z7F9PYpmDb1vGcYj+jWe8mgHbyO
         4uwshDqAIDSKA8p26rIWZClo1wnmea1TYGj4+js4TWblLoDksxvYSJvZdTBAe0OSmT
         PHhpbuIPB9wqC0kQS8993A+zLlpJevlGWpvieB2QVjYAWuuRItQDCPhKF7Q1x7u8vl
         O3Z0GYQeQdSCepaN1YHs/79DtF6Z+aCP6RTgoOUqNN4nLo1Tb832aT2pCax3NAwHMr
         9U0i1E1Cu59v1ELwbS0h9nXPguOMNE4qHVLloZzhC3w1N/nzzyryGIHM8avWTUrW7n
         Yxfe8KcLbs3qg==
Date:   Fri, 27 Jan 2023 12:29:14 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH 1/7] kbuild: do not put .scmversion into the source
 tarball
Message-ID: <Y9QmChqp0WEZSk+H@dev-arch.thelio-3990X>
References: <20230122141428.115372-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230122141428.115372-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Sun, Jan 22, 2023 at 11:14:21PM +0900, Masahiro Yamada wrote:
> .scmversion is used by (src)rpm-pkg and deb-pkg to carry KERNELRELEASE.
> 
> In fact, deb-pkg does not rely on it any more because the generated
> debian/rules specifies KERNELRELEASE from the command line.
> 
> Do likwise for (src)rpm-pkg, and remove this feature.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/Makefile.package |  6 ++----
>  scripts/package/mkspec   |  6 +++---
>  scripts/setlocalversion  | 19 +------------------
>  3 files changed, 6 insertions(+), 25 deletions(-)
> 
> diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> index 525a2820976f..e84c4e8ceb8e 100644
> --- a/scripts/Makefile.package
> +++ b/scripts/Makefile.package
> @@ -32,7 +32,7 @@ export KDEB_SOURCENAME
>  TAR_CONTENT := Documentation LICENSES arch block certs crypto drivers fs \
>                 include init io_uring ipc kernel lib mm net rust \
>                 samples scripts security sound tools usr virt \
> -               .config .scmversion Makefile \
> +               .config Makefile \
>                 Kbuild Kconfig COPYING $(wildcard localversion*)
>  MKSPEC     := $(srctree)/scripts/package/mkspec
>  
> @@ -47,10 +47,8 @@ if test "$(objtree)" != "$(srctree)"; then \
>  	echo >&2; \
>  	false; \
>  fi ; \
> -$(srctree)/scripts/setlocalversion --save-scmversion; \
>  tar -I $(KGZIP) -c $(RCS_TAR_IGNORE) -f $(2).tar.gz \
> -	--transform 's:^:$(2)/:S' $(TAR_CONTENT) $(3); \
> -rm -f $(objtree)/.scmversion
> +	--transform 's:^:$(2)/:S' $(TAR_CONTENT) $(3)
>  
>  # rpm-pkg
>  # ---------------------------------------------------------------------------
> diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> index adab28fa7f89..d3c6701b7769 100755
> --- a/scripts/package/mkspec
> +++ b/scripts/package/mkspec
> @@ -90,7 +90,7 @@ $S	rm -f scripts/basic/fixdep scripts/kconfig/conf
>  $S	rm -f tools/objtool/{fixdep,objtool}
>  $S
>  $S	%build
> -$S	$MAKE %{?_smp_mflags} KBUILD_BUILD_VERSION=%{release}
> +$S	$MAKE %{?_smp_mflags} KERNELRELEASE=%{version} KBUILD_BUILD_VERSION=%{release}
>  $S
>  	%install
>  	mkdir -p %{buildroot}/boot
> @@ -101,8 +101,8 @@ $S
>  	%else
>  	cp \$($MAKE -s image_name) %{buildroot}/boot/vmlinuz-$KERNELRELEASE
>  	%endif
> -$M	$MAKE %{?_smp_mflags} INSTALL_MOD_PATH=%{buildroot} modules_install
> -	$MAKE %{?_smp_mflags} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
> +$M	$MAKE %{?_smp_mflags} KERNELRELEASE=%{version} INSTALL_MOD_PATH=%{buildroot} modules_install
> +	$MAKE %{?_smp_mflags} KERNELRELEASE=%{version} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
>  	cp System.map %{buildroot}/boot/System.map-$KERNELRELEASE
>  	cp .config %{buildroot}/boot/config-$KERNELRELEASE
>  $S$M	rm -f %{buildroot}/lib/modules/$KERNELRELEASE/build
> diff --git a/scripts/setlocalversion b/scripts/setlocalversion
> index af4754a35e66..3b31702b4a4a 100755
> --- a/scripts/setlocalversion
> +++ b/scripts/setlocalversion
> @@ -11,16 +11,11 @@
>  #
>  
>  usage() {
> -	echo "Usage: $0 [--save-scmversion] [srctree]" >&2
> +	echo "Usage: $0 [srctree]" >&2
>  	exit 1
>  }
>  
> -scm_only=false
>  srctree=.
> -if test "$1" = "--save-scmversion"; then
> -	scm_only=true
> -	shift
> -fi
>  if test $# -gt 0; then
>  	srctree=$1
>  	shift
> @@ -35,10 +30,6 @@ scm_version()
>  	short=false
>  
>  	cd "$srctree"
> -	if test -e .scmversion; then
> -		cat .scmversion
> -		return
> -	fi
>  	if test "$1" = "--short"; then
>  		short=true
>  	fi
> @@ -103,14 +94,6 @@ collect_files()
>  	echo "$res"
>  }
>  
> -if $scm_only; then
> -	if test ! -e .scmversion; then
> -		res=$(scm_version)
> -		echo "$res" >.scmversion
> -	fi
> -	exit
> -fi
> -
>  if ! test -e include/config/auto.conf; then
>  	echo "Error: kernelrelease not valid - run 'make prepare' to update it" >&2
>  	exit 1
> -- 
> 2.34.1
> 

I believe this patch causes issues with binrpm-pkg (I have not done a
full bisect, as I am not fully online today; the source path has been
replaced with $PWD):

$ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- RPMOPTS="--define '_topdir $PWD/rpmbuild'" olddefconfig binrpm-pkg
...
Building target platforms: aarch64-linux
Building for target aarch64-linux
warning: line 23: It's not recommended to have unversioned Obsoletes: Obsoletes: kernel-headers
error: cannot open Packages database in /var/lib/rpm
Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.targJq
+ umask 022
+ cd .
+ /usr/bin/rm -rf $PWD/rpmbuild/BUILDROOT/kernel-6.2.0_rc5_next_20230127+-1.aarch64
+ /usr/bin/mkdir -p $PWD/rpmbuild/BUILDROOT
+ /usr/bin/mkdir $PWD/rpmbuild/BUILDROOT/kernel-6.2.0_rc5_next_20230127+-1.aarch64
+ mkdir -p $PWD/rpmbuild/BUILDROOT/kernel-6.2.0_rc5_next_20230127+-1.aarch64/boot
++ make -f ./Makefile -s image_name
+ cp arch/arm64/boot/Image.gz $PWD/rpmbuild/BUILDROOT/kernel-6.2.0_rc5_next_20230127+-1.aarch64/boot/vmlinuz-6.2.0-rc5-next-20230127+
+ make -f ./Makefile -j128 KERNELRELEASE=6.2.0_rc5_next_20230127+ INSTALL_MOD_PATH=$PWD/rpmbuild/BUILDROOT/kernel-6.2.0_rc5_next_20230127+-1.aarch64 modules_install
make[3]: warning: -j128 forced in submake: resetting jobserver mode.
+ make -f ./Makefile -j128 KERNELRELEASE=6.2.0_rc5_next_20230127+ INSTALL_HDR_PATH=$PWD/rpmbuild/BUILDROOT/kernel-6.2.0_rc5_next_20230127+-1.aarch64/usr headers_install
make[3]: warning: -j128 forced in submake: resetting jobserver mode.
+ cp System.map $PWD/rpmbuild/BUILDROOT/kernel-6.2.0_rc5_next_20230127+-1.aarch64/boot/System.map-6.2.0-rc5-next-20230127+
+ cp .config $PWD/rpmbuild/BUILDROOT/kernel-6.2.0_rc5_next_20230127+-1.aarch64/boot/config-6.2.0-rc5-next-20230127+
+ /usr/lib/rpm/brp-compress
Processing files: kernel-6.2.0_rc5_next_20230127+-1.aarch64
error: File not found: $PWD/rpmbuild/BUILDROOT/kernel-6.2.0_rc5_next_20230127+-1.aarch64/lib/modules/6.2.0-rc5-next-20230127+
warning: File not found: $PWD/rpmbuild/BUILDROOT/kernel-6.2.0_rc5_next_20230127+-1.aarch64/lib/modules/6.2.0-rc5-next-20230127+/build
warning: File not found: $PWD/rpmbuild/BUILDROOT/kernel-6.2.0_rc5_next_20230127+-1.aarch64/lib/modules/6.2.0-rc5-next-20230127+/source

RPM build warnings:
    line 23: It's not recommended to have unversioned Obsoletes: Obsoletes: kernel-headers
    File not found: $PWD/rpmbuild/BUILDROOT/kernel-6.2.0_rc5_next_20230127+-1.aarch64/lib/modules/6.2.0-rc5-next-20230127+/build
    File not found: $PWD/rpmbuild/BUILDROOT/kernel-6.2.0_rc5_next_20230127+-1.aarch64/lib/modules/6.2.0-rc5-next-20230127+/source

RPM build errors:
    cannot open Packages database in /var/lib/rpm
    File not found: $PWD/rpmbuild/BUILDROOT/kernel-6.2.0_rc5_next_20230127+-1.aarch64/lib/modules/6.2.0-rc5-next-20230127+
...

Cheers,
Nathan
