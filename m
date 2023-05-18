Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F63707879
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 05:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjERDbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 23:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjERDbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 23:31:04 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB0E30D2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 20:30:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WFGze6yYm1PoownDKFhaN1Ba35fKwwHF08WtNb0l5+L2hj2p/gn4MkeGcsxzneoYrXC/X7DNrR1DS/2zAxrIeg1kEMOACLI95J9dMvhpCYb3neEvbsoHFqi6A69dVhvCEMEcYcaBplfx5XkohIKgPM2hQS43cq1H/m8bgT2iYYYj5SmxVr7dvMkUskfZ+yGKs7yNbdByasdVYZDDCYYutM3igcLoD3Po2PNNizx204abvi58aEuwfWMFt9vQIWUsAeaDnvPodQb6OveSYvFgAFKb5EgSHFHydUjK2wwOFs0UX2dDOZGNyXy6QbLjaKbppU2TVffow864W+V+8iKmSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSz5gw72J85pRO4qECysO8uR06VwQ2kPI6A7kcZJPp8=;
 b=koGfeGqt5jpU3uaxYyq+YLD3NnuvZS7+3T0LsVMbbmv1GAMaT+J41Th2tVOunu30GzZ8+a/xPRIl4tGmCRaKEWLwTjZ74Fq8KDPE41bKhadi2wytLKyzfnTyz8FExMUoL6eBnIZaDUidyZa3d7LptnKYNcBW8bZSfPfzZXr/bPQi7jzk57feTCrMl8cr5Jr+jVBu2N2Rhp4YKDQMolpEhwt6vDD6mNJeQhB/VWSbBzrjp6R++/6VyNbYAmBpHYBgEDyPm3ZEMk/LFX0Uy8L9b+S8FkXQrO0xTr250LpTw6aQ66KnCacE0Rg85o3cSkx4hCQDJMf0sDgGGEm6x4DNNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSz5gw72J85pRO4qECysO8uR06VwQ2kPI6A7kcZJPp8=;
 b=O/R8kSbvBNysR0QkUdtCePHnvoglqjj6YHLCT/0eTCc2yN+E9NqposUS0xkIszrZPuMWpfsCjwhid1quZojbjQlJSR9aTSAAa62VUaRtwYLUW2Xh4gWA3q47+k9DnNTVdw+wQMI5vUWIET+VBmh67asJ5RW/D5RUZ4pRtjGmtTE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by DM4PR12MB7694.namprd12.prod.outlook.com (2603:10b6:8:102::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Thu, 18 May
 2023 03:30:52 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::b197:512:a4ca:6e9c]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::b197:512:a4ca:6e9c%4]) with mapi id 15.20.6387.033; Thu, 18 May 2023
 03:30:52 +0000
Message-ID: <0ac968e3-cd80-6339-970d-37005876b145@amd.com>
Date:   Thu, 18 May 2023 09:00:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH] sched/fair: Introduce SIS_PAIR to wakeup task on
 local idle core first
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>, Mike Galbraith <efault@gmx.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tim Chen <tim.c.chen@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Aaron Lu <aaron.lu@intel.com>, Barry Song <baohua@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20230516011159.4552-1-yu.c.chen@intel.com>
 <19664c68f77f5b23a86e5636a17ad2cbfa073f78.camel@gmx.de>
 <ZGNBt7vWJ3fDs5Sc@chenyu5-mobl1>
 <795a6d9475ecb444d219a9d36dc93b48a69e960e.camel@gmx.de>
 <ZGUHa+Si4dJbdsZN@chenyu5-mobl1>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ZGUHa+Si4dJbdsZN@chenyu5-mobl1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0109.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::22) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|DM4PR12MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: 6311d57d-cffc-42c3-18f1-08db5750477d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ystOKUVo6H4fUiKXavOuZsqLc6n67zsah2gC7AmqfzI/qaZQXNj7fTe1HWq0CLZCXQr6+ivpCJb+l6Thp7UJd1CzXSzKeW+HIXIYZa2ZNuMEgdnM3KKCfLrRfhUfo5SYdktzme4mrsmCiDUcQrMPIBwUkLM8U4HPdqFpoEEp4PTiQuhPa+WUKdrvE0PVn1cIX3g0+LDryQiPAcO32WRXhrVqwH+kvzxg/AFPnBdI3+uKlOtt9B7KIuzm6UUHEFLXrhIu0IfbuB8z/iaDuBF+R92a7+LWi1yl6pGwnAhgfMzOKYi6bMsD/3G+hid2xr6BYsHewc1DwXWBahznky/d7sHb0NV3bIKaPcYtrmJv61Qs30RqrPrZv3/JpkGrFvwDUfIc0c2fq3hhdISUQACVx91jGzeII1J33wPk/e6wVGYDyCJLn2JT8mL4ns2mPYMN1CxcCCsOpSyTGJYrthr4HZCMdu+OAczIrdXPGW0XiSQEgH7jTgvaacW+e4fIlpLO86mY/2oKMkWBvudm2ZPKl9Md4GjXN6JPLHss8qmB6CH99BrzUtuDt+r4uqVEbnz3Dnhtewtp6HhDxNlGhrJLSxpSEBfcNj+6YfNVx1qgzKEAjle3Zzn1YHv6I5nahziLRKPcOJfjEy5tw8shG/Lbpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199021)(31686004)(38100700002)(31696002)(86362001)(36756003)(8936002)(8676002)(478600001)(5660300002)(26005)(6506007)(7416002)(6512007)(41300700001)(186003)(53546011)(2616005)(83380400001)(2906002)(316002)(66946007)(110136005)(6486002)(6666004)(54906003)(66556008)(66476007)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aURYSkMyaXc5RkFWY3pxU0tMcmJOcFVTZkd2bTBBQmZLQi8vYi9Qb2pkT2pn?=
 =?utf-8?B?K3dmWFVqL0d0a0JHT1BLT3FSd0JxVWdPMUJqaWVuYWpTaUYzdDNXblBTZUg5?=
 =?utf-8?B?MnlrR1hMQ1d0QlRhRjFnR1NLVnY4Y0dqd21qY1hzYVZhTm1yUkVaMzlzdUZG?=
 =?utf-8?B?QUFwdkRvdXpkRjV6dVZMSGFBZnhOcUdVTmZSVndPRy9uTndhb05WSmhRaUxi?=
 =?utf-8?B?V0NUdXRFZ2FmQnlwRUljdWsvSkhPVXUyVVFkNW50N2xmVlAwSG42T2M4NHZC?=
 =?utf-8?B?M1hHaHVkMkZncXdPS1ptTThic1BSZW5FcXBSejBpUWV0NEJsRWtyM1poN3pr?=
 =?utf-8?B?dnBETi9xVURzSVZRQlROMFBnMHp2d3dKWHBHME1VVzh5UTVFUnRWek1iWmRC?=
 =?utf-8?B?MndGdlFWMndwb3BwdHNoMzlDRDA0bUlMSExzT2Y3UldYRWt5YWVkS2hTYlAw?=
 =?utf-8?B?MHA5bUFjUXBsdk0xYXBwbVpKOVA0YWptM09CZFhqWUdGNU1zNXYyT2pvd1Iz?=
 =?utf-8?B?MVJ6eURSdW01WWtOb1RueHZhMWZGNkw3ZzdEakhNcHlyTDcvVktib293TjBr?=
 =?utf-8?B?VWJVNlBtVGY2aWdtWGh4VzNoTURWMUJweEJ0a2FOK0dHRFcwbWw5MlNRaE5K?=
 =?utf-8?B?c3U3cUR3TVZvT0xYa1hSbEU4ZGFpbFoxbnA0SVJBUlU1d1dHbHdKTGRiOVBZ?=
 =?utf-8?B?eUxYRWZGYWwzcEhQWUg4Z09oYzVLVTdEYVpHWEJJV1lJYkZOd3l5MStIdU50?=
 =?utf-8?B?a01ENlhsdzJKNGZpTTVKVDhVR25YZ1dsTWUyNDZ5a3U3OEdleCtlZGx3T1pv?=
 =?utf-8?B?NmtTS21uOWdzaXZLZmlaUWxZVlYyeHpITC80QmFKZHdteDAzaXJLV2ZoTXZv?=
 =?utf-8?B?UXU5V1BzOE8zT2x2QXBrZ2Nlb2F0akhiYzRuQTZsSi9GS3E0MDBBbWRMRjlF?=
 =?utf-8?B?OVN6NEVvVnlQTjZEZXNnZW9NMk5GVmt5cnRON0szbEZhSVVyR2VNVlVhTlZ6?=
 =?utf-8?B?OG5yRS92bk5pWE9VOHNsYXNOOU5rYjc4cmRjd0tRMVZ5YVJSTlI2TkQvZFNX?=
 =?utf-8?B?NlJrdDljL3dYRlBxa3R5bWR5bGovSGVJWm1iVUlmYVJ1WUU3VHJsTjc4NlVy?=
 =?utf-8?B?cWREMjh5em5PUXMyL2JtRWQ2SURjdUxPczJaTzQzQ2Q5WFUvdkFLWWZxMVlt?=
 =?utf-8?B?WmpHTnlyOXJsdVNVOWR6ZHMydnViTFArM2x0WHVkbzFHeStuQVdDVTV2Q0VH?=
 =?utf-8?B?ekdGcXhtU0d5dXZhb1BCbXNtazRtYmY5MGFQUjdFbUhodlE0TXdLRTVaZmlX?=
 =?utf-8?B?ZE85bFh1cmZDWTc3eEUzRG44cHJkZXBzcm9nclY2c09KazZOTG5mQmc5TTZR?=
 =?utf-8?B?aDFOcGdmSktWY0Z3cGRxNlF5czdSRkZDZVlmeWJ5Tlh0L0h4eERkb3JRd21M?=
 =?utf-8?B?OW5QYS9tcFR6NkdVWFVPaFVUSTFFMFFVT2JiMHhtQ3JWOGdGYytkUUhTTGc1?=
 =?utf-8?B?bEYyVVVrTHlSN2hUNFdocDRSdXJsZzlLdkNMRWdOZXBsRGhqcmxxTkJvN2JX?=
 =?utf-8?B?RG5ZckxXQ3ZqZDhEZi9KbXpQeEZVdGZwVW1Vei9oMUpzRFFmbGUxd2JEZm91?=
 =?utf-8?B?bnZwZC9qR0xiRHB1NjRmVVFvR2tjWlcram9VQjRGU2RsSFd0S0xyd2o2YXJ1?=
 =?utf-8?B?Wmt1bHZCaXZMcFpTaWxrRzB1dk1hQndVUlVVUGlVTytXcDY1Sk1QKzBtU2la?=
 =?utf-8?B?NkRoSVBuRnFsQWhGbllOcmVHUGdvb1llMTVmVGRTUjJRU0xmdmtCMWhCS0N0?=
 =?utf-8?B?V05WSGhmc1oycXZ5cVlmQ0ZoNlNrTmZ5TVNyUHVzVk5QZFIyalc4dnRtc0pV?=
 =?utf-8?B?Z1M1elNUTklaVGoxNnNRdU9uc2JTbWZYeVRtbEZORGpzMDErWjFYUkRhOU9X?=
 =?utf-8?B?b01IUGdBYlViRkR1UzliVFZsOEIrTitqdjhUR08yWWwrZ0JXZDFwQlNyaXk4?=
 =?utf-8?B?UmxBb2xxQ0Nyc0pSSzR6TnBSZ2FKN1dtS0FnUGdFajJMYldaTzhPcWFxUkxM?=
 =?utf-8?B?UFQ2M254TUFhS0FQc3hvSzBVRlRtRWpLUm11dEJ6UDJBQVRtd3NrT1NYSHgx?=
 =?utf-8?Q?RbDevZ/+uO2CUHfTEDKEyDk4o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6311d57d-cffc-42c3-18f1-08db5750477d
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 03:30:51.5777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDszVQvnEbJPuZJgYV46ax9PtFMEI46D4S7YoD2EeLSnQnAmlq64J3rcU7Q48RU3T5dPhOdpLKp4mlA/QpuASA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7694
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chenyu,

I'll do some light testing with some benchmarks and share results on the
thread but meanwhile I have a few observations with the implementation.

On 5/17/2023 10:27 PM, Chen Yu wrote:
> On 2023-05-16 at 13:51:26 +0200, Mike Galbraith wrote:
>> On Tue, 2023-05-16 at 16:41 +0800, Chen Yu wrote:
>> [..snip..]
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7d2613ab392c..572d663065e3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7126,6 +7126,23 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	    asym_fits_cpu(task_util, util_min, util_max, target))
>  		return target;
>  
> +	/*
> +	 * If the waker and the wakee are good friends to each other,
> +	 * putting them within the same SMT domain could reduce C2C
> +	 * overhead. But this only applies when there is no idle core
> +	 * available. SMT idle sibling should be prefered to wakee's
> +	 * previous CPU, because the latter could still have the risk of C2C
> +	 * overhead.
> +	 *
> +	 */
> +	if (sched_feat(SIS_PAIR) && sched_smt_active() && !has_idle_core &&

"has_idle_core" is not populated at this point and will always be false
from the initialization. Should there be a:

	has_idle_core = test_idle_cores(? /* Which CPU? */);
	if (sched_feat(SIS_PAIR) ...) {
		...
	}
	has_idle_core = false;

?: "has_idle_core" is currently used in select_idle_sibling() from the
perspective of the target MC. Does switching target to current core
(which may not be on the same MC) if target MC does not have an idle core
make sense in all scenarios?

> +	    current->last_wakee == p && p->last_wakee == current) {
> +		i = select_idle_smt(p, smp_processor_id());

Also wondering if asym_fits_cpu() check is needed in some way here.
Consider a case where waker is on a weaker capacity CPU but wakee
previously ran on a stronger capacity CPU. It might be worthwhile
to wake the wakee on previous CPU if the current CPU does not fit
the task's utilization and move the pair to the CPU with larger
capacity during the next wakeup. wake_affine_weight() would select
a target based on load and capacity consideration but here we
switch the wakeup target to a thread on the current core.

Wondering if the capacity details already considered in the path?

> +
> +		if ((unsigned int)i < nr_cpumask_bits)
> +			return i;
> +	}
> +
>  	/*
>  	 * If the previous CPU is cache affine and idle, don't be stupid:
>  	 */
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index ee7f23c76bd3..86b5c4f16199 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -62,6 +62,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
>   */
>  SCHED_FEAT(SIS_PROP, false)
>  SCHED_FEAT(SIS_UTIL, true)
> +SCHED_FEAT(SIS_PAIR, true)
>  
>  /*
>   * Issue a WARN when we do multiple update_rq_clock() calls

--
Thanks and Regards,
Prateek
