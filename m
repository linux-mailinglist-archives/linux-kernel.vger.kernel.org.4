Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECD5658815
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 01:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbiL2A0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 19:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbiL2A0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 19:26:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44519FCE;
        Wed, 28 Dec 2022 16:26:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79524615FC;
        Thu, 29 Dec 2022 00:26:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42548C433EF;
        Thu, 29 Dec 2022 00:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672273598;
        bh=nmAr+L0kfJbSocsWpY1frx3crxtESMYLmdBlJdum37w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sbZJST4qxzwbpgTahPc1g3HxfoOnBaq5gmoLL6yCMuTyKKw9zTt9bLhWdGhGLKVly
         M8/TL3EGVZa5p0KAVSmQLJNvRULw3bbtqnvBjyV3U0VJUOj9sjTiK76A12tBYpLRyT
         IzxUeRQ4xyDeTJsg/5seThrOSRMUq7V6k0x/PCmi9bwRE87U12tyXIcawKcr7mKvHh
         QvXHVYiZyuDu/03RqQC6dKKJK5O+7Fm3tr1a2gcKVeeOHKI6NeFgAXGmiM83WXUnBc
         crGuaGYf8m0TxET0tU11WdgD7rUTneoFb9OmV2yptOVg3R83nysFtKukDXntV9tL/U
         qg9D9MDcz2+tw==
Date:   Wed, 28 Dec 2022 17:26:36 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Ivan Vecera <ivecera@redhat.com>,
        Jonathan Toppins <jtoppins@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        =?iso-8859-1?B?zfFpZ28=?= Huguet <ihuguet@redhat.com>
Subject: Re: [PATCH] kbuild: rpm-pkg: add libelf-devel as alternative for
 BuildRequires
Message-ID: <Y6zevMoJOZh9Ouy3@dev-arch.thelio-3990X>
References: <20221228191014.659746-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221228191014.659746-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 04:10:14AM +0900, Masahiro Yamada wrote:
> Guoqing Jiang reports that openSUSE cannot compile the kernel rpm due
> to "BuildRequires: elfutils-libelf-devel" added by commit 8818039f959b
> ("kbuild: add ability to make source rpm buildable using koji").
> The relevant package name in openSUSE is libelf-devel.
> 
> Add it an alternative package.
> 
> BTW, if it is impossible to solve the build requirement, the final
> resort would be:
> 
>     $ make RPMOPTS=--nodeps rpm-pkg
> 
> This passes --nodeps to the rpmbuild command so it will not verify
> build dependencies. This is useful to test rpm builds on non-rpm
> system. On Debian/Ubuntu, for example, you can install rpmbuild by
> 'apt-get install rpm'.
> 
> NOTE1:
>   Likewise, it is possible to bypass the build dependency check for
>   debian package builds:
> 
>     $ make DPKG_FLAGS=-d deb-pkg
> 
> NOTE2:
>   The 'or' operator is supported since RPM 4.13. So, old distros such
>   as CentOS 7 will break. I suggest installing newer rpmbuild in such
>   cases.
> 
> Link: https://lore.kernel.org/linux-kbuild/ee227d24-9c94-bfa3-166a-4ee6b5dfea09@linux.dev/T/#u
> Fixes: 8818039f959b ("kbuild: add ability to make source rpm buildable using koji")
> Reported-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> 
>  scripts/package/mkspec | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> index dda00a948a01..adab28fa7f89 100755
> --- a/scripts/package/mkspec
> +++ b/scripts/package/mkspec
> @@ -51,7 +51,8 @@ sed -e '/^DEL/d' -e 's/^\t*//' <<EOF
>  	URL: https://www.kernel.org
>  $S	Source: kernel-$__KERNELRELEASE.tar.gz
>  	Provides: $PROVIDES
> -$S	BuildRequires: bc binutils bison dwarves elfutils-libelf-devel flex
> +$S	BuildRequires: bc binutils bison dwarves
> +$S	BuildRequires: (elfutils-libelf-devel or libelf-devel) flex
>  $S	BuildRequires: gcc make openssl openssl-devel perl python3 rsync
>  
>  	# $UTS_MACHINE as a fallback of _arch in case
> -- 
> 2.34.1
> 
