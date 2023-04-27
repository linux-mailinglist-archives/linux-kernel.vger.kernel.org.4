Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A95A6F0709
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243859AbjD0OMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243854AbjD0OMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:12:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB9042120
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 07:12:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A01F411FB;
        Thu, 27 Apr 2023 07:13:02 -0700 (PDT)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 786173F64C;
        Thu, 27 Apr 2023 07:12:11 -0700 (PDT)
Message-ID: <670081d0-b4fc-79c5-68f8-5b3c162b74b9@arm.com>
Date:   Thu, 27 Apr 2023 15:12:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 09/19] x86/resctrl: Queue mon_event_read() instead of
 sending an IPI
Content-Language: en-GB
To:     Peter Newman <peternewman@google.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>
References: <20230320172620.18254-1-james.morse@arm.com>
 <20230320172620.18254-10-james.morse@arm.com>
 <CALPaoCgXYBphe+toVBmF6eGKz8sCHYsaTvvd5ZnrJBf07tjbzg@mail.gmail.com>
 <CALPaoCgnHYwpyVy_aPafPm6-v+DqirXSbVBLP_wx6jEp8pNBOA@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <CALPaoCgnHYwpyVy_aPafPm6-v+DqirXSbVBLP_wx6jEp8pNBOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 23/03/2023 09:09, Peter Newman wrote:
> On Wed, Mar 22, 2023 at 3:07 PM Peter Newman <peternewman@google.com> wrote:
>> On Mon, Mar 20, 2023 at 6:27 PM James Morse <james.morse@arm.com> wrote:
>>>
>>> x86 is blessed with an abundance of monitors, one per RMID, that can be
>>
>> As I explained earlier, this is not the case on AMD.
>>
>>> read from any CPU in the domain. MPAMs monitors reside in the MMIO MSC,
>>> the number implemented is up to the manufacturer. This means when there are
>>> fewer monitors than needed, they need to be allocated and freed.
>>>
>>> Worse, the domain may be broken up into slices, and the MMIO accesses
>>> for each slice may need performing from different CPUs.
>>>
>>> These two details mean MPAMs monitor code needs to be able to sleep, and
>>> IPI another CPU in the domain to read from a resource that has been sliced.
>>
>> This doesn't sound very convincing. Could mon_event_read() IPI all the
>> CPUs in the domain? (after waiting to allocate and install monitors
>> when necessary?)
> 
> No wait, I know that isn't correct.
> 
> As you explained it, the remote CPU needs to sleep because it may need
> to atomically acquire, install, and read a CSU monitor.
> 
> It still seems possible for the mon_event_read() thread to do all the
> waiting (tell remote CPU to program CSU monitor, wait, tell same remote
> CPU to read monitor), but that sounds like more work that I don't see a
> lot of benefit to doing today.
> 
> Can you update the changelog to just say the remote CPU needs to block
> when installing a CSU monitor?

Sure, I've added this after the first paragraph:
-------%<-------
MPAM's CSU monitors are used to back the 'llc_occupancy' monitor file. The
CSU counter is allowed to return 'not ready' for a small number of
micro-seconds after programming. To allow one CSU hardware monitor to be
used for multiple control or monitor groups, the CPU accessing the
monitor needs to be able to block when configuring and reading the
counter.
-------%<-------


Thanks,

James
