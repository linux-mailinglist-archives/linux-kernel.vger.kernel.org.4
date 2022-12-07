Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6530A645DCB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 16:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiLGPmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 10:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLGPmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 10:42:49 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D30212096;
        Wed,  7 Dec 2022 07:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670427768; x=1701963768;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S2oZsetW7iPEBVhqx/feOGn0yhjsgnW9M1+nukZd+TM=;
  b=PzDc1H/zWZkgTjM0KxkUQTgaTOYlAzCNZIAl9j5F1Mlu+Ro5CQhiNpSl
   C6WUOapgX9H6+gyJmLdjEZNmsW4R7G3Xh67ZvbAJNbU2Rswg+iMuobyzL
   brOYaECsbUXBbtXZR3//8ruL7RZec6f4SCjifwn9k6Ig9NlJQZiaTtvlr
   T6gxQInO2kNQLrYY0qQvJE0JCTEYKIzVUEyhiPi05Q6gCKTBwGn0C1WQS
   p2haVA/3bGw2OIEIposjuXErC+yaP3lteYR9ywfs4ztO2LTtezYKCHpih
   5xke7Fmj0Km/ybMSzX13pGWuizneggiVHe9o9YT93na11xNS1GDDNkcdU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="381214559"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="381214559"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 07:42:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="820996925"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="820996925"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga005.jf.intel.com with ESMTP; 07 Dec 2022 07:42:41 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 2B7FgeKK020747;
        Wed, 7 Dec 2022 15:42:40 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v3 3/5] kbuild: add read-file macro
Date:   Wed,  7 Dec 2022 16:40:44 +0100
Message-Id: <20221207154044.2181347-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221126225624.751661-3-masahiroy@kernel.org>
References: <20221126225624.751661-1-masahiroy@kernel.org> <20221126225624.751661-3-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 27 Nov 2022 07:56:22 +0900

> Since GNU Make 4.2, $(file ...) supports the read operater '<', which
> is useful to read a file without forking any process. No warning is
> shown even if the input file is missing.
> 
> For older Make versions, it falls back to the cat command.
> 
> The added ifeq will break when GNU Make 4.10 or 10.0 is released.
> It will take a long time if the current release pace continues.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
> ---
> 
> (no changes since v1)
> 
>  Makefile                  |  2 +-
>  scripts/Kbuild.include    | 15 +++++++++++++++
>  scripts/Makefile.modfinal |  2 +-
>  scripts/Makefile.modinst  |  2 +-
>  4 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index eb80332f7b51..60ce9dcafc72 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -369,7 +369,7 @@ else # !mixed-build
>  include $(srctree)/scripts/Kbuild.include
>  
>  # Read KERNELRELEASE from include/config/kernel.release (if it exists)
> -KERNELRELEASE = $(shell cat include/config/kernel.release 2> /dev/null)
> +KERNELRELEASE = $(call read-file, include/config/kernel.release)
>  KERNELVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
>  export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION
>  
> diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> index 4b8cf464b53b..55c2243f91c8 100644
> --- a/scripts/Kbuild.include
> +++ b/scripts/Kbuild.include
> @@ -10,6 +10,10 @@ empty   :=
>  space   := $(empty) $(empty)
>  space_escape := _-_SPACE_-_
>  pound := \#
> +define newline
> +
> +
> +endef
>  
>  ###
>  # Comparison macros.
> @@ -55,6 +59,17 @@ stringify = $(squote)$(quote)$1$(quote)$(squote)
>  kbuild-dir = $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
>  kbuild-file = $(or $(wildcard $(kbuild-dir)/Kbuild),$(kbuild-dir)/Makefile)
>  
> +###
> +# Read a file, replacing newlines with spaces
> +#
> +# This ifeq will break when GNU Make 4.10 is released.
> +# Remove this conditional until then.
> +ifeq ($(call test-ge, $(MAKE_VERSION), 4.2),y)
> +read-file = $(subst $(newline),$(space),$(file < $1))
> +else
> +read-file = $(shell cat $1 2>/dev/null)
> +endif
> +

Great stuff. Used it in my upcoming series to simplify things, works
as expected.

sed-syms = $(subst $(space),\|,$(foreach file,$(sym-files-y),$(call read-file,$(file))))

The only thing that came to my mind while I was implementing the
oneliner above: maybe add ability to read multiple files? For now,
I used a foreach, could it be somehow incorporated into read-file
already?

Besides that:

Reviewed-and-tested-by: Alexander Lobakin <alexandr.lobakin@intel.com>

>  ###
>  # Easy method for doing a status message
>         kecho := :
> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index 25bedd83644b..7252f6cf7837 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
> @@ -13,7 +13,7 @@ include $(srctree)/scripts/Kbuild.include
>  include $(srctree)/scripts/Makefile.lib
>  
>  # find all modules listed in modules.order
> -modules := $(sort $(shell cat $(MODORDER)))
> +modules := $(sort $(call read-file, $(MODORDER)))
>  
>  __modfinal: $(modules)
>  	@:
> diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
> index a4c987c23750..509d424dbbd2 100644
> --- a/scripts/Makefile.modinst
> +++ b/scripts/Makefile.modinst
> @@ -9,7 +9,7 @@ __modinst:
>  include include/config/auto.conf
>  include $(srctree)/scripts/Kbuild.include
>  
> -modules := $(sort $(shell cat $(MODORDER)))
> +modules := $(sort $(call read-file, $(MODORDER)))
>  
>  ifeq ($(KBUILD_EXTMOD),)
>  dst := $(MODLIB)/kernel
> -- 
> 2.34.1

Thanks,
Olek
