Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A7863690E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239342AbiKWSf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239257AbiKWSfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:35:53 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E6954B11;
        Wed, 23 Nov 2022 10:35:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MF4bvzWDZX/w7W1zXjynR+TA6lYdhub6wqMfKAUJCJ2GYPxcmChbNX2UdYbqGJ8fdc6x0aF1eNbTruQOSTgm83DLSyV3KlYQSZr8FODuohgKOJWpHQO1/WHqf//J73nWV/j/DTr8eu7NQUUqJA4Rgy3NNiFcjo7vcqX6KcZ5iBaf1KcdlQ7uIBkkR3BzSC9BthfN/IFAEe/b8isk+R3xCc5LzhDypdb21WlZgUs6LpZ9kL6dEIIH6TACW7xBKZ1OQ7Cj5g7hp6csMr9cSvnZvcrRbubJkD33qc00HyuBpxBot7awuKJLWayMBu3yMbbgjm7/7qdbsm/z1k7GCPCfmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BD/VfxU3CuPgDYKkIYEf6O9LcoMfna5odwIsc/7Tn/A=;
 b=ekWNbQUIKVkdDipdKJUsM+a8d5M83CTDDfHXY3fvwShZ9NsFEl7o0IDT3l7FP52VZChMHPbAKG9rekhDtRkiYl3L16BVvKuIaAtV5Izx2PVCwu9Zi17LB7MRnS6JAEYXya/WBSYRzcbV3eszWd5U+u7IZHZWCNT7sXFVNqMpRYizU91IjrcAVFKUkwLoqa/K3tXk3QIw1zx1nMxwVBqufJo0sJ8GW7moAuz+gwXHPzo37KQaFQxdQSolJzYyT94xodmHUE+Hwap5w3HaalN4FaLr5GihuNN8rs81pfV03x/fmnTT3ixynnTobDDy32L+QtUYwcvX6je96392mSoRDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BD/VfxU3CuPgDYKkIYEf6O9LcoMfna5odwIsc/7Tn/A=;
 b=j8HL1k/tpE+xFWr0EORTiSBNh4s5DHfkMvmvqA9Q/9YuvNLY0/Xlik7ohKcXgfHId/Khl9/2kgQgVQHhG8t6eemO+ZcNJCurWs7h+/ari1VTSOdYxtql4VFCwi3+n47shQpShanXriihqp5LWGZw7Y6Ipo0HgEIPbp08VvKQsos=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH2PR12MB4135.namprd12.prod.outlook.com (2603:10b6:610:7c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 18:35:49 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%4]) with mapi id 15.20.5857.018; Wed, 23 Nov 2022
 18:35:49 +0000
Message-ID: <7c1fd8c3-771e-fd4c-368a-83b30572980d@amd.com>
Date:   Wed, 23 Nov 2022 12:35:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 08/13] x86/resctrl: Add sysfs interface to read
 mbm_total_bytes_config
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
References: <166759188265.3281208.11769277079826754455.stgit@bmoger-ubuntu>
 <166759205510.3281208.11437041392524040365.stgit@bmoger-ubuntu>
 <46d00211-e6e2-a0d9-22ca-ee0d3ca15468@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <46d00211-e6e2-a0d9-22ca-ee0d3ca15468@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0242.namprd03.prod.outlook.com
 (2603:10b6:610:e5::7) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH2PR12MB4135:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f9ef68f-2849-41b3-67bf-08dacd8189d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PqivIVXAEs+WjFw3mNYl3R+/DvwWe3ghSiZ/tP/UG1grhGJbiTmmBkQLbheIs3scAWzmz/m880r9M2gsRFSLygMld5mhioatp69IMeYkxTjjsaLHwPEilBHOBxtL6Yfrj5WdzaN2C0jprtx2/o96+NWfyyp/H7xPvaITAKQZkZPZEmv7ZANVbdffViuJRGO6kibaWABuwn2lbRexLIPxWI2Nwjj3wDgP/pFWPKWyyN1lFiJ58OZSC4GCFRl4j9yoossPcIqNOeYHJALF2FjrRDvinnnxzABdY1jJL+WWcbU3MQYGueBPUuQgtHnA8Rg1iYZprX6uymszDDft3CEMr0PNh0zIqotyU9onkaVmGkyBGryYiBf+dni8A//tte6b8HfMLTgyWCLkPvfZXT1l/kjImSMUk8e/6KDDTNqi3+yIiEvUqBvX6zDEA+68kg+YIn/ynYeiW/xXxulIn3jpbIwjT2guw8imFItgbFSJ17Jz75Z93bZ+KL+uMp+5GA1OD+/hEuWIxSfEygmd7QeXbOiMjSqQs/+koVcZb+fnMW0Y6eOtlW22W7XDuDpY8cxwfxW38CaKS1Cvfz/WRGaVGSZZ6/64j4W4mmOy6m7Q8MPvpVxXsF0FD3Mz4Yln3D6C72sUh1WCLVRlz1njdcyTkh+Tytc8cFK5K3xKNrbKZPkd5wLU0xnYFRaRSPFqF52c//0YCQyhFRuzdfDllmuHhJFy4QBRi2CXURFYEsBH0SI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(451199015)(36756003)(31686004)(41300700001)(38100700002)(31696002)(2906002)(86362001)(83380400001)(66476007)(3450700001)(66556008)(8676002)(316002)(66946007)(4326008)(186003)(26005)(6486002)(478600001)(8936002)(7416002)(5660300002)(6512007)(6506007)(2616005)(6666004)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWlhM3RGNFhQYnlQUlhJSFdlRzREcFlOZkZmZzJVdnBXOUxiVnhyOVM5ZUFi?=
 =?utf-8?B?ZFRSWUc3ZVR5RzA4SWx6eUtnYUxDa1phU2RRUkdhaWNaK2JvTXFMcWxSbnFG?=
 =?utf-8?B?SjUzRlhHd1JRU0dwa1pLTUVvemhDaUtkeEJWK25zQTZRUDdCQWxPN0NZQ2d0?=
 =?utf-8?B?azlSZVhtbEIwaTdOSUpMNkQ0MnI5NjF1TlpwT2Y4L3hWL1FzWk10QnZQd3hh?=
 =?utf-8?B?Yi9vVlF0aVU5TTlUUmQxcUZiKy9rYVhUMmJaOHY4bHVwM2wrUi9LbFVlR0I4?=
 =?utf-8?B?eWhvQ3pSdmlTZmZlaUErZGxDNTcrdUd1TDE3NjhmNDJzVklqbGhBWlhudEhV?=
 =?utf-8?B?M3RKL2h4UElNV0xwODlsQXlJbThObDg5eHJaWXNCSEl3dVVUVzAxNHJrNFZa?=
 =?utf-8?B?dVppK2FuMERKcFdtWktpV3IyZk5nUzF1K3VMQThiN0xNdHZkTW9TMEwvMUd1?=
 =?utf-8?B?QXhST0cyN2hNU3VSRit4VmRYaVhlM0NEN09KK3Y4K28vT0tQTjYxL3c3VTlh?=
 =?utf-8?B?aGlBeUpvMXFsKzZVcTdTTjA3ZnFHUVY0RGRMTE1rYjU0VHVqRVM2cjAycmZK?=
 =?utf-8?B?QWpuRmwzUWRFTUMvbldZNDNvZFl0WUF1eTE4Y2s0b2xXclJJOFJtQU5aYVFS?=
 =?utf-8?B?MnhHVlY4andPbWpHeTMzZWg0dHg4QUkvNm5XcEI1YVFpRWQ5V2NmZDRuLzNk?=
 =?utf-8?B?a253VG9LdVltSGJjQ0JWdWxDbHhad0xVaUhjbmhpZ2dFWFF1Z2hwRlR5VWk2?=
 =?utf-8?B?emhUMEJiTGVjaHBqS3M0ZDlFM2FiMFhsaTFRV2Fxc2tyM3FHdm84WE9aNEVr?=
 =?utf-8?B?VjVhZWdEa0ZWSTBnU0VQeFVteThQSzdIVjZRNDJmTjYvUEVKUXR0Z011eEhj?=
 =?utf-8?B?UjBOMDVSaXFGVFdQRzF1d2VvbElFNmFjMzBiWjVyOWFTYW9PRGV6UUk0VGJR?=
 =?utf-8?B?VWFIM29rWGlKL2VJMitTNmhCRlZBQXhYWENnU3J1eHlSZk1QQmhtZnRIbytE?=
 =?utf-8?B?S0gzNmlUbzFaYVBHM1Zzell5S0JuZUZVbUp3TDg0V0JsSVJvT0xxaFlnSlpr?=
 =?utf-8?B?SFNMNjdEUVk2Q0YyNkl0dmZQakVGbTB0TVN1R3hzcTRyWENONWg4cEJBWFNa?=
 =?utf-8?B?cG5IeUhyRTdmQUhnRjlYUzRPajJsS3haNXlYd1pXRkVFL3FCOHNITTFlUzJF?=
 =?utf-8?B?bjFiZW1MRnBHV0x5NXRBWmhpemdWVzh1WUpDZklvU3lXajlubGNNaTVoV1lY?=
 =?utf-8?B?Z3BNTWZJdG94WWZHRDJsbXFoVlJzY2JvN2FBMHJHYSt3V0IwR2NpUklGdXM2?=
 =?utf-8?B?ejhpNWE5N1cwTlVIdWdtelU2bWE2YjdlOVVQenpkT3FaQmR0NUhCQ3ZLUjBl?=
 =?utf-8?B?WlpPV242LzNqa2hTdkN0U0Rueks4RUlZMm8zejBkSVRYK3J5MVFzeU9VRFZk?=
 =?utf-8?B?TjV6UUpQZW1DVmU5T2huaUtuT2VmY1Nwdlo3U0VDdWt2ZExkTW93YWc4cjUx?=
 =?utf-8?B?U1kxa3didHhCaldEZ1RLWXRSMUtIZVE3ZWR6Y2FWOEZSVDN3dUF2Mm5sRHda?=
 =?utf-8?B?bHVldFpuQ0NaeHVoanRRYk9td2xaR0tEWHBEdmpqWnBjQ2dBcjdXSnI2UHl4?=
 =?utf-8?B?TmE3a2N3R0dIRDBENkNaT1ZNaS84NkxVdERTTGk2aHZpQWhta05SUXJZSGVL?=
 =?utf-8?B?ck01cmwrS0FDNHlSVHh1MzIyODFWZGozcGtzVitIZTFpNDBKUTA5SE9Xb3hS?=
 =?utf-8?B?ck9rbGYvbWRLOWwvTkRyYy9nZVh0RjNHNTB4WlRpMFdwcUlKdXcrQUIvTkpN?=
 =?utf-8?B?aFpVTXJyYk1kb1BDVHJqMTBNNlZsQ012WHZzYml1dUgxWncyMm41d2FqWVdu?=
 =?utf-8?B?VUJmSTQ2TngyU3ZzM3VxTWNtTnJjNzJEZkt0YkdTT1FaK3JaWGtZektRMWEw?=
 =?utf-8?B?NlZxNEU0YVFUSG9JNXYybnk3alJvanJTcVVQSHdJSWx5RnFObnllV0tmUk9y?=
 =?utf-8?B?dW5SUHJmUzUwekFCbDNwWlZyWWxzSkx2TjdCMDRmL1JML2IybXZQUHZiUnJU?=
 =?utf-8?B?N1RxcHljbzJhMlY4Tk4yd0psVVdWQXRGVENmazZqSWVXcWVTOXEvWmVmVnFr?=
 =?utf-8?Q?AO7w=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9ef68f-2849-41b3-67bf-08dacd8189d5
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 18:35:48.8609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cDiK3gacwlXuPeRdzdQmgYXOx/WpTwlprydX1kAwGa5wJvnSZF499qlUPM62sKiB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4135
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,


On 11/22/22 18:19, Reinette Chatre wrote:
> Hi Babu,
>
> On 11/4/2022 1:00 PM, Babu Moger wrote:
>> The current event configuration can be viewed by the user by reading
>> the configuration file /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config.
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
>> By default, the mbm_total_bytes_config is set to 0x7f to count all the
>> event types.
>>
>> For example:
>>     $cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
>>     0=0x7f;1=0x7f;2=0x7f;3=0x7f
>>
>>     In this case, the event mbm_total_bytes is currently configured
>>     with 0x7f on domains 0 to 3.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  arch/x86/kernel/cpu/resctrl/internal.h |   28 ++++++++++
>>  arch/x86/kernel/cpu/resctrl/monitor.c  |    1 
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   87 ++++++++++++++++++++++++++++++++
>>  3 files changed, 116 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 5459b5022760..c74285fd0f6e 100644
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
>> @@ -41,6 +42,32 @@
>>   */
>>  #define MBM_CNTR_WIDTH_OFFSET_MAX (62 - MBM_CNTR_WIDTH_BASE)
>>  
>> +/* Reads to Local DRAM Memory */
>> +#define READS_TO_LOCAL_MEM		BIT(0)
>> +
>> +/* Reads to Remote DRAM Memory */
>> +#define READS_TO_REMOTE_MEM		BIT(1)
>> +
>> +/* Non-Temporal Writes to Local Memory */
>> +#define NON_TEMP_WRITE_TO_LOCAL_MEM	BIT(2)
>> +
>> +/* Non-Temporal Writes to Remote Memory */
>> +#define NON_TEMP_WRITE_TO_REMOTE_MEM	BIT(3)
>> +
>> +/* Reads to Local Memory the system identifies as "Slow Memory" */
>> +#define READS_TO_LOCAL_S_MEM		BIT(4)
>> +
>> +/* Reads to Remote Memory the system identifies as "Slow Memory" */
>> +#define READS_TO_REMOTE_S_MEM		BIT(5)
>> +
>> +/* Dirty Victims to All Types of Memory */
>> +#define  DIRTY_VICTIMS_TO_ALL_MEM	BIT(6)
>> +
>> +/* Max event bits supported */
>> +#define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
>> +
>> +/* Max configurable events */
>> +#define MAX_CONFIG_EVENTS		2
>>  
> This max being disconnected from what it is a max of looks like
> a source of future confusion.

ok, Not required anymore with your suggested change below.  Will remove it.

>
>>  struct rdt_fs_context {
>>  	struct kernfs_fs_context	kfc;
>> @@ -542,5 +569,6 @@ bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
>>  void __check_limbo(struct rdt_domain *d, bool force_free);
>>  void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>>  void __init thread_throttle_mode_init(void);
>> +void mbm_config_rftype_init(void);
>>  
>>  #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 06c2dc980855..a188dacab6c8 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -787,6 +787,7 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
>>  	if (mon_configurable) {
>>  		mbm_total_event.configurable = true;
>>  		mbm_local_event.configurable = true;
>> +		mbm_config_rftype_init();
>>  	}
>>  
>>  	l3_mon_evt_init(r);
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 8342feb54a7f..dea58b6b4aa4 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1423,6 +1423,78 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
>>  	return ret;
>>  }
>>  
>> +struct mon_config_info {
>> +	u32 evtid;
>> +	u32 mon_config;
>> +};
>> +
>> +/**
>> + * mon_event_config_index_get - get the index for the configurable event
>> + * @evtid: event id.
>> + *
>> + * Return: 0 for evtid == QOS_L3_MBM_TOTAL_EVENT_ID
>> + *         1 for evtid == QOS_L3_MBM_LOCAL_EVENT_ID
>> + *         > 1 otherwise
>> + */
>> +static inline unsigned int mon_event_config_index_get(u32 evtid)
>> +{
>> +	return evtid - QOS_L3_MBM_TOTAL_EVENT_ID;
>> +}
> It seems strange that the validation of the index is split
> from where the index is determined. I think it would be easier
> to understand, and reduce code duplication, it if is done together.
>
> How about:
> #define INVALID_CONFIG_INDEX   UINT_MAX
>
> static inline unsigned int mon_event_config_index_get(u32 evtid)
> {
> 	switch (evtid) {
> 	case QOS_L3_MBM_TOTAL_EVENT_ID:
> 		return 0;
> 	case QOS_L3_MBM_LOCAL_EVENT_ID:
> 		return 1;
> 	default:
> 		/* WARN */
> 		return INVALID_CONFIG_INDEX;
> 	}
> }
>
> What do you think?
Yes. It should work
>
>> +
>> +static void mon_event_config_read(void *info)
>> +{
>> +	struct mon_config_info *mon_info = info;
>> +	u32 h, index;
>> +
>> +	index = mon_event_config_index_get(mon_info->evtid);
>> +	if (index >= MAX_CONFIG_EVENTS) {
>> +		pr_warn_once("Invalid event id %d\n", mon_info->evtid);
>> +		return;
>> +	}
>> +	rdmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, h);
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
>> +	mutex_lock(&rdtgroup_mutex);
>> +
>> +	list_for_each_entry(dom, &r->domains, list) {
>> +		if (sep)
>> +			seq_puts(s, ";");
>> +
>> +		mon_info.evtid = evtid;
>> +		mondata_config_read(dom, &mon_info);
>> +
>> +		seq_printf(s, "%d=0x%02lx", dom->id,
> This is a u32 ... is just x sufficient?

I have added 0x%02lx to silence the compiler. Not required anymore.


>
>> +			   mon_info.mon_config & MAX_EVT_CONFIG_BITS);
> Please do this masking within mondata_config_read(). It should
> not be required for every mon_config_read() caller to validate the
> data because they may forget (re. patch 10).
Sure. Will do.
>
>> +		sep = true;
>> +	}
>> +	seq_puts(s, "\n");
>> +
>> +	mutex_unlock(&rdtgroup_mutex);
>> +
>> +	return 0;
>> +}
>> +
>> +static int mbm_total_bytes_config_show(struct kernfs_open_file *of,
>> +				       struct seq_file *seq, void *v)
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
>> @@ -1521,6 +1593,12 @@ static struct rftype res_common_files[] = {
>>  		.seq_show	= max_threshold_occ_show,
>>  		.fflags		= RF_MON_INFO | RFTYPE_RES_CACHE,
>>  	},
>> +	{
>> +		.name		= "mbm_total_bytes_config",
>> +		.mode		= 0444,
>> +		.kf_ops		= &rdtgroup_kf_single_ops,
>> +		.seq_show	= mbm_total_bytes_config_show,
>> +	},
>>  	{
>>  		.name		= "cpus",
>>  		.mode		= 0644,
>> @@ -1627,6 +1705,15 @@ void __init thread_throttle_mode_init(void)
>>  	rft->fflags = RF_CTRL_INFO | RFTYPE_RES_MB;
>>  }
>>  
>> +void mbm_config_rftype_init(void)
> Does this need __init?

Not. Required. Will remove it.

Thanks

Babu

>
>> +{
>> +	struct rftype *rft;
>> +
>> +	rft = rdtgroup_get_rftype_by_name("mbm_total_bytes_config");
>> +	if (rft)
>> +		rft->fflags = RF_MON_INFO | RFTYPE_RES_CACHE;
>> +}
>> +
>>  /**
>>   * rdtgroup_kn_mode_restrict - Restrict user access to named resctrl file
>>   * @r: The resource group with which the file is associated.
>>
>>
> Reinette

-- 
Thanks
Babu Moger

