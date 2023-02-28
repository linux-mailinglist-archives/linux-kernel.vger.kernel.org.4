Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236F16A5FF7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 20:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjB1Tvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 14:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjB1Tvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 14:51:43 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDBA3344D;
        Tue, 28 Feb 2023 11:51:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpgqV3jhQ3k9mO1sfI2/Ov/yf9dYkB8HzO2VTB2+cgosUbZzCKSkJ0KacL4c03nNQeQD4GKvwZAZTzCaxZrTZ9pGf0VR2lYzILmvVDBXZ8zw3HbkicClxwofVh/8BvG2duqj3HXRYyJKVQ1pihYHfMc6sHyl6RemYVmhC0EdzGPX06RzOC6SGd/8EgLycIhdOkKXDdKKWaL+vqla1b9Tn7EAf4g6MOq7Jr34Osuop9GEJdkbf2LCDMq2L0B7syVjwUq8cldz8Uj9/LOmyTAzOOcDL7ntt9yjCvRw5bB8fyUi0fFvJd4f5XcLfed8i4S5eBGMsU76xK2WN7v4o2pXLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpjEJcg1rY8WFSe02Jr3h1n8yC0mgxRmXacwtDvnsBk=;
 b=GFk0gS9G+5ATjQTNElib/azD65leDf6v94fwuVUO9Kh856R/ilI3cQTHoc5erOHhhJCAnneAfRV2QhjKKqpfbqHv+mFdETVPeEDJpRro0wi4yktSzklzX5Yy0li/avDjblptxS2nLiXRrYj7+r02c62+KrWGS7DdIzSw/nPu9sz8Dpc+dp3Zo6wqQe/5stsDaAxjx2r352ydzymm5KiZlDCrNc8iRDPoYJ07V0Yv3W0zSh16LJlJeBs448IvdEdb6kDdOQiR4oXx2l2Xa41FrkrXsD6MVAWSixMzC0QH/0nkvOw8dLhsIlIkglwDe6E97GkDN8EXdGANrhh9mGEVqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpjEJcg1rY8WFSe02Jr3h1n8yC0mgxRmXacwtDvnsBk=;
 b=MFyL/T1ZMls9gFYNRHW0Y1nOwIXMYj8yFvVcbSQ734i6OIZ9w9vEaWD2xeDAXFZZmlXna3/zLPC7vtcqX5vPP+MQXbWQJIvrZb7zSGXPIVcwkZ32YodANnIIyIN+3cmwm1dsWUey8Dfoq5BqoyFM7XZpXIf2AYdNoT2vrY/9fvk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB6661.namprd12.prod.outlook.com (2603:10b6:8:bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Tue, 28 Feb
 2023 19:51:36 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6%8]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 19:51:36 +0000
Message-ID: <38ce210b-50f7-188b-63a9-c7b3870fa99c@amd.com>
Date:   Tue, 28 Feb 2023 13:51:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH 7/7] x86/resctrl: Determine if Sub-NUMA Cluster is enabled
 and initialize.
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>, x86@kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev
References: <20230126184157.27626-1-tony.luck@intel.com>
 <20230126184157.27626-8-tony.luck@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20230126184157.27626-8-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:208:160::24) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM4PR12MB6661:EE_
X-MS-Office365-Filtering-Correlation-Id: acb97631-6974-41b9-4693-08db19c53332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hxfUtXVJUREGgXCufGZsfi3VbFAL3foSvirf2k88zdBABO6DFJtAZ7lgZ5QJI3ZSCahupDNtDDflJ3eNjAitVdizvi5xtUBuUqxJhLHK/1P2EvmvrDwRASVLjLgjPSysgxCv4BQUjDmvuL5vdgW1DHrnHWEg4cbEFJukxBk5QmUsWUn6bbXoJX2Gww74Z/VlZdoQb5LgEqUTSm4wjhSmbA4t/l6a6k6XWlOipCTwqd+xXgZcyEgcEkLWksdfKq4MKiDvRYizE13y+1ZfQcgCvuTrDgIEwgFP1ApZKI1rd2ngF/a3+sGsTsA+EtUW88iERVYrDFVO3wjqasSsNYX8y6QTBixAFMwQzdE5bban2v2DKT2bW8ck9kSpDXawYovXL4fatTki4tTwwAH5gsivRg0mLSqxBtUVvQwoKu9FvGxVCtc5uMox5C/C/mc3kCyYID4u9p/Q3L8RRrRgBpXRg1w16kMk7lyEV0Sss59656j2taiVJEY03yJ2KeivKBT90yt1usep0u1l9Jmxtp+OewnnSRHnk2cihbh66uL8yzoePnWYZH6AIemdBQskSqfL8iYQgaHcQ0uebrTGVSnQCmMlg59riMzGOLI19RBoknHUbYivQR1wb0NvgB/KCFP2pUX5MVvuliydEdLsWnlUFEWlK5fOD7Y4haiqFQLcTCObKxzz4ZRCNK0Eba8KD7QRenYQah9lun3ff2V1/cV0Oof3iu2K1jFhhkeIWvUMcfg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(451199018)(7416002)(31696002)(86362001)(2616005)(6486002)(31686004)(54906003)(36756003)(110136005)(8936002)(186003)(66476007)(8676002)(66556008)(66946007)(83380400001)(5660300002)(3450700001)(4326008)(41300700001)(53546011)(478600001)(26005)(6506007)(6512007)(6666004)(38100700002)(2906002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkdqNm03ckE0d1VFNUMvMUpHaEliMm5iVmQ4SFNxOVJWMXAwSkdQWG1KdjMw?=
 =?utf-8?B?MWpMZTU2aWtTSlBybndCTmxwVU9TREU5bTRTK0RxSWhUY1BORU44NWpvTy9z?=
 =?utf-8?B?S2pyRDVMdUQ3dS8zRGVaTEhGRVEwQzk5VEJiNUZSZHk0MWVzVmFYdGNKOGhu?=
 =?utf-8?B?VXZhRkZNeFB2UWZEVCtYY0JPcWE3K0Z4ZUQ5WVZZUC9NM2FTNmExV09RaU42?=
 =?utf-8?B?SnhiM1BIZUZJaUR6eUE5QkZuZkthaGQ0ZmhURXBtQ2VEYjE5YVZhZzRKbm1Q?=
 =?utf-8?B?c3JzVUxTTmZIdkJNNk10bVJxZDY0WFFJcGFrYlByRkQrRzJrTzhUVnVQZ2I0?=
 =?utf-8?B?VVVrcDk4eWNodlRoYlR4MWVIakE4aGl5VmRyVWVKY0Q5b0I2bHNwcHFrUmhC?=
 =?utf-8?B?aGk3dkFiVjBORGRYL0lndHp6cndRODUyK0kyZDltUDE2TXo1bG9kQ2FENWI1?=
 =?utf-8?B?MnhtNFFGN2RhZXc5ZjVFUzJQcDNlYnNtNWxSNzh0TkJOSjFnS2xIQzZGTkQ2?=
 =?utf-8?B?UUJVcjBGVEl5c3l6bS9VMER6emxQQ0dLdTRnT1lKaHRpMEFXZkFQVlR0STJv?=
 =?utf-8?B?UVRLbDYwV1FacVpBOHdFb3lTUVlTRXFnenJMaW1HdWpXWFdUUE0yU3ZoM2h2?=
 =?utf-8?B?cXdnNFh3aVVJajZXSE9jeGRrdm84a0FJVzc3bG5uUjUxdThUWmhtZWVucGg1?=
 =?utf-8?B?VHJpcldweHVPdXBOR215M3FpSERBRlRKcmFQYVh4R3U5emdVdWNzT1hZOElO?=
 =?utf-8?B?Ty9BNXI3Nm94VDd1a3ViRjJ3SzNnakNhbGNlZUVsSVFjK2U3dEhrMFUwcVFD?=
 =?utf-8?B?Z3RNNVJxRWxkeklwdEkyRWkvYUJjKzR5QXRpYjUrbElUK0phT0MvSUJzWG1W?=
 =?utf-8?B?YTNtUzBxQkxyNWhVelpOVWVScXRqLzk5SmVWL0ZlTFdJUkpqVit0aStNWnRB?=
 =?utf-8?B?dGwxQUJjSGMvcklid2hqcCtnWGZ1dG5vM2JlaHpyeXhqcEVTejZCQUw4cDRs?=
 =?utf-8?B?VzN1TzVYYzE5WXNzQUl5ZnpjT1Nvd25ZWGQzMEt2MS9CUzR0MnZxV1A0U25C?=
 =?utf-8?B?c1BySnVHUXE3Nmhuayt2VUNrY1VoMTFRWEF3WXhVUWQ4TlB2b21JUnZxd1JL?=
 =?utf-8?B?bVphdTNmdWpMWnRCSVQzL0JGOGFudHozd3h4cmtQUGRicEdQR3NkRlN3T2RU?=
 =?utf-8?B?V3JMWUNFRHJXc2V5cEJlRnlFNGZZUVZHMmhVK1ZnTU1ySTNaeFRmSVpRT1dw?=
 =?utf-8?B?RzNyZUVPTTdIaERRbjhZa3J4SjdrU0xpNXhSZURWY0FrTkdRMUtaTjJyTG1Y?=
 =?utf-8?B?MjZWVXF0TitDd2hSWDA3cEk3S1VsenBLVFJzR2Y3MW5PUFRrRitwUTI4K0kw?=
 =?utf-8?B?Y0ZhVXVIbitIWDdVcjFtdy9UbEZvYVg3N0xmY2JTcnp1T21UUHgrcXN6U0Zp?=
 =?utf-8?B?Q1UxQnVCTlh4eFRKV2s2Vi9WQjNYbTlhQnd2WEprc0phT05rbTVCU0dYZ3U3?=
 =?utf-8?B?SlNXMmhCWTh0N05yZ21SQWVwR3Nuemp0aU51QXJFakJCcXgzQXliT1ZPZUM3?=
 =?utf-8?B?eGpod0RxWnRLOUYrVWJMOERTU3VxMDQ5SWVyYW5QVHkwSWUxbU9wYUI2VEFk?=
 =?utf-8?B?ZWRMdGNBcFpTcU1tRlJxb2RGR1J3ekd2dnUyelEwSzNmZ0NiOUdGK2dvdnFW?=
 =?utf-8?B?QzJTODBJc2dCejdQUzZibFU3MmFKdVBFNFNxU0Q2UkhHSGdKbWplbkdiNmc3?=
 =?utf-8?B?eEhWdWMvckxwR0V3MmJwZUxlKzJDaG9vSGdoTXpGSkJnQ2JONHBncDBNUGVs?=
 =?utf-8?B?N2RPUXhSU2tUSW1Mc2FuaUlDdytKTHgxbktNb3diS1hVUnQyMGswb2xIQ2ta?=
 =?utf-8?B?aHdUc2Y1SE1hZmRmbHluTTdGQzJ1Qm0vcjhSb2ExR2Z0WWoranZGcTlUaUtT?=
 =?utf-8?B?RnIzR0NqbmFEclJ6cUVOcDhFNlhmWHl3eTVhSW1KeFltMGx0cDRCdk1zbkJJ?=
 =?utf-8?B?d0xRYk9BWmxyM0FVdlRseVI4TUFJWTJSaWVUSHhrM3pNZ2M3ai9rb0xmcmQ0?=
 =?utf-8?B?MzIwV0x0R1p3QXVib0hpRjR2OW1wWVlTU1o3M1laVkhNY3RvcFNBTG1lMStP?=
 =?utf-8?Q?mo8QvSKr2KxCQPhxS+Q2UJoQK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acb97631-6974-41b9-4693-08db19c53332
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 19:51:36.2960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K3ADlO88esJ12xGCojs1vz6fwx1w+V+n8vxWYN4nriMpwQaDBBkZX0KnAswEPbZM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6661
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,


On 1/26/23 12:41, Tony Luck wrote:
> There isn't a simple hardware enumeration to indicate to software that
> a system is running with Sub-NUMA Cluster enabled.
> 
> Compare the number of NUMA nodes with the number of L3 caches to calculate
> the number of Sub-NUMA nodes per L3 cache.
> 
> When Sub-NUMA cluster mode is enabled in BIOS setup the RMID counters
> are distributed equally between the SNC nodes within each socket.
> 
> E.g. if there are 400 RMID counters, and the system is configured with
> two SNC nodes per socket, then RMID counter 0..199 are used on SNC node
> 0 on the socket, and RMID counter 200..399 on SNC node 1.
> 
> Handle this by initializing a per-cpu RMID offset value. Use this
> to calculate the value to write to the RMID field of the IA32_PQR_ASSOC
> MSR during context switch, and also to the IA32_QM_EVTSEL MSR when
> reading RMID event values.
> 
> N.B. this works well for well-behaved NUMA applications that access
> memory predominantly from the local memory node. For applications that
> access memory across multiple nodes it may be necessary for the user
> to read counters for all SNC nodes on a socket and add the values to
> get the actual LLC occupancy or memory bandwidth. Perhaps this isn't
> all that different from applications that span across multiple sockets
> in a legacy system.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/include/asm/resctrl.h        |  4 ++-
>  arch/x86/kernel/cpu/resctrl/core.c    | 43 +++++++++++++++++++++++++--
>  arch/x86/kernel/cpu/resctrl/monitor.c |  2 +-
>  3 files changed, 44 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
> index 52788f79786f..59b8afd8c53c 100644
> --- a/arch/x86/include/asm/resctrl.h
> +++ b/arch/x86/include/asm/resctrl.h
> @@ -35,6 +35,8 @@ DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
>  DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
>  DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
>  
> +DECLARE_PER_CPU(int, rmid_offset);
> +
>  /*
>   * __resctrl_sched_in() - Writes the task's CLOSid/RMID to IA32_PQR_MSR
>   *
> @@ -69,7 +71,7 @@ static void __resctrl_sched_in(void)
>  	if (static_branch_likely(&rdt_mon_enable_key)) {
>  		tmp = READ_ONCE(current->rmid);
>  		if (tmp)
> -			rmid = tmp;
> +			rmid = tmp + this_cpu_read(rmid_offset);
>  	}
>  
>  	if (closid != state->cur_closid || rmid != state->cur_rmid) {
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 53b2ab37af2f..0ff739375e3b 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -16,6 +16,7 @@
>  
>  #define pr_fmt(fmt)	"resctrl: " fmt
>  
> +#include <linux/cpu.h>
>  #include <linux/slab.h>
>  #include <linux/err.h>
>  #include <linux/cacheinfo.h>
> @@ -484,6 +485,13 @@ static int get_domain_id(int cpu, enum resctrl_scope scope)
>  	return get_cpu_cacheinfo_id(cpu, scope);
>  }
>  
> +DEFINE_PER_CPU(int, rmid_offset);
> +
> +static void set_per_cpu_rmid_offset(int cpu, struct rdt_resource *r)
> +{
> +	this_cpu_write(rmid_offset, (cpu_to_node(cpu) % snc_ways) * r->num_rmid);
> +}
> +
>  /*
>   * domain_add_cpu - Add a cpu to a resource's domain list.
>   *
> @@ -515,6 +523,8 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  		cpumask_set_cpu(cpu, &d->cpu_mask);
>  		if (r->cache.arch_has_per_cpu_cfg)
>  			rdt_domain_reconfigure_cdp(r);
> +		if (r->mon_capable)
> +			set_per_cpu_rmid_offset(cpu, r);
>  		return;
>  	}
>  
> @@ -533,9 +543,12 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  		return;
>  	}
>  
> -	if (r->mon_capable && arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
> -		domain_free(hw_dom);
> -		return;
> +	if (r->mon_capable) {
> +		if (arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
> +			domain_free(hw_dom);
> +			return;
> +		}
> +		set_per_cpu_rmid_offset(cpu, r);
>  	}
>  
>  	list_add_tail(&d->list, add_pos);
> @@ -845,11 +858,35 @@ static __init bool get_rdt_resources(void)
>  	return (rdt_mon_capable || rdt_alloc_capable);
>  }
>  
> +static __init int find_snc_ways(void)
> +{
> +	unsigned long *node_caches;
> +	int cpu, node, ret;
> +
> +	node_caches = kcalloc(BITS_TO_LONGS(nr_node_ids), sizeof(*node_caches), GFP_KERNEL);
> +	if (!node_caches)
> +		return 1;
> +
> +	cpus_read_lock();
> +	for_each_node(node) {
> +		cpu = cpumask_first(cpumask_of_node(node));
> +		set_bit(get_cpu_cacheinfo_id(cpu, 3), node_caches);
> +	}
> +	cpus_read_unlock();
> +
> +	ret = nr_node_ids / bitmap_weight(node_caches, nr_node_ids);
> +	kfree(node_caches);
> +
> +	return ret;
> +}
> +
>  static __init void rdt_init_res_defs_intel(void)
>  {
>  	struct rdt_hw_resource *hw_res;
>  	struct rdt_resource *r;
>  
> +	snc_ways = find_snc_ways();
> +
>  	for_each_rdt_resource(r) {
>  		hw_res = resctrl_to_arch_res(r);
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 3fc63aa68130..bd5ec348d925 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -160,7 +160,7 @@ static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
>  	 * IA32_QM_CTR.Error (bit 63) and IA32_QM_CTR.Unavailable (bit 62)
>  	 * are error bits.
>  	 */
> -	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
> +	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid + this_cpu_read(rmid_offset));

I am thinking loud here.
When a new monitor group is created, new RMID is assigned. This is done by
alloc_rmid. It does not know about the rmid_offset details. This will
allocate the one of the free RMIDs.

When CPUs are assigned to the group, then per cpu  pqr_state is updated.
At that point, this RMID becomes default_rmid for that cpu.

But CPUs can be assigned from two different Sub-NUMA nodes.

Considering same example you mentioned.

E.g. in 2-way Sub-NUMA cluster with 200 RMID counters there are only
100 available counters to the resctrl code. When running on the first
SNC node RMID values 0..99 are used as before. But when running on the
second node, a task that is assigned resctrl rmid=10 must load 10+100
into IA32_PQR_ASSOC to use RMID counter 110.

#mount -t resctrl resctrl /sys/fs/resctrl/
#cd /sys/fs/resctrl/
#mkdir test  (Lets say RMID 1 is allocated)
#cd test
#echo 1 > cpus_list
#echo 101 > cpus_list

In this case, the following code may run on two different RMIDs even
though it was intended to run on same RMID.

wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid + this_cpu_read(rmid_offset));

Have you thought of this problem?

Thanks
Babu
