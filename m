Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3F66BD413
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjCPPkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjCPPkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:40:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781D4763C3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678981060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=10cvjAWj/i7Tr+Lb50o4wfxv3/cWk1L2EfPxqlS0kiI=;
        b=Y/sgKRq7lMHjHBZ7kYHtfTE/WP8lrLo75E9rCdM/RxZdfTqFbFWOLmUrPUtTTk6iRNCgLM
        DvqYlKFZfqn8MgDppEveDDPgorHwnl8mplAtO6ICATB1eiLabPOd/9/qh0RztWNopHnHTk
        BTP6AXGqWHFX+Sm68CQ+lHbcyvLhKpg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-5P9qB5f9MS-tNRE5TU38sA-1; Thu, 16 Mar 2023 11:37:39 -0400
X-MC-Unique: 5P9qB5f9MS-tNRE5TU38sA-1
Received: by mail-wr1-f71.google.com with SMTP id i25-20020adfaad9000000b002cff37de14fso381102wrc.16
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:37:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678981058;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=10cvjAWj/i7Tr+Lb50o4wfxv3/cWk1L2EfPxqlS0kiI=;
        b=EXuHs4OschwUsjTZyen2krzKc5M6LQM0z8pj38bpZHs15mQf2ho22+x9Zx6mSGIiVQ
         z1ikN8632uvWE6X29KFZpoWRkqc78W87WteSvW+cmkoE4AnlNaQZ65zbHSoqDf0+kwZ6
         Sw2ZCL24gKNiVmYf80ODV/0rSjgtHhGOo4RJgDU6XRK4jDC9iagziGENDsRddXVZYahH
         TXGDKq/xjBeHe3eueDPdt8g4/RmbCsarq2in6g1yXWuetiERZ3DCFEsB+1l6Eq3owGvG
         aChe5JECRCpR6l4f61Z/aN6dJuv4PbweNYXYAVzgXECbcr7YuVXQDnEIlyc+zmFeRV+2
         qZNQ==
X-Gm-Message-State: AO0yUKWluNNS3MI3iynPFwhULZdItKvWT+DcE+ha/QIusPb52YF19ocA
        f011Iv1dIEnaqYSNHDKhJet54vGYJQsewnKUJvmBS1kRkxqVhmsxMeUWhPVkV07IVnTzDmBKBrP
        LU8JsfQU0mmKi3KeLPCbotMyb
X-Received: by 2002:a5d:5955:0:b0:2cf:e29f:d7f5 with SMTP id e21-20020a5d5955000000b002cfe29fd7f5mr4525448wri.25.1678981058130;
        Thu, 16 Mar 2023 08:37:38 -0700 (PDT)
X-Google-Smtp-Source: AK7set8fqjO7xgut70o0sevMb1v49SL3ULnSmxx8KeSVsgNMEeq2wco+1sVFyTBO2HcQ0pt6HItXAg==
X-Received: by 2002:a5d:5955:0:b0:2cf:e29f:d7f5 with SMTP id e21-20020a5d5955000000b002cfe29fd7f5mr4525437wri.25.1678981057806;
        Thu, 16 Mar 2023 08:37:37 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id w12-20020a5d608c000000b002cfefa50a8esm6184757wrt.98.2023.03.16.08.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 08:37:37 -0700 (PDT)
Message-ID: <e25eca2e-67c8-bcd5-69f8-f6590fc0b011@redhat.com>
Date:   Thu, 16 Mar 2023 16:37:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] mm/thp: Rename TRANSPARENT_HUGEPAGE_NEVER_DAX to
 _UNSUPPORTED
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>
References: <20230315171642.1244625-1-peterx@redhat.com>
 <83625129-26c9-8885-7367-bb56bc5367f3@redhat.com> <ZBMzQW674oHQJV7F@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZBMzQW674oHQJV7F@x1n>
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

On 16.03.23 16:18, Peter Xu wrote:
> On Thu, Mar 16, 2023 at 03:57:12PM +0100, David Hildenbrand wrote:
>> On 15.03.23 18:16, Peter Xu wrote:
>>> TRANSPARENT_HUGEPAGE_NEVER_DAX has nothing to do with DAX.  It's set when
>>> has_transparent_hugepage() returns false, checked in hugepage_vma_check()
>>> and will disable THP completely if false.  Rename it to reflect its real
>>> purpose.
>>>
>>> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>> Cc: Yang Shi <shy828301@gmail.com>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>    include/linux/huge_mm.h | 2 +-
>>>    mm/huge_memory.c        | 4 ++--
>>>    2 files changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>> index 70bd867eba94..9a3a3af2dd80 100644
>>> --- a/include/linux/huge_mm.h
>>> +++ b/include/linux/huge_mm.h
>>> @@ -79,7 +79,7 @@ static inline vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn,
>>>    }
>>>    enum transparent_hugepage_flag {
>>> -	TRANSPARENT_HUGEPAGE_NEVER_DAX,
>>> +	TRANSPARENT_HUGEPAGE_UNSUPPORTED,
>>>    	TRANSPARENT_HUGEPAGE_FLAG,
>>>    	TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
>>>    	TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG,
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index b0ab247939e0..913e7dc32869 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -88,7 +88,7 @@ bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
>>>    	/*
>>>    	 * If the hardware/firmware marked hugepage support disabled.
>>>    	 */
>>> -	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_NEVER_DAX))
>>> +	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_UNSUPPORTED))
>>>    		return false;
>>>    	/* khugepaged doesn't collapse DAX vma, but page fault is fine. */
>>> @@ -464,7 +464,7 @@ static int __init hugepage_init(void)
>>>    		 * Hardware doesn't support hugepages, hence disable
>>>    		 * DAX PMD support.
>>
>>
>> We should also fixup that comment then, no?
> 
> Yes, I'd drop the comment since the code explains itself.  One fixup
> attached.  Thanks.

LGTM

-- 
Thanks,

David / dhildenb

