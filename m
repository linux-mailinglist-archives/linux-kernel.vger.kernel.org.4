Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2666E7D7B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbjDSOwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbjDSOwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:52:23 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::60b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2571F122;
        Wed, 19 Apr 2023 07:52:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1Ofm8hqJ1S+mslRmWuQQWk01EKcbYRRt7CSsjJVeX78FUuhqmt8W42boZWJFZkTS4+V02djTbrF22xe7CUR5nuJ+UxbsV8PUfL8JTPJX8ZM+Kl4S2x/iJNMy4xxTBG5v4U666rsTY95Q8fo+0CMqmZXp/JjiFP9LVXpE6bFu65k96YB/N1IKsm+m0roI7X+U0mQx4T5dNx+viuq0bya5jaTEry32J6grMKG6LMfnb7/OmnnQX9reNgH4P3Gwo3R8Pq+C9MReujHCnHDW+XKJ/FQa8y53a2xXbooorCWz/xi9FAur3Y5NngfK8RX+Tx7Rs+hg5XaG07hEVnGOPkuQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDZIlU3xkPUJonmzOvIj1hfRSE8pCfo9WR/cMrCdGTs=;
 b=ds/SKGz74dks/X8PkEmN1fG1sKCjM6bmxqaIlmnQIzAKPjzGIn6G7xKkuDcEXWB9AgSX1e7fVs8Fl8mUCqRU85a+T9cppyegI6lYiPGBJ/brw87FPC9v2TJxdMeQfrwou4oIO6RU3pVcirkydpMpKBwnsijmUuaemWmp/lQ9VRM1mELXGNKe+ZlwBREQGkznN3G7QpWym80Wkd2OH/jsl985GY5BsTEiD0McfsrY+TrVvyqnhTniBUrM/ZtNGIcmle4tSQh5chHmV4BGCeEqMqjn4E+TK7NFCzHdv2uC8VOGE8K/z5CjS6RDTM9lA75MpkC11q/qQYA1BfsWeh97iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDZIlU3xkPUJonmzOvIj1hfRSE8pCfo9WR/cMrCdGTs=;
 b=a9zNF8v1CROS2IeFgm6VaXJjMyx7qv1m7wvZek0J5U49/YTJ+rj3TMa0tUeC8R4yvSM5yySNH0UDF70co7LlC0PCGDk3z7beBnd/U+FmRd9fiHuK9X/VULNLgr74eS1Mm7ppOxvNEdE5y7STbEn9rw3jR+PC6CM9ne+uumcRXA8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH2PR12MB4120.namprd12.prod.outlook.com (2603:10b6:610:7b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Wed, 19 Apr
 2023 14:52:16 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57ca:ec64:35da:a5b1]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57ca:ec64:35da:a5b1%7]) with mapi id 15.20.6298.045; Wed, 19 Apr 2023
 14:52:16 +0000
Message-ID: <36ef8031-40a7-3324-7b4e-4510f11a488b@amd.com>
Date:   Wed, 19 Apr 2023 09:52:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 1/7] x86/resctrl: Add multiple tasks to the resctrl
 group at once
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     corbet@lwn.net, Reinette Chatre <reinette.chatre@intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
 <168177444676.1758847.11474266921067437724.stgit@bmoger-ubuntu>
 <d046eebf-15b-2d23-b8f6-5dd06b49d0d3@linux.intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <d046eebf-15b-2d23-b8f6-5dd06b49d0d3@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0349.namprd03.prod.outlook.com
 (2603:10b6:610:11a::33) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH2PR12MB4120:EE_
X-MS-Office365-Filtering-Correlation-Id: fb4c2351-2bfc-4449-747b-08db40e5aaf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bU13s7ZNw/SdBNE89gSO8aKONpW3aBWAncVLGKHeIg/XcY4YWfreA8sd1bknneaZGMRldk6o+GdrKD/bZ9PKpgS5X6/twCvJQmLlwt1iVGHn+JOsvgnb5aUJD2W0GacKWMw2ak4PrqsMSkuodPHYLscTVDkVEqRzk9RO5Lp2FXdzh0XiEOk82NpPF9/cz8LBoTfgnskhEVMcwFSMoclj90bYSvawH953w9/a6NErfgRS0y+hxmyfTEOLgXP0ybSbj/SlPA8g8t0BopuYvgDGOvQ0hHX0MYsZwN1rAm4lXEIo+Am0aZbr8vcj2pPqhbuxmZUEJh2hAYoseq+Vgv1LHGHWAkH44WqVtCw3ohijeqcYs6/3xGbSQOTIwuAx+wo64pdXb5fTfPaGUtVkyvA9HdD/FfwZ/aiPka3+iOSq7oPxoZZJJp0F1Qe87vTC00C0JjkoQ+FixfHpUJXjhBotDyROKF6rREjP0b2xLCNb2T21PHsVYDvIsGIICxcPNYaaGgirNDgp5C/NoDukQS8JPnvYAPH6hioOVEMcYApc8kNgjonTTHCFgkgxbvsN0R3qGrvyDNRe8kV0d3YvKFK7ydLcuehnUpBXy+Cj+XZZ3sRVQKmrR4Et7D0zLljT7DI5i2y2cAohOLA2RmergsaR/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(451199021)(186003)(6916009)(4326008)(54906003)(316002)(66946007)(66476007)(66556008)(478600001)(6486002)(8676002)(8936002)(6666004)(41300700001)(5660300002)(3450700001)(2906002)(7406005)(7416002)(86362001)(36756003)(31696002)(38100700002)(2616005)(6512007)(26005)(6506007)(53546011)(66574015)(83380400001)(31686004)(66899021)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGlnTGovK0t5MDduVE01VlJhN2ZqSXlsd1hyNHRkK1VFQS9KUmJyMXVsbWI5?=
 =?utf-8?B?OE10T3VCK0tLNmhpa1RXbVJBa3M5OEhYU2l0UXlGY0RCMlBYSzZwNUNpN1Fz?=
 =?utf-8?B?NUlzMFhrZ2N6Q3BRQUg3T1pxaS9BRjBkN0N2OWJFc3JibzFUNDRORUgzU1FV?=
 =?utf-8?B?ODVIY3dhTHo4ZzVQcFIwTVNjYVN6M2hVTVZkTEpmVlo0ZXM5M1dzNE1wOURw?=
 =?utf-8?B?N1B2TlVpNFRDQ3UvRGM0TkNQcHc2L1lUY2Y0dDlkanMrWkMwSlZsYy91b2pQ?=
 =?utf-8?B?UVBJUndTUDk4a1ZNUysrTTdPdi9yNFRnTjZtQVhHcGl0d2xzcURLRlkwS1Jk?=
 =?utf-8?B?SGlqQjBlRDNxa0RDLy9rVUlsNE84YmljdUhXcXlub1lUWlM0OHl3TlUzVFdY?=
 =?utf-8?B?Ny9RdXhxR2dtMTNRQ2pZYTY5QVdIVTFkSTY5VlNCSWlvTmxSOUMraG1hUFdm?=
 =?utf-8?B?UngxQnJEd3hnMWJHeU03YkNJMGZoaU5lTFREOW41T3kzSUpNRXE1UUJmSVA5?=
 =?utf-8?B?OXBlanNCbDdhc3RJVEFFU2p3Q1VQUFJ6cW4xaGF0a0ZxdGlKOG5DR0V6OEsx?=
 =?utf-8?B?WFFUSHlDQ21KOVNiYjcrYTZxQWswdmJNSkc0ZDJLdFF2Yk96K0xneHY1T3Ri?=
 =?utf-8?B?VnMxOG9icnJzenpGNHhqMDBLU0JxbjY5WGtFSSsrUHhRYy83ZE9Fa1o2Z1U1?=
 =?utf-8?B?RmduVWMwK21YWDAreU5XenRaaDVYVmplYk0xYUVkaFExSFRIbXdkV28xa0l3?=
 =?utf-8?B?dFNOamU5NVVlb01uRmR4cVp5dHVXVU9yTTkxT1U2Zk90ZjFvbGd3M3RqVUU3?=
 =?utf-8?B?cmdTWVk0QVVaQzVpNDdDRHNPS2w4ejUzZHVqemNpY1BQV3VFSDFteUxDemhO?=
 =?utf-8?B?bExrQnRkbnU5cEVGTGhTOGVhU3B2Y0lTTDk1KzZYRHBwQ2RPTlNxR0k3Mm9s?=
 =?utf-8?B?N1hua1hOa1UybXNTcUdrVUVhQ0d5SjNiT1pTOS9CU1E1RndoZ0s2VVhZRzNw?=
 =?utf-8?B?N3dlYW44L1NTZiswODlveUU4Y0pLUlAzM2RIcTFwZmRMcUhmeU5QN0Zybitn?=
 =?utf-8?B?anRUSEtwb00wTllMbXcxZ1RKTWZONHVzc1NmMndBaUI1WUJSYkN0TkZkRno3?=
 =?utf-8?B?Y2RrM2gyTHU4TEhxNkpnQS9UOWdXUWc1b3c3eVA2enpKMkFnM0xyaXZhSk82?=
 =?utf-8?B?dXBnaXVHM1IrTHd6SHF2V0p5cVF2L3VnRmdSSTdOWUcxaFJEbTFJeWZnbmJh?=
 =?utf-8?B?OHU3dlBNcStVeFkzeWtseWtZVU5SNGNVNUtJcXpYZzdEdHlnUldqbUJ4QmNF?=
 =?utf-8?B?WU5tZld3RGRWN2V2L0E3NzRRZTlVRUwwQi9uUnpsU3ZBRHd2Rk0yeWVxa0hT?=
 =?utf-8?B?dFdGQm45MnBUSXkrK1NMWlZTZ2VlRENUZk12QlpFeXZiUFRxY1FCUEhGQTZs?=
 =?utf-8?B?TmpRaUsvSEV1Z1pZOHFwVms5RzE3US9GaU9CemVmRE40R0gzQm0ydDZ4YUxl?=
 =?utf-8?B?SWpnd05XbERLS2JuNUZSdWZtVEFlN3FQSlhEbHhGUCtUMW1YNFZhdFRZR0Vv?=
 =?utf-8?B?bXJQYmtvS0pES3NCUDBXK1F4Wmd2R3RtMzE4ZGxJTW5hQUhVL3pDM2N1bk1K?=
 =?utf-8?B?VWNqT0F3SmdLYVYxeGJYeWw5TkMyRmhFUjhYNnhYK3NKMjNtQkRqanZ4OG9Q?=
 =?utf-8?B?akVRVEtKZU1hVUFZZGNVM1ZWQTlIdk5hZTh3dGFmQmtybmZwYWZxZDhKenRI?=
 =?utf-8?B?Snp2amlpdUJSZjJsU3c3UEZHaENoWjkzdHB6OTFLUVhMZEpmdjNPWkxjRXFF?=
 =?utf-8?B?YnUrbDJlTkJZUmVDMnY4TXB3ODBSUytYNzVvbWgyWmdGWm9SZ1FndGkvUmpm?=
 =?utf-8?B?bnJDK3pjRmhyZFU3SkNuLzUyNGx3NGJkZnpqbUZuWWUrY0RlNGpBM2E0SWhm?=
 =?utf-8?B?LzlFVXhIYWJMRjFnenlYR3I0SFhxV29VQW9haHVPS0JIRmUwOFVMTnZDMFl6?=
 =?utf-8?B?YWpCc1JyMFMvMFEybGQxTnRBL3JwR3hHSkNmMjVuZ004M0w2TVIvSVRXS3NP?=
 =?utf-8?B?MVJmNzh4a2dZYUQ3UVhRS01jUkMvdmtETHRlN3h1bXU0Y1ZrNENOaWNXNWVF?=
 =?utf-8?Q?358c=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb4c2351-2bfc-4449-747b-08db40e5aaf2
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 14:52:16.5572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JaHJV+HkH8ZxVqTQ8BROVmBkkz+oMUG7nSw6OdaUPbZnEoYAL3YKwp9tMVu1ql5k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4120
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarvinen,

On 4/19/23 07:58, Ilpo Järvinen wrote:
> On Mon, 17 Apr 2023, Babu Moger wrote:
> 
>> The resctrl task assignment for MONITOR or CONTROL group needs to be
>> done one at a time. For example:
>>
>>   $mount -t resctrl resctrl /sys/fs/resctrl/
>>   $mkdir /sys/fs/resctrl/clos1
>>   $echo 123 > /sys/fs/resctrl/clos1/tasks
>>   $echo 456 > /sys/fs/resctrl/clos1/tasks
>>   $echo 789 > /sys/fs/resctrl/clos1/tasks
>>
>> This is not user-friendly when dealing with hundreds of tasks.
>>
>> It can be improved by supporting the multiple task id assignment in
>> one command with the tasks separated by commas. For example:
>>
>>   $echo 123,456,789 > /sys/fs/resctrl/clos1/tasks
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  Documentation/x86/resctrl.rst          |    9 ++++++++-
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   31 ++++++++++++++++++++++++++++++-
>>  2 files changed, 38 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
>> index 387ccbcb558f..f28ed1443a6a 100644
>> --- a/Documentation/x86/resctrl.rst
>> +++ b/Documentation/x86/resctrl.rst
>> @@ -292,7 +292,14 @@ All groups contain the following files:
>>  "tasks":
>>  	Reading this file shows the list of all tasks that belong to
>>  	this group. Writing a task id to the file will add a task to the
>> -	group. If the group is a CTRL_MON group the task is removed from
>> +	group. Multiple tasks can be added by separating the task ids
>> +	with commas. Tasks will be assigned sequentially in the order it
>> +	is entered.
> 
> "Tasks ... it is ..." doesn't sound correct.

How about "Tasks will be assigned sequentially in the order they are entered."

> 
>> Failures while assigning the tasks will be aborted
>> +	immediately and tasks next in the sequence will not be assigned.
>> +	Users may need to retry them again. Failure details possibly with
>> +	pid will be logged in /sys/fs/resctrl/info/last_cmd_status file.
>> +
>> +	If the group is a CTRL_MON group the task is removed from
>>  	whichever previous CTRL_MON group owned the task and also from
>>  	any MON group that owned the task. If the group is a MON group,
>>  	then the task must already belong to the CTRL_MON parent of this
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 6ad33f355861..df5bd13440b0 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -696,18 +696,41 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
>>  				    char *buf, size_t nbytes, loff_t off)
>>  {
>>  	struct rdtgroup *rdtgrp;
>> +	char *pid_str;
>>  	int ret = 0;
>>  	pid_t pid;
>>  
>> -	if (kstrtoint(strstrip(buf), 0, &pid) || pid < 0)
>> +	if (nbytes == 0)
>>  		return -EINVAL;
>> +
>> +	buf[nbytes - 1] = '\0';
>> +
>>  	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>>  	if (!rdtgrp) {
>>  		rdtgroup_kn_unlock(of->kn);
>>  		return -ENOENT;
>>  	}
>> +
>> +next:
>> +	if (!buf || buf[0] == '\0')
>> +		goto unlock;
>> +
>>  	rdt_last_cmd_clear();
>>  
>> +	pid_str = strim(strsep(&buf, ","));
>> +
>> +	if (kstrtoint(pid_str, 0, &pid)) {
>> +		rdt_last_cmd_printf("Task list parsing error\n");
>> +		ret = -EINVAL;
>> +		goto unlock;
>> +	}
>> +
>> +	if (pid < 0) {
>> +		rdt_last_cmd_printf("Invalid pid %d value\n", pid);
>> +		ret = -EINVAL;
>> +		goto unlock;
>> +	}
>> +
>>  	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED ||
>>  	    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
>>  		ret = -EINVAL;
>> @@ -716,6 +739,12 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
>>  	}
>>  
>>  	ret = rdtgroup_move_task(pid, rdtgrp, of);
>> +	if (ret) {
>> +		rdt_last_cmd_printf("Error while processing task %d\n", pid);
>> +		goto unlock;
>> +	} else {
>> +		goto next;
>> +	}
> 
> Why is this not changed into a while () loop??

Yes. I can change that. It might look bit more cleaner.

> 
>>  
>>  unlock:
>>  	rdtgroup_kn_unlock(of->kn);
>>
>>
> 
> 

-- 
Thanks
Babu Moger
