Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7055F9A44
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 09:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiJJHn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 03:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbiJJHmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 03:42:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3AB1A3AB;
        Mon, 10 Oct 2022 00:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1eRxM63YBnLGny/uQKmG8pvw2aWvkBhE+yRLA3VSCIo=; b=alpCk4Y7XDeobV7r9Ze3bANnuZ
        YsatUfSY7waSevjuZjzkz3TguPyg0CPr0q7Sdh1FM3A9UKmyKoGsbt2tHp1xhwhKzwvX6+rdEEKnz
        1QJO/1bqiFsf7Gl0cTI1GlzTcsU7DHlfUXMtDcrUR5CSy7N4AgeEigb6wtZUmfKNI3DpobUKdy3Vs
        UlpYBoonNFHS1b0622NexQMFh9oRy0sCvMKQac3Lv+IXtzScVawVEtrv24Qu1su8zPcgq3VCoMwWM
        DWfBdcmm3xTOnPYu2XEz4HSORmDKdRBDNzkaoqAMvOLRAi982hFCPcrI9LRDtGlQgEXGtiI1dJ7XS
        k7yzt+NQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ohnMe-0042uk-GF; Mon, 10 Oct 2022 07:38:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8F0183001CB;
        Mon, 10 Oct 2022 09:38:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7BFC12BF1DAC2; Mon, 10 Oct 2022 09:38:11 +0200 (CEST)
Date:   Mon, 10 Oct 2022 09:38:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] sched: Introduce struct balance_callback to avoid CFI
 mismatches
Message-ID: <Y0PL4zKWyS6z6OX2@hirez.programming.kicks-ass.net>
References: <20221008000758.2957718-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221008000758.2957718-1-keescook@chromium.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 05:07:58PM -0700, Kees Cook wrote:
> Introduce distinct struct balance_callback instead of performing function
> pointer casting which will trip CFI. Avoids warnings as found by Clang's
> future -Wcast-function-type-strict option:
> 
> In file included from kernel/sched/core.c:84:
> kernel/sched/sched.h:1755:15: warning: cast from 'void (*)(struct rq *)' to 'void (*)(struct callback_head *)' converts to incompatible function type [-Wcast-function-type-strict]
>         head->func = (void (*)(struct callback_head *))func;
>                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> No binary differences result from this change.
> 
> This patch is a cleanup based on Brad Spengler/PaX Team's modifications
> to sched code in their last public patch of grsecurity/PaX based on my
> understanding of the code. Changes or omissions from the original code
> are mine and don't reflect the original grsecurity/PaX code.
> 
> Reported-by: Sami Tolvanen <samitolvanen@google.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1724
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  kernel/sched/core.c     | 24 ++++++++++++------------
>  kernel/sched/deadline.c |  4 ++--
>  kernel/sched/rt.c       |  4 ++--
>  kernel/sched/sched.h    | 14 ++++++++++----
>  4 files changed, 26 insertions(+), 20 deletions(-)

Thanks!
