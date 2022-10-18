Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA90602CB9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbiJRNS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiJRNS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:18:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A4FC821E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vOs271AnMKn7xANLa4dJLlxcb6GAeGuxqotUegc5Fcc=; b=SSqbZBbnkr5qUXfmGjX8nVfQpb
        DzCT1II0oHl+SZo/rDG0O/IWwrsrbyKrnGj+VAY01JBr1e1GjAsmpr6O+S5mvXeDGD8KQD5W22wYI
        w0Wy2A7JIm83un1J0GQfYxeHz9RDdYTgk34Nfv+5AKT7zXFuiZNG2UjEcst9vlpqcer8unTsaMAN6
        OtMKeGGNt3uwkRVrCHGRI0JnDHhTfDonxNhzd8of3P7VluON42OUQkINdBK6Ef26E6I75P6DUwhVZ
        Oe+CtRLQaqWIrLXeKLuBbmcD5TIuhieufuSn20eg8BiExLNWiZRh+EmyMbiLpIGjDpPdsUyopksCs
        jREhWcrw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okmUa-004Ubx-3m; Tue, 18 Oct 2022 13:18:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 18CDB300202;
        Tue, 18 Oct 2022 15:18:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F0C312215707D; Tue, 18 Oct 2022 15:18:46 +0200 (CEST)
Date:   Tue, 18 Oct 2022 15:18:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH] ftrace,kcfi: Separate ftrace_stub() and
 ftrace_stub_graph()
Message-ID: <Y06ntk9uY5re23WX@hirez.programming.kicks-ass.net>
References: <Y06dg4e1xF6JTdQq@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y06dg4e1xF6JTdQq@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 02:35:16PM +0200, Peter Zijlstra wrote:
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -162,6 +162,16 @@
>  #define PATCHABLE_DISCARDS	*(__patchable_function_entries)
>  #endif
>  
> +#ifndef ARCH_SUPPORTS_CFI_CLANG

#ifndef CONFIG_ARCH_..

works much better as we found.

> +/*
> + * Simply points to ftrace_stub, but with the proper protocol.
> + * Defined by the linker script in linux/vmlinux.lds.h
> + */
> +#define	FTRACE_STUB_HACK	ftrace_stub_graph = ftrace_stub;
> +#else
> +#define FTRACE_STUB_HACK
> +#endif

Fixed up version available at:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/urgent
