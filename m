Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16C665DBC1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 18:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239517AbjADR7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 12:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbjADR7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 12:59:09 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9B0E7;
        Wed,  4 Jan 2023 09:59:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0g9uwzrubLbdq5ZC2gQCCKXjRkfBt8tyKCYfmSn8YZ7ktEcgq2Nz8Xq6sE9kuSuEiO2CFPtnD05N0VLsWQMCofGjM9ghUcu1/3WstuBCjDZhd00nHFnDKEUlU8VpYUhFl1xLCzAopRO853PI7W1L8J6CtdBHmQ+N4Xdy41pRZ+BNJYSo/SLiBd21eOMa5AwfAzZemUTn6NL0mS/5UKfwkDW4HFobws8Nt+Cs2UIxu9h68DuL9L0nJxeACmk4Cnvaj58a+vkXg8scj8QioTd0mq/rpl9fcho2BW2GRxYrtE7wrTxq4Tf4hc0dXbqLYEO8xrA+qSR6Wc1ryJ9WY9i8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVY7leu0r3WOaR93D6ljgI8z7mll3l9JUOGyhWaLENQ=;
 b=n0QbxJ8hkmJfvMPNewccrdfz0C0KcC/Jd/4IwZBJUcEOamm3IjQ5bVAI1p9Ljlu8PEJF+TbqaWxYvip3D7YpH5uUtYTTwMKRrkZnbetiGCt0XPRxdVLLfluv+CQnsFWZv2gTz3dXgIKZobOkWQ4PKDSOc5Xb1b32IhExTcU92KXHz76FASZcHUVj0n5ta2dOuuhKuuhTokFONqksv/PvJ4R6g+oVAn2lZ4Z57la2YHRdaGf1P/zzTQ1fuO+W9tyqlkayrnPGnXJYIyOk3AbR8VxY1rlgGZg8M/48qNUY1ye6U/laXGMnHo+QaWngAiznXcP5EvFt9wt+NBhjqi7nxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVY7leu0r3WOaR93D6ljgI8z7mll3l9JUOGyhWaLENQ=;
 b=vWqorKG1OHNlwhHBOxvcWI6wu1Lhcwnh5Y6HIqDUVuV6bwrgq8nygGKNV1+oF/kiXkRT7i4qAozn33rH1kMdI73MqlkQvNZj64vcPJuPy0+ew0GkBvnbBXYceGcCkbhmOb/qQejCItaFIWKHD1zq4NAIgmCE8ZH3fKX1u9a0Ns4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BL0PR12MB4945.namprd12.prod.outlook.com (2603:10b6:208:1c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 17:59:04 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%3]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 17:59:03 +0000
Message-ID: <58d53ab6-df0c-9e8c-052a-a8b60c9a8258@amd.com>
Date:   Wed, 4 Jan 2023 11:58:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH 3/3] x86/resctrl: Display the RMID and COSID for
 resctrl groups
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
 <167278361325.34228.16916982678071203069.stgit@bmoger-ubuntu>
 <IA1PR11MB609764AC3E09E0A1F8A8FF7E9BF59@IA1PR11MB6097.namprd11.prod.outlook.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <IA1PR11MB609764AC3E09E0A1F8A8FF7E9BF59@IA1PR11MB6097.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0228.namprd03.prod.outlook.com
 (2603:10b6:610:e7::23) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|BL0PR12MB4945:EE_
X-MS-Office365-Filtering-Correlation-Id: 19a58209-c3ae-42af-ec09-08daee7d5d78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7vEMExFi6LRY8ZPWC6aX+1Y296v7hksQn6jmYKnbuv4g+l7yEjUxIL3wkr4nSqQWk6L/YVxMwiodaPsQ6ciNLErdJ+KvV1/P+rA4ulKZBbHjdYJdK2z59qUlxT5254/XFfAZkL4rPHDGssZRqzrEY3eX+ZwSa2dZLnftdLrGMjLth29w734VqvfeTH+qDN9gFb0fbrOSFiQStDLca24SX276Qm4lkSQ7d68cTzmXoa1WL2lqj5p7qJqZHe9oi0afDe0f0x+T0YR/FGL5EtXOemkbrS0Fm7J/I1XKQImlh4Q+1m9RN0yClvc4MgAxSWlZdNys5r4Vd+3XJ6FSPjNAOITpHLGQIdiZTElFM4bMvufIdaxk6JyARv7GD2iy75byKknMqroQBuc4r+pSa6d3/x3unwNynxQVTuzfUzquMtNQQSF4Qpuz6lxBaUdAIxoinUgBI5S8DOo88fjxdGPvItlCUcf5O51soK2LP0fo0PhF21+Ey1yzUfAlqJPwsTVOnEWdy9yv+jTq1dtQpJdDjlD6llGv19LQXPSxGvbGmgTpXCyTUYzooS718kW/OHF//aJ0T3iU2BpdKeN2Pz7a/QYza4UxowbfLXpdvsCq7+gEa19mEcREtiNECF+MrFyH4rVUQP+JvT+hndlh/ozWnSPF0W4nK4y8YSiY6Zh/ASijnTEbdqkCGs6k1JZnaKPeNJ6Nddd+IagpjQL96zSGpGHWyWPGs1yRofbhNgsRO5w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(451199015)(7416002)(3450700001)(5660300002)(2906002)(31686004)(8936002)(4326008)(8676002)(41300700001)(66476007)(66946007)(110136005)(54906003)(316002)(6486002)(478600001)(66556008)(53546011)(6512007)(186003)(26005)(6666004)(6506007)(83380400001)(2616005)(38100700002)(86362001)(36756003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEw3b2h5U1lod2k1aXJibGJLQmZPYVVoeEc5SlUwZlNUb2wzLy80dU5oUzdC?=
 =?utf-8?B?YVpBK0tvTGdvOUpDbW1abzN1eW42N2xUODMvRENZbXAyMmNYU2d2Zkw1ajBU?=
 =?utf-8?B?SmNNVTZ3Zm40dnJIVlFCQTlBVlVSZ2lYV3JrSU95SzhYWDRTT0Y2QzM2bTdV?=
 =?utf-8?B?L0RaaG1hb05zdHZUcFlCMm55amRNc1pmWlRQdkFBU21yakxxemhGcHhXVVZ0?=
 =?utf-8?B?WmJUNDRRK2VpYXR0aTlGT3R1azBYcHY4bWpwSFRWa0NrVktlbW1BY2RKYUZU?=
 =?utf-8?B?anNxWUx6WmVtTUNTdmkrTnhaR2xJMHcvRlJUU1R5T3M2VmNlbllNVEIvUFNi?=
 =?utf-8?B?c3JKajhFbmdIWFVMUTVqWExrd3JWRG9QVzJoR3pPcGxtVW5nbXFZeE1TUkVQ?=
 =?utf-8?B?NVNrUlVkcWtrQ2JrTXBsMCt3T1hpdHp5eGxJR3N0WmQyc1hGTGNmOGVaMmZO?=
 =?utf-8?B?Y016eE1UQStVRlNiN0RTSWY2Y2pVV0ZXa2J5bGNOR2tpdGZGUDcrUkxNTDQ3?=
 =?utf-8?B?dk53OW5BNzVMUGRaaDVRMi83UEV6ZTMvQkRoU0gza2Erbk5Wdm1RWW0xb01M?=
 =?utf-8?B?SUpzL21JYk5LL1A2bWdwQlZ5ZFJ3RUhxeExmWVlMcHJaQXB1M3c3YTllSE5Z?=
 =?utf-8?B?bUVDTnFVUzBlZE9Qbm9TS3k3MkhoZ0lEOSsyYm1SVWlZRzBSUDYxNUY2eE5T?=
 =?utf-8?B?bnBsYzRSam5ZaVdPWTFEc2NKRE1TR0dUNHA0QkR2RlpnSExjeW4rNHQvNGla?=
 =?utf-8?B?Mzk5anZ5Szc0Qmh0U3pSMXpzMzRIejdja29TaGRwS2tTNm1yd0xIVnZyTld1?=
 =?utf-8?B?L25rS255MG9NaXVkZSs5c28wRnYzdTRxVmVhSC96c2JDblRQUFRhRElQNWNz?=
 =?utf-8?B?OS83S1I3bHFUY2FwbTJZOEZYWm5ENGZ5T3JFK2NXaTVtV2hBb1J5MXdlMGR4?=
 =?utf-8?B?UDZMTUY1Tkx3TzJVZUtLbFBYeHVTWmhZR0xNQzRYVEhCbWh6UitvSFBSQWNu?=
 =?utf-8?B?cDlsTUhZbVZVS2t6aTRLUmdKWkFuMkgrcldkS0RTNm5nZ0FLK1NVaVBnL25t?=
 =?utf-8?B?bWUxUThhd2ZLUTloWCtTZm84dVBrTFI5RGQxR2RQYkFlYkR6dElMRFpwR3F5?=
 =?utf-8?B?ZnFyMEtIUlZKYWZHKzNxQ3dIUkZ2MllPQjlWL1h1T1oyZGgrTmZ5eDhMRWN0?=
 =?utf-8?B?Q3hRR1NHTi9JOWdOTEFOc3VtN2FNdzNpaXlRaEZrazJHV0txcjZTSVNiaUpi?=
 =?utf-8?B?WVFXRlJPL21SbVdOOElCaS8yRVpTTzNsQVdKdExqMi9zRU85bElDRGlCT2xE?=
 =?utf-8?B?QTAvZmU1dnRtWjVibkVoOHBHS01GTWRkQS9ObzJPbGVjRW9Bb1hVVHptM1lj?=
 =?utf-8?B?Sk4yL0tIeDk5cnBxY1RXYzBOWERLd3IxdU1scitxeW43N1B2WlBrdzNoUmpC?=
 =?utf-8?B?T3BzT01UampBS080RDVML29qMFduZWtSSlE5Nm9Gb2lIUGxOQ0JkMUg1dFNE?=
 =?utf-8?B?MmIwZFM1clFDclBIZTI3bnNXSVl2YlF6NHlnS2RvMG1NTnpCdVJUbmRQbGhu?=
 =?utf-8?B?bHFoUlREQUV5NnlPcFVaL1RVZ245ZlBsUzVtK05GbDBTdzBHQW9DcWNQb1cx?=
 =?utf-8?B?Nis2eXdpM1cvbG1CTExPZG5PQjgvSjN0dUkyVVE0THlCWURNUWpjdmVHb1BH?=
 =?utf-8?B?a3A5bndhNkR0czI5MHVIRzRPaFFEUGNlNklHYnpKTUQ0blhLeHArUnNyT1JN?=
 =?utf-8?B?VjlsclJJUklMMzdQK0tBcUFRM1JBTU1mcmxBVzkwQ3Z6eC9mRzA2S3VaUmRS?=
 =?utf-8?B?ZXJSQXFENGI2SnZleG03UmMwUm16SmltNktWM2lta0IzMHhtR2ljR0VJdjNW?=
 =?utf-8?B?S2ljaTdITGtiTXJNMlZzNG1PdUVBUTJRNGRaYm5iUTZKTklQc1VwVkRZYVc3?=
 =?utf-8?B?QzNCM3laNzJwczN3NlMvbXdvQy9QcUl0L24rVlRzUVBjNThnNHV6UmZ1UU8v?=
 =?utf-8?B?TitBL3BkUDNGTmpPUWpxdDNZWVp1a3BuUGUzZHFMZFF0WFV6WkU0Vml6cEtV?=
 =?utf-8?B?QStUVE90QzNjcyt0R1ZscWNjTk5vWlZKeWsySlRLdjlqdFRXOGUvMnBwMTZU?=
 =?utf-8?Q?36BfWCCqLzMhkXxucoDEPCvnA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a58209-c3ae-42af-ec09-08daee7d5d78
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 17:59:03.4281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 086ZAKNOTvaeeCcBpS1odjcwUu7W5jNGxc848Rb/TatMuMm7vdUCKIStK6NrP3jz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4945
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

On 1/4/23 00:06, Yu, Fenghua wrote:
> Hi, Babu,
>
>> When a user creates a control or monitor group, the CLOSID or RMID are not
>> visible to the user. These are architecturally defined entities.
>> There is no harm in displaying these in resctrl groups. Sometimes it can help to
>> debug the issues.
> Although "no harm" to show them, it's not useful for generic user either and may
> cause confusion sometimes. CLOSID and RMID are supposed to be invisible to
> generic users.
>
> Maybe introduce a new resctrl mount option called "debug" and show the files
> and maybe other future debug info only in debug mode?

Actually, test team feels very strongly about this. Whenever there is some
issue, first question is what is the rmid or closid are you running on? We
normally don't have an answer for that.

In my opinion, adding debug mode just for these two fields seems way overkill.

Thanks

Babu


>
>> Add CLOSID and RMID to the control/monitor groups display in resctrl interface.
>>
>>   $cat /sys/fs/resctrl/clos1/closid
>>   1
>>   $cat /sys/fs/resctrl/mon_groups/mon1/rmid
>>   3
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  Documentation/x86/resctrl.rst          |   15 ++++++++++
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   46
>> ++++++++++++++++++++++++++++++++
>>  2 files changed, 61 insertions(+)
>>
>> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
>> index f26e16412bcb..8520514bc8b5 100644
>> --- a/Documentation/x86/resctrl.rst
>> +++ b/Documentation/x86/resctrl.rst
>> @@ -231,6 +231,14 @@ All groups contain the following files:
>>  	Just like "cpus", only using ranges of CPUs instead of bitmasks.
>>
>>
>> +"rmid":
>> +	Reading this file shows the resource monitoring id (RMID) for
>> +	monitoring the resource utilization. Monitoring is performed by
>> +	tagging each core(or thread) or process via a Resource Monitoring
>> +	ID (RMID). Kernel assigns a new RMID when a group is created
>> +	depending on the available RMIDs. Multiple cores(or threads) or
>> +	processes can share a same RMID in a resctrl domain.
>> +
>>  When control is enabled all CTRL_MON groups will also contain:
>>
>>  "schemata":
>> @@ -252,6 +260,13 @@ When control is enabled all CTRL_MON groups will
>> also contain:
>>  	file. On successful pseudo-locked region creation the mode will
>>  	automatically change to "pseudo-locked".
>>
>> +"closid":
>> +	Reading this file shows the Class of Service (CLOS) id which acts
>> +	as a resource control tag on which the resources can be throttled.
>> +	Kernel assigns a new CLOSID a control group is created depending
>> +	on the available CLOSIDs. Multiple cores(or threads) or processes
>> +	can share a same CLOSID in a resctrl domain.
>> +
>>  When monitoring is enabled all MON groups will also contain:
>>
>>  "mon_data":
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 0d71ed22cfa9..98b4798e5cae 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -769,6 +769,38 @@ static int rdtgroup_tasks_show(struct kernfs_open_file
>> *of,
>>  	return ret;
>>  }
>>
>> +static int rdtgroup_closid_show(struct kernfs_open_file *of,
>> +				struct seq_file *s, void *v)
>> +{
>> +	struct rdtgroup *rdtgrp;
>> +	int ret = 0;
>> +
>> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>> +	if (rdtgrp)
>> +		seq_printf(s, "%u\n", rdtgrp->closid);
>> +	else
>> +		ret = -ENOENT;
>> +	rdtgroup_kn_unlock(of->kn);
>> +
>> +	return ret;
>> +}
>> +
>> +static int rdtgroup_rmid_show(struct kernfs_open_file *of,
>> +			      struct seq_file *s, void *v)
>> +{
>> +	struct rdtgroup *rdtgrp;
>> +	int ret = 0;
>> +
>> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>> +	if (rdtgrp)
>> +		seq_printf(s, "%u\n", rdtgrp->mon.rmid);
>> +	else
>> +		ret = -ENOENT;
>> +	rdtgroup_kn_unlock(of->kn);
>> +
>> +	return ret;
>> +}
>> +
>>  #ifdef CONFIG_PROC_CPU_RESCTRL
>>
>>  /*
>> @@ -1593,6 +1625,20 @@ static struct rftype res_common_files[] = {
>>  		.seq_show	= rdtgroup_size_show,
>>  		.fflags		= RF_CTRL_BASE,
>>  	},
>> +	{
>> +		.name		= "closid",
>> +		.mode		= 0444,
>> +		.kf_ops		= &rdtgroup_kf_single_ops,
>> +		.seq_show	= rdtgroup_closid_show,
>> +		.fflags		= RF_CTRL_BASE,
>> +	},
>> +	{
>> +		.name		= "rmid",
>> +		.mode		= 0444,
>> +		.kf_ops		= &rdtgroup_kf_single_ops,
>> +		.seq_show	= rdtgroup_rmid_show,
>> +		.fflags		= RFTYPE_BASE,
>> +	},
>>
>>  };
>>
>>
> Thanks.
>
> -Fenghua

-- 
Thanks
Babu Moger

