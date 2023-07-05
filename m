Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABA47488C9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 18:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbjGEQBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 12:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbjGEQBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 12:01:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDC91FFC
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 09:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688572774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3BHk3BJu6uKLeym+GkO2TX4kGRjzXnZU8li/D4qz6iI=;
        b=ehe4pqoWVl4L2j4PfCVQc9VR9a/51iBPreaMsDGH1zsks+BojXpvZMb0gcKUSYj0WJay+D
        seq9rPYPzjqnkvSzAU1iXpV0fSQ8UElsTh89F6erDepB86pEYqaQCMCOUaYj/Egqh7O+kK
        wh/c52M4ZxrW3f2YC/FCJhtocT8y++s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-EZpf5dOLMUO9FJLfSCL7ag-1; Wed, 05 Jul 2023 11:59:31 -0400
X-MC-Unique: EZpf5dOLMUO9FJLfSCL7ag-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F943800B35;
        Wed,  5 Jul 2023 15:59:31 +0000 (UTC)
Received: from fedora (unknown [10.22.16.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA677F5CF8;
        Wed,  5 Jul 2023 15:59:29 +0000 (UTC)
Date:   Wed, 5 Jul 2023 12:59:28 -0300
From:   Wander Lairson Costa <wander@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, juri.lelli@redhat.com
Subject: Re: Splat in kernel RT while processing incoming network packets
Message-ID: <6cmltsaeqjcekglutpnp4lxyqnjng5m4w73ae4btwrivuxvptf@zmhahab7643i>
References: <bkw2aao62e3ppg7332dbhycgzdwr7k5brezj3bcij6zewphmnd@eigmbvjh6wuu>
 <20230703142908.RcxjjF_E@linutronix.de>
 <x6d2ae4ss4wvvuib2hmop6ztysjsbyno7gbjkyek5xng2kmgyd@yfmnfognlj5n>
 <20230704100527.75hMNZ35@linutronix.de>
 <a4ed5a8cc35f34a3cb11aded76b0f289c658c1a7.camel@redhat.com>
 <20230704144749.wJUlub6-@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230704144749.wJUlub6-@linutronix.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 04:47:49PM +0200, Sebastian Andrzej Siewior wrote:
> On 2023-07-04 12:29:33 [+0200], Paolo Abeni wrote:
> > Just to hopefully clarify the networking side of it, napi instances !=
> > network backlog (used by RPS). The network backlog (RPS) is available
> > for all the network devices, including the loopback and all the virtual
> > ones. 
> 
> Yes.
> 
> > The napi instances (and the threaded mode) are available only on
> > network device drivers implementing the napi model. The loopback driver
> > does not implement the napi model, as most virtual devices and even
> > some H/W NICs (mostily low end ones).
> 
> Yes.
> 
> > The network backlog can't run in threaded mode: there is no API/sysctl
> > nor infrastructure for that. The backlog processing threaded mode could
> > be implemented, even if should not be completely trivial and it sounds
> > a bit weird to me.
> 
> Yes, I mean that this needs to be done.
> 
> > 
> > Just for the records, I mentioned the following in the bz:
> > 
> > It looks like flush_smp_call_function_queue() has 2 only callers,
> > migration, and do_idle().
> > 
> > What about moving softirq processing from
> > flush_smp_call_function_queue() into cpu_stopper_thread(), outside the
> > unpreemptable critical section?
> 
> This doesn't solve anything. You schedule softirq from hardirq and from
> this moment on you are in "anonymous context" and we solve this by
> processing it in ksoftirqd.
> For !RT you process it while leaving the hardirq. For RT, we can't.
> Processing it in the context of the currently running process (say idle
> as in the reported backtrace or an another running user task) would lead
> to processing network related that originated somewhere at someone
> else's expense. Assume you have a high prio RT task running, not related
> to networking at all, and suddenly you throw a bunch of skbs on it.
> 
> Therefore it is preferred to process them within the interrupt thread in
> which the softirq was raised/ within its origin.
> 
> The other problem with ksoftirqd processing is that everything is added
> to a global state and then left for ksoftirqd to process. The global
> state is considered by every local_bh_enable() instance so random
> interrupt thread could process it or even a random task doing a syscall
> involving spin_lock_bh().
> 
> The NAPI-threads are nice in a way that they don't clobber the global
> state.
> For RPS we would need either per-CPU threads or serve this in
> ksoftirqd/X. The additional thread per-CPU makes only sense if it runs
> at higher priority. However without the priority it would be no
> different to ksoftirqd unless it does only the backlog's work.
> 
> puh. I'm undecided here. We might want to throw it into ksoftirqd,
> remove the warning. But then this will be processed with other softirqs
> (like USB due to tasklet) and at some point and might be picked up by
> another interrupt thread.
> 

Maybe, under RT, some softirq should run in the context of the "target"
process. For NET_RX, for example, the softirq's would run in the context
of the packet recipient process. Each task_struct would have a list of
pending softirq, which would be checked in a few points, like on scheduling,
when the process enters in the kernel, softirq raise, etc. The default
target process would be ksoftirqd. Does this idea make sense?

> > Cheers,
> > 
> > Paolo
> 
> Sebastian
> 

