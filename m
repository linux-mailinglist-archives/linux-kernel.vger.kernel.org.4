Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF686BCFEF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 13:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjCPMyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 08:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjCPMyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 08:54:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB931DB99
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 05:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678971210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b/kZQV0Z3sunLtF+IrcBAzynIpOwC3dQjG7Vc/z2Nlc=;
        b=iAe1V4kgXNFz+cPe2Y6EpPCeVSg/joetTpFf+IsrxqP/2ZgFwBFrRi6ZQuISUENv4LME9m
        0BGzVYyS4OyQI0+UyoIHGTRVYsK1L1G9ixwrYGteGGrZ02DiNVkS45C8r9BwfzyyPMRhfQ
        C6MkVTx8+pGBV3bRCHKqkBQQMXl+62A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-48-u3-SW79xMM65lTz3EbCLqQ-1; Thu, 16 Mar 2023 08:53:29 -0400
X-MC-Unique: u3-SW79xMM65lTz3EbCLqQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B62FE85A5A3;
        Thu, 16 Mar 2023 12:53:28 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 17FCC202701E;
        Thu, 16 Mar 2023 12:53:28 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 0C2F54039030F; Thu, 16 Mar 2023 07:54:29 -0300 (-03)
Date:   Thu, 16 Mar 2023 07:54:29 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 02/11] this_cpu_cmpxchg: ARM64: switch
 this_cpu_cmpxchg to locked, add _local function
Message-ID: <ZBL1ZToOqV5aKX49@tpad>
References: <20230209150150.380060673@redhat.com>
 <20230209153204.683821550@redhat.com>
 <df9e3ddc-e3be-4ceb-af7f-e5557b9228df@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df9e3ddc-e3be-4ceb-af7f-e5557b9228df@gentwo.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 12:56:20AM +0100, Christoph Lameter wrote:
> On Thu, 9 Feb 2023, Marcelo Tosatti wrote:
> 
> > Goal is to have vmstat_shepherd to transfer from
> > per-CPU counters to global counters remotely. For this,
> > an atomic this_cpu_cmpxchg is necessary.
> 
> The definition for this_cpu_functionality is that it is *not* incurring
> atomic overhead and it was introduced to *avoid* the overhead of atomic
> operations.
> 
> This sabotages this_cpu functionality,

Christoph,

Two points:

1) If you look at patch 6, users of this_cpu_cmpxchg are converted
to this_cpu_cmpxchg_local (except per-CPU vmstat counters).
Its up to the user of the interface, depending on its requirements,
to decide whether or not atomic operations are necessary
(atomic with reference to other processors).

this_cpu_cmpxchg still has the benefits of use of segment registers:

:Author: Christoph Lameter, August 4th, 2014
:Author: Pranith Kumar, Aug 2nd, 2014

this_cpu operations are a way of optimizing access to per cpu
variables associated with the *currently* executing processor. This is
done through the use of segment registers (or a dedicated register where
the cpu permanently stored the beginning of the per cpu area for a
specific processor).

this_cpu operations add a per cpu variable offset to the processor
specific per cpu base and encode that operation in the instruction
operating on the per cpu variable.

This means that there are no atomicity issues between the calculation of
the offset and the operation on the data. Therefore it is not
necessary to disable preemption or interrupts to ensure that the
processor is not changed between the calculation of the address and
the operation on the data.

2) The performance results seem to indicate that 
cache locking is effective on modern processors (on this particular case and others as well):

4b23a68f953628eb4e4b7fe1294ebf93d4b8ceee mm/page_alloc: protect PCP lists with a spinlock

    As preparation for dealing with both of those problems, protect the
    lists with a spinlock.  The IRQ-unsafe version of the lock is used
    because IRQs are already disabled by local_lock_irqsave.  spin_trylock
    is used in combination with local_lock_irqsave() but later will be
    replaced with a spin_trylock_irqsave when the local_lock is removed.

    The per_cpu_pages still fits within the same number of cache lines after
    this patch relative to before the series.

    struct per_cpu_pages {
            spinlock_t                 lock;                 /*     0     4 */
            int                        count;                /*     4     4 */
            int                        high;                 /*     8     4 */
            int                        batch;                /*    12     4 */
            short int                  free_factor;          /*    16     2 */
            short int                  expire;               /*    18     2 */

            /* XXX 4 bytes hole, try to pack */

            struct list_head           lists[13];            /*    24   208 */

            /* size: 256, cachelines: 4, members: 7 */
            /* sum members: 228, holes: 1, sum holes: 4 */
            /* padding: 24 */
    } __attribute__((__aligned__(64)));

    There is overhead in the fast path due to acquiring the spinlock even
    though the spinlock is per-cpu and uncontended in the common case.  Page
    Fault Test (PFT) running on a 1-socket reported the following results on a
    1 socket machine.

                                         5.19.0-rc3               5.19.0-rc3
                                            vanilla      mm-pcpspinirq-v5r16
    Hmean     faults/sec-1   869275.7381 (   0.00%)   874597.5167 *   0.61%*
    Hmean     faults/sec-3  2370266.6681 (   0.00%)  2379802.0362 *   0.40%*
    Hmean     faults/sec-5  2701099.7019 (   0.00%)  2664889.7003 *  -1.34%*
    Hmean     faults/sec-7  3517170.9157 (   0.00%)  3491122.8242 *  -0.74%*
    Hmean     faults/sec-8  3965729.6187 (   0.00%)  3939727.0243 *  -0.66%*

And for this case:

To test the performance difference, a page allocator microbenchmark:
https://github.com/netoptimizer/prototype-kernel/blob/master/kernel/mm/bench/page_bench01.c
with loops=1000000 was used, on Intel Core i7-11850H @ 2.50GHz.

For the single_page_alloc_free test, which does

        /** Loop to measure **/
        for (i = 0; i < rec->loops; i++) {
                my_page = alloc_page(gfp_mask);
                if (unlikely(my_page == NULL))
                        return 0;
                __free_page(my_page);
        }

Unit is cycles.

Vanilla                 Patched         Diff
115.25                  117             1.4%

(to be honest, the results are in the noise as well, during the tests
the "LOCK cmpxchg" shows no significant difference to the "cmpxchg"
version for the page allocator benchmark).

