Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D58670D0AF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 03:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjEWBxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 21:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjEWBxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 21:53:11 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBB7CA
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 18:53:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VjI-vRX_1684806786;
Received: from 30.97.48.222(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VjI-vRX_1684806786)
          by smtp.aliyun-inc.com;
          Tue, 23 May 2023 09:53:07 +0800
Message-ID: <3177581a-2252-04a0-1933-fc4cf100046d@linux.alibaba.com>
Date:   Tue, 23 May 2023 09:53:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] erofs: use HIPRI by default if per-cpu kthreads are
 enabled
To:     Yue Hu <zbestahu@gmail.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Sandeep Dhavale <dhavale@google.com>, huyue2@coolpad.com,
        zhangwen@coolpad.com
References: <20230522092141.124290-1-hsiangkao@linux.alibaba.com>
 <20230523085226.00006933.zbestahu@gmail.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230523085226.00006933.zbestahu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/23 17:52, Yue Hu wrote:
> On Mon, 22 May 2023 17:21:41 +0800
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 
>> As Sandeep shown [1], high priority RT per-cpu kthreads are
>> typically helpful for Android scenarios to minimize the scheduling
>> latencies.
>>
>> Switch EROFS_FS_PCPU_KTHREAD_HIPRI on by default if
>> EROFS_FS_PCPU_KTHREAD is on since it's the typical use cases for
>> EROFS_FS_PCPU_KTHREAD.
>>
>> Also clean up unneeded sched_set_normal().
>>
>> [1] https://lore.kernel.org/r/CAB=BE-SBtO6vcoyLNA9F-9VaN5R0t3o_Zn+FW8GbO6wyUqFneQ@mail.gmail.com
>> Cc: Sandeep Dhavale <dhavale@google.com>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>>   fs/erofs/Kconfig | 1 +
>>   fs/erofs/zdata.c | 2 --
>>   2 files changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
>> index 704fb59577e0..f259d92c9720 100644
>> --- a/fs/erofs/Kconfig
>> +++ b/fs/erofs/Kconfig
>> @@ -121,6 +121,7 @@ config EROFS_FS_PCPU_KTHREAD
>>   config EROFS_FS_PCPU_KTHREAD_HIPRI
>>   	bool "EROFS high priority per-CPU kthread workers"
>>   	depends on EROFS_FS_ZIP && EROFS_FS_PCPU_KTHREAD
>> +	default y
> 
> How about removing this config option?

I tend to leave it as is.

Thanks,
Gao Xiang
