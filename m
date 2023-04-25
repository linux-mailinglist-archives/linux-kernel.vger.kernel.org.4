Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678EB6EE758
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbjDYSIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbjDYSIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:08:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18F016188;
        Tue, 25 Apr 2023 11:08:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B0306296A;
        Tue, 25 Apr 2023 18:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56927C433D2;
        Tue, 25 Apr 2023 18:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682446085;
        bh=1c/iySntLL2tAru2rg3HGAKk4foULiGQ+TrL9KwD5+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uDhmFSjovHbtIFKGXov8t1lTW+4dGG0CG3nSxoWC/RQqFp7YSHLi4qWsiE3UnCYuI
         6488vGTTBaT1U4zrYgXQHHCXu6fxTt15VGomGs86VEcsObxGRkzoGXsfVluvvCaaH8
         X7N99jhNE+zN3brFB9yaGhQBCKiox17zwXfXVca7jL67goipbcwZypMaaL5izCdEdy
         u/0qzZxHzsTAE6vk8S4hcri6WmAPBgAlrbsdUq17bsdd52QJCSXtB1V29BNhF5rvX4
         AQhEvwWvFTYT8oZ+eOvQIYAyygn3zjUMvvkv6NT3S6S41W4gTmsUuSXkFm+wb7wOtL
         yto/Lc3S+RwkQ==
Date:   Tue, 25 Apr 2023 11:08:02 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH] kbuild: deb-pkg: specify targets in debian/rules as
 .PHONY
Message-ID: <20230425180802.GA2881732@dev-arch.thelio-3990X>
References: <20230425110859.1757001-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425110859.1757001-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 08:08:59PM +0900, Masahiro Yamada wrote:
> If a file with the same name exists, the target is not run.
> 
> For example, the following command fails.
> 
>   $ make O=build-arch bindeb-pkg
>     [ snip ]
>   sed: can't read modules.order: No such file or directory
>   make[6]: *** [../Makefile:1577: __modinst_pre] Error 2
>   make[5]: *** [../scripts/Makefile.package:150: intdeb-pkg] Error 2
>   make[4]: *** [../Makefile:1657: intdeb-pkg] Error 2
>   make[3]: *** [debian/rules:14: binary-arch] Error 2
>   dpkg-buildpackage: error: debian/rules binary subprocess returned exit status 2
>   make[2]: *** [../scripts/Makefile.package:139: bindeb-pkg] Error 2
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> 
>  scripts/package/mkdebian | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
> index a4c2c2276223..b6cb95473548 100755
> --- a/scripts/package/mkdebian
> +++ b/scripts/package/mkdebian
> @@ -269,6 +269,8 @@ cat <<EOF > debian/rules
>  srctree ?= .
>  KERNELRELEASE = ${KERNELRELEASE}
>  
> +.PHONY: clean build build-arch build-indep binary binary-arch binary-indep
> +
>  build-indep:
>  build-arch:
>  	\$(MAKE) -f \$(srctree)/Makefile ARCH=${ARCH} \
> -- 
> 2.37.2
> 
