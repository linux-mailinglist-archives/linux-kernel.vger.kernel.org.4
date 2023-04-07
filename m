Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0193F6DA91A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 08:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbjDGGvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 02:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbjDGGvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 02:51:23 -0400
Received: from out28-146.mail.aliyun.com (out28-146.mail.aliyun.com [115.124.28.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E988A72BC
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 23:51:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1331011|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.187664-0.105877-0.706459;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=victor@allwinnertech.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.S9Rb6Vf_1680850272;
Received: from 192.168.220.144(mailfrom:victor@allwinnertech.com fp:SMTPD_---.S9Rb6Vf_1680850272)
          by smtp.aliyun-inc.com;
          Fri, 07 Apr 2023 14:51:13 +0800
Message-ID: <87857a82-99af-a941-9374-3bbe373ff74a@allwinnertech.com>
Date:   Fri, 7 Apr 2023 14:51:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] tick/broadcast: Do not set oneshot_mask except
 was_periodic was true
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        jindong.yue@nxp.com, linux-kernel@vger.kernel.org
References: <20230328063629.108510-1-victor@allwinnertech.com>
 <ZCqp02hiCell/5AR@lothringen>
 <b187d221-228a-f032-8c93-16e148ec49ca@allwinnertech.com>
 <ZCwWUyUkcC9PZlij@lothringen>
From:   Victor Hassan <victor@allwinnertech.com>
In-Reply-To: <ZCwWUyUkcC9PZlij@lothringen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/4/2023 8:21 PM, Frederic Weisbecker wrote:
> On Tue, Apr 04, 2023 at 07:37:06PM +0800, Victor Hassan wrote:
>>>
>>> Leading to such race:
>>>
>>> * CPU 1 stop its tick, next event is in one hour
>>> * CPU 0 registers new broadcast and sets CPU 1 in tick_broadcast_oneshot_mask
>>> * CPU 1 runs into cpuidle_enter_state(), and tick_broadcast_enter() is ignored because
>>>     the CPU is already in tick_broadcast_oneshot_mask
>>
>> Yes.
>>
>>> * CPU 1 goes to sleep
>>> * CPU 0 runs the broadcast callback, sees that the next timer for CPU 1
>>>     is in one hour, program the broadcast to that deadline
>>> * CPU 1 gets an interrupt that enqueues a new timer expiring in the next jiffy
>>> * CPU 1 don't call tick_broadcast_exit and thus don't remove itself from
>>>     tick_broadcast_oneshot_mask
>>
>> I'm not sure about this... Actually, I believe CPU 1 *will* call
>> tick_broadcast_exit in this condition because I cannot find a limitation on
>> this execution path.
> 
> You're right, what I wrote doesn't make sense. Let me try again:
> 
> * CPU 1 stop its tick, next event is in one hour. It calls
>    tick_broadcast_enter() and goes to sleep.
>    
> * CPU 1 gets an interrupt that enqueues a new timer expiring in the next jiffy
>    (note it's not yet actually programmed in the tick device)
>    
> * CPU 1 call tick_broadcast_exit().
> 
> * CPU 0 registers new broadcast device and sets CPU 1 in tick_broadcast_oneshot_mask
> 
> * CPU 0 runs the broadcast callback, sees that the next timer for CPU 1
>    is in one hour (because the recently enqueued timer for CPU 1 hasn't been programmed
>    yet), so it programs the broadcast to that 1 hour deadline.
> 
> * CPU 1 runs tick_nohz_idle_stop_tick() which eventually writes and program
>    dev->next_event to next jiffy
>    
> * CPU 1 runs into cpuidle_enter_state(), and tick_broadcast_enter() is ignored because
>    the CPU is already in tick_broadcast_oneshot_mask, so the dev->next_event
>    change isn't propagated to broadcast.
> 
> * CPU 1 goes to sleep for 1 hour.

Hi Frederic,
   Yes, I think that make sense :)


> 
> Does it make more sense? There might be more simple scenario of course.
> 
> Thanks.

