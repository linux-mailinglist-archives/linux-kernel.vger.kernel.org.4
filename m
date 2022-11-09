Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7846230FD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiKIREF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbiKIRDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:03:36 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D5E929C8A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 09:02:51 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56F871FB;
        Wed,  9 Nov 2022 09:02:56 -0800 (PST)
Received: from [10.1.197.38] (eglon.cambridge.arm.com [10.1.197.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97F603F534;
        Wed,  9 Nov 2022 09:02:46 -0800 (PST)
Message-ID: <bd31ed69-7748-b46c-f98a-3701e1de3e0d@arm.com>
Date:   Wed, 9 Nov 2022 17:02:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 06/18] x86/resctrl: Allow the allocator to check if a
 CLOSID can allocate clean RMID
Content-Language: en-GB
To:     Shawn Wang <shawnwang@linux.alibaba.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, xingxin.hx@openanolis.org,
        baolin.wang@linux.alibaba.com, peternewman@google.com
References: <20221021131204.5581-1-james.morse@arm.com>
 <20221021131204.5581-7-james.morse@arm.com>
 <fd711241-5811-9673-aa02-dfa5ecd36dbf@linux.alibaba.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <fd711241-5811-9673-aa02-dfa5ecd36dbf@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

On 08/11/2022 15:57, Shawn Wang wrote:
> On 10/21/2022 9:11 PM, James Morse wrote:
>> MPAM's PMG bits extend its PARTID space, meaning the same PMG value can be
>> used for different control groups.
>>
>> This means once a CLOSID is allocated, all its monitoring ids may still be
>> dirty, and held in limbo.
>>
>> Add a helper to allow the CLOSID allocator to check if a CLOSID has dirty
>> RMID values. This behaviour is enabled by a kconfig option selected by
>> the architecture, which avoids a pointless search for x86.

>> +/**
>> + * resctrl_closid_is_dirty - Determine if clean RMID can be allocate for this
>> + *                           CLOSID.
>> + * @closid: The CLOSID that is being queried.
>> + *
>> + * MPAM's equivalent of RMID are per-CLOSID, meaning a freshly allocate CLOSID
>> + * may not be able to allocate clean RMID. To avoid this the allocator will
>> + * only return clean CLOSID.
>> + */
>> +bool resctrl_closid_is_dirty(u32 closid)
>> +{
>> +    struct rmid_entry *entry;
>> +    int i;
>> +
>> +    lockdep_assert_held(&rdtgroup_mutex);
>> +
>> +    if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
>> +        return false;
> 
> Since dirty closid occurs when the kconfig option for MPAM is enabled, it seems
> that the condition of the if statement here should take the opposite value:
>     if (!IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))

Yup. Bother.

Thanks for spotting that! It was intended to avoid this work on x86 as its pointless, and
the number of RMID could be large.


Thanks!

James
