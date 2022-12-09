Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBDC6487F3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiLIRr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiLIRrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:47:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3BB1F9DB;
        Fri,  9 Dec 2022 09:47:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 985B4B828D2;
        Fri,  9 Dec 2022 17:47:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0730C433D2;
        Fri,  9 Dec 2022 17:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670608069;
        bh=y8+bQeEBh4EKlM4FuSR/xglLOJLIIH/+Cc2XHBl/fgE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cYOmfKaNQQV2G9IUpO6ceVZe2H5bWOfZa51xI+25npPXn8bf00G9IQbT7a0h8XY1E
         gwtz547yjfdpaMIY5hFjMQ98SRR17sfNPzt2nFtmdAnpPQwD/RSiOccnvUt5sM0WYC
         P/2xWhSaOo9ck6kuAL+urgQPL6qZZ+LATTKsxYS8qbHPIHCcVsHAAa05PrJIoQ3xm6
         HuR89UQ27UczlzgLdomnfsPmHO55mhyu6oLClvKurFAbgsNrBorxSnngGlykv5DRmw
         0REd1p5dklVhgmrIMPadZnvWS8yjcWdmFhsrirP9akAGavZ5QkcSNoYX2+YeqEq4zP
         X6y6PzAVZt6UQ==
Date:   Fri, 9 Dec 2022 10:47:47 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH 1/2] kbuild: move -Werror from KBUILD_CFLAGS to
 KBUILD_CPPFLAGS
Message-ID: <Y5N0wwIkoHuPbcwU@dev-arch.thelio-3990X>
References: <20221206040731.442499-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206040731.442499-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 01:07:30PM +0900, Masahiro Yamada wrote:
> CONFIG_WERROR turns warnings into errors, which happens only for *.c
> files because -Werror is added to KBUILD_CFLAGS.
> 
> Adding it to KBUILD_CPPFLAGS makes more sense because preprocessors
> understand the -Werror option.
> 
> For example, you can put a #warning directive in any preprocessed code.
> 
>     warning: #warning "this is a warning message" [-Wcpp]
> 
> If -Werror is added, it is promoted to an error.
> 
>     error: #warning "this is a warning message" [-Werror=cpp]
> 
> This commit moves -Werror to KBUILD_CPPFLAGS so it works in the same way
> for *.c, *.S, *.lds.S or whatever needs preprocessing.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

This seems reasonable, as people should not really be polluting the
build with messages through pragmas anyways, since the build should
always be clean.

> ---
> 
>  Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 53fa1a9fba8a..f84b57910667 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -869,7 +869,8 @@ stackp-flags-$(CONFIG_STACKPROTECTOR_STRONG)      := -fstack-protector-strong
>  
>  KBUILD_CFLAGS += $(stackp-flags-y)
>  
> -KBUILD_CFLAGS-$(CONFIG_WERROR) += -Werror
> +KBUILD_CPPFLAGS-$(CONFIG_WERROR) += -Werror
> +KBUILD_CPPFLAGS += $(KBUILD_CPPFLAGS-y)
>  KBUILD_CFLAGS-$(CONFIG_CC_NO_ARRAY_BOUNDS) += -Wno-array-bounds
>  
>  KBUILD_RUSTFLAGS-$(CONFIG_WERROR) += -Dwarnings
> -- 
> 2.34.1
> 
> 
