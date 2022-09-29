Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACE35EF40C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 13:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbiI2LM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 07:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbiI2LMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:12:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605CB1296AA
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 04:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664449969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8n1tzf6l3ZAoFU3fQ1/TWRNrSqhpIqUhxfDxIN+Hz74=;
        b=BdkdRImd/HSKkYu0/ZJ1RMRWge3+hZlXxJxteKQbtqeJMRsXlI7xsj3lHLpSjpUrhKuDo/
        BVJ4ABeluTMtTDd3FfwVD6uqNrZzxAS0ZiGgAIRbOEzein0CIrWQatuFNDNq3ShB3vwMNJ
        jlDeWFeXVT6CO/Puh4sBOeDvwnYZ3LY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-54-5lWUtMxAOcSwijuQf-WGuA-1; Thu, 29 Sep 2022 07:12:47 -0400
X-MC-Unique: 5lWUtMxAOcSwijuQf-WGuA-1
Received: by mail-wr1-f70.google.com with SMTP id k6-20020adfc706000000b0022cc19d5dd2so389890wrg.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 04:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=8n1tzf6l3ZAoFU3fQ1/TWRNrSqhpIqUhxfDxIN+Hz74=;
        b=Dxkw7Sy4fI5T3JTQYFK5xkF9RRYJSyp5hUxgo9BYBfpmL85zz4QRHBr/zePd/aa3Yo
         6lcfGBe+COVhdFf69qzY3SBjYkxMYNUeeplHCPrLMKe2ckKcq7wIi6QOL9fQSTcIeLbU
         V7o+jPy1SnUgfnEecXKGvFE8wDoNlDWyXkZqv4zBclQ7XjBwjlHQepFKwkDhfTHhEyGF
         UmZgMJhBTLg6aopVXnZ3gp0Ai7VU8kBLyHqdbw5lKDBsupCOicBF+soUYbEWjbUSOLFH
         YUtdzMxH3yBxALhS9R8V2nyTFm8uaGkYGujY84SnnSoS1csT7crLefaGtV7xC+HVijtm
         kOjg==
X-Gm-Message-State: ACrzQf3nbb3Pm3EQa8qzwH5ccodpCLsM4TIgbZnd5BMTcBpgWwdrcMzy
        +BSFYUHLv0kmPLQAsqrLOBT11ZUrpD4EbOfXVCzWqkD+WquQDyalsg/pNvS07x9vU4xDVzCl7K1
        nEQfQoMGoaXKHr2WHRh/dqj3Q
X-Received: by 2002:a05:600c:524d:b0:3b4:91ee:933e with SMTP id fc13-20020a05600c524d00b003b491ee933emr1950010wmb.80.1664449966525;
        Thu, 29 Sep 2022 04:12:46 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM63urpPF0tMcfh0uoQnrtkfZy8NEBrgdlFDDyB16VVL5UtdAS8f9v9m0kQfC4/rjvgN3MujyQ==
X-Received: by 2002:a05:600c:524d:b0:3b4:91ee:933e with SMTP id fc13-20020a05600c524d00b003b491ee933emr1949988wmb.80.1664449966189;
        Thu, 29 Sep 2022 04:12:46 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:ce00:b5d:2b28:1eb5:9245? (p200300cbc705ce000b5d2b281eb59245.dip0.t-ipconnect.de. [2003:cb:c705:ce00:b5d:2b28:1eb5:9245])
        by smtp.gmail.com with ESMTPSA id y3-20020a5d4ac3000000b0022ac672654dsm6690558wrs.58.2022.09.29.04.12.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 04:12:45 -0700 (PDT)
Message-ID: <745f75a4-6a2a-630f-8228-0c5e081588e7@redhat.com>
Date:   Thu, 29 Sep 2022 13:12:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 0/3] ksm: fix incorrect count of merged pages when
 enabling use_zero_pages
Content-Language: en-US
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     xu.xin.sc@gmail.com, akpm@linux-foundation.org,
        imbrenda@linux.vnet.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xu xin <xu.xin16@zte.com.cn>
References: <20220929025206.280970-1-xu.xin16@zte.com.cn>
 <4a3daba6-18f9-d252-697c-197f65578c44@redhat.com>
 <20220929123630.0951b199@p-imbrenda>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220929123630.0951b199@p-imbrenda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.09.22 12:36, Claudio Imbrenda wrote:
> On Thu, 29 Sep 2022 11:21:44 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 29.09.22 04:52, xu.xin.sc@gmail.com wrote:
>>> From: xu xin <xu.xin16@zte.com.cn>
>>>
>>> Before enabling use_zero_pages by setting /sys/kernel/mm/ksm/
>>> use_zero_pages to 1, pages_sharing of KSM is basically accurate. But
>>> after enabling use_zero_pages, all empty pages that are merged with
>>> kernel zero page are not counted in pages_sharing or pages_shared.
>>> That is because the rmap_items of these ksm zero pages are not
>>> appended to The Stable Tree of KSM.
>>>
>>> We need to add the count of empty pages to let users know how many empty
>>> pages are merged with kernel zero page(s).
>>>
>>> Please see the subsequent patches for details.
>>
>> Just raising the topic here because it's related to the KSM usage of the
>> shared zero-page:
>>
>> MADV_UNMERGEABLE and other ways to trigger unsharing will *not* unshare
>> the shared zeropage as placed by KSM (which is against the
>> MADV_UNMERGEABLE documentation at least). It will only unshare actual
>> KSM pages. We might not want want to blindly unshare all shared
>> zeropages in applicable VMAs ... using a dedicated shared zero (KSM)
>> page -- instead of the generic zero page --  might be one way to handle
>> this cleaner.
> 
> I don't understand why do you need this.
> 
> first of all, one zero page would not be enough (depending on the
> architecture, e.g. on s390x you need many). the whole point of zero
> page merging is that one zero page is not enough.

I don't follow. Having multiple ones is a pure optimization on s390x (I 
recall something about cache coloring), no? So why should we blindly 
care in the special KSM use case here?

> 
> second, once a page is merged with a zero page, it's not really handled
> by KSM anymore. if you have a big allocation, of which you only touch a
> few pages, would the rest be considered "merged"? no, it's just zero
> pages, right?

If you haven't touched memory, there is nothing populated -- no shared 
zeropage.

We only populate shared zeropages in private anonymous mappings on read 
access without prior write.

> this is the same, except that we take present pages with zeroes in it
> and we discard them and map them to zero pages. it's kinda like if we
> had never touched them.

MADV_UNMERGEABLE

"Undo  the effect of an earlier MADV_MERGEABLE operation on the 
specified address range; KSM unmerges whatever pages it had merged in 
the address range specified  by  addr  and length."

Now please explain to me how not undoing a zeropage merging is correct 
according to this documentation.

-- 
Thanks,

David / dhildenb

