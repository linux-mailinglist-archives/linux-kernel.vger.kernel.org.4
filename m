Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E353769120F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 21:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjBIU26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 15:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBIU24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 15:28:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6435F5FE67
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 12:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=he0ClzuWWKJzCwIDzxuxkjez/oJOJsB8LaLOV9MDX8g=; b=pXAQMb3eM2KB72Ll+o1pJFiOT+
        5l7DJ5zlqfvYdBpLXaEn4tSw+Oc36zvu/FTCiclOPl/74yiXGVPgXk5Ynwibn1vOveLazir4+YdPW
        9uoR18LdCFL2QmRwWEb582w+IcyTUsqISt7hk2pB3/ug25HYAYbvcjoQuySUicX9kM8fFxSAsG5Nv
        Bu5X4oACwSiiRkjiw7bWUv4Aydu1vfJkTho3THjR4HeyfgpqK9NIGoGPfOWuZ1BLZLyFVzjAFQgfV
        60ObkCVPRr7PQA4rq4R6O5SK0iQDsCzZTkzIybt2c94dEjJTAuDLVz5QqKVq/J+XpH92rcZN9cvYu
        Jxbg4pFQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQDWs-002UZk-L0; Thu, 09 Feb 2023 20:28:26 +0000
Date:   Thu, 9 Feb 2023 20:28:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        kernel test robot <oliver.sang@intel.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mm@kvack.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: mm, slab/slub: Ensure kmem_cache_alloc_bulk() is available early
Message-ID: <Y+VXamju0ECWYR5y@casper.infradead.org>
References: <202302011308.f53123d2-oliver.sang@intel.com>
 <87o7qdzfay.ffs@tglx>
 <9a682773-df56-f36c-f582-e8eeef55d7f8@suse.cz>
 <875ycdwyx6.ffs@tglx>
 <871qn1wofe.ffs@tglx>
 <6c0b681e-97bc-d975-a8b9-500abdaaf0bc@suse.cz>
 <8b7762c3-02be-a5c9-1c4d-507cfb51a15c@suse.cz>
 <87edr1uykw.ffs@tglx>
 <e3a8f265-ea15-35ba-e46e-89024e83db47@suse.cz>
 <878rh73mxl.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rh73mxl.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 09:46:30PM +0100, Thomas Gleixner wrote:
> On Wed, Feb 08 2023 at 10:15, Vlastimil Babka wrote:
> 
> Cc+ Willy
> 
> > On 2/7/23 19:20, Thomas Gleixner wrote:
> >> On Tue, Feb 07 2023 at 15:47, Vlastimil Babka wrote:
> >>> From 340d7c7b99f3e67780f6dec480ed1d27e6f325eb Mon Sep 17 00:00:00 2001
> >>> From: Vlastimil Babka <vbabka@suse.cz>
> >>> Date: Tue, 7 Feb 2023 15:34:53 +0100
> >>> Subject: [PATCH] mm, slab/slub: remove notes that bulk alloc/free needs
> >>>  interrupts enabled
> >>>
> >>> The slab functions kmem_cache_[alloc|free]_bulk() have been documented
> >>> as requiring interrupts to be enabled, since their addition in 2015.
> >>> It's unclear whether that was a fundamental restriction, or an attempt
> >>> to save some cpu cycles by not having to save and restore the irq
> >>> flags.
> >> 
> >> I don't think so. The restriction is rather meant to avoid huge
> >> allocations in atomic context which causes latencies and also might
> >> deplete the atomic reserves.
> >
> > Fair enough.
> >
> >> So I rather avoid that and enforce !ATOMIC mode despite the
> >> local_irq_save/restore() change which is really only to accomodate with
> >> early boot.
> >
> > We could add some warning then? People might use the bulk alloc unknowingly
> > again e.g. via maple tree. GFP_KERNEL would warn through the existing
> > warning, but e.g. GFP_ATOMIC currently not.
> 
> Correct.
> 
> > Some maple tree users could use its preallocation instead outside of the
> > atomic context, when possible.
> 
> Right.
> 
> The issue is that there might be maple_tree users which depend on
> GFP_ATOMIC, but call in from interrupt enabled context, which is
> legitimate today.
> 
> Willy might have some insight on that.

Not today, but eventually.  There are XArray users which modify the tree
in interrupt context or under some other spinlock that we can't drop
for them in order to do an allocation.  And I want to replace the radix
tree underpinnings of the XArray with the maple tree.  In my copious
spare time.
