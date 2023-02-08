Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D84C68F69F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjBHSKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjBHSKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:10:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1598DC154
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 10:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3eN7aIzkLFLIdp/JFL79Wf1u+TIujhiGAfM1SS+nUFk=; b=Nb7AmXOoG8we3qFUPrNH3yvQl4
        wPU9qZoqe7LI2P+fXzCXv2KHphb9lNMbCkpZnbzTHcWpj+Y/w57mEXlbZmaO0SdOlKWdLSE3clxH+
        4Nv8+FZxSaNAxlL6lKHkZCiF6QClsznhCD7ydK7YU4ZlET1QivWvZSjfqZg1wj2LrnUeuLRvZAkQb
        vOkM7462Ti7emJqo79NbXzWHPI+2YZWQUqBPa51rsOI1TX9grK8DL7CRSPgoYlRZtzYlw432nZOZz
        v1sfkRCQ+fmbXRcLT6tYFz4ytKJhsVgmeR0yfjmY99PFBcUmGQA1XIJYpz/AHTwRS3BHyY9ZcyPZr
        aOZPywqw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPot6-001RGK-Lj; Wed, 08 Feb 2023 18:09:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D6D663001CB;
        Wed,  8 Feb 2023 19:09:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B7FB320F05D4E; Wed,  8 Feb 2023 19:09:42 +0100 (CET)
Date:   Wed, 8 Feb 2023 19:09:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, kasan-dev@googlegroups.com,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>,
        Miroslav Benes <mbenes@suse.cz>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] objdump: add UACCESS exception for more stringops
Message-ID: <Y+PlZi8mrHray92j@hirez.programming.kicks-ass.net>
References: <20230208164011.2287122-1-arnd@kernel.org>
 <20230208164011.2287122-3-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208164011.2287122-3-arnd@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 05:39:57PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The memset/memmove/memcpy string functions are wrapped in different
> ways based on configuration. While the __asan_mem* functions already
> have exceptions, the ones called from those do not:
> 
> mm/kasan/shadow.o: warning: objtool: __asan_memset+0x30: call to __memset() with UACCESS enabled
> mm/kasan/shadow.o: warning: objtool: __asan_memmove+0x51: call to __memmove() with UACCESS enabled
> mm/kasan/shadow.o: warning: objtool: __asan_memcpy+0x51: call to __memcpy() with UACCESS enabled
> vmlinux.o: warning: objtool: .altinstr_replacement+0x1406: call to memcpy_erms() with UACCESS enabled
> vmlinux.o: warning: objtool: .altinstr_replacement+0xed0: call to memset_erms() with UACCESS enabled
> vmlinux.o: warning: objtool: memset+0x4: call to memset_orig() with UACCESS enabled
> vmlinux.o: warning: objtool: memset+0x4: call to memset_orig() with UACCESS enabled
> 
> Add these to the list as well.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  tools/objtool/check.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 0f67c6a8bc98..e8fb3bf7a2e3 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -1248,6 +1248,13 @@ static const char *uaccess_safe_builtin[] = {
>  	"clear_user_erms",
>  	"clear_user_rep_good",
>  	"clear_user_original",
> +	"__memset",
> +	"__memcpy",
> +	"__memmove",
> +	"memset_erms",
> +	"memcpy_erms",
> +	"memset_orig",
> +	"memcpy_orig",
>  	NULL
>  };

Hmm, I wanted to go the other way and remove __asan_mem*.

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=sched/core-robot&id=79cdfdacd5b8d1ac77e24ccbc178bba0294d0d78


