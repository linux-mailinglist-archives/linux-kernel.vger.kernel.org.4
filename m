Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7726B303F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 23:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjCIWNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 17:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCIWNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 17:13:30 -0500
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2351999C2F;
        Thu,  9 Mar 2023 14:13:27 -0800 (PST)
Message-ID: <b4427052-9e94-bce7-b745-2473be5686fa@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1678400003;
        bh=jek5obCUz0PG/txARSS67XWDgInyk7/o7PGoSvmWT+g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=YUx5bulNZ3tgiJCaK11hT9J4fERH379GAxhPy+Mi1YY2bDwSQo/5vFWkVOOox1PyC
         2HI1B3e8TJi12q0lqz1NasGzcD2tq5FM9z1GHpyaxEFCtHs4k04E97L8vPFX/vDW7Y
         BsjO6P5wXqWq2JxSK31gGZK0a7PfcYl2rSMlup9o=
Date:   Thu, 9 Mar 2023 23:13:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [Regression] rt2800usb - Wifi performance issues and connection
 drops
Content-Language: en-US
To:     Felix Fietkau <nbd@nbd.name>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Mann <rauchwolke@gmx.net>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Johannes Berg <johannes.berg@intel.com>
References: <b8efebc6-4399-d0b8-b2a0-66843314616b@leemhuis.info>
 <5a7cd098-1d83-6297-e802-ce998c8ec116@leemhuis.info>
 <6025e17e-4c29-6d36-6b9c-2fec543b21c4@wetzel-home.de>
 <debc7fe9-204d-63a7-aa61-91b20a46f385@wetzel-home.de>
 <4a02173f-3a60-0a7e-8962-3778e6c55bf3@nbd.name>
 <cfa5cc30-bf5a-bffd-4c2f-eec8a6522dd5@wetzel-home.de>
 <42185fa2-4191-fcf5-9c0f-fd7098bb856b@nbd.name>
From:   Alexander Wetzel <alexander@wetzel-home.de>
In-Reply-To: <42185fa2-4191-fcf5-9c0f-fd7098bb856b@nbd.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.03.23 12:57, Felix Fietkau wrote:
> On 08.03.23 12:41, Alexander Wetzel wrote:
>> On 08.03.23 08:52, Felix Fietkau wrote:
>>
>>>> I'm also planning to provide some more debug patches, to figuring out
>>>> which part of commit 4444bc2116ae ("wifi: mac80211: Proper mark iTXQs
>>>> for resumption") fixes the issue for you. Assuming my understanding
>>>> above is correct the patch should not really fix/break anything for
>>>> you...With the findings above I would have expected your git bisec to
>>>> identify commit a790cc3a4fad ("wifi: mac80211: add wake_tx_queue
>>>> callback to drivers") as the first broken commit...
>>> I can't point to any specific series of events where it would go 
>>> wrong, but I suspect that the problem might be the fact that you're 
>>> doing tx scheduling from within ieee80211_handle_wake_tx_queue. I 
>>> don't see how it's properly protected from potentially being called 
>>> on different CPUs concurrently.
>>>
>>> Back when I was debugging some iTXQ issues in mt76, I also had 
>>> problems when tx scheduling could happen from multiple places. My 
>>> solution was to have a single worker thread that handles tx, which is 
>>> scheduled from the wake_tx_queue op.
>>> Maybe you could do something similar in mac80211 for non-iTXQ drivers.
>>>
>>
>> I think it's already doing all of that:
>> ieee80211_handle_wake_tx_queue() is the mac80211 implementation for the
>> wake_tx_queue op. The drivers without native iTXQ support simply link it
>> to this handler.
> I know. The problem I see is that I can't find anything that guarantees 
> that .wake_tx_queue_op is not being called concurrently from multiple 
> different places. ieee80211_handle_wake_tx_queue is doing the scheduling 
> directly, instead of deferring it to a single workqueue/tasklet/thread, 
> and multiple concurrent calls to it could potentially cause issues.

Good hint, thanks.
According to the latest debug log exactly that seems to be happening:

ieee80211_wake_queue() is called by the driver and wake_txqs_tasklet 
tasklet is started. But during execution of the drv_wake_tx_queue() from 
the tasklet userspace queues a new skb and also calls into 
drv_wake_tx_queue(), which is then run overlapping...

Not sure yet how that could cause the problem. But this breaks the 
assumption that drv_wake_tx_queue() are not overlapping. And TX fails 
directly after such an overlapping TX...

I'll probably just serialize the calls and then we verify if that helps...

Alexander
