Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6DF5ECA8B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbiI0RLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbiI0RLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:11:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A390FCA7A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:11:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F10CF60CF6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 17:11:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A9AC433B5;
        Tue, 27 Sep 2022 17:11:11 +0000 (UTC)
Date:   Tue, 27 Sep 2022 13:12:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [Resend PATCH v2] tracing: Disable interrupt or preemption
 before acquiring arch_spinlock_t
Message-ID: <20220927131221.1b3a736b@gandalf.local.home>
In-Reply-To: <9c798af6-aa2c-5f76-7a50-ef1983f9bdcd@redhat.com>
References: <20220922133158.1731333-1-longman@redhat.com>
        <20220922145622.1744826-1-longman@redhat.com>
        <9c798af6-aa2c-5f76-7a50-ef1983f9bdcd@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2022 11:28:13 -0400
Waiman Long <longman@redhat.com> wrote:

> On 9/22/22 10:56, Waiman Long wrote:
> > It was found that some tracing functions in kernel/trace/trace.c acquire
> > an arch_spinlock_t with preemption and irqs enabled. An example is the
> > tracing_saved_cmdlines_size_read() function which intermittently causes
> > a "BUG: using smp_processor_id() in preemptible" warning when the LTP
> > read_all_proc test is run.
> >
> > That can be problematic in case preemption happens after acquiring the
> > lock. Add the necessary preemption or interrupt disabling code in the
> > appropriate places before acquiring an arch_spinlock_t.
> >
> > The convention here is to disable preemption for trace_cmdline_lock and
> > interupt for max_lock.
> >
> > Fixes: a35873a0993b ("tracing: Add conditional snapshot")
> > Fixes: 939c7a4f04fc ("tracing: Introduce saved_cmdlines_size file")
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Waiman Long <longman@redhat.com>
> > ---
> >   kernel/trace/trace.c | 23 +++++++++++++++++++++++
> >   1 file changed, 23 insertions(+)  
> 
> Ping!
> 
> Any comment on this patch?

You may have noticed (from today's emailing) I applied the patch ;-)

-- Steve
