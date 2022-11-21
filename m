Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE0F63217B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiKUL6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiKUL6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:58:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4B625DE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=o0EKc3Pe6P0zEDho1WqfbGNf67EYwO93LZKKivn25Io=; b=StZ2cJN8J1/aPZmmf1J5LCMRiY
        cKQCbW2OlifgO0Bx2Ah+WEaZD5/chHOyAjw7CdKxiblAmlTeiGVlAFWmp0q3hQCU501u/Q/x/Pj9Q
        kAIEQNWmCGeV9qf1zk/Y6+0T0sdrzFg4nhsg/a5dfjQLr0sbe0g9eEGtotmGzYt+tZopiOiXNFQ+J
        eE+qVpUbpl11ZdKdXtSt5Tio24tzZsa5Vz/VIEAjiRAjHX8p9ZnNNRbA8RvuZpMn54ho8fOYq3XLA
        Govorcb1jlq841qi7ug2LpljIxCsaWVS17yb7Iy9shBov8aJejpq/e3QlBOYPK7ynLagyArDUvlWI
        YKX3CpMQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ox5Rf-005BNo-OT; Mon, 21 Nov 2022 11:58:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2CCF0300322;
        Mon, 21 Nov 2022 12:58:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0E5EB2BE3B106; Mon, 21 Nov 2022 12:58:32 +0100 (CET)
Date:   Mon, 21 Nov 2022 12:58:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <Y3tn5wz6TjsqfGTA@hirez.programming.kicks-ass.net>
References: <20221117005418.3499691-1-joshdon@google.com>
 <Y3d+1a9AEnWaxFwq@hirez.programming.kicks-ass.net>
 <CABk29NtSmXVCvkdpymeam7AYmXhZy2JLYLPFTdKpk5g6AN1-zg@mail.gmail.com>
 <094299a3-f039-04c1-d749-2bea0bc14246@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <094299a3-f039-04c1-d749-2bea0bc14246@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2022 at 10:22:40AM +0800, Chengming Zhou wrote:
> > +               if (cfs_rq->runtime_remaining > 0) {
> > +                       if (cpu_of(rq) != this_cpu ||
> > +                           SCHED_WARN_ON(local_unthrottle)) {
> > +                               unthrottle_cfs_rq_async(cfs_rq);
> > +                       } else {
> > +                               local_unthrottle = cfs_rq;
> > +                       }
> > +               } else {
> > +                       throttled = true;
> > +               }
> 
> Hello,
> 
> I don't get the point why local unthrottle is put after all the remote cpus,
> since this list is FIFO? (earliest throttled cfs_rq is at the head)

Let the local completion time for a CPU be W. Then if we queue a remote
work after the local synchronous work, the lower bound for total
completion is at least 2W.

OTOH, if we first queue all remote work and then process the local
synchronous work, the lower bound for total completion is W.

The practical difference is that all relevant CPUs get unthrottled
rougly at the same point in time, unlike with the original case, where
some CPUs have the opportunity to consume W runtime while another is
still throttled.

