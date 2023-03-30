Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615EC6D06BA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjC3N3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbjC3N3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:29:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E92A5FE
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 06:28:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 15FC321A4E;
        Thu, 30 Mar 2023 13:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680182933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3wzkcoa7Mihtj9UNRxQh22SXDR3QABl+wSSlCghODgg=;
        b=gvETP0ewtc0Ul0ZpGOqUt9Yp3FS7/2Q0XqMw9CaX97ZRMz3tveUL7AOHe7jahtIcVRoeHP
        oXO228EQnaPtNCFbTD8sXDAbdHwiMtiyH+9O5eM9Mah6lg6Evz4V+m+g4blsQm2+V/Lr9s
        4IG5CQxIeBNlxSc5enE6unLkLQU9nQs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E4FF01348E;
        Thu, 30 Mar 2023 13:28:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id b3m5NZSOJWTuCQAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 30 Mar 2023 13:28:52 +0000
Date:   Thu, 30 Mar 2023 15:28:52 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Frederic Weisbecker <fweisbecker@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonardo Bras <leobras@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] sched/isolation: Add cpu_is_isolated() API
Message-ID: <ZCWOlHmyO1YREEGt@dhcp22.suse.cz>
References: <20230317134448.11082-1-mhocko@kernel.org>
 <20230317134448.11082-2-mhocko@kernel.org>
 <ZBSyaVk919Fi07Wv@tpad>
 <ZBSy2QZYZRtCNBd8@tpad>
 <ZBVwlv+Mi+GfR1E3@dhcp22.suse.cz>
 <ZB4lt3IaPWVmn41n@localhost.localdomain>
 <ZCFu9jFm/rskeNlM@tpad>
 <ZCLT8iH2ltmQ40my@dhcp22.suse.cz>
 <ZCRJJRz01vX8jPjb@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZCRJJRz01vX8jPjb@tpad>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29-03-23 11:20:21, Marcelo Tosatti wrote:
> On Tue, Mar 28, 2023 at 01:48:02PM +0200, Michal Hocko wrote:
> > On Mon 27-03-23 07:24:54, Marcelo Tosatti wrote:
> > > On Fri, Mar 24, 2023 at 11:35:35PM +0100, Frederic Weisbecker wrote:
> > > > Le Sat, Mar 18, 2023 at 09:04:38AM +0100, Michal Hocko a écrit :
> > > > > On Fri 17-03-23 15:35:05, Marcelo Tosatti wrote:
> > [...]
> > > > > > Actually introducing cpu_is_isolated() seems fine, but it can call
> > > > > > housekeeping_test_cpu(cpu, HK_TYPE_TICK) AFAICS.
> > > > >  
> > > > > This is not really my area. Frederic, could you have a look please?
> > > > 
> > > > The point is to have a function that tells if either nohz_full= or
> > > > isolcpus=[domain] has been passed for the given CPU.
> > > > 
> > > > Because I assumed that both would be interested in avoiding that flush
> > > > noise, wouldn't it be the case?
> > > 
> > > Yes, that is the case. But as a note: for the two main types of
> > > configuration performed (one uses isolcpus=[domain] and the other
> > > cgroups, for isolating processes) nohz_full= is always set.
> > > 
> > > So just testing for nohz_full= would be sufficient (which perhaps would
> > > make the code simpler).
> > 
> > I do not see any mention about that assumption under Documentation/. 
> 
> Documentation/admin-guide/kernel-per-CPU-kthreads.rst
> 
> SCHED_SOFTIRQ
> -------------
> 
> Do all of the following:
> 
> 1.      Avoid sending scheduler IPIs to the CPU to be de-jittered,
>         for example, ensure that at most one runnable kthread is present
>         on that CPU.  If a thread that expects to run on the de-jittered
>         CPU awakens, the scheduler will send an IPI that can result in
>         a subsequent SCHED_SOFTIRQ.
> 2.      CONFIG_NO_HZ_FULL=y and ensure that the CPU to be de-jittered
>         is marked as an adaptive-ticks CPU using the "nohz_full="
>         boot parameter.  This reduces the number of scheduler-clock
>         interrupts that the de-jittered CPU receives, minimizing its
>         chances of being selected to do the load balancing work that
>         runs in SCHED_SOFTIRQ context.

Quite hidden and easy to miss if you are only aware of isolcpus.

> > Is this a best practice documented anywhere or it just happens to be
> > the case with workloads you deal with?
> 
> Option 2. However Frederic seems interested in matching the exported
> toggles with the known use-cases classes.
> 
> For example, for this guide:
> http://www.comfilewiki.co.kr/en/doku.php?id=comfilepi:improving_real-time_performance:index
> 
> Using nohz_full= would be a benefit (and its not being currently set,
> perhaps due to not knowing all the options?).
> 
> http://www.comfilewiki.co.kr/en/doku.php?id=comfilepi:improving_real-time_performance:index
> 
> 
> AFAIU the workloads for which disabling nohz_full= is a benefit are those
> where the switching between nohz full mode and sched tick enabled mode
> and vice-versa (which involve programming the local timer) happens
> often and is therefore avoidable? For example switching between 1
> runnable task and more than 1 runnable task (and vice versa).

The patch from Frederic is testing for both. You seem to be arguing to
reduce the test and I still do not understand why. Sure some workloads
(following the above) will likely use nohz_full= as well but does it
make sense to build that expectation into the higher level logic? What
is an actual benefit?

-- 
Michal Hocko
SUSE Labs
