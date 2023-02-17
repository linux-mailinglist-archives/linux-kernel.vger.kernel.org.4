Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5F569AEF7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 16:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjBQPGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 10:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjBQPGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 10:06:44 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C386EA7;
        Fri, 17 Feb 2023 07:06:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J31pzeihTjL1AUdj+bIi9664WNSKxjK2uMXdqz7/WX1AUaYGrdeItw2+9HCRsdJDFGjrnb5Qc5Xd9AIsKNNNDh1QLISzPR4YaoEUsuqy2ee2QURo6cGZj1wr3t5JX6MU4aYDW4NeL1ShEL2puEyq9x5itpChDb9/fJ1srjqNeob9RnJzJQ/RQGLl/O0ufzV221g7HXGQVA7bHQgf6FVj6/YhE94J2xetlwDaINqwn7GLsZhF0O/th8/5KY+LX7NYeQL36z3LiPoPmeitIyihWQzraoyijDf+jjWRvWgGwNi3xhtthAQeXwTqBxu3bgotuIf61dB9nIzkKy620aI5BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ir+wdT2FnQq+GkRjr6SmLBfSvaousocUpgSHPKMloLo=;
 b=NcLYoN+B9D9dQC6HTfk5i4tvWlPfulCE7lc8ZgI+bOpWOEO6/XIcafc9CsDe+UK8OGibIx4AkETHYsmsv0bZKmk+t/D52atAko1anVrwyJJXU3TNegHWduHin8iij8D9+DxOcguURWcFgCM8iW4kRemBfxhWP0NCx/RkMH6MwlthA9FpudSXY+rn+pc8ZoJGwLD54xLmwWnNfdF8J0S9LA8sxe/cxWJiSmx3rupMTitYvvO2T03DHOWhgrCD49RG76kQIoIxouU9G5w1zpIUk4+UMMyqcorWqtIrPjLdTbXZ6X25DK5cAejFr/NxP3q2Tzk5B8U6tPk27xfipmFlqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ir+wdT2FnQq+GkRjr6SmLBfSvaousocUpgSHPKMloLo=;
 b=yCYgkkbyNFHeF07RftuRh3l/VvuoEOu5+UOE6PxHcvU0iFrtU64EmLv9RWrgGaZ1ZED9fdUjqn4G+EwAaVSzqp2iBmJcR4ggOBfBSfvFNlFOBOsn51svfsb9knmohJI3GXLsFil/LVCs5eW3SiLyOJsCNjjiT8aN0/PNQmtEa9Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW4PR12MB7429.namprd12.prod.outlook.com (2603:10b6:303:21b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Fri, 17 Feb
 2023 15:05:59 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6%7]) with mapi id 15.20.6111.015; Fri, 17 Feb 2023
 15:05:59 +0000
Message-ID: <090d80c5-47ad-c152-27cc-81019aa5daef@amd.com>
Date:   Fri, 17 Feb 2023 09:05:55 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [RFC v2 PATCH 1/7] x86/resctrl: Add multiple tasks to the resctrl
 group at once
Content-Language: en-US
To:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        reinette.chatre@intel.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, eranian@google.com,
        peternewman@google.com
References: <167537433143.647488.9641864719195184123.stgit@bmoger-ubuntu>
 <167537441417.647488.18261538242584692230.stgit@bmoger-ubuntu>
 <3898cf3c-42e8-1fa0-395f-318bceda313d@intel.com>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <3898cf3c-42e8-1fa0-395f-318bceda313d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0350.namprd03.prod.outlook.com
 (2603:10b6:610:11a::24) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW4PR12MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: cd57f1e6-f5fd-4a05-25ab-08db10f87a26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bL+IPSeadwL8Q7ppBOo2tSPWP2inaTgVc3m8SrKX0Nrs8Yop8GTl1563C9+TOeUaScmlJbBETENsSAbdGtfyNgaf3sXw0K5VHkWZCN0M4mciyzH1AWVNORwFV97BgrrbWPDmpUpLUps/oJkwcYDoohGSWeCmNINQJbZ4r/DEsIk9nC0x/JiywiKZSCYTJ0ThNtoSZD9ZyQME6hHo1Uv3kzt9imy/ZMliC3wrciShSPVywfenLoHwnOWkuYT6U1wgm0RYRsp5fyKEj13C1hafkpGhvq429+tDVGev9xlz0Brx9WvNXmoVwCbaRmJSEGukfXkhBqLASq/YE2euyh7K43bPhes2FMoCxsMLsLboj9NLMReyaqc1iLL/JgVb5MB3Kv+2MX64C/MbVKOl2LP6HVbHEDf5HC8nWQotEr1BIND1NDLhKpIuKFEjcF5QxSyFqRld/bf13enPkcTfH3yx3xhuSJfoTlugiwDXJVWIKeLvcYWBAYLmiI4z5R1O5s6TE648++2IiDdqvxChTdXNzEBV69ilRvJb60wjQ8a1h6rI0YsMCsrbK6rHpnWPV6ZCM5I24LpsO7KzlHR6kIatw793dqeRSVDdarcT9atnXX9H6vMCtOjTCMOmbZ6rPYuLhf3zaNL7WStVvsLQT9P3fDiFP+iCeNUPMQbqFZuzInr68GHcnHQhdYITvNhJBzuLegSBEHmgo8M0tRw9ODwO4rOMJpRtRdfyh/TBttU3K4g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199018)(186003)(2616005)(53546011)(26005)(6512007)(6666004)(6506007)(6486002)(110136005)(38100700002)(478600001)(316002)(66946007)(66556008)(66899018)(4326008)(8676002)(41300700001)(5660300002)(66476007)(7416002)(8936002)(2906002)(31696002)(83380400001)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVZZZk9GVmhhbXFQZmZvaTVVM1RNWTlBYTJMWmVzQWcvTGJPTXY2TzlJSGI1?=
 =?utf-8?B?UEJENVVPM25ZemNsNk9ISURsT1FoTFRYU2JNOW9xZHVRWkRYMmNuT0Ftdnh2?=
 =?utf-8?B?bjVocWxmZzFHbXBzYXltdzJBZVgyMTRjVlNuOEZzWUJCamVJTzNNUWlJSFRt?=
 =?utf-8?B?ZDJZWmVZS0V1b3VOeDZ6UDdLVUJsb0hUeUltRzVOdUYvdGE0YmRTMkQwN0Yx?=
 =?utf-8?B?R0lyOGJGdTdvSEdpVW5rUnFqUTRib3krSFJESHNNcFB1U1IxVmFvMjRmRDZD?=
 =?utf-8?B?S1NYblJxaUhQYVNSSjJFMldKQ1RMbUZwL3V0eTAyRFBNMUxvbWgyVlNEUmxV?=
 =?utf-8?B?S1VYc2ZIOFpnQ1E5MUJvMklWU254Nm5iQldvUHlZRk9FNzlYamE5NWt5QVQz?=
 =?utf-8?B?UGo0eHgrdThxVmZVekQ2b21uNklaQWJCUm50RlpRUTdyWGsyK1VMOW5kVzkx?=
 =?utf-8?B?WXlHQ2ZMdlVXR2o4ZHBDOStmQnlPVDYxbVBGczd5QkRuN2hiOG5aWmxzT0ll?=
 =?utf-8?B?cVc5MlBveXlCb3ByQmlNMlVjcjhhRFpxeUwxV05Pekw5WEQ2d0VGbWU5ZktX?=
 =?utf-8?B?RVROMElHTXlleHVCVmcrNHJ1MktPVzJGZjZpa04raWNiZG9rYUNRejBlZlI2?=
 =?utf-8?B?U2VDR0V6NThlL1g4UmZXMFZ5QkRnZ3lNNW9aeTc5dlFmZm8xTTZ1OTZ5NHNB?=
 =?utf-8?B?UWxrSWc1UFhmU0grRjc3SFQ0K0VVY1NrMkVPOHlsN3JmajBkV005RkxZNURQ?=
 =?utf-8?B?Zm5XMUhsQ1VPTHlYVXlQajlHRENTcWFJM1ViNzhKbVRxcXp1eE9oRzd0dkow?=
 =?utf-8?B?Z2E3bWQwV1BaczhhS2g5RDR1NWRSdXduQWtQcTJuQkxJWTdHY1lkT2VKeXU5?=
 =?utf-8?B?ZFA4TXI2c0dPWlozdEpoc1NGUXQ1QTZUZFFRSm9XMlNIM0VwckcrNU1jZ3hN?=
 =?utf-8?B?c0x1WjV3aDYySktMWDZ3cHZoR1BXY1BwTHgwdDZvbFpqdnRpeGxVbnhySFpW?=
 =?utf-8?B?SnRwT1VyNmxOdFpYMTlUZG5sSUJMYmlJZEU0OTgxYjlQSmJxRm04dW9rMmVZ?=
 =?utf-8?B?WlhuaERseEcrNnhFRC8yMjZwTW5NS1FBTVd5d3RPNURXSFZBTll6eXhrTkRl?=
 =?utf-8?B?NjBoR1pJanR4QUpDS3NrYlQ0NXFkZ2N4Q1RlamFORDJ0UXIrQWVwUldrZ3NF?=
 =?utf-8?B?VFlpVy9hQm9kWDRrMGZ5cVBjUVVCUHBUNVBWZ0R3K3g2SkVYQkhlZlkwRHVO?=
 =?utf-8?B?SStydzJndGFJSU16Z044RWllRllUS2taMzdMd1UyWEN6OFFkNXlUdzZ1Y09o?=
 =?utf-8?B?b2FzR3ZKcHdGVThzUXB3VHcvejJ0VlFQdjR3b1Y1NVQvblJvL3E2RUptbFRD?=
 =?utf-8?B?VkNiN1pTTExiT2pxTFVyeTRkclYwU21CcStwNW51dUFWdG45R2E3WHpOK2lr?=
 =?utf-8?B?OGJtVlZTbjJocFNyUkdDVnhhSkZtL1hudnIxQWRvOEdTaGR4NXQ1STFqSm0r?=
 =?utf-8?B?eXJ4M0t1TXoyclozS3dlOGVOd1BTaHFKQWE1Zjltd3RjczJWYkp0V2dreklT?=
 =?utf-8?B?YVJWd2hudjB4ZHBEUzQvQ0FHQ2ZpR1ljZWRJTmc1OTkrVXdqbTBUYkdBQWRD?=
 =?utf-8?B?MUpHSndqc2JFcmlBb0oyNjIxMGU1Q3RuYkV1TXJsZGE4UmpybjJQWWRldXVB?=
 =?utf-8?B?dW91WWlndWNuTXZFYW5kTWJRWWFvd0tHMjVCeU43TGdkTEtkZXRqbXlybWt1?=
 =?utf-8?B?bG9uZlVVM3g1MmN1eUF2dC95dUlISWc3V0J3Z2FnaDU5TTZCaFQwREVVdFRC?=
 =?utf-8?B?Rk5zS3VUV21pNjE5dmZWTkE1SFpya3NGZ05YVHFpTHhUV0IxNitVVjd6Nnhu?=
 =?utf-8?B?aXVUM3J5WERCeDZNUU1kWkxTMHh1ZkNmempKT1hMNkwvYWY3THMrTS9XZVZX?=
 =?utf-8?B?Q05qbHdJS3pweDFKN2hFdDVIVStXa1p2OG1hUkRQRzU2MXcxSDBUYU1tNkNL?=
 =?utf-8?B?ZlhIdEtyd21LTmlkRXpOTDF4QXEweVYzRFZ3U0NjN1lnak5RWCtDT2Zsd1M3?=
 =?utf-8?B?S2xLQ3FXUXlCOEFzTGEzYXZCTGdiYjFIZGlDeGRvZG5zUjhGR3R1di80K0hz?=
 =?utf-8?Q?esjkQpGaUcczpuNb8an31UZvQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd57f1e6-f5fd-4a05-25ab-08db10f87a26
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 15:05:59.2342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +2C8O472qvFhwoCt+WIwrriE0kzrZh4mjUEfIP/CEb3H69672TArVoMoxt59gbkj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7429
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua,

On 2/16/2023 4:27 PM, Fenghua Yu wrote:
> Hi, Babu,
>
> On 2/2/23 13:46, Babu Moger wrote:
>> The resctrl task assignment for MONITOR or CONTROL group needs to be
>> done one at a time. For example:
>>
>>    $mount -t resctrl resctrl /sys/fs/resctrl/
>>    $mkdir /sys/fs/resctrl/clos1
>>    $echo 123 > /sys/fs/resctrl/clos1/tasks
>>    $echo 456 > /sys/fs/resctrl/clos1/tasks
>>    $echo 789 > /sys/fs/resctrl/clos1/tasks
>>
>> This is not user-friendly when dealing with hundreds of tasks.
>
> Maybe add something like "poor performance due to syscall overhead...".
Ok. Sure
>
>>
>> Improve the user experience by supporting the multiple task assignment
>> in one command with the tasks separated by commas. For example:
>>
>>    $echo 123,456,789 > /sys/fs/resctrl/clos1/tasks
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>   Documentation/x86/resctrl.rst          |    9 +++++++--
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c |   24 +++++++++++++++++++++++-
>>   2 files changed, 30 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/x86/resctrl.rst 
>> b/Documentation/x86/resctrl.rst
>> index 058257dc56c8..58b76fc75cb7 100644
>> --- a/Documentation/x86/resctrl.rst
>> +++ b/Documentation/x86/resctrl.rst
>> @@ -292,13 +292,18 @@ All groups contain the following files:
>>   "tasks":
>>       Reading this file shows the list of all tasks that belong to
>>       this group. Writing a task id to the file will add a task to the
>> -    group. If the group is a CTRL_MON group the task is removed from
>> +    group. Multiple tasks can be assigned together in one command by
>> +    inputting the tasks separated by commas. Tasks will be assigned
>> +    sequentially in the order it is provided. Failure while assigning
>> +    the tasks will be aborted immediately and tasks next in the
>> +    sequence will not be assigned. Users may need to retry them again.
>
> May need to add "tasks before the failure are assigned...".
Sure.
>
> To retry movement, user needs to know which pid fails. So it's better
> to add "last_command_status shows the failure pid and user can parse
> it to retry assignment starting from the failure pid".
Sure.
>
>> +
>> +    If the group is a CTRL_MON group the task is removed from
>>       whichever previous CTRL_MON group owned the task and also from
>>       any MON group that owned the task. If the group is a MON group,
>>       then the task must already belong to the CTRL_MON parent of this
>>       group. The task is removed from any previous MON group.
>>   -
>>   "cpus":
>>       Reading this file shows a bitmask of the logical CPUs owned by
>>       this group. Writing a mask to this file will add and remove
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c 
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index e2c1599d1b37..13b7c5f3a27c 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -683,16 +683,34 @@ static ssize_t rdtgroup_tasks_write(struct 
>> kernfs_open_file *of,
>>                       char *buf, size_t nbytes, loff_t off)
>>   {
>>       struct rdtgroup *rdtgrp;
>> +    char *pid_str;
>>       int ret = 0;
>>       pid_t pid;
>>   -    if (kstrtoint(strstrip(buf), 0, &pid) || pid < 0)
>> +    /* Valid input requires a trailing newline */
>> +    if (nbytes == 0 || buf[nbytes - 1] != '\n')
>>           return -EINVAL;
>> +
>> +    buf[nbytes - 1] = '\0';
>> +
>>       rdtgrp = rdtgroup_kn_lock_live(of->kn);
>>       if (!rdtgrp) {
>>           rdtgroup_kn_unlock(of->kn);
>>           return -ENOENT;
>>       }
>> +
>> +next:
>> +    if (!buf || buf[0] == '\0')
>> +        goto unlock;
>> +
>> +    pid_str = strim(strsep(&buf, ","));
>> +
>> +    if (kstrtoint(pid_str, 0, &pid) || pid < 0) {
>> +        rdt_last_cmd_puts("Invalid pid value\n");
>
> Better to add pid_str in failure info. Then user knows where the 
> failure pid happens and can re-do the movement starting from the 
> failed pid.

ok.

>
>> +        ret = -EINVAL;
>> +        goto unlock;
>> +    }
>> +
>>       rdt_last_cmd_clear();
>>         if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED ||
>> @@ -703,6 +721,10 @@ static ssize_t rdtgroup_tasks_write(struct 
>> kernfs_open_file *of,
>>       }
>>         ret = rdtgroup_move_task(pid, rdtgrp, of);
>> +    if (ret)
>
> May need to report "Failed at %d\n", pid;

Ok. Dont want to overwrite the last command status. I may need to update 
it with pid. Will check on this.

thanks

Babu

>
>> +        goto unlock;
>> +    else
>> +        goto next;
>>     unlock:
>>       rdtgroup_kn_unlock(of->kn);
>>
>>
>
> Thanks.
>
> -Fenghua
