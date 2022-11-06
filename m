Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D923A61E37F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 17:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiKFQmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 11:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiKFQmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 11:42:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6742CAE6D
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 08:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667752905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q4V0qdtzaAgHkOTmwB/UZPKeoOTGimkTFcNo1OeSquI=;
        b=RZnf0Vqt6jMnUbPIuVcK1Gi3QuCdpkRIITsSsrXgVcVLBwJ7ZYTAUvDEbpd+Zv0mLruEEH
        WOtGgRU3UoW6zbgiypNzRO+KoEYkyvuDYUW0OZZ4YLEP52/W6wQgaLjUnej2oMQSdb2p4i
        2VNCc71F6KzG2FvtdNCqk+LfEeZ/YBI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-259--cklSvVUO6KzWBqcw3yQuQ-1; Sun, 06 Nov 2022 11:41:44 -0500
X-MC-Unique: -cklSvVUO6KzWBqcw3yQuQ-1
Received: by mail-qk1-f199.google.com with SMTP id bp10-20020a05620a458a00b006fa29f253dcso8315281qkb.11
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 08:41:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4V0qdtzaAgHkOTmwB/UZPKeoOTGimkTFcNo1OeSquI=;
        b=MB9R0tKub0MvWiX6fdG2aajg/Numee+kz9sHXOZg3zBIEUDawDjNEb3pHBAePuB/z8
         TurLOi+RPM+CvS6XN/VbifBHhigOPFBD1vkG7SmMeNY3EpO8GJs2emndt4gcHvDOK7x4
         rwrl4z8+YW0buXN8sBfkxNCCGpuJDR60XujImmYRJ4qSkMQXQbYUxmHCXjKOd0Na2Mm3
         EsNg3CKkLDAUB/i43pa0qErw6DnAUxocrkyHRxHBe/z8OSBI0ArQAlIF4OrWZzi9RGPe
         SaXBr7NolSj83NknoQzIykO2yUaKlnQjolH+R51lL0DY11soRa3fFQQcNadwKU6rx9V7
         RvuA==
X-Gm-Message-State: ACrzQf2PQSeU983RkLQkn9RhBhbGE49ZIUjTPCMo/7wEBt+grKnoO/Vl
        iZQep7kL2LlO/8dzZQ78jAecsGAz8ODAU2dCPN0hULwBFESWwlxs4Nv6lShRAnPbpxC/VnBGk4s
        kDKr4wDGZhbb2D106dV30pbYZ
X-Received: by 2002:a05:620a:284a:b0:6ce:beaa:4c82 with SMTP id h10-20020a05620a284a00b006cebeaa4c82mr33085817qkp.529.1667752904317;
        Sun, 06 Nov 2022 08:41:44 -0800 (PST)
X-Google-Smtp-Source: AMsMyM58jTWMgcGwzh+CDIbR2YemSLoayoxELZKpkj7d+R/sLzF4rrNGSoAi2N3ATLVqoUTNdCtL+Q==
X-Received: by 2002:a05:620a:284a:b0:6ce:beaa:4c82 with SMTP id h10-20020a05620a284a00b006cebeaa4c82mr33085802qkp.529.1667752904003;
        Sun, 06 Nov 2022 08:41:44 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id m13-20020a05620a290d00b006fa43e139b5sm4768605qkp.59.2022.11.06.08.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 08:41:43 -0800 (PST)
Date:   Sun, 6 Nov 2022 11:41:42 -0500
From:   Peter Xu <peterx@redhat.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        James Houghton <jthoughton@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH RFC 05/10] mm/hugetlb: Make walk_hugetlb_range() RCU-safe
Message-ID: <Y2fjxgojqKazzINq@x1n>
References: <20221030212929.335473-6-peterx@redhat.com>
 <202211061521.28931f7-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202211061521.28931f7-oliver.sang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2022 at 04:14:10PM +0800, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed WARNING:suspicious_RCU_usage due to commit (built with gcc-11):
> 
> commit: 8b7e3b7ca3897ebc4cb7b23c65a4618d64056e3b ("[PATCH RFC 05/10] mm/hugetlb: Make walk_hugetlb_range() RCU-safe")
> url: https://github.com/intel-lab-lkp/linux/commits/Peter-Xu/mm-hugetlb-Make-huge_pte_offset-thread-safe-for-pmd-unshare/20221031-053221
> base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
> patch link: https://lore.kernel.org/lkml/20221030212929.335473-6-peterx@redhat.com
> patch subject: [PATCH RFC 05/10] mm/hugetlb: Make walk_hugetlb_range() RCU-safe
> 
> in testcase: kernel-selftests
> version: kernel-selftests-x86_64-9313ba54-1_20221017
> with following parameters:
> 
> 	sc_nr_hugepages: 2
> 	group: vm
> 
> test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> 
> 
> on test machine: 12 threads 1 sockets Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz (Coffee Lake) with 16G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Link: https://lore.kernel.org/oe-lkp/202211061521.28931f7-oliver.sang@intel.com
> 
> 
> kern  :warn  : [  181.942648] WARNING: suspicious RCU usage
> kern  :warn  : [  181.943175] 6.1.0-rc1-00309-g8b7e3b7ca389 #1 Tainted: G S
> kern  :warn  : [  181.943972] -----------------------------
> kern  :warn  : [  181.944526] include/linux/rcupdate.h:364 Illegal context switch in RCU read-side critical section!
> kern  :warn  : [  181.945559]
> other info that might help us debug this:
> 
> kern  :warn  : [  181.946625]
> rcu_scheduler_active = 2, debug_locks = 1
> kern  :warn  : [  181.947473] 2 locks held by hmm-tests/9934:
> kern :warn : [  181.948016] #0: ffff8884325b2d18 (&mm->mmap_lock#2){++++}-{3:3}, at: dmirror_fault (test_hmm.c:?) test_hmm
> kern :warn : [  181.949129] #1: ffffffff858a7860 (rcu_read_lock){....}-{1:2}, at: walk_hugetlb_range (pagewalk.c:?) 
> kern  :warn  : [  181.950161]
> stack backtrace:
> kern  :warn  : [  181.950780] CPU: 9 PID: 9934 Comm: hmm-tests Tainted: G S                 6.1.0-rc1-00309-g8b7e3b7ca389 #1
> kern  :warn  : [  181.951863] Hardware name: Dell Inc. Vostro 3670/0HVPDY, BIOS 1.5.11 12/24/2018
> kern  :warn  : [  181.952709] Call Trace:
> kern  :warn  : [  181.953070]  <TASK>
> kern :warn : [  181.953403] dump_stack_lvl (??:?) 
> kern :warn : [  181.953890] __might_resched (??:?) 
> kern :warn : [  181.954403] __mutex_lock (mutex.c:?) 
> kern :warn : [  181.954886] ? validate_chain (lockdep.c:?) 
> kern :warn : [  181.955405] ? hugetlb_fault (??:?) 
> kern :warn : [  181.955926] ? mark_lock+0xca/0xac0 
> kern :warn : [  181.956450] ? mutex_lock_io_nested (mutex.c:?) 
> kern :warn : [  181.957039] ? check_prev_add (lockdep.c:?) 
> kern :warn : [  181.957580] ? hugetlb_vm_op_pagesize (hugetlb.c:?) 
> kern :warn : [  181.958177] ? hugetlb_fault (??:?) 
> kern :warn : [  181.958690] hugetlb_fault (??:?) 
> kern :warn : [  181.959199] ? find_held_lock (lockdep.c:?) 
> kern :warn : [  181.959709] ? hugetlb_no_page (??:?) 
> kern :warn : [  181.960255] ? __lock_release (lockdep.c:?) 
> kern :warn : [  181.960772] ? lock_downgrade (lockdep.c:?) 
> kern :warn : [  181.961292] ? lock_is_held_type (??:?) 
> kern :warn : [  181.961830] ? handle_mm_fault (??:?) 
> kern :warn : [  181.962363] handle_mm_fault (??:?) 
> kern :warn : [  181.962870] ? hmm_vma_walk_hugetlb_entry (hmm.c:?) 
> kern :warn : [  181.963501] hmm_vma_fault (hmm.c:?) 
> kern :warn : [  181.964096] walk_hugetlb_range (pagewalk.c:?) 
> kern :warn : [  181.964639] __walk_page_range (pagewalk.c:?) 
> kern :warn : [  181.965160] walk_page_range (??:?) 
> kern :warn : [  181.965670] ? __walk_page_range (??:?) 
> kern :warn : [  181.966213] ? rcu_read_unlock (main.c:?) 
> kern :warn : [  181.966718] ? lock_is_held_type (??:?) 
> kern :warn : [  181.967259] ? mmu_interval_read_begin (??:?) 
> kern :warn : [  181.967855] ? lock_is_held_type (??:?) 
> kern :warn : [  181.968400] hmm_range_fault (??:?) 
> kern :warn : [  181.968911] ? down_read (??:?) 
> kern :warn : [  181.969383] ? hmm_vma_fault (??:?) 
> kern :warn : [  181.969891] ? __lock_release (lockdep.c:?) 
> kern :warn : [  181.970416] dmirror_fault (test_hmm.c:?) test_hmm
> kern :warn : [  181.971012] ? dmirror_migrate_to_system+0x590/0x590 test_hmm
> kern :warn : [  181.971847] ? find_held_lock (lockdep.c:?) 
> kern :warn : [  181.972355] ? dmirror_write+0x202/0x310 test_hmm
> kern :warn : [  181.973069] ? __lock_release (lockdep.c:?) 
> kern :warn : [  181.973586] ? lock_downgrade (lockdep.c:?) 
> kern :warn : [  181.974107] ? lock_is_held_type (??:?) 
> kern :warn : [  181.974641] ? dmirror_write+0x202/0x310 test_hmm
> kern :warn : [  181.975355] ? lock_release (??:?) 
> kern :warn : [  181.975845] ? __mutex_unlock_slowpath (mutex.c:?) 
> kern :warn : [  181.976444] ? bit_wait_io_timeout (mutex.c:?) 
> kern :warn : [  181.977008] ? lock_is_held_type (??:?) 
> kern :warn : [  181.977547] ? dmirror_do_write (test_hmm.c:?) test_hmm
> kern :warn : [  181.978185] dmirror_write+0x1bf/0x310 test_hmm
> kern :warn : [  181.978881] ? dmirror_fault (test_hmm.c:?) test_hmm
> kern :warn : [  181.979484] ? lock_is_held_type (??:?) 
> kern :warn : [  181.980021] ? __might_fault (??:?) 
> kern :warn : [  181.980523] ? lock_release (??:?) 
> kern :warn : [  181.981019] dmirror_fops_unlocked_ioctl (test_hmm.c:?) test_hmm
> kern :warn : [  181.981732] ? dmirror_exclusive+0x780/0x780 test_hmm
> kern :warn : [  181.982485] ? do_user_addr_fault (fault.c:?) 
> kern :warn : [  181.983042] ? __lock_release (lockdep.c:?) 
> kern :warn : [  181.983562] __x64_sys_ioctl (??:?) 
> kern :warn : [  181.984074] do_syscall_64 (??:?) 
> kern :warn : [  181.984545] ? do_user_addr_fault (fault.c:?) 
> kern :warn : [  181.985103] ? do_user_addr_fault (fault.c:?) 
> kern :warn : [  181.985654] ? irqentry_exit_to_user_mode (??:?) 
> kern :warn : [  181.986256] ? lockdep_hardirqs_on_prepare (lockdep.c:?) 
> kern :warn : [  181.986945] entry_SYSCALL_64_after_hwframe (??:?) 

So it is caused by the hmm code doing page fault during page walk, where
it'll go into the hugetlb fault logic and trying to take sleeptable locks..

That's slightly out of my expectation because logically I think the page
walk hooks should only do trivial works on the pte/pmd/.. being walked on,
rather than things as complicated as triggering a page fault as what HMM
does.  And it's also surprising to me that we can actually allow sleep.
But so far it looks safe.

Besides HMM it seems there's yet another user (enable_skey_walk_ops) that
can also yield itself by calling cond_resched().

My current plan is I may need to add some helpers so that when the hooks
decides to call code that can sleep, we need to notify the walker API.  It
could be something called walk_page_pause(), walk_page_cont(), then for
either a fault or cond_reched(), we could:

  walk_page_pause(&walk);
  hmm_vma_fault(); // or cond_reched(), etc.
  walk_page_cont(&walk);

We should probably also emphasize somewhere that mmap lock should never be
released for the whole page walk process, because walk_page_range() will
cache vma pointers.

If there's any better suggestion, please feel free to comment, or I'll give
it a shot with above approach in the next version.

-- 
Peter Xu

