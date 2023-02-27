Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4926A4B57
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjB0Tmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjB0Tmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:42:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE76626CE8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 11:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677526904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T5EHg8kPWMCSbaL6BDDyElln71bXn4w1AjwdqeSKwPo=;
        b=iQmaOWCsU3XGPvwj2oMBP3H046v0X5T63wZU3OHKbm5ycR/RPCMF3KIcuCgniRK/7mm+1f
        tu3ee+M5sFdXX1Nop7i+mHWtY55aBEVXRECIKEOOXji5LfQHdYfQmbwcrWR8nyLS4QTVSv
        Rt0BTBZ3+Ri1JYs3GC4gTimk7XAOFbc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-9Y3So9MEM_SG5dyC6CCJ3Q-1; Mon, 27 Feb 2023 14:41:40 -0500
X-MC-Unique: 9Y3So9MEM_SG5dyC6CCJ3Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 15529857D07;
        Mon, 27 Feb 2023 19:41:40 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A5613140EBF4;
        Mon, 27 Feb 2023 19:41:39 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id F3A0E403BC530; Mon, 27 Feb 2023 16:41:18 -0300 (-03)
Date:   Mon, 27 Feb 2023 16:41:18 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 00/11] fold per-CPU vmstats remotely
Message-ID: <Y/0HXjDXtMSKlwR8@tpad>
References: <20230209150150.380060673@redhat.com>
 <20230224023410.2940-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224023410.2940-1-hdanton@sina.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 10:34:10AM +0800, Hillf Danton wrote:
> On Thu, Feb 09, 2023 at 12:01:50PM -0300, Marcelo Tosatti wrote:
> > This patch series addresses the following two problems:
> > 
> >     1. A customer provided some evidence which indicates that
> >        the idle tick was stopped; albeit, CPU-specific vmstat
> >        counters still remained populated.
> > 
> >        Thus one can only assume quiet_vmstat() was not
> >        invoked on return to the idle loop. If I understand
> >        correctly, I suspect this divergence might erroneously
> >        prevent a reclaim attempt by kswapd. If the number of
> >        zone specific free pages are below their per-cpu drift
> >        value then zone_page_state_snapshot() is used to
> >        compute a more accurate view of the aforementioned
> >        statistic.  Thus any task blocked on the NUMA node
> >        specific pfmemalloc_wait queue will be unable to make
> >        significant progress via direct reclaim unless it is
> >        killed after being woken up by kswapd
> >        (see throttle_direct_reclaim())
> > 
> >     2. With a SCHED_FIFO task that busy loops on a given CPU,
> >        and kworker for that CPU at SCHED_OTHER priority,
> >        queuing work to sync per-vmstats will either cause that
> >        work to never execute, or stalld (i.e. stall daemon)
> >        boosts kworker priority which causes a latency
> >        violation
> > 
> > By having vmstat_shepherd flush the per-CPU counters to the
> > global counters from remote CPUs.
> > 
> > This is done using cmpxchg to manipulate the counters,
> > both CPU locally (via the account functions),
> > and remotely (via cpu_vm_stats_fold).
> 
> Frankly another case of bandaid[1] ?
> 
> [1] https://lore.kernel.org/lkml/20230223150624.GA29739@lst.de/

Only if you disable per-CPU vmstat counters for isolated CPUs
(then maintenance of the data structures in isolated CPUs is
not necessary).

Which would be terrible for performance, however.


