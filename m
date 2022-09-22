Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169E45E59B8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 05:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiIVDrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 23:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiIVDrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 23:47:47 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C027AB188
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 20:47:45 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VQQi8tk_1663818461;
Received: from 30.240.98.118(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VQQi8tk_1663818461)
          by smtp.aliyun-inc.com;
          Thu, 22 Sep 2022 11:47:42 +0800
Message-ID: <4117f7f5-8156-d8c7-9e48-55a1b632f83d@linux.alibaba.com>
Date:   Thu, 22 Sep 2022 11:47:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [RFC 0/6] migrate_pages(): batch TLB flushing
To:     Zi Yan <ziy@nvidia.com>, Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>
References: <20220921060616.73086-1-ying.huang@intel.com>
 <FE41BDA8-F7EC-4FBC-9647-A5A835CDECB0@nvidia.com>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <FE41BDA8-F7EC-4FBC-9647-A5A835CDECB0@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.6 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huang,

     This is an exciting change, but on ARM64 machine the TLB flushing 
are not through IPI, it depends on 'vale1is'

instruction，so I'm wondering if there's also a  benefit on arm64, and 
I'm going to test it on an ARM64 machine.


在 2022/9/21 下午11:47, Zi Yan 写道:
> On 21 Sep 2022, at 2:06, Huang Ying wrote:
>
>> From: "Huang, Ying" <ying.huang@intel.com>
>>
>> Now, migrate_pages() migrate pages one by one, like the fake code as
>> follows,
>>
>>    for each page
>>      unmap
>>      flush TLB
>>      copy
>>      restore map
>>
>> If multiple pages are passed to migrate_pages(), there are
>> opportunities to batch the TLB flushing and copying.  That is, we can
>> change the code to something as follows,
>>
>>    for each page
>>      unmap
>>    for each page
>>      flush TLB
>>    for each page
>>      copy
>>    for each page
>>      restore map
>>
>> The total number of TLB flushing IPI can be reduced considerably.  And
>> we may use some hardware accelerator such as DSA to accelerate the
>> page copying.
>>
>> So in this patch, we refactor the migrate_pages() implementation and
>> implement the TLB flushing batching.  Base on this, hardware
>> accelerated page copying can be implemented.
>>
>> If too many pages are passed to migrate_pages(), in the naive batched
>> implementation, we may unmap too many pages at the same time.  The
>> possibility for a task to wait for the migrated pages to be mapped
>> again increases.  So the latency may be hurt.  To deal with this
>> issue, the max number of pages be unmapped in batch is restricted to
>> no more than HPAGE_PMD_NR.  That is, the influence is at the same
>> level of THP migration.
>>
>> We use the following test to measure the performance impact of the
>> patchset,
>>
>> On a 2-socket Intel server,
>>
>>   - Run pmbench memory accessing benchmark
>>
>>   - Run `migratepages` to migrate pages of pmbench between node 0 and
>>     node 1 back and forth.
>>
>> With the patch, the TLB flushing IPI reduces 99.1% during the test and
>> the number of pages migrated successfully per second increases 291.7%.
> Thank you for the patchset. Batching page migration will definitely
> improve its throughput from my past experiments[1] and starting with
> TLB flushing is a good first step.
>
> BTW, what is the rationality behind the increased page migration
> success rate per second?
>
>> This patchset is based on v6.0-rc5 and the following patchset,
>>
>> [PATCH -V3 0/8] migrate_pages(): fix several bugs in error path
>> https://lore.kernel.org/lkml/20220817081408.513338-1-ying.huang@intel.com/
>>
>> The migrate_pages() related code is converting to folio now. So this
>> patchset cannot apply recent akpm/mm-unstable branch.  This patchset
>> is used to check the basic idea.  If it is OK, I will rebase the
>> patchset on top of folio changes.
>>
>> Best Regards,
>> Huang, Ying
>
> [1] https://lwn.net/Articles/784925/
>
> --
> Best Regards,
> Yan, Zi
