Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB0A5E668E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiIVPPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiIVPO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:14:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1606477EBF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663859695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qjp7gSqru1V14obi6EFQxvOUgdoMmkmY1jvpy9DdMTw=;
        b=YfZW4/jfWm8oROa+zKk93r/4aLcp6aNrsiIrBg0CpL5O+z6md89JpocNwmu2rRTDCSY5ce
        tlMNDlTBg4PjNSXF+oRH6Vv0BvtSFshEBci2+p7XYLaLjlW9KwIs2H714z7ZnJ2VUIIu7I
        Ccy1m7N0XV+gkTBYqNx0gma754IHi6k=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-445-uainvANjNPKVvfvhgcfvuA-1; Thu, 22 Sep 2022 11:14:53 -0400
X-MC-Unique: uainvANjNPKVvfvhgcfvuA-1
Received: by mail-qt1-f197.google.com with SMTP id j25-20020ac84c99000000b0035bb13ed4ffso6690305qtv.23
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:14:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Qjp7gSqru1V14obi6EFQxvOUgdoMmkmY1jvpy9DdMTw=;
        b=GYzt+gvnlwqAwO/dlkjl4kFqYo8sGqVGW4LsZ6Zy6dNouHQFziMsm7KyrEb92HGuoU
         RM8d/BkPldmfuAGdq6MHCZ1DUYEg66N4uw8cBmcTX7mMxVJvZgwzbdax5wsW3vkwPPaa
         02KbIqixkPkttAOCl6dNpINIy89DpZd4PZG+qIShEPD9ykMBWMyy5ouIVAsVfebjFEL9
         Be7qOHdgkySLYQ9W+bIIhZSLskWTrad5nQUYEO9iM/LplNQU6CUn6fVu+5d3cRFGEz7H
         uszDSnrIjHj5+26VBZj2Vdjs+Tx7+MZik4yvX6V3QlX7AG6AojmELV/O87ajHtKF4I9q
         81nQ==
X-Gm-Message-State: ACrzQf2jMgijfggrXgzsA+LlXPRS3I/FhMWPYafRKWW/eB5WlRzEIlfx
        +sigMMKgfOznZwkhrJ/YBcNeaYqQKyLWR54fJLExS1gOCs3vHyzfDSi2b7N8jgoSbj/eqjkQX3F
        moU3x378eF3VEM0MNtI9IdFua
X-Received: by 2002:a05:620a:462b:b0:6ce:7dce:82d6 with SMTP id br43-20020a05620a462b00b006ce7dce82d6mr2502598qkb.476.1663859692935;
        Thu, 22 Sep 2022 08:14:52 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM64Y1dl6PNU7Z1b6oFSNnzd8HcoaFOTopooptpW4R0paiaMW1ijLneOM1S44vEwHsDY/ok6qQ==
X-Received: by 2002:a05:620a:462b:b0:6ce:7dce:82d6 with SMTP id br43-20020a05620a462b00b006ce7dce82d6mr2502579qkb.476.1663859692674;
        Thu, 22 Sep 2022 08:14:52 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id c3-20020a37e103000000b006ce3fcee2bdsm3851025qkm.50.2022.09.22.08.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 08:14:52 -0700 (PDT)
Date:   Thu, 22 Sep 2022 11:14:51 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Liu Shixin <liushixin2@huawei.com>,
        Liu Zixian <liuzixian4@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm: hugetlb: fix UAF in hugetlb_handle_userfault
Message-ID: <Yyx76wt2LYWSKLUs@xz-m1.local>
References: <20220921083440.1267903-1-liushixin2@huawei.com>
 <YytOYH1MSo5cNoB6@monkey>
 <Yyuk83B4VHh+pbFp@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yyuk83B4VHh+pbFp@monkey>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 04:57:39PM -0700, Mike Kravetz wrote:
> On 09/21/22 10:48, Mike Kravetz wrote:
> > On 09/21/22 16:34, Liu Shixin wrote:
> > > The vma_lock and hugetlb_fault_mutex are dropped before handling
> > > userfault and reacquire them again after handle_userfault(), but
> > > reacquire the vma_lock could lead to UAF[1] due to the following
> > > race,
> > > 
> > > hugetlb_fault
> > >   hugetlb_no_page
> > >     /*unlock vma_lock */
> > >     hugetlb_handle_userfault
> > >       handle_userfault
> > >         /* unlock mm->mmap_lock*/
> > >                                            vm_mmap_pgoff
> > >                                              do_mmap
> > >                                                mmap_region
> > >                                                  munmap_vma_range
> > >                                                    /* clean old vma */
> > >         /* lock vma_lock again  <--- UAF */
> > >     /* unlock vma_lock */
> > > 
> > > Since the vma_lock will unlock immediately after hugetlb_handle_userfault(),
> > > let's drop the unneeded lock and unlock in hugetlb_handle_userfault() to fix
> > > the issue.
> > 
> > Thank you very much!
> > 
> > When I saw this report, the obvious fix was to do something like what you have
> > done below.  That looks fine with a few minor comments.
> > 
> > One question I have not yet answered is, "Does this same issue apply to
> > follow_hugetlb_page()?".  I believe it does.  follow_hugetlb_page calls
> > hugetlb_fault which could result in the fault being processed by userfaultfd.
> > If we experience the race above, then the associated vma could no longer be
> > valid when returning from hugetlb_fault.  follow_hugetlb_page and callers
> > have a flag (locked) to deal with dropping mmap lock.  However, I am not sure
> > if it is handled correctly WRT userfaultfd.  I think this needs to be answered
> > before fixing.  And, if the follow_hugetlb_page code needs to be fixed it
> > should be done at the same time.
> > 
> 
> To at least verify this code path, I added userfaultfd handling to the gup_test
> program in kernel selftests.

IIRC vm/userfaultfd should already have GUP tested with pthread mutexes
(which iiuc uses futex, and futex uses GUP).

But indeed I didn't trigger any GUP paths after a quick run..  I agree we
should have some unit test that can at least cover GUP with userfaultfd.
I'll further check it up from vm/userfaultfd side later.

> When doing basic gup test on a hugetlb page in
> a userfaultfd registered range, I hit this warning:
> 
> [ 6939.867796] FAULT_FLAG_ALLOW_RETRY missing 1
> [ 6939.871503] CPU: 2 PID: 5720 Comm: gup_test Not tainted 6.0.0-rc6-next-20220921+ #72
> [ 6939.874562] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1.fc35 04/01/2014
> [ 6939.877707] Call Trace:
> [ 6939.878745]  <TASK>
> [ 6939.879779]  dump_stack_lvl+0x6c/0x9f
> [ 6939.881199]  handle_userfault.cold+0x14/0x1e
> [ 6939.882830]  ? find_held_lock+0x2b/0x80
> [ 6939.884370]  ? __mutex_unlock_slowpath+0x45/0x280
> [ 6939.886145]  hugetlb_handle_userfault+0x90/0xf0
> [ 6939.887936]  hugetlb_fault+0xb7e/0xda0
> [ 6939.889409]  ? vprintk_emit+0x118/0x3a0
> [ 6939.890903]  ? _printk+0x58/0x73
> [ 6939.892279]  follow_hugetlb_page.cold+0x59/0x145
> [ 6939.894116]  __get_user_pages+0x146/0x750
> [ 6939.895580]  __gup_longterm_locked+0x3e9/0x680
> [ 6939.897023]  ? seqcount_lockdep_reader_access.constprop.0+0xa5/0xb0
> [ 6939.898939]  ? lockdep_hardirqs_on+0x7d/0x100
> [ 6939.901243]  gup_test_ioctl+0x320/0x6e0
> [ 6939.902202]  __x64_sys_ioctl+0x87/0xc0
> [ 6939.903220]  do_syscall_64+0x38/0x90
> [ 6939.904233]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [ 6939.905423] RIP: 0033:0x7fbb53830f7b
> 
> This is because userfaultfd is expecting FAULT_FLAG_ALLOW_RETRY which is not
> set in this path.
> 
> Adding John, Peter and David on Cc: as they are much more fluent in all the
> fault and FOLL combinations and might have immediate suggestions.  It is going
> to take me a little while to figure out:
> 1) How to make sure we get the right flags passed to handle_userfault

As David mentioned, one way is to have "locked" passed in with non-NULL.

The other way is to have FOLL_NOWAIT even if locked==NULL.

Here IIUC the trick is when the GUP caller neither wants to release the
mmap lock, nor does it want to stop quickly (i.e. it wants to wait for the
page fault with mmap lock held), then we'll have both locked==NULL and
!FOLL_NOWAIT.  Userfaultfd currently doesn't think it's wise so generated
that warning with CONFIG_DEBUG_VM.

> 2) How to modify follow_hugetlb_page as userfaultfd can certainly drop
>    mmap_lock.  So we can not assume vma still exists upon return.

I think FOLL_NOWAIT flag might work if the only thing we want to do is to
trigger handle_userfault() path.  But I'll also look into vm/userfaultfd as
mentioned above to make sure we'll have GUP covered there too.  I'll update
if I found anything useful there.

Off-topic a bit: the whole discussion reminded me something on whether
userfaultfd is doing correctly here.  E.g., here userfaultfd should really
look like the case when a swap in is needed for a file.  FOLL_NOWAIT on
swap-in will mean:

#define FOLL_NOWAIT	0x20	/* if a disk transfer is needed, start the IO
				 * and return without waiting upon it */

Now userfaultfd returns VM_FAULT_RETRY immediately with FOLL_NOWAIT.  I'm
wondering whether it should really generate the message before doing that,
to match with the semantics of initial use of FOLL_NOWAIT on swapping.

Thanks,

-- 
Peter Xu

