Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D9F60E90E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbiJZTga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234170AbiJZTg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:36:27 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF9678BF0;
        Wed, 26 Oct 2022 12:36:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KroJjuioC+YCpbYNY41cid3uDFD8/8jchze2UeFf3zOJaLd1nagxdrwyrYZigCDi38yfka5YcQfiF4lLWV1jFoMGDBbcWnP8fk0sn3PZ71kbzbwJ+HWDhq5mhqyY5I8c4K0k2Q49tLQpbCivH5Qb0Cwn4xN8/UpgBwluv2Xoz2YTxQKoKS1W+37TcEK2uGgufvoety3Wfj/vNnO+3arYh6nR5DShF6Zvqf9S2fVxX+k1v3OMS2qQN9B+rAUPceEd5ujKsT8KbY0TwF7VexQB3orHcllgYsmROLwXv9g3w7geUlU2lwz8enRcaR2joP6ij+AzdzyJLvn2nr6qbyjKeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2wr31c3ejz3qiAt1nKKJU4Il/w7/UqjFk8ScF1Tsmg=;
 b=bif9isBv9J+1W+8JTEH6i3BOlzDXBHV9/f1hiYBC9vndF25O1fZGLoxF97++3O2s3UIakYDamvAMispLrk93Eb4yE6MpPMMdQFoANczY8/DPRj3vWGVz4i7/UySfxywIZyoI11aYDDiDX7oqnWsJ0TEMtBN2nKuY5q+B7sqenrhemT2837fWyoRnwDmMvi8kq/O9WropZkfRmXlXHZLpSRUy8WUDK7JeU3V0lPmQfjWGMOpJjIuDYansdv1cIbxEa1imueKoS9VH5+PHIBOqataOXUYOhFwr4s498Eh/M6pdrHhA54iCKzd2yVH81/fSfMWH5vCIfFSrGZke666ctA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2wr31c3ejz3qiAt1nKKJU4Il/w7/UqjFk8ScF1Tsmg=;
 b=HQunJx/WahdXJAaDrVzUA/GRZeLlIwae2s5NpQbPVJhlpcTnRbEmUhmyx3wbNdfjplqoWATOs9WYk+nkt6TBEwnY5DkjXly5jjsIfyTWuej2s6MbYkt/HyNPlMBjfeRu5S/zvZHkRtRsRUKcRFXPKiAQh5iApvSkQ9+gL6vuXb0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ0PR12MB7067.namprd12.prod.outlook.com (2603:10b6:a03:4ae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Wed, 26 Oct
 2022 19:36:21 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::2d5:77ac:6d39:e57b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::2d5:77ac:6d39:e57b%9]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 19:36:21 +0000
Message-ID: <a6349e6d-6733-66be-87d0-a10fc1480305@amd.com>
Date:   Wed, 26 Oct 2022 14:36:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 07/12] x86/resctrl: Add sysfs interface to read
 mbm_total_bytes event configuration
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com
References: <166604543832.5345.9696970469830919982.stgit@bmoger-ubuntu>
 <166604561380.5345.17668177010598977321.stgit@bmoger-ubuntu>
 <0065fe9d-80d4-2e8a-afbb-d150df2ee78b@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <0065fe9d-80d4-2e8a-afbb-d150df2ee78b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0060.namprd03.prod.outlook.com
 (2603:10b6:610:b3::35) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ0PR12MB7067:EE_
X-MS-Office365-Filtering-Correlation-Id: 12a8db5e-4576-47d3-13fd-08dab7895bfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /D6o+rEV5aug3FGW4h5HN+XRI43jVKirtzGsiLPsm9BhpaeD7hQdbMQUq6eptdN3ZXlgKCAh37lOJpysdyUBjunvI788bsOjmdpcl3iQ7sOmCD33CVMtTxA2l3Vz9H+y8rFIxg0oIe43muojg71yGprB/obBhQyggyWJCkkLHK3ce7bMVadTcRkXJPDPpyBNC9xmAoLE2YgCh9MZZDMjEIuAou6dJbg1yUIHIpVeP1BJQiPdoGvNSRXpYusGg4iLIacX64gjC0Ka/tyNv/HDKtipPUjhoPXT0GX5hmQOiGViNEeMIN6xz/6GE1OANVQXI0hpyhsRiQwAfcAR6vCbT49f/k1wd2calN/fz/dE0zwScN/tEOgLaSCAzvYDVCqxJ9MBrJVFaPg+9bnI7e3EepIZ4S7f1un15FyD3xc6TVObpkFZNacesFrv7Hx9ZjLXZaH94+E1Z2y6xsrjgz4KPotFbp48YfkZNudqjhMt1CmzQFF6xnIm89Jh+Y3f1362U2QUtKRFtnntHSPtB94o7BgCNavReRYvk6gYOlxjqu3LmfoAl6dI/NJpzCm//nI+EdIs/dqLSorxsfmONTzlxN961Cl/Ptf9IWgH4L3TRpv4vO11k7C1Ws7VRoIcF3J8P11LebnN/KVDeCI+3Q0Bb8op5ZmbsZMuzzudTQ1Y6jYEi2birf9N7F+DxB7HgHZJEY5d3Kkql9BDCKTyVoYjbj/cwQUBVAhGy/qD6XtKyfYtfXg1RuNNfxh3/Zp1oZ1uvaadsgOR49vb7Z0dapWz8C1hNLsQlJ0JRQJSh4rxvas=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199015)(66946007)(5660300002)(4326008)(6666004)(36756003)(8676002)(7416002)(8936002)(2906002)(41300700001)(3450700001)(316002)(6506007)(478600001)(66556008)(2616005)(31686004)(26005)(6486002)(6512007)(31696002)(53546011)(66476007)(38100700002)(83380400001)(186003)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWY4WENvZHBGU2lTclVyN2d4QlM3OUtMSzVpejhFUWJTeXJqa1dScEpkMmgz?=
 =?utf-8?B?cVg0RkpqSklpM2pTMklqMzhURHpQRlRBL3NDWHBab08xK05sVHZuMUNXZkhl?=
 =?utf-8?B?eHJkK3FjcElobnZkV250TWIrR3R0VlRvWEY4Rmdtd3ZkeGdScXZ4MjBkSDRH?=
 =?utf-8?B?UFBQOVVEU21hZFQvRHluakpuTE5Bd2t0VHU3cGFOZEFvT2ZERDcyV1BUbHU2?=
 =?utf-8?B?dzJCMW5FcWVLUTN0aFM0a0lnT0J4aHFpMzhiYXJCdzNYVmp3eUxiUEFISThM?=
 =?utf-8?B?cjAyUWhwbldSVElXTnF6R1RIYktJb1JwNVNLcWV1Z0p1NDN1SFRra1pMaW51?=
 =?utf-8?B?bk1xdDhSckgwYUdUbUJZWlMwTmN4S1BIVlVlYldPWUpKclZvNm1HRyszOFBQ?=
 =?utf-8?B?YjB1SHYyQVh2d01GMHY2MjBoeDQ1Mk9wZ2tyNHhlY0ZzQWpEL2dFdUhLd3Rw?=
 =?utf-8?B?UVZLbHdwRjBqaW9NSzNBbVVQeFVLZEVheTNleW5nSjc3QlhxbHM5alZrWWl3?=
 =?utf-8?B?b1dRbXB0MUkybXA5cmxPVEZVbVhoK2RhakVDVlJJYi8rY0Q2TkJHa1J5VXNF?=
 =?utf-8?B?UktyNTgweUt1ZHV1bjFNYmcvZmpSRkZhWndLQTFMT05JVkdaK1Z3cUtwRnp2?=
 =?utf-8?B?NnZOWHg4YndKNC8wZ2FNeW9VSDRaVkZXQy9TcFhxdlYvcGxEcFhYQ0NWalZr?=
 =?utf-8?B?MDVFTXE3RTVYaU9iMnRMdWFyQUQ4WXhWT21UNzR0ZjBsWUdTWkZwTkN6aTdN?=
 =?utf-8?B?ci8zQzBBblFxMU52K0FDM21QdGo4UUlWUmNYL1MvVnRTTWt4TWE5UTNnUjZh?=
 =?utf-8?B?UXgzK2ViYlAyK09PQ2cyN2NaSWRDcHJCVXBtSTUwZzk5bzVHeTVQTW95NndG?=
 =?utf-8?B?Q3VFL2loc2xXdXdzRGdoUGhLcVYxcjhiTTg2cnpXMlI0NkwxSm9BcHNkZmxH?=
 =?utf-8?B?bWdudzZ0NVlMU1VPRkhZaWI1cWZ1SUxsOE9vSEtBdTdzcEZRN2poYWpKQkVv?=
 =?utf-8?B?N3dJdnM2cWxCVW8raEc1WWE3cm1NVjRqejFkdEpwZWpMTUkwbm53SnR3WGxo?=
 =?utf-8?B?Wk9YRjVzRXRKZzhJdFZJaS9hcEpLMEEzVGV6WU1QcVBOcHBCYmxpbTh0alVy?=
 =?utf-8?B?NzFPZUczR2dJb0VwTTE0cWJNbU82S29vWEZXN1Y2dUpoR3B4UkxBMmZHU1lM?=
 =?utf-8?B?bzMyNkFJcC90bGp6RGlKM2hqQXd6NHQrZzd0YkszYXJpSmNkb1MzZWJjTkxZ?=
 =?utf-8?B?amp0NzRrUng1V3NkOWpiZTM5aTdBY2RzZ3JVU2hYbE0rU2ZGbHNBQzRybmtp?=
 =?utf-8?B?YWQxN05sQ2V4Z2ZlcnZkMHJvMm1DS0R1ZHR6Z1MrajFpdE5lY2FmVHNvek15?=
 =?utf-8?B?VlRkcEpOekpJVGZsR1QzYzN3OUQ4bVVnbGc1YkxtSzBTNm8zM01aWGhtaHkv?=
 =?utf-8?B?Q3RwQVpNRFVkNTBQZzh1MVBQWWNvcDllU01kYkV5RzJ6eUJSTFJRaHVJVUdX?=
 =?utf-8?B?OWR3Z0pVS29ZWWlxUlJieTd1ajZjcmg3YnlGMEZLRUlicTkvSWtML2lZYVJJ?=
 =?utf-8?B?WnNjL2F2S285MWtaTHJhRnBlbmNlMmwwK2pCcEI2ZlVhNzZhSnZYd3VxQmtO?=
 =?utf-8?B?VGVXeVcyVkQ5eGtTTWc0MzlKRVpnMUN6YVBSVGJFbXZMYUlEcFRLaWprN0lz?=
 =?utf-8?B?QVdEZjQwenpNS25RclVYZE83ZHNBbWFOTGRYbUtqMitmWHBQODFRcFRvRXdG?=
 =?utf-8?B?S1k0aTBlc3MyMlk4eG1RWFhJNDdqbHY3YlBUNEIrdWpJQk83SStEeEs0NElm?=
 =?utf-8?B?dFF1eWsyemh3ZW93c0syOTBlQmI4cE1mbkFmcHRpK0tpVGg0d2ZiZWdGUjN6?=
 =?utf-8?B?Qk9JN0N1eHZ3emJaL2JmNUhJUHFtUk1uUmxuV294d05abUFrR0Jac1dWYitR?=
 =?utf-8?B?elNaaHZDZXZCdUg5d3ByeTJmdDhieXl1M0tPSjlPTFNDdnJOT2UwMmZpT1li?=
 =?utf-8?B?SUhiaitLQjkxYXk3d1RqbGZRbDM3UEo1ZU5telE4YUdFb3pJRmNTS2JpR1Q5?=
 =?utf-8?B?c3V2bHU1dXhEWi8vM1lpSXp1ZVJlZG0zSXZqRFNSZ1dVUjgzQW9mRGFZL0ZI?=
 =?utf-8?Q?PAOvhCJ0udNn9DsuuFqBy5n8C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a8db5e-4576-47d3-13fd-08dab7895bfe
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 19:36:21.1251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: muxL0R50gTt8hjgKiRuCohlMQD/9j85CqQv44f3ojJCfoUVrZbZ+sTiNdLsV7XM+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7067
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 10/25/22 18:47, Reinette Chatre wrote:
> Hi Babu,
>
> On 10/17/2022 3:26 PM, Babu Moger wrote:
>> The current event configuration can be viewed by the user by reading
>> the configuration file /sys/fs/resctrl/info/L3_MON/mbm_total_config.
>> The event configuration settings are domain specific and will affect all
>> the CPUs in the domain.
>>
>> Following are the types of events supported:
>> ====  ===========================================================
>> Bits   Description
>> ====  ===========================================================
>> 6      Dirty Victims from the QOS domain to all types of memory
>> 5      Reads to slow memory in the non-local NUMA domain
>> 4      Reads to slow memory in the local NUMA domain
>> 3      Non-temporal writes to non-local NUMA domain
>> 2      Non-temporal writes to local NUMA domain
>> 1      Reads to memory in the non-local NUMA domain
>> 0      Reads to memory in the local NUMA domain
>> ====  ===========================================================
>>
>> By default, the mbm_total_bytes configuration is set to 0x7f to count
>> all the event types.
>>
>> For example:
>>     $cat /sys/fs/resctrl/info/L3_MON/mbm_total_config
>>     0=0x7f;1=0x7f;2=0x7f;3=0x7f
>>
>>     In this case, the event mbm_total_bytes is currently configured
>>     with 0x7f on domains 0 to 3.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  arch/x86/kernel/cpu/resctrl/core.c     |    3 +
>>  arch/x86/kernel/cpu/resctrl/internal.h |    2 +
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   76 ++++++++++++++++++++++++++++++++
>>  3 files changed, 81 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index 46813b1c50c2..758c5d7553a4 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -826,6 +826,9 @@ static __init bool get_rdt_mon_resources(void)
>>  	if (!rdt_mon_features)
>>  		return false;
>>  
>> +	if (mon_configurable)
>> +		mbm_config_rftype_init();
>> +
> Please move this to be within rdt_get_mon_l3_config().
Sure.
>
>>  	return !rdt_get_mon_l3_config(r, mon_configurable);
>>  }
>>  
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index b458f768f30c..326a1b582f38 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -15,6 +15,7 @@
>>  #define MSR_IA32_MBA_THRTL_BASE		0xd50
>>  #define MSR_IA32_MBA_BW_BASE		0xc0000200
>>  #define MSR_IA32_SMBA_BW_BASE		0xc0000280
>> +#define MSR_IA32_EVT_CFG_BASE		0xc0000400
>>  
>>  #define MSR_IA32_QM_CTR			0x0c8e
>>  #define MSR_IA32_QM_EVTSEL		0x0c8d
>> @@ -541,5 +542,6 @@ bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
>>  void __check_limbo(struct rdt_domain *d, bool force_free);
>>  void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>>  void __init thread_throttle_mode_init(void);
>> +void __init mbm_config_rftype_init(void);
>>  
>>  #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 5f0ef1bf4c78..0982845594d0 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1423,6 +1423,67 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
>>  	return ret;
>>  }
>>  
>> +struct mon_config_info {
>> +	u32 evtid;
>> +	u32 mon_config;
>> +};
>> +
>> +static void mon_event_config_read(void *info)
>> +{
>> +	struct mon_config_info *mon_info = info;
>> +	u32 h, msr_index;
>> +
>> +	switch (mon_info->evtid) {
>> +	case QOS_L3_MBM_TOTAL_EVENT_ID:
>> +		msr_index = 0;
>> +		break;
>> +	case QOS_L3_MBM_LOCAL_EVENT_ID:
>> +		msr_index = 1;
>> +		break;
>> +	default:
>> +		/* Not expected to come here */
>> +		return;
>> +	}
>> +
>> +	rdmsr(MSR_IA32_EVT_CFG_BASE + msr_index, mon_info->mon_config, h);
>> +}
>> +
>> +static void mondata_config_read(struct rdt_domain *d, struct mon_config_info *mon_info)
>> +{
>> +	smp_call_function_any(&d->cpu_mask, mon_event_config_read, mon_info, 1);
>> +}
>> +
>> +static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid)
>> +{
>> +	struct mon_config_info mon_info = {0};
>> +	struct rdt_domain *dom;
>> +	bool sep = false;
>> +
>> +	list_for_each_entry(dom, &r->domains, list) {
> This is done with no protection ... I do not see anything preventing last CPU of
> a domain going offline around this time taking this domain with it while this code
> still tries to access its members.
>
> I think all of this needs protection with rdtgroup_mutex.
Yes. I agree. Will change it.
>
>> +		if (sep)
>> +			seq_puts(s, ";");
>> +
>> +		mon_info.evtid = evtid;
>> +		mondata_config_read(dom, &mon_info);
>> +
>> +		seq_printf(s, "%d=0x%02x", dom->id, mon_info.mon_config);
> It does not seem robust to me to use printf field width to manage the data
> returned from hardware. At this time bits 0 - 6 are supported by hardware ...
> what happens if hardware starts using bit 7 for something? 
> It seems to me that the mask introduced later needs to be pulled here to
> ensure that only the valid bits are handled.
Ok. Sure.
>
>> +		sep = true;
>> +	}
>> +	seq_puts(s, "\n");
>> +
>> +	return 0;
>> +}
>> +
>> +static int mbm_total_config_show(struct kernfs_open_file *of,
>> +				 struct seq_file *seq, void *v)
>> +{
>> +	struct rdt_resource *r = of->kn->parent->priv;
>> +
>> +	mbm_config_show(seq, r, QOS_L3_MBM_TOTAL_EVENT_ID);
>> +
>> +	return 0;
>> +}
>> +
>>  /* rdtgroup information files for one cache resource. */
>>  static struct rftype res_common_files[] = {
>>  	{
>> @@ -1521,6 +1582,12 @@ static struct rftype res_common_files[] = {
>>  		.seq_show	= max_threshold_occ_show,
>>  		.fflags		= RF_MON_INFO | RFTYPE_RES_CACHE,
>>  	},
>> +	{
>> +		.name		= "mbm_total_config",
>> +		.mode		= 0644,
>> +		.kf_ops		= &rdtgroup_kf_single_ops,
>> +		.seq_show	= mbm_total_config_show,
>> +	},
> Please only make mode writable when there is support for it.

Ok.

Thanks

Babu

>
>>  	{
>>  		.name		= "cpus",
>>  		.mode		= 0644,
>> @@ -1627,6 +1694,15 @@ void __init thread_throttle_mode_init(void)
>>  	rft->fflags = RF_CTRL_INFO | RFTYPE_RES_MB;
>>  }
>>  
>> +void __init mbm_config_rftype_init(void)
>> +{
>> +	struct rftype *rft;
>> +
>> +	rft = rdtgroup_get_rftype_by_name("mbm_total_config");
>> +	if (rft)
>> +		rft->fflags = RF_MON_INFO | RFTYPE_RES_CACHE;
>> +}
>> +
>>  /**
>>   * rdtgroup_kn_mode_restrict - Restrict user access to named resctrl file
>>   * @r: The resource group with which the file is associated.
>>
>>
>
> Reinette

-- 
Thanks
Babu Moger

