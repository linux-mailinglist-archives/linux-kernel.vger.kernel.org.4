Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773CC6F2E7D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 06:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjEAEmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 00:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbjEAEmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 00:42:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7B610C4
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 21:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=7BExZKPW0oNzIKDCDEfj/tcEXlczD4qYuB1duwQjZ9k=; b=AQX+1sqFmF0QB21wDuWQjP+GST
        FCcadbDxo6oIEO1Y5wVLBi5wxFb+GfnYNRZjgbUJTWf2t7+VMIky2DzvK3W4v4fdN/gFX+h2BdTCA
        YKA37RhX97vouJKAFbfPOt/Y5lGKAvhamsq/8hAtbT2ZGVedq70ivI244pSbngkDNgA2PC0HYPvPk
        2uKEJZ7NsMkYyfuwpt1yGwg1ewKXrs45BW/578Y/TfB+Gjgtrt7P6ZIT0JB8cIMUvpZO4IcDi0zlK
        YSIBJsR4SkZsx8at6hgEg+1bkll/iO45HLgDbDJtHTOlqYJE7XyUMAC3We5JtQXIBN+V890wix0YN
        s2/3/MXg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1ptLMT-00FFYk-17;
        Mon, 01 May 2023 04:42:05 +0000
Message-ID: <4143448b-fb4f-860d-da67-b864e5b33020@infradead.org>
Date:   Sun, 30 Apr 2023 21:42:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH] workqueue: fix cast warnings on i386
Content-Language: en-US
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
References: <20230429044506.24843-1-rdunlap@infradead.org>
 <CAJhGHyBjTykZ3d-D-M_1eD5J8QgNcPZcCsCMnqbBcvRoEceSuQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAJhGHyBjTykZ3d-D-M_1eD5J8QgNcPZcCsCMnqbBcvRoEceSuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lai,

On 4/30/23 21:37, Lai Jiangshan wrote:
> On Sat, Apr 29, 2023 at 12:45 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> Add casts to avoid int-to-pointer-cast warings on i386 or UML for i386:
>>
>> ../kernel/workqueue.c: In function ‘get_work_pwq’:
>> ../kernel/workqueue.c:713:24: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>>   713 |                 return (void *)(data & WORK_STRUCT_WQ_DATA_MASK);
>>       |                        ^
>> ../kernel/workqueue.c: In function ‘get_work_pool’:
>> ../kernel/workqueue.c:741:25: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>>   741 |                 return ((struct pool_workqueue *)
>>       |                         ^
>> ../kernel/workqueue.c: In function ‘get_work_pool_id’:
>> ../kernel/workqueue.c:763:25: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>>   763 |                 return ((struct pool_workqueue *)
>>       |                         ^
>>
> 
> Hello, Randy
> 
> Both the type of the "data" and WORK_STRUCT_WQ_DATA_MASK are
> "unsigned long", so I don't think "(data & WORK_STRUCT_WQ_DATA_MASK)"
> needs to be converted to "unsigned long".
> 
>         WORK_STRUCT_FLAG_MASK   = (1UL << WORK_STRUCT_FLAG_BITS) - 1,
>         WORK_STRUCT_WQ_DATA_MASK = ~WORK_STRUCT_FLAG_MASK,
> 
> This simple fix might hide the real problem.

Thanks for replying.

Do you have any suggestions for how to eliminate these warnings on i386
and ARCH=um SUBARCH=i386?

> Thanks
> Lai.
> 
>> Fixes: e120153ddf86 ("workqueue: fix how cpu number is stored in work->data")
>> Fixes: 112202d9098a ("workqueue: rename cpu_workqueue to pool_workqueue")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Tejun Heo <tj@kernel.org>
>> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
>> ---
>>  kernel/workqueue.c |    6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff -- a/kernel/workqueue.c b/kernel/workqueue.c
>> --- a/kernel/workqueue.c
>> +++ b/kernel/workqueue.c
>> @@ -710,7 +710,7 @@ static struct pool_workqueue *get_work_p
>>         unsigned long data = atomic_long_read(&work->data);
>>
>>         if (data & WORK_STRUCT_PWQ)
>> -               return (void *)(data & WORK_STRUCT_WQ_DATA_MASK);
>> +               return (void *)(unsigned long)(data & WORK_STRUCT_WQ_DATA_MASK);
>>         else
>>                 return NULL;
>>  }
>> @@ -739,7 +739,7 @@ static struct worker_pool *get_work_pool
>>
>>         if (data & WORK_STRUCT_PWQ)
>>                 return ((struct pool_workqueue *)
>> -                       (data & WORK_STRUCT_WQ_DATA_MASK))->pool;
>> +                       (unsigned long)(data & WORK_STRUCT_WQ_DATA_MASK))->pool;
>>
>>         pool_id = data >> WORK_OFFQ_POOL_SHIFT;
>>         if (pool_id == WORK_OFFQ_POOL_NONE)
>> @@ -761,7 +761,7 @@ static int get_work_pool_id(struct work_
>>
>>         if (data & WORK_STRUCT_PWQ)
>>                 return ((struct pool_workqueue *)
>> -                       (data & WORK_STRUCT_WQ_DATA_MASK))->pool->id;
>> +                       (unsigned long)(data & WORK_STRUCT_WQ_DATA_MASK))->pool->id;
>>
>>         return data >> WORK_OFFQ_POOL_SHIFT;
>>  }

-- 
~Randy
