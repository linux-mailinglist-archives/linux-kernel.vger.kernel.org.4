Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E1C606952
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 22:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiJTUFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 16:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiJTUFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 16:05:49 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DC5134DE8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 13:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666296347; x=1697832347;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Df31rUtnrw/F7hIheI4Cx6bl73pYnzh4BvNXaOx9ZRU=;
  b=ls8JcQ8tvpbfgIk9cbNwS+szM9Alj7gqiq9XdW4ozZhEQ0j5yiWk0yNU
   gYwgLVnhQRyDUDXEvLmRma5/z0QY7+qK+K+FYwL1nGCB9Ghg1U+w3MR8M
   bHpLc0FotI2GGyGNEy5S4JMmbVB+bhzlbqzyt06kKz8GVRm5RsJ9J0LDn
   F81hfGg0ZD8yYv8CHsTeGkRwwdN5wkjWMcBMx4VBmzJaoelECfUA/JSHY
   BjACBvBKCxsyjTc+unNQCe9RS1eQtpRESybQQmzu287Q85bYtiFQDz6Wm
   TYkmZtyzGFTsBmRYl1unMq378akWOwOchqej4Y4PmThjtUo2oVAeh6KAt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="290132342"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="290132342"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 13:05:46 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="632471154"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="632471154"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 13:05:46 -0700
Date:   Thu, 20 Oct 2022 13:05:45 -0700
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
Message-ID: <Y1GqGbBNk6fX/OnD@agluck-desk3.sc.intel.com>
References: <SJ1PR11MB60838C1F65CA293188BB442DFC289@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20221019170835.155381-1-tony.luck@intel.com>
 <893b681b-726e-94e3-441e-4d68c767778a@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <893b681b-726e-94e3-441e-4d68c767778a@linux.alibaba.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 09:57:04AM +0800, Shuai Xue wrote:
> 
> 
> 在 2022/10/20 AM1:08, Tony Luck 写道:
> > If the kernel is copying a page as the result of a copy-on-write
> > fault and runs into an uncorrectable error, Linux will crash because
> > it does not have recovery code for this case where poison is consumed
> > by the kernel.
> > 
> > It is easy to set up a test case. Just inject an error into a private
> > page, fork(2), and have the child process write to the page.
> > 
> > I wrapped that neatly into a test at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/aegl/ras-tools.git
> > 
> > just enable ACPI error injection and run:
> > 
> >   # ./einj_mem-uc -f copy-on-write
> > 
> > Add a new copy_user_highpage_mc() function that uses copy_mc_to_kernel()
> > on architectures where that is available (currently x86 and powerpc).
> > When an error is detected during the page copy, return VM_FAULT_HWPOISON
> > to caller of wp_page_copy(). This propagates up the call stack. Both x86
> > and powerpc have code in their fault handler to deal with this code by
> > sending a SIGBUS to the application.
> 
> Does it send SIGBUS to only child process or both parent and child process?

This only sends a SIGBUS to the process that wrote the page (typically
the child, but also possible that the parent is the one that does the
write that causes the COW).

> > 
> > Note that this patch avoids a system crash and signals the process that
> > triggered the copy-on-write action. It does not take any action for the
> > memory error that is still in the shared page. To handle that a call to
> > memory_failure() is needed. 
> 
> If the error page is not poisoned, should the return value of wp_page_copy
> be VM_FAULT_HWPOISON or VM_FAULT_SIGBUS? When is_hwpoison_entry(entry) or
> PageHWPoison(page) is true, do_swap_page return VM_FAULT_HWPOISON to caller.
> And when is_swapin_error_entry is true, do_swap_page return VM_FAULT_SIGBUS.

The page has uncorrected data in it, but this patch doesn't mark it
as poisoned.  Returning VM_FAULT_SIGBUS would send an "ordinary" SIGBUS
that doesn't include the BUS_MCEERR_AR and "lsb" information. It would
also skip the:

	"MCE: Killing %s:%d due to hardware memory corruption fault at %lx\n"

console message. So might result in confusion and attepmts to debug a
s/w problem with the application instead of blaming the death on a bad
DIMM.

> > But this cannot be done from wp_page_copy()
> > because it holds mmap_lock(). Perhaps the architecture fault handlers
> > can deal with this loose end in a subsequent patch?

I started looking at this for x86 ... but I have changed my mind
about this being a good place for a fix. When control returns back
to the architecture fault handler it no longer has easy access to
the physical page frame number. It has the virtual address, so it
could descend back into somee new mm/memory.c function to get the
physical address ... but that seems silly.

I'm experimenting with using sched_work() to handle the call to
memory_failure() (echoing what the machine check handler does using
task_work)_add() to avoid the same problem of not being able to directly
call memory_failure()).

So far it seems to be working. Patch below (goes on top of original
patch ... well on top of the internal version with mods based on
feedback from Dan Williams ... but should show the general idea)

With this patch applied the page does get unmapped from all users.
Other tasks that shared the page will get a SIGBUS if they attempt
to access it later (from the page fault handler because of
is_hwpoison_entry() as you mention above.

-Tony

From d3879e83bf91cd6c61e12d32d3e15eb6ef069204 Mon Sep 17 00:00:00 2001
From: Tony Luck <tony.luck@intel.com>
Date: Thu, 20 Oct 2022 09:57:28 -0700
Subject: [PATCH] mm, hwpoison: Call memory_failure() for source page of COW
 failure

Cannot call memory_failure() directly from the fault handler because
mmap_lock (and others) are held.

It is important, but not urgent, to mark the source page as h/w poisoned
and unmap it from other tasks.

Use schedule_work() to queue a request to call memory_failure() for the
page with the error.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 mm/memory.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index b6056eef2f72..4a1304cf1f4e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2848,6 +2848,37 @@ static inline int pte_unmap_same(struct vm_fault *vmf)
 	return same;
 }
 
+#ifdef CONFIG_MEMORY_FAILURE
+struct pfn_work {
+	struct work_struct work;
+	unsigned long pfn;
+};
+
+static void do_sched_memory_failure(struct work_struct *w)
+{
+	struct pfn_work *p = container_of(w, struct pfn_work, work);
+
+	memory_failure(p->pfn, 0);
+	kfree(p);
+}
+
+static void sched_memory_failure(unsigned long pfn)
+{
+	struct pfn_work *p;
+
+	p = kmalloc(sizeof *p, GFP_KERNEL);
+	if (!p)
+		return;
+	INIT_WORK(&p->work, do_sched_memory_failure);
+	p->pfn = pfn;
+	schedule_work(&p->work);
+}
+#else
+static void sched_memory_failure(unsigned long pfn)
+{
+}
+#endif
+
 /*
  * Return:
  *	0:		copied succeeded
@@ -2866,8 +2897,10 @@ static inline int __wp_page_copy_user(struct page *dst, struct page *src,
 	unsigned long addr = vmf->address;
 
 	if (likely(src)) {
-		if (copy_mc_user_highpage(dst, src, addr, vma))
+		if (copy_mc_user_highpage(dst, src, addr, vma)) {
+			sched_memory_failure(page_to_pfn(src));
 			return -EHWPOISON;
+		}
 		return 0;
 	}
 
-- 
2.37.3

