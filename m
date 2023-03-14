Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA296B9CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 18:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjCNRQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 13:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjCNRQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 13:16:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFEAA7AB8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 10:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A71jfeeH35kqwMfbB++u47Md5fonzEz0fp2iSi6N5mg=; b=u8qMKDKhYyM/6gjRm/oLIqA1mE
        5Qck6jS1HueWJ1I/V+hBWlP7ef9ixdBAI2nOqZQizJ4UMC4vrJWDqM91GjDS8s+zfz9OeFuNf5/hT
        pUiIhnzEc89ey7eIeEvD8Y+vyo3bSHpO9D8CcvBT53cRW6hcx4mAQyOHUu9QiLc89SmtG/QBhmUvk
        SiknHhIzCUX/bcM030itd2ypHRofYF+5pVVS8hUleDyqSrLJcsQZ3XWPsZX0iYoLk/5/8tOKA1MUV
        F5rGsrBbLI/NcZBjLjHTs83gqJMjyXmkBHecDhpt6fnKj/1lu4Z/uqqaW1yRhi3uOayAKbwbFQKlx
        59anIxcg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pc8Ft-00D59y-7l; Tue, 14 Mar 2023 17:16:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5AC243001F7;
        Tue, 14 Mar 2023 18:16:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 302CB20321D61; Tue, 14 Mar 2023 18:16:07 +0100 (CET)
Date:   Tue, 14 Mar 2023 18:16:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        rkagan@amazon.de
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
Message-ID: <20230314171607.GN2017917@hirez.programming.kicks-ass.net>
References: <CAKfTPtAf5RrzZRSHtfK+r3QvnFQ-oM3+rJ-z5SB8T4+nUv1aQw@mail.gmail.com>
 <20230309142825.GB273121@hirez.programming.kicks-ass.net>
 <ZAnvCGdlOrWbIC/o@hirez.programming.kicks-ass.net>
 <CAKfTPtADUas2QHZCQyu0ad-JTKRQ=PcsB=o7+PuJNVxHwAzkCQ@mail.gmail.com>
 <ZAs+zV0o9ShO7nLT@vingu-book>
 <02a08042-e7c4-464d-bc20-9ec4ccdab1ff@arm.com>
 <8c093661-7431-00d8-d703-b8f7a7c8e747@arm.com>
 <CAKfTPtBw9SJxVBcN1qff7jRzE81kXSjbc-rXD6goEBFiXEwbyg@mail.gmail.com>
 <20230314120726.GG1845660@hirez.programming.kicks-ass.net>
 <CAKfTPtBHocw4N-YMHeqfMj78Ro=aF8sJPanxVCN=tM70hr6r8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBHocw4N-YMHeqfMj78Ro=aF8sJPanxVCN=tM70hr6r8g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 02:24:37PM +0100, Vincent Guittot wrote:

> > @@ -7632,11 +7646,8 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
> >          * min_vruntime -- the latter is done by enqueue_entity() when placing
> >          * the task on the new runqueue.
> >          */
> > -       if (READ_ONCE(p->__state) == TASK_WAKING) {
> > -               struct cfs_rq *cfs_rq = cfs_rq_of(se);
> > -
> > +       if (READ_ONCE(p->__state) == TASK_WAKING || reset_vruntime(cfs_rq, se))
> 
> That's somehow what was proposed in one of the previous proposals but
> we can't call rq_clock_task(rq_of(cfs_rq)) because rq lock might not
> be hold and rq task clock has not been updated before being used

Argh indeed. I spend a lot of time ensuring we didn't take the old rq
lock on wakeup -- and then a lot of time cursing about how we don't :-)

Now, if we could rely on the rq-clock being no more than 1 tick behind
current, this would still be entirely sufficient to catch the long sleep
case.

Except I suppose that NOHZ can bite us here. If the old CPU is idle, the
timestamps can be arbitrarily old. Mooo :/


