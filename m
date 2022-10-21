Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6FD606EA6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 06:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiJUEIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 00:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiJUEI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 00:08:29 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661B91BA1E1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 21:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666325308; x=1697861308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bf5sIebrRjerkXBiHhejNDTo9YDTgaUUT5P8ABmQ1vI=;
  b=Eg81x3J76Mf7d3uluRNPcSmBM2ROPoaGoPZgx9+txOWqOw4CFI9dNKXe
   yZpIXEXxsm+/xxjfBaXX3hWYW+EmZEp/1GFBfjp0jujxIGVmhk69hoK9V
   z0O+oNQnSjBXRvjYb0G/l6RzP5meBj1qnL6ZSf2fiP6Pb9oT7EFcXXRye
   QDAYC3lluDWr1qtt2Sygax2N+2QaEHvJQxqJwWEkpaNIeQUo6ajfebXff
   Uq+VEa9ewKWgUgjKxffpwGvFeUPYsbp3ZKHlkPRhmiKjFK4/peeBPgVGA
   lQNusfAo6xg7qcKRb+8Xo55fdMpT9IwMlvv5xpwk0bpn6aEUkXNfIBO9K
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="308589160"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="308589160"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 21:08:25 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="735297385"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="735297385"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 21:08:25 -0700
Date:   Thu, 20 Oct 2022 21:08:24 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] mm, hwpoison: Try to recover from copy-on write faults
Message-ID: <Y1IbOAvpGzA8bst1@agluck-desk3.sc.intel.com>
References: <SJ1PR11MB60838C1F65CA293188BB442DFC289@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20221019170835.155381-1-tony.luck@intel.com>
 <893b681b-726e-94e3-441e-4d68c767778a@linux.alibaba.com>
 <Y1GqGbBNk6fX/OnD@agluck-desk3.sc.intel.com>
 <359bae4e-6ce3-cc7e-33d0-252064157bc6@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <359bae4e-6ce3-cc7e-33d0-252064157bc6@linux.alibaba.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 09:52:01AM +0800, Shuai Xue wrote:
> 
> 
> 在 2022/10/21 AM4:05, Tony Luck 写道:
> > On Thu, Oct 20, 2022 at 09:57:04AM +0800, Shuai Xue wrote:
> >>
> >>
> >> 在 2022/10/20 AM1:08, Tony Luck 写道:

> > I'm experimenting with using sched_work() to handle the call to
> > memory_failure() (echoing what the machine check handler does using
> > task_work)_add() to avoid the same problem of not being able to directly
> > call memory_failure()).
> 
> Work queues permit work to be deferred outside of the interrupt context
> into the kernel process context. If we return to user-space before the
> queued memory_failure() work is processed, we will take the fault again,
> as we discussed recently.
> 
>     commit 7f17b4a121d0d ACPI: APEI: Kick the memory_failure() queue for synchronous errors
>     commit 415fed694fe11 ACPI: APEI: do not add task_work to kernel thread to avoid memory leak
> 
> So, in my opinion, we should add memory failure as a task work, like
> do_machine_check does, e.g.
> 
>     queue_task_work(&m, msg, kill_me_maybe);

Maybe ... but this case isn't pending back to a user instruction
that is trying to READ the poison memory address. The task is just
trying to WRITE to any address within the page.

So this is much more like a patrol scrub error found asynchronously
by the memory controller (in this case found asynchronously by the
Linux page copy function).  So I don't feel that it's really the
responsibility of the current task.

When we do return to user mode the task is going to be busy servicing
a SIGBUS ... so shouldn't try to touch the poison page before the
memory_failure() called by the worker thread cleans things up.

> > +	INIT_WORK(&p->work, do_sched_memory_failure);
> > +	p->pfn = pfn;
> > +	schedule_work(&p->work);
> > +}
> 
> I think there is already a function to do such work in mm/memory-failure.c.
> 
> 	void memory_failure_queue(unsigned long pfn, int flags)

Also pointed out by Miaohe Lin <linmiaohe@huawei.com> ... this does
exacly what I want, and is working well in tests so far. So perhaps
a cleaner solution than making the kill_me_maybe() function globally
visible.

-Tony
