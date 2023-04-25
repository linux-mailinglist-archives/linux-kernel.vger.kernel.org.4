Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C8F6EE160
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbjDYLxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbjDYLxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:53:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B742D13F8D;
        Tue, 25 Apr 2023 04:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RuyX3d7D1azwsn4TOGYEeBa8zDHbPol4DtyJcZjYy1w=; b=YLzLX23gAqE/afcAhQhX/CCgMI
        c94ZoDFe8oTJK2JSS/FuFGg8KUS5MYESVL9zKBUuFX7pze6a+rQ5PaTvvIeSr87dHaWiZmxJTRf4k
        ZnYkaXPe9I8mpJ6ZFo6m4WPVvHZUc9bpUolM4kAQW5pfuUzoAT4BSZcvoCfBYgEp055GC/jb8VTv8
        yBrlzwI/q0hZhcGAjBwsIg3GQ6498b4k6et/MqH9pyecJ+1MLldg1AIA1Viioh+zJ+jpg94WqSC4Y
        zTgteBn+91FFU6o2Y2N8N4q4l0FvCaHhNqzrDnQH+jP5wtpEGUOET5GiAols0niV9kFXp6T89bCa6
        n7YxfyQQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1prHER-001PFv-P0; Tue, 25 Apr 2023 11:53:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 968D5300380;
        Tue, 25 Apr 2023 13:53:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7990C241943F2; Tue, 25 Apr 2023 13:53:13 +0200 (CEST)
Date:   Tue, 25 Apr 2023 13:53:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, lance@osuosl.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: BUG : PowerPC RCU: torture test failed with __stack_chk_fail
Message-ID: <20230425115313.GD1335080@hirez.programming.kicks-ass.net>
References: <CAABZP2xJRGhPmfB-PrfesQKzP7fsuZsj+3TewAiLLW8u=YK4dg@mail.gmail.com>
 <CAEXW_YSSGYgqTpxqbYikCFS9t=2f+L-0phbU+gAAngB5z-FbyA@mail.gmail.com>
 <ZEXOMC2casTlobE1@boqun-archlinux>
 <87fs8pzalj.fsf@mail.concordia>
 <20230424151351.GP19790@gate.crashing.org>
 <ZEagN1jJwg+rUzX4@boqun-archlinux>
 <CAEXW_YRfetnhgCw5OgnwhgZF_U+UkHN=uy=L8ovGLqn1UCtfTg@mail.gmail.com>
 <20230425101324.GD1331236@hirez.programming.kicks-ass.net>
 <CAEXW_YRFZ3zDc0gJRHjJPRuNaBtnmUc+9RxSAHH48jkFw_b34g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YRFZ3zDc0gJRHjJPRuNaBtnmUc+9RxSAHH48jkFw_b34g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 06:59:29AM -0400, Joel Fernandes wrote:
> > I'm a little confused; the way I understand the whole stack protector
> > thing to work is that we push a canary on the stack at call and on
> > return check it is still valid. Since in general tasks randomly migrate,
> > the per-cpu validation canary should be the same on all CPUs.

> AFAICS, the canary is randomly chosen both in the kernel [1]. This

Yes, at boot, once. But thereafter it should be the same for all CPUs.

> also appears to be the case in glibc. That makes sense because you
> don't want the canary to be something that the attacker can easily
> predict and store on the stack to bypass buffer overflow attacks:
> 
> [1] kernel :
> /*
>  * Initialize the stackprotector canary value.
>  *
>  * NOTE: this must only be called from functions that never return,
>  * and it must always be inlined.
>  */
> static __always_inline void boot_init_stack_canary(void)
> {
>         unsigned long canary = get_random_canary();
> 
>         current->stack_canary = canary;
> #ifdef CONFIG_PPC64
>         get_paca()->canary = canary;
> #endif
> }
> 
> thanks,
> 
>  - Joel
