Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABED674CB79
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjGJFDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjGJFDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:03:05 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE0D120
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 22:03:02 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vmy4O50_1688965378;
Received: from 30.97.48.247(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vmy4O50_1688965378)
          by smtp.aliyun-inc.com;
          Mon, 10 Jul 2023 13:02:59 +0800
Message-ID: <1a107593-e411-70a0-b6b8-3c34a9036ff3@linux.alibaba.com>
Date:   Mon, 10 Jul 2023 13:02:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] erofs: fix two loop issues when read page beyond EOF
To:     Chunhai Guo <guochunhai@vivo.com>,
        "xiang@kernel.org" <xiang@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>
Cc:     "huyue2@coolpad.com" <huyue2@coolpad.com>,
        "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
        "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230708062432.67344-1-guochunhai@vivo.com>
 <97875049-8df9-e041-61ca-d90723ba6e82@linux.alibaba.com>
 <d6ee4571-64d6-ebd2-4adb-83f33e5e608d@vivo.com>
 <fd738d38-17de-4b61-e4e8-d4f98ef8d1db@linux.alibaba.com>
 <ac05d6e3-79b4-a470-2a30-8c809c277209@vivo.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ac05d6e3-79b4-a470-2a30-8c809c277209@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/10 12:35, Chunhai Guo wrote:
> 
> 
> On 2023/7/10 11:37, Gao Xiang wrote:
>>
>>
>> On 2023/7/10 11:32, Chunhai Guo wrote:
>>> Hi Xiang,
>>>
>>> On 2023/7/8 17:00, Gao Xiang wrote:
>>>> Hi Chunhai,
>>>>
>>>> On 2023/7/8 14:24, Chunhai Guo wrote:
>>>>> When z_erofs_read_folio() reads a page with an offset far beyond EOF, two
>>>>> issues may occur:
>>>>> - z_erofs_pcluster_readmore() may take a long time to loop when the offset
>>>>>      is big enough, which is unnecessary.
>>>>>        - For example, it will loop 4691368 times and take about 27 seconds
>>>>>          with following case.
>>>>>            - offset = 19217289215
>>>>>            - inode_size = 1442672
>>>>> - z_erofs_do_read_page() may loop infinitely due to the inappropriate
>>>>>      truncation in the below statement. Since the offset is 64 bits and
>>>>> min_t() truncates the result to 32 bits. The solution is to replace
>>>>> unsigned int with another 64-bit type, such as erofs_off_t.
>>>>>        cur = end - min_t(unsigned int, offset + end - map->m_la, end);
>>>>>        - For example:
>>>>>            - offset = 0x400160000
>>>>>            - end = 0x370
>>>>>            - map->m_la = 0x160370
>>>>>            - offset + end - map->m_la = 0x400000000
>>>>>            - offset + end - map->m_la = 0x00000000 (truncated as unsigned int)
>>>>
>>>> Thanks for the catch!
>>>>
>>>> Could you split these two into two patches?
>>>>
>>>> how about using:
>>>> cur = end - min_t(erofs_off_t, offend + end - map->m_la, end)
>>>> for this?
>>>>
>>>> since cur and end are all [0, PAGE_SIZE - 1] for now, and
>>>> folio_size() later.
>>>
>>> OK. I will split the patch.
>>>
>>> Sorry that I can not understand what is 'offend' refer to and what do you mean. Could you please describe it more clearly?
>>
>> Sorry, there is a typo here, I meant 'offset'.
>>
>> `cur` and `end` both are not exceed 4096 if your page_size
>> is 4096.
>>
>> Does
>> cur = end - min_t(erofs_off_t, offset + end - map->m_la, end)
>>
>> fix your issue?
> 
> Yes. I think this will fix this issue. Do you mean the below change is unncessary?
>  >>>> -    unsigned int cur, end, spiltted;
>  >>>> +    erofs_off_t cur, end;
>  >>>> +    unsigned int spiltted;

Yes, please help send a fix for this!

Thanks,
Gao Xiang

