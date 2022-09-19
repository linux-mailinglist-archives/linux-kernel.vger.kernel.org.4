Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588575BD298
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiISQwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiISQv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 12:51:28 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82153E77C;
        Mon, 19 Sep 2022 09:50:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXDXjZdqWZj7l+/SR/8/woy0gEWnt4MRkuGURkQ9gPM8sgdID2l/B2KWW7EUdIF+yyFRFH2NF536BISUgqr4jO/xJfEax6WGWizjl1zSrxkJtNVqYrMYCat6tgmsW7RzTyWpURO/dZ02FttkM31YTywNkCFFMdZ5FrKuLFc978j0d0E31eW7IbTki+GaK6hUSqiYy8WwBF84O5pF0QjZ+7CIThoZoi3bJnB9XVhSPDaV8WkFYivTtPG1JgFRv6Aojyrben9ek3fR8jEByH5cbTn+LYC8tIQ/I7S+W9XB4twHPkwBysipVcUM9trTRu2Uq0hIwFkKRuKoT/9NwvxFeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StxzaFq0Yey9oKWHwOM5HIAtfUHzZQ85bBdwE2faQwo=;
 b=mOpqXnIlc1cCObFT2hQqFEec6+T5MDR6/Ia6tcfXTPegIg1QrRRUNIcuEcq+BIhYIVlGu4gpthBXerTSyjU52GfCWz8sv7TIzTop0PYJqB1QwPyQyXLI+5KRyfuqXTPwCynEpjWSr3gI/YJ9jeAaTpE1eN9Sf4IpS6E8HpefwauiAbxy6miQ/qHfbAe/Oee5YvL3vGKwK/b9DljUxvKS+OIouUrVF4VF2BrzojEZNVDdoH+RuGnWkSf0tqzdb3QOHESvVEUagCe5Q0MlkyFJfmvAQr50vLTmaGUCZuHSC4FrGpSt11dfA1kgYy8T786QJJHD127ONEB8O8Y9DHGS2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=StxzaFq0Yey9oKWHwOM5HIAtfUHzZQ85bBdwE2faQwo=;
 b=cYjBzP3aMli8z3CP5QdKpEo927Dl/m64hbXpeDnv+QW3JBLw/xC27Lun0nOYk6oqpc+HjuotWJtPtwZ5cuPFi+w3bCL1MDUbTEVErOFbOe7c5ISRhgx67FhjD+jxBJdCAv45A+yO54+ivG/+v1WIKt8Wa5/3Sbi45/8u+zvRMcI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BY5PR12MB4164.namprd12.prod.outlook.com (2603:10b6:a03:207::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 16:50:20 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::4120:60cf:46a8:7109]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::4120:60cf:46a8:7109%7]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 16:50:20 +0000
Message-ID: <3511f4f6-d043-9a22-7779-af2c2983b6a2@amd.com>
Date:   Mon, 19 Sep 2022 11:50:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 11/13] x86/resctrl: Add sysfs interface to write the
 event configuration
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
References: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
 <166257367603.1043018.15774268739007323339.stgit@bmoger-ubuntu>
 <32cfa982-037c-6edf-702a-c59d9c5d2f57@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <32cfa982-037c-6edf-702a-c59d9c5d2f57@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:610:b0::27) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|BY5PR12MB4164:EE_
X-MS-Office365-Filtering-Correlation-Id: 080c3247-6291-4d88-e3bf-08da9a5f09ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eSIx9Nffphca2d933ebIwfBjZCOPC/KWLHPp9aldMeoVz1D0Qb4BUFDOUIhjGUer+3hPppy0zPQjCxaIn7I67b0gGqPNyo7wPuhv0hL4BW6YuZnu3cZAdx34Oo5OqKDdkLCYU/iJRgKFD/BKevsJtzpDbIiLR8tAPEi9Fc+3sQohWG9BJYU+SyetK1SQol21L0e7y3ypCOzTQEXTEo6RGDptVaD9s7uz5ZiKh8OYtoJCSNblObGNdYmKjwEXbt/95ZFLAFitr/VtE8CZ2jYNVC9i2csYczW2EXqWzrMILsahpxSJL04Nagktpj9Vx7FvcZIAE2rNUPTzznFsf3KmwfE/QJvx2WDvAmym6UAM07sFX82E32EKHGJViyd/b2XC5aGHwtRfeICSadWw0RJdtxIrSjrqt4jtECaPBINCHNpvqllo412jMXYK0QmS5uA5dBZT9tAdFYVxQVU2hwAnLfYZIbHLEtRuMzz4KJzA0KnsmBfMKOdsZf8wLrz602epckiQUEJ2h1PwYYQkJRwKp9pbNTNx/Yih5L1L9wX3B0yUkilYuHqzLkPn50OIlvo2b8KmU5IsLw8KNCI5Ve254xNCWISXXRp8yvbPcWWt3XFl2TkoYZqhdgrtLAahRKoGl8djdAvC9/qkowr3BbyrUXTyD6DQj6AEmQTTc7uu819M/60pR4H8Nyx5v8QN7twNZjnruYyOAYRk2rcjZi8V+BeB4gwmrGUgPZR/H1jOESOurtW8++MtaSGiHDulhDzutgLJMIwYbHkWnWdHWZGQjavYByKiSyjCTe0t6OFTVLk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199015)(6486002)(36756003)(7416002)(66476007)(66556008)(2906002)(4326008)(3450700001)(8676002)(31696002)(66946007)(86362001)(5660300002)(8936002)(38100700002)(316002)(26005)(31686004)(6512007)(186003)(2616005)(6506007)(478600001)(83380400001)(6666004)(41300700001)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yi9rTmNQSEdmUGZtTXp4bzJjSFBPbEY1UFo0UTQxRXdBMm1adVA0bFhkbWNY?=
 =?utf-8?B?K1lqNWU4bFNMRDZTa0hhYktZeXozY2RVaFk1WWt2MFNDTXIxNEhTdnQvbTlD?=
 =?utf-8?B?UnNodm9HVk9DeVcxTHlDbzdLajB0UCs4bVMwaDZyaklVL0Z1YUdMZmcvVk9L?=
 =?utf-8?B?L3d3REVtNW5WNURPSkNPbWt3K3pIMkxxUlVDYXlJdjBKcGQxWmJqRW5LS3Mz?=
 =?utf-8?B?TnhFSHdhUmp3UGlWWEtFSDZJMUVmaUtLejFSdU1jMkQzV3hobFd4MTFGOWgr?=
 =?utf-8?B?dEhNWWdqQjBSNkQzRytrOFNLK25PY1hvdGkyT1FwRUFyc0x1MXdKRXdvVmta?=
 =?utf-8?B?Q2ZKVHhGNi9qWkVTdUFPZjBjYjN6TVAwcVhpbzRCVU1HTlJ0Wk5lNm5saUVU?=
 =?utf-8?B?UHVMZXM0OXlJblJMRmYxdnB1QXN0YVcvczhNTG1sS0dIb2tmZjJGZTRsdHhk?=
 =?utf-8?B?ZW4yRjlsVXpKTi9KbVJXbTk2OHJOR3lkaGtaUUpraW00TEdyZy9xQlpPOHNR?=
 =?utf-8?B?WGhBYjlXMnpGb3ZUekFxL2N3bHEycDZjSGFiRHVqdzdmZk85bXR5TUhWdTA4?=
 =?utf-8?B?VlIweXM2UW1BU21Tazk5c2l1MjRuTHFnR2Nib2UzM3hsNDVNUlhDTGhBT2Jx?=
 =?utf-8?B?TXFxcS9qcjdRc0VrcDJRQkNhbTdFR3phSyswc0F1Yk50bDZldEh5SjVzS0xB?=
 =?utf-8?B?OURZZ09DS3B5cEV2ZEorZUdLNnJyOW9uUHFudkpuMEhmK254U0QwTzRmdVdX?=
 =?utf-8?B?UE5QeFkvVHVmYUlpY3ozclVJNGFJaUM4ZjBVT2llSlpadkR5cFI2OURLMWVn?=
 =?utf-8?B?MmFKYmtwQ3VxQ1NHY3l4UDgvcGlGeitvU2tiLzZPWkt0TDR1enh3VC9YL0Rq?=
 =?utf-8?B?VEhEOHVWQkVzYWl4MXNDdVVGRDlqTk5FTCthb2RaZW9GNldMbzVaR0FoSlRk?=
 =?utf-8?B?NXZrZE01dGo1bU16bmk1cXZvczVZTzZvWnJja2lUcmFJOEs1LzRqMTFsR0Zm?=
 =?utf-8?B?bmYzdjJSL25CV2dFODZJUnQzVlNsc2o4dzBmeEJLMlV1ZGR1cXBGR01lZGZL?=
 =?utf-8?B?OUJMMmFzY1ErUGlaM1lNWnI2alVXSW9PbGlKOU1PbUNrOW9LSDVVT3ZqOUxU?=
 =?utf-8?B?azlwVFhSb2MrR1U4KzFPREhkQldBK3BOZDkvUUpDTzkvZDU3L3cwSEtqNG9G?=
 =?utf-8?B?ZDdVb25xQnV6S0dEV2dVUHJMNm9XbnRQU3ZrT0cvU3htUU9VMEsrRVloTW5R?=
 =?utf-8?B?VlBQUzlPK3RRN2hlK1FLRmtLTzBxMnBmSmtTdFY5QTNPdThCeEpaM1d3VE9s?=
 =?utf-8?B?ZFI5cXhUaDl0ZlY2emxMQXJjckdFb1M5Q283SWVta1RpeERONHBvZko4bzRs?=
 =?utf-8?B?emZaZkNLdzF3WUY0VmFiZTMrZnFFeHlZWTVGNEY0ZTFXak9kVTdPSFdmeG8y?=
 =?utf-8?B?N2l0U25YK3VKQTRxQVVUSnExR0luQm8rNmZFekJDcmdwN2ZSbGF6N2o5RkZi?=
 =?utf-8?B?WjFyNkh0ZlM5WC8vVURjdkdVNTVmeHNsL3M3OHAvQ284dlk1a1BBZE5VSnhQ?=
 =?utf-8?B?RGtuamdDWVlBUGFORnZUQ0o2VDJWS2dGR095ZVRRNjVEZXdsU0J4clIybWYy?=
 =?utf-8?B?WEUrcDEwM3hKMTBqc056cGlUNGxFaGlsWC9rNTZubWxHbW1PbVZMcklJZVRk?=
 =?utf-8?B?M1Z0MlE1eFZMeFNtTFRiSmIyNENoN0VVWVJqUCsxanlkSzc2eFhXUXdMOTVY?=
 =?utf-8?B?WFlvRTlJT1crdHlydGRLU0ZKbDdBQnByc1VZWlY5dHB4cHIrZmJ6dEplNCtT?=
 =?utf-8?B?WjF3bFdZYis3YVVMNEIwQ3lqdXR6Vk05VkJjS1M5Y24zdWUySDAyWlp3YXJl?=
 =?utf-8?B?aU4rWHI3ZjNzU1I2b1ZXWWNkVjBkR2ZuWHM3RXMzR1c1VFlsYjgzaURRTzd1?=
 =?utf-8?B?aTRESkR3SWJDK3BCODBoZCtoYkZLa2QyU2VlZ0Z1L0hPTWEyRFlnQWIvVUZI?=
 =?utf-8?B?bXlXS0JQK1I2OW1DaGk5ZHFOM05ZUm5jY3lLbFkwb3dtTFVYUWtyWS94VGxD?=
 =?utf-8?B?RTNjOFc2Y1o1bjRWM01Ta1BOQ3pmNko0VExXMzU0dnU0UjhCRm1ROVMzdEo4?=
 =?utf-8?Q?15glOV7ObPcPgN7C9btULSQkF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 080c3247-6291-4d88-e3bf-08da9a5f09ba
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 16:50:20.4816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mR8movr8E5u/vuL1WI+nXybtxgtMKK7fshQxaxnjps5JMYVl2b8+x+W8ZslIDsbW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4164
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/16/22 11:17, Reinette Chatre wrote:
> Hi Babu,
>
> On 9/7/2022 11:01 AM, Babu Moger wrote:
>
> ...
>
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 6f067c1ac7c1..59b484eb1267 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -330,9 +330,121 @@ int rdtgroup_mondata_config_show(struct seq_file *m, void *arg)
>>  	return ret;
>>  }
>>  
>> +/*
>> + * This is called via IPI to read the CQM/MBM counters
>> + * in a domain.
> copy&paste from previous patch?
Will correct it.
>
>> + */
>> +void mon_event_config_write(void *info)
>> +{
>> +	struct mon_config_info *mon_info = info;
>> +	u32 msr_index;
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
>> +	wrmsr(MSR_IA32_EVT_CFG_BASE + msr_index, mon_info->mon_config, 0);
>> +}
>> +
>> +ssize_t  rdtgroup_mondata_config_write(struct kernfs_open_file *of,
>> +				       char *buf, size_t nbytes, loff_t off)
>> +{
>> +	struct mon_config_info mon_info;
>> +	struct rdt_hw_resource *hw_res;
>> +	struct rdtgroup *rdtgrp;
>> +	struct rdt_resource *r;
>> +	unsigned int mon_config;
>> +	cpumask_var_t cpu_mask;
>> +	union mon_data_bits md;
>> +	struct rdt_domain *d;
>> +	u32 resid, domid;
>> +	int ret = 0, cpu;
>> +
>> +	ret = kstrtouint(buf, 0, &mon_config);
>> +	if (ret)
>> +		return ret;
>> +
>> +	rdt_last_cmd_clear();
>> +
>> +	/* mon_config cannot be more than the supported set of events */
>> +	if (mon_config > MAX_EVT_CONFIG_BITS) {
>> +		rdt_last_cmd_puts("Invalid event configuration\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	cpus_read_lock();
>> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>> +	if (!rdtgrp) {
>> +		return -ENOENT;
>> +		goto e_unlock;
>> +	}
>> +
>> +	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL)) {
>> +		ret = -ENOMEM;
>> +		goto e_unlock;
>> +	}
>> +
>> +	md.priv = of->kn->priv;
>> +	resid = md.u.rid;
>> +	domid = md.u.domid;
>> +
>> +	hw_res = &rdt_resources_all[resid];
>> +	r = &hw_res->r_resctrl;
>> +	d = rdt_find_domain(r, domid, NULL);
>> +	if (IS_ERR_OR_NULL(d)) {
>> +		ret = -ENOENT;
>> +		goto e_cpumask;
>> +	}
>> +
>> +	/*
>> +	 * Read the current config value first. If both are same
>> +	 * then we dont need to write again
>> +	 */
>> +	mon_info.evtid = md.u.evtid;
>> +	mondata_config_read(d, &mon_info);
>> +	if (mon_info.mon_config == mon_config)
>> +		goto e_cpumask;
>> +
>> +	mon_info.mon_config = mon_config;
>> +
>> +	/* Pick all the CPUs in the domain instance */
>> +	for_each_cpu(cpu, &d->cpu_mask)
>> +		cpumask_set_cpu(cpu, cpu_mask);
>> +
>> +	/* Update MSR_IA32_EVT_CFG_BASE MSR on all the CPUs in cpu_mask */
>> +	on_each_cpu_mask(cpu_mask, mon_event_config_write, &mon_info, 1);
> If this is required then could you please add a comment why every CPU in
> the domain needs to be updated? Until now configuration changes
> only needed to be made on one CPU per domain. 
> Even in the previous patch when the user reads the current configuration
> value it is only done on one CPU in the domain ... to me that implies
> that the scope is per domain and only one CPU in the domain needs to be
> changed.

Yes, This register is domain specific. However the hardware team
recommends it to update on all the CPU threads. It is not clear in the
specs right now.

I have asked them to make that clear in the specs next time.

>
>> +
>> +	/*
>> +	 * When an Event Configuration is changed, the bandwidth counters
>> +	 * for all RMIDs and Events will be cleared, and the U-bit for every
>> +	 * RMID will be set on the next read to any BwEvent for every RMID.
>> +	 * Clear the mbm_local and mbm_total counts for all the RMIDs.
>> +	 */
> This is a snippet that was copied from the hardware spec and since it is
> inserted into the kernel driver the context makes it hard to understand.
> Could it be translated into what it means in this context?
> Perhaps something like:
>
> 	/*
> 	 * When an Event Configuration is changed, the bandwidth counters
> 	 * for all RMIDs and Events will be cleared by the hardware. The
>          * hardware also sets MSR_IA32_QM_CTR.Unavailable (bit 62) for every
> 	 * RMID on the next read to any event for every RMID. Subsequent
> 	 * reads will have MSR_IA32_QM_CTR.Unavailable (bit 62) cleared
> 	 * while it is tracked by the hardware.
> 	 * Clear the mbm_local and mbm_total counts for all the RMIDs.
> 	 */
>
> Please fixup where I got it wrong.

Looks good.

Thanks Babu

>
>> +	memset(d->mbm_local, 0, sizeof(struct mbm_state) * r->num_rmid);
>> +	memset(d->mbm_total, 0, sizeof(struct mbm_state) * r->num_rmid);
>> +
> Reinette

-- 
Thanks
Babu Moger

