Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E55A6D9FB4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 20:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239399AbjDFSXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 14:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjDFSXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 14:23:35 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D182959F9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 11:23:33 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id bi31so29690837oib.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 11:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680805413; x=1683397413;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=pighxnNX/pMr8ZJCiJ5Ab8VkADN3PXqDCYexnTC1HBY=;
        b=KzwA5MOSWigBpiX5qN7AVADQyzSShWXSvMzfkugV2wpO4KhIwWNcwSyAAlt9KjIPJA
         PMVqTIuZ49R6FpqY6q8VfI0L/2XwPFJB2DOFM9ru0JOocwZ+RcO1lsArgpgdOmvbZd6B
         e4krku/rrHgx+FwRdxEnqpXufcXWiifx1bG5qE2RMRGKOGR83NXtvR98SUbohrcavv0f
         EmX86JXWV4i3DVDD+539SvICvp1iz2EATHLfsRSVuY3RDuOazQfAj1hOIfsMQzhSp3EV
         UCsMqIfhrfU19zacTsqIvgCzLDJOdmwaE2KNP4qD9/8opQAOYBact/OnUHtG5xwaQ5ol
         VQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680805413; x=1683397413;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pighxnNX/pMr8ZJCiJ5Ab8VkADN3PXqDCYexnTC1HBY=;
        b=iJBYKDQXn3UZUg6F4Tw91aMcIDjkPvurTAf++XYcsVTTn2vp+qXwIuzJqFltISc+2i
         Dl7e+oyaOFx8jipnFyZRNNyrqhdN9ZUEGm1bKiUI0Ey3jdVcu/Pe1rxqlAwciBz4Tp8a
         ISYKRTifb8j3/dpkfNqTFrQgUMlypVURZp8aWdY+I7QCHL7w4DkIx0N64Cya7U5LIN3G
         jx/sfDnmxaVyg6BJ0w1nVingGHNNRI9SVv5nzsTHUNCZb201fKVfJSVRu1OveK+O29cK
         m+6HABGg2LWaDKUPLCHFNctYdAKKhqEjBxxcLrfy3cqZL/1HEZfqq1vR9d25g4CpzVpV
         UDhA==
X-Gm-Message-State: AAQBX9fWTNJ6Wo3CC2f5GqPWLnhrgS5lC0xZAW0wHO6SdBo9lr3bp21B
        6aXXohU68zDPmhi9l8iV3EHtJydbgRQ=
X-Google-Smtp-Source: AKy350bC2J/KFajezUAsS5F6dp3T13DRhm78UZwA4zRmhcplWGX6uFAK1u8kN3TOj65gpxx9fON2dg==
X-Received: by 2002:a05:6808:1396:b0:386:c879:d3ae with SMTP id c22-20020a056808139600b00386c879d3aemr4743399oiw.10.1680805413044;
        Thu, 06 Apr 2023 11:23:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a6-20020a056808120600b003874631e249sm944134oil.36.2023.04.06.11.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 11:23:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1ed73bf7-809f-74e8-559d-e240a2a291c8@roeck-us.net>
Date:   Thu, 6 Apr 2023 11:23:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] mm-treewide-redefine-max_order-sanely-fix.txt
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <9460377a-38aa-4f39-ad57-fb73725f92db@roeck-us.net>
 <20230406072529.vupqyrzqnhyozeyh@box.shutemov.name>
 <83e6bc46-dfc0-0e95-e69c-5b996af1e50b@roeck-us.net>
 <20230406151015.yndcm24fyxitvqyc@box.shutemov.name>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230406151015.yndcm24fyxitvqyc@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/23 08:10, Kirill A. Shutemov wrote:
> On Thu, Apr 06, 2023 at 06:57:41AM -0700, Guenter Roeck wrote:
>> On 4/6/23 00:25, Kirill A. Shutemov wrote:
>>> On Wed, Apr 05, 2023 at 10:20:26PM -0700, Guenter Roeck wrote:
>>>> Hi,
>>>>
>>>> On Wed, Mar 15, 2023 at 06:38:00PM +0300, Kirill A. Shutemov wrote:
>>>>> fix min() warning
>>>>>
>>>>> Link: https://lkml.kernel.org/r/20230315153800.32wib3n5rickolvh@box
>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>>     Link: https://lore.kernel.org/oe-kbuild-all/202303152343.D93IbJmn-lkp@intel.com/
>>>>> Signed-off-by: "Kirill A. Shutemov" <kirill@shutemov.name>
>>>>> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>>>> Cc: Zi Yan <ziy@nvidia.com>
>>>>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>>>
>>>> This patch results in various boot failures (hang) on arm targets
>>>> in linux-next. Debug messages reveal the reason.
>>>>
>>>> ########### MAX_ORDER=10 start=0 __ffs(start)=-1 min()=10 min_t=-1
>>>>                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>
>>>> If start==0, __ffs(start) returns 0xfffffff or (as int) -1, which min_t()
>>>> interprets as such, while min() apparently uses the returned unsigned long
>>>> value. Obviously a negative order isn't received well by the rest of the
>>>> code.
>>>
>>> Actually, __ffs() is not defined for 0.
>>>
>>> Maybe something like this?
>>>
>>> diff --git a/mm/memblock.c b/mm/memblock.c
>>> index 7911224b1ed3..63603b943bd0 100644
>>> --- a/mm/memblock.c
>>> +++ b/mm/memblock.c
>>> @@ -2043,7 +2043,11 @@ static void __init __free_pages_memory(unsigned long start, unsigned long end)
>>>    	int order;
>>>    	while (start < end) {
>>> -		order = min_t(int, MAX_ORDER, __ffs(start));
>>> +		/* __ffs() behaviour is undefined for 0 */
>>> +		if (start)
>>> +			order = min_t(int, MAX_ORDER, __ffs(start));
>>> +		else
>>> +			order = MAX_ORDER;
>>
>> Shouldn't that be
>> 		else
>> 			order = 0;
>> ?
> 
> +Mike.
> 
> No. start == 0 is MAX_ORDER-aligned. We want to free the pages in the
> largest chunks alignment allows.
> 

Ah, ok. Makes sense.

Thanks,
Guenter

