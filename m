Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C9F6EFEB7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 02:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242714AbjD0A6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 20:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242674AbjD0A6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 20:58:05 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339A93A92
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:58:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vh5A7WK_1682557079;
Received: from 30.97.48.53(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vh5A7WK_1682557079)
          by smtp.aliyun-inc.com;
          Thu, 27 Apr 2023 08:58:00 +0800
Message-ID: <40db45ab-774d-4a27-a604-a56c8447969b@linux.alibaba.com>
Date:   Thu, 27 Apr 2023 08:57:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] Revert "Revert "mm/compaction: fix set skip in
 fast_find_migrateblock""
To:     Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <3576e3520c044beb2a81860aecb2d4f597089300.1682521303.git.baolin.wang@linux.alibaba.com>
 <c48c4da5-9de5-f060-b6ad-5373ced87d0a@suse.cz>
 <20230426153331.dfqagb47i4xo3ouv@techsingularity.net>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230426153331.dfqagb47i4xo3ouv@techsingularity.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/26/2023 11:33 PM, Mel Gorman wrote:
> On Wed, Apr 26, 2023 at 05:10:14PM +0200, Vlastimil Babka wrote:
>> On 4/26/23 17:03, Baolin Wang wrote:
>>> This reverts commit 95e7a450b8190673675836bfef236262ceff084a.
>>>
>>> When I tested thpscale with v6.3 kernel, I found the compaction efficiency
>>> had a great regression compared to v6.2-rc1 kernel. See below numbers:
>>>                                      v6.2-rc             v6.3
>>> Percentage huge-3        81.35 (   0.00%)       32.97 ( -59.47%)
>>> Percentage huge-5        89.92 (   0.00%)       41.70 ( -53.63%)
>>> Percentage huge-7        92.41 (   0.00%)       34.08 ( -63.12%)
>>> Percentage huge-12       90.29 (   0.00%)       41.10 ( -54.49%)
>>> Percentage huge-18       82.38 (   0.00%)       41.24 ( -49.95%)
>>> Percentage huge-24       80.34 (   0.00%)       35.99 ( -55.20%)
>>> Percentage huge-30       88.90 (   0.00%)       44.20 ( -50.28%)
>>> Percentage huge-32       90.69 (   0.00%)       79.57 ( -12.25%)
>>>
>>> Ops Compaction stalls                 113790.00      207099.00
>>> Ops Compaction success                 33983.00      19488.00
>>> Ops Compaction failures                79807.00      187611.00
>>> Ops Compaction efficiency                 29.86          9.41
>>>
>>> After some investigation, I found the commit 95e7a450b819
>>> ("Revert mm/compaction: fix set skip in fast_find_migrateblock") caused
>>> the regression. This commit revert the commit 7efc3b726103 ("mm/compaction:
>>> fix set skip in fast_find_migrateblock") to fix a CPU stalling issue, which
>>> is caused by compaction stucked in repeating fast_find_migrateblock().
>>>
>>> And now the compaction stalling issue is addressed by commit cfccd2e63e7e
>>> ("mm, compaction: finish pageblocks on complete migration failure"). So
>>
>> IIRC at that time I was pointing out some scenarios that could make the
>> problem appear even after that commit, and we wanted to revisit that
>> when Mel is back.

Ah, I missed that, and will check previous discussion.

> Yes, I've prototyped the fix against 6.3-rc7 and the revert is at the
> end but the revert on its own has the potential for causing problems. The
> series needs to be rebased, retested and posted. What I last tested
> should show up shortly at
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git/ mm-follupfastmigrate-v1r1

Thanks.
