Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D7160D08D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbiJYP2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbiJYP2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:28:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3566243328;
        Tue, 25 Oct 2022 08:28:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 307ADD6E;
        Tue, 25 Oct 2022 08:28:22 -0700 (PDT)
Received: from [10.57.1.104] (unknown [10.57.1.104])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C27A83F71A;
        Tue, 25 Oct 2022 08:28:13 -0700 (PDT)
Message-ID: <4e50b890-0588-1551-fb7c-6cd8191d1054@arm.com>
Date:   Tue, 25 Oct 2022 16:28:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
From:   James Clark <james.clark@arm.com>
Subject: Re: [PATCH v2 1/1] perf arm64: Send pointer auth masks to ring buffer
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
Content-Language: en-US
In-Reply-To: <Y1F8DUWaWhlh/phL@hirez.programming.kicks-ass.net>
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



On 20/10/2022 17:49, Peter Zijlstra wrote:
> On Thu, Oct 20, 2022 at 11:19:20AM +0100, James Clark wrote:
>> From: Andrew Kilroy <andrew.kilroy@arm.com>
>>
>> Perf report cannot produce callgraphs using dwarf on arm64 where pointer
>> authentication is enabled.  This is because libunwind and libdw cannot
>> unmangle instruction pointers that have a pointer authentication code
>> (PAC) embedded in them.
>>
>> libunwind and libdw need to be given an instruction mask which they can
>> use to arrive at the correct return address that does not contain the
>> PAC.
>>
>> The bits in the return address that contain the PAC can differ by
>> process, so this patch adds a new sample field PERF_SAMPLE_ARCH_1
>> to allow the kernel to send the masks up to userspace perf.
>>
>> This field can be used in a architecture specific fashion, but on
>> arm64, it contains the ptrauth mask information. The event will
>> currently fail to open on architectures other than arm64 if
>> PERF_SAMPLE_ARCH_1 is set. It will also fail to open on arm64 if
>> CONFIG_ARM64_PTR_AUTH isn't set, as the data would always be zeros.
> 
> A little more information please; wth is pointer authentication? Are we

Yes the commit message could do with some links and details. I
will add more background about the feature if I resend it.


> going to be having the same thing with x86 LAM where only a subset of
> the available bits have meaning to the hardware?

If LAM is used with things like return addresses on the stack then yes.
For data addresses then it wouldn't cause this exact issue.

The problem is that libunwind and perf do pointer arithmetic when
unwinding with other values that don't have these bits set. For example
computing offset in an mmap where the base address doesn't have an
authentication code but a return value does results in an incorrect
value. Like x-y=offset is only correct if the PAC bits are masked out first.

> 
> Why do we want the same mask repeated over and over with each sample;
> should this not be part of the address space (side-band) data?

You are probably right that it could be done that way. The reason that
we did it this way was to be consistent with ptrace feature [1] where it
is delivered to userspace on a per-process basis. And there is also a
prctl for the enabled key types [2] which can be changed dynamically.
Particularly for the last reason is why it was done per sample.

Having said that, the enabled keys field is not used by perf, only the
mask is used, so I can drop the per sample data until enabled keys is
needed, which may be never.

I'm going to assume that perf shouldn't use ptrace because of
permissions and conflicts with debuggers, so I could put the mask
somewhere like PERF_RECORD_FORK instead of per sample.


[1]:
https://lore.kernel.org/all/20181207183931.4285-9-kristina.martsenko@arm.com/
[2]:
https://lore.kernel.org/all/d6609065f8f40397a4124654eb68c9f490b4d477.1616123271.git.pcc@google.com/
