Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B055F63A4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiJFJ3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiJFJ3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:29:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAA130F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 02:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665048573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+smpxbXq4s4VZXWHyY6FHA0tm1OoQPC2gTDZdrKKgFc=;
        b=RJcMkKK0/m6NiSBWK7hlzuphaSrswJFqSKiMM4J+qiMi5fdOvEQfjI7kj4wSmVZQhAfyls
        gwJUkoanXivbyezJTe6hWxbf//IXp5NFjxJ4IhXVrOYwQ9dVdra4ZnqjGslcBwVhbs1DaO
        jDJkrKgHPxjiohhKWGlhcFLvXTupaWU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-358-dBOD3VBQOf-wMlbgS8tp-g-1; Thu, 06 Oct 2022 05:29:32 -0400
X-MC-Unique: dBOD3VBQOf-wMlbgS8tp-g-1
Received: by mail-wm1-f70.google.com with SMTP id 18-20020a05600c229200b003c1cb5820bbso367423wmf.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 02:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=+smpxbXq4s4VZXWHyY6FHA0tm1OoQPC2gTDZdrKKgFc=;
        b=DH7f0DXRD0H08RNm/vTsStcFdPgLQPVUL6P0DMhYUPhyrf5vJVuqcwjgycVB9LQmOb
         DgstM/mZNE2oWoAJV32OlnutCaBXd2JDW8ecE+asJJfib5Us5Pm1xPAhV+wcUM60isqQ
         3yKE6rqwYwEjvxuDJg/6kjwXK5CE7PslAbq6aqnvBaQ4rY40VStEddACy00y5C78rbhm
         zGItFbMBLCB6xrHXQ+f6+V6+bXIs3GU+dg1sEhK3Dm/6s0Pz1M30pqM2d0ghO+OlPapa
         jSsDxCkxHQqujD3UUO4p6nZqFIaQWkgGeeYqa8xc2pgEuWdoY8LVY35Y0pSSxYLp52ZY
         +gOA==
X-Gm-Message-State: ACrzQf3vQqsXFk8ZGvqdG+pJ4aZycTIIvfS4R5PnxmTnqVZr3SwzpvQ/
        tgGhveTmQ3bh5ARFbGcmIeklyGZYFefRo7B9BwFBa3jPMjRicM6g/QV/sLQoquG4Q2hzvKe53k/
        EmjTEB24zH01x0h/OW3DusnDj
X-Received: by 2002:a5d:51c2:0:b0:22e:3c45:9eff with SMTP id n2-20020a5d51c2000000b0022e3c459effmr2417256wrv.118.1665048571476;
        Thu, 06 Oct 2022 02:29:31 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4sLsL83Bl3DnANSzkrKeNP7L6BNgjr9mJL7tkJpTRVq2QeiBP58gaQpBqj4Eq8uMYVJLrszg==
X-Received: by 2002:a5d:51c2:0:b0:22e:3c45:9eff with SMTP id n2-20020a5d51c2000000b0022e3c459effmr2417236wrv.118.1665048571137;
        Thu, 06 Oct 2022 02:29:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:3700:aed2:a0f8:c270:7f30? (p200300cbc7053700aed2a0f8c2707f30.dip0.t-ipconnect.de. [2003:cb:c705:3700:aed2:a0f8:c270:7f30])
        by smtp.gmail.com with ESMTPSA id k16-20020adfd850000000b0022e3538d305sm14750024wrl.117.2022.10.06.02.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 02:29:30 -0700 (PDT)
Message-ID: <bdddfd01-bc7e-2f99-21b9-2762a7041096@redhat.com>
Date:   Thu, 6 Oct 2022 11:29:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
References: <20220930141931.174362-1-david@redhat.com>
 <20220930141931.174362-5-david@redhat.com> <Yz3qekna97ndP4FK@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 4/7] mm/ksm: fix KSM COW breaking with userfaultfd-wp
 via FAULT_FLAG_UNSHARE
In-Reply-To: <Yz3qekna97ndP4FK@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.10.22 22:35, Peter Xu wrote:
> On Fri, Sep 30, 2022 at 04:19:28PM +0200, David Hildenbrand wrote:
>> Let's stop breaking COW via a fake write fault and let's use
>> FAULT_FLAG_UNSHARE instead. This avoids any wrong side effects of the fake
>> write fault, such as mapping the PTE writable and marking the pte
>> dirty/softdirty.
>>
>> Also, this fixes KSM interaction with userfaultfd-wp: when we have a KSM
>> page that's write-protected by userfaultfd, break_ksm()->handle_mm_fault()
>> will fail with VM_FAULT_SIGBUS and will simpy return in break_ksm() with 0.
>> The warning in dmesg indicates this wrong handling:
>>
>> [  230.096368] FAULT_FLAG_ALLOW_RETRY missing 881
>> [  230.100822] CPU: 1 PID: 1643 Comm: ksm-uffd-wp [...]
>> [  230.110124] Hardware name: [...]
>> [  230.117775] Call Trace:
>> [  230.120227]  <TASK>
>> [  230.122334]  dump_stack_lvl+0x44/0x5c
>> [  230.126010]  handle_userfault.cold+0x14/0x19
>> [  230.130281]  ? tlb_finish_mmu+0x65/0x170
>> [  230.134207]  ? uffd_wp_range+0x65/0xa0
>> [  230.137959]  ? _raw_spin_unlock+0x15/0x30
>> [  230.141972]  ? do_wp_page+0x50/0x590
>> [  230.145551]  __handle_mm_fault+0x9f5/0xf50
>> [  230.149652]  ? mmput+0x1f/0x40
>> [  230.152712]  handle_mm_fault+0xb9/0x2a0
>> [  230.156550]  break_ksm+0x141/0x180
>> [  230.159964]  unmerge_ksm_pages+0x60/0x90
>> [  230.163890]  ksm_madvise+0x3c/0xb0
>> [  230.167295]  do_madvise.part.0+0x10c/0xeb0
>> [  230.171396]  ? do_syscall_64+0x67/0x80
>> [  230.175157]  __x64_sys_madvise+0x5a/0x70
>> [  230.179082]  do_syscall_64+0x58/0x80
>> [  230.182661]  ? do_syscall_64+0x67/0x80
>> [  230.186413]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Since it's already there, worth adding the test into ksm_test.c?

Yes, I can give it a try. What I dislike about ksm_test is that it's a 
mixture of benchmarks and test cases that have to explicitly triggered 
by parameters. It's not a simple "run all available test cases" tests as 
we know it. So maybe something separate (or having it as part of the 
uffd tests) makes more sense.

> 
>>
>> Consequently, we will no longer trigger a fake write fault and break COW
>> without any such side-effects.
>>
>> This is primarily a fix for KSM+userfaultfd-wp, however, the fake write
>> fault was always questionable. As this fix is not easy to backport and it's
>> not very critical, let's not cc stable.
> 
> A patch to cc most of the stable would probably need to still go with the
> old write approach but attaching ALLOW_RETRY.  But I agree maybe that may
> not need to bother, or a report should have arrived earlier..  The unshare
> approach looks much cleaner indeed.

A fix without FAULT_FLAG_UNSHARE is not straight forward. We really 
don't want to notify user space about write events here (because there 
is none). And there is no way around the uffd handling in WP code 
without that.

FAULT_FLAG_ALLOW_RETRY would rely on userfaultfd triggering and having 
to resolve the WP event.

> 
>>
>> Fixes: 529b930b87d9 ("userfaultfd: wp: hook userfault handler to write protection fault")
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Acked-by: Peter Xu <peterx@redhat.com>
> 

Thanks!

-- 
Thanks,

David / dhildenb

