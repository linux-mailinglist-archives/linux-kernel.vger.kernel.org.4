Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078C46A0DB7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 17:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbjBWQTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 11:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbjBWQTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 11:19:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E738D6EAC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 08:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677169144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J5wJD4UZGGLwwhFNUelyaNQpGB+8TJ0lXfVf1F3a+Rc=;
        b=SJmluBiiS7hjaDEQLVfjMbs8RyUQMBj9V+TrI3ahMwdXDGs0bn9IsJ2lkFlcmC4OXWTUWT
        NfVphzLICtV/WVgx6oit7VOuagmDNkVpW9q9T/F77TTvNfICzvCnrSyCqPsgX4cfqSa+H0
        YXYCUxBDkWqvYCMdwpDmO56zL+CvXdQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-637-yrvnEPUwN-CQihCW4oo4vg-1; Thu, 23 Feb 2023 11:17:41 -0500
X-MC-Unique: yrvnEPUwN-CQihCW4oo4vg-1
Received: by mail-wm1-f69.google.com with SMTP id az39-20020a05600c602700b003e97eb80524so2237920wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 08:17:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J5wJD4UZGGLwwhFNUelyaNQpGB+8TJ0lXfVf1F3a+Rc=;
        b=XmX1mgqU4RQgsqZ8210BFtgdb8JGqXXFH8GOqgLEbrmoSUSyYO4iOw1CwwQWvfNofD
         dj32WYa+WU7OS+zWAKENOQMCNZdoVnAkJCltC/2WkHht/aXWyNG2L2A/3iHaJmhdMnhp
         cZNH3oEmKYa9JF0MOSq+wpQcBKKA1eBYvIyXQ+0a4MhLR52A0p7YJoB1uEmRz1xizo8X
         9ruB6mCS3zhwu/qSBYm5ny/tElOK0NZ2gLUE9oSFpRhqSiQF4t9pMl8e8b8ZjnDTHFrQ
         whEFtcPJRrG0SAso8uiHUSt7cbqtSLTLQX3Jrq+Cn4ZcG6SsbkevekUicSD7UJjAmGUM
         VVEg==
X-Gm-Message-State: AO0yUKX7zaGOcC9JsMRCDyH+0x+goPcXJEumjaMkPUT5qJ6lFbPxnGfx
        lc3ahdcpGr3k4mSAGKpeg4xOPW7R2lcGXGMcQwddPflviHCtCRhGti2QbEhpapORAcSKvCrJRpK
        rQTL/0uyZ8Ns4GhHn49TLnMfM
X-Received: by 2002:a5d:4e0e:0:b0:2c6:8e3a:f701 with SMTP id p14-20020a5d4e0e000000b002c68e3af701mr9662818wrt.56.1677169053445;
        Thu, 23 Feb 2023 08:17:33 -0800 (PST)
X-Google-Smtp-Source: AK7set90iGL7LLCK3O7yvoRG0v9no1ZsdfIyCN8b0GEahclZRogIll9xh9jikihjR1SiHy8LOrSFTQ==
X-Received: by 2002:a5d:4e0e:0:b0:2c6:8e3a:f701 with SMTP id p14-20020a5d4e0e000000b002c68e3af701mr9662786wrt.56.1677169053062;
        Thu, 23 Feb 2023 08:17:33 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:3000:cdd3:8a10:9480:1a33? (p200300cbc7063000cdd38a1094801a33.dip0.t-ipconnect.de. [2003:cb:c706:3000:cdd3:8a10:9480:1a33])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d51d0000000b002c56046a3b5sm10666859wrv.53.2023.02.23.08.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 08:17:32 -0800 (PST)
Message-ID: <0a0b3032-a275-ddc9-697b-a8bc2344d3bc@redhat.com>
Date:   Thu, 23 Feb 2023 17:17:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 00/46] hugetlb: introduce HugeTLB high-granularity
 mapping
Content-Language: en-US
To:     James Houghton <jthoughton@google.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230218002819.1486479-1-jthoughton@google.com>
 <Y/U7ngTyPlg2XCRj@monkey> <28a7208c-939c-19ea-1cf0-298444dffe85@redhat.com>
 <CAHS8izNPr+TfxLL_dBitKAgd11rPhjHx+10Nn96TD3HXzUSevQ@mail.gmail.com>
 <94a10407-ebcb-7090-ef92-2bbc9416d6fa@redhat.com>
 <CADrL8HVYBEJrn2BnXEzenTxmxgqCwg5EM+ow509TBCPQrDxsNQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CADrL8HVYBEJrn2BnXEzenTxmxgqCwg5EM+ow509TBCPQrDxsNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.02.23 16:53, James Houghton wrote:
> On Thu, Feb 23, 2023 at 1:07 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 22.02.23 21:57, Mina Almasry wrote:
>>> On Wed, Feb 22, 2023 at 7:49 AM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 21.02.23 22:46, Mike Kravetz wrote:
>>>>> On 02/18/23 00:27, James Houghton wrote:
>>>>>> This series introduces the concept of HugeTLB high-granularity mapping
>>>>>> (HGM). This series teaches HugeTLB how to map HugeTLB pages at
>>>>>> high-granularity, similar to how THPs can be PTE-mapped.
>>>>>>
>>>>>> Support for HGM in this series is for MAP_SHARED VMAs on x86_64 only. Other
>>>>>> architectures and (some) support for MAP_PRIVATE will come later.
>>>>>>
>>>>>> This series is based on latest mm-unstable (ccd6a73daba9).
>>>>>>
>>>>>> Notable changes with this series
>>>>>> ================================
>>>>>>
>>>>>>     - hugetlb_add_file_rmap / hugetlb_remove_rmap are added to handle
>>>>>>       mapcounting for non-anon hugetlb.
>>>>>>     - The mapcounting scheme uses subpages' mapcounts for high-granularity
>>>>>>       mappings, but it does not use subpages_mapcount(). This scheme
>>>>>>       prevents the HugeTLB VMEMMAP optimization from being used, so it
>>>>>>       will be improved in a later series.
>>>>>>     - page_add_file_rmap and page_remove_rmap are updated so they can be
>>>>>>       used by hugetlb_add_file_rmap / hugetlb_remove_rmap.
>>>>>>     - MADV_SPLIT has been added to enable the userspace API changes that
>>>>>>       HGM allows for: high-granularity UFFDIO_CONTINUE (and maybe other
>>>>>>       changes in the future). MADV_SPLIT does NOT force all the mappings to
>>>>>>       be PAGE_SIZE.
>>>>>>     - MADV_COLLAPSE is expanded to include HugeTLB mappings.
>>>>>>
>>>>>> Old versions:
>>>>>> v1: https://lore.kernel.org/linux-mm/20230105101844.1893104-1-jthoughton@google.com/
>>>>>> RFC v2: https://lore.kernel.org/linux-mm/20221021163703.3218176-1-jthoughton@google.com/
>>>>>> RFC v1: https://lore.kernel.org/linux-mm/20220624173656.2033256-1-jthoughton@google.com/
>>>>>>
>>>>>> Changelog:
>>>>>> v1 -> v2 (thanks Peter for all your suggestions!):
>>>>>> - Changed mapcount to be more THP-like, and make HGM incompatible with
>>>>>>      HVO.
>>>>>> - HGM is now disabled by default to leave HVO enabled by default.
>>>>>
>>>>> I understand the reasoning behind the move to THP-like mapcounting, and the
>>>>> incompatibility with HVO.  However, I just got to patch 5 and realized either
>>>>> HGM or HVO will need to be chosen at kernel build time.  That may not be an
>>>>> issue for cloud providers or others building their own kernels for internal
>>>>> use.  However, distro kernels will need to pick one option or the other.
>>>>> Right now, my Fedora desktop has HVO enabled so it would likely not have
>>>>> HGM enabled.  That is not a big deal for a desktop.
>>>>>
>>>>> Just curious, do we have distro kernel users that want to use HGM?
>>>>
>>>> Most certainly I would say :)
> 
> I'm not sure. Maybe distros want the hwpoison benefits HGM provides?
> But that's not implemented in this series.

 From what I can tell, HGM helps to improve live migration of VMs with 
gigantic pages. That sounds like a good reason why distros (that support 
virtualization) might want it independent of hwpoison changes.

-- 
Thanks,

David / dhildenb

