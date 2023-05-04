Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCB06F7830
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 23:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjEDVcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 17:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjEDVcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 17:32:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16F411544;
        Thu,  4 May 2023 14:32:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 374FA639AC;
        Thu,  4 May 2023 21:32:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2260EC433EF;
        Thu,  4 May 2023 21:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683235968;
        bh=P/MeTcvt656SH/EiSEp3jgkQwUVnSMd7oAuct3X6qQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JCsVZPTK2NWH0hXev0nmFSS+FTlsAoL2+G9BoGvu61nr9dJ6HGyvLCKX0ZM/uXt97
         jnHyFPKSr7EaeJ/7djXBFBASlhCKsil04HhcPlGNa8RVvB9y6F8Gm7JMz0dELbHFon
         2Y1bmOQ/kx+eFE+VWUqpUj8DX96Xknz2W4zY6CdWlhNOYCEh9L8RtHU4MyfyhPO6Hc
         M12/rTXlvpl31Ak2JJC24rx/fjHbLLk8PwxOn7XggExS5cF3nZNasJiild0aLogxLv
         41WmRi3z4Wb2bLJ7ssXRshCGSOVt3Ozfimvr4KPW/OG+pxXNgNoIjbdb4d/Ozi+SQq
         VYkcPusg3NlFw==
Date:   Thu, 4 May 2023 14:32:46 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Ahmed S. Darwish" <darwi@linutronix.de>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kbuild@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] scripts/tags.sh: Fix gtags generation for O=
 kernel builds
Message-ID: <20230504213246.GB1666363@dev-arch.thelio-3990X>
References: <20230504201833.202494-1-darwi@linutronix.de>
 <20230504201833.202494-2-darwi@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504201833.202494-2-darwi@linutronix.de>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 10:18:33PM +0200, Ahmed S. Darwish wrote:
> gtags considers any file outside of its current working directory
> "outside the source tree" and refuses to index it.
> 
> For O= kernel builds, scripts/tags.sh invokes gtags with the current
> working directory set to ${O}. This leads to gtags ignoring the entire
> kernel source and generating an empty index.
> 
> For O= builds, set gtags' working directory to the kernel source tree
> and explicitly set its output path through parameters instead.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  scripts/tags.sh | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/tags.sh b/scripts/tags.sh
> index ea31640b2671..1a6db535503b 100755
> --- a/scripts/tags.sh
> +++ b/scripts/tags.sh
> @@ -131,7 +131,14 @@ docscope()
>  
>  dogtags()
>  {
> -	all_target_sources | gtags -i -f -
> +	# gtags refuses to index any file outside of the current working
> +	# directory. For O= builds, set the current working directory to
> +	# the kernel source tree and the output tags dir to ${O}.
> +	suffixparams=
> +	if [ -v O ]; then

I think

  if [ -n "$O" ]; then

would match the style preferred by Kbuild (though that is usually for
portability sake, which probably does not matter here since bash is
explicitly requested). Perhaps not worth addressing if there is no other
reason for a v2.

> +		suffixparams="-C $tree $O"
> +	fi
> +	all_target_sources | gtags -i -f - $suffixparams
>  }
>  
>  # Basic regular expressions with an optional /kind-spec/ for ctags and
> -- 
> 2.30.2
> 
