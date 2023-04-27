Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AED6F0704
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243748AbjD0OKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243795AbjD0OKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:10:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6597D46AE
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 07:10:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19F452F4;
        Thu, 27 Apr 2023 07:10:56 -0700 (PDT)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B0463F64C;
        Thu, 27 Apr 2023 07:09:50 -0700 (PDT)
Message-ID: <87a8ee28-903a-b561-5736-3543ff1550ae@arm.com>
Date:   Thu, 27 Apr 2023 15:09:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 06/19] x86/resctrl: Allow the allocator to check if a
 CLOSID can allocate clean RMID
Content-Language: en-GB
To:     Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
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
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com
References: <20230320172620.18254-1-james.morse@arm.com>
 <20230320172620.18254-7-james.morse@arm.com>
 <37c2371c-11e6-a2ef-059a-1a0ba08c2f67@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <37c2371c-11e6-a2ef-059a-1a0ba08c2f67@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 01/04/2023 00:21, Reinette Chatre wrote:
> On 3/20/2023 10:26 AM, James Morse wrote:
>> +/**
>> + * resctrl_closid_is_dirty - Determine if all RMID associated with this CLOSID
>> + *                           are available.
>> + * @closid: The CLOSID that is being queried.
>> + *
>> + * MPAM's equivalent of RMID are per-CLOSID, meaning a freshly allocated CLOSID
>> + * may not be able to allocate clean RMID. To avoid this the allocator will
>> + * only return clean CLOSID. This is enough for now as it allows MPAM systems
>> + * to use resctrl. This suffers from the problem that there may be no CLOSID
>> + * where all the RMID are clean, causing the CLOSID allocation to fail.
>> + * This can be improved (once MPAM support is upstream) to return the cleanest
>> + * CLOSID where PMG=0 is clean. This would allow the CLOSID allocation to

> Why does PMG=0 have to be the clean ID?

True, there ends up being a second search anyway.


> I am wondering about the use cases here. When a new CLOSID needs to be allocated,
> would it not be useful to instead have a utility that returns the "cleanest" CLOSID?

It would, but this is a trade off between churn and features, I'm trying to do the minimum
to get feature parity for supporting MPAM by keeping any additional code that x86 doesn't
use small and simple. Improvements that only affect MPAM can be kicked down the road.

But as we're discussing it...


> Instead of picking an available CLOSID and then always have to check if it is
> "dirty or not", why not have a utility that picks the CLOSID with the most
> available PMGs?

I think an extra array to keep track of this is simplest as it avoids a complex walk of
the rmid_ptrs[] array looking for the global minimum across a number of entries. I think
it would be two additional patches. I'll include this in the next version.


Thanks,

James



