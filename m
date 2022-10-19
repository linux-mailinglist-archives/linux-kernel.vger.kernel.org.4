Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B361604938
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiJSO2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbiJSO1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:27:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C8D3B9B2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666188702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bNsmwdfusQykh4S+xlKrJJSlnfHZs+V8z/WwZn6gi74=;
        b=UFp7dQx/TAmdAXOohfFNwUbJhKA5nwOED4qoY9QzCHWsOJJJQOP/n71Ip4HNX/cPGfDtGd
        Q+2GBPcSZkUPd1sKE8+ztWXCmBngEaBRbu6kS/8UwPev0ZsZqL3MGZhH8l88RpQ/IJNRwy
        YBkh/9Sl5qm3tw6lJ9at6gN2JkodQ44=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-216-6tYJ9084NhuNIAnEJRuoMw-1; Wed, 19 Oct 2022 10:08:31 -0400
X-MC-Unique: 6tYJ9084NhuNIAnEJRuoMw-1
Received: by mail-wr1-f71.google.com with SMTP id g27-20020adfa49b000000b0022cd5476cc7so5640796wrb.17
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bNsmwdfusQykh4S+xlKrJJSlnfHZs+V8z/WwZn6gi74=;
        b=f4/IYMSqOZev4XRUOYkraoDDqsp0jf/TrdR+BOz//zhs3gPxNXPe4c9lIytbN54njJ
         eBbMUWmebZojspW5sXAFxL5xuhSS0R03LaSyAWBqHLByitv/NzSAm3LrWQ2L74GbtWoa
         1N22K3yI6uh6PQocSR0ejVzxvqat84YzuRBHw3Rjqf9GlB0a1Bd9Rhi0tmFhAw4DVXjn
         cFdzInB3oEuUbD1oy6QkLJtCBqjpagAaG1PLhs99gbB/LrMBlFVJwqdhgT15jrM8WVAd
         NqCUfboAu7bSRA6WK5z934/4GgiHzHUs0cc6HYzbh+9ApZdG4UA6E2Z/MzM5lAnD+4dI
         /szA==
X-Gm-Message-State: ACrzQf05t4vWrhDxkffeIWPkjVi3MaG2xItFTkHdOi79w4Yrs8K+PfAd
        sTO5Lq3qS2TUKnjNpVDK08tVQh9jhBv3gJ2R+uzN3TKVG64ItH/xxDUvAnJAV3dt1teWCSZ/koj
        JPxccL9mMCGZrZw9v+qwj3CCA
X-Received: by 2002:a05:600c:a08:b0:3bc:eb4c:b90 with SMTP id z8-20020a05600c0a0800b003bceb4c0b90mr5909826wmp.184.1666188510548;
        Wed, 19 Oct 2022 07:08:30 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6EwyJcYMSpjoODNKk5OHkTyIuDhpe47pK9XQN7+0LEtL4Gr7Lu8Tejd0RmwxqPO1rZdijHgw==
X-Received: by 2002:a05:600c:a08:b0:3bc:eb4c:b90 with SMTP id z8-20020a05600c0a0800b003bceb4c0b90mr5909802wmp.184.1666188510202;
        Wed, 19 Oct 2022 07:08:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:2c00:d4ac:d2c:4aee:dac1? (p200300cbc7072c00d4ac0d2c4aeedac1.dip0.t-ipconnect.de. [2003:cb:c707:2c00:d4ac:d2c:4aee:dac1])
        by smtp.gmail.com with ESMTPSA id 5-20020a05600c028500b003c64c186206sm33907wmk.16.2022.10.19.07.08.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 07:08:29 -0700 (PDT)
Message-ID: <e361b003-6437-079b-b42d-a29b72604354@redhat.com>
Date:   Wed, 19 Oct 2022 16:08:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] mm/mmap: Fix MAP_FIXED address return on VMA merge
Content-Language: en-US
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Liu Zixian <liuzixian4@huawei.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20221018191613.4133459-1-Liam.Howlett@oracle.com>
 <3da4244a-5a1b-cf34-bf5c-22c199b15cb6@redhat.com>
 <20221018202518.zrnoe6ho4lcfuptm@revolver>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221018202518.zrnoe6ho4lcfuptm@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>    mm/mmap.c | 15 +++++++--------
>>>    1 file changed, 7 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/mm/mmap.c b/mm/mmap.c
>>> index 42cd2c260898..22010e13f1a1 100644
>>> --- a/mm/mmap.c
>>> +++ b/mm/mmap.c
>>> @@ -2625,14 +2625,14 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>>>    		if (error)
>>>    			goto unmap_and_free_vma;
>>> -		/* Can addr have changed??
>>> -		 *
>>> -		 * Answer: Yes, several device drivers can do it in their
>>> -		 *         f_op->mmap method. -DaveM
>>> +		/*
>>> +		 * Expansion is handled above, merging is handled below.
>>> +		 * Drivers should not alter the address of the VMA.
>>>    		 */
>>> -		WARN_ON_ONCE(addr != vma->vm_start);
>>> -
>>> -		addr = vma->vm_start;
>>> +		if (WARN_ON((addr != vma->vm_start))) {
>>> +			error = -EINVAL;
>>> +			goto close_and_free_vma;
>>> +		}
>>
>> If this is something that user space can trigger, WARN_* is the wrong
>> choice. But what I understand from the comment change is that this must not
>> happen at that point unless there is a real issue.
> 
> The VMA start address could be changed in call_mmap() which is a driver
> call.  I guess someone could write a driver to mmap by a users action?
> I don't think it can be reached other ways.  In any case, I'm changing a
> WARN_ON_ONCE() to a WARN_ON() and undoing the badness instead of
> marching forwards.

WARN_ON_ONCE() can also be used in conditionals if that's what you were 
concerned about, but ...

> 
>>
>> Why not "if (WARN_ON_ONCE)" ?
> 
> I was thinking it was harder to ignore if it happen more frequently?
> There isn't a driver that does this now, but I'm not picky over which
> variant to call.

.. I think the assumption really is that we won't see (m)any these 
calls. And if we do, it's a bad bad driver. So WARN_ON() might be just fine.

If this would be easy to trigger by any user space, WARN* would have 
been the wrong choice, that's why I was asking.

-- 
Thanks,

David / dhildenb

