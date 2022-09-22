Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804445E5C9E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 09:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiIVHqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 03:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiIVHql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 03:46:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DFFA00D6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 00:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663832799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FlqGi/LmHMmhAuBiBmv+t3gfQAVt3KBVjR3Qs9ZnL2M=;
        b=Ucr0sCrznlaUSKHEtHYIGd4C00iCoHWtzBNyibBet3Yz7oVs3thRJQ3KRchRb+EpPut7ag
        zp5csZfse2SgAHStSNH9DhzRpqtM4WtX6ROqrd+fdr+HGzgXWHF2/we5KUJ2ZUnNIVVRj+
        1bXf/W/okMU7ClKf/4NXc+ZPn+nBKQo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-187-sUGUNkS-OjSK47PZkgCfOw-1; Thu, 22 Sep 2022 03:46:38 -0400
X-MC-Unique: sUGUNkS-OjSK47PZkgCfOw-1
Received: by mail-wm1-f71.google.com with SMTP id 14-20020a05600c228e00b003b4d065282dso436500wmf.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 00:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=FlqGi/LmHMmhAuBiBmv+t3gfQAVt3KBVjR3Qs9ZnL2M=;
        b=ciSZRAs+9CnrlQYOn6CXd+bocJwzJgFR4POqpwtPmpK2FCoD2+MaZ9QF/X/hnF64Ev
         0dx8QGHI5IN7sauZbW9hy7I0QuCOkbCzOl0R6QMXCNX2sO0YRufTrlqscqn26Mq6rPJe
         iovsey5XroUX4gqw7fKb8FwBpMoTf30VFbXfT79KFXbo1YTxGiYR4eCtbvpQxp/OasHK
         CdePDkHoAJ7kWrQKw2FewhcVj5+BpcdlIox3w2uwMMkO1ur9x4K3liM0LaZW2CVCUTVA
         X8sWeLzxzzUyBtSgxEIjc+wJ3eHHMV9dP4Rhk7ExoIIv+QB1pKPEa6wdpD+btfUvavAm
         xURQ==
X-Gm-Message-State: ACrzQf1NLdlyGb0Y8Ab0JnuUrctNZ2Qilh0HAkYEii5zOueASkIJlSgM
        DVlHSgV8tUZSDMRo6Dgo2WaPIckSAp+onolSaDlX3iHUt1OmtvUf+o5geaXguQWtNthhKxegBGE
        p/8D3hq1C3cjBHOId9KKLccTO
X-Received: by 2002:a5d:6d0b:0:b0:22a:ca5b:a37e with SMTP id e11-20020a5d6d0b000000b0022aca5ba37emr1074642wrq.383.1663832797534;
        Thu, 22 Sep 2022 00:46:37 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7xbeisrSEKCHtuAyuSyHFAvgGQU2bhXL/iAEd0tcAO1ALOa95cKY+8VHi76Qy6AzC8ABTSwQ==
X-Received: by 2002:a5d:6d0b:0:b0:22a:ca5b:a37e with SMTP id e11-20020a5d6d0b000000b0022aca5ba37emr1074626wrq.383.1663832797166;
        Thu, 22 Sep 2022 00:46:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:2200:d595:cc20:2e3a:fc5f? (p200300cbc7082200d595cc202e3afc5f.dip0.t-ipconnect.de. [2003:cb:c708:2200:d595:cc20:2e3a:fc5f])
        by smtp.gmail.com with ESMTPSA id v16-20020a5d6790000000b00228dd80d78asm4378619wru.86.2022.09.22.00.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 00:46:36 -0700 (PDT)
Message-ID: <708d1ec7-5c25-5e45-0db8-bd97a64e0db1@redhat.com>
Date:   Thu, 22 Sep 2022 09:46:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Liu Shixin <liushixin2@huawei.com>
Cc:     Liu Zixian <liuzixian4@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>
References: <20220921083440.1267903-1-liushixin2@huawei.com>
 <YytOYH1MSo5cNoB6@monkey> <Yyuk83B4VHh+pbFp@monkey>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: hugetlb: fix UAF in hugetlb_handle_userfault
In-Reply-To: <Yyuk83B4VHh+pbFp@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.09.22 01:57, Mike Kravetz wrote:
> On 09/21/22 10:48, Mike Kravetz wrote:
>> On 09/21/22 16:34, Liu Shixin wrote:
>>> The vma_lock and hugetlb_fault_mutex are dropped before handling
>>> userfault and reacquire them again after handle_userfault(), but
>>> reacquire the vma_lock could lead to UAF[1] due to the following
>>> race,
>>>
>>> hugetlb_fault
>>>    hugetlb_no_page
>>>      /*unlock vma_lock */
>>>      hugetlb_handle_userfault
>>>        handle_userfault
>>>          /* unlock mm->mmap_lock*/
>>>                                             vm_mmap_pgoff
>>>                                               do_mmap
>>>                                                 mmap_region
>>>                                                   munmap_vma_range
>>>                                                     /* clean old vma */
>>>          /* lock vma_lock again  <--- UAF */
>>>      /* unlock vma_lock */
>>>
>>> Since the vma_lock will unlock immediately after hugetlb_handle_userfault(),
>>> let's drop the unneeded lock and unlock in hugetlb_handle_userfault() to fix
>>> the issue.
>>
>> Thank you very much!
>>
>> When I saw this report, the obvious fix was to do something like what you have
>> done below.  That looks fine with a few minor comments.
>>
>> One question I have not yet answered is, "Does this same issue apply to
>> follow_hugetlb_page()?".  I believe it does.  follow_hugetlb_page calls
>> hugetlb_fault which could result in the fault being processed by userfaultfd.
>> If we experience the race above, then the associated vma could no longer be
>> valid when returning from hugetlb_fault.  follow_hugetlb_page and callers
>> have a flag (locked) to deal with dropping mmap lock.  However, I am not sure
>> if it is handled correctly WRT userfaultfd.  I think this needs to be answered
>> before fixing.  And, if the follow_hugetlb_page code needs to be fixed it
>> should be done at the same time.
>>
> 
> To at least verify this code path, I added userfaultfd handling to the gup_test
> program in kernel selftests.  When doing basic gup test on a hugetlb page in
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

Right. Without being able to drop the mmap lock, we cannot continue. And 
we don't know if we can drop it without FAULT_FLAG_ALLOW_RETRY.

FAULT_FLAG_ALLOW_RETRY is only set when we can communicate to the caller 
that we dropped the mmap lock [e.g., int *locked parameter].

All code paths that pass NULL won't be able to handle --  especially 
surprisingly also pin_user_pages_fast() -- cannot trigger usefaultfd and 
will result in this warning.


A "sane" example is access via /proc/self/mem via ptrace: we don't want 
to trigger userfaultfd, but instead simply fail the GUP get/pin.


Now, this is just a printed *warning* (not a WARN/BUG/taint) that tells 
us that there is a GUP user that isn't prepared for userfaultfd. So it 
rather points out a missing GUP adaption -- incomplete userfaultfd 
support. And we seem to have plenty of that judging that 
pin_user_pages_fast_only().

Maybe the printed stack trace is a bit too much and makes this look very 
scary.

> 
> Adding John, Peter and David on Cc: as they are much more fluent in all the
> fault and FOLL combinations and might have immediate suggestions.  It is going
> to take me a little while to figure out:
> 1) How to make sure we get the right flags passed to handle_userfault

This is a GUP caller problem -- or rather, how GUP has to deal with 
userfaultfd.

> 2) How to modify follow_hugetlb_page as userfaultfd can certainly drop
>     mmap_lock.  So we can not assume vma still exists upon return.

Again, we have to communicate to the GUP caller that we dropped the mmap 
lock. And that requires GUP caller changes.

-- 
Thanks,

David / dhildenb

