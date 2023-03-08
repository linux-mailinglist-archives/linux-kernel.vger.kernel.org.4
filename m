Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852926B0716
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjCHM3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjCHM3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:29:19 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3E38C800;
        Wed,  8 Mar 2023 04:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678278555; x=1709814555;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=74bgf4K5vnxyOhb7A4v9H6AxayJ3b1hKMVnJKdHJB2Q=;
  b=gTqDrf1gVKMKrQon8JGCEsojPqilgiI02gLRXC+T9KVEh6/nBNBy0oxm
   EQRMA7jnUhT90yjEJ9fmfeafuYL+HZ82nr8nR3pwUxyN+gbgP3soQFeGR
   0ZmvMkb0zb7grRSHBy69JHRLYS8nOpds0+CBp6mni0Q/bL7urybSMto/a
   JU+ttf8OlX8GigzMMWNnAX1sY029g22tnhukrqKJbhAvW1Hbqbg68eEN6
   ZvbMAZ1fNEjfqgQtFocIe6gupWwxK9Ip2QKCtiRUdav0wmFrxFNKryZCb
   jOQDIFx2OcZmgJ6jHpKWASPB8TXp1nm2JjHhmlZPicBt5OV74e+1eToAe
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="334852323"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="334852323"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 04:29:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="787107909"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="787107909"
Received: from dandries-mobl.ger.corp.intel.com (HELO [10.251.218.180]) ([10.251.218.180])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 04:29:11 -0800
Message-ID: <444e7e7b-c576-38a9-9f85-b169b32c3807@linux.intel.com>
Date:   Wed, 8 Mar 2023 14:29:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v6 11/12] kbuild: deb-pkg: improve the usability of source
 package
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        "Bossart, Pierre-louis" <pierre-louis.bossart@intel.com>,
        "Vehmanen, Kai" <kai.vehmanen@intel.com>,
        "Girdwood, Liam R" <liam.r.girdwood@intel.com>,
        peter.ujfalusi@linux.intel.com
References: <20230215012034.403356-1-masahiroy@kernel.org>
 <20230215012034.403356-11-masahiroy@kernel.org>
Content-Language: en-US
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20230215012034.403356-11-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/02/2023 03:20, Masahiro Yamada wrote:
> Improve the source package support in case the dpkg-buildpackage is
> directly used to build binary packages.
> 
> For cross-compiling, you can set CROSS_COMPILE via the environment
> variable, but it is better to set it automatically - set it to
> ${DEB_HOST_GNU_TYPE}- if we are cross-compiling but not from the top
> Makefile.
> 
> The generated source package may be carried to a different build
> environment, which may have a different compiler installed.
> Run olddefconfig first to set new CONFIG options to their default
> values without prompting.
> 
> Take KERNELRELEASE and KBUILD_BUILD_VERSION from the version field of
> debian/changelog in case it is updated afterwards.

I just arrived to this patch when trying to update the kernel for SOF
from 6.2.0 base to 6.3.0-rc1:
https://github.com/thesofproject/linux/pull/4223#issuecomment-1459997676

Our CI is building a kernel deb package from PRs to test with this command:
make bindeb-pkg LOCALVERSION=-$PRIDV-default KDEB_PKGVERSION=$(make
kernelversion)-$GITSHA

The files, directories and the name of the deb package follows the rule
set up by scripts/setlocalversion, taking into account the LOCALVERSION,
CONFIG_LOCALVERSION and CONFIG_LOCALVERSION_AUTO, but the built kernel
is using the version derived from KDEB_PKGVERSION and the system is not
able to boot up since the modules are in a different directory then they
should be.

Something like this:
make bindeb-pkg LOCALVERSION=-testbuild
vmlinuz-6.3.0-rc1-testbuild-05827-g863ad81a6aa9-dirty
/lib/modules/6.3.0-rc1-testbuild-05827-g863ad81a6aa9-dirty/

strings vmlinuz-6.3.0-rc1-testbuild-05827-g863ad81a6aa9-dirty | grep 6.3
6.3.0-rc1-testbuild-05827-g863ad81a6aa9-dirty

Then with the KDEB_PKGVERSION:
make bindeb-pkg LOCALVERSION=-testbuild KDEB_PKGVERSION=$(make
kernelversion)-notworking
vmlinuz-6.3.0-rc1-testbuild-05827-g863ad81a6aa9-dirty
/lib/modules/6.3.0-rc1-testbuild-05827-g863ad81a6aa9-dirty/

strings vmlinuz-6.3.0-rc1-testbuild-05827-g863ad81a6aa9-dirty | grep 6.3
6.3.0-rc1

in this case modprobe will not find the modules, it is looking for them
under /lib/modules/6.3.0-rc1

Reverting this patch makes the created  deb package usable, the system
is bootable.

We use the LOCALVERSION to feed in PR inforamtion and the
KDEB_PKGVERSION is used fro additional information, like build ID.

Do you have any suggestion on how to get the functionality back or we
must stop using the KDEB_PKGVERSION altogether?

Thank you,
-- 
Péter

> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> Changes in v6:
>   - New patch
> 
>  scripts/package/deb-build-option | 16 ++++++++++++++++
>  scripts/package/mkdebian         |  9 ++++-----
>  2 files changed, 20 insertions(+), 5 deletions(-)
>  create mode 100755 scripts/package/deb-build-option
> 
> diff --git a/scripts/package/deb-build-option b/scripts/package/deb-build-option
> new file mode 100755
> index 000000000000..b079b0d121d4
> --- /dev/null
> +++ b/scripts/package/deb-build-option
> @@ -0,0 +1,16 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +# Set up CROSS_COMPILE if we are cross-compiling, but not called from the
> +# kernel toplevel Makefile
> +if [ -z "${CROSS_COMPILE}${cross_compiling}" -a "${DEB_HOST_ARCH}" != "${DEB_BUILD_ARCH}" ]; then
> +	echo CROSS_COMPILE=${DEB_HOST_GNU_TYPE}-
> +fi
> +
> +version=$(dpkg-parsechangelog -S Version)
> +version_upstream="${version%-*}"
> +debian_revision="${version#${version_upstream}}"
> +debian_revision="${debian_revision#*-}"
> +
> +echo KERNELRELEASE=${version_upstream}
> +echo KBUILD_BUILD_VERSION=${debian_revision}
> diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
> index eef20d5dc288..f74380036bb5 100755
> --- a/scripts/package/mkdebian
> +++ b/scripts/package/mkdebian
> @@ -90,10 +90,8 @@ rm -rf debian
>  version=$KERNELRELEASE
>  if [ -n "$KDEB_PKGVERSION" ]; then
>  	packageversion=$KDEB_PKGVERSION
> -	revision=${packageversion##*-}
>  else
> -	revision=$($srctree/init/build-version)
> -	packageversion=$version-$revision
> +	packageversion=$version-$($srctree/init/build-version)
>  fi
>  sourcename=${KDEB_SOURCENAME:-linux-upstream}
>  
> @@ -244,8 +242,9 @@ srctree ?= .
>  
>  build-indep:
>  build-arch:
> -	\$(MAKE) KERNELRELEASE=${version} ARCH=${ARCH} \
> -	KBUILD_BUILD_VERSION=${revision} -f \$(srctree)/Makefile
> +	\$(MAKE) -f \$(srctree)/Makefile ARCH=${ARCH} \
> +	\$(shell \$(srctree)/scripts/package/deb-build-option) \
> +	olddefconfig all
>  
>  build: build-arch
>  

-- 
Péter
