Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731CB707272
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjEQTmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjEQTmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:42:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC87271B;
        Wed, 17 May 2023 12:42:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04DA164AB5;
        Wed, 17 May 2023 19:42:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FC7C433EF;
        Wed, 17 May 2023 19:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684352559;
        bh=afhI056VdXNOr9ugoqlRkd2TTFxvYYZ/gycL5eBOWXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YUk0CCY0gbbYh1ILW9Y80BGNdCD8aVom443ZRnGmZp6gHYNPGY6nOHSGOpla7z3F9
         FX9QzNm1UO338vsjPE3LzzQXej6dglBW2R84lzV4DTBxdQkz0Et7RCXC0qKiPYdPlf
         HfvPeqswFlXmM1yds8VtHBJ3N3Vn/a9k9D1Wli6O1Krl8QukSEk/G3ytVknfQePcE7
         rtskS3VCbqX9mAtS68eeWWlCUldNzRclks28YB/JkBc2qdUqsVvfLhHjywQDTQPkOF
         YjjV5YA5oVefQJmQCS8/HqkJaA4lnWkRWJWCDlyQ28TbENhnLICK+oU13yd1ToTWfp
         Zv/FDKcHY6OOw==
Date:   Wed, 17 May 2023 13:43:28 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>, Bill Wendling <morbo@google.com>,
        Qing Zhao <qing.zhao@oracle.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] Compiler Attributes: Add __counted_by macro
Message-ID: <ZGUuYHlEoCF9AyKz@work>
References: <20230517190841.gonna.796-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517190841.gonna.796-kees@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 12:08:44PM -0700, Kees Cook wrote:
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

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
> v2: - update "Optional" comments
> v1: https://lore.kernel.org/all/20230504181636.never.222-kees@kernel.org/
> ---
>  include/linux/compiler_attributes.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> index e659cb6fded3..a92d8887e8f0 100644
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -123,6 +123,19 @@
>  # define __designated_init
>  #endif
>  
> +/*
> + * Optional: only supported since gcc >= 14
> + * Optional: only supported since clang >= 17
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
