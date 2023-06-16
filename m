Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF04733441
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345829AbjFPPHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345760AbjFPPHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:07:31 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5247430E7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 08:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=dTZilnTl2B2y+Xe9DYrYC5q8JXXaDZYdjdfnrCS8f0Q=; b=Ksp12oxRXcD6hnEVmYPWCsFjn+
        86PsMdAjOKXFC1S3M1vk1JZNb+mfRZcU2U9cGZhFvMqxdeGYklXlxBu4cjnTsGOogZ6vEogMT42gX
        QWQqM+w7kEwfKbr+wUe0EfYFNL+16zLSRJZVjq7P24E8c59CDIVz/pgm6dbcybUalIEZe7rkovxha
        tAfsGMo7rV/X0h+Cy86WFRRaRpkhpKf/AMzj6ZhrHuc9grvOFNo77ofq89FnOnlKiKFXkUrm+KgjS
        cBQ6SG7XOkR88GE+6mU93B5CJwdIApQwFYJ6koxW6PZNu5kVMwyVEIgiTZcP6IvR9lK9zb4vDWQXK
        mCFHPzCg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qAB2i-00CxAi-06;
        Fri, 16 Jun 2023 15:07:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8090D300208;
        Fri, 16 Jun 2023 17:07:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 600602451D177; Fri, 16 Jun 2023 17:07:14 +0200 (CEST)
Date:   Fri, 16 Jun 2023 17:07:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: fix throttle accounting with nested bandwidth
 limits
Message-ID: <20230616150714.GR83892@hirez.programming.kicks-ass.net>
References: <20230615201252.1009678-1-joshdon@google.com>
 <20230616133323.GH4253@hirez.programming.kicks-ass.net>
 <CABk29NuFreTRe+byiweOWccvjXmt1H8Mw5qEbQfonvpQFbTZGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABk29NuFreTRe+byiweOWccvjXmt1H8Mw5qEbQfonvpQFbTZGA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 07:47:24AM -0700, Josh Don wrote:
> On Fri, Jun 16, 2023 at 6:33 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Jun 15, 2023 at 01:12:52PM -0700, Josh Don wrote:
> > > This fixes two issues:
> > > - throttled_clock should only be set on the group that is actually
> > >   getting throttled
> > > - self-throttled time should only be accounted on entry/exit to
> > >   throttled state when we have nested limits
> > >
> > > Fixes: 88cb2868250c ("sched: add throttled time stat for throttled children")
> > > Fixes: 3ab150d011da ("sched: don't account throttle time for empty groups")
> > > Signed-off-by: Josh Don <joshdon@google.com>
> >
> > Hurmph, those are not the sha1 I have in tip/sched/core.
> >
> > Also, should I rebase and just pull those patches so we can try again?
> 
> Oh whoops, I used the SHA's from your queue.git.
> 
> Yes, if it is still possible to intercept them then that would be
> great. I'm OOO at the moment, but can respin those for you first thing
> next week.

There's only a few patches on top, I'll make it go away.

