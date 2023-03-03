Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB456A9EE9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjCCSfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbjCCSe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:34:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66B3A60A84
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 10:34:51 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66E12143D;
        Fri,  3 Mar 2023 10:35:34 -0800 (PST)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09DE93F93E;
        Fri,  3 Mar 2023 10:34:45 -0800 (PST)
Message-ID: <753cd447-24a8-0dd8-6f35-9ad75ba619c5@arm.com>
Date:   Fri, 3 Mar 2023 18:34:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 05/18] x86/resctrl: Allow RMID allocation to be scoped
 by CLOSID
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
References: <20230113175459.14825-1-james.morse@arm.com>
 <20230113175459.14825-6-james.morse@arm.com>
 <2ad21ffe-6019-eb34-a0b3-2c9d26799269@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <2ad21ffe-6019-eb34-a0b3-2c9d26799269@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 02/02/2023 23:45, Reinette Chatre wrote:
> On 1/13/2023 9:54 AM, James Morse wrote:
>> MPAMs RMID values are not unique unless the CLOSID is considered as well.
>>
>> alloc_rmid() expects the RMID to be an independent number.
>>
>> Pass the CLOSID in to alloc_rmid(). Use this to compare indexes when
>> allocating. If the CLOSID is not relevant to the index, this ends up
>> comparing the free RMID with itself, and the first free entry will be
>> used. With MPAM the CLOSID is included in the index, so this becomes a
>> walk of the free RMID entries, until one that matches the supplied
>> CLOSID is found.
>>
>> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
>> Signed-off-by: James Morse <james.morse@arm.com>
> 
> ...
> 
>>  /*
>> - * As of now the RMIDs allocation is global.
>> + * As of now the RMIDs allocation is the same in each domain.

> Could you please elaborate what is meant/intended with this change
> (global vs per domain)? From the changelog a comment that RMID
> allocation is the same in each resource group for MPAM may be
> expected but per domain is not clear to me.

This is badly worded. It's referring to the limbo list management, while RMID=7 isn't
unique on MPAM, the struct rmid_entry used in two domains will be the same because the
CLOSID doesn't change. This means its still sufficient to move around the struct
rmid_entry to manage the limbo list.

I think this had me confused because 'as of now' implies the RMID won't always be globally
allocated, and MPAM has non-unique RMID/PMG values which are a different kind of global.


I'll change this to read:
/*
 * For MPAM the RMID value is not unique, and has to be considered with
 * the CLOSID. The (CLOSID, RMID) pair is allocated on all domains, which
 * allows all domains to be managed by a single limbo list.
 * Each domain also has a rmid_busy_llc to reduce the work of the limbo handler.
 */

(seeing as the function doesn't touch rmid_budy_llc, or refer to it by name)

Thanks,

James
