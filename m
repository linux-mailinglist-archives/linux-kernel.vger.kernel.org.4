Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAF16F64BD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 08:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjEDGJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 02:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjEDGJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 02:09:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0CB2128
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 23:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kdsR0guEY624cKUQSYsVx2bXuW3WeI6HUMgourQ1avY=; b=FIntEoogQ8rpGiMYdMEYJzhIc2
        v9YCmx0tlIPF2b6lW12RSQm87qq7sw0v17FTFNuhoRhylAsesdByerA030v8EtH5NSYjUFqTh6KNE
        DPtf9cg4P/DUXnutvZ0uKphw5WRzJ+Sh68JQwhtfq2OBZZfahDIpDy1LyzPCGel/bb7zBjs/gCrI/
        X0kXtCWDOGDjKFndW/PjFT5GkK2n43BNVLjzlikEghAgOBAxxZVtvmjDG1XfrYLPewm/MiZIAv1jp
        bjhC7xY+DqQkQev7dHqemAuO0ZqtnFXF/Au9WlNIHHVcubEyD4N+EZ8uniSNkRs8ajsIxYG9Iknl6
        YDuvcROg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1puS9c-00AIy0-Fz; Thu, 04 May 2023 06:09:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2014D3006DA;
        Thu,  4 May 2023 08:09:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E6AEF240701FD; Thu,  4 May 2023 08:09:23 +0200 (CEST)
Date:   Thu, 4 May 2023 08:09:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] selftests/rseq: Implement
 rseq_unqual_scalar_typeof
Message-ID: <20230504060923.GB1734100@hirez.programming.kicks-ass.net>
References: <20230503201324.1587003-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503201324.1587003-1-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 04:13:22PM -0400, Mathieu Desnoyers wrote:
> Allow defining variables and perform cast with a typeof which removes
> the volatile and const qualifiers.
> 
> This prevents declaring a stack variable with a volatile qualifier
> within a macro, which would generate sub-optimal assembler.
> 
> This is imported from the "librseq" project.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  tools/testing/selftests/rseq/compiler.h | 27 +++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/tools/testing/selftests/rseq/compiler.h b/tools/testing/selftests/rseq/compiler.h
> index f47092bddeba..8dc7f881e253 100644
> --- a/tools/testing/selftests/rseq/compiler.h
> +++ b/tools/testing/selftests/rseq/compiler.h
> @@ -33,4 +33,31 @@
>  #define RSEQ_COMBINE_TOKENS(_tokena, _tokenb)	\
>  	RSEQ__COMBINE_TOKENS(_tokena, _tokenb)
>  
> +#ifdef __cplusplus
> +#define rseq_unqual_scalar_typeof(x)					\
> +	std::remove_cv<std::remove_reference<decltype(x)>::type>::type
> +#else
> +/*
> + * Use C11 _Generic to express unqualified type from expression. This removes
> + * volatile qualifier from expression type.
> + */
> +#define rseq_unqual_scalar_typeof(x)					\
> +	__typeof__(							\
> +		_Generic((x),						\
> +			char: (char)0,					\
> +			unsigned char: (unsigned char)0,		\
> +			signed char: (signed char)0,			\
> +			unsigned short: (unsigned short)0,		\
> +			signed short: (signed short)0,			\
> +			unsigned int: (unsigned int)0,			\
> +			signed int: (signed int)0,			\
> +			unsigned long: (unsigned long)0,		\
> +			signed long: (signed long)0,			\
> +			unsigned long long: (unsigned long long)0,	\
> +			signed long long: (signed long long)0,		\
> +			default: (x)					\
> +		)							\
> +	)

FWIW, I like how the kernel version uses a little helper for the
signed/unsigned pairs. Makes it a little more readable.

> +#endif
> +
>  #endif  /* RSEQ_COMPILER_H_ */
> -- 
> 2.25.1
> 
