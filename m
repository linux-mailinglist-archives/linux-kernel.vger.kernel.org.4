Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23B274F797
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjGKRyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 13:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjGKRys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:54:48 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275BDE77;
        Tue, 11 Jul 2023 10:54:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RedSEYgHlCdJHxtSVfLjiyziL00yao7CDQ/QB8oPL3asI2zT7f6MjbIPBEN+pnKsnZJayOvHT2YJpx622OUKjnKb0mO6Pw531Uyqak9H03wQTwQUbDLT0mIc5awpFTZnks45RqX8x7ru55jnQve8wQCdH64sz5oZlW6r6cb8ANjjoip4rwOY9ZFhaUEbu/ykx/XASkBpNV/lEvCqwl6Fo7JWHtS2Y3L2dQ8Zm0p+Z04actmUc/OSFmc9yIe/B4MDS/V1TmeSNurZgxlljiuFzDHOH5TfvLK9lL/FkHHEuGxcCDnREv9ULC+jEK2kq71f1TvsZb+Y7oY+VoWew2dHTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkOYJKnXir/Rwevf0qv6r/OZUN9aZwD3mCXE9emoiKw=;
 b=XM27Rku8rbSV/G5eVdJSFQykvQ36E41qHg5wyE+aJZj7eg2s4W4wVHWuC5JfhwgOTH4tHGetN6hcog4e45FQUh+OePXavm/ebBOcgIffy1SXxySXWmstcIOyuc8UwHU7WtFUlRVWeqHAvPnYbWAYM0w8hKeXPTo2iNMQ3iyqwlf9+OxMlDBrTfPpJZhoc1JMwjHtjfeqpOKydS4+givnKG08t6NVL2CuOjUma7yC4qb1pp0nzS/FFemzS/ZD677tpWR1c0k3IYx2NO8V7/K2VWx/kZIVrX2vqj372Nl8OqZtLNItyYfus8izEcoLRac1ErA3OFBItoTIQ6nFCuonnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkOYJKnXir/Rwevf0qv6r/OZUN9aZwD3mCXE9emoiKw=;
 b=r7WIKeGNlt/bHpBDltkm/lBhVMrwKVJny7GEOVCXlcNh1EG1BMKR0oCTv4zxTpoKxn0AK3OarPEy95xDfCIOamO+5eryJ9sNDKyHCApIY/m+gnOolWWwF2tYHXQMzStTE7ehSb/zd9BJ4q7Z/CgdeGL747bFwa2UmlcfE5r92eU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA0PR12MB7461.namprd12.prod.outlook.com (2603:10b6:806:24b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Tue, 11 Jul
 2023 17:54:44 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f870:5325:36eb:e741]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f870:5325:36eb:e741%2]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 17:54:44 +0000
Message-ID: <78cf154c-e9e3-a3be-c52b-d70ff4df8be2@amd.com>
Date:   Tue, 11 Jul 2023 12:54:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 1/8] x86/resctrl: Add multiple tasks to the resctrl
 group at once
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
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <168564586603.527584.10518315376465080920.stgit@bmoger-ubuntu>
 <168564605452.527584.8450496267087240475.stgit@bmoger-ubuntu>
 <3cb0a5d9-2268-6111-db9b-b99ef185607d@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <3cb0a5d9-2268-6111-db9b-b99ef185607d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0073.namprd12.prod.outlook.com
 (2603:10b6:802:20::44) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA0PR12MB7461:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f05b1fc-80bc-46f6-b12b-08db8237e8c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UWt14u9TyjBScYY7RNHjRhL36/++Vn0etBQOhOLDvgv/qV/GtSdCG0cO9yEawDMyP3kUU18SLZtrsbgjfy8MTououX0BGmIKddhNO7Y7hUYEV98Ewzybyh/rXHomaGkRKEBMWUqDcep6Cta0ku7HuSHZe3ADMpdLcDxLA0uRKQjvUA4lKGYRqpVutvbFgVjIXdbJWC3pKPpUXrpXg1TY0k7Vft59aIQ3URe6mCVQZ/KJrl+00nJnZRlbTDk9CTytngeK/I3n/Hrzf8/bC+3koxnxyzf3Yx4tuYnh2TS4a/VLQ+1iW+h2ACvqCJxoOabPhBfYT/F3mBdzx6xxqkwFMxusgU8WBAZzunXuPXVXlT+3tl+kUwqBKxGTRr13hvvSF3nIa57FED5J64ajP7HEfto1cSCUzHOm4ZJqOLb7jYuWVRz90VJkGghZDt7cQN+fxDUdR9yuIWsb45KdLDPRyAuXWAUUNkWOSrW2qf6SiYVcHxVID5MUTVlY9Q/GVNLnnbRlBPyybB14vHF2uTlwa9CEGtrz9zXR4VDsMuqFCnKccF+N95savHNJFyWbikFY0cj6MF3Z7HDyxSeXKpXTvZROYy7oTTbDGGLviC5AjuQvX3pbCTfMQQPTLBSRP2zpU4tBw/Hdtnb4H8VuMQXF/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(451199021)(53546011)(478600001)(2906002)(6512007)(26005)(2616005)(6506007)(186003)(41300700001)(3450700001)(83380400001)(66476007)(7406005)(4326008)(316002)(8676002)(5660300002)(7416002)(8936002)(66556008)(6666004)(6486002)(66946007)(36756003)(38100700002)(86362001)(31696002)(31686004)(66899021)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1VhL1k3WXBpY3ZrbDZ5aS9Kd0w3Q3pRdFl4dzdNWm9sWFlqL1VmWFZWVFNo?=
 =?utf-8?B?eDlnbTlLb2k0ZkVZYW1nalArci9oeE8yQk9IYkw1c3J0UkpGNnh2eGVBa2Rm?=
 =?utf-8?B?bFc5a0dWalFtV3dwL0h6S0FQMWhmazFkMGw4NnNiOVFEcVJ4WmJ3MzRpRVpa?=
 =?utf-8?B?OGZoVURwOXNIZXZOQ0hGUU1QWXZpazJSQk9nWDhvTFFjUXFmM1VFOUFIK1Fa?=
 =?utf-8?B?ZGgyZ3RIRVNsbDBuZTJwZWJWL3lBcU9QdnBQRmtGazVHRi83WjVBMWFZd09o?=
 =?utf-8?B?WURzSFIvMnR4bXJNRWhTTGl4eCtXRmhrNG53Z2FxM2x2S2RCWE1KcWw0QkU3?=
 =?utf-8?B?NVdkNW9KaEl2WThObUtSV2JXVlBHSlFON3JCU2NPanBBa3dReTBOdFFhRmY1?=
 =?utf-8?B?RWcrZHRMVFpWSFRMMnhQa3lud2RIeldVVzA2WEduc2dVSVp0NUFkaWtkVG5M?=
 =?utf-8?B?NEU2THBkS0ZWcnV6OWFQUnRNZ21haTZwQmJqZG40M1dqN09ESy9oUm9FRVZx?=
 =?utf-8?B?dmhiT3NnZUprVlhTZzdKNkhWUldvcElCZFhibTIyNTVBOFkvOWh1K3NmWUVx?=
 =?utf-8?B?TjV6enR0YkJpTDNhVHdpU0JaakhEQjRHckhhUzFLSFJlSEpiaVlpeGU3WkNN?=
 =?utf-8?B?TzlWUnYvVTUvanJVR1J5SS9yd3F1cjhHb2dhMFhoREVPVDVoVDJlMTZBUW51?=
 =?utf-8?B?eEZpZXZiSTZGSnVwbTFGdUlCK3l1TzdoUmQzYUdqZEFHTHFuSlpxaE5PRUVW?=
 =?utf-8?B?N1o0Y2lQZ1RUaXF5bndkTUhTZnBkczZ6VXNkRm9OZzdzRXp4YURpc2p3VkFa?=
 =?utf-8?B?RWl0NE9PbDZJT3VJTEp0UjFMRnlCZW13UkM3ZHlaYURWNG1aSFR1ZkhBbFBU?=
 =?utf-8?B?WXlhemV3UEtLN2M1TFp4NEdHWkE4dFBBZTh2cTlZU0ZNMEFWd1FCNC9qN1ow?=
 =?utf-8?B?dnl0cE04dEx0TWJEY1psZ2dZZnRrOUxCdVptS3FTenRWRUoxeVpDK2Jnb01w?=
 =?utf-8?B?RThmbjdtZXduS2xBUUdwUURoOG91RU9nK2xVK2xoaVBmcENhMkFFUlVVUGtG?=
 =?utf-8?B?bUkxbnZpc3Q2YkFoTS9zVk53Nnp4K21qcEZtY3ZLYVdGTW1oc2NuVHBIcmgw?=
 =?utf-8?B?YWZzNmxtNmplRmJuTGJhdnRMS3FDKzlCK3RWS2NTenFVRXZlT3VoeVE5MGpt?=
 =?utf-8?B?ZzRkbUROZ29pTmVFWXJVTnhvZTFobXlzQ2JSalpIc1Yyb1NPcUpzMTBzUDly?=
 =?utf-8?B?L21HN2gyRVFnNkJPQTI4ZmU2NXRob21wbm1iL2JDN0hxT2FWSmVTVmk1VzFJ?=
 =?utf-8?B?Q2UrdVJCU1pIaTF5RnF1ZjdaeUxNajJ0eEFLbkhkL2M5dTFCSVJwNDBhcEZz?=
 =?utf-8?B?NFllektLWHBHV0p1bVNDbHp0VnI4ZWlnYzBoUDhacWM2OGQ5bmF0dTEvaS9L?=
 =?utf-8?B?ZHpmdFBGN2ZTdkxiYlVIcUZhQTJSbGxwV1ZEMkdoaGZBNWpYNDlNMGdFV0Vs?=
 =?utf-8?B?QThiWlVBK0pQazhEY21LMzhFVVJKNjlScVBESFlnNGkrYkIxakhZUjk5TWpz?=
 =?utf-8?B?M3ppQ2pkcW5ybkZqeG9OL2N1alVWU2Y3S2R6WDFRVnRxeEpHM0RFc2xYYUZU?=
 =?utf-8?B?cEpvZHZPM0lITlo2UUh1ZHZJb3hMNVVURkJFeXpqUUYyQXZOQ3NMbmlHVFlj?=
 =?utf-8?B?WG9aTEZOLysvRmVSQ3dyRmY4akNYNUtYWGtzazFjU2dXbW5mejZqb3NKbmRt?=
 =?utf-8?B?NTlNOHVsQUhyYjZTWUNwOURNMEF0dDFSMTh1TmpXM0xxZmJGRjZqV0czN2N5?=
 =?utf-8?B?RTk4andBM1F6bTBRYlFCcWRFYTBXSktvMzdKRVA3eGdyc2NvMWdsYnJhaWV6?=
 =?utf-8?B?Y1JvQjByVEpoQmxKVWJ3VkozUVR6VG1xMENFUEFXcFphekh6Qyt6aElmWmN5?=
 =?utf-8?B?bEx0SFZDOTdBczBrbUgxUU5IM0pkSFlkZ21KUnlkZE9Gd254b0d1c2k5YTZD?=
 =?utf-8?B?WkN6ZHgrQzBWM3ZHY20vTCtyYW95MU5ZTXlSNjlQbnROazc0QmdrbU02dis4?=
 =?utf-8?B?U3psYk1XR0FqT0wrTjdTeGkyQW1uRlVKTmNwRkJIQUpuTHdZeE1aZVFhRTRC?=
 =?utf-8?Q?/ESw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f05b1fc-80bc-46f6-b12b-08db8237e8c2
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 17:54:44.6506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YckRuYw5kfArWR18BHc1GtZDIWF0OJuwp+IDjrqknSt7fVagWT33RW0B6i5AsubV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7461
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 7/7/23 16:38, Reinette Chatre wrote:
> Hi Babu,
> 
> On 6/1/2023 12:00 PM, Babu Moger wrote:
>> The resctrl task assignment for monitor or control group needs to be
>> done one at a time. For example:
>>
>>   $mount -t resctrl resctrl /sys/fs/resctrl/
>>   $mkdir /sys/fs/resctrl/ctrl_grp1
>>   $echo 123 > /sys/fs/resctrl/ctrl_grp1/tasks
>>   $echo 456 > /sys/fs/resctrl/ctrl_grp1/tasks
>>   $echo 789 > /sys/fs/resctrl/ctrl_grp1/tasks
>>
>> This is not user-friendly when dealing with hundreds of tasks.
>>
>> Support multiple task assignment in one command with tasks ids separated
>> by commas. For example:
>>   $echo 123,456,789 > /sys/fs/resctrl/ctrl_grp1/tasks
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 6ad33f355861..504137a5d31f 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -696,11 +696,10 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
>>  				    char *buf, size_t nbytes, loff_t off)
>>  {
>>  	struct rdtgroup *rdtgrp;
>> +	char *pid_str;
>>  	int ret = 0;
>>  	pid_t pid;
>>  
>> -	if (kstrtoint(strstrip(buf), 0, &pid) || pid < 0)
>> -		return -EINVAL;
>>  	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>>  	if (!rdtgrp) {
>>  		rdtgroup_kn_unlock(of->kn);
>> @@ -708,16 +707,27 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
>>  	}
>>  	rdt_last_cmd_clear();
>>  
>> -	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED ||
>> -	    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
>> -		ret = -EINVAL;
>> -		rdt_last_cmd_puts("Pseudo-locking in progress\n");
>> -		goto unlock;
>> -	}
> 
> Please do not drop this snippet. I think there may have been misunderstanding
> during previous comments - this snippet is required, it just does not need
> to be run for every pid the user provides since it depends on the resource
> group, not the pid.

Ok. Got it.

> 
>> +	while (buf && buf[0] != '\0') {
> 
> I think it may help to add a check for '\n' here also. It looks to me
> that a user (shell) that provides "pid,", which is "pid,\n" would encounter
> error and this may not actually be an error.

Ok Sounds good. I have verified it. New check will look like this below.

while (buf && buf[0] != '\0' && buf[0] != '\n') {

> 
>> +		pid_str = strim(strsep(&buf, ","));
>>  
>> -	ret = rdtgroup_move_task(pid, rdtgrp, of);
>> +		if (kstrtoint(pid_str, 0, &pid)) {
>> +			rdt_last_cmd_puts("Task list parsing error\n");
>> +			ret = -EINVAL;
>> +			break;
>> +		}
>>  
>> -unlock:
>> +		if (pid < 0) {
>> +			rdt_last_cmd_printf("Invalid pid %d value\n", pid);
>> +			ret = -EINVAL;
>> +			break;
>> +		}
> 
> I'm trying to image a possible error and it does not look right. For example,
> the above could be "Invalid pid 123 value". How about just "Invalid pid %d".

Sure.

Thanks
Babu
