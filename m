Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5DA6E08A9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 10:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjDMILh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 04:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjDMILf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:11:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC355FC6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 01:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681373448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BicKsHmWZzac/YBlZAspRK8qzvBfIdiX2v+jxSpHdUc=;
        b=NpqyWQ90AXUD9xS7thB1IFECNM5IayuitQV6EWlmj6MrwVfTBy0kECP2SlP0Um5dRBDI/a
        WYKswSJviCdrJ3OAicjlwX4/oqkWcYcP3MUpAsf5oOMoSoHttSWoBjttJS9lUXL5O1t8gm
        K8RSSIk4IeuRNRvMxop7t31PuxjZ/Qs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-H3gvGvDcOteoE_qYu8KIQg-1; Thu, 13 Apr 2023 04:10:47 -0400
X-MC-Unique: H3gvGvDcOteoE_qYu8KIQg-1
Received: by mail-wm1-f70.google.com with SMTP id bh18-20020a05600c3d1200b003f05a99b571so10030187wmb.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 01:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681373446; x=1683965446;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BicKsHmWZzac/YBlZAspRK8qzvBfIdiX2v+jxSpHdUc=;
        b=fijnq/vqkw+M/mPINUBCf+fHeGAaTJZvoOZee/ovCtQ9672F0ckfx2Dhzn8I0zyAb8
         co9fUWslLP8j3LF27+NbqAh8C+w1Od2ZfwCcBXoP9d6OnZkXODJotzTiHoF7QTf9LTd/
         s/FyDBcAIIO28k04a0faKRt+xGYrb9zD2c9/0S0sf94hJkz6R1omsP7KXljW8lWplqcA
         kOM98wrstkG0XV+DKXVgaawoqhpHCVc/tY03EI+Eg9sfwHxTwkl+mVzOiFem2w0cpY2a
         Xe0x2eX4AyQDurD+RSnNJRdsJhHTZKdyqPoESUMbUt5tlYi0lzy+fU2fi08fsQYmlbiI
         7w9w==
X-Gm-Message-State: AAQBX9fitY6CQ+OnH04G+m5oPojsEGMlxFTactID0U+vJ859rKhzQvOt
        UDSfsi3cO7ppfA3lbLq251LmwApYbcSUixyQuh6MMJgJKcsL/orNUip3YlXMC1HsyiHImDU6HcF
        yzn9TwUt7CTpWVf/JChsAz4aW
X-Received: by 2002:a5d:4241:0:b0:2e4:cc81:8a80 with SMTP id s1-20020a5d4241000000b002e4cc818a80mr751828wrr.26.1681373446205;
        Thu, 13 Apr 2023 01:10:46 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z+1v6fqv73Ez8CQYOt3Gxgg06TKHkadfH9tvU0savFWMLQFBC/hyWk7Box+pdqdLyncGNB2Q==
X-Received: by 2002:a5d:4241:0:b0:2e4:cc81:8a80 with SMTP id s1-20020a5d4241000000b002e4cc818a80mr751805wrr.26.1681373445820;
        Thu, 13 Apr 2023 01:10:45 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c470a00b003ef36ef3833sm4836553wmo.8.2023.04.13.01.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 01:10:45 -0700 (PDT)
Message-ID: <3059388f-1604-c326-c66f-c2e0f9bb6cbf@redhat.com>
Date:   Thu, 13 Apr 2023 10:10:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
To:     Peter Xu <peterx@redhat.com>
Cc:     Lokesh Gidra <lokeshgidra@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Brian Geffon <bgeffon@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Nicolas Geoffray <ngeoffray@google.com>,
        Jared Duke <jdduke@google.com>,
        android-mm <android-mm@google.com>,
        Blake Caldwell <blake.caldwell@colorado.edu>,
        Mike Rapoport <rppt@kernel.org>
References: <CA+EESO4uO84SSnBhArH4HvLNhaUQ5nZKNKXqxRCyjniNVjp0Aw@mail.gmail.com>
 <ZC8BgFSFC3cDcAcS@x1n> <27ac2f51-e2bf-7645-7a76-0684248a5902@redhat.com>
 <ZDbVMk0trT5UaqaA@x1n>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: RFC for new feature to move pages from one vma to another without
 split
In-Reply-To: <ZDbVMk0trT5UaqaA@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.04.23 17:58, Peter Xu wrote:
> On Wed, Apr 12, 2023 at 10:47:52AM +0200, David Hildenbrand wrote:
>>> Personally it was always a mistery to me on how vm_pgoff works with
>>> anonymous vmas and why it needs to be setup with vm_start >> PAGE_SHIFT.
>>>
>>> Just now I tried to apply below oneliner change:
>>>
>>> @@ -1369,7 +1369,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>>>                           /*
>>>                            * Set pgoff according to addr for anon_vma.
>>>                            */
>>> -                       pgoff = addr >> PAGE_SHIFT;
>>> +                       pgoff = 0;
>>>                           break;
>>>                   default:
>>>                           return -EINVAL;
>>>
>>> The kernel even boots without a major problem so far..
>>
>> I think it's for RMAP purposes.
>>
>> Take a look at linear_page_index() and how it's, for example, used in
>> ksm_might_need_to_copy() alongside page->index.
> 
>  From what I read, the vma's vm_pgoff is set before setup any page->index
> within the vma, while the latter will be calculated out of the vma pgoff
> with linear_page_index() (in __page_set_anon_rmap()).
> 
> 	folio->index = linear_page_index(vma, address);
> 
> I think I missed something, but it seems to me any comparisions between
> page->index and linear_page_index() will just keep working for anonymous
> even if we change vma pgoff to 0 when vma is mapped.
> 
> Do you perhaps mean this is needed for ksm only?  I really am not familiar
> enough with ksm, especially when it's swapped out.  I do see that
> ksm_might_need_to_copy() wants to avoid reusing a page if anon_vma is setup
> not for current vma, but I don't know when it'll happen.
> 
> 	if (PageKsm(page)) {
> 		if (page_stable_node(page) &&
> 		    !(ksm_run & KSM_RUN_UNMERGE))
> 			return page;	/* no need to copy it */
> 	} else if (!anon_vma) {
> 		return page;		/* no need to copy it */
> 	} else if (page->index == linear_page_index(vma, address) &&
> 			anon_vma->root == vma->anon_vma->root) {
> 		return page;		/* still no need to copy it */
> 	}
> 
> I think when all these paths don't trigger (aka, we need to copy) it means
> there's anon_vma assigned to the page but not the right one (even though I
> don't know how that could happen..).  Meanwhile I don't see either on how
> vma pg_off affects this (and I assume a real KSM page ignores page->index
> completely).

I think you are right with folio->index = linear_page_index(vma, address).

I did not check the code yet, but thinking about it I figured out why we 
want to set pgoff to the start of the VMA in the address space for 
anonymous memory:

For RMAP and friends (relying on linear_page_index), folio->index has to 
match the index within the VMA. If would set pgoff to something else, 
we'd have less VMA merging opportunities. So your system might work, but 
you'd end up with many anon VMAs.


Imagine the following:

[ anon0 ][  fd   ][ anon1 ]

Unmap the fd:

[ anon0 ][ hole  ][ anon1 ]

Mmap anon:

[ anon0 ][ anon2 ][ anon1 ]


We can now merge all 3 VMAs into one, even if the first and latter 
already map pages.


A simpler and more common example is probably:

[ anon0 ]

Mmmap anon1 before the existing one

[ anon1 ][ anon0 ]

Which we can merge into a single one.



Mapping after an existing one could work, but one would have to 
carefully set pgoff based on the size of the previous anon VMA ... which 
is more complicated

So instead, we consider the whole address space as a virtual, anon file, 
starting at offset 0. The pgoff of a VMA is then simply the offset in 
that virtual file (easily computed from the start of the VMA), and VMA 
merging is just the same as for an ordinary file.

-- 
Thanks,

David / dhildenb

