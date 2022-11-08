Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380416218E6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbiKHP6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234310AbiKHP6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:58:16 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8B815701
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 07:58:14 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=shawnwang@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VUK61dP_1667923078;
Received: from 30.39.65.162(mailfrom:shawnwang@linux.alibaba.com fp:SMTPD_---0VUK61dP_1667923078)
          by smtp.aliyun-inc.com;
          Tue, 08 Nov 2022 23:58:09 +0800
Message-ID: <fd711241-5811-9673-aa02-dfa5ecd36dbf@linux.alibaba.com>
Date:   Tue, 8 Nov 2022 23:57:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
From:   Shawn Wang <shawnwang@linux.alibaba.com>
Subject: Re: [PATCH 06/18] x86/resctrl: Allow the allocator to check if a
 CLOSID can allocate clean RMID
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
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
In-Reply-To: <20221021131204.5581-7-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/21/2022 9:11 PM, James Morse wrote:
> MPAM's PMG bits extend its PARTID space, meaning the same PMG value can be
> used for different control groups.
> 
> This means once a CLOSID is allocated, all its monitoring ids may still be
> dirty, and held in limbo.
> 
> Add a helper to allow the CLOSID allocator to check if a CLOSID has dirty
> RMID values. This behaviour is enabled by a kconfig option selected by
> the architecture, which avoids a pointless search for x86.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   arch/x86/kernel/cpu/resctrl/internal.h |  1 +
>   arch/x86/kernel/cpu/resctrl/monitor.c  | 31 ++++++++++++++++++++++++++
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 18 +++++++++------
>   3 files changed, 43 insertions(+), 7 deletions(-)

> +/**
> + * resctrl_closid_is_dirty - Determine if clean RMID can be allocate for this
> + *                           CLOSID.
> + * @closid: The CLOSID that is being queried.
> + *
> + * MPAM's equivalent of RMID are per-CLOSID, meaning a freshly allocate CLOSID
> + * may not be able to allocate clean RMID. To avoid this the allocator will
> + * only return clean CLOSID.
> + */
> +bool resctrl_closid_is_dirty(u32 closid)
> +{
> +	struct rmid_entry *entry;
> +	int i;
> +
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
> +		return false;

Since dirty closid occurs when the kconfig option for MPAM is enabled, it seems
that the condition of the if statement here should take the opposite value:
	if (!IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))

> +
> +	for (i = 0; i < resctrl_arch_system_num_rmid_idx(); i++) {
> +		entry = &rmid_ptrs[i];
> +		if (entry->closid != closid)
> +			continue;
> +
> +		if (entry->busy)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +

Shawn
