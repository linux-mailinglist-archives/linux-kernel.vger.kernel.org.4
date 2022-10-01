Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F095F186C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 03:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiJAB2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 21:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbiJAB2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 21:28:23 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D862E697;
        Fri, 30 Sep 2022 18:28:19 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id d15so3852653qka.9;
        Fri, 30 Sep 2022 18:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=NKdvHvQ44i5cKwfP63cHSA4v+56YKGXpXNp8A2uLGk0=;
        b=FCZdmHTXpzPh+SsHcbqp1NVBPvLVyGUTI1Z1NrHdkhsxdmOLtckQ+AzroORVm1xfbe
         2AvWitpo2qrn4401punrBuO2gNFE91JNc+rQ1OCv9ksC57ugddx+WD5k81UvZVKyBOKU
         GcW8Zu1WDE+3ah0ndtw+iZfXjhkMdRQejkPL6LrAAcTuiJScy1cRNcszUY2Yuqxh08qm
         F+ApvDwF0URuQHgg4L9QcIpp6e8GG2AnZhQyoez77JPvDJKuA0Euu0u0rCPg1oXU0RUz
         KI4iW7LC4VjML5NNLxTUtt7Vk5ezCWqemRdQpktx9/NvbPWiSanwnpcM1SxTmjYTDyob
         gv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=NKdvHvQ44i5cKwfP63cHSA4v+56YKGXpXNp8A2uLGk0=;
        b=2bKVraubzrYKzdJr0n6se4X8vR6kZQNaTSb8HQahc4e105qcYN77wPtjejAChaj2Ao
         4V8tcLT+myIIAgGcLgcKkhBw2+y3cYHTT+lKPcNIj4Xe+hDSbCVCgNje3CbgjBLlH2wa
         3y2iSfOY/PeV+4xKQhP4FIgLnDUBGSf4/iszD9HRBJPY9dSHg4fz7AvSDOidcstmqfUU
         3Fp9REQLo9D0tZP8cZJXwJ4WpYtMpv7YQDQ1E5YkRpXcABDsuKTv8uuRdKyNnxuy+S6c
         fG8NUScHVen5sqKMfoFHDqFRhivTLCGccjEYY7jUpUS5pLEuImXhEpSVekirq8chMdLt
         oTrw==
X-Gm-Message-State: ACrzQf1eIs7vGOtWHkvTf1rVXfQROHMJPiqUItc5q9tat1uoLbU131eO
        HkaH5fDDf3bxOLO1Nqrkylk=
X-Google-Smtp-Source: AMsMyM5yIKxAHMaIcYqUfvWo5dav+HCUqxOsA5j4NLkufoQwILTy6jGJJb9OrwbCTNdnhlkr/R4qGA==
X-Received: by 2002:a37:a98c:0:b0:6cf:9ca3:b2fd with SMTP id s134-20020a37a98c000000b006cf9ca3b2fdmr8331629qke.118.1664587698484;
        Fri, 30 Sep 2022 18:28:18 -0700 (PDT)
Received: from [10.69.53.73] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a16-20020a05620a16d000b006b58d8f6181sm3814147qkn.72.2022.09.30.18.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 18:28:17 -0700 (PDT)
Message-ID: <b86d90fe-5d57-67ec-49b7-c477924f6438@gmail.com>
Date:   Fri, 30 Sep 2022 18:28:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 2/9] mm/vmstat: show start_pfn when zone spans pages
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
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
From:   Doug Berger <opendmb@gmail.com>
In-Reply-To: <8e61d0f4-0c40-6c2d-da60-fa97e2ee7530@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/2022 1:15 AM, David Hildenbrand wrote:
> On 29.09.22 00:32, Doug Berger wrote:
>> A zone that overlaps with another zone may span a range of pages
>> that are not present. In this case, displaying the start_pfn of
>> the zone allows the zone page range to be identified.
>>
> 
> I don't understand the intention here.
> 
> "/* If unpopulated, no other information is useful */"
> 
> Why would the start pfn be of any use here?
> 
> What is the user visible impact without that change?
Yes, this is very subtle. I only caught it while testing some 
pathological cases.

If you take the example system:
The 7278 device has four ARMv8 CPU cores in an SMP cluster and two 
memory controllers (MEMCs). Each MEMC is capable of controlling up to 
8GB of DRAM. An example 7278 system might have 1GB on each controller, 
so an arm64 kernel might see 1GB on MEMC0 at 0x40000000-0x7FFFFFFF and 
1GB on MEMC1 at 0x300000000-0x33FFFFFFF.

Placing a DMB on MEMC0 with 'movablecore=256M@0x70000000' will lead to 
the ZONE_MOVABLE zone spanning from 0x70000000-0x33fffffff and the 
ZONE_NORMAL zone spanning from 0x300000000-0x33fffffff.

If instead you specified 'movablecore=256M@0x70000000,512M' you would 
get the same ZONE_MOVABLE span, but the ZONE_NORMAL would now span 
0x300000000-0x32fffffff. The requested 512M of movablecore would be 
divided into a 256MB DMB at 0x70000000 and a 256MB "classic" movable 
zone start would be displayed in the bootlog as:
[    0.000000] Movable zone start for each node
[    0.000000]   Node 0: 0x000000330000000

Finally, if you specified the pathological 
'movablecore=256M@0x70000000,1G@12G' you would still have the same 
ZONE_MOVABLE span, and the ZONE_NORMAL span would go back to 
0x300000000-0x33fffffff. However, because the second DMB (1G@12G) 
completely overlaps the ZONE_NORMAL there would be no pages present in 
ZONE_NORMAL and /proc/zoneinfo would report ZONE_NORMAL 'spanned 
262144', but not where those pages are. This commit adds the 'start_pfn' 
back to the /proc/zoneinfo for ZONE_NORMAL so the span has context.

Regards,
     Doug

> 
>> Signed-off-by: Doug Berger <opendmb@gmail.com>
>> ---
>>   mm/vmstat.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/mm/vmstat.c b/mm/vmstat.c
>> index 90af9a8572f5..e2f19f2b7615 100644
>> --- a/mm/vmstat.c
>> +++ b/mm/vmstat.c
>> @@ -1717,6 +1717,11 @@ static void zoneinfo_show_print(struct seq_file 
>> *m, pg_data_t *pgdat,
>>       /* If unpopulated, no other information is useful */
>>       if (!populated_zone(zone)) {
>> +        /* Show start_pfn for empty overlapped zones */
>> +        if (zone->spanned_pages)
>> +            seq_printf(m,
>> +                   "\n  start_pfn:           %lu",
>> +                   zone->zone_start_pfn);
>>           seq_putc(m, '\n');
>>           return;
>>       }

