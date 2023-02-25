Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E916A2AE0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 17:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjBYQvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 11:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYQvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 11:51:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDA6136FB;
        Sat, 25 Feb 2023 08:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ubipUM+wv2whMLKzwwBASjo1sJH0JLw6VTjEqEWMXK0=; b=esugZB5w+J2sx/Sifbb59C3f5J
        hGyJSxWq/XG8tKEnrj6XdGBQWkWkiq/RyufNnlPhczrDRPI0kSipUKzckS/vnSG5JXZz22oH7jdKc
        kUIDE/gp8rTpxatVSaFvs2hgAQHj0kgpbYiuS06UBxPugWiKreLB1p356qJaruEaddPGL2pqRW4wX
        yoVeiCgs6v/XfVVSRO72r3L4QefKIMtEwEGsPqPXyM/tiDy9NI3nKgHk9NWnpaicWuejZ1YzvgGiF
        f8cOQojEie2MKNxoAXLMKV6DtaLJ6UC8Z6DHlNZ40hwtg6Qb+3jfmHYG5pRl/42a4dLmjxItg4kF8
        HajJLNuA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pVxlC-00GFAT-GH; Sat, 25 Feb 2023 16:50:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5B792300293;
        Sat, 25 Feb 2023 17:50:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2357820CC1861; Sat, 25 Feb 2023 17:50:58 +0100 (CET)
Date:   Sat, 25 Feb 2023 17:50:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] s390/rwonce: add READ_ONCE_ALIGNED_128() macro
Message-ID: <Y/o8cmyc7IW+28S2@hirez.programming.kicks-ass.net>
References: <20230224100237.3247871-1-hca@linux.ibm.com>
 <20230224100237.3247871-2-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224100237.3247871-2-hca@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 11:02:36AM +0100, Heiko Carstens wrote:
> Add an s390 specific READ_ONCE_ALIGNED_128() helper, which can be used for
> fast block concurrent (atomic) 128-bit accesses.
> 
> The used lpq instruction requires 128-bit alignment. This is also the
> reason why the compiler doesn't emit this instruction if __READ_ONCE() is
> used for 128-bit accesses.

Does your u128 not have natural alignment? Does it help if you force
align the u128 type?

> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/include/asm/rwonce.h | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 arch/s390/include/asm/rwonce.h
> 
> diff --git a/arch/s390/include/asm/rwonce.h b/arch/s390/include/asm/rwonce.h
> new file mode 100644
> index 000000000000..91fc24520e82
> --- /dev/null
> +++ b/arch/s390/include/asm/rwonce.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __ASM_S390_RWONCE_H
> +#define __ASM_S390_RWONCE_H
> +
> +#include <linux/compiler_types.h>
> +
> +/*
> + * Use READ_ONCE_ALIGNED_128() for 128-bit block concurrent (atomic) read
> + * accesses. Note that x must be 128-bit aligned, otherwise a specification
> + * exception is generated.
> + */
> +#define READ_ONCE_ALIGNED_128(x)			\
> +({							\
> +	union {						\
> +		typeof(x) __x;				\
> +		__uint128_t val;			\
> +	} __u;						\
> +							\
> +	BUILD_BUG_ON(sizeof(x) != 16);			\
> +	asm volatile(					\
> +		"	lpq	%[val],%[_x]\n"		\
> +		: [val] "=d" (__u.val)			\
> +		: [_x] "QS" (x)				\
> +		: "memory");				\
> +	__u.__x;					\
> +})
> +
> +#include <asm-generic/rwonce.h>
> +
> +#endif	/* __ASM_S390_RWONCE_H */
> -- 
> 2.37.2
> 
