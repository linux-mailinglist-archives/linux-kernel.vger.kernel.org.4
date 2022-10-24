Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3785D609A2A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 08:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiJXGDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 02:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJXGDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 02:03:09 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36D152DD5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 23:03:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VStC9yI_1666591383;
Received: from 30.97.48.50(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VStC9yI_1666591383)
          by smtp.aliyun-inc.com;
          Mon, 24 Oct 2022 14:03:04 +0800
Message-ID: <ac39c3e6-8328-af47-c812-1632fddbbcfd@linux.alibaba.com>
Date:   Mon, 24 Oct 2022 14:03:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 1/2] mm: migrate: Fix return value if all subpages of
 THPs are migrated successfully
To:     "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     david@redhat.com, ziy@nvidia.com, apopple@nvidia.com,
        jingshan@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <fca6bb0bd48a0292a0ace2fadd0f44579a060cbb.1666335603.git.baolin.wang@linux.alibaba.com>
 <20221021114149.eadf6fafdd0b2c2409a46389@linux-foundation.org>
 <CAHbLzkpv3TkUag9+0mdBE5PbNuN4o3xbDT-Z4p-CjB6Fq775Hw@mail.gmail.com>
 <871qqym1bt.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <871qqym1bt.fsf@yhuang6-desk2.ccr.corp.intel.com>
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



On 10/24/2022 9:56 AM, Huang, Ying wrote:
> Yang Shi <shy828301@gmail.com> writes:
> 
>> On Fri, Oct 21, 2022 at 11:41 AM Andrew Morton
>> <akpm@linux-foundation.org> wrote:
>>>
>>> On Fri, 21 Oct 2022 18:16:23 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
>>>
>>>> When THP migration, if THPs are split and all subpages are migrated successfully
>>>> , the migrate_pages() will still return the number of THP that were not migrated.
>>>> That will confuse the callers of migrate_pages(), for example, which will make
>>>> the longterm pinning failed though all pages are migrated successfully.
>>>>
>>>> Thus we should return 0 to indicate all pages are migrated in this case.
>>>>
>>>
>>> This had me puzzled for a while.  I think this wording is clearer?
>>>
>>> : During THP migration, if THPs are not migrated but they are split and all
>>> : subpages are migrated successfully, migrate_pages() will still return the
>>> : number of THP pages that were not migrated.  This will confuse the callers
>>> : of migrate_pages().  For example, the longterm pinning will failed though
>>> : all pages are migrated successfully.
>>> :
>>> : Thus we should return 0 to indicate that all pages are migrated in this
>>> : case.
>>>
>>> This is a fairly longstanding problem?  No Fixes: we can identify?
>>
>> It doesn't seem like a long standing issue. It seems like commit
>> b5bade978e9b ("mm: migrate: fix the return value of migrate_pages()")
>> fixed one problem, but introduced this new one IIUC.
>>
>> Before this commit, the code did:
>>
>> nr_failed += retry + thp_retry;
>> rc = nr_failed;
>>
>> But retry and thp_retry were actually reset for each retry until the
>> last one. So as long as there is no permanent migration failure and
>> THP split failure, nr_failed should be 0 IIUC. TBH the code is a
>> little bit hard to follow, please correct me if I'm wrong.
> 
> I think that you are correct.  We can added
> 
> Fixes: b5bade978e9b ("mm: migrate: fix the return value of migrate_pages()")

I think so too. Thanks Yang and Ying for pointing it out.

> 
>>> Did you consider the desirability of a -stable backport?
> 
> I think this can be backport to -stable.

Agree.

Andrew, could you help to add the Fixes tag and cc -stable? Thanks.
