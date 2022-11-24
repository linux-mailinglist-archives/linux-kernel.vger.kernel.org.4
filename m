Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EB7637B5F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiKXOWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiKXOWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:22:13 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7325EBC8B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:22:11 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B31A223A;
        Thu, 24 Nov 2022 06:22:17 -0800 (PST)
Received: from [10.1.197.38] (eglon.cambridge.arm.com [10.1.197.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD3D23F73B;
        Thu, 24 Nov 2022 06:22:08 -0800 (PST)
Message-ID: <39cb8e29-2c04-a316-73d4-2878e98c3625@arm.com>
Date:   Thu, 24 Nov 2022 14:22:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 14/18] x86/resctrl: Add helpers for system wide mon/alloc
 capable
Content-Language: en-GB
To:     "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
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
        "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "peternewman@google.com" <peternewman@google.com>
References: <20221021131204.5581-1-james.morse@arm.com>
 <20221021131204.5581-15-james.morse@arm.com>
 <TYAPR01MB633026AE84D35BCB92211C4B8B019@TYAPR01MB6330.jpnprd01.prod.outlook.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <TYAPR01MB633026AE84D35BCB92211C4B8B019@TYAPR01MB6330.jpnprd01.prod.outlook.com>
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

Hello!

On 10/11/2022 10:51, Shaopeng Tan (Fujitsu) wrote:
>> resctrl reads rdt_alloc_capable or rdt_mon_capable to determine whether any
>> of the resources support the corresponding features.
>> resctrl also uses the static-keys that affect the architecture's context-switch
>> code to determine the same thing.
>>
>> This forces another architecture to have the same static-keys.
>>
>> As the static-key is enabled based on the capable flag, and none of the
>> filesystem uses of these are in the scheduler path, move the capable flags
>> behind helpers, and use these in the filesystem code instead of the static-key.
>>
>> After this change, only the architecture code manages and uses the static-keys
>> to ensure __resctrl_sched_in() does not need runtime checks.
>>
>> This avoids multiple architectures having to define the same static-keys.

> arch/x86/kernel/cpu/resctrl/rdtgroup.c
>  static void mkdir_rdt_prepare_rmid_free(struct rdtgroup *rgrp)
>  {
>          if (rdt_mon_capable) 
>                  free_rmid(rgrp->closid, rgrp->mon.rmid);
>  }
> I think you forgot to fix rdt_mon_capable here.
> if (rdt_mon_capable) => if (resctrl_arch_mon_capable())

Yes - looks like I did.


Thanks!

James
