Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5686B6103
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 22:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjCKV0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 16:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCKV0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 16:26:43 -0500
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F36935ADFB;
        Sat, 11 Mar 2023 13:26:41 -0800 (PST)
Message-ID: <f00171a1-7f6f-d708-9587-4f176457fdfd@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1678569998;
        bh=U6lC5gOtxUA3/Ri+0eXIzfgp0Rj6K35nvwwsmlhPHcM=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To;
        b=qg30G2AVU2BxKEQaxUM871A4uwJJwHUXz6dyq5830uEx/YLVFOQ1EXsV3hH4Eur/J
         46blQWl7f/YJt/fUXpV35MDSLQkM2gZhSnyMfXCVfsrHV4BqbErf9SpMK+gzVD1n95
         a9pydU5tpDIDhVDKv0FFj/Ye4veoaYVwOZxr75tw=
Date:   Sat, 11 Mar 2023 22:26:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Alexander Wetzel <alexander@wetzel-home.de>
Subject: Re: [Regression] rt2800usb - Wifi performance issues and connection
 drops
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
 <b4427052-9e94-bce7-b745-2473be5686fa@wetzel-home.de>
Content-Language: en-US
In-Reply-To: <b4427052-9e94-bce7-b745-2473be5686fa@wetzel-home.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.03.23 23:13, Alexander Wetzel wrote:
> On 08.03.23 12:57, Felix Fietkau wrote:
>> On 08.03.23 12:41, Alexander Wetzel wrote:
>>> On 08.03.23 08:52, Felix Fietkau wrote:
>>>
>>>>> I'm also planning to provide some more debug patches, to figuring out
>>>>> which part of commit 4444bc2116ae ("wifi: mac80211: Proper mark iTXQs
>>>>> for resumption") fixes the issue for you. Assuming my understanding
>>>>> above is correct the patch should not really fix/break anything for
>>>>> you...With the findings above I would have expected your git bisec to
>>>>> identify commit a790cc3a4fad ("wifi: mac80211: add wake_tx_queue
>>>>> callback to drivers") as the first broken commit...
>>>> I can't point to any specific series of events where it would go 
>>>> wrong, but I suspect that the problem might be the fact that you're 
>>>> doing tx scheduling from within ieee80211_handle_wake_tx_queue. I 
>>>> don't see how it's properly protected from potentially being called 
>>>> on different CPUs concurrently.
>>>>
>>>> Back when I was debugging some iTXQ issues in mt76, I also had 
>>>> problems when tx scheduling could happen from multiple places. My 
>>>> solution was to have a single worker thread that handles tx, which 
>>>> is scheduled from the wake_tx_queue op.
>>>> Maybe you could do something similar in mac80211 for non-iTXQ drivers.
>>>>
>>>
>>> I think it's already doing all of that:
>>> ieee80211_handle_wake_tx_queue() is the mac80211 implementation for the
>>> wake_tx_queue op. The drivers without native iTXQ support simply link it
>>> to this handler.
>> I know. The problem I see is that I can't find anything that 
>> guarantees that .wake_tx_queue_op is not being called concurrently 
>> from multiple different places. ieee80211_handle_wake_tx_queue is 
>> doing the scheduling directly, instead of deferring it to a single 
>> workqueue/tasklet/thread, and multiple concurrent calls to it could 
>> potentially cause issues.
> 
> Good hint, thanks.
> According to the latest debug log exactly that seems to be happening:
> 
> ieee80211_wake_queue() is called by the driver and wake_txqs_tasklet 
> tasklet is started. But during execution of the drv_wake_tx_queue() from 
> the tasklet userspace queues a new skb and also calls into 
> drv_wake_tx_queue(), which is then run overlapping...
> 
> Not sure yet how that could cause the problem. But this breaks the 
> assumption that drv_wake_tx_queue() are not overlapping. And TX fails 
> directly after such an overlapping TX...
> 
> I'll probably just serialize the calls and then we verify if that helps...

Serialization helps. A (crude and in multiple ways incorrect) patch 
preventing two drv_wake_tx_queue() running for the same ac fixed the 
issue for Thomas:
https://bugzilla.kernel.org/show_bug.cgi?id=217119#c20

So it looks like we'll now have soon a fix for the issue.

The driver wakes the queue for IEEE80211_AC_BE often for only a single 
skb and then stops it again.
The short run time is insufficient for wake_txqs_tasklet to proper wake 
all queues itself and from time to time a new TX operation squeezes in 
after IEEE80211_AC_BE has been unblocked but prior of drv_wake_tx_queue 
being called from the wake_txqs_tasklet. When this happens 
drv_wake_tx_queue is called two times: Once from the tasklet, once from 
the userspace.

ieee80211_handle_wake_tx_queue is using ieee80211_txq_schedule_start, 
which has this documented requirement:
"The driver must not call multiple TXQ scheduling rounds concurrently."
Now I don't think that is causing the reported regression. Nevertheless 
we should prevent concurrent calls of ieee80211_handle_wake_tx_queue for 
that reason alone.

The real reason of the hangs is probably in the rt2800usb driver or 
hardware. I don't see anything in the driver code, so probably the HW 
itself has a problem with the two near-concurrent TX operations.

The real culprit of the regression should be commit a790cc3a4fad ("wifi: 
mac80211: add wake_tx_queue callback to drivers"), which switched 
rt2800usb over to iTXQs. But without the fix from commit 4444bc2116ae 
("wifi: mac80211: Proper mark iTXQs for resumption") mac80211 omitted to 
schedule the required run of the wake_txqs_tasklet. Thus thus instead of 
two concurrent drv_wake_tx_queue we only got one and the driver 
continued to work.

I asked Thomas on bugzilla to test the "best" solution I came up with.

There seems to be multiple ways. But I can't find a simple, low risk and 
complete fix. So I compromised...

When Thomas can confirm the fix we can soon discuss the fix on 
linux-wireless.


Alexander

