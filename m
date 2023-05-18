Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34812707E0F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 12:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjERK0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 06:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjERK0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 06:26:36 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0711FCF
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 03:26:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlk9psHiNgIaHZS1jOW1m2fb7Jc0/Ihxt3+uQxctIXj85Pa7FfTyWVHa0tviu7kGYdCNy3Hb6LlV+RZLOLj92NqIG0dZGr6ihYpM6OBDhIWX8H/7GIi5yllzet0XHEWpVQPMTwSaJL7g2KM6gV9ZvBn0tZgMMuunDsXqbVoj0HcI1JYoMpwWjeyPr+f8UqiLauDdYtpdFkNsZo5hfcoDoxPIHwmxodaZmmcIqVquXT34bSPsLCXWIFvqOjs6fKPMcwzV0vjUiShQIZqUPAwolmap0MIbsSj6G90wXbDbElU5y15qXDXT10wZR1abHeBcJQjSX5grLcMSHkIC3Goxig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pj4mhm+sLh5/Bkv/I99j82b7n05wyxqtTvzWWJDBvgA=;
 b=b7D4KNgpebVqT0R8Zs5DNJ0a94AMJWT056eBe0DG7OuTXxJOvJ8ttcG65RtCQREsGwTjqoMZymbvDZk8cOayaHf7pe22rdkCF/yFl6KJ0jgHmo735ycwKzMXcmu5IDme5CN7jfm+1bpTAypGJh6hxFP1KKpTCzv0YQDPAQVoFlb6iSqCtcfFec01ALJMKwiUnZKTJ8n0cBJXrpz042vh54CZ+QnQwd1Fft3fdID8thgqPcWggsA3PMaDq3HyuZP1nHAN3A71fpDxmBW7st0lyJ5F0aJpwTZ+Jbf9VuL7mK5isSnp4UE/ovdJXDonx16vHv9PoQMHmxG4QUb2n+0h8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pj4mhm+sLh5/Bkv/I99j82b7n05wyxqtTvzWWJDBvgA=;
 b=rJ51ZirRGiem87c1U/JXSQglhED1rNaf9mvzbMYIoZJywY6aZ/H66mOk6MGEWacfQlVhQfV6pXtaYl5KM7PdQ71d06XsHndUpcPykCbE93DfWK9P1NZJvqp+GpQWQXh+dYtnSa9S50GR+c/mMKgX9Y5NdA9fH95/w4BK6OMbok0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by SA0PR12MB4559.namprd12.prod.outlook.com (2603:10b6:806:9e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 10:26:25 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::b197:512:a4ca:6e9c]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::b197:512:a4ca:6e9c%4]) with mapi id 15.20.6387.033; Thu, 18 May 2023
 10:26:25 +0000
Message-ID: <12061140-4f09-b83f-843c-2fb8ff9f6e81@amd.com>
Date:   Thu, 18 May 2023 15:56:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH] sched/fair: Introduce SIS_PAIR to wakeup task on
 local idle core first
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
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
 <0ac968e3-cd80-6339-970d-37005876b145@amd.com>
 <ZGWmveL2YTiXp2XR@chenyu5-mobl1>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ZGWmveL2YTiXp2XR@chenyu5-mobl1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::7) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|SA0PR12MB4559:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f911a65-0b9d-4fb4-e9d8-08db578a5520
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cw1J1JZlZ+5ZHQJtoIH7keduaW7omPhK0LUVmBIA4PGWQK2l/hFW31rCpw4A966lfAQy5kmoWH9z/cmRFTYuWI0E8kr3uYUEzlsNxyB97WMfnmDT7LI7N+LD6z8Q2ARPpuinSe35iqbJrVq2KPJM9EClevkQul7p67NXkArUWjXXm6O7/ubVNJ0m9R2F9Wbvo6vMU3ZUKTPKALpzS5E3IQIV2qhLRYFhDOcIVkeARQUIlJf8+cn4UPMdn6Q/Q9pFBGNJh0SCUjIg5oVGRvTGWSHl1JZASZ1dRTIyaXwpLk67f0+rFCfnJgMdZ5GCCbQ0mP5UEMdGR4cTlOb3vwRLuMFXnxH0iewnx0IxmUBmoeDl47QJF4P8N1AfDzv7l38dwUR2JXRWM4Z/Av5YrnyU7QEcWFaSTUGvsPXAkGtpz6Ihu6W5iVOwk4/8sY+nGHcQspZx5lBeLk6K31h3VWFSyLDvqWArpnUiLMEnJyanK5QEEYr/niXC7UlneRkBgXtEUe8hKgzldyak5ItMPmmYk6GGouvcdP3tVNX5MDzBJ7lxxS5S2FGpDRRC05pfXKGINpAhavJ0Ge6YOEsoV2etpfHzkSCOjcbCms3HeIApzfYE4NGfkMltjY/PpY0XqcETCE34Ozwr9TkH2I9YE0h58Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(451199021)(83380400001)(186003)(6486002)(2616005)(54906003)(478600001)(6666004)(6512007)(6506007)(53546011)(26005)(8936002)(36756003)(5660300002)(8676002)(7416002)(41300700001)(6916009)(38100700002)(66556008)(66476007)(4326008)(66946007)(2906002)(316002)(31696002)(31686004)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDh3Ly9TRHFGSWI0aUJUTisrajJsd2w2cDllb0xkdGZ5MEM2enlmbmVJSXFq?=
 =?utf-8?B?UGZOSXVSU0JlSkJTN05LQ3FQRndrZHFXM2poSW1BVHVNQlRsaTF0L1FVaXk0?=
 =?utf-8?B?R09oK1F6UkZVV0hYTXZ0L2pCQUFwVUNHNFI0bko4L0Fjd3FOcjRkcDhPSkpJ?=
 =?utf-8?B?WEl0MVExZEN0ZXl0bWlHTFJ6R0xJa0FnL01Zc3JyLzNzbXpNOThZSGR3U05t?=
 =?utf-8?B?SjRudURPcnhKWStmQ0g2YUpoS1FtQjJZM3IvbEJTVU5NVnN4V290K2tteDFu?=
 =?utf-8?B?MzBzcjh6UmZjR2VYWG5IZm1CeDZ5c1MyUmNFUHBmM2xzUkVEdjJGZUkyNVA2?=
 =?utf-8?B?S29lMXlpSHdOWkMvQUgwdTNreHQzZHpranNobE9Rcm5LMnlGeGRzSnFhUitr?=
 =?utf-8?B?bThMMklGUzlXQTh2akVHRm5EcmZKdkxoTzVpMUVablpxZnd4NzR1emxVZVFl?=
 =?utf-8?B?T084bk4xMTdSREpxS1BNNHVjV3U2WE8zdDNIaHRrSXBDdThMczlZVlhUYmJB?=
 =?utf-8?B?d1MweExiM1ZOL3pFVlAwQjJZQzZLZEF4ODRIbGZtbWNNaHBqNGljRnpqVTkw?=
 =?utf-8?B?eElSc2huNG9YSVFjdWJiUy9iVUxMZE55THVjU2NvT1hyY2J4a01vVnppdXYw?=
 =?utf-8?B?c2pFMUNBQ1JybHR0eVdKbEhZN2ZGMWo2anlwWDhtVHdzV0kvOERHVEh1TElT?=
 =?utf-8?B?N3A5bHJGYk41N002dWNlYWdkTTJYMm9aV2piVFlFL0dOOWZsbGVESDBUbTNL?=
 =?utf-8?B?STllNHFTTmxQc2hHMUljN25uQkdKWndoaVVqR0NIU2hMQzNWaVhtOUc1bldp?=
 =?utf-8?B?NkpnR3p1Q3Fyak5TS1ZZVk5yNWdpSnptUFQ0TStYOEVyVmhSMVFNamRqQzRO?=
 =?utf-8?B?S0dQY3RpK2d0R1haYlFTdkxob2F1MlI1bE0ydVZFQjlUcmU1S2FqK01adGpz?=
 =?utf-8?B?M0EydHZSQzgxMTh1QkczUkJXSW9rWVlUU0pjZGJrcGlUVWdhZXA2WHdGb3F3?=
 =?utf-8?B?TlZZV0pSOG1Jbi9vbmJmN2ZTS2VXRUVKeHBucytGN3MzVkM0SmhnVkNGRi9m?=
 =?utf-8?B?alNQNjVIWTJhRHR5YVZVelZpc0cwbDdNb2pIQjIxTzRjcjVaNzlFTjBXVHJj?=
 =?utf-8?B?cno3L3MyMncxeE0xMkdZdlhaanFWbUNhaC9aK3cxUTN2RWlTMGNCR1ZsdWFl?=
 =?utf-8?B?czlQaTlRcFpMdHhYbm5lLzBYK1U4NWF3cW1rN2JqZFVlVnZpSGhQY21hS1VS?=
 =?utf-8?B?VEdlUXBkVzA2bHBZRDBXNUpBdGJhNDFwbmdFZEtUaHp3bnNzaUVldmEzSEt1?=
 =?utf-8?B?T05OcU1BQXRVcGdTM3VibzVIcnVMcGFzSnRLSlFmKzRFSmorNEZnTm1Pa3l6?=
 =?utf-8?B?amtFeExLNTlWM2sxNDNhVGthMWVVc1hMUDRsVlBHTUdCNnJVS1JidytvaU5l?=
 =?utf-8?B?RU1qL1BRSmM4WTBCS3NuaFNxRlprbjg3Ynd0YlJoOG1BUzlJVExuRkE4Qk5Y?=
 =?utf-8?B?UkJHMjkwUGNpZVVBbTM1KzdjZ3MyL0NnSjR1aG5GOWp4SERNN2M0MWJrNVQv?=
 =?utf-8?B?dCtvbHpEVzFvR0lJZ21CQVdpSlJybmFuZmpWdVVKNUlXSkZzSFF2dkxUT2N1?=
 =?utf-8?B?cG95bzE2Q3FHRS9vRVpxanEyYWorV3ovL0JLU291U1FiUm9pRDVNY2hxT1hL?=
 =?utf-8?B?djdZbWhtOW1Fc3k0c3BEQ2FYb0dLVS8vNGZNaUtmNHJQeXNDdCtGK2hvRE5B?=
 =?utf-8?B?eHo1UENxR3lORjZobEZOOFBYcFFaazR6TmV6d1FHMjBQbDVvdzBmOFQxL3Y2?=
 =?utf-8?B?NUNwZVpoYTRhTE0wSGEyemlZNlE1dFlFZ0JLR2IySXkzU2p1OU1iaWxqYzdo?=
 =?utf-8?B?Yy9NRzhKb0NKL2xyTnpBVW4xaUo5NmJmNVlheFRtUG5taHRydWJGYU9qeGpi?=
 =?utf-8?B?dXZzMkhXa0dlWDZWaC92aFVwSGUvTUlqdGJPQUF4ZXpiOE8wV3VsN0U4UkFB?=
 =?utf-8?B?NUhDdVFRYXFXWTE2OTh3c0F2NjB0bUdwM0xPT1QvNTVaWTVyYkdNbExHc0FR?=
 =?utf-8?B?VFhHb2Z3WjZaR3ZXcmRZV2Ftc056VW5JTjcveW15YjZRYVNlRDh1NFUyNFRK?=
 =?utf-8?Q?ZIEFlyBJbyzOT9ZskRmhivQuN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f911a65-0b9d-4fb4-e9d8-08db578a5520
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 10:26:25.2769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: esYdwK7sbE1Tb/ApqWw67w5K/tODowfNRDKttOUNZZNgmbihZ8iyAG08XsYwpg04xEBVeaCymwoP/5SoSNwUuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4559
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chenyu,

On 5/18/2023 9:47 AM, Chen Yu wrote:
> Hi Prateek,
> On 2023-05-18 at 09:00:38 +0530, K Prateek Nayak wrote:
>> [..snip..]  
>>> +	/*
>>> +	 * If the waker and the wakee are good friends to each other,
>>> +	 * putting them within the same SMT domain could reduce C2C
>>> +	 * overhead. But this only applies when there is no idle core
>>> +	 * available. SMT idle sibling should be prefered to wakee's
>>> +	 * previous CPU, because the latter could still have the risk of C2C
>>> +	 * overhead.
>>> +	 *
>>> +	 */
>>> +	if (sched_feat(SIS_PAIR) && sched_smt_active() && !has_idle_core &&
>>
>> "has_idle_core" is not populated at this point and will always be false
>> from the initialization. Should there be a:
>>
>> 	has_idle_core = test_idle_cores(? /* Which CPU? */);
> Yes you are right, I have 2 patches, the first one is to check has_idle_core
> in the beginning but I forgot to send it out but only the second one.
>> 	if (sched_feat(SIS_PAIR) ...) {
>> 		...
>> 	}
>> 	has_idle_core = false;
>>
>> ?: "has_idle_core" is currently used in select_idle_sibling() from the
>> perspective of the target MC. Does switching target to current core
>> (which may not be on the same MC) if target MC does not have an idle core
>> make sense in all scenarios?
> Right, we should check whether target equals to current CPU. Since I tested
> with 1 socket online, this issue did not expose

Ah! I see. Yup a single socket (with one MC) will not run into any issues
with the current implementation.

>>
>>> +	    current->last_wakee == p && p->last_wakee == current) {
>>> +		i = select_idle_smt(p, smp_processor_id());
>>
>> Also wondering if asym_fits_cpu() check is needed in some way here.
>> Consider a case where waker is on a weaker capacity CPU but wakee
>> previously ran on a stronger capacity CPU. It might be worthwhile
>> to wake the wakee on previous CPU if the current CPU does not fit
>> the task's utilization and move the pair to the CPU with larger
>> capacity during the next wakeup. wake_affine_weight() would select
>> a target based on load and capacity consideration but here we
>> switch the wakeup target to a thread on the current core.
>>
>> Wondering if the capacity details already considered in the path?
>>
> Good point, I guess what you mean is that, target could be other CPU rather than
> the current one, there should be a check if the target equals to current CPU.

Yup. That should handle the asymmetric capacity condition too but
wondering if it makes the case too narrow to see the same benefit.

Can you perhaps try "cpus_share_cache(target, smp_processor_id())"
instead of a "target == smp_processor_id()"? Since we use similar
logic to test if p->recent_used_cpu is a good target or not?

This will be equivalent to your current implementation for a single
socket with one LLC and as for dual socket or multiple LLC case,
we can be sure "has_idle_core" is indicates the status of MC which
is shared by both target and current cpu.

> Let me refine the patch and have a test.
> 

I'll hold off queuing a full test run until then.

> thanks,
> Chenyu
>
> [..snip..]
--
Thanks and Regards,
Prateek
