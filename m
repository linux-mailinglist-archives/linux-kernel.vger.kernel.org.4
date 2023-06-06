Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910E7723E0A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbjFFJnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236753AbjFFJnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:43:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E6CE7C;
        Tue,  6 Jun 2023 02:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5yocUGC4GxofX6G+uoVqnBsQ/8jEOxWwcuyBmPMbaTU=; b=vd08MjBj/XYcdrPdcL454J+9Rm
        vL2Sp34Zr1yw5GeRezIkscVZTscZpyLHorKvnwJW7OhxPtSr/vnn9M4NXRi8f4nsRBy1xIY79Xl6p
        JJaPLaBejWQm1W33q6CzufeyTwfQPU1th/VjEr6Ym85tPFNQAYnCS0OvsZX4PaE3OfNvonEudg76O
        GGcbcA46n451Fw53u5Jw0Aqf4vMVhMJ0e020bV/dFt8tvp4pubnWw/0m6+V+dreV03I+sfMj2YzxB
        9CMn1RmbR8mkpFm7TA3b7iivNzDeuCLCNP4tReCMeQqQY3hnNExpiuSJe8Gv1ZKcbXXIrYTU6mHDQ
        sirgTS7A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6TDL-00D00H-BE; Tue, 06 Jun 2023 09:42:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B5B71300188;
        Tue,  6 Jun 2023 11:42:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 622A720DC35C3; Tue,  6 Jun 2023 11:42:51 +0200 (CEST)
Date:   Tue, 6 Jun 2023 11:42:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     keescook@chromium.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, ndesaulniers@google.com, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de,
        linux-toolchains@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Lock and Pointer guards
Message-ID: <20230606094251.GA907347@hirez.programming.kicks-ass.net>
References: <20230526205204.861311518@infradead.org>
 <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
 <20230530092342.GA149947@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530092342.GA149947@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 11:23:42AM +0200, Peter Zijlstra wrote:

> Yes, it's a wee bit more involved, but I'm thinking it gives a fair
> amount of flexibility and we don't need to ret rid of
> -Wdeclaration-after-statement.

So I made all that work and .. Yes, you're absolutely right.

Busting -Wdeclaration-after-statement is the right thing to do for
guards.

So then I came up with:

#define __ptr_guard(_guard, _name)                                     \
       guard_##_guard##_t _name __cleanup(guard_##_guard##_cleanup)

#define ptr_guard(_guard, _name)                                       \
       __diag(push)                                                    \
       __diag(ignored "-Wdeclaration-after-statement")                 \
       __ptr_guard(_guard, _name)                                      \
       __diag(pop)

#define guard_init(_guard, _var...)                                    \
       guard_##_guard##_init(_var)

#define named_guard(_guard, _name, _var...)                            \
       ptr_guard(_guard, _name) = guard_init(_guard, _var)

#define guard(_guard, _var...)                                         \
       named_guard(_guard, __UNIQUE_ID(guard), _var)

#define scoped_guard(_guard, _var...)                                  \
       for (__ptr_guard(_guard, scope) = guard_init(_guard, _var),     \
            *done = NULL; !done; done = (void *)1)


And that all (mostly) works on clang, but not GCC :-( GCC refuses to
accept _Pragma() inside an expression.

So I now have that ptr_guard() with push/pop for clang but without for
GCC, which means that only clang has a fighting chance to report
-Wdeclaration-after-statement warns until such a time as that we can get
GCC 'fixed'.

  https://godbolt.org/z/5MPeq5W6K


FWIW: the work-in-progress patches I have are here:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=core/guards
