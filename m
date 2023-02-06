Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF8568C572
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 19:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjBFSK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 13:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjBFSKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 13:10:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8532D22DD4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 10:10:04 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675707002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pnsD8O7AGv/ghgX6NFYa+KhfEm1cKVXyeecAuGcrGc8=;
        b=LCDwQx6rF0S2wMbs06qsNSIV4PMAkOB0SpBJVrqteSNNl07N6FwgDkuRqLWd7BSNEJeFtz
        jCF4wUQHomXrDBAYxj3i3GkJTPOe6nJ+l4vjkq4O0ukdsXZNyAEeWwJ9I1j7apBrwBE2xa
        ByS0kIH6UgWjoBkTSQVVF6CrlNjHYEgYdfL2dmsgFDMJKT77W9SN5E6qDVtM3lM9Ps67UO
        F1oc/bij8jbkXvFzYJpWMdMLUROkOg444nXbwSQl1iuONGjSKUuSCturmYAXwgKyAs8fGL
        ay8xfQ0jccYiqLArCDrpE/wWtiJPAehxzUN76X6ngkm6cx0vx9Zqtb8Ly5gQtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675707002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pnsD8O7AGv/ghgX6NFYa+KhfEm1cKVXyeecAuGcrGc8=;
        b=v854839Ja9qHeAUoo9A55MaeyPfSfr0iCQhaDj0DVimhoIEUpf0w9aY3/4tsed5i7CZoVQ
        XedNHdH6dBvFe2Aw==
To:     Vlastimil Babka <vbabka@suse.cz>,
        kernel test robot <oliver.sang@intel.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mm@kvack.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 5/5] genirq: Use the maple tree for IRQ descriptors
 management
In-Reply-To: <9a682773-df56-f36c-f582-e8eeef55d7f8@suse.cz>
References: <202302011308.f53123d2-oliver.sang@intel.com>
 <87o7qdzfay.ffs@tglx> <9a682773-df56-f36c-f582-e8eeef55d7f8@suse.cz>
Date:   Mon, 06 Feb 2023 19:10:02 +0100
Message-ID: <87lelay8at.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06 2023 at 15:24, Vlastimil Babka wrote:
> On 2/1/23 14:27, Thomas Gleixner wrote:
>> This triggers because __kmem_cache_alloc_bulk() uses
>> lock_irq()/unlock_irq(). Seems nobody used it during early boot stage
>> yet. Though the maple tree conversion of the interrupt descriptor
>> storage which is the purpose of the patch in question makes that happen.
>> 
>> Fix below.
>
> Looks like it should work. But I think we also need to adjust SLAB's
> mm/slab.c kmem_cache_alloc_bulk() which does local_irq_disable(); /
> local_irq_enable(); right?

Yup.

> Also if we enter this with IRQ's disabled, then we should take care about
> the proper gfp flags. Looking at the patch [1] I see
>
> WARN_ON(mas_store_gfp(&mas, desc, GFP_KERNEL) != 0);
>
> so GFP_KERNEL would be wrong with irqs disabled, looks like a case for
> GFP_ATOMIC.
> OTOH I can see the thing it replaces was:
>
> static RADIX_TREE(irq_desc_tree, GFP_KERNEL);
>
> so that's also a GFP_KERNEL and we haven't seen debug splats from
> might_alloc() checks before in this code?. That's weird, or maybe the
> case

might_alloc()
  might_sleep_if()
    __might_sleep()
      WARN_ON(task->state != RUNNING);  <- Does not trigger
      __might_resched()
        if (.... || system_state == SYSTEM_BOOTING || ...)
           return;

As system_state is SYSTEM_BOOTING at this point the splats are not
happening.

> of "we didn't enable irqs yet on this cpu being bootstrapped" is handled
> differently than "we have temporarily disabled irqs"? Sure, during early
> boot we should have all the memory and no need to reclaim...

The point is that interrupts are fully disabled during early boot and
there is no scheduler so there is no scheduling possible.

Quite some code in the kernel relies on GFP_KERNEL being functional
during that early boot stage. If the kernel runs out of memory that
early, then the chance of recovery is exactly 0.

Thanks,

        tglx

