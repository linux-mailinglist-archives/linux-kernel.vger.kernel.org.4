Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F073D70E43F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237601AbjEWRuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237830AbjEWRtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:49:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17DFE70;
        Tue, 23 May 2023 10:49:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E998E61D51;
        Tue, 23 May 2023 17:49:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF95C433EF;
        Tue, 23 May 2023 17:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684864155;
        bh=WulWyTLsl5PkcQrddm9jfceGIGntrpe2tN+xa+us7bo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cX2tItOE1A1Jntu+R2QwFXn1l2foJFtg3vTP5UqBKoyZAx1yIVSFWvsSppTEK/EOP
         lN7uZmcVpfDnJLrPAK6p60xdJr60YQkvTKJ9egHit5rKTgaVtlfC5DrIIcVuVa1PFF
         q1Rgb8mF6vjH0jYHR6CmpB5cz3pG5RY46o+x53evUnUB2rCdD4iCI7gCRQZHsgiqA2
         KwyIutNcCQl9ndkkDPM89DD6D+5+/8NAiqoAUZuwyjrrjqs0bnFJc7HxI/H/oHPED7
         K2Hu1Wx4MD5Ad4NUkal8QwWsuF0f1J8vGR9nTjgaKW8lAvglCsQTkZQ8a3n3daoFjQ
         tIlPVx23OT0Gg==
Date:   Tue, 23 May 2023 10:49:13 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>, Bill Wendling <morbo@google.com>,
        Qing Zhao <qing.zhao@oracle.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] Compiler Attributes: Add __counted_by macro
Message-ID: <20230523174913.GB1388474@dev-arch.thelio-3990X>
References: <20230517190841.gonna.796-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517190841.gonna.796-kees@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

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
