Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563896BA497
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 02:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjCOB1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 21:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjCOB1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 21:27:48 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801EC2DE45
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 18:27:45 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vdtx.Pd_1678843662;
Received: from 30.221.128.163(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vdtx.Pd_1678843662)
          by smtp.aliyun-inc.com;
          Wed, 15 Mar 2023 09:27:42 +0800
Message-ID: <4ed1ebe6-0579-1f1b-6dae-7fd04f40b3d1@linux.alibaba.com>
Date:   Wed, 15 Mar 2023 09:27:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] mm: compaction: fix the possible deadlock when
 isolating hugetlb pages
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        osalvador@suse.de, vbabka@suse.cz, william.lam@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1bc1c955b03603c4e14f56dfbbef9f637f18dbbd.1678703534.git.baolin.wang@linux.alibaba.com>
 <a24a86fbae09711e61dc4424aa7aebff718e9995.1678703534.git.baolin.wang@linux.alibaba.com>
 <20230313170838.GA3044@monkey>
 <db50d82c-07f1-6a87-6960-7810c54f8093@linux.alibaba.com>
 <20230314172725.GA4769@monkey>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230314172725.GA4769@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/15/2023 1:27 AM, Mike Kravetz wrote:
> On 03/14/23 12:11, Baolin Wang wrote:
>> On 3/14/2023 1:08 AM, Mike Kravetz wrote:
>>> On 03/13/23 18:37, Baolin Wang wrote:
>>>
>>> It would seem that the pfn of a hugetlb page would always be a multiple of
>>> COMPACT_CLUSTER_MAX so we would drop the lock.  However, I am not sure if
>>> that is ALWAYS true and would prefer something like the code you suggested.
>>
>> Well, this is not always true, suppose the CONT-PTE hugetlb on ARM arch,
>> which contains 16 contiguous normal pages.
>>
> 
> Right.  I keep forgetting about the CONT-* page sizes on arm :(
> 
> In any case, I think explicitly dropping the lock as you have done is a
> good idea.
> 
> Feel free to add,
> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Thanks for reviewing.
