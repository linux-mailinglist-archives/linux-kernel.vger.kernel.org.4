Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB4B6A047D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 10:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbjBWJIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 04:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbjBWJIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 04:08:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E801EFF2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677143262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E/BAL2p+AIRztx0whTYatHzYBA8FlxWN8hYeshAkNjI=;
        b=BKIxgD1mPMUqNP8Tvdl8M+n2ZYS7mXw4gm+jUyFnC0T7LdpKB2Km6n7n0YDWyBfggDpg8B
        ORqdXArU82DhZ0p7wJUQNQ01NP0mEokwWUq8U2ZKATHTTGlywkVXfCJR2rPx8A8dbdN96p
        nQ8zY2n4BaUrcAcYt2jAJAsZOdDn4jc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-644-gFGA5TIbOc22GBzRIq3J2Q-1; Thu, 23 Feb 2023 04:07:38 -0500
X-MC-Unique: gFGA5TIbOc22GBzRIq3J2Q-1
Received: by mail-wr1-f70.google.com with SMTP id z6-20020a5d4c86000000b002c54ce46094so2290934wrs.17
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:07:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E/BAL2p+AIRztx0whTYatHzYBA8FlxWN8hYeshAkNjI=;
        b=UI4haM69zClGK1jz5PB2QOqAQT5yCBfZ+npl8q3hvtps/lkBYLdUQSTV4ZmYTvsoVH
         rBgWWx3UA+X0vEvhSzEt6BFOyOSuIcTkhV9LmSYH3ImRagDuM3hgxIAQHsevbGUXIs+D
         asNvv2BnfRBIaMVtG/VtLw7y0IFxWiGTS+a1R8euqJZ+SYQOBc8/5b/VHQeL/nJ1V5hf
         STyyqAbwzudx8ryRUqAr2ULg1azDGQxueSP3pQUlE1gaskW1kpC71K3e9x+2LHfDGd4W
         niVBJJEWvma08b7dku1h6ViBdot/BR4sXVc1k2mS5ba3QpBKblYiFYOrvERxIm38bykm
         lQHQ==
X-Gm-Message-State: AO0yUKXIeOtcTm2jBzFOgn3OwwRizH354Ru1vv+fIDgKfNgjtiAOuSNt
        VYEcYwjomVpybr22PuQg/jJ0Watzwe5HC5nemfkhb6aU6MJqGMvm3jfql0w4vVOEVQHrBjbuvzJ
        BWPXyJ/pw4ATRDYLbiRg+v7l4
X-Received: by 2002:a05:600c:328a:b0:3dc:50bc:da70 with SMTP id t10-20020a05600c328a00b003dc50bcda70mr7957847wmp.10.1677143257501;
        Thu, 23 Feb 2023 01:07:37 -0800 (PST)
X-Google-Smtp-Source: AK7set9RfY0vcBnPlzesx2HPB/lwsM3Xewi6Cu7IlK2PdBhnzLKimFGqKFnsMpy3GzL7gL20mRDDag==
X-Received: by 2002:a05:600c:328a:b0:3dc:50bc:da70 with SMTP id t10-20020a05600c328a00b003dc50bcda70mr7957827wmp.10.1677143257112;
        Thu, 23 Feb 2023 01:07:37 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 15-20020a05600c22cf00b003e11f280b8bsm11307836wmg.44.2023.02.23.01.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 01:07:36 -0800 (PST)
Message-ID: <94a10407-ebcb-7090-ef92-2bbc9416d6fa@redhat.com>
Date:   Thu, 23 Feb 2023 10:07:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 00/46] hugetlb: introduce HugeTLB high-granularity
 mapping
Content-Language: en-US
To:     Mina Almasry <almasrymina@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAHS8izNPr+TfxLL_dBitKAgd11rPhjHx+10Nn96TD3HXzUSevQ@mail.gmail.com>
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

On 22.02.23 21:57, Mina Almasry wrote:
> On Wed, Feb 22, 2023 at 7:49 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 21.02.23 22:46, Mike Kravetz wrote:
>>> On 02/18/23 00:27, James Houghton wrote:
>>>> This series introduces the concept of HugeTLB high-granularity mapping
>>>> (HGM). This series teaches HugeTLB how to map HugeTLB pages at
>>>> high-granularity, similar to how THPs can be PTE-mapped.
>>>>
>>>> Support for HGM in this series is for MAP_SHARED VMAs on x86_64 only. Other
>>>> architectures and (some) support for MAP_PRIVATE will come later.
>>>>
>>>> This series is based on latest mm-unstable (ccd6a73daba9).
>>>>
>>>> Notable changes with this series
>>>> ================================
>>>>
>>>>    - hugetlb_add_file_rmap / hugetlb_remove_rmap are added to handle
>>>>      mapcounting for non-anon hugetlb.
>>>>    - The mapcounting scheme uses subpages' mapcounts for high-granularity
>>>>      mappings, but it does not use subpages_mapcount(). This scheme
>>>>      prevents the HugeTLB VMEMMAP optimization from being used, so it
>>>>      will be improved in a later series.
>>>>    - page_add_file_rmap and page_remove_rmap are updated so they can be
>>>>      used by hugetlb_add_file_rmap / hugetlb_remove_rmap.
>>>>    - MADV_SPLIT has been added to enable the userspace API changes that
>>>>      HGM allows for: high-granularity UFFDIO_CONTINUE (and maybe other
>>>>      changes in the future). MADV_SPLIT does NOT force all the mappings to
>>>>      be PAGE_SIZE.
>>>>    - MADV_COLLAPSE is expanded to include HugeTLB mappings.
>>>>
>>>> Old versions:
>>>> v1: https://lore.kernel.org/linux-mm/20230105101844.1893104-1-jthoughton@google.com/
>>>> RFC v2: https://lore.kernel.org/linux-mm/20221021163703.3218176-1-jthoughton@google.com/
>>>> RFC v1: https://lore.kernel.org/linux-mm/20220624173656.2033256-1-jthoughton@google.com/
>>>>
>>>> Changelog:
>>>> v1 -> v2 (thanks Peter for all your suggestions!):
>>>> - Changed mapcount to be more THP-like, and make HGM incompatible with
>>>>     HVO.
>>>> - HGM is now disabled by default to leave HVO enabled by default.
>>>
>>> I understand the reasoning behind the move to THP-like mapcounting, and the
>>> incompatibility with HVO.  However, I just got to patch 5 and realized either
>>> HGM or HVO will need to be chosen at kernel build time.  That may not be an
>>> issue for cloud providers or others building their own kernels for internal
>>> use.  However, distro kernels will need to pick one option or the other.
>>> Right now, my Fedora desktop has HVO enabled so it would likely not have
>>> HGM enabled.  That is not a big deal for a desktop.
>>>
>>> Just curious, do we have distro kernel users that want to use HGM?
>>
>> Most certainly I would say :)
>>
> 
> Is it a blocker to merge in an initial implementation though? Do
> distro kernel users have a pressing need for HVO + HGM used in tandem?

At least RHEL9 seems to include HVO. It's not enabled as default 
(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON not set), but compiled 
in so it can be runtime-enabled. Disabling HVO is not an option IMHO.

Maybe, one could make both features compile-time compatible but 
runtime-mutually exclusive. Or work on a way to make them fully 
compatible right from the start.

-- 
Thanks,

David / dhildenb

