Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5A6631E2F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbiKUKXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbiKUKXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:23:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516BB2182A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5zIwYFky3D2pTNep9PW/j8wYr5wyhQdCK147aNotvRg=; b=PuybbQgaGUYEKEKRg7Bst3hFqR
        RS3Jn0evnz3ZeW0FsBZfbXq7+27aTdRbxN26knS3dQNtgsptkcC5VmCf885qJAA+qm3P+AbW2/Opn
        4i928oITfHcwAmG1qN7sBwXCiUqoliWuZv4W4wsoGABi5SfCWrc8ueQsLVQEDxWh3YYaY8wPUUVB+
        1kjmzHtYCPi2CFIJg2o9Xol/4ifGET5i0F6CfJnWxpwY5dp5J6dCEWp1xrUCexSJK/uJpwbKXu9OE
        GYbybCTTxSFIxlMQMZFNdxKUaIyiggf2HIvlDd7N/hBdt9HMSc4gtxW96vTOLyXY0jymSkSL1NPNT
        NI7F+rFg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ox3xC-0056sx-LC; Mon, 21 Nov 2022 10:23:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CF448300322;
        Mon, 21 Nov 2022 11:22:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AD014203A8986; Mon, 21 Nov 2022 11:22:56 +0100 (CET)
Date:   Mon, 21 Nov 2022 11:22:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] x86: suppress KMSAN reports in arch_within_stack_frames()
Message-ID: <Y3tRgGUKCxUoLeM8@hirez.programming.kicks-ass.net>
References: <20221118172305.3321253-1-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118172305.3321253-1-glider@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 06:23:05PM +0100, Alexander Potapenko wrote:
> arch_within_stack_frames() performs stack walking and may confuse
> KMSAN by stepping on stale shadow values. To prevent false positive
> reports, disable KMSAN checks in this function.
> 
> This fixes KMSAN's interoperability with CONFIG_HARDENED_USERCOPY.
> 
> Link: https://github.com/google/kmsan/issues/89
> Link: https://lore.kernel.org/lkml/Y3b9AAEKp2Vr3e6O@sol.localdomain/
> Cc: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
>  arch/x86/include/asm/thread_info.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
> index f0cb881c1d690..f1cccba52eb97 100644
> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -163,7 +163,12 @@ struct thread_info {
>   *	GOOD_FRAME	if within a frame
>   *	BAD_STACK	if placed across a frame boundary (or outside stack)
>   *	NOT_STACK	unable to determine (no frame pointers, etc)
> + *
> + * This function reads pointers from the stack and dereferences them. The
> + * pointers may not have their KMSAN shadow set up properly, which may result
> + * in false positive reports. Disable instrumentation to avoid those.
>   */
> +__no_kmsan_checks
>  static inline int arch_within_stack_frames(const void * const stack,
>  					   const void * const stackend,
>  					   const void *obj, unsigned long len)

Seems OK; but now I'm confused as to the exact distinction between
__no_sanitize_memory and __no_kmsan_checks.

The comments there about seem to suggest __no_sanitize_memory ensures no
instrumentation at all, and __no_kmsan_checks some instrumentation but
doesn't actually check anything -- so what's left then?
