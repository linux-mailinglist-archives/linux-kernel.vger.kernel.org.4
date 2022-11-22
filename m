Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F57A6337E8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbiKVJGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbiKVJGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:06:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D8ADED1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669107933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h2fTDZU7Y2Vrqet95Gjzc0cvOcSZU6gDzpfc8yLs0sg=;
        b=TAwr18NkuA75wAhvMrXY93s//KPMfLXfv70xLCqyezqrhvz7SAuRS6rXOUfn7e1Mmpt4hD
        RURn4p7tIvom5DM313Y4Vdq/2q3yFgWvSfMdaiWB0OVm/Qegv1NXFgO8v0VYo1lBhdY68N
        h/3w1fUc/hlE6UoUNJ7mWVQpNi10Ofo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-220-H-Ra2UPxOQG6JSbtTRdYWg-1; Tue, 22 Nov 2022 04:05:31 -0500
X-MC-Unique: H-Ra2UPxOQG6JSbtTRdYWg-1
Received: by mail-wm1-f69.google.com with SMTP id c1-20020a7bc001000000b003cfe40fca79so3844073wmb.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:05:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h2fTDZU7Y2Vrqet95Gjzc0cvOcSZU6gDzpfc8yLs0sg=;
        b=IzrCeHiKOPxILdH5djorsPfF9dt9RksG2m+6SPDhIp267G8rL67nZaLlKU6P8giGOH
         M7bQoXVzkDbgJleQeZfocFKiiTn3VH5iWhIpS8j3iCL4yYRJ0mhSCXs+1XaQbOO3hp19
         +JX04+gZsWRhYoudxGlMA/2cfZ7JgCogp8ObVbr6fInLPpHJtUpw8Lkv2xuPyNOyRlbl
         1zChgtHtPYEBkIO2oFQTVUVHrEqUcFUBYgPlh/dpgSiZAWRStu2XDucDNuoGpweMo5ZV
         ZtRtgn7kMWRNtUDT8Aashsjf51bXP8LqlLhKIrtWNq1dOxSlCl58zTWEPeMXOOiP6NmD
         ucsw==
X-Gm-Message-State: ANoB5plXxOLUpU7qqS5orzCszrvjQVDxoNZLUmlqzeCqlcrWw1ftM1c8
        25McGxiPaPbdYfSlB9TCGZAYaSBDvyQWlwDZLsYW+gN0N8z63MhiHrE3lnbEBpGhizH5SGA2+XY
        sUBWowftrf3RCS1Uy0pWZyP58
X-Received: by 2002:a1c:f617:0:b0:3cf:e0ef:1f69 with SMTP id w23-20020a1cf617000000b003cfe0ef1f69mr1705949wmc.163.1669107930581;
        Tue, 22 Nov 2022 01:05:30 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4Y7DTNGbgnoPxPhqhwn0MjeYOzXwVXxc/cY3rCYpWGnVrKPTxJSydpEx0fntgGVLmBqTEGAw==
X-Received: by 2002:a1c:f617:0:b0:3cf:e0ef:1f69 with SMTP id w23-20020a1cf617000000b003cfe0ef1f69mr1705909wmc.163.1669107930184;
        Tue, 22 Nov 2022 01:05:30 -0800 (PST)
Received: from [192.168.3.108] (p5b0c65c4.dip0.t-ipconnect.de. [91.12.101.196])
        by smtp.gmail.com with ESMTPSA id v17-20020a5d5911000000b00241da0e018dsm4073477wrd.29.2022.11.22.01.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 01:05:29 -0800 (PST)
Message-ID: <4b926dc7-b8ec-e363-b9d8-35c0f2c897f6@redhat.com>
Date:   Tue, 22 Nov 2022 10:05:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        syzbot+f0b97304ef90f0d0b1dc@syzkaller.appspotmail.com
References: <20221031152524.173644-1-david@redhat.com>
 <Y1/0e12ZJT6+N0kI@nvidia.com> <Y2BIbyxT0Bh6bCUr@monkey>
 <e2e59601-ced3-a62e-48e8-69fd24b1297e@redhat.com>
 <20221121133320.a4e1c70af6ca72f29795fd5f@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1] mm/gup: disallow FOLL_FORCE|FOLL_WRITE on hugetlb
 mappings
In-Reply-To: <20221121133320.a4e1c70af6ca72f29795fd5f@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.11.22 22:33, Andrew Morton wrote:
> On Mon, 21 Nov 2022 09:05:43 +0100 David Hildenbrand <david@redhat.com> wrote:
> 
>>>> MikeK do you have test cases?
>>>
>>> Sorry, I do not have any test cases.
>>>
>>> I can ask one of our product groups about their usage.  But, that would
>>> certainly not be a comprehensive view.
>>
>> With
>>
>> https://lkml.kernel.org/r/20221116102659.70287-1-david@redhat.com
>>
>> on it's way, the RDMA concern should be gone, hopefully.
>>
>> @Andrew, can you queue this one? Thanks.
> 
> This is all a little tricky.
> 
> It's not good that 6.0 and earlier permit unprivileged userspace to
> trigger a WARN.  But we cannot backport this fix into earlier kernels
> because it requires the series "mm/gup: remove FOLL_FORCE usage from
> drivers (reliable R/O long-term pinning)".
> 
> Is it possible to come up with a fix for 6.1 and earlier which won't
> break RDMA?

Let's recap:

(1) Nobody so far reported a RDMA regression, it was all pure
     speculation. The only report we saw was via ptrace when fuzzing
     syscalls.

(2) To trigger it, one would need a hugetlb MAP_PRIVATE mappings without
     PROT_WRITE. For example:

       mmap(0, SIZE, PROT_READ,
            MAP_PRIVATE|MAP_ANON|MAP_HUGETLB|MAP_HUGE_2MB, -1, 0)
     or
       mmap(0, SIZE, PROT_READ, MAP_PRIVATE, hugetlbfd, 0)

     While that's certainly valid, it's not the common use case with
     hugetlb pages.

(3) Before 1d8d14641fd9 (< v6.0), it "worked by accident" but was wrong:
     pages would get mapped writable into page tables, even though we did
     not have VM_WRITE. FOLL_FORCE support is essentially absent but not
     fenced properly.

(4) With 1d8d14641fd9 (v6.0 + v6.1-rc), it results in a warning instead.

(5) This patch silences the warning.


Ways forward are:

(1) Implement FOLL_FORCE for hugetlb and backport that. Fixes the
     warning in 6.0 and wrong behavior before that. The functionality,
     however, might not be required in 6.2 at all anymore: the last
     remaining use case would be ptrace (which, again, we don't have
     actual users reporting breakages).

(2) Use this patch and backport it into 6.0/6.1 to fix the warning. RDMA
     will be handled properly in 6.2 via reliable long-term pinnings.

(3) Use this patch and backport it into 6.0/6.1 to fix the warning.
     Further, backport the reliable long-term pinning changes into
     6.0/6.1 if there are user reports.

(4) On user report regarding RDMA in 6.0 and 6.1, revert the sanity
     check that triggers the warning and restore previous (wrong)
     behavior.


To summarize, the benefit of (1) would be to have ptrace on hugetlb COW 
mappings working. As stated, I'd like to minimize FOLL_FORCE 
implementations if there are no legacy users because FOLL_FORCE has a 
proven record of security issues. Further, backports to < 6.0 might not 
be straight forward.

I'd suggest (2), but I'm happy to hear other opinions.

-- 
Thanks,

David / dhildenb

