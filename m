Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140636B0F23
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 17:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjCHQrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 11:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCHQq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 11:46:58 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EB165C129
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 08:46:56 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABEB81042;
        Wed,  8 Mar 2023 08:47:39 -0800 (PST)
Received: from [10.57.90.59] (unknown [10.57.90.59])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE1343F67D;
        Wed,  8 Mar 2023 08:46:54 -0800 (PST)
Message-ID: <b8c21aec-75d6-7b5b-4777-58838f8d8602@arm.com>
Date:   Wed, 8 Mar 2023 16:46:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix event queue overflow
 acknowledgment
Content-Language: en-GB
To:     Tomas Krcka <krckatom@amazon.de>
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev, joro@8bytes.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shameerali.kolothum.thodi@huawei.com, will@kernel.org
References: <8291b66d-b9b8-47c9-f5ed-a4e951c92154@arm.com>
 <20230308140204.83249-1-krckatom@amazon.de>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230308140204.83249-1-krckatom@amazon.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-08 14:02, Tomas Krcka wrote:
>>> When an overflow occurs in the event queue, the SMMU toggles overflow
>>> flag OVFLG in the PROD register.
>>> The evtq thread is supposed to acknowledge the overflow flag by toggling
>>> flag OVACKFLG in the CONS register, otherwise the overflow condition is
>>> still active (OVFLG != OVACKFLG).
>>>
>>> Currently the acknowledge register is toggled after clearing the event
>>> queue but is never propagated to the hardware. It would be done next
>>> time when executing evtq thread.
>>>
>>> The SMMU still adds elements to the queue when the overflow condition is
>>> active but any subsequent overflow information after clearing the event
>>> queue will be lost.
>>>
>>> This change keeps the SMMU in sync as it's expected by design.
>>
>> If I've understood correctly, the upshot of this is that if the queue
>> has overflowed once, become empty, then somehow goes from empty to full
>> before we manage to consume a single event, we won't print the "events
>> lost" message a second time.
>>
>> Have you seen this happen in practice? TBH if the event queue ever
>> overflows even once it's indicative that the system is hosed anyway, so
>> it's not clear to me that there's any great loss of value in sometimes
>> failing to repeat a warning for a chronic ongoing operational failure.
>>
> 
> Yes, I did see in practice. And it’s not just about loosing subsequence warning.
> The way how it’s done now keeps inconsistent CONS register value between SMMU and the kernel
> until any new event happens. The kernel doesn’t inform SMMU that we know about the overflow
> and consuming events as fast as we can.

Interesting - out of curiosity, is something blocking the IRQ thread 
from running in a timely manner, or are you just using a really tiny 
event queue?

Either way though, the point is that there is nothing to "inform" the 
SMMU about here. It will see that we're consuming events and making 
space in the queue, because we're still updating CONS.RD. All that an 
update of PROD.OVFLG serves to do is indicate to software that events 
have been discarded since the last time CONS.OVACKFLG was updated. It 
makes no difference to the SMMU if it continues to discard *more* events 
until software updates CONS.OVACKFLG again. It's entirely software's own 
decision how closely it wants to keep track of overflows.

Like I say it's not clear how much Linux really cares about that, given 
that all we do with the information is log a message to indicate that 
some more events have been lost since the last time we logged the same 
message. Furthermore, the only thing we'll do with the overwhelming 
majority of events themselves is also log messages. Thus realistically 
if we're suddenly faced with processing a full event queue out of 
nowhere, then many of the events which *were* delivered to the queue 
will also be "lost" thanks to rate-limiting.

FWIW I think it's still true that for our currently supported use-cases 
in Linux, *any* discardable event is a sign that something's gone wrong; 
a full queue of 32K events would already be a sign that something's gone 
*severely* wrong, so at that point knowing whether it was exactly 32K, 
or 32K + n for some indeterminate value of n, is unlikely to be 
significantly meaningful.

>> It could be argued that we have a subtle inconsistency between
>> arm_smmu_evtq_thread() and arm_smmu_priq_thread() here, but the fact is
>> that the Event queue and PRI queue *do* have different overflow
>> behaviours, so it could equally be argued that inconsistency in the code
>> helps reflect that. FWIW I can't say I have a strong preference either way.
> 
> For the argument that the code can reflect the difference.
> Then the comment 'Sync our overflow flag, as we believe we're up to speed’ is
> already misleading.

Yes, that is what I was alluding to. Sometimes if a comment doesn't 
clearly match the code it means the code is wrong. Sometimes it just 
means the comment is wrong.

I'm not saying this patch is the wrong answer, but as presented it 
hasn't managed to convince me that it's the right one either. Largely 
since I'm not 100% sure what the exact question is - even with this 
change we'd still have the same ABA problem whenever the queue overflows 
again *before* it's completely drained.

Thanks,
Robin.
