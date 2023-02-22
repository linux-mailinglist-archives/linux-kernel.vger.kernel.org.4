Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0492169F9B7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 18:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjBVRLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 12:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjBVRLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 12:11:20 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3974A23322;
        Wed, 22 Feb 2023 09:11:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 985BCCE1DF0;
        Wed, 22 Feb 2023 17:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC35C433EF;
        Wed, 22 Feb 2023 17:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677085875;
        bh=4sGn3LZFddbDjgW7sklcZGxfWyx4lt6W3QkHf/G2mcQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hlpkfE3LVCZLran1cNtI2bXRPA0GIFK84E06RFIZBIGXkzd64tx+xyLgZoQp0MA8w
         omFi9+anIRGoqpDY1wrhypPVRnpJw/TR4eBSMYOTX8OJxbwEm3n6dd/Az0i6ADkK/s
         9r+aLIWd4+FJJ9t83UReRHUb90nf6teGV2ztTNdeWGbIHVKd0AbWG1vmvMb9vKI/3r
         7QA80wDpiXxTc/iY8VOs/oiz3IcFuAEHKL/XcW1LfZCvuYK2KixFS1PuyqEYlA51vP
         CLNm7rU2LE7skcig9MBt1GdMJshOOB/i+QI7NWA6mb4L4oclKMiE1fe9R5KrRdI2BT
         9hzXWoCQPpYDw==
Date:   Wed, 22 Feb 2023 10:11:13 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH] kbuild: rpm-pkg: remove unneeded KERNELRELEASE from
 modules/headers_install
Message-ID: <Y/ZMsX2gtnUZXlal@dev-arch.thelio-3990X>
References: <20230222144730.3813421-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222144730.3813421-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 11:47:29PM +0900, Masahiro Yamada wrote:
> There is no need to pass KERNELRELEASE to installation targets.
> 
> KERNELRELEASE used for building the kernel is saved in
> include/config/kernel.release.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> 
>  scripts/package/mkspec | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> index 83a64d9d7372..3c550960dd39 100755
> --- a/scripts/package/mkspec
> +++ b/scripts/package/mkspec
> @@ -99,8 +99,8 @@ $S
>  	%else
>  	cp \$($MAKE -s image_name) %{buildroot}/boot/vmlinuz-$KERNELRELEASE
>  	%endif
> -$M	$MAKE %{?_smp_mflags} KERNELRELEASE=$KERNELRELEASE INSTALL_MOD_PATH=%{buildroot} modules_install
> -	$MAKE %{?_smp_mflags} KERNELRELEASE=$KERNELRELEASE INSTALL_HDR_PATH=%{buildroot}/usr headers_install
> +$M	$MAKE %{?_smp_mflags} INSTALL_MOD_PATH=%{buildroot} modules_install
> +	$MAKE %{?_smp_mflags} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
>  	cp System.map %{buildroot}/boot/System.map-$KERNELRELEASE
>  	cp .config %{buildroot}/boot/config-$KERNELRELEASE
>  $S$M	rm -f %{buildroot}/lib/modules/$KERNELRELEASE/build
> -- 
> 2.34.1
> 
