Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D062E5F598C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 20:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiJESJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 14:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiJESJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 14:09:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36CC3AA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 11:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664993374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EILNfA7N9+8iFvHlpQy0LTguKHZxy+BH1aj+G4n/6Fg=;
        b=C/FQBSV9zTA8B6a1e5/qaPlKsPuZrQ1txQBsc88KFsGplZZyFbsjVqqPXQpvXiVePbzEnS
        k7hiNdZWFZ8/u4UAyDiBg11D9ERr1Mn0eDTP42i9Zs1jHxfdXyE3UrQIEpY0VyTkWwvMt3
        cqER8DRyn3Wb7Xr8BGKvZif5yglFMOk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-661-4v4E5jOKOHmoBsdAnaXg6Q-1; Wed, 05 Oct 2022 14:09:32 -0400
X-MC-Unique: 4v4E5jOKOHmoBsdAnaXg6Q-1
Received: by mail-wm1-f71.google.com with SMTP id i82-20020a1c3b55000000b003bf635eac31so1058363wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 11:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=EILNfA7N9+8iFvHlpQy0LTguKHZxy+BH1aj+G4n/6Fg=;
        b=K7t4uzIKr7tvhdFRq8lNgAghbbja+ISjFbXDrnrIti61cKzDN4lIrQVPj+WMyy2M6H
         wL/AiDSJH9gHAfPPXyxTY0jWeNEV1nTz3rJOKJafXZEtJUWW7RdTwIIz4/dhXFzIHbYi
         7wICIDPUWAt/0PtMkllXliWGQ8cYHP7mXFahIStlICdatHymUvZylxv2XVk0ZOvnePZp
         jPAAbPWw/kHi6xvoJ8+3UEAmGLsms8yEKxl9xKd1pDSEkMhkX7eGut2nBpc+UeLmIU27
         v6aBqBiEWVC22P4vbaJIAS5NnMGC3n+Ak50y2c8qBQ902srG1+yuyMJfI/RRwGhgmG/J
         mzAw==
X-Gm-Message-State: ACrzQf3e7O9o/Wf9MHiXULWDUCAfP+9rlaFLXdO350fOImOUzt0UHfWs
        KWZId2Y6Ykpcn+jbq4DH+CDUqXOvsl0M7u9kgEmKQaPJFWRI5j+jTSJKkg9Odh1nn09Lvfakj6M
        BNl5HAdmeByc0LbBMWzJUuxN0
X-Received: by 2002:a5d:6a42:0:b0:22e:6706:647b with SMTP id t2-20020a5d6a42000000b0022e6706647bmr642983wrw.58.1664993371131;
        Wed, 05 Oct 2022 11:09:31 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6GWHac6uT0D+X91ERTzLNHZyPlhzgA2jM5+WzKEJoau6td1MXwIP/Qp+dZqdNDDL+WY0UZDg==
X-Received: by 2002:a5d:6a42:0:b0:22e:6706:647b with SMTP id t2-20020a5d6a42000000b0022e6706647bmr642956wrw.58.1664993370783;
        Wed, 05 Oct 2022 11:09:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:5a00:b732:1c9:3697:fccf? (p200300cbc7025a00b73201c93697fccf.dip0.t-ipconnect.de. [2003:cb:c702:5a00:b732:1c9:3697:fccf])
        by smtp.gmail.com with ESMTPSA id f11-20020a05600c154b00b003a3442f1229sm3123817wmg.29.2022.10.05.11.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 11:09:30 -0700 (PDT)
Message-ID: <84ee3d9e-9579-d3f2-fe5a-ec6ec4a2710a@redhat.com>
Date:   Wed, 5 Oct 2022 20:09:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
To:     Doug Berger <opendmb@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Muchun Song <songmuchun@bytedance.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20220928223301.375229-1-opendmb@gmail.com>
 <20220928223301.375229-3-opendmb@gmail.com>
 <8e61d0f4-0c40-6c2d-da60-fa97e2ee7530@redhat.com>
 <b86d90fe-5d57-67ec-49b7-c477924f6438@gmail.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 2/9] mm/vmstat: show start_pfn when zone spans pages
In-Reply-To: <b86d90fe-5d57-67ec-49b7-c477924f6438@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.10.22 03:28, Doug Berger wrote:
> On 9/29/2022 1:15 AM, David Hildenbrand wrote:
>> On 29.09.22 00:32, Doug Berger wrote:
>>> A zone that overlaps with another zone may span a range of pages
>>> that are not present. In this case, displaying the start_pfn of
>>> the zone allows the zone page range to be identified.
>>>
>>
>> I don't understand the intention here.
>>
>> "/* If unpopulated, no other information is useful */"
>>
>> Why would the start pfn be of any use here?
>>
>> What is the user visible impact without that change?
> Yes, this is very subtle. I only caught it while testing some
> pathological cases.
> 
> If you take the example system:
> The 7278 device has four ARMv8 CPU cores in an SMP cluster and two
> memory controllers (MEMCs). Each MEMC is capable of controlling up to
> 8GB of DRAM. An example 7278 system might have 1GB on each controller,
> so an arm64 kernel might see 1GB on MEMC0 at 0x40000000-0x7FFFFFFF and
> 1GB on MEMC1 at 0x300000000-0x33FFFFFFF.
> 

Okay, thanks. You should make it clearer in the patch description -- 
especially how this relates to DMB. Having that said, I still have to 
digest your examples:

> Placing a DMB on MEMC0 with 'movablecore=256M@0x70000000' will lead to
> the ZONE_MOVABLE zone spanning from 0x70000000-0x33fffffff and the
> ZONE_NORMAL zone spanning from 0x300000000-0x33fffffff.

Why is ZONE_MOVABLE spanning more than 256M? It should span

0x70000000-0x80000000

Or what am I missing?

> 
> If instead you specified 'movablecore=256M@0x70000000,512M' you would
> get the same ZONE_MOVABLE span, but the ZONE_NORMAL would now span
> 0x300000000-0x32fffffff. The requested 512M of movablecore would be
> divided into a 256MB DMB at 0x70000000 and a 256MB "classic" movable
> zone start would be displayed in the bootlog as:
> [    0.000000] Movable zone start for each node
> [    0.000000]   Node 0: 0x000000330000000


Okay, so that's the movable zone range excluding DMB.

> 
> Finally, if you specified the pathological
> 'movablecore=256M@0x70000000,1G@12G' you would still have the same
> ZONE_MOVABLE span, and the ZONE_NORMAL span would go back to
> 0x300000000-0x33fffffff. However, because the second DMB (1G@12G)
> completely overlaps the ZONE_NORMAL there would be no pages present in
> ZONE_NORMAL and /proc/zoneinfo would report ZONE_NORMAL 'spanned
> 262144', but not where those pages are. This commit adds the 'start_pfn'
> back to the /proc/zoneinfo for ZONE_NORMAL so the span has context.

... but why? If there are no pages present, there is no ZONE_NORMAL we 
care about. The zone span should be 0. Does this maybe rather indicate 
that there is a zone span processing issue in your DMB implementation?

Special-casing zones based on DMBs feels wrong. But most probably I am 
missing something important :)

-- 
Thanks,

David / dhildenb

