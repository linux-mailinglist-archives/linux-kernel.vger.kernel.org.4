Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6108A65DB29
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 18:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239747AbjADRUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 12:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjADRUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 12:20:31 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4B7DFCF;
        Wed,  4 Jan 2023 09:20:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bS0FaFZoBwvcpixB7i+Twb7elqh3dj1wEWDNliplsxGBBwl1oVrSfVClJwzXlF1sRNHBmqMyb/n1xJMR4u5KgwpeDeItE1LAyWytKYfo03T6p/DblziAKME1MYDrS2uj3loJtOyIRQlTgksJX57KSFouhbGeWY+npJsBjopjDL6lJ6P4Ju/3I1rEPw39xxkP8GX8vH8RmuLZMIGY42ZvYwrlagX5nQHrCOUjlsSRiladc03QVfPdhY3bVJfsvyyKGwbI2lSDAgl9O8Lz+Y1ILcYWEmDLig97TtItBMy2XYIXUfqVfoxp8/pncYZGcYXm69I8e8GYEn2MlN81aiGNFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Obf0kWPICEAH2McJKxIFvn+r4U5oBnn5Bb/hiY3ZXWM=;
 b=kT1MXgr0gVDIpkojATUhFuPNHMidrL6d5rJO37t+ESEWTznlx5hxSCyyvAlOFJ18IblApL7Re4hBfsrJxql3eW+thY7Co214S/11G9BmqmS8Om+wrOUDP+bQy1qK7+bFGBvuS3DPFAoHWLfnXG77Op1bUQ0tjFmuQkv0AbD4EPyiLg9iAHqbY6gTsc026pPTU0ZV+vAzMy/f3p1mrX4lJEMXG6CLmavdt96tO9lM3t+FWHIoSOUBYVYyYlZdNw4b6CzEf+5DOQbOAMxkLH/slq/LXRW5OeCe3mGxqdgNz9NNxQFmRuQCXz5vU6ZLBPyS/j5pa8xtagfJDZcsQCDxgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Obf0kWPICEAH2McJKxIFvn+r4U5oBnn5Bb/hiY3ZXWM=;
 b=G/Hq41SVIabaj3HujgQlXSJ0O3bgWohasvVcBPS1j7j/aIh9QbDvvFRr/j0izo8w4Vaf2SWO5CUpWQUwco0dbzgzxXpQHSqIQ2EPuwPaoqEWlupWw0NkyBCxnWbTFseN96Sx6DMU9zxKUOaQeP+O+Vwx6L/ZCQjFdjPOIlbqnWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 17:20:28 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%3]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 17:20:28 +0000
Message-ID: <48724d09-cddf-1927-e3b3-f572e35ded0a@amd.com>
Date:   Wed, 4 Jan 2023 11:20:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH 1/3] x86/resctrl: Add multiple tasks to the resctrl
 group at once
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
 <167278359522.34228.17439739885350817510.stgit@bmoger-ubuntu>
 <IA1PR11MB6097AA6AEDC9E37D487C284C9BF59@IA1PR11MB6097.namprd11.prod.outlook.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <IA1PR11MB6097AA6AEDC9E37D487C284C9BF59@IA1PR11MB6097.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0062.namprd07.prod.outlook.com
 (2603:10b6:610:5b::36) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM6PR12MB4516:EE_
X-MS-Office365-Filtering-Correlation-Id: 21bb63e3-7339-46da-6250-08daee77f974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2JjV8LPkQJe7h1GbIeaAOzlnsH6yPR+4UASTVs/v7R5bdWUH5jfUP5njJG61v5hsoVk2ssVUSk1KE9miDRd8AnajRgbQozN6kYT3hW0kLu4U67KlhATt8uyPM1R3fGHOElDma+4C7W+3G5ZxAvlm6FOpc+hl7VC0lX/IBrb5HMskBMkTn0vjteZAVa7qI6jrWG6vECxD0t+I9tCLfe08RpL/0qVEc3nFmyJEdVbd9Q/vfsIQCdeKbTSnh9LL4Y/bRPfugO8/3CXd+yZCjPP8czllyaJL1zGahA87ze3c0X4cpYJBM9V9J0kr3/R5yZ86rMChjOqNVQkNk7O7Rx1aKaM+Ha20gv7DJkphZ4DguYmukvV5cj4gwEwn8yo8iMKcZ0VT5mzwnsyq5LZNWGqszJeEa18wQ9pTu8qmBZSZ15j20TamhVj+lCfeO0vw8seXP5srmziSqPZrNFzBkU58fWUwZLFMGB08krmxZ0g0IqVQBWRkPcPaEsgzxmolatd6n7iN+f7rDvV/1XtnMKnSPFSmhDtduapNiGWp/j5mKsN/roJFUdUOPnB8lFxQRJHyWBzYg8Z27ZpvrdzMOhhSu+7ahGEe/rqoZaj6BV7srfODZIFbj1hOupwlF7akO8y7zva4uJ+x0J2uWdgxaNEwpTYxLRfBGHpA65tceZOgSLReiNv3V76fRqr/Ghn+SsZlyI2BClq/p+VNdxvv48XgxdFAKrMyo9K0CwsIZoAribQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199015)(7416002)(66946007)(4326008)(66556008)(66476007)(8936002)(66899015)(5660300002)(8676002)(41300700001)(2906002)(54906003)(31686004)(3450700001)(316002)(110136005)(36756003)(6666004)(478600001)(6506007)(53546011)(26005)(186003)(2616005)(6512007)(83380400001)(6486002)(31696002)(86362001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEpvYWlDUUhHU2NXNWo2OWNORW9icXJsUGxJZmRib3BWSDN2TldaQW5GTGs4?=
 =?utf-8?B?aUl5cjRvR3JKWnkvYTdnV0E3NFUxU3B6d0E2bS9zdFZRRkRCMFRqbFdmZDlR?=
 =?utf-8?B?QzN0YmRHaEp1UUIvYnMrdkVkdWFHVVgvNVlUcXB2bjJEKzJKSy9teWY2dVZ3?=
 =?utf-8?B?SkhTM1JVeUZJSEFPeWx4Z1hpYVVOK2d2bFVnenpmaFdkMmhYOUExWFBPT083?=
 =?utf-8?B?WEpyVlpiOEtDKzU4VUZRd0lVelY2WlVLVVkyTlVVTktSYUE4aXUzcWdRNUpn?=
 =?utf-8?B?b0RkcGlicDZGK05UNFg4c1ZNQ2FhM0ZwSjZjY3lGSDVkTzdrbGpCaHp1Sy9s?=
 =?utf-8?B?OVFvaFhYR3RkK3gvQlgrSUxoVDB1UVhrQ2Nsdkl6aE1oNUNTMmE5WlhRdjJm?=
 =?utf-8?B?emFmU1hRQlovN1YxZ2RmM0laS0Q3NW44V2hCenJWR09HUXdZM3I0aUZwcVFD?=
 =?utf-8?B?b1RKOXdzRGU3aTFmazNKRHdvUjdYcjllb0c2VTM5WlJ5dWpNQU1JZmJhdEQz?=
 =?utf-8?B?cFhzVkJQU0Z1ejN1S3lMbWZseDU0MTJzYXkxdWZpSU9rZW1nejBMdEE4SHFW?=
 =?utf-8?B?RVc0UFh4ZW9vS3FpaFdOWFVyMG9GME5qd3cwTTkzTXZMMVUrTS9OWSs0cFBU?=
 =?utf-8?B?VU1JTndpVVhXMUNOeWMxYW9mbXhMZjEwek5KRFBpVHhHMHhIVE01YkJYWng0?=
 =?utf-8?B?ZyszQ3JvWG1xOUN0c0FJM1lLVGdhMmtFdkU2RHFXYVAyV0doWUxEM2ZkaWcv?=
 =?utf-8?B?cmlYTzlGb2dmYTRPTm50WFdOQ05Xdi9ldlFaMUQ2OEVvQXczNXVZWkhROWk2?=
 =?utf-8?B?Z0l5UHd5ODlsa3IxZkpVY2dwSml2TkduZWFtMkNkZGFsLzRmK0RORjBlc041?=
 =?utf-8?B?clR2L3Z3RDIrVDdiOW1yRncyQ0JaWkNZMW5yTVoyTlpNQU9ZaUF0MGFxTjli?=
 =?utf-8?B?cG5YSGFyWU0ra05HNXVaK0ZCTU1MdjJrU001VUh5bDBzOWd0N0s1M2dhc2gz?=
 =?utf-8?B?VG9tSzhyMkE1TEJwaWtoRUlzOTl1cVUzL0ZITitWK2ErQWR1WmQ3RllVZDVu?=
 =?utf-8?B?VDI4bG9hemp4eDBhSmhsTFd6OTA5T2xSUUtvdGg5RisxaTFwc21pT3dwZlh5?=
 =?utf-8?B?S0psa0lESHNvUnM0b01va1QxME5KRWVTTXA0WnlNNC9aWFNsVXhLUjliQzY5?=
 =?utf-8?B?MXFBS05IS2VIOE1mRVN6ZThSSG1SSE9CUkpZd1lwbE4rSkRhQys2UXpVajlE?=
 =?utf-8?B?RTNGMnNhWmVwdlBaN0pLcjRTaFd3RTg3aG4rSnQxWCs0aGxlQTJUT3lhL0dr?=
 =?utf-8?B?U1lUVkhzTmxuNDR3SmtaSE9sQ2MzZEFwUEhleHg0a2s2dEtycTlsRm9XS3JY?=
 =?utf-8?B?VS8zUXR0Yk9ZM0NDU3ROa3JnY2VieTljZ3daUG44UVZocEZhSTVuUDgzR0JY?=
 =?utf-8?B?V2EyazhndWlNcDZlNUVmZEJSMWV2dkpkbXdhc0RwSEhuZ0Q2eDdxY3pBMGZF?=
 =?utf-8?B?K0hCdEMzRjJWT2p5dVhTVFFReWJ6bFRaK3N5UUZ6Z29rNCtYZ2VYUXRGelNj?=
 =?utf-8?B?VXJHd0VqQm9DQml5OUZFaFQ1YTlkWndNM1IxQTdIQlN1b0lIemhZZUV0SkxI?=
 =?utf-8?B?ZFFSSC96eGNqWm9tcC9HTUdWcG51RFVFUEk4a0xPS2M2TTVudFRsRFRuQVd2?=
 =?utf-8?B?UU9JRHRVNXFKSVVDWEttcmltNXRpZ0lJekQrS29sZEQ2bzZuRWJRQi8vUENX?=
 =?utf-8?B?N2d2RDByZkdpcitGWHFZS05GazJWanZMZHQ3RHM0RlNHNmp3SCs0M0JvZWFh?=
 =?utf-8?B?VTBxWmZVSW9iUW8yajlPZHFiN21sR2ltbjRLK09mb1NjUE5zR05tU0dDa3h2?=
 =?utf-8?B?OTBnTGloKzBFRWZKQUVzcm8xZkxUYml6dU9zQ1UrU2xwTW9wZzZRNlhGOFZi?=
 =?utf-8?B?V2RDUi9kdkV1T2M1dFdRaDhtOUFaOUpSYjdxK0tHVTg3SXZNTjdqcjhmazVQ?=
 =?utf-8?B?THFYaXBiTFVBN1ZBTnBtSGUzVlhhREx4OTdkQms1SmJCV2RGenk5a3VQS2Ir?=
 =?utf-8?B?NGJSbE13K2ZVQW9kSVNxakMwWDlnQXN0NG53dHlFbXpmWGlnUm5vUDV5eHho?=
 =?utf-8?Q?K7qs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21bb63e3-7339-46da-6250-08daee77f974
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 17:20:28.1737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9h2g5PiBKB24U+/IuY7LetaTOp8DQcQJKKyXhS1UvszrPwgZtWba+NrPf2W4IlU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4516
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

On 1/3/23 23:46, Yu, Fenghua wrote:
> Hi, Babu,
>
>> Right now, the resctrl task assignment for the MONITOR or CONTROL group
>> needs to be one at a time. For example:
>>   $mount -t resctrl resctrl /sys/fs/resctrl/
>>   $mkdir /sys/fs/resctrl/clos1
>>   $echo 123 > /sys/fs/resctrl/clos1/tasks
>>   $echo 456 > /sys/fs/resctrl/clos1/tasks
>>   $echo 789 > /sys/fs/resctrl/clos1/tasks
>>
>> This is not user-friendly when dealing with hundreds of tasks.
>>
>> Improve the user experience by supporting the multiple task assignment in one
>> command with tasks separated by commas. For example:
>>   $echo 123,456,789 > /sys/fs/resctrl/clos1/tasks
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  Documentation/x86/resctrl.rst          |   13 ++++++------
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   35 ++++++++++++++++++++++++++--
>> ----
>>  2 files changed, 35 insertions(+), 13 deletions(-)
>>
>> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
>> index 71a531061e4e..f26e16412bcb 100644
>> --- a/Documentation/x86/resctrl.rst
>> +++ b/Documentation/x86/resctrl.rst
>> @@ -208,12 +208,13 @@ All groups contain the following files:
>>  "tasks":
>>  	Reading this file shows the list of all tasks that belong to
>>  	this group. Writing a task id to the file will add a task to the
>> -	group. If the group is a CTRL_MON group the task is removed from
>> -	whichever previous CTRL_MON group owned the task and also from
>> -	any MON group that owned the task. If the group is a MON group,
>> -	then the task must already belong to the CTRL_MON parent of this
>> -	group. The task is removed from any previous MON group.
>> -
>> +	group. Multiple tasks can be assigned at once with each task
>> +	separated by commas. If the group is a CTRL_MON group the task
>> +	is removed from whichever previous CTRL_MON group owned the task
>> +	and also from any MON group that owned the task. If the group is
>> +	a MON group, then the task must already belong to the CTRL_MON
>> +	parent of this group. The task is removed from any previous MON
>> +	group.
> Multiple tasks movement may fail in the middle. How to handle the failure
> in the middle? Abort on all previous success movements?
>
> Seems simple way is to exit from the failed task movement. That means
> all previous successful movements will not be reversed and all tasks won't
> be moved since the failure.

Yes. That is what even I am thinking. Exit on a failed movement and record
the error. Don't need to reverse the successful movements.

>
> Then this info needs to be explained in the doc.
Sure.
>>  "cpus":
>>  	Reading this file shows a bitmask of the logical CPUs owned by diff --git
>> a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index e5a48f05e787..344607853f4c 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -686,28 +686,49 @@ static ssize_t rdtgroup_tasks_write(struct
>> kernfs_open_file *of,
>>  				    char *buf, size_t nbytes, loff_t off)  {
>>  	struct rdtgroup *rdtgrp;
>> +	char *pid_str;
>>  	int ret = 0;
>>  	pid_t pid;
>>
>> -	if (kstrtoint(strstrip(buf), 0, &pid) || pid < 0)
>> +	/* Valid input requires a trailing newline */
>> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
>>  		return -EINVAL;
>> +
>> +	buf[nbytes - 1] = '\0';
>> +
>> +	cpus_read_lock();
>>  	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>>  	if (!rdtgrp) {
>> -		rdtgroup_kn_unlock(of->kn);
>> -		return -ENOENT;
>> +		ret = -ENOENT;
>> +		goto exit;
>> +	}
>> +
>> +next:
>> +	if (!buf || buf[0] == '\0')
>> +		goto exit;
>> +
>> +	pid_str = strim(strsep(&buf, ","));
>> +
>> +	if (kstrtoint(pid_str, 0, &pid) || pid < 0) {
>> +		ret = -EINVAL;
> rdt_last_cmd_puts() to record the error.
Sure.
>
>> +		goto exit;
>>  	}
>> +
>>  	rdt_last_cmd_clear();
>>
>>  	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED ||
>> -	    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
>> -		ret = -EINVAL;
>> +			rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
>>  		rdt_last_cmd_puts("Pseudo-locking in progress\n");
>> -		goto unlock;
>> +		ret = -EINVAL;
>> +		goto exit;
>>  	}
>>
>>  	ret = rdtgroup_move_task(pid, rdtgrp, of);
> Do you want to exit if there is error in rdtgroup_move_task()?
> Otherwise, the failure won't be captured if later take movement succeeds.

Yes, that makes more sense. Exit on a failed movement and record the error.

Thanks

Babu

>
>> -unlock:
>> +	goto next;
>> +
>> +exit:
>> +	cpus_read_unlock();
>>  	rdtgroup_kn_unlock(of->kn);
>>
>>  	return ret ?: nbytes;
>>
> Thanks.
>
> -Fenghua

-- 
Thanks
Babu Moger

