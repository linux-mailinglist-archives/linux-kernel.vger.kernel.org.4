Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887C56065D2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJTQcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiJTQcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:32:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF84B1AFABF;
        Thu, 20 Oct 2022 09:31:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A62161C55;
        Thu, 20 Oct 2022 16:31:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54E3C433C1;
        Thu, 20 Oct 2022 16:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666283518;
        bh=m0e5s+7vjQK6i5I/82ZYyoeq25NadpHcQ6GXllTid18=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PIucaDp1d5kUDRaubYsxusNCAuDLzpDrQg7XAAKUe9nrcLJT93KOsjevUkIYF6EmQ
         uu6qrTdk/2zLKxOZMPq/tl5OdS9BXAVTZI48XhBRneYRp4zaW0sbWipBMKjjs1BrLh
         PQbNGFIcoD5XNbZBR00fKVsinXtbd9/zzk8aJ6xBv2fhejhScTNAebmzYsGq10Zwst
         81cWXGN+stTDtL4IHBG22EVq7UvxJd9yPEz9WhhJY0AjN9AITfEWgIfEoqDhZc6Hxs
         V/egd3ESGZWdk7C16Cre2i9NykIKIWec5ULpASlJNh0cwE+gJsG+7cp+Vt5A/eXvGQ
         xjrERUBjBE8WQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 62E865C04D0; Thu, 20 Oct 2022 09:31:58 -0700 (PDT)
Date:   Thu, 20 Oct 2022 09:31:58 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org
Subject: Re: [PATCH rcu 5/8] slab: Explain why SLAB_DESTROY_BY_RCU reference
 before locking
Message-ID: <20221020163158.GP5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221019224652.GA2499358@paulmck-ThinkPad-P17-Gen-1>
 <20221019224659.2499511-5-paulmck@kernel.org>
 <4a29b39a-b9b5-9c95-e43a-9e5f87801786@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a29b39a-b9b5-9c95-e43a-9e5f87801786@suse.cz>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 09:10:49AM +0200, Vlastimil Babka wrote:
> On 10/20/22 00:46, Paul E. McKenney wrote:
> > It is not obvious to the casual user why it is absolutely necessary to
> > acquire a reference to a SLAB_DESTROY_BY_RCU structure before acquiring
> > a lock in that structure.  Therefore, add a comment explaining this point.
> 
> s/SLAB_DESTROY_BY_RCU/SLAB_TYPESAFE_BY_RCU/ in subject, commit log and the
> added comment? :)

Boy, I was certainly living in the past when I did this patch, wasn't I?

Thank you, will fix on next rebase.

> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Christoph Lameter <cl@linux.com>
> > Cc: Pekka Enberg <penberg@kernel.org>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Cc: <linux-mm@kvack.org>
> > ---
> >  include/linux/slab.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index 90877fcde70bd..446303e385265 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -76,6 +76,12 @@
> >   * rcu_read_lock before reading the address, then rcu_read_unlock after
> >   * taking the spinlock within the structure expected at that address.
> >   *
> > + * Note that it is not possible to acquire a lock within a structure
> > + * allocated with SLAB_DESTROY_BY_RCU without first acquiring a reference
> > + * as described above.  The reason is that SLAB_DESTROY_BY_RCU pages are
> > + * not zeroed before being given to the slab, which means that any locks
> > + * must be initialized after each and every kmem_struct_alloc().
> > + *
> 
> Wonder if slab caches with a constructor should be OK here as AFAIK it
> should mean the object has to be in the initialized state both when
> allocated and freed?

It does look that way, thank you!

And __i915_request_ctor(), sighand_ctor(), and anon_vma_ctor() actually
do this, initializing a lock in the process.

The ctor function could just initialize the locks, and all would be well.
In addition, this makes sequence-lock-like approaches a bit easier, as in
"just use a sequence lock".

I will update with attribution.

							Thanx, Paul

> >   * Note that SLAB_TYPESAFE_BY_RCU was originally named SLAB_DESTROY_BY_RCU.
> >   */
> >  /* Defer freeing slabs to RCU */
> 
