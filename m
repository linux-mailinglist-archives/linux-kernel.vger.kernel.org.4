Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC30712D1B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243727AbjEZTKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjEZTKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:10:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED64F187;
        Fri, 26 May 2023 12:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uJAXYYqrpUX+Aacn25secLYK8MSl6B11yqPPBJ47bxg=; b=NYeuZL482p1auY8S6tRFUj5Le5
        JLvdE9UqUvSim3C3+S86kSzmmDE8xno+NystN6atL8RRyXMu2WV6TnZs3mjeYMnN0ej9OaMB0D6tQ
        7X4tnALIr3CulWTwnY3GePY0uI/Nc1xy1dCyntM3+Ao8RxA6ZmztyHgOykC8eS3rAtz4se17NVcJj
        xargWMYoLlLdVfw0PRe2lS3b0IT8JGroYMoC9dfkNuaWi38CfbzofM3gHgbFBa9Wsp+CQvpTrzdIC
        04R33iANdkGcO+5szbbssY/kqWiLLue1Zjyb5dXFPZ7xKN+MyYp5oWOuARSGTgahaziF9rFRL+f9E
        hK6xP6/g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q2cpM-007gOp-0n;
        Fri, 26 May 2023 19:10:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4692A3006B1;
        Fri, 26 May 2023 21:10:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2488222163BC1; Fri, 26 May 2023 21:10:14 +0200 (CEST)
Date:   Fri, 26 May 2023 21:10:14 +0200
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
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de
Subject: Re: [RFC][PATCH 1/2] locking: Introduce __cleanup__ based guards
Message-ID: <20230526191014.GA4057254@hirez.programming.kicks-ass.net>
References: <20230526150549.250372621@infradead.org>
 <20230526151946.960406324@infradead.org>
 <CAHk-=wgYL6JaL79EmOBV=vge7jWGkph73JnJgU9U3jeXa6b2=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgYL6JaL79EmOBV=vge7jWGkph73JnJgU9U3jeXa6b2=Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 11:22:36AM -0700, Linus Torvalds wrote:

> But you can actually do the 'bool done' using the exact same type you
> have for the guard - just make it a pointer instead, and use NULL for
> "not done" and non-NULL for "done". It ends up acting exactly like a
> boolean.

Damn; I've actually seen that and should've thought of it.

> IOW, something like this:
> 
>   #define variable_scope(type, enter, exit) \
>         for (type *_done = NULL, _scope __cleanup(exit) = enter;
> !_done; _done = (void *)8)
> 
>   #define scoped(type, init...) \
>         variable_scope(scope_##type##_t, scope_##type##_init(init),
> scope_##type##_cleanup)
> 

> I dunno. I didn't *test* the above. Maybe you already tried something
> like the above, and there's a reason why it doesn't work.

I have not; let me go try that. That does look *much* nicer.
