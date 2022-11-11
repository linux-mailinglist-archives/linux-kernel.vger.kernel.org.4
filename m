Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F5F6259E5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbiKKLyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbiKKLyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:54:47 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E9E965862
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 03:54:45 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 501C31FB;
        Fri, 11 Nov 2022 03:54:51 -0800 (PST)
Received: from [10.57.38.243] (unknown [10.57.38.243])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98E9C3F534;
        Fri, 11 Nov 2022 03:54:43 -0800 (PST)
Message-ID: <b077c98d-2749-3281-5f0b-e297025d38b5@arm.com>
Date:   Fri, 11 Nov 2022 11:54:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [GIT PULL] arm64 updates for 6.1-rc1
Content-Language: en-GB
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Amit Pundir <amit.pundir@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20221005144116.2256580-1-catalin.marinas@arm.com>
 <CAMi1Hd38YB2m_r=m0wuDz+wErii37fUq1BJnvN9=y6opDzo_Fw@mail.gmail.com>
 <Y0aq8y5mEZi14lJ/@arm.com>
 <CAMi1Hd3Y9AibeVnh9_KYJ2EXar7bBSypKm4Tixj47htM7ZOURw@mail.gmail.com>
 <CAMi1Hd1VBCFhf7+EXWHQWcGy4k=tcyLa7RGiFdprtRnegSG0Mw@mail.gmail.com>
 <Y24uvyDJU3CL1jOi@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Y24uvyDJU3CL1jOi@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-11 11:15, Catalin Marinas wrote:
> On Tue, Nov 08, 2022 at 10:58:16PM +0530, Amit Pundir wrote:
>> On Tue, 25 Oct 2022 at 18:08, Amit Pundir <amit.pundir@linaro.org> wrote:
>>> On Wed, 12 Oct 2022 at 17:24, Catalin Marinas <catalin.marinas@arm.com> wrote:
>>>> On Sat, Oct 08, 2022 at 08:28:26PM +0530, Amit Pundir wrote:
>>>>> On Wed, 5 Oct 2022 at 20:11, Catalin Marinas <catalin.marinas@arm.com> wrote:
>>>>>> Will Deacon (2):
>>>>>>        arm64: dma: Drop cache invalidation from arch_dma_prep_coherent()
>>>>>
>>>>> This patch broke AOSP on Dragonboard 845c (SDM845). I don't see any
>>>>> relevant crash in the attached log and device silently reboots into
>>>>> USB crash dump mode. The crash is fairly reproducible on db845c. I
>>>>> could trigger it twice in 5 reboots and it always crash at the same
>>>>> point during the boot process. Reverting this patch fixes the crash.
>>>>>
>>>>> I'm happy to test run any debug patche(s), that would help narrow
>>>>> down this breakage.
> [...]
>>> Further narrowed down the breakage to the userspace daemon rmtfs
>>> https://github.com/andersson/rmtfs. Is there anything specific in the
>>> userspace code that I should be paying attention to?

FWIW, this scenario appears to have pretty much everything going on - 
buffers allocated from no-map carveouts, being shared with firmware as 
well as DMA devices, being poked by userspace through /dev/mem, and 
presumably with the funky Qualcomm sort-of-coherent outer cache in the 
mix too (where IIRC the outer non-cacheable attribute behaves 
differently for CPUs vs. DMA). If anything's ever going to go awry with 
mismatched attributes and stale cachelines, it's probably in that setup 
somewhere.

> Since you don't see anything in the logs like a crash and the system
> restarts, I suspect it's some deadlock and that's triggering the
> watchdog. We have an erratum (826319) but that's for Cortex-A53. IIUC
> SDM845 has Kryo 3xx series which based on some random google searches is
> derived from A75/A55. Unfortunately the MIDR_EL1 register doesn't match
> the Arm Ltd numbering, so I have no idea what CPUs these are by looking
> at the boot log.

Note that the EL2 firmware on these things tends to happily reset the 
system without warning if you so much as look at it funny, so I'd 
imagine a straightforward timeout or other unexpected condition due to 
coherency getting lost somewhere in the kernel/firmware/device handoff 
process is probably more than enough.

Robin.
