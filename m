Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2275E5EC4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 11:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiIVJkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 05:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiIVJkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 05:40:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A69393ECF6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 02:40:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2A3E1595;
        Thu, 22 Sep 2022 02:40:46 -0700 (PDT)
Received: from [10.1.197.78] (eglon.cambridge.arm.com [10.1.197.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD7933F73B;
        Thu, 22 Sep 2022 02:40:37 -0700 (PDT)
Message-ID: <d1a20168-c7ce-78f9-33ef-7f408426d743@arm.com>
Date:   Thu, 22 Sep 2022 10:40:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 00/21] x86/resctrl: Make resctrl_arch_rmid_read()
 return values in bytes
Content-Language: en-GB
To:     "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>
References: <20220902154829.30399-1-james.morse@arm.com>
 <TYAPR01MB63307A29B75C74ACFE2A748B8B479@TYAPR01MB6330.jpnprd01.prod.outlook.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <TYAPR01MB63307A29B75C74ACFE2A748B8B479@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 13/09/2022 02:00, tan.shaopeng@fujitsu.com wrote:
>> Changes in this version?
>>  * Changed supports_mba_mbps() to use is_mbm_local_enabled()
>>
>> ---
>> The aim of this series is to insert a split between the parts of the monitor code
>> that the architecture must implement, and those that are part of the resctrl
>> filesystem. The eventual aim is to move all filesystem parts out to live in
>> /fs/resctrl, so that resctrl can be wired up for MPAM.
>>
>> What's MPAM? See the cover letter of a previous series. [1]
>>
>> The series adds domain online/offline callbacks to allow the filesystem to
>> manage some of its structures itself, then moves all the 'mba_sc' behaviour to
>> be part of the filesystem.
>> This means another architecture doesn't need to provide an mbps_val array.
>> As its all software, the resctrl filesystem should be able to do this without any
>> help from the architecture code.
>>
>> Finally __rmid_read() is refactored to be the API call that the architecture
>> provides to read a counter value. All the hardware specific overflow detection,
>> scaling and value correction should occur behind this helper.

> I tested this patch series(patch v6) on Intel(R) Xeon(R) Gold 6254 CPU with resctrl selftest.
> It is no problem.
> 
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>

Thanks for testing it again!


James
