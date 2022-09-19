Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0948B5BC9B7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 12:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiISKqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 06:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiISKpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 06:45:43 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6D16168;
        Mon, 19 Sep 2022 03:28:36 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663583314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HbKeZTfik2pMHV79p6gXSE8IXVFHdfJd0El4C7BHEQ8=;
        b=JbdRu245UdkmBLOGcN3/fNgHPJC5p/+OggoJGFmdGN8IiimLru+Hmkd4rPBj9IeD5Omhih
        cMyoIV3oysKNw+jABMyMeksiAfwPuCKlyzSajNjlyRTzTR4c+XQn78/5CwhTvchNS1RDEw
        XTGanU/cSkW0aT+dNKwoda7pELseY4c=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH v3 5/5] md/raid10: convert resync_lock to use seqlock
To:     Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org,
        logang@deltatee.com, pmenzel@molgen.mpg.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com,
        "yukuai3@huawei.com >> yukuai (C)" <yukuai3@huawei.com>
References: <20220916113428.774061-1-yukuai1@huaweicloud.com>
 <20220916113428.774061-6-yukuai1@huaweicloud.com>
 <e73dc8e8-09a3-ecc8-3199-ac87e8b9ee55@linux.dev>
 <a6364e1e-f661-9e32-9d49-5ec421d77025@huaweicloud.com>
Message-ID: <b87f4f81-2514-5731-46b0-511b02e3420d@linux.dev>
Date:   Mon, 19 Sep 2022 18:28:29 +0800
MIME-Version: 1.0
In-Reply-To: <a6364e1e-f661-9e32-9d49-5ec421d77025@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/19/22 9:08 AM, Yu Kuai wrote:
> Hi,
>
> 在 2022/09/18 19:36, Guoqing Jiang 写道:
>>
>>
>> On 9/16/22 7:34 PM, Yu Kuai wrote:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> Currently, wait_barrier() will hold 'resync_lock' to read 
>>> 'conf->barrier',
>>> and io can't be dispatched until 'barrier' is dropped.
>>>
>>> Since holding the 'barrier' is not common, convert 'resync_lock' to use
>>> seqlock so that holding lock can be avoided in fast path.
>>>
>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>> ---
>>>   drivers/md/raid10.c | 87 
>>> ++++++++++++++++++++++++++++++---------------
>>>   drivers/md/raid10.h |  2 +-
>>>   2 files changed, 59 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
>>> index 9a28abd19709..2daa7d57034c 100644
>>> --- a/drivers/md/raid10.c
>>> +++ b/drivers/md/raid10.c
>>> @@ -79,6 +79,21 @@ static void end_reshape(struct r10conf *conf);
>>>   #include "raid1-10.c"
>>> +#define NULL_CMD
>>> +#define cmd_before(conf, cmd) \
>>> +    do { \
>>> +        write_sequnlock_irq(&(conf)->resync_lock); \
>>> +        cmd; \
>>> +    } while (0)
>>> +#define cmd_after(conf) write_seqlock_irq(&(conf)->resync_lock)
>>
>> The two is not paired well given only cmd_before needs the 'cmd'.
>
> May be should I just remove cmd_after?

I'd remove it but just my personal flavor.

>>
>>> +
>>> +#define wait_event_barrier_cmd(conf, cond, cmd) \
>>> +    wait_event_cmd((conf)->wait_barrier, cond, cmd_before(conf, 
>>> cmd), \
>>> +               cmd_after(conf))
>>> +
>>> +#define wait_event_barrier(conf, cond) \
>>> +    wait_event_barrier_cmd(conf, cond, NULL_CMD)
>>
>> What is the issue without define NULL_CMD?
>>
>
> Checkpatch will complain this:
>
> ERROR: space prohibited before that close parenthesis ')'
> #38: FILE: drivers/md/raid10.c:94:
> +       wait_event_barrier_cmd(conf, cond, )
>
> total: 1 errors, 0 warnings, 169 lines checked

Hmm, freeze_array has a different usage for it, so two cmds before sleep
and one cmd after sleep, perhaps it is the best way for now.

Thanks,
Guoqing
