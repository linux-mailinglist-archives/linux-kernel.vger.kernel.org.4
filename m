Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C92637B5B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiKXOVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiKXOVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:21:36 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C0C4D5A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:21:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57B8B23A;
        Thu, 24 Nov 2022 06:21:41 -0800 (PST)
Received: from [10.1.197.38] (eglon.cambridge.arm.com [10.1.197.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DABAA3F73B;
        Thu, 24 Nov 2022 06:21:31 -0800 (PST)
Message-ID: <7a942c00-67a9-c038-b516-4ae85e997a6e@arm.com>
Date:   Thu, 24 Nov 2022 14:21:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 07/18] x86/resctrl: Move CLOSID/RMID matching and setting
 to use helpers
Content-Language: en-GB
To:     Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
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
 <20221021131204.5581-8-james.morse@arm.com>
 <xhsmh8rk8xnxg.mognet@vschneid.remote.csb>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <xhsmh8rk8xnxg.mognet@vschneid.remote.csb>
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

Hi Valentin,

On 18/11/2022 15:49, Valentin Schneider wrote:
> On 21/10/22 13:11, James Morse wrote:
>> When switching tasks, the CLOSID and RMID that the new task should
>> use are stored in struct task_struct. For x86 the CLOSID known by resctrl,
>> the value in task_struct, and the value written to the CPU register are
>> all the same thing.
>>
>> MPAM's CPU interface has two different PARTID's one for data accesses
>> the other for instruction fetch. Storing resctrl's CLOSID value in
>> struct task_struct implies the arch code knows whether resctrl is using
>> CDP.
>>
>> Move the matching and setting of the struct task_struct properties
>> to use helpers. This allows arm64 to store the hardware format of
>> the register, instead of having to convert it each time.
>>
>> __rdtgroup_move_task()s use of READ_ONCE()/WRITE_ONCE() ensures torn
>> values aren't seen as another CPU may schedule the task being moved
>> while the value is being changed. MPAM has an additional corner-case
>> here as the PMG bits extend the PARTID space. If the scheduler sees a
>> new-CLOSID but old-RMID, the task will dirty an RMID that the limbo code
>> is not watching causing an inaccurate count. x86's RMID are independent
>> values, so the limbo code will still be watching the old-RMID in this
>> circumstance.
>> To avoid this, arm64 needs both the CLOSID/RMID WRITE_ONCE()d together.
>> Both values must be provided together.

> I think I remember something about this... Is that about having them
> union'd and read/written as one? (just for my own curiosity)

Yup. Many moons ago you pointed out that storing partid/pmg separately lets the remote
CPUs load torn values. arm64 not only needs the values as a pair, it needs to read/write
them as a pair.


>> Because MPAM's RMID values are not unique, the CLOSID must be provided
>> when matching the RMID.
>>
>> CC: Valentin Schneider <vschneid@redhat.com>

(CC here also stands for celebrate-contribution!)


>> Signed-off-by: James Morse <james.morse@arm.com>
> 
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>

Thanks!

James
