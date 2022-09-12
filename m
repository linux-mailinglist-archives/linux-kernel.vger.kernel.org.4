Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B48E5B555D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 09:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiILH34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 03:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiILH3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 03:29:52 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B491144F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 00:29:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=luoben@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VPQS590_1662967771;
Received: from B-530WMD6R-2112.local(mailfrom:luoben@linux.alibaba.com fp:SMTPD_---0VPQS590_1662967771)
          by smtp.aliyun-inc.com;
          Mon, 12 Sep 2022 15:29:44 +0800
Subject: Re: [PATCH] mm/slub: return 0 when object pointer is NULL
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1662962379-16174-1-git-send-email-luoben@linux.alibaba.com>
 <Yx7dKxwxlNmCr9Ai@hyeyoo>
From:   Ben Luo <luoben@linux.alibaba.com>
Message-ID: <133458f0-23c9-9421-abb8-a50d5551b524@linux.alibaba.com>
Date:   Mon, 12 Sep 2022 15:29:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Yx7dKxwxlNmCr9Ai@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Hyeonggon,

Thanks for replying :)

在 2022/9/12 15:18, Hyeonggon Yoo 写道:
> On Mon, Sep 12, 2022 at 01:59:39PM +0800, Ben Luo wrote:
>> NULL is definitly not a valid address
>>
>> Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
>> ---
>>   mm/slub.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 862dbd9..50fad18 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -674,7 +674,7 @@ static inline int check_valid_pointer(struct kmem_cache *s,
>>   	void *base;
>>   
>>   	if (!object)
>> -		return 1;
>> +		return 0;
>>   
>>   	base = slab_address(slab);
>>   	object = kasan_reset_tag(object);
>> -- 
>> 1.8.3.1
>>
> Hello Ben.
>
> The return value is used to check if the @object has valid pointer
> in @slab. (used for debugging) the return value is 0 if valid, 1 if invalid.
>
> It does not return a pointer. So changing it to 0 because 1 is invalid
> address does not make sense.

I know the meaning of this return value, but I think this function was 
expected by returning 0 if invalid ,1 if valid

Check this original code:

         if (object < base || object >= base + slab->objects * s->size ||
                 (object - base) % s->size) {
                 return 0;
         }

Object not in range of [base, base+length) is an invalid slab address, 
and it will return 0


--

Thanks,

Ben

>
