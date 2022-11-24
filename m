Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6E36374E0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiKXJNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiKXJNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:13:10 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2569AA7C20
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rYKETZNIw+pj0LXb2Wyi36GtM0KwamzRnevtcxyrblE=; b=BE2GJmWj8FcFlJeGphp0U+CMdU
        Ek4OwVIY+0wgIOZFoXZ1RhRwL8uMpwUVwAfIgASOchavvWe+DyMhNb2FJJjJTj24TRJAVBAxLWkGP
        3fOn+pXhfg+87MR7GHIKI0KrdaNvBXFHhJ7CDXIqOHLSW22Gelmi50qdFT7zSP5tcH+oF48RpODAq
        TrRApHUGFYRCiaoMvKfn+XMe0+LuHXjXgOKd55paAr321SX7k9xkBGrhBEu7SGQ/TJPZyMCJAM34i
        d0cbHaR4POdUO7QF86KBvc6zgCXrnLJGatP33Za+50svtNZnBRyY13a+qO7oIx1Qzj9/Yq5yziER6
        s3UFpMbw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oy8Hl-0047dR-Jm; Thu, 24 Nov 2022 09:12:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 03129300202;
        Thu, 24 Nov 2022 10:12:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DA96E2B974B5C; Thu, 24 Nov 2022 10:12:43 +0100 (CET)
Date:   Thu, 24 Nov 2022 10:12:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Aaron Lu <aaron.lu@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Christian Brauner <brauner@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>
Subject: Re: [PATCH v3] sched: async unthrottling for cfs bandwidth
Message-ID: <Y381i3/BwtW6edlS@hirez.programming.kicks-ass.net>
References: <20221117005418.3499691-1-joshdon@google.com>
 <Y3d+1a9AEnWaxFwq@hirez.programming.kicks-ass.net>
 <CABk29NtSmXVCvkdpymeam7AYmXhZy2JLYLPFTdKpk5g6AN1-zg@mail.gmail.com>
 <Y3xnUhjSb56ex9XX@ziqianlu-desk2>
 <CABk29Ntdztkv4jT87vFgTtC99d49iUu9CcHPruh9MxDazaAW7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29Ntdztkv4jT87vFgTtC99d49iUu9CcHPruh9MxDazaAW7A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 11:41:04AM -0800, Josh Don wrote:
> > > +        */
> > > +       if (local_unthrottle) {
> > > +               rq = cpu_rq(this_cpu);
> > > +               rq_lock_irqsave(rq, &rf);
> >
> > Should we add:
> >                 if (cfs_rq_throttled(local_unthrottle))
> >
> > before calling into unthrottle_cfs_rq_async(local_unthrottle) to avoid a
> > potential WARN?
> >
> > As for whether the local cfs_rq can be unthrottled now after rq lock is
> > re-acquired, I suppose it can be. e.g. another user sets a new quota to
> > this task group during the window of rq lock gets dropped in the above
> > loop and re-acquired here IIUC.
> >
> > > +               unthrottle_cfs_rq_async(local_unthrottle);
> > > +               rq_unlock_irqrestore(rq, &rf);
> > > +       }
> > > +
> > >         return throttled;
> > >  }
> 
> Yes, we should add that check due to the case you described with a
> user concurrently configuring bandwidth. And as long as we're doing
> that, we might as well make this unthrottle_cfs_rq() instead and snip
> the comment. Peter, would you mind adding that delta?

Done, should be pushed into the queue.git thing momentarily.
