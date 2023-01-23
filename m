Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5374B6779D9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 12:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjAWLKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 06:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjAWLKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 06:10:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EF3222E9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 03:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674472166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aMnhh2FcKB6BDDZBKf1lz6P+s3DgCNA59AADk0H021Y=;
        b=aC6L9FHYfS51ak5U5XHGbhObGjjr9PcRjg5BdSImYOCMwJAWZR/HZ5IvqUnonH5Ws34BeE
        CyzKMb99AF647McYY9U96p5NY3C1Ceooq07AJ7NbPH1Iupd3BQiMSP17ssIRl8o38ZZ0t3
        psXeqGhfWqTXrJwFnVkK5I7o7p+usYg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-651-1bW8ozM-PbaPzjfwCQ9ROw-1; Mon, 23 Jan 2023 06:09:25 -0500
X-MC-Unique: 1bW8ozM-PbaPzjfwCQ9ROw-1
Received: by mail-wm1-f69.google.com with SMTP id q19-20020a1cf313000000b003d96c95e2f9so2724360wmq.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 03:09:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMnhh2FcKB6BDDZBKf1lz6P+s3DgCNA59AADk0H021Y=;
        b=G/nDta7YmoPpBA1p8KrWoTNMqKqGFnN8Syge12MfHz303qDgtHg+S1fn8vQrYwfYQP
         q/fupHPqQtEraABYN180hRKhawzT7UHcudPOrOWbWPo23Ekv2O2N2h+xUSABGD3j06Cu
         DopxW9gzL2xa1yqk4GqmIbUwFl7wVPoyTSCFwUZNFZ6aaVqYNgk0vxqmxnmg+CG0fP4F
         CoRTKI/56meIl8ZKrAMwW1vG1gzszVrDFRdvPuxv+YmAhJPQ7sVJI1mC7maNqD9RmCAD
         RPPrMbXSMoWkxag6AIDfnEGWZDXorqtFWVeFub4aV6BfrE74Lk/EZAjLZNV96Xd6Mz6s
         lTeA==
X-Gm-Message-State: AFqh2kqARPesOf3yD0acKyMJ3q1A9N0n1FBKX8Q88njaOwuJ4m4Gx9CX
        I8DvKBB4lpSXUJgzp3SnjoLgWC1r7arOaT8rh7+G37veaUUJ7gdc3eYELoDU100QssWKydvh/bF
        abFH35En84cNheBAAWGJj6caa
X-Received: by 2002:a05:600c:2056:b0:3db:ce8:6662 with SMTP id p22-20020a05600c205600b003db0ce86662mr21413153wmg.31.1674472164142;
        Mon, 23 Jan 2023 03:09:24 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtt/tjHMcVlvz+Zt+gH+lDqjAnjU0u5PzIEnVLrwsbollUeNyOSRYjMSOkguLXSPFUAvP+xXg==
X-Received: by 2002:a05:600c:2056:b0:3db:ce8:6662 with SMTP id p22-20020a05600c205600b003db0ce86662mr21413122wmg.31.1674472163770;
        Mon, 23 Jan 2023 03:09:23 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:1100:65a0:c03a:142a:f914? (p200300cbc704110065a0c03a142af914.dip0.t-ipconnect.de. [2003:cb:c704:1100:65a0:c03a:142a:f914])
        by smtp.gmail.com with ESMTPSA id q12-20020adff50c000000b002bc83b85180sm7289389wro.114.2023.01.23.03.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 03:09:23 -0800 (PST)
Message-ID: <84effdd8-1b67-4451-0fc4-a9e39210e5f1@redhat.com>
Date:   Mon, 23 Jan 2023 12:09:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mm/khugepaged: fix collapse_pte_mapped_thp() to allow
 anon_vma
Content-Language: en-US
To:     Zach O'Keefe <zokeefe@google.com>
Cc:     Yang Shi <shy828301@gmail.com>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <b740c9fb-edba-92ba-59fb-7a5592e5dfc@google.com>
 <dc9f7bb0-77d4-8b0e-c6b6-ece3f77ed326@redhat.com>
 <32be06f-f64-6632-4c36-bed7c0695a3b@google.com>
 <7ff97950-b524-db06-9ad6-e98b80dcfefa@redhat.com>
 <CAHbLzkqjooxnAwqK7vZoJpP2bSUTCUgv3UtWsZgo444jpGSfoA@mail.gmail.com>
 <86d5f618-800d-9672-56c4-9309ef222a39@redhat.com>
 <CAAa6QmSByYrWkp+8K0NK+pocKT0CVj83RaVUB1VqMPvuPHnpNQ@mail.gmail.com>
 <d50eb6f2-0585-7441-081b-cadaa5901c6e@redhat.com>
 <CAAa6QmR6KeCCMHGyR9jkwk-KCwb_FTcEfnKeHRJ2U7+3SVz7hg@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAAa6QmR6KeCCMHGyR9jkwk-KCwb_FTcEfnKeHRJ2U7+3SVz7hg@mail.gmail.com>
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

On 18.01.23 00:00, Zach O'Keefe wrote:
> On Mon, Jan 9, 2023 at 12:50 AM David Hildenbrand <david@redhat.com> wrote:
>>
>>>>>>>>
>>>>>>>> Side note: set_huge_pmd() wins the award of "ugliest mm function of early
>>>>>>>> 2023". I was briefly concerned how do_set_pmd() decides whether the PMD can be
>>>>>>>> writable or not. Turns out it's communicated via vm_fault->flags. Just
>>>>>>>> horrible.
>>>
> 
> Hey David,
> 
> Sorry for the late response here.
> 
>>> My first Linux award! :) At least it's not "worst mm security issue of
>>> early 2023". I'll take it!
>>
>> Good that you're not taking my words the wrong way.
>>
>> MADV_COLLAPSE is a very useful feature (especially also for THP tests
>> [1]). I wish I could have looked at some of the patches earlier. But we
>> cannot wait forever to get something merged, otherwise we'd never get
>> bigger changes upstream.
>>
>> ... so there is plenty of time left in 2023 to cleanup khugepaged.c :P
>>
>>
>> [1] https://lkml.kernel.org/r/20230104144905.460075-1-david@redhat.com
> 
> Yes, thank you for these tests. I have them open in another tab along
> with a mental TODO to take a closer look at them, and response
> half-written. In-place collapse of anonymous memory *is* something
> that I was interested in exploring later (I have a use-case for it;
> hugepage-aware malloc() implementations). I'm taking so long on it
> (sorry) b/c I need to review your point (2) (all PTE's mapping
> exclusively). Hopefully I can get to it shortly.

Cool, please let me know if you have any questions. Being able to 
in-place collapse a PTE-mapped anon THP again would be nice.

-- 
Thanks,

David / dhildenb

