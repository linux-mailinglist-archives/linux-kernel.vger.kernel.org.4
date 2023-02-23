Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A9C6A0D75
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 17:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbjBWQBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 11:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbjBWQBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 11:01:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4D236FF2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 08:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677168025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GgcvtHnEOWjGtnQ2Rt3eSpStNGTeNOXLjTLKJm7KuKI=;
        b=iYwa1YlLT/LFsCygMl8oHQ8oLXQ9Y6mrnaJag0urMhCQx06DVyBWohY34eMdPq6xNdlZOo
        jSFXFKGk9PaNmeEAr2pEJ/kFvL6S+iObhDpMnTKSctAZEOOoPjvVRGH7C0BuOs4/43hLA1
        kvM9YvtZ0PtFFIu7f7s0+s+2m78CtQo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-S2kTqbv0Oli32z3bynY_9g-1; Thu, 23 Feb 2023 11:00:19 -0500
X-MC-Unique: S2kTqbv0Oli32z3bynY_9g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9A9F38041CA;
        Thu, 23 Feb 2023 16:00:12 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 985FD404BEC1;
        Thu, 23 Feb 2023 16:00:12 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id AFF64400E065E; Thu, 23 Feb 2023 11:54:53 -0300 (-03)
Date:   Thu, 23 Feb 2023 11:54:53 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 00/11] fold per-CPU vmstats remotely
Message-ID: <Y/d+PTnMoUFU1TAd@tpad>
References: <20230209150150.380060673@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209150150.380060673@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 12:01:50PM -0300, Marcelo Tosatti wrote:
> This patch series addresses the following two problems:
> 
>     1. A customer provided some evidence which indicates that
>        the idle tick was stopped; albeit, CPU-specific vmstat
>        counters still remained populated.
> 
>        Thus one can only assume quiet_vmstat() was not
>        invoked on return to the idle loop. If I understand
>        correctly, I suspect this divergence might erroneously
>        prevent a reclaim attempt by kswapd. If the number of
>        zone specific free pages are below their per-cpu drift
>        value then zone_page_state_snapshot() is used to
>        compute a more accurate view of the aforementioned
>        statistic.  Thus any task blocked on the NUMA node
>        specific pfmemalloc_wait queue will be unable to make
>        significant progress via direct reclaim unless it is
>        killed after being woken up by kswapd
>        (see throttle_direct_reclaim())
> 
>     2. With a SCHED_FIFO task that busy loops on a given CPU,
>        and kworker for that CPU at SCHED_OTHER priority,
>        queuing work to sync per-vmstats will either cause that
>        work to never execute, or stalld (i.e. stall daemon)
>        boosts kworker priority which causes a latency
>        violation
> 
> By having vmstat_shepherd flush the per-CPU counters to the
> global counters from remote CPUs.
> 
> This is done using cmpxchg to manipulate the counters,
> both CPU locally (via the account functions),
> and remotely (via cpu_vm_stats_fold).
> 
> Thanks to Aaron Tomlin for diagnosing issue 1 and writing
> the initial patch series.
> 
> v2:
> - actually use LOCK CMPXCHG on counter mod/inc/dec functions
>   (Christoph Lameter)
> - use try_cmpxchg for cmpxchg loops
>   (Uros Bizjak / Matthew Wilcox)
> 
> 
>  arch/arm64/include/asm/percpu.h     |   16 ++-
>  arch/loongarch/include/asm/percpu.h |   23 ++++
>  arch/s390/include/asm/percpu.h      |    5 +
>  arch/x86/include/asm/percpu.h       |   39 ++++----
>  include/asm-generic/percpu.h        |   17 +++
>  include/linux/mmzone.h              |    3 
>  kernel/fork.c                       |    2 
>  kernel/scs.c                        |    2 
>  mm/vmstat.c                         |  424 ++++++++++++++++++++++++++++++++++++++++++++++++------------------------------------------
>  9 files changed, 308 insertions(+), 223 deletions(-)

Friendly ping, any other concern with this series?

If not, ACKed-by or Reviewed-by's would be welcome.


