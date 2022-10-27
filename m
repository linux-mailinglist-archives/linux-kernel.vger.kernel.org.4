Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4827D60FA2E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 16:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbiJ0OL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 10:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbiJ0OLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 10:11:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB6041843E0;
        Thu, 27 Oct 2022 07:11:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D15E423A;
        Thu, 27 Oct 2022 07:11:57 -0700 (PDT)
Received: from [10.57.1.115] (unknown [10.57.1.115])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 310FC3F7B4;
        Thu, 27 Oct 2022 07:11:49 -0700 (PDT)
Message-ID: <8eb174c0-c785-c092-96f5-3a4fa3441287@arm.com>
Date:   Thu, 27 Oct 2022 15:11:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/1] perf arm64: Send pointer auth masks to ring buffer
From:   James Clark <james.clark@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, acme@kernel.org,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kristina.martsenko@arm.com
References: <20221020101921.1219533-1-james.clark@arm.com>
 <20221020101921.1219533-2-james.clark@arm.com>
 <Y1F8DUWaWhlh/phL@hirez.programming.kicks-ass.net>
 <4e50b890-0588-1551-fb7c-6cd8191d1054@arm.com>
Content-Language: en-US
In-Reply-To: <4e50b890-0588-1551-fb7c-6cd8191d1054@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/10/2022 16:28, James Clark wrote:
> 
> 
> On 20/10/2022 17:49, Peter Zijlstra wrote:
>> On Thu, Oct 20, 2022 at 11:19:20AM +0100, James Clark wrote:
>>> From: Andrew Kilroy <andrew.kilroy@arm.com>
>>>
>>> Perf report cannot produce callgraphs using dwarf on arm64 where pointer
>>> authentication is enabled.  This is because libunwind and libdw cannot
>>> unmangle instruction pointers that have a pointer authentication code
>>> (PAC) embedded in them.
>>>
>>> libunwind and libdw need to be given an instruction mask which they can
>>> use to arrive at the correct return address that does not contain the
>>> PAC.
>>>
>>> The bits in the return address that contain the PAC can differ by
>>> process, so this patch adds a new sample field PERF_SAMPLE_ARCH_1
>>> to allow the kernel to send the masks up to userspace perf.
>>>
>>> This field can be used in a architecture specific fashion, but on
>>> arm64, it contains the ptrauth mask information. The event will
>>> currently fail to open on architectures other than arm64 if
>>> PERF_SAMPLE_ARCH_1 is set. It will also fail to open on arm64 if
>>> CONFIG_ARM64_PTR_AUTH isn't set, as the data would always be zeros.
>>
>> A little more information please; wth is pointer authentication? Are we
> 
> Yes the commit message could do with some links and details. I
> will add more background about the feature if I resend it.
> 
> 
>> going to be having the same thing with x86 LAM where only a subset of
>> the available bits have meaning to the hardware?
> 
> If LAM is used with things like return addresses on the stack then yes.
> For data addresses then it wouldn't cause this exact issue.
> 
> The problem is that libunwind and perf do pointer arithmetic when
> unwinding with other values that don't have these bits set. For example
> computing offset in an mmap where the base address doesn't have an
> authentication code but a return value does results in an incorrect
> value. Like x-y=offset is only correct if the PAC bits are masked out first.
> 
>>
>> Why do we want the same mask repeated over and over with each sample;
>> should this not be part of the address space (side-band) data?
> 
> You are probably right that it could be done that way. The reason that
> we did it this way was to be consistent with ptrace feature [1] where it
> is delivered to userspace on a per-process basis. And there is also a
> prctl for the enabled key types [2] which can be changed dynamically.
> Particularly for the last reason is why it was done per sample.
> 
> Having said that, the enabled keys field is not used by perf, only the
> mask is used, so I can drop the per sample data until enabled keys is
> needed, which may be never.
> 
> I'm going to assume that perf shouldn't use ptrace because of
> permissions and conflicts with debuggers, so I could put the mask
> somewhere like PERF_RECORD_FORK instead of per sample.
> 

Hi Peter,

Sorry for flip flopping, but I've read those threads that I linked and
spoke with Kristina and we would like to stick with the per sample
implementation after all.

The reason is that in the future there may also be a prctrl for 48/52
bit userspace addressing which would change the mask dynamically in the
same way as the enabled keys. Although this isn't possible now it makes
sense to do it this way in case of that, and also for consistency with
the ptrace feature.

I also think that repeating the mask in this case has a very low impact
because if you are doing dwarf unwinding, then the whole stack is saved
anyway, so a few extra u64s wouldn't be noticeable.

Are you ok with that and for me to resubmit with the expanded commit
message?

Thanks
James

> 
> [1]:
> https://lore.kernel.org/all/20181207183931.4285-9-kristina.martsenko@arm.com/
> [2]:
> https://lore.kernel.org/all/d6609065f8f40397a4124654eb68c9f490b4d477.1616123271.git.pcc@google.com/
