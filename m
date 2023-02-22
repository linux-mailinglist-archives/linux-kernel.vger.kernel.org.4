Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB3369F84D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjBVPtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjBVPtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:49:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9977C31E36
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 07:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677080941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GVZBOKGD+V7dnhmBUhnfKIR5wlVaDW+yBjCOv4O7PbE=;
        b=Mh78JGukovE6zBFCTleVgkAKsid+TDEa/kJszmjqjpLL6x35m4cA3XtHEYaPwFRhc7UHVr
        B32xnnwUZBQe1v1rH3967+v5MYfMBCh3Gu4RpINYg5o7gzDT3DIk9mBMzQGvvP6ilpCA5b
        uVU3nQyIXbJ63a7KnZVDAt5sGtAvk0w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-613-f99Q36ioNYWIWMSA6LCkGA-1; Wed, 22 Feb 2023 10:49:00 -0500
X-MC-Unique: f99Q36ioNYWIWMSA6LCkGA-1
Received: by mail-wm1-f71.google.com with SMTP id c7-20020a7bc847000000b003e00be23a70so3685635wml.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 07:48:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GVZBOKGD+V7dnhmBUhnfKIR5wlVaDW+yBjCOv4O7PbE=;
        b=UJcyMvN7fG8ke6LR5uQikpU5Fxe+M8zHXlQXtg52TOSTJ2ccbIfpGk4MGwGqzIF91M
         Fyscdr2MiStc2qD+4HWGJRnqS2HH6WfpKnBSLktoKYxtftvBJY5R4kSCQNQnZ2TYIHoc
         ECibMS+kM/JNrkmALhHcGougYMz5LIBQuNNY3YFDaCk0g6oFSEtY8sibTt3aFaO8ANJq
         m+Ut05bNOVshXSzjgiPXiwCidW3lZnXDAPLRdsY0FWozZk71AKl5+AkwoYrmn+tTkeru
         tyaaGYSjb3Y1qCtM+294a24FAt+99CfP3lAGvIHwKrDzVyC6pg0A1Rkri+c/Itgo8p0S
         mBYQ==
X-Gm-Message-State: AO0yUKXmXuMBUMRerZDDpgmz4AgKOdpL9kLM04cNKfzZ6cKdU4W6wERQ
        YdzVXMwzJfncZjiBQ75JvZnIbcniXdc3WpCB3xLHwkX28Mhd3yfSwhoy5Vra2ht2SSishcMtf4j
        le4Vu0X6f/eyc+N+nSkN63WVX
X-Received: by 2002:adf:e505:0:b0:2c5:56ab:ee5b with SMTP id j5-20020adfe505000000b002c556abee5bmr7765716wrm.48.1677080938434;
        Wed, 22 Feb 2023 07:48:58 -0800 (PST)
X-Google-Smtp-Source: AK7set/2d8R8uayDlkM/vphgzaY3W11nRhaJF1cal3UEr+GSyZKqWne3weKffIQjki6hs0rJ/X8gKQ==
X-Received: by 2002:adf:e505:0:b0:2c5:56ab:ee5b with SMTP id j5-20020adfe505000000b002c556abee5bmr7765692wrm.48.1677080937997;
        Wed, 22 Feb 2023 07:48:57 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:a100:95ad:6325:131:6b1d? (p200300cbc704a10095ad632501316b1d.dip0.t-ipconnect.de. [2003:cb:c704:a100:95ad:6325:131:6b1d])
        by smtp.gmail.com with ESMTPSA id o24-20020a5d58d8000000b002c7066a6f77sm4586083wrf.31.2023.02.22.07.48.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 07:48:57 -0800 (PST)
Message-ID: <28a7208c-939c-19ea-1cf0-298444dffe85@redhat.com>
Date:   Wed, 22 Feb 2023 16:48:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 00/46] hugetlb: introduce HugeTLB high-granularity
 mapping
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230218002819.1486479-1-jthoughton@google.com>
 <Y/U7ngTyPlg2XCRj@monkey>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y/U7ngTyPlg2XCRj@monkey>
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

On 21.02.23 22:46, Mike Kravetz wrote:
> On 02/18/23 00:27, James Houghton wrote:
>> This series introduces the concept of HugeTLB high-granularity mapping
>> (HGM). This series teaches HugeTLB how to map HugeTLB pages at
>> high-granularity, similar to how THPs can be PTE-mapped.
>>
>> Support for HGM in this series is for MAP_SHARED VMAs on x86_64 only. Other
>> architectures and (some) support for MAP_PRIVATE will come later.
>>
>> This series is based on latest mm-unstable (ccd6a73daba9).
>>
>> Notable changes with this series
>> ================================
>>
>>   - hugetlb_add_file_rmap / hugetlb_remove_rmap are added to handle
>>     mapcounting for non-anon hugetlb.
>>   - The mapcounting scheme uses subpages' mapcounts for high-granularity
>>     mappings, but it does not use subpages_mapcount(). This scheme
>>     prevents the HugeTLB VMEMMAP optimization from being used, so it
>>     will be improved in a later series.
>>   - page_add_file_rmap and page_remove_rmap are updated so they can be
>>     used by hugetlb_add_file_rmap / hugetlb_remove_rmap.
>>   - MADV_SPLIT has been added to enable the userspace API changes that
>>     HGM allows for: high-granularity UFFDIO_CONTINUE (and maybe other
>>     changes in the future). MADV_SPLIT does NOT force all the mappings to
>>     be PAGE_SIZE.
>>   - MADV_COLLAPSE is expanded to include HugeTLB mappings.
>>
>> Old versions:
>> v1: https://lore.kernel.org/linux-mm/20230105101844.1893104-1-jthoughton@google.com/
>> RFC v2: https://lore.kernel.org/linux-mm/20221021163703.3218176-1-jthoughton@google.com/
>> RFC v1: https://lore.kernel.org/linux-mm/20220624173656.2033256-1-jthoughton@google.com/
>>
>> Changelog:
>> v1 -> v2 (thanks Peter for all your suggestions!):
>> - Changed mapcount to be more THP-like, and make HGM incompatible with
>>    HVO.
>> - HGM is now disabled by default to leave HVO enabled by default.
> 
> I understand the reasoning behind the move to THP-like mapcounting, and the
> incompatibility with HVO.  However, I just got to patch 5 and realized either
> HGM or HVO will need to be chosen at kernel build time.  That may not be an
> issue for cloud providers or others building their own kernels for internal
> use.  However, distro kernels will need to pick one option or the other.
> Right now, my Fedora desktop has HVO enabled so it would likely not have
> HGM enabled.  That is not a big deal for a desktop.
> 
> Just curious, do we have distro kernel users that want to use HGM?

Most certainly I would say :)

-- 
Thanks,

David / dhildenb

