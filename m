Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AD16654BD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 07:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjAKGkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 01:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjAKGkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 01:40:01 -0500
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B15E099
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 22:39:59 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VZM3vru_1673419196;
Received: from 30.97.48.51(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VZM3vru_1673419196)
          by smtp.aliyun-inc.com;
          Wed, 11 Jan 2023 14:39:57 +0800
Message-ID: <3c7c722d-e8d0-f52b-e0ea-7994bd6b55bb@linux.alibaba.com>
Date:   Wed, 11 Jan 2023 14:40:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/5] mm: compaction: Remove redundant VM_BUG_ON() in
 compact_zone()
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1673342761.git.baolin.wang@linux.alibaba.com>
 <740a2396d9b98154dba76e326cba5e798b640ead.1673342761.git.baolin.wang@linux.alibaba.com>
 <Y71qNeLNeiBB5a/+@casper.infradead.org>
 <20230110152532.8b2d34bf04d7b8e9a4e39130@linux-foundation.org>
 <Y732taMH+r/QGcgD@casper.infradead.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <Y732taMH+r/QGcgD@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/11/2023 7:37 AM, Matthew Wilcox wrote:
> On Tue, Jan 10, 2023 at 03:25:32PM -0800, Andrew Morton wrote:
>> On Tue, 10 Jan 2023 13:37:57 +0000 Matthew Wilcox <willy@infradead.org> wrote:
>>
>>> On Tue, Jan 10, 2023 at 09:36:18PM +0800, Baolin Wang wrote:
>>>> The compaction_suitable() will never return values other than COMPACT_SUCCESS,
>>>> COMPACT_SKIPPED and COMPACT_CONTINUE, so after validation of COMPACT_SUCCESS
>>>> and COMPACT_SKIPPED, we will never hit other unexpected case. Thus remove
>>>> the redundant VM_BUG_ON() validation for the return values of compaction_suitable().
>>>
>>> I don't understand why we'd remove this check.
>>
>> Well, just from code inspection it serves no purpose.
>>
>> Such an assertion might be useful during early code development, but I
>> think we can consider compaction_suitable() to adequately debugged by
>> now?
> 
> What if compaction_suitable() is modified to return another value?

Then this will be an expected value which should be handled by caller, 
and IMO we can not make such assumption for future to keep this 
unhelpful check.
