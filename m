Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0E1664541
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 16:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbjAJPso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 10:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjAJPsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:48:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC65144C5B
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 07:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673365675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cSzObwxumbN+UkQGeWa1qzsda16QNp+w2Cr+vbxgJ/M=;
        b=R12Naht8DF7q35rs0yGXK9lQYOPghs8tMrfyVdk5ZtpTzrdhbAs/gGW0kXJbbAorB7VZpA
        ywdLWhmq3ARuOuhGXwkVvaVjwi/fr5AsVByBzz4cq9/tDlWaH2H4T13KTdtCT9vTd9qrdA
        RTD7cYOMp0MYcEvOg+DURyNtaLHfU9Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-664--sgXk9JfPuOPReMWh04OUA-1; Tue, 10 Jan 2023 10:47:52 -0500
X-MC-Unique: -sgXk9JfPuOPReMWh04OUA-1
Received: by mail-wr1-f69.google.com with SMTP id d27-20020adfa35b000000b002bc813ba677so980195wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 07:47:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cSzObwxumbN+UkQGeWa1qzsda16QNp+w2Cr+vbxgJ/M=;
        b=bkghWEnTx4XuISbZfWbUkr+OEwsHY4SX0LWdyEj/7YcuZvo0EpOhUZ39RjQue0w3gC
         i+oRVYrn5hQ1SLtc4/x1bWrd67f3mZpOU/yWuXDlMYIARFcLaRwgUcAOYpg+Oj7Gchgy
         gK4019Udf3x6+2QDAQW3S4XPOi3acL9oBe+weVkxIPBCA04Y1Ul/xQoqFRXuVTtVcZyR
         qXLm2i/uji5Pc/pTSyH/kXrEaW9/pZe794fvqZ872LGZytH6nqsqbhwzm7oufvySURqN
         IVx+kzCtoD5erZ/khTDgmpDYDFTFrAPShjs8ZikHqYDn1BLC4sN7t4UeLFNVt053ASA4
         ZAJQ==
X-Gm-Message-State: AFqh2kpAhA7XP/R2Gc7ceBsbZ0NEfFUqNSsCazx1lnDxtBIA4CqeV0op
        mlNdopvtYYyzBakniz7Ux6oV4q4+k++JGj0yfvAx5AX+Ro8l0nr4OltC9ZLkEFIqokLWnV7gZCE
        LHrJNrHfA/cNKT26OaCpe2bSs
X-Received: by 2002:adf:e9d1:0:b0:242:5fe3:b61b with SMTP id l17-20020adfe9d1000000b002425fe3b61bmr41624823wrn.23.1673365671755;
        Tue, 10 Jan 2023 07:47:51 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs9YnvwZN98X1f+BspYVBBXRFNES6tA+IXgOS+4rTtsIEHri7EJWOFFDrKPpECnSp4WsoK3ug==
X-Received: by 2002:adf:e9d1:0:b0:242:5fe3:b61b with SMTP id l17-20020adfe9d1000000b002425fe3b61bmr41624811wrn.23.1673365671495;
        Tue, 10 Jan 2023 07:47:51 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:4200:65d9:4d0d:bb61:14c8? (p200300cbc708420065d94d0dbb6114c8.dip0.t-ipconnect.de. [2003:cb:c708:4200:65d9:4d0d:bb61:14c8])
        by smtp.gmail.com with ESMTPSA id q4-20020adfdfc4000000b002bc6c180738sm5779763wrn.90.2023.01.10.07.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 07:47:51 -0800 (PST)
Message-ID: <4b52c79e-7b40-1d5e-bd92-d99224be8ba0@redhat.com>
Date:   Tue, 10 Jan 2023 16:47:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 00/46] Based on latest mm-unstable (85b44c25cd1e).
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     James Houghton <jthoughton@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230105101844.1893104-1-jthoughton@google.com>
 <60f06008-dea5-a08e-edec-fc4aec76dfb5@redhat.com> <Y7xwoZq+WqCsyXpw@monkey>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y7xwoZq+WqCsyXpw@monkey>
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

On 09.01.23 20:53, Mike Kravetz wrote:
> On 01/05/23 11:47, David Hildenbrand wrote:
>> On 05.01.23 11:17, James Houghton wrote:
>>> This series introduces the concept of HugeTLB high-granularity mapping
>>> (HGM). This series teaches HugeTLB how to map HugeTLB pages at
>>> high-granularity, similar to how THPs can be PTE-mapped.
>>>
>>> Support for HGM in this series is for MAP_SHARED VMAs on x86 only. Other
>>> architectures and (some) support for MAP_PRIVATE will come later.
>>
>> Why even care about the complexity of COW-sharable anon pages? TBH, I'd just
>> limit this to MAP_SHARED and call it a day. Sure, we can come up with use
>> cases for everything (snapshotting VMs using fork while also support
>> optimized postcopy), but I think this would need some real justification for
>> the added complexity and possible (likely!) issues.
> 
> I believe the primary use case driving this beyond MAP_SHARED would be
> poisoning due to memory errors.  Extending HGM seems to be the most
> elegant way to start providing better support for this.

Good point. Although I wonder if in practice, most applicable users 
either already are, or should switch to, using MAP_SHARED hugetlb.

-- 
Thanks,

David / dhildenb

