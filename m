Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5169C607BCD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiJUQKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiJUQKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:10:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C6FF9876;
        Fri, 21 Oct 2022 09:10:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A3FC61F0B;
        Fri, 21 Oct 2022 16:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2AA5C433D6;
        Fri, 21 Oct 2022 16:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666368603;
        bh=NZzqyU+bobEWKzEadvtSYF/+VAx77MPAMZ3IBqV2Hl0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LmM4Bmy9Tiahnfw2j7UouzsVbcjxZOVggWesE6VdAlwRXf0pXtTqcsoCw8kUHTtJM
         ijZIu9TAksJIEbTVuD7CXtD1427Pt15UIYLpp+qzo2Y3Fa8YCRcjo/TjxgZ4duGPVF
         1vckVYgpYgfHjurtpZaPL3cBnsF4bGM8k4c9TnhMZ6Aoil+3uoKgwUibXl1NTDuXfi
         5FIIv0PciLlyJYDCnllEwFvbh8CiZDL/HzuKQ+gImEOcTjuWXlGRiSsu8gbfIyFkYK
         RbTtav+ERW963sW//fHdaPpkw5nI2XYhYFYhCad72PkSUARwFNgCwK2z0d06guhX4f
         RQQzOsLPSnVHA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5861B5C0543; Fri, 21 Oct 2022 09:10:03 -0700 (PDT)
Date:   Fri, 21 Oct 2022 09:10:03 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@gentwo.de>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org
Subject: Re: [PATCH rcu 5/8] slab: Explain why SLAB_DESTROY_BY_RCU reference
 before locking
Message-ID: <20221021161003.GL5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221019224652.GA2499358@paulmck-ThinkPad-P17-Gen-1>
 <20221019224659.2499511-5-paulmck@kernel.org>
 <03d5730-9241-542d-76c6-728be4487c4@gentwo.de>
 <20221021134309.GG5600@paulmck-ThinkPad-P17-Gen-1>
 <8504f36a-b6bc-4c46-843e-55d8cd5a1dd0@suse.cz>
 <20221021154224.GJ5600@paulmck-ThinkPad-P17-Gen-1>
 <e6183d91-cb6d-7d14-85d0-3b112a5c7c1f@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6183d91-cb6d-7d14-85d0-3b112a5c7c1f@suse.cz>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 05:50:39PM +0200, Vlastimil Babka wrote:
> On 10/21/22 17:42, Paul E. McKenney wrote:
> > On Fri, Oct 21, 2022 at 03:50:17PM +0200, Vlastimil Babka wrote:
> >> On 10/21/22 15:43, Paul E. McKenney wrote:
> >> > On Fri, Oct 21, 2022 at 09:44:23AM +0200, Christoph Lameter wrote:
> >> >> On Wed, 19 Oct 2022, Paul E. McKenney wrote:
> >> >> 
> >> >> > It is not obvious to the casual user why it is absolutely necessary to
> >> >> > acquire a reference to a SLAB_DESTROY_BY_RCU structure before acquiring
> >> >> > a lock in that structure.  Therefore, add a comment explaining this point.
> >> >> 
> >> >> Sorry but this is not correct and difficult to comprehend.
> >> >> 
> >> >> 1. You do not need a reference to a slab object after it was allocated.
> >> >>    Objects must be properly protected by rcu_locks.
> >> >> 
> >> >> 2. Locks are initialized once on slab allocation via a constructor (*not* on object allocation via kmem_cache_alloc)
> >> >> 
> >> >> 3. Modifying locks at allocation/free is not possible since references to
> >> >>    these objects may still persist after free and before alloc.
> >> >> 
> >> >> 4. The old term SLAB_DESTROY_BY_RCU is used here.
> >> > 
> >> > Thank you for looking this over, but Vlastimil beat you to it.  How does
> >> > the update below look?
> >> 
> >> LGTM.
> > 
> > May I please have your ack?
> > 
> > 							Thanx, Paul
> > 
> >> > ------------------------------------------------------------------------
> >> > 
> >> > commit ff4c536e6b44e2e185e38c3653851f92e07139da
> >> > Author: Paul E. McKenney <paulmck@kernel.org>
> >> > Date:   Mon Sep 26 08:57:56 2022 -0700
> >> > 
> >> >     slab: Explain why SLAB_TYPESAFE_BY_RCU reference before locking
> >> >     
> >> >     It is not obvious to the casual user why it is absolutely necessary to
> >> >     acquire a reference to a SLAB_TYPESAFE_BY_RCU structure before acquiring
> >> >     a lock in that structure.  Therefore, add a comment explaining this point.
> >> >     
> >> >     [ paulmck: Apply Vlastimil Babka feedback. ]
> >> >     
> >> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >> 
> >> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> It was there :)

One of those mornings, I guess...

Thank you very much!!!

							Thanx, Paul

> >> >     Cc: Christoph Lameter <cl@linux.com>
> >> >     Cc: Pekka Enberg <penberg@kernel.org>
> >> >     Cc: David Rientjes <rientjes@google.com>
> >> >     Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >> >     Cc: Andrew Morton <akpm@linux-foundation.org>
> >> >     Cc: Vlastimil Babka <vbabka@suse.cz>
> >> >     Cc: Roman Gushchin <roman.gushchin@linux.dev>
> >> >     Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> >> >     Cc: <linux-mm@kvack.org>
> >> > 
> >> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> >> > index 90877fcde70bd..487418c7ea8cd 100644
> >> > --- a/include/linux/slab.h
> >> > +++ b/include/linux/slab.h
> >> > @@ -76,6 +76,17 @@
> >> >   * rcu_read_lock before reading the address, then rcu_read_unlock after
> >> >   * taking the spinlock within the structure expected at that address.
> >> >   *
> >> > + * Note that it is not possible to acquire a lock within a structure
> >> > + * allocated with SLAB_TYPESAFE_BY_RCU without first acquiring a reference
> >> > + * as described above.  The reason is that SLAB_TYPESAFE_BY_RCU pages
> >> > + * are not zeroed before being given to the slab, which means that any
> >> > + * locks must be initialized after each and every kmem_struct_alloc().
> >> > + * Alternatively, make the ctor passed to kmem_cache_create() initialize
> >> > + * the locks at page-allocation time, as is done in __i915_request_ctor(),
> >> > + * sighand_ctor(), and anon_vma_ctor().  Such a ctor permits readers
> >> > + * to safely acquire those ctor-initialized locks under rcu_read_lock()
> >> > + * protection.
> >> > + *
> >> >   * Note that SLAB_TYPESAFE_BY_RCU was originally named SLAB_DESTROY_BY_RCU.
> >> >   */
> >> >  /* Defer freeing slabs to RCU */
> >> 
> 
