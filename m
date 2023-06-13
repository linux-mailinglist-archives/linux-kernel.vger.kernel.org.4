Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F093C72DA07
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 08:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbjFMGmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 02:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjFMGmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 02:42:22 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259AEE6B;
        Mon, 12 Jun 2023 23:42:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0Vl1.3ud_1686638534;
Received: from 30.240.112.107(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vl1.3ud_1686638534)
          by smtp.aliyun-inc.com;
          Tue, 13 Jun 2023 14:42:15 +0800
Message-ID: <ca66ecce-b8eb-ad22-2b25-bad8552ea5a4@linux.alibaba.com>
Date:   Tue, 13 Jun 2023 14:42:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.1
Subject: Re: [PATCH 2/2] perf/ring_buffer: Fix high-order allocations for AUX
 space with correct MAX_ORDER limit
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>, James Clark <james.clark@arm.com>
Cc:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        kirill@shutemov.name, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, jolsa@kernel.org, namhyung@kernel.org,
        irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
References: <20230612052452.53425-1-xueshuai@linux.alibaba.com>
 <20230612052452.53425-3-xueshuai@linux.alibaba.com>
 <751cb217-4be0-ddfc-780b-87517a8e337a@arm.com>
 <20230612090937.GD217089@leoy-huanghe.lan>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20230612090937.GD217089@leoy-huanghe.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/12 17:09, Leo Yan wrote:
> On Mon, Jun 12, 2023 at 09:45:38AM +0100, James Clark wrote:
> 
> [...]
> 
>>> @@ -609,8 +609,8 @@ static struct page *rb_alloc_aux_page(int node, int order)
>>>  {
>>>  	struct page *page;
>>>  
>>> -	if (order > MAX_ORDER)
>>> -		order = MAX_ORDER;
>>> +	if (order >= MAX_ORDER)
>>> +		order = MAX_ORDER - 1;
>>>  
>>>  	do {
>>>  		page = alloc_pages_node(node, PERF_AUX_GFP, order);
>>
>>
>> It seems like this was only just recently changed with this as the
>> commit message (23baf83):
>>
>>    mm, treewide: redefine MAX_ORDER sanely
>>
>>   MAX_ORDER currently defined as number of orders page allocator
>>   supports: user can ask buddy allocator for page order between 0 and
>>   MAX_ORDER-1.
>>
>>   This definition is counter-intuitive and lead to number of bugs all
>>   over the kernel.
>>
>>   Change the definition of MAX_ORDER to be inclusive: the range of
>>   orders user can ask from buddy allocator is 0..MAX_ORDER now.
>>
>> It might be worth referring to this in the commit message or adding a
>> fixes: reference. Or maybe this new change isn't quite right?
> 
> Good point.  If so, we don't need this patch anymore.
> 
> Thanks for reminding, James.
> 
> Leo

Hi, Leo and James,

I tested on the Linus master tree, the mentioned commit 23baf83 ("mm, treewide: redefine MAX_ORDER sanely")
has fix this oops.

I will drop out this patch, thank you :)

Cheers,
Shuai
