Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2181691444
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 00:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjBIXTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 18:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjBIXTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 18:19:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBA82748C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 15:19:41 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675984778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KNBAizjZNrVbj6pu64DG8DfhaakV1VisWaDQqQ90zu4=;
        b=lmDhAP1PQMG2F0l6M/QJaBtsmc9DkUkHKzdMPAZ5U/UHcjh8SOqbIBGFq9gBkxmGtxZcPv
        rVd/IabCM5zxTh5bsnS8+W1Q1c5S9OmKcHv0ioCw4AXrtBfGPDhYXjqoydMJZQVisjLuxK
        VGb1rXri4AhIfKr4qd8ToCPOwcX3ehu8r8v+/VyXHtOZbzKSVgmhyw3Z9qnEWyaB07f6uZ
        2hDhcCoGpibZdMS0xqDzlxCjqN32sJ6omeybEyENes49sCcDZK8BSgWNwnMGPyFyjyAgl0
        9wHTKSr94+ytBY6/cEjfZMM7ZAMx0InU5JSWvQ1Ddyv1dCRParVEyhJv90t1Ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675984778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KNBAizjZNrVbj6pu64DG8DfhaakV1VisWaDQqQ90zu4=;
        b=S+GJCt6IlD44szHumRK564PyKeEcwcKJMXnI8vs0nAARVs0FVWrqyh74z/i8zQ4GvuSniE
        Z3WMNSsvckHj1oCQ==
To:     Matthew Wilcox <willy@infradead.org>
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
In-Reply-To: <Y+VXamju0ECWYR5y@casper.infradead.org>
References: <202302011308.f53123d2-oliver.sang@intel.com>
 <87o7qdzfay.ffs@tglx> <9a682773-df56-f36c-f582-e8eeef55d7f8@suse.cz>
 <875ycdwyx6.ffs@tglx> <871qn1wofe.ffs@tglx>
 <6c0b681e-97bc-d975-a8b9-500abdaaf0bc@suse.cz>
 <8b7762c3-02be-a5c9-1c4d-507cfb51a15c@suse.cz> <87edr1uykw.ffs@tglx>
 <e3a8f265-ea15-35ba-e46e-89024e83db47@suse.cz> <878rh73mxl.ffs@tglx>
 <Y+VXamju0ECWYR5y@casper.infradead.org>
Date:   Fri, 10 Feb 2023 00:19:38 +0100
Message-ID: <87h6vu1l6d.ffs@tglx>
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

On Thu, Feb 09 2023 at 20:28, Matthew Wilcox wrote:
> On Wed, Feb 08, 2023 at 09:46:30PM +0100, Thomas Gleixner wrote:
>> The issue is that there might be maple_tree users which depend on
>> GFP_ATOMIC, but call in from interrupt enabled context, which is
>> legitimate today.
>> 
>> Willy might have some insight on that.
>
> Not today, but eventually.  There are XArray users which modify the tree
> in interrupt context or under some other spinlock that we can't drop
> for them in order to do an allocation.  And I want to replace the radix
> tree underpinnings of the XArray with the maple tree.  In my copious
> spare time.

If any usage which you described, i.e. interrupt context or with a
spinlock held, where interrupts were disabled on acquisition of the
lock, ends up calling into kmem_cache_alloc_bulk() today, then that's
broken because kmem_cache_alloc_bulk() reenables interrupts
unconditionally.

So either such code does not exist as of today or it just gets lucky to
not run into the code path leading up to kmem_cache_alloc_bulk().

We have to clarify what the valid calling convention of
kmem_cache_alloc_bulk() is in the regular kernel context, i.e. outside
of early boot.

Thanks,

        tglx



