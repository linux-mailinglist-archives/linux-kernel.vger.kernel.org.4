Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181E56C4588
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjCVJCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjCVJCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:02:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5D953DB5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 02:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679475687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mFVpzwEJYt2no2NNxFKxaFJZexC0zVUmzATggS8rAKc=;
        b=JcROl8G8ZMS55dP4MAfQMgWL0Fwn3/k4zPJHqwJs16B2NwRZPRflyXEx6CQvv242NUf00A
        YfGyIkp6iwU2DdCldOrwVK2IR9wgw3t+zO1lhydk0WPCUayLPc1jI1r9asm7OxQmHR01sX
        G4lmORoE2F4/8KqtDNNm3LamuAFzdB4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-RmrEer-EPSmvpbsJ6mNzkA-1; Wed, 22 Mar 2023 05:01:19 -0400
X-MC-Unique: RmrEer-EPSmvpbsJ6mNzkA-1
Received: by mail-wm1-f69.google.com with SMTP id q21-20020a05600c46d500b003ee570749f7so730564wmo.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 02:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679475678;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFVpzwEJYt2no2NNxFKxaFJZexC0zVUmzATggS8rAKc=;
        b=vdP/st7Ejx+3hhW9l6BnVKe8djgND6eG5DaaqZ40Zq72STjRBmKkoB7nm5ZjdToQnm
         DklUoN1i+WeuSJf4T9sZrViVY/5wr+Br5JstKookk/pXnJ5sIP6v/udxN0W8QnpNeQCb
         fOl8O+7kg4WRbgjHXxMCaxqD1jRVl2IThfQZgfCnlujAUx4zxVpQpm3487GgbRY4BtbQ
         LY1VM5vLu9Q63lOA33X2V4TxCMnsfHrpLQtvt8OpxleT6O5vq+MLVGElCWJD49SQA1SH
         ZA2v4OOi0rGeEDhyJXDTTJVnSNhmSAW7ghOnE3ZD4tRJw0r6YuW0e1hgaMMJIS7vnYHK
         tPZg==
X-Gm-Message-State: AO0yUKXryAX8EcuRhVFkv4+IIUhaFXFo6b+pSK4q/8ptf21XdIjtoQ/i
        TFtPwwRnCU2ZQj7ow7sB6MTsM9afOwDeHwdPkobgqetxw8HPNrswuIkNAbZHY5rASTB2Nh/xnP8
        8Cv5XImCEIJf5Yt8l0y1Op5pi
X-Received: by 2002:a05:600c:2155:b0:3ed:93de:49ff with SMTP id v21-20020a05600c215500b003ed93de49ffmr4587066wml.0.1679475678539;
        Wed, 22 Mar 2023 02:01:18 -0700 (PDT)
X-Google-Smtp-Source: AK7set/8yN8AH64pyojIF3y/RKbehT7oWGYoqR9SMYxxN3EQ7/UjR+ICmjI1ZsqeI2QMDySSvO224Q==
X-Received: by 2002:a05:600c:2155:b0:3ed:93de:49ff with SMTP id v21-20020a05600c215500b003ed93de49ffmr4587041wml.0.1679475678153;
        Wed, 22 Mar 2023 02:01:18 -0700 (PDT)
Received: from [192.168.3.108] (p5b0c68dc.dip0.t-ipconnect.de. [91.12.104.220])
        by smtp.gmail.com with ESMTPSA id d17-20020a05600c34d100b003ee443bf0c7sm3505222wmq.16.2023.03.22.02.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 02:01:17 -0700 (PDT)
Message-ID: <9b531543-9f97-178f-8a97-494322410806@redhat.com>
Date:   Wed, 22 Mar 2023 10:01:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 1/4] mm/mlock: return EINVAL if len overflows for
 mlock/munlock
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     mawupeng <mawupeng1@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kuleshovmail@gmail.com, aneesh.kumar@linux.ibm.com
References: <20230320024739.224850-1-mawupeng1@huawei.com>
 <20230320024739.224850-2-mawupeng1@huawei.com>
 <27b9cb5b-0118-f989-80c2-6a143a4232af@redhat.com>
 <3ef9520c-6713-527a-0214-ac7a8bb2d49c@huawei.com>
 <6dd844f7-d43b-c744-f295-9f14c68d3928@redhat.com>
 <8be13253-b4ca-b134-3e85-b4097484bb29@huawei.com>
 <9583bc53-716d-f2ff-38e7-1dda7e57dd5d@redhat.com>
Organization: Red Hat
In-Reply-To: <9583bc53-716d-f2ff-38e7-1dda7e57dd5d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.03.23 09:54, David Hildenbrand wrote:
> On 22.03.23 03:14, mawupeng wrote:
>>
>>
>> On 2023/3/21 22:19, David Hildenbrand wrote:
>>> On 21.03.23 08:44, mawupeng wrote:
>>>>
>>>>
>>>> On 2023/3/20 18:54, David Hildenbrand wrote:
>>>>> On 20.03.23 03:47, Wupeng Ma wrote:
>>>>>> From: Ma Wupeng <mawupeng1@huawei.com>
>>>>>>
>>>>>> While testing mlock, we have a problem if the len of mlock is ULONG_MAX.
>>>>>> The return value of mlock is zero. But nothing will be locked since the
>>>>>> len in do_mlock overflows to zero due to the following code in mlock:
>>>>>>
>>>>>>       len = PAGE_ALIGN(len + (offset_in_page(start)));
>>>>>>
>>>>>> The same problem happens in munlock.
>>>>>>
>>>>>> Add new check and return -EINVAL to fix this overflowing scenarios since
>>>>>> they are absolutely wrong.
>>>>>
>>>>> Thinking again, wouldn't we reject mlock(0, ULONG_MAX) now as well?
>>>>
>>>> mlock will return 0 if len is zero which is the same w/o this patchset.
>>>> Here is the calltrace if len is zero.
>>>>
>>>> mlock(len == 0)
>>>>       do_mlock(len == 0)
>>>>           if (!len)
>>>>               return 0
>>>>
>>>
>>> I was asking about addr=0, len=ULONG_MAX.
>>>
>>> IIUC, that used to work but could now fail? I haven't played with it, though.
>>
>> Thanks for reviewing.
>>
>> Previous for add = 0 and len == ULONG_MAX, mlock will return ok(0) since len overflows to zero.
>> IFAICT, this is not right since mlock do noting(lock nothing) and return ok(0).
>>
>> With this patch, for the same situation, mlock can return EINVAL as expected.
> 
> Quoting the man page:
> 
> "EINVAL (mlock(),  mlock2(),  and  munlock()) The result of the addition
> addr+len was less than addr (e.g., the addition may have resulted in an
> overflow)."
> 
> ULONG_MAX+0 = ULONG_MAX
> 
> There is no overflow expected. The proper way to implement it would be
> to handle that case and not fail with EINVAL.
> 
> At least that would be expected when reading the man page.
> 

As a side note, I agree that failing with EINVAL is better than doing 
noting (mlocking nothing). But I am not sure what we are expected to do 
in that case ... the man page is a bit vague on that.

-- 
Thanks,

David / dhildenb

