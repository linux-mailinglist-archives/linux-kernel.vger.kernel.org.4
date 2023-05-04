Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF436F77ED
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 23:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjEDVSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 17:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjEDVSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 17:18:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CD213C12;
        Thu,  4 May 2023 14:18:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A82466120E;
        Thu,  4 May 2023 21:18:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC7AC433D2;
        Thu,  4 May 2023 21:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683235110;
        bh=TxYeoSXKxOHRLPFJsvXYPhN8fWjJV7GYIjZiQWu6XWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EpQHRsKjHtgCM7M9XrBRxB099JjBNG22++T1N66aaJozyGrUty3HE/XNKb41aSMda
         C+LrH6YvgIyhYC6fR8SMmr8LocvmhCj/9PgqcC3hwy6a1YgPooHZaIsiPHCTFyn16Y
         ESoUj9GLawnXJXjg7kPONM/kD3h7Ja/V/9+gMEpKFo2SjV9WGWaAUXdem0i7vqsq4+
         oJdiOwMCury/ESM3Ljr3dBSL4ecchhjYWL0zYb/jgNTOXMgsQ3P1Rt+FcaSpFIFIcO
         +8zi2Kzw4qR7uRPddc0dsUtFUXG4/Cv/jASODrH0Q1eJFQICzZm0k9ysvNF0DVoPJT
         EGyKESyfi1okQ==
Date:   Thu, 4 May 2023 14:18:27 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>, Bill Wendling <morbo@google.com>,
        Qing Zhao <qing.zhao@oracle.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Compiler Attributes: Add __counted_by macro
Message-ID: <20230504211827.GA1666363@dev-arch.thelio-3990X>
References: <20230504181636.never.222-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504181636.never.222-kees@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 11:16:40AM -0700, Kees Cook wrote:
> In an effort to annotate all flexible array members with their run-time
> size information, the "element_count" attribute is being introduced by
> Clang[1] and GCC[2] in future releases. This annotation will provide
> the CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE features the ability
> to perform run-time bounds checking on otherwise unknown-size flexible
> arrays.
> 
> Even though the attribute is under development, we can start the
> annotation process in the kernel. This requires defining a macro for
> it, even if we have to change the name of the actual attribute later.
> Since it is likely that this attribute may change its name to "counted_by"
> in the future (to better align with a future total bytes "sized_by"
> attribute), name the wrapper macro "__counted_by", which also reads more
> clearly (and concisely) in structure definitions.
> 
> [1] https://reviews.llvm.org/D148381
> [2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108896
> 
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Bill Wendling <morbo@google.com>
> Cc: Qing Zhao <qing.zhao@oracle.com>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Tom Rix <trix@redhat.com>
> Cc: llvm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

I agree with Miguel's comment formatting and content suggestions. Thanks
for the links, they look good. If we have to update the name of the
attribute later, it is not the end of the world, as getting the coversion
started at this phase will make the roll out quicker.

> ---
>  include/linux/compiler_attributes.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> index e659cb6fded3..9d63fe2024d5 100644
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -123,6 +123,18 @@
>  # define __designated_init
>  #endif
>  
> +/*
> + * Optional: future support coming in clang 17 and gcc 14
> + *
> + *   gcc: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108896
> + * clang: https://reviews.llvm.org/D148381
> + */
> +#if __has_attribute(__element_count__)
> +# define __counted_by(member)		__attribute__((__element_count__(member)))
> +#else
> +# define __counted_by(member)
> +#endif
> +
>  /*
>   * Optional: only supported since clang >= 14.0
>   *
> -- 
> 2.34.1
> 
