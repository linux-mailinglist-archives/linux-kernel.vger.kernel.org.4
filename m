Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811A35B6CB7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 14:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbiIMMEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 08:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbiIMMEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 08:04:37 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D006C60DA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 05:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hEpCORyj+0B2c8CSokQtAfftL9v4UKhuX8e0O4W42lQ=; b=FWxcF1DrWGJmcDkJwK+fQLssK7
        kzli3Bcih+3hYnzsYAbqx8RS29oYfkZ1GR+cwP63aQzyleFAg4VQ2QGuB+hOWD9erml6yV904Jwsq
        vJDdpzlVckA9yRQJHKdQ7qzaGGJGGZFQ4lg8NWOH+H/uuEuGB/eITA5uSaJGTmG8KF8JyI1wN6Z3W
        1ufnjneB9DVqHIDEWw0puNvo11F+Th85EKkfLsikg/6BnbO3ES5mYsCbo3b9Rrm7BUu8vyppOyS/l
        +jR+7gUWly1XUmDriX/1l4xBE5G3BjkD7b5i86qSePdtWmjtmS9WUvK1C3BwC95LWcX+lkNwE3cXa
        A6n9Mxkw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oY4dx-00C4OO-Co; Tue, 13 Sep 2022 12:03:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BFDAF30030F;
        Tue, 13 Sep 2022 14:03:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 974E220282DC8; Tue, 13 Sep 2022 14:03:54 +0200 (CEST)
Date:   Tue, 13 Sep 2022 14:03:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sathvika Vasireddy <sv@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        mingo@redhat.com, christophe.leroy@csgroup.eu, rostedt@goodmis.org,
        mbenes@suse.cz, npiggin@gmail.com, chenzhongjin@huawei.com,
        naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH v3 02/16] powerpc: Override __ALIGN and __ALIGN_STR macros
Message-ID: <YyBxqjtC0DAhmQrT@hirez.programming.kicks-ass.net>
References: <20220912082020.226755-1-sv@linux.ibm.com>
 <20220912082020.226755-3-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912082020.226755-3-sv@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 01:50:06PM +0530, Sathvika Vasireddy wrote:
> In a subsequent patch, we would want to annotate powerpc assembly functions
> with SYM_FUNC_START_LOCAL macro. This macro depends on __ALIGN macro.
> 
> The default expansion of __ALIGN macro is:
>         #define __ALIGN      .align 4,0x90
> 
> So, override __ALIGN and __ALIGN_STR macros to use the same alignment as
> that of the existing _GLOBAL macro. Also, do not pad with 0x90, because
> repeated 0x90s are not a nop or trap on powerpc.
> 
> Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/linkage.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/linkage.h b/arch/powerpc/include/asm/linkage.h
> index b71b9582e754..b88d1d2cf304 100644
> --- a/arch/powerpc/include/asm/linkage.h
> +++ b/arch/powerpc/include/asm/linkage.h
> @@ -4,6 +4,9 @@
>  
>  #include <asm/types.h>
>  
> +#define __ALIGN		.align 2
> +#define __ALIGN_STR	".align 2"

Like mentioned last time; I'm fixing this (but you're right to not wait
on that), that said, would it make sense to write it like:

#define __ALIGN		.balign 4
#define __ALIGN_STR	__stringify(__ALIGN)

That said; with power instructions being 4 bytes, the above alignment is
basically no-alignment, right?


