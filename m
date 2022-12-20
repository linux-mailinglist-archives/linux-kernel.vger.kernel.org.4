Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5C8652116
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 13:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiLTM7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 07:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbiLTM7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 07:59:34 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAD9BE36
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9DkvdiaBZqUHcco7XfIMGg1vO7ZJS1qXjuZnq3ZNZLM=; b=bAKalqIkNBnuonpJYyIbPfwUP1
        48V91BGNyo2/WsWNAufJpcYh/5+2nGzkKji8RLrNhf7cct3dmTxiNcVolhz1z+eKRJ8q+Q3vzFlKL
        jMT75NJhJqfl6QIMezCHQdyOADkxeIar7EuIHE2hONH8R8Ns9FsKXP/uGMt0k+m8/DFXA3GP8pbSm
        tmO4+1DAOjP/EnSkEfPTPlORY4GcDmAzAXm++UG8njXe6+lj2TS+pCA3xruPdWMYoLLcxoel9CPUZ
        k/sBK0/bN1k7y/axDNvLlFWvEDmUu5PmZgZIhUmcflXxJnLLo6qtMLnWZsVlDL9mlKGs2yVqU5Y9Q
        HmJaFovg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1p7cDK-00D01L-23;
        Tue, 20 Dec 2022 12:59:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CC18C3000DD;
        Tue, 20 Dec 2022 13:59:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A8F2C20C02114; Tue, 20 Dec 2022 13:59:21 +0100 (CET)
Date:   Tue, 20 Dec 2022 13:59:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: Make const-safe
Message-ID: <Y6Gxqe5ZpB+uesxL@hirez.programming.kicks-ass.net>
References: <20221212144946.2657785-1-willy@infradead.org>
 <Y5mTJVi2PBix+Gy6@hirez.programming.kicks-ass.net>
 <Y5oP2Psz++gHholO@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5oP2Psz++gHholO@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 06:03:04PM +0000, Matthew Wilcox wrote:
> On Wed, Dec 14, 2022 at 10:11:01AM +0100, Peter Zijlstra wrote:
> > On Mon, Dec 12, 2022 at 02:49:46PM +0000, Matthew Wilcox (Oracle) wrote:
> > > With a modified container_of() that preserves constness, the compiler
> > > finds some pointers which should have been marked as const.  task_of()
> > > also needs to become const-preserving for the !FAIR_GROUP_SCHED case so
> > > that cfs_rq_of() can take a const argument.  No change to generated code.
> > 
> > More const more better I suppose.. Thanks!
> > 
> > Happen to have a sha for the container_of() commit handy?
> 
> There isn't one yet.  Obviously we can't make container_of()
> const-preserving until we've fixed all the places which would warn.
> The diff I have in my tree looks like this:
> 
> diff --git a/include/linux/container_of.h b/include/linux/container_of.h
> index 1d898f9158b4..9416e6cc8c88 100644
> --- a/include/linux/container_of.h
> +++ b/include/linux/container_of.h
> @@ -20,7 +20,10 @@
>         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>                       __same_type(*(ptr), void),                        \
>                       "pointer type mismatch in container_of()");       \
> -       ((type *)(__mptr - offsetof(type, member))); })
> +       __mptr -= offsetof(type, member);                               \
> +       _Generic(ptr,                                                   \
> +               const typeof(*(ptr)) *: (const type *)__mptr,           \
> +               default: ((type *)__mptr)); })
> 
>  /**
>   * container_of_const - cast a member of a structure out to the containing
> 
> I have all of fs/ and net/ compiling cleanly now.  There are a few
> places which really need the const-removing properties, and I've made
> those call a new macro called container_of_not_const(), but I don't
> like that name.

#define const_cast(T, exp)	_Generic((exp), const T : (T)(exp), default: (exp))

perhaps? Then one can write something like:

	struct task_struct *p = const_cast(struct task_struct *,
					   constainer_of(node, struct task_struct *, run_node));

The repetition is a bit naf, but at least the construct is more
generally useful.

(I really wish there was a qualifier stripping typeof() variant -- and
yes, I know about the _Atomic thing).
