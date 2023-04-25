Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1476EE4FB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 17:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbjDYPt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 11:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjDYPt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 11:49:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DB7E4499
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 08:49:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1A084B3;
        Tue, 25 Apr 2023 08:50:38 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D18613F587;
        Tue, 25 Apr 2023 08:49:53 -0700 (PDT)
Message-ID: <22e2728f-d51a-bf92-4791-a7df5c4a2c15@arm.com>
Date:   Tue, 25 Apr 2023 16:49:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] perf/arm-cmn: Fix DTC reset
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
To:     Geoff Blake <blakgeof@amazon.com>
Cc:     will@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ilkka@os.amperecomputing.com
References: <f0b61513276ee2c448ae02a6840135571039cea7.1680792373.git.robin.murphy@arm.com>
 <b2488619-a306-981c-1172-7efce749c10e@amazon.com>
 <5ea7ec4e-bf9b-f3a7-965c-fa85b640d00f@arm.com>
In-Reply-To: <5ea7ec4e-bf9b-f3a7-965c-fa85b640d00f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 3:19 pm, Robin Murphy wrote:
> On 2023-04-06 22:25, Geoff Blake wrote:
>> Ran this patch on an AWS C6g.metal and unfortunately still see the
>> spurious IRQs trigger quickly (within 10 tries) when using the following
>> flow:
>>
>> perf stat -a -e arm_cmn_0/event=0x5,type=0x5/ -- sleep 600
>> kexec -e
>>
>> Adding in the simple shutdown routine, I have run over 100 of the
>> above cycles and the spurious IRQs haven't triggered.  I think we still
>> need both for now.
> 
> There is no "need both" - if this patch doesn't work to reset the PMU as 
> intended then we still need a better patch that does. After yet more 
> trying, I still cannot reproduce your results, but I do suspect this 
> patch isn't as good as it initially seemed.
> 
> I got my hands on a C6g.metal instance, and I'm building the mainline 
> version of arm-cmn.c from my cmn-dev branch (including the two other 
> pending fixes that I've sent recently) against the 5.15.0-1031-aws 
> kernel that it came with, as a standalone module with a trivial 
> makefile. Even running "stress -m 60" in the background, as the most 
> effective thing I've found so far, that hnf_pocq_reqs_recvd event takes 
> well over 8 minutes to overflow, so I have failed to achieve the 
> necessary timing to kexec at just the right point for the residual 
> interconnect traffic to add up and overflow the event during the handful 
> of seconds that the kexec takes. For completeness, I have managed to run 
> the perf stat/kexec, then run stress for 10 minutes under the new 
> kernel, *then* finally load the module to achieve the right conditions, 
> but that's so utterly contrived and long-winded that I don't really have 
> the patience to do it more than the twice that I already did.
> 
> What I can do instantly and reliably is reproduce equivalent conditions 
> with my (now even more stripped-down) remove hack[1] and a simple 
> rmmod/insmod (with a few seconds in between for good measure), leading 
> to demonstrable latent overflows on all 4 DTCs every time. The existing 
> code does seem to manage to reset DTC0 such that its interrupt (IRQ 27) 
> does not fire, consistent with what I've observed on other machines, 
> while I see the secondary DTCs (IRQs 28, 29 and 30) each fire 100000 
> times spuriously and get disabled. With this patch on top[2], that 
> consistently does not happen over 100 unload/reload cycles.
> 
> Given that you say the same write to clear DTC_CTL, but a few seconds 
> earlier in the form of the shutdown hook, does seem to work, I have 
> still been wary of some kind of weird timing issue all along, but the 
> fact that I was getting such consistent behaviour even on C6g seemed to 
> be pointing away from that :/
> 
> The closest I've got so far is by leaving this even more involved test 
> loop (with real PMU programming in between) running overnight:
> 
> for i in {1..10000}; do sudo insmod arm-cmn.ko && sudo perf stat -e 
> arm_cmn_0/eventid=5,type=5/ sleep 1 && sudo rmmod arm-cmn && sleep 4; done
> 
> and now coming back to find /proc/interrupts saying this:
> 
>   27:          1          0          0...
>   28:          1          0          0...
>   29:          2          0          0...
>   30:          1          0          0...
> 
> I've quite often seen a single IRQ firing earlier than expected (not 
> necessarily spuriously), so I still need to check what's up with that - 
> it may be that writing to the counters doesn't always take either. 
> However, the single extra incidence of IRQ 29 which has happened at some 
> point after I went home is more of a smoking gun:
> 
> [84581.790043] WARNING: CPU: 0 PID: 0 at /home/ubuntu/arm-cmn.c:1828 
> arm_cmn_handle_irq+0x148/0x1cc [arm_cmn]
> 
> So something still snuck through reset, but it *was* at least visible 
> and clearable by the time the IRQ was enabled. Interestingly the other 
> warning for !dtc->cycles did not fire at the same time, even though the 
> hack normally overflows PMCCNTR before PMEVCNTR(0). I'll keep digging...

I realise I neglected to follow up on this - where I got to was adding 
an extra read back of CMN_DTC_CTL after the write, tweaking my remove 
hack to generate overflows even more reliably for good measure, and that 
then ran for ~56,000 test cycles (until my time on the instance ran out) 
without any stray interrupts at all. However I wasn't keen on posting 
that as a v2 without any better justification than it being a "add 
random things to change the timing a bit" bodge. Since we're in the 
merge window now, I'll see if I can get a better answer by -rc1.

Thanks,
Robin.
