Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0993E6E257B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjDNOTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjDNOTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:19:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EAF73A24D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:19:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24D902F4;
        Fri, 14 Apr 2023 07:20:23 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D40FE3F6C4;
        Fri, 14 Apr 2023 07:19:37 -0700 (PDT)
Message-ID: <5ea7ec4e-bf9b-f3a7-965c-fa85b640d00f@arm.com>
Date:   Fri, 14 Apr 2023 15:19:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] perf/arm-cmn: Fix DTC reset
To:     Geoff Blake <blakgeof@amazon.com>
Cc:     will@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ilkka@os.amperecomputing.com
References: <f0b61513276ee2c448ae02a6840135571039cea7.1680792373.git.robin.murphy@arm.com>
 <b2488619-a306-981c-1172-7efce749c10e@amazon.com>
Content-Language: en-GB
In-Reply-To: <b2488619-a306-981c-1172-7efce749c10e@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-06 22:25, Geoff Blake wrote:
> Ran this patch on an AWS C6g.metal and unfortunately still see the
> spurious IRQs trigger quickly (within 10 tries) when using the following
> flow:
> 
> perf stat -a -e arm_cmn_0/event=0x5,type=0x5/ -- sleep 600
> kexec -e
> 
> Adding in the simple shutdown routine, I have run over 100 of the
> above cycles and the spurious IRQs haven't triggered.  I think we still
> need both for now.

There is no "need both" - if this patch doesn't work to reset the PMU as 
intended then we still need a better patch that does. After yet more 
trying, I still cannot reproduce your results, but I do suspect this 
patch isn't as good as it initially seemed.

I got my hands on a C6g.metal instance, and I'm building the mainline 
version of arm-cmn.c from my cmn-dev branch (including the two other 
pending fixes that I've sent recently) against the 5.15.0-1031-aws 
kernel that it came with, as a standalone module with a trivial 
makefile. Even running "stress -m 60" in the background, as the most 
effective thing I've found so far, that hnf_pocq_reqs_recvd event takes 
well over 8 minutes to overflow, so I have failed to achieve the 
necessary timing to kexec at just the right point for the residual 
interconnect traffic to add up and overflow the event during the handful 
of seconds that the kexec takes. For completeness, I have managed to run 
the perf stat/kexec, then run stress for 10 minutes under the new 
kernel, *then* finally load the module to achieve the right conditions, 
but that's so utterly contrived and long-winded that I don't really have 
the patience to do it more than the twice that I already did.

What I can do instantly and reliably is reproduce equivalent conditions 
with my (now even more stripped-down) remove hack[1] and a simple 
rmmod/insmod (with a few seconds in between for good measure), leading 
to demonstrable latent overflows on all 4 DTCs every time. The existing 
code does seem to manage to reset DTC0 such that its interrupt (IRQ 27) 
does not fire, consistent with what I've observed on other machines, 
while I see the secondary DTCs (IRQs 28, 29 and 30) each fire 100000 
times spuriously and get disabled. With this patch on top[2], that 
consistently does not happen over 100 unload/reload cycles.

Given that you say the same write to clear DTC_CTL, but a few seconds 
earlier in the form of the shutdown hook, does seem to work, I have 
still been wary of some kind of weird timing issue all along, but the 
fact that I was getting such consistent behaviour even on C6g seemed to 
be pointing away from that :/

The closest I've got so far is by leaving this even more involved test 
loop (with real PMU programming in between) running overnight:

for i in {1..10000}; do sudo insmod arm-cmn.ko && sudo perf stat -e 
arm_cmn_0/eventid=5,type=5/ sleep 1 && sudo rmmod arm-cmn && sleep 4; done

and now coming back to find /proc/interrupts saying this:

  27:          1          0          0...
  28:          1          0          0...
  29:          2          0          0...
  30:          1          0          0...

I've quite often seen a single IRQ firing earlier than expected (not 
necessarily spuriously), so I still need to check what's up with that - 
it may be that writing to the counters doesn't always take either. 
However, the single extra incidence of IRQ 29 which has happened at some 
point after I went home is more of a smoking gun:

[84581.790043] WARNING: CPU: 0 PID: 0 at /home/ubuntu/arm-cmn.c:1828 
arm_cmn_handle_irq+0x148/0x1cc [arm_cmn]

So something still snuck through reset, but it *was* at least visible 
and clearable by the time the IRQ was enabled. Interestingly the other 
warning for !dtc->cycles did not fire at the same time, even though the 
hack normally overflows PMCCNTR before PMEVCNTR(0). I'll keep digging...

Thanks,
Robin.

[1] 
https://gitlab.arm.com/linux-arm/linux-rm/-/commit/d3bdc783411fd71d5948ce7c7e7fa6cc6b388b6c
[2] 
https://gitlab.arm.com/linux-arm/linux-rm/-/commit/c742e8be1a783430151828ed27287ad3d61ff9d1

> 
> -Geoff
> 
> On Thu, 6 Apr 2023, Robin Murphy wrote:
> 
>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>>
>>
>>
>> It turns out that my naive DTC reset logic fails to work as intended,
>> since clearing PMCR.PMU_EN appears to result in writes to PMOVSR_CLR
>> being ignored, while some hard-to-characterise combination of conditions
>> (differently between DTC0 and secondary DTCs) also appears to result in
>> PMOVSR reading as zero even when an overflow remains asserted. Thus
>> rather than resetting the PMU to a nice clean state, we can currently
>> end up with screaming spurious interrupts from secondary DTCs which we
>> can neither see nor clear. This behaviour is of course not documented.
>>
>> Resetting PMCR to disable the interrupt output but enable the PMU itself
>> seems to at least make the PMOVSR_CLR write work as expected on DTC0
>> (although it looks like writing to PMCR twice has actually been having
>> some hidden side-effect of clearing any pending overflows there).
>> Unfortunately this still does not seem to help secondary DTCs, but going
>> beyond PMU scope and additionally resetting DTC_CTL does seems to make
>> everything work out, and superficially looks sensible. Therefore pile
>> that onto the house of empirical cards too, until I can check with the
>> hardware team whether there's actually any proper recommended way of
>> recovering from an arbitrary PMU state after an oops/kexec/whatever.
>>
>> Fixes: 0ba64770a2f2 ("perf: Add Arm CMN-600 PMU driver")
>> Reported-by: Geoff Blake <blakgeof@amazon.com>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>> This supersedes the previous shutdown/IRQ patches, now that I've
>> finally managed to make *some* sense of what's really going on. If
>> anyone's interested, this is the contrivance I used for testing:
>>
>> https://gitlab.arm.com/linux-arm/linux-rm/-/commit/d8f1035c5bc510516d6e4f0b7bf0b875a749daf7
>> ---
>>   drivers/perf/arm-cmn.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
>> index 144cc08d9e04..81fe01171e33 100644
>> --- a/drivers/perf/arm-cmn.c
>> +++ b/drivers/perf/arm-cmn.c
>> @@ -1899,7 +1899,10 @@ static int arm_cmn_init_dtc(struct arm_cmn *cmn, struct arm_cmn_node *dn, int id
>>          if (dtc->irq < 0)
>>                  return dtc->irq;
>>
>> -       writel_relaxed(0, dtc->base + CMN_DT_PMCR);
>> +       if (idx == 0)
>> +               writel_relaxed(0, dtc->base + CMN_DT_DTC_CTL);
>> +
>> +       writel_relaxed(CMN_DT_PMCR_PMU_EN, dtc->base + CMN_DT_PMCR);
>>          writel_relaxed(0x1ff, dtc->base + CMN_DT_PMOVSR_CLR);
>>          writel_relaxed(CMN_DT_PMCR_OVFL_INTR_EN, dtc->base + CMN_DT_PMCR);
>>
>> --
>> 2.39.2.101.g768bb238c484.dirty
>>
>>
