Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5FF6487F5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiLIRtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiLIRtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:49:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D8769332;
        Fri,  9 Dec 2022 09:49:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7286622CF;
        Fri,  9 Dec 2022 17:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04487C433D2;
        Fri,  9 Dec 2022 17:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670608158;
        bh=m6SS2DDS4p6GsaniGyVCYqB96onm+knvX+hrwb8N7qQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V318J8bcBcsnu5gXOqhsDTBA5VnGd3PSACWx7cXJQ6kbjFJkAIf9exb2gnOo+67Q+
         TF+/KjiPIi9WlGS/g0BktJ01BKw3xh6ZqYBzByNEGN/iWotYyezAD6PI2o7lTDKNX9
         amoXxi/jStPoAP3bH/6Ik/HrRyCumdbtZydlKy3e3EmdFnvd3xI2NE+OSWk8HYdLZu
         u6PU7fyZv2d1q8kfhZ7jHTmsHtyTckuVtP8agKTisMHTC2QcZwmIFSgHbKewDT+nrK
         8Jy3PcS82IsJ7qKt7XW78lODIupW4OveP7h7ZiP3045nYBq9Xafukukxho6VE/Lq/I
         A8zypi22RgixQ==
Date:   Fri, 9 Dec 2022 10:49:16 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH 2/2] kbuild: add -Wundef to KBUILD_CPPFLAGS for W=1 builds
Message-ID: <Y5N1HGYyJGgm3qVH@dev-arch.thelio-3990X>
References: <20221206040731.442499-1-masahiroy@kernel.org>
 <20221206040731.442499-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206040731.442499-2-masahiroy@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 01:07:31PM +0900, Masahiro Yamada wrote:
> The use of an undefined macro in an #if directive is warned, but only
> in *.c files. No warning from other files such as *.S, *.lds.S.
> 
> Since -Wundef is a preprocessor-related warning, it should be added to
> KBUILD_CPPFLAGS instead of KBUILD_CFLAGS.
> 
> My previous attempt [1] uncovered several warnings, and could not finish
> fixing them all.
> 
> This commit adds -Wundef to KBUILD_CPPFLAGS for W=1 builds in order to
> block new breakages. (The kbuild test robot tests with W=1)
> 
> We can fix the warnings one by one. After we fix all of them, we can
> make this default in the top Makefile, and remove -Wundef from
> KBUILD_CFLAGS.
> 
> [1]: https://lore.kernel.org/all/20221012180118.331005-2-masahiroy@kernel.org/
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Looks like the robot already found a few so this clearly works as
intended.

> ---
> 
>  scripts/Makefile.extrawarn | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index 6bbba36c5969..40cd13eca82e 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -38,6 +38,7 @@ KBUILD_CFLAGS += -Wno-sign-compare
>  KBUILD_CFLAGS += -Wno-type-limits
>  KBUILD_CFLAGS += -Wno-shift-negative-value
>  
> +KBUILD_CPPFLAGS += -Wundef
>  KBUILD_CPPFLAGS += -DKBUILD_EXTRA_WARN1
>  
>  else
> -- 
> 2.34.1
> 
> 
