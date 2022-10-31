Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B3A61385D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 14:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiJaNtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 09:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbiJaNtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 09:49:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 177D4764E;
        Mon, 31 Oct 2022 06:49:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FE921FB;
        Mon, 31 Oct 2022 06:49:06 -0700 (PDT)
Received: from [10.57.3.132] (unknown [10.57.3.132])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0BDC3F5A1;
        Mon, 31 Oct 2022 06:48:57 -0700 (PDT)
Message-ID: <133c2f4b-1ca5-2d0c-f4f4-e01ff5e028c8@arm.com>
Date:   Mon, 31 Oct 2022 13:48:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/1] perf arm64: Send pointer auth masks to ring buffer
Content-Language: en-US
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
 <Y1q914IVy6XgE1xq@hirez.programming.kicks-ass.net>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <Y1q914IVy6XgE1xq@hirez.programming.kicks-ass.net>
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



On 27/10/2022 18:20, Peter Zijlstra wrote:
> On Tue, Oct 25, 2022 at 04:28:12PM +0100, James Clark wrote:
> 
>>> Why do we want the same mask repeated over and over with each sample;
>>> should this not be part of the address space (side-band) data?
>>
>> You are probably right that it could be done that way. The reason that
>> we did it this way was to be consistent with ptrace feature [1] where it
>> is delivered to userspace on a per-process basis. And there is also a
>> prctl for the enabled key types [2] which can be changed dynamically.
>> Particularly for the last reason is why it was done per sample.
>>
>> Having said that, the enabled keys field is not used by perf, only the
>> mask is used, so I can drop the per sample data until enabled keys is
>> needed, which may be never.
>>
>> I'm going to assume that perf shouldn't use ptrace because of
>> permissions and conflicts with debuggers, so I could put the mask
>> somewhere like PERF_RECORD_FORK instead of per sample.
> 
> Yeah, or create an new RECORD type which you can also send around at
> prctl() time.
> 
> The only thing that's needed on top of that is exposing the mask
> somewhere in /proc for existing tasks; which is what perf also uses to
> syntesize RECORD_MMAP events on startup etc..
> 

Hmm ok, in that case I can just add the /proc interface for now because
the mask won't change and we can add the new record type at the point
it's needed in the future.

Thanks for the feedback.
