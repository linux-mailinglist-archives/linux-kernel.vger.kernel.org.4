Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74CF60132F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 18:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiJQQGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 12:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJQQGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 12:06:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A416EF12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666022765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KG02hPJbNg6J8TWd2/QPe4puTPwoDSB7QBpWIeJjsZI=;
        b=K7u6w2CckmLAqcchaHNX4ptMVTvb8h4iDM+IilrGuScqLDUw9/hk55Qn69Y9WpSdJLJYtI
        lXn27Bk+Ihw6Uz2PSiDXXNPkCcHkBzgbE4pnIG2iGxy4fKufjQYK600mM3r4HlhNf/15l/
        /oDX0rTsHyyL6lNmV8XZhfTULjYc8+g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-25-7MzJootMPyCO-tr1JF1MDQ-1; Mon, 17 Oct 2022 12:06:03 -0400
X-MC-Unique: 7MzJootMPyCO-tr1JF1MDQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57D7286C042;
        Mon, 17 Oct 2022 16:06:02 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D2ADC10197;
        Mon, 17 Oct 2022 16:06:01 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id A17D5416D5CB; Mon, 17 Oct 2022 13:04:47 -0300 (-03)
Date:   Mon, 17 Oct 2022 13:04:47 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Aaron Tomlin <atomlin@redhat.com>, frederic@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v8 5/5] tick/sched: Ensure quiet_vmstat() is called when
 the idle tick was stopped too
Message-ID: <Y019H0l48s9bXfxc@fuller.cnet>
References: <20220924152227.819815-1-atomlin@redhat.com>
 <20220925010511.1482-1-hdanton@sina.com>
 <20221003124435.1769-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003124435.1769-1-hdanton@sina.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 08:44:35PM +0800, Hillf Danton wrote:
> On 26 Sep 2022 10:20:04 +0100  Aaron Tomlin <atomlin@redhat.com> wrote:
> > On Sun 2022-09-25 09:05 +0800, Hillf Danton wrote:
> > > On 24 Sep 2022 16:24:41 +0100 Aaron Tomlin <atomlin@redhat.com> wrote:
> > > > 
> > > > In the context of the idle task and an adaptive-tick mode/or a nohz_full
> > > > CPU, quiet_vmstat() can be called: before stopping the idle tick,
> > > > entering an idle state and on exit. In particular, for the latter case,
> > > > when the idle task is required to reschedule, the idle tick can remain
> > > > stopped and the timer expiration time endless i.e., KTIME_MAX. Now,
> > > > indeed before a nohz_full CPU enters an idle state, CPU-specific vmstat
> > > > counters should be processed to ensure the respective values have been
> > > > reset and folded into the zone specific 'vm_stat[]'. That being said, it
> > > > can only occur when: the idle tick was previously stopped, and
> > > > reprogramming of the timer is not required.
> > > > 
> > > > A customer provided some evidence which indicates that the idle tick was
> > > > stopped; albeit, CPU-specific vmstat counters still remained populated.
> > > > Thus one can only assume quiet_vmstat() was not invoked on return to the
> > > > idle loop.
> > > 
> > > Why did housekeeping CPUs fail to do their works, with this assumption
> > > put aside?
> > 
> > Hi Hillf,
> > 
> > I'm not sure I understand your question.
> > 
> > In this context, when tick processing is stopped, delayed work is not going
> > to be handled until the CPU exits idle.
> 
> Given work canceled because per-CPU pages can be freed remotely from
> housekeeping CPUs (see patch 3/5), what is added here is not needed.
> 
> IOW which one is incorrect?
> 
> BTW given delayed work is not going to be handled until the CPU exits idle,

Hi Hilf,

The comment on the codebase now is:

void quiet_vmstat(void)
{
        if (system_state != SYSTEM_RUNNING)
                return;

        if (!delayed_work_pending(this_cpu_ptr(&vmstat_work)))
                return;

        if (!need_update(smp_processor_id()))
                return;
        
        /*
         * Just refresh counters and do not care about the pending delayed
         * vmstat_update. It doesn't fire that often to matter and canceling
         * it would be too expensive from this path.
         * vmstat_shepherd will take care about that for us.
         */
        refresh_cpu_vm_stats(false);
}

However this is incorrect. The pending delayed work is only cancelled
when executed and not requeued from:

static void vmstat_update(struct work_struct *w)
{
        if (refresh_cpu_vm_stats(true)) {
                /*
                 * Counters were updated so we expect more updates
                 * to occur in the future. Keep on running the
                 * update worker thread.
                 */
                queue_delayed_work_on(smp_processor_id(), mm_percpu_wq,
                                this_cpu_ptr(&vmstat_work),
                                round_jiffies_relative(sysctl_stat_interval));
        }
}

Since this patchset changes the synchronization to happen at return to
userspace or entering idle, we do want to cancel that work (which, after
synchronization, is not necessary).

> canceling work is noop in 3/5, despite what the vmstat shepherd does depends
> not on tick.

Canceling work is a not a noop in 3/5: If the work is not cancelled (if 3/5 
is dropped), there will be a pending work to be executed, from the kworker thread 
on an isolated CPU. Which is undesired for a fully isolated CPU, with no
interruptions.

