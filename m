Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E1E6462A1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 21:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiLGUqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 15:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLGUqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 15:46:45 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE2258BF4;
        Wed,  7 Dec 2022 12:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670446004; x=1701982004;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=eTDbxYWR4ZutHid/GJ7kKhEcbnpjoulOObTQVkZ7K50=;
  b=LyD3XsVRBaVBqRqnRlRBhDPg16G3t1089KIPF3faMTwO7VuiJG8QmDBm
   L6ovRkdGFeLNGOm/A315pJAYVff+26IzH1upPF8AwPsXQzju3Op9IO6WX
   kbGETnzJgmf1uPXQQTod2UeQ+aNGKuoff2eHpBbyDTt34KA+QUELg8od3
   KQaAdfwHLAR5X8nkK17plqChQtVZTTAQLvRcURy/qqvSK8/UBcAj4MZYh
   AcORv72qzTFgTWvgviKukr9XKHZi2s+xe2QwjGT+yD32JUU7hzXKSP3fj
   /AQI1IkmkF/p30b4W+TxwRWh3KUHOGdn56AE/sLykbrXBGSoBBpv2g5qr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="297355962"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="297355962"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 12:46:43 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="975597739"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="975597739"
Received: from fbackhou-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.36.192])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 12:46:40 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Carlos Bilbao <carlos.bilbao@amd.com>, ojeda@kernel.org,
        corbet@lwn.net, akiyks@gmail.com, rdunlap@infradead.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        konstantin@linuxfoundation.org,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: Re: [PATCH v4 1/2] docs: Move rustdoc output, cross-reference it
In-Reply-To: <20221207173053.1463800-2-carlos.bilbao@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20221207173053.1463800-1-carlos.bilbao@amd.com>
 <20221207173053.1463800-2-carlos.bilbao@amd.com>
Date:   Wed, 07 Dec 2022 22:46:37 +0200
Message-ID: <87cz8v0wnm.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Dec 2022, Carlos Bilbao <carlos.bilbao@amd.com> wrote:
> Generate rustdoc documentation with the rest of subsystem's documentation
> in Documentation/output. Add a cross reference to the generated rustdoc in
> Documentation/rust/index.rst if Sphinx target rustdoc is set.
>
> Reviewed-by: Akira Yokosawa <akiyks@gmail.com>
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>  Documentation/rust/index.rst |  8 ++++++++
>  rust/Makefile                | 15 +++++++++------
>  2 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/rust/index.rst b/Documentation/rust/index.rst
> index 4ae8c66b94fa..4fc97c1eb1d1 100644
> --- a/Documentation/rust/index.rst
> +++ b/Documentation/rust/index.rst
> @@ -6,6 +6,14 @@ Rust
>  Documentation related to Rust within the kernel. To start using Rust
>  in the kernel, please read the quick-start.rst guide.
>  
> +.. only:: rustdoc
> +
> +	You can also browse `rustdoc documentation <rustdoc/kernel/index.html>`_.
> +
> +.. only:: not rustdoc
> +
> +	This documentation does not include rustdoc generated information.
> +

FWIW, this and the -t rustdoc part in patch 2/2 look good to me.

BR,
Jani.


>  .. toctree::
>      :maxdepth: 1
>  
> diff --git a/rust/Makefile b/rust/Makefile
> index 7700d3853404..080c07048065 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -1,5 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> +# Where to place rustdoc generated documentation
> +RUSTDOC_OUTPUT = $(objtree)/Documentation/output/rust/rustdoc
> +
>  always-$(CONFIG_RUST) += target.json
>  no-clean-files += target.json
>  
> @@ -58,7 +61,7 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
>  	OBJTREE=$(abspath $(objtree)) \
>  	$(RUSTDOC) $(if $(rustdoc_host),$(rust_common_flags),$(rust_flags)) \
>  		$(rustc_target_flags) -L$(objtree)/$(obj) \
> -		--output $(objtree)/$(obj)/doc \
> +		--output $(RUSTDOC_OUTPUT) \
>  		--crate-name $(subst rustdoc-,,$@) \
>  		@$(objtree)/include/generated/rustc_cfg $<
>  
> @@ -75,15 +78,15 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
>  # and then retouch the generated files.
>  rustdoc: rustdoc-core rustdoc-macros rustdoc-compiler_builtins \
>      rustdoc-alloc rustdoc-kernel
> -	$(Q)cp $(srctree)/Documentation/images/logo.svg $(objtree)/$(obj)/doc
> -	$(Q)cp $(srctree)/Documentation/images/COPYING-logo $(objtree)/$(obj)/doc
> -	$(Q)find $(objtree)/$(obj)/doc -name '*.html' -type f -print0 | xargs -0 sed -Ei \
> +	$(Q)cp $(srctree)/Documentation/images/logo.svg $(RUSTDOC_OUTPUT)
> +	$(Q)cp $(srctree)/Documentation/images/COPYING-logo $(RUSTDOC_OUTPUT)
> +	$(Q)find $(RUSTDOC_OUTPUT) -name '*.html' -type f -print0 | xargs -0 sed -Ei \
>  		-e 's:rust-logo\.svg:logo.svg:g' \
>  		-e 's:rust-logo\.png:logo.svg:g' \
>  		-e 's:favicon\.svg:logo.svg:g' \
>  		-e 's:<link rel="alternate icon" type="image/png" href="[./]*favicon-(16x16|32x32)\.png">::g'
>  	$(Q)echo '.logo-container > img { object-fit: contain; }' \
> -		>> $(objtree)/$(obj)/doc/rustdoc.css
> +		>> $(RUSTDOC_OUTPUT)/rustdoc.css
>  
>  rustdoc-macros: private rustdoc_host = yes
>  rustdoc-macros: private rustc_target_flags = --crate-type proc-macro \
> @@ -141,7 +144,7 @@ quiet_cmd_rustdoc_test = RUSTDOC T $<
>  		@$(objtree)/include/generated/rustc_cfg \
>  		$(rustc_target_flags) $(rustdoc_test_target_flags) \
>  		--sysroot $(objtree)/$(obj)/test/sysroot $(rustdoc_test_quiet) \
> -		-L$(objtree)/$(obj)/test --output $(objtree)/$(obj)/doc \
> +		-L$(objtree)/$(obj)/test --output $(RUSTDOC_OUTPUT) \
>  		--crate-name $(subst rusttest-,,$@) $<
>  
>  # We cannot use `-Zpanic-abort-tests` because some tests are dynamic,

-- 
Jani Nikula, Intel Open Source Graphics Center
