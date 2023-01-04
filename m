Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD0565DB8A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 18:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239900AbjADRuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 12:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239978AbjADRuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 12:50:05 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EB91A22D;
        Wed,  4 Jan 2023 09:50:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUide4LHyS7w8veAUOKMHFCDaqQnvdATQc2cqC7NXnmcMaC92e7JWxP+xnPrQxhs457ffxFz6vcYaMShEmYR8rtCtM77r2/gjkpg4tF0Qjc9+pMsSEs4iqENt8OQ9pCkXrc/IGLjQeMHOX8UxbZSEStQYBQTbio5BK1Lmo9g7m5RLKMofiPxrjp2QooKdOU/CGqdjgJ1Ksz6Q7ssuJOCLdsK+0lcWyBfHHv6bo7iwxAD3i1lssqM7oAVd1+7mbbjAms+yg+XKYX8GeAbkDAX+yH09CRboxcTarL70OxgHSVBP4q30VKw8IaqKfZ46WKNr/FHNWfRzJmcKJwVMXmnIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2m1WUFo5wB53ZcjiIghE7LiaVGLaUEnnA7tBDmvYdMU=;
 b=lJchUsC7Zds0Yti6zC1cf87LKI2Qfmv+Ccs0QjtmBhVrFS4bNujqHoNxqnwKyU+BlceKnyqGB+cA7oGT4ZtQVCFyL2JmXlVb6m1ZXSRNnE3bc3rD93eFE7ZBBowXsduxCTLcd1PcCR0ZGhRiKKB4WUJ0KTn8/6LVoWrAf023xYxGKdmhh0aYbUUSIbk10nEzj6PqZiChvNs1eaSX2PItfRYVzNvlzh6TeShoGL0s13R9u/4Vp9+nF47OZoY0If41Gi4aVhQPs85Nq4ezH5kkEvNQCiLW62agmTystc+lOHFcUKd2wihhk1qsjRF3wRME175VUPENsUvWC6XLn1H9TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2m1WUFo5wB53ZcjiIghE7LiaVGLaUEnnA7tBDmvYdMU=;
 b=5Rp4h1WcV7Z/BfSYprl1UZVENI0ZjqhPd9OmXYxEpkvNMaH+jI75KLpnDbLz8+kmc0VkmmpyfyZwxhkiUHIxUhRGYxooQpG9MzIhMWibt6dkVjRfbrA+xN40OqNGqTnz1JjPB5auopnbohDTBRjyiaxe9GvW7Y3QVqOEpIcVKps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 17:50:01 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%3]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 17:50:00 +0000
Message-ID: <e3b5286f-469e-90ba-e4a9-09153c9562d4@amd.com>
Date:   Wed, 4 Jan 2023 11:49:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH 2/3] x86/resctrl: Move the task's threads to the group
 automatically
Content-Language: en-US
To:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "peternewman@google.com" <peternewman@google.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
References: <167278351577.34228.12803395505584557101.stgit@bmoger-ubuntu>
 <167278360189.34228.2442698916556329960.stgit@bmoger-ubuntu>
 <IA1PR11MB6097CF779BF29E7F716108849BF59@IA1PR11MB6097.namprd11.prod.outlook.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <IA1PR11MB6097CF779BF29E7F716108849BF59@IA1PR11MB6097.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:610:b3::27) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH2PR12MB4198:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a83a0b1-e19d-4a45-ccd1-08daee7c1a14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rByuooBGftkU0rVlb9J0KSCyqtS89YtKVhAsD+luJOx370oAZNUsRlII2vDLGWN/dUplegyMoCaNjWIjMhYzH4Q85FGSmLbphvZra4IXMpTzVmveyq9TIasPgtfKApbcgnuPgSTidBVt1nLaO8N6eSfsdG6KRcjXlkVdqCdcRyZzsdlWL/cmDX+nSg4mR/CdWi+tmc6PWlKxZWmhryDS1wDwrwG697hDkRlZbvEOsUCOlptxqe+GpPXcyzwkbkdKpzQSl7O6at6+caVHE5QdDgyUe3xsyJz438P77c8Gmg9CRaxIFDJjtenjmuWmJqp2F6Ab3FxpJ8cBbDkNzkc2lrLbHz0kl+ibiqXelcqZpyYMjaa48R2C846ci9BqDrlQSw+yGuVaWOgbm/Fj4x/hpjAKFZwkzEIJi14hv7aoh7Gs2Bu7xq0g57InznOoPP9JJV/48N5hieoOsrPggguFUCI/I4LP27iJQZTCdGuTINpZPVHJBxaZwhyQWQHGU9Eu8iyMOoiL0WdSzh3pTtddFiK0NwudmZxzDI4gTpPisriaHzqp8llQkih3yJibuif5KXRcdfu1wgFMGzIblstrLcBW+U4olT4FwQyUoTL7urM3XXQbxFlyEEBxc8zRffmK5ep8cLJ6J/7vc416ALPxcColxbMiKV7gmFscjM1gguhJTjL+aw6/64BQtZSsP9dqDf0JC0hWue2flkr1K7AWdsiJqZVZdtZTa7GWXDvdO3A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(451199015)(83380400001)(6512007)(26005)(2616005)(186003)(53546011)(6506007)(6666004)(31696002)(86362001)(36756003)(38100700002)(478600001)(8676002)(4326008)(41300700001)(66899015)(3450700001)(2906002)(7416002)(5660300002)(8936002)(31686004)(66476007)(6486002)(66946007)(316002)(66556008)(54906003)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0xKVkNWOUFDUXV4RU5yNDc5bnZuNURTWHZZZysyZk0wcDJ1OUhQZVdnMWtD?=
 =?utf-8?B?Tk1PVmVyVTNrUzRLRm5zeXFCUXowN3pvQ25aT0VYcFoxRE5nU2pabUNXY05F?=
 =?utf-8?B?a2NBSWM5WWszNDg4WHJCZzZVT2RmS2ovWHdOR2kvMC9Va3VrY1gxK0ZzcldP?=
 =?utf-8?B?N0dua1NZT3JPLzJ4dzZnZTNCeFliMHJZZEpXTVBXdzBOOGo5TzZhOVZFdW4y?=
 =?utf-8?B?TXMvS1RsSE1HQ1lYOTJXaVl0Rzh2RjF2Z29LcFRTNDJhUFVhemI0ZE14MnFG?=
 =?utf-8?B?RGpXVzJpVlF1a1J2ejFUV1VVYTFZNmlrM0JzNzcwc1JnNWt1aE85L3RaN2RH?=
 =?utf-8?B?YXdxU3F0NWZOUDlhNWc5aENLcDgyRUxpOWMyWjNNdlVyWmJTd1l5NklndnVp?=
 =?utf-8?B?YmxDNVdoRUpxb2hid0tyem1ZWVhSQVUwNnBVMUNCMGZOb1F4YmhKeE1HYmxL?=
 =?utf-8?B?b1dWTlR4NGxBTGk0TEk0SnJBOVlWWCtPcFhvaUJoT3JhSDRudHlOamxGcE5k?=
 =?utf-8?B?Z0lNM3pISXZVNGQyZVZIYVFsMXdxaE1CRXdHdERtYVdQSi92VTk1SGdEUG9j?=
 =?utf-8?B?eXFiay8xd0RGdjkzMlBHQXE3MFgzay8wZzlTb0RBMHIrWG1TMGxsYnpueld6?=
 =?utf-8?B?aGR0OXNEVmhuMHpXenBYdTVxZFRwY1FySFptbWhaMVd3Z09qSXpySWJITko5?=
 =?utf-8?B?dis4ZXhEd0czcHluQlNLc1Racy9IN3F3bVZNN2N1QWZoRnhlQmw4VlJUWEY3?=
 =?utf-8?B?Q20xaFVYc3REeWJwWURnOXlQRFlIcDJ6eWR1UDJjMWtXaitCMllWSzFGVkg1?=
 =?utf-8?B?MkhsbnpYVjVRa2xmM2hGRW1EUnhWcGU5SVVHRHdxdE5Zd1FQQlpNbDlULy9Y?=
 =?utf-8?B?TWFRVEQ4SnB6c09NelEzdHlJeW10aC9WV2tsK3RvbEpyOXJHRE91bllNUWFn?=
 =?utf-8?B?TGNoMVNDOWgxS2hrdEsySis2L1plS2xMQlAxazhwQ1RHSWJpY2ZNcGx3SnRo?=
 =?utf-8?B?NlVZRy9SUFlVaU5XYVlYTUUwdHVvazh2MkxhT01aT3AxbnFsVG1Hb2s2YktE?=
 =?utf-8?B?Q0ViWXp2SUFoazM1ZFRqekZ3eHJBSnVNRHhRb21RTFhkU0FuYm5zc0Vtd3p0?=
 =?utf-8?B?NlA4Z2xSOTF0REhETWZwRW16LzV0aldjYUpJY3RFRnpLR0RyRm1Od3J4TGxj?=
 =?utf-8?B?SUpQekF5NEtaZW5LdnltUVl3ZTFSaTRMeWY4alh5WjdOdFhoR1d0N2hYSGx3?=
 =?utf-8?B?THVhUUU4UzQrdENaaUVIK3FaSkhDMndRZjdWdXdDME1XUFpyaWR3cmsvYktP?=
 =?utf-8?B?cGYyM0tVVnd0OWtYUzJ4M2Ixc2liVkdUblQ4K3ByZzlVZmZsV2k5U2k2Q2kx?=
 =?utf-8?B?RjJwejQ0MXlwME03MnRLM0dxY1lQbnJ4eEVvc2RTY3ZBYjgvS29QU2dlVDYy?=
 =?utf-8?B?SGpjMXh4dXE0eXZSaGVVOHVhdTFlL0I2Q3NodVRrNHlqWGVha0ZKa0I0Ynkx?=
 =?utf-8?B?OVNyNEtOWHJiY0c1b0F6b3RNNkY5cFNnRXV3RGtRYmdJSUFzREZZMjlZbjdF?=
 =?utf-8?B?WmdxM2xKSjA5RDFDTFVSZW9UWmFINGZka3BRSHNYZXlmRlpWMGVTb1N3bDFT?=
 =?utf-8?B?NWwrTXMxMk04Q0xzZU9xbGhpeVYyTEVveUlKeEkwZFdKSWc1aVhOTk8rdGpM?=
 =?utf-8?B?WTVaUFdqWlkvcHdMUjVDYzlHcW8yQW5FNDlBeUJmWXp1MzZZV1BIdVQ0bHIr?=
 =?utf-8?B?a1VRa3AyN1dSYVNKdGxVbmQrcndiMHB0RnhvRzBqb21JRkxYaVVsang4eHVw?=
 =?utf-8?B?OC81WkdVM2kza1J0Y3k5VWN0NnFzK1NpZC9aajdoNlRsdUxLbENoMVBmSlJB?=
 =?utf-8?B?Zkt4SmUrUmN5cGVwRy81Wm5VUFFZT21DL2dMd2k3VjUrc0pBWTYyNy9NSUxU?=
 =?utf-8?B?Qm4xUm5Qd2hnSTc3aHJOMkZFTDFVcXpkTUltemVRN24xT1IxaXRHYUx2RmJn?=
 =?utf-8?B?N3U0MzUvNXRqOU9lWG1IUU1hbjl2anQvU0M5SURIRGlHcGVhQ2lxeDJ3Z2li?=
 =?utf-8?B?VHB3MThpT2Z1dXNsNXlXQm93VG5iS0tob2dsclJuTmV0VWZFS3lVVFZRMVZk?=
 =?utf-8?Q?socU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a83a0b1-e19d-4a45-ccd1-08daee7c1a14
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 17:50:00.8522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DRXA6sMpkrVjaXRFBnACCn5U1M+knfPS9oDdpd9EHldZDa+3LzOmh2lqsvlJ39JJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4198
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua,

On 1/3/23 23:55, Yu, Fenghua wrote:
> Hi, Babu,
>
>> Some micro benchmarks run multiple threads when started. Monitoring (or
>> controlling) the benchmark using the task id is bit tricky. Users need to track all
>> the threads and assign them individually to monitor or control. For example:
>>   $stream_lowOverhead -codeAlg 13 -nRep 100000 -cores 0 1 2 3 -memMB 32
>>   -alignKB 8192 -aPadB 0 -bPadB 0 -cPadB 0 -testMask 1
>>
>>   $pidof stream_lowOverhead
>>   6793
>>
>> This benchmark actually runs multiple threads underneath on the cores listed
>> above. It can be seen with the command:
>>   $ps -T -p 6793
>>    PID   SPID TTY          TIME CMD
>>   6793   6793 pts/2    00:00:00 stream_lowOverh
>>   6793   6802 pts/2    00:01:25 stream_lowOverh
>>   6793   6803 pts/2    00:01:25 stream_lowOverh
>>   6793   6804 pts/2    00:01:25 stream_lowOverh
>>   6793   6805 pts/2    00:01:25 stream_lowOverh
>>
>> Users need to assign these threads individually to the resctrl group for
>> monitoring or controlling.
>>
>>   $echo 6793 > /sys/fs/restrl/clos1/tasks
>>   $echo 6802 > /sys/fs/restrl/clos1/tasks
>>   $echo 6803 > /sys/fs/restrl/clos1/tasks
>>   $echo 6804 > /sys/fs/restrl/clos1/tasks
>>   $echo 6805 > /sys/fs/restrl/clos1/tasks
>>
>> That is not easy when dealing with numerous threads.
>>
>> Detect the task's threads automatically and assign them to the resctrl group
>> when parent task is assigned. For example:
> But user may choose not to move threads along with the parent.
> You will need to have an option to opt in.
Yes. I agree.
>
>>   $echo 6793 > /sys/fs/restrl/clos1/tasks
>>
>> All the threads will be assigned to the group automatically.
>>   $cat /sys/fs/restrl/clos1/tasks
>>   6793
>>   6793
>>   6802
>>   6803
>>   6804
>>   6805
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |    9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 344607853f4c..0d71ed22cfa9 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -685,6 +685,7 @@ static int rdtgroup_move_task(pid_t pid, struct rdtgroup
>> *rdtgrp,  static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
>>  				    char *buf, size_t nbytes, loff_t off)  {
>> +	struct task_struct *task, *thread;
>>  	struct rdtgroup *rdtgrp;
>>  	char *pid_str;
>>  	int ret = 0;
>> @@ -723,7 +724,13 @@ static ssize_t rdtgroup_tasks_write(struct
>> kernfs_open_file *of,
>>  		goto exit;
>>  	}
>>
>> -	ret = rdtgroup_move_task(pid, rdtgrp, of);
>> +	task = find_task_by_vpid(pid);
>> +	thread = task;
>> +	do {
>> +		ret = rdtgroup_move_task(thread->pid, rdtgrp, of);
>> +		if (ret)
>> +			goto exit;
> If failure happens in the middle of threads, will you reverse the previous
> moved threads (or even the task) or will you report this failure and move
> to the next thread? Seems to me you need to either move all threads or
> no thread moved at all.

Yes. We should handle the failures properly.  Reversing all previous
movements requires quite a bit of book keeping.

As a work-around Reinette's comment "echo $$ >
/sys/fs/resctrl/clos1/tasks" seems to move all the threads.

I will have to think about this more closely.

Thanks

Babu


>
>> +	} while_each_thread(task, thread);
>>
>>  	goto next;
>>
>>
> Thanks.
>
> -Fenghua

-- 
Thanks
Babu Moger

