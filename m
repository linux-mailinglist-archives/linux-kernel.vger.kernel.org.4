Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8147964EC97
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 15:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiLPOFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 09:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPOFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 09:05:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282A128E10;
        Fri, 16 Dec 2022 06:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1GFjpQ7kUqBpcsYqnNwkgNJfjVlRXjx2+yVp8vKZtKI=; b=Fe0FYw4U4c3kW0Zci6+CADjzz3
        va1rfx7hiXgVMTUEtidbcRCuQSyUruUQVyVtkHIEH8bDzJESRCK0UPHkUPNgxy0+z1mhn8W5U8Ua6
        lmDrTc8YhGj48EBs1vRjKAUtNiB5IBVD6ABEcsCf0hnXzEdEjfCNfz/U8LPiQ/5nBr+NEutz1R0v+
        z3hqXnUrerECq5lzL1PSa/fPophynKrG9korPQJOswrmkr85RiYtcK3yr6nL/Bia3Ay2tRnMdLoqd
        Hikm52CTDsfHnKqckNN5wzhvb+6SvvNcZUkeKHsZOwzZRvmmpdk4dzc8CeIhbGsfQlMAFusJRrAy2
        6y9VGGwQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p6BL3-00FWKQ-ID; Fri, 16 Dec 2022 14:05:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EE0033001E7;
        Fri, 16 Dec 2022 15:05:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 88051201D8171; Fri, 16 Dec 2022 15:05:13 +0100 (CET)
Date:   Fri, 16 Dec 2022 15:05:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jann Horn <jannh@google.com>,
        Seth Jenkins <sethjenkins@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@google.com>,
        Huang Ying <ying.huang@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Rob Herring <robh@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] exit: Allow oops_limit to be disabled
Message-ID: <Y5x7GXeluFmZ8E0E@hirez.programming.kicks-ass.net>
References: <20221202210617.never.105-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202210617.never.105-kees@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 01:06:21PM -0800, Kees Cook wrote:

> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -954,7 +954,7 @@ void __noreturn make_task_dead(int signr)
>  	 * To make sure this can't happen, place an upper bound on how often the
>  	 * kernel may oops without panic().
>  	 */
> -	if (atomic_inc_return(&oops_count) >= READ_ONCE(oops_limit))
> +	if (atomic_inc_return(&oops_count) >= READ_ONCE(oops_limit) && oops_limit)
>  		panic("Oopsed too often (kernel.oops_limit is %d)", oops_limit);
>  

That's dodgy, please write as:

	limit = READ_ONCE(oops_limit);
	if (atomic_inc_return(&oops_count) >= limit && limit)

So we don't explicitly add a reload that negates the whole READ_ONCE().
