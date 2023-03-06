Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8546ABE33
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCFLdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjCFLc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:32:59 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB0663C22
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 03:32:55 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00B0512FC;
        Mon,  6 Mar 2023 03:33:39 -0800 (PST)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C01E3F5A1;
        Mon,  6 Mar 2023 03:32:53 -0800 (PST)
Message-ID: <ab8c7a00-8c7e-97ab-25db-92053c7b45cc@arm.com>
Date:   Mon, 6 Mar 2023 11:32:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 08/18] x86/resctrl: Queue mon_event_read() instead of
 sending an IPI
Content-Language: en-GB
To:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "peternewman@google.com" <peternewman@google.com>
References: <20230113175459.14825-1-james.morse@arm.com>
 <20230113175459.14825-9-james.morse@arm.com>
 <IA1PR11MB6097ED9919B408116EFE161E9BC69@IA1PR11MB6097.namprd11.prod.outlook.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <IA1PR11MB6097ED9919B408116EFE161E9BC69@IA1PR11MB6097.namprd11.prod.outlook.com>
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

Hi Fenghua,

On 17/01/2023 18:29, Yu, Fenghua wrote:
>> x86 is blessed with an abundance of monitors, one per RMID, that can be read
>> from any CPU in the domain. MPAMs monitors reside in the MMIO MSC, the
>> number implemented is up to the manufacturer. This means when there are
>> fewer monitors than needed, they need to be allocated and freed.
>>
>> Worse, the domain may be broken up into slices, and the MMIO accesses for
>> each slice may need performing from different CPUs.
>>
>> These two details mean MPAMs monitor code needs to be able to sleep, and IPI
>> another CPU in the domain to read from a resource that has been sliced.
>>
>> mon_event_read() already invokes mon_event_count() via IPI, which means this
>> isn't possible.
>>
>> Change mon_event_read() to schedule mon_event_count() on a remote CPU
>> and wait, instead of sending an IPI. This function is only used in response to a
>> user-space filesystem request (not the timing sensitive overflow code).

> But mkdir mon group needs mon_event_count() to reset RMID state.
> If mon_event_count() is called much later, the RMID state may be used
> before it's reset. E.g. prev_msr might be non-0 value. That will cause
> overflow code failure.
> 
> Seems this may happen on both x86 and arm64. At least need to make sure
> RMID state reset happens before it's used.

On the architecture side, there is a patch from Peter that records the MSR value on the
architecture side when an RMID is reset/re-allocated. 2a81160d29d6 ("x86/resctrl: Fix
event counts regression in reused RMIDs")

For the filesystem, the 'first' value is passed through and handled by the CPU that reads
the MSR. I don't see what problem any extra delay due to scheduling would cause.


Thanks,

James
