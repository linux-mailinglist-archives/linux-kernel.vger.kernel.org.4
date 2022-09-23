Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466935E80C8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbiIWReJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiIWReI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:34:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C5875FC6;
        Fri, 23 Sep 2022 10:34:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3AD0B839A7;
        Fri, 23 Sep 2022 17:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B088C433C1;
        Fri, 23 Sep 2022 17:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663954444;
        bh=FiCQ39KpHYBHnMz5U2BvF3FQdfKbQciCmb1jqa2PQws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WO/8o2Z6Og+SP3LSp2vHjP7PVXf7mNszKQ/YTCYsA7Ia9xk7N0MHAqnsoyegvpSqP
         UP+Tv/+6et8I1WuhRHmkDLWPDptMtrdlmP28wGfu7mTDKvi46oMzIVA1RGCNj/iQWM
         1GJZeWNQBoBaMhZc5CAJQS3Sk31Wex+xU+fxhawsINTSrbDGdfiW3tTOoYmj8igo8t
         s9ysMjZVTL8lJOmFvMqgYxxvDkCOE6h/ilR9hvL/YBp9EuX0lvQ2XsRjAtTyIEfpK4
         Ez6tLBSjI4qyhHaXPbR4UHkX01zIiYx096XEpON2FXEoCwamRXpDBXpEpr8mOib5oj
         SZZ7jqiZG6TeQ==
Date:   Fri, 23 Sep 2022 10:34:02 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Zack Rusin <zackr@vmware.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: Add an option to skip vmlinux.bz2 in the rpm's
Message-ID: <Yy3uCtztO3uDgecE@dev-arch.thelio-3990X>
References: <20220922184525.3021522-1-zack@kde.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922184525.3021522-1-zack@kde.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 02:45:25PM -0400, Zack Rusin wrote:
> From: Zack Rusin <zackr@vmware.com>
> 
> The debug vmlinux takes up the vast majority of space in the built
> rpm's. While having it enabled by default is a good idea because it
> makes debugging easier, having an option to skip it is highly valuable
> for CI/CD systems where small packages are a lot easier to deal with
> e.g. kernel rpm built using binrpm-pkg on Fedora 36 default 5.19.8 kernel
> config and localmodconfig goes from 255MB to 65MB which is an almost
> 4x difference.
> 
> To skip adding vmlinux.bz2 to the built rpm add SKIP_RPM_VMLINUX
> environment variable which when set to "y", e.g. via
> "SKIP_RPM_VMLINUX=y make binrpm-pkg" won't include vmlinux.bz2 in the
> built rpm.
> 
> Signed-off-by: Zack Rusin <zackr@vmware.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: linux-kbuild@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Yes please, this seems to slightly improve the time spent actually
building and installing the package.

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  scripts/package/mkspec | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> index 7c477ca7dc98..5a71fc0852b0 100755
> --- a/scripts/package/mkspec
> +++ b/scripts/package/mkspec
> @@ -23,6 +23,12 @@ else
>  	M=DEL
>  fi
>  
> +if [ "$RPM_SKIP_VMLINUX" = y ]; then
> +	D=DEL
> +else
> +	D=
> +fi
> +
>  if grep -q CONFIG_DRM=y .config; then
>  	PROVIDES=kernel-drm
>  fi
> @@ -94,8 +100,8 @@ $M	$MAKE %{?_smp_mflags} INSTALL_MOD_PATH=%{buildroot} modules_install
>  	$MAKE %{?_smp_mflags} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
>  	cp System.map %{buildroot}/boot/System.map-$KERNELRELEASE
>  	cp .config %{buildroot}/boot/config-$KERNELRELEASE
> -	bzip2 -9 --keep vmlinux
> -	mv vmlinux.bz2 %{buildroot}/boot/vmlinux-$KERNELRELEASE.bz2
> +$D	bzip2 -9 --keep vmlinux
> +$D	mv vmlinux.bz2 %{buildroot}/boot/vmlinux-$KERNELRELEASE.bz2
>  $S$M	rm -f %{buildroot}/lib/modules/$KERNELRELEASE/build
>  $S$M	rm -f %{buildroot}/lib/modules/$KERNELRELEASE/source
>  $S$M	mkdir -p %{buildroot}/usr/src/kernels/$KERNELRELEASE
> -- 
> 2.34.1
> 
> 
