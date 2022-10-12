Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EDB5FCF15
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 01:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiJLX6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 19:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJLX6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 19:58:00 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E00437FC;
        Wed, 12 Oct 2022 16:57:58 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id o2so156439qkk.10;
        Wed, 12 Oct 2022 16:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FmGTt81upNKJCIsUibynyofUcfo56u99EQM7Huk1XAY=;
        b=CgtNenL/z9CyDUzMXKS8FMIVEYPcOxh4jHQx/8pN6R0+6F7+VW5sS7NklPE7bmXIeQ
         XlqeopIhYfCMzOFNlev/XbSVskzyfM+wIFWhpM5HxUwVDqsV4n8YGPSvO72n0aXlTjZb
         pQx8vjEUO+T/W4vYbflHq2m43HAjcE/ipFf0Jwc0UxGVnMEnWJo/hPqEyZ4SQwX3dVXw
         TTq7+BTvX7xIGQBR5X+0pDLXCcUCgwQ9VglUwTAN+xsGuy9x7mgu0MrPicOHcdqczPe0
         UYenH3Qnbe+aQXpO2QU13S23tsaJVRGA3Je281PDBV4lb4AmOvyZa+SJrINuVIXyiv/q
         0wIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FmGTt81upNKJCIsUibynyofUcfo56u99EQM7Huk1XAY=;
        b=kjK8CPP1/GfvVsq9oc3AyRQK3H81haCPJUiXi9pfwG139I/+D5sdrph4CXkQEMe2P7
         YdRGToAm+1XuKtflPpT+lPRIiWPrFMYl4yOqKYqu/LBv5mxiZ6e77QIufZyFMWLfLF0A
         I014yvH9SwgJGsMgnFUSG9qcrsYrHf6vGEEHsPzNRSoz72u7upBsxOZivV4USkcIM9i5
         u7t64PtLa2NDmWMcjomlGeZlGYzhRBX2vOYMQ54iEN4ZoxCyOGC7iIcaFksidyVRcOAO
         644bXVC0mr5XfeLZPH2/52bhVYvphJO7eIigKT4rOMhA5HXchRzmdT5X5WQFn6EB/1Z3
         FiEQ==
X-Gm-Message-State: ACrzQf1yPnlfnUP+5g008dCnuTtn85CLAOvOhA7gbndpFmv10CAoLBZM
        ay5gQij2U1B5lQqwHDqEJBM=
X-Google-Smtp-Source: AMsMyM6sAy/Ash+9v4opTMFFF5CqbSfOxYuzqswsETtOQTHE46P24Et4A6MkmJdYKowAg6hvDglWmw==
X-Received: by 2002:a05:620a:43a8:b0:6ee:9b14:779e with SMTP id a40-20020a05620a43a800b006ee9b14779emr3519974qkp.343.1665619078010;
        Wed, 12 Oct 2022 16:57:58 -0700 (PDT)
Received: from [10.69.53.73] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id h19-20020a05620a401300b006eeb185c209sm1256588qko.50.2022.10.12.16.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 16:57:57 -0700 (PDT)
Message-ID: <0f038010-ed83-55bb-70a5-24f5c6d68666@gmail.com>
Date:   Wed, 12 Oct 2022 16:57:53 -0700
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
 <b86d90fe-5d57-67ec-49b7-c477924f6438@gmail.com>
 <84ee3d9e-9579-d3f2-fe5a-ec6ec4a2710a@redhat.com>
From:   Doug Berger <opendmb@gmail.com>
In-Reply-To: <84ee3d9e-9579-d3f2-fe5a-ec6ec4a2710a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/2022 11:09 AM, David Hildenbrand wrote:
> On 01.10.22 03:28, Doug Berger wrote:
>> On 9/29/2022 1:15 AM, David Hildenbrand wrote:
>>> On 29.09.22 00:32, Doug Berger wrote:
>>>> A zone that overlaps with another zone may span a range of pages
>>>> that are not present. In this case, displaying the start_pfn of
>>>> the zone allows the zone page range to be identified.
>>>>
>>>
>>> I don't understand the intention here.
>>>
>>> "/* If unpopulated, no other information is useful */"
>>>
>>> Why would the start pfn be of any use here?
>>>
>>> What is the user visible impact without that change?
>> Yes, this is very subtle. I only caught it while testing some
>> pathological cases.
>>
>> If you take the example system:
>> The 7278 device has four ARMv8 CPU cores in an SMP cluster and two
>> memory controllers (MEMCs). Each MEMC is capable of controlling up to
>> 8GB of DRAM. An example 7278 system might have 1GB on each controller,
>> so an arm64 kernel might see 1GB on MEMC0 at 0x40000000-0x7FFFFFFF and
>> 1GB on MEMC1 at 0x300000000-0x33FFFFFFF.
>>
> 
> Okay, thanks. You should make it clearer in the patch description -- 
> especially how this relates to DMB. Having that said, I still have to 
> digest your examples:
> 
>> Placing a DMB on MEMC0 with 'movablecore=256M@0x70000000' will lead to
>> the ZONE_MOVABLE zone spanning from 0x70000000-0x33fffffff and the
>> ZONE_NORMAL zone spanning from 0x300000000-0x33fffffff.
> 
> Why is ZONE_MOVABLE spanning more than 256M? It should span
> 
> 0x70000000-0x80000000
> 
> Or what am I missing?
I was working from the notion that the classic 'movablecore' 
implementation keeps the ZONE_MOVABLE zone the last zone on System RAM 
so it always spans the last page on the node (i.e. 0x33ffff000). My 
implementation moves the start of ZONE_MOVABLE up to the lowest page of 
any defined DMBs on the node.

I see that memory hotplug does not behave this way, which is probably 
more intuitive (though less consistent with the classic zone layout). I 
could attempt to change this in a v3 if desired.

> 
>>
>> If instead you specified 'movablecore=256M@0x70000000,512M' you would
>> get the same ZONE_MOVABLE span, but the ZONE_NORMAL would now span
>> 0x300000000-0x32fffffff. The requested 512M of movablecore would be
>> divided into a 256MB DMB at 0x70000000 and a 256MB "classic" movable
>> zone start would be displayed in the bootlog as:
>> [    0.000000] Movable zone start for each node
>> [    0.000000]   Node 0: 0x000000330000000
> 
> 
> Okay, so that's the movable zone range excluding DMB.
> 
>>
>> Finally, if you specified the pathological
>> 'movablecore=256M@0x70000000,1G@12G' you would still have the same
>> ZONE_MOVABLE span, and the ZONE_NORMAL span would go back to
>> 0x300000000-0x33fffffff. However, because the second DMB (1G@12G)
>> completely overlaps the ZONE_NORMAL there would be no pages present in
>> ZONE_NORMAL and /proc/zoneinfo would report ZONE_NORMAL 'spanned
>> 262144', but not where those pages are. This commit adds the 'start_pfn'
>> back to the /proc/zoneinfo for ZONE_NORMAL so the span has context.
> 
> ... but why? If there are no pages present, there is no ZONE_NORMAL we 
> care about. The zone span should be 0. Does this maybe rather indicate 
> that there is a zone span processing issue in your DMB implementation?
My implementation uses the zones created by the classic 'movablecore' 
behavior and relocates the pages within DMBs. In this case the 
ZONE_NORMAL still has a span which gets output but no present pages so 
the output didn't show where the zone was without this patch. This is a 
convenience to avoid adding zone resizing and destruction logic outside 
of memory hotplug support, but I could attempt to add that code in a v3 
if desired.

> 
> Special-casing zones based on DMBs feels wrong. But most probably I am 
> missing something important :)
> 

Thanks for making me aware of your confusion so I can attempt to make it 
clearer.
-Doug
