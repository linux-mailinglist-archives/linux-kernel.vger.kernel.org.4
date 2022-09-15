Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071BF5B9287
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 04:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiIOCIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 22:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiIOCIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 22:08:46 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03CF8E9A3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 19:08:45 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VPqbprC_1663207718;
Received: from 30.240.121.31(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VPqbprC_1663207718)
          by smtp.aliyun-inc.com;
          Thu, 15 Sep 2022 10:08:43 +0800
Message-ID: <564a2ac1-9833-9073-b217-85efbdfc2dfb@linux.alibaba.com>
Date:   Thu, 15 Sep 2022 10:08:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH] mm,hwpoison: check mm when killing accessing process
Content-Language: en-US
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     linmiaohe@huawei.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cuibixuan@linux.alibaba.com, baolin.wang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
References: <20220915012626.GA1791458@hori.linux.bs1.fc.nec.co.jp>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20220915012626.GA1791458@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/9/15 AM9:48, Naoya Horiguchi 写道:
> On Wed, Sep 14, 2022 at 02:49:35PM +0800, Shuai Xue wrote:
>> The GHES code calls memory_failure_queue() from IRQ context to queue work
>> into workqueue and schedule it on the current CPU. Then the work is
>> processed in memory_failure_work_func() by kworker and calls
>> memory_failure().
>>
>> When a page is already poisoned, commit a3f5d80ea401 ("mm,hwpoison: send
>> SIGBUS with error virutal address") make memory_failure() call
>> kill_accessing_process() that:
>>
>>     - holds mmap locking of current->mm
>>     - does pagetable walk to find the error virtual address
>>     - and sends SIGBUS to the current process with error info.
>>
>> However, the mm of kworker is not valid. Therefore, check mm when killing
>> accessing process.
>>
>> Fixes: a3f5d80ea401 ("mm,hwpoison: send SIGBUS with error virutal address")
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> 
> Thank you for the patch, the fix itself makes sense to me.
> I agree with this patch with applying comments from Andrew.
> 
> Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

Thank you for prompt review.

Cheers,
Shuai
