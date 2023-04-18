Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9044D6E6C3F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 20:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjDRSjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 14:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjDRSjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 14:39:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139428A78;
        Tue, 18 Apr 2023 11:38:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A207A6157C;
        Tue, 18 Apr 2023 18:38:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3B5C433D2;
        Tue, 18 Apr 2023 18:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681843138;
        bh=yWZFzaHwyCv590iWQSNnSJIy2iMn1qsrmtyHHPDyNjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tTBz5/THNY2r5Qonb0/k6KdIPTIHWgikjyDPzf+X1CICN1lxEdutltpVPJoGX9pjy
         WqKOZpVRZY0q6nJQ3RYe7e/TfBBeAwCx/KAxR0U91xrWyi7lP9XovtLU+NONZAKO+d
         ScD0DiySwUAOGwN6xys/QurCg2R7yD0S+jMz7uXB3EzHsC+hWIXrQxXXdwrh9KYZsb
         hv8zIC7HPIQDTGQheaOg08pro71okyo8+t5cQAkm9ZZACzIDAombvSEk5qM+pAgezg
         Eub6hOrIbap1qAU3ilp1OiP7eZP79jSejWKR3iEkc0RiULl6Fq6pjpvJX0heVd5dnB
         +1GaFzUgj0nIQ==
Date:   Tue, 18 Apr 2023 11:38:56 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH] kbuild: rpm-pkg: remove kernel-drm PROVIDES
Message-ID: <20230418183856.GA2635379@dev-arch.thelio-3990X>
References: <20230417143535.250565-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417143535.250565-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 11:35:35PM +0900, Masahiro Yamada wrote:
> This code was added more than 20 years ago. [1]
> 
> I checked the kernel spec files in Fedora and OpenSUSE, but did not
> see 'kernel-drm'. I do not know if there exists a distro that uses it
> in RPM dependency.
> 
> Remove this, and let's see if somebody complains about it.
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/?id=6d956df7d6b716b28c910c4f5b360c4d44d96c4d
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> 
>  scripts/package/mkspec | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> index fc8ad3fbc0a9..8049f0e2c110 100755
> --- a/scripts/package/mkspec
> +++ b/scripts/package/mkspec
> @@ -28,11 +28,6 @@ else
>  	M=DEL
>  fi
>  
> -if grep -q CONFIG_DRM=y include/config/auto.conf; then
> -	PROVIDES=kernel-drm
> -fi
> -
> -PROVIDES="$PROVIDES kernel-$KERNELRELEASE"
>  __KERNELRELEASE=$(echo $KERNELRELEASE | sed -e "s/-/_/g")
>  EXCLUDES="$RCS_TAR_IGNORE --exclude=*vmlinux* --exclude=*.mod \
>  --exclude=*.o --exclude=*.ko --exclude=*.cmd --exclude=Documentation \
> @@ -55,7 +50,7 @@ sed -e '/^DEL/d' -e 's/^\t*//' <<EOF
>  $S	Source0: linux.tar.gz
>  $S	Source1: config
>  $S	Source2: diff.patch
> -	Provides: $PROVIDES
> +	Provides: kernel-$KERNELRELEASE
>  $S	BuildRequires: bc binutils bison dwarves
>  $S	BuildRequires: (elfutils-libelf-devel or libelf-devel) flex
>  $S	BuildRequires: gcc make openssl openssl-devel perl python3 rsync
> -- 
> 2.37.2
> 
