Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6C66F71FF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 20:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjEDSgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 14:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjEDSgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 14:36:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9049C61B1;
        Thu,  4 May 2023 11:36:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20EE76366D;
        Thu,  4 May 2023 18:36:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9BDC433D2;
        Thu,  4 May 2023 18:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683225408;
        bh=ZiIXIAF6RSHoRAlY7IyT0+9Ap/TJ7jY1zKVBsImaVOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=egMHkwjtcwPeT1kyUyYRRShK6qf8MULoFxaGH4+5BXI21ZIKPiO/IjeTUmKScG1z1
         Pw6Vb+eCaqHbt8oAVlmF43QS2JXuEbNNWL6hldJ0pV7iGLACl8Iud7saLVATkqndZy
         9AR+d2YkBPc/7RppsQrVMx/h9mvDTH7UfBGxBcejKFi4JaUJ+5STd3km52mF+9nS5K
         SblhUpk9Bwz8GvqSV6omj5gSZKyJNLfDFsmOJztjHMBleHVyw2sUC91ZERIzWZt7t+
         0Q2jlpPwf48hls0wTDZnGWl7DKbcDK6EGEfhk4uzJE7WOHpQyT14iFQf+h0KD4wvC3
         EfTaALTJi7ZQQ==
Date:   Thu, 4 May 2023 12:37:37 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>, Bill Wendling <morbo@google.com>,
        Qing Zhao <qing.zhao@oracle.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Compiler Attributes: Add __counted_by macro
Message-ID: <ZFP7cfQpb60wfLd+@work>
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

It's happening! :D

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

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

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
