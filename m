Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1C76B7607
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjCMLcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjCMLcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:32:01 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11CD5ADE1;
        Mon, 13 Mar 2023 04:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678707085; x=1710243085;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=I7iSicHuyxxaF0RVaV8snquWL3/pD7+lY3Rh4oeQyv8=;
  b=oI73gp+AmEBseu7ahLk4wUTM/EvQFaA6zbbxKqpryzxCxSobLH3ex65+
   SD+kkRwe9/G7ao2AXoimuIWDn9y/i+09sxjoAlFLMGRSztOWxRaZXlobY
   v5n4CN8ZlrxY2DtVMDiCi3OjNwrIi8Iwss2eWBTvi6/kb6iE3WjkQmPzJ
   3Nl9N9bh0rMKNXrSMugeLOC9zTEgZr/nLoMBjc99qFluDNcdzjUTXriHQ
   QqjWcHE2/LSRjf/EAb29HJ0pPLJ3lIqhRyuC1v34P2TgC3D819vpvxpzD
   3/rr7XwXd01Yr9oz5Knl8rMo6SUvh+2vnsDQz4//Huct6ECDr/3AP6bYJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="337143322"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="337143322"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 04:30:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="681005614"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="681005614"
Received: from tchambon-mobl.ger.corp.intel.com (HELO [10.249.43.68]) ([10.249.43.68])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 04:30:56 -0700
Message-ID: <8abcae28-f38c-06ca-22df-30669161855e@linux.intel.com>
Date:   Mon, 13 Mar 2023 13:31:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH 2/6] kbuild: deb-pkg: do not take KERNELRELEASE from the
 source version
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
References: <20230312200731.599706-1-masahiroy@kernel.org>
 <20230312200731.599706-3-masahiroy@kernel.org>
Content-Language: en-US
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20230312200731.599706-3-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/03/2023 22:07, Masahiro Yamada wrote:
> KERNELRELEASE does not need to match the package version in changelog.
> Rather, it conventially matches what is called 'ABINAME', which is a
> part of the binary package names.
> 
> Both are the same by default, but the former might be overridden by
> KDEB_PKGVERSION. In this case, the resulting package would not boot
> because /lib/modules/$(uname -r) does not point the module directory.
> 
> Partially revert 3ab18a625ce4 ("kbuild: deb-pkg: improve the usability
> of source package").

Thank you, I have tested locally and in our CI, bindeb-pkg target works
again.

Tested-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

> 
> Reported-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Fixes: 3ab18a625ce4 ("kbuild: deb-pkg: improve the usability of source package")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/package/deb-build-option | 9 ++++-----
>  scripts/package/mkdebian         | 1 +
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/scripts/package/deb-build-option b/scripts/package/deb-build-option
> index b079b0d121d4..bd53624318f2 100755
> --- a/scripts/package/deb-build-option
> +++ b/scripts/package/deb-build-option
> @@ -8,9 +8,8 @@ if [ -z "${CROSS_COMPILE}${cross_compiling}" -a "${DEB_HOST_ARCH}" != "${DEB_BUI
>  fi
>  
>  version=$(dpkg-parsechangelog -S Version)
> -version_upstream="${version%-*}"
> -debian_revision="${version#${version_upstream}}"
> -debian_revision="${debian_revision#*-}"
> +debian_revision="${version##*-}"
>  
> -echo KERNELRELEASE=${version_upstream}
> -echo KBUILD_BUILD_VERSION=${debian_revision}
> +if [ "${version}" != "${debian_revision}" ]; then
> +	echo KBUILD_BUILD_VERSION=${debian_revision}
> +fi
> diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
> index c6fbfb9f74ba..31b050368cd0 100755
> --- a/scripts/package/mkdebian
> +++ b/scripts/package/mkdebian
> @@ -244,6 +244,7 @@ KERNELRELEASE = ${KERNELRELEASE}
>  build-indep:
>  build-arch:
>  	\$(MAKE) -f \$(srctree)/Makefile ARCH=${ARCH} \
> +	KERNELRELEASE=\$(KERNELRELEASE) \
>  	\$(shell \$(srctree)/scripts/package/deb-build-option) \
>  	olddefconfig all
>  

-- 
Péter
