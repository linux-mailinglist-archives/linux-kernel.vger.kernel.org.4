Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675DA6B777A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjCMMaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjCMMaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:30:11 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F184FA8D;
        Mon, 13 Mar 2023 05:30:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yk4jjtMLc6jGNxtgz2zyAOGYZzTMt7WsBLCHy4Hd7TSBntq58UyaEX/P1PPT+uuEghv8TJWVdfvSyRtKdc9nPBcZJIm2MiRhAjBoQFZGJZHC6OIyX3ro41likvTufBL8Tiwn2SXNtCUnvAJ7PxhjaPmPAto22gxiXL82k6eO1+Rgnx69ZnEzkix5dx9g2EqPewTo00tU2d5Of2Dn0lunRsaicaZDCrGZjIcwrkXTUNfL6sV3dl1iuCaoAp1v+iqU2diEkvMq/bPAW6ijh73q2qzUbllK+2kUgkJpl6jpd55CDcl27AyfzapiaAPPTYi/Py+7DR7lNYnNyp0grb2CRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTuiSvLXqVSbLTZe+Gso1U1+5OJ/uwtvulOX+7PHhj8=;
 b=Gdt6sxS1yteRZwiJ/2CwmGRv+oMD+hD7AjlVZxP4YSEAbVYDWwHUCjq0m54fmJDNZRR94iUqovGUT1o+6CgaXhHAx2Kz/csMd9dxDCufI0IxrU878P3Wi/UmpiI9gS3g8rkxgBCfItgNl6wPK1J9WZdMIYfkpBAoyP+HuLG84dpc8K89JtNBNytZmrXXceRYty1MC0im8K4iGn6HNz94kFHiy9q0kRZHhM3W4qeqIz5XonAbg+FNvrQ/mkbQAeyxY5o5ZXTIi2RlUu4PQYOd39TzPDvczji5rEPCRGE0NKmF8dysNWkU2kvP2wSOL9/2I/lUUAUC+dIPxeDWTghs2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTuiSvLXqVSbLTZe+Gso1U1+5OJ/uwtvulOX+7PHhj8=;
 b=dWkQDzoN7QvxC26/Fhp8bhYTys+TPDwSfq3kRVbMeNKQ2HvW0qr+LKI5tNrBZH+wgm86OZxDWm58O6znA5ZCvbYzMyGAaT7WRL6rneBgmCCDoLKCrUbyNZMD4UdICpi7KX0W6/Aiq6UKPBqSjHO+MqSgbb99KieQo8gkVQGnSps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM6PR12MB4091.namprd12.prod.outlook.com (2603:10b6:5:222::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 12:30:00 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d8e6:76b5:2c23:1247]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d8e6:76b5:2c23:1247%4]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 12:30:00 +0000
Message-ID: <45de7e62-d951-1019-990e-6df285a64cf6@amd.com>
Date:   Mon, 13 Mar 2023 17:59:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/3] perf/ibs: Fix interface via core pmu events
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     namhyung@kernel.org, eranian@google.com, acme@kernel.org,
        mark.rutland@arm.com, jolsa@kernel.org, irogers@google.com,
        bp@alien8.de, x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230309101111.444-1-ravi.bangoria@amd.com>
 <20230309101111.444-3-ravi.bangoria@amd.com>
 <20230312145426.GA1757905@hirez.programming.kicks-ass.net>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20230312145426.GA1757905@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::15) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DM6PR12MB4091:EE_
X-MS-Office365-Filtering-Correlation-Id: 685eadf2-0c7d-4744-c206-08db23bea986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wFG85peWGYdWPp1cg2YI9xSfsTpkIpXtXows5eYclcaRl4f2cBc4S8xh89i8kaP6DGIeOPprqMS4/opIFlv+CKwl1+Q5TNsuuBn5OqQuHTdogF0+A64z1rQgqhbCfyyoT5Lxb6IxKwQ+1aXNgEYww5vbWOHYdXEhK/KLGIu3uk51TYhL3rRyMv3dyBfgTj07HxVG4So6J4o27YBKoCEAtdifYghXcqpyIJahuWvxrgSf87WleEk/4xVAz50BloLy2U7a9HWSpdICXaCn6VdXmBXHnkqKdzAF5z+cRSP9shQlikBNFCSgUUT/M+CDlVq6rTpACO9d7WL9tUXlDdRLpNt1xS0pYOhorf9J+CmWuknagaQ89OMQj5nJWYk9riO0uIcca1SBl5KpiSEVz/QQmPteF5dVI0GiNdbWSL8llSKbZNAn4xgci8csA+2XpUranKdRPocltI1EdvnAxAC0zm8D/s047y5CXQHFwNcPGIT4Wf4B/ZRdqtnFEV4ehRMPhnOZeEcUV28YdrklrjpT1ZxqUoRt0G8mUO7l83eyxC5oweSnRs5Yc2YKLJY7iB/vzv2wjeIaFePyo8v4bx+E7qimV4x0lFhlNRtcCB8r8WtNvUCQRB1oDFZMGCxArSJ0ibRuHm0/UslbwXBPPIB7pmUP4rIHupqc64aD3wKBieO4o0HqW0Nt/GADqQi6bth/HOsxv3DiWL10U5WEY+GEH/2mS7oMrVOHYm7sB+tEJDY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199018)(6666004)(83380400001)(316002)(38100700002)(478600001)(6512007)(8936002)(186003)(8676002)(6506007)(36756003)(26005)(5660300002)(53546011)(6916009)(4326008)(7416002)(66556008)(66476007)(66946007)(41300700001)(31696002)(86362001)(44832011)(2616005)(6486002)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzJ2Uy9kdGVPSTBvYUN5d0Y0UjYxVUVCeFpUSVlsZHVqNmZZeVBlOHNVWjNK?=
 =?utf-8?B?dVBDYVovODFJdGVwQlpVYkx0Zmk1bjJCaUFYVGNuWTVJZHdJdDVVa29BbVp0?=
 =?utf-8?B?UkYwTUg4NDA2MVBCS0Z5WXAySFVSdUphaXJJTENtZ1VLQng5STYwdWVPZDM0?=
 =?utf-8?B?NjFJVE5RK1hDbVpmQ1hKSjZZRkp4NTlRRnpkRnhOeDRBR0E0bVFDVHFWUHFN?=
 =?utf-8?B?QkpnVFQxUDAvTmJsalZDVmhMRkJsUWU0SW9pdWxxUnJHeWp2VVd4QW95eVhO?=
 =?utf-8?B?RDhUQzVsNC9ONWRaNmxVb3R2cUJEc05VMjdKRUZVUHJIQlJMdk1yMUVVZGFw?=
 =?utf-8?B?QnVGNE04d2JIWTZBRGFNcFNYNE1LR0ZRZUkwZ2RtaHA4cjFYdlhTT1FMQ1Aw?=
 =?utf-8?B?Y1k2amJiRnB1azRNQnNpbXVWaFA2QU5mQjVLWjArMk51bFROei9XUjdPWUNv?=
 =?utf-8?B?QVduSW90bHJqYmpDeHBvZE5SdnNaVGlDUkRaTlRMT1YxbUc3NUZvVDR0cUpq?=
 =?utf-8?B?dUFBNDJhdWp5OEo3eDNPMUdmTHdxTlFtMUxFOWl1UUN6dXdabC9zMzVKemVx?=
 =?utf-8?B?U1h0WWdmckd6LzBSMXpURVpYRnh3RTBScWpMWmJra2ZNSm04dVV2WFpYV0tD?=
 =?utf-8?B?eGp3OEtBTU9yR3RYRC9kRUR4SUU4Tys4dEYzV1lzNlJrM0kzN2RlbXUzV1Zm?=
 =?utf-8?B?aDFKWmJsb00rcDRRV1JFdjh4QjE1ZUd2bnFLM1oxTFh6M2JKVlJCdlJHM2Z0?=
 =?utf-8?B?dHpNMnZxaVVtWTZxdlRVUHAyQ29XMWh4TStySWZ4a2hCbGllR0h3SWNQczNp?=
 =?utf-8?B?Vnk2Znk4OHhmb3RxVWpyV3F2Sm5nSnRLUUdzQzd0ZGtieCtkTnRsUVBwREhJ?=
 =?utf-8?B?UG9yUkZzejZRY3AvV3BReWFkWW9BRVcxZWVMRmdMMURJcTRjN1dnRXl6a0VZ?=
 =?utf-8?B?dGZMMGVXbkRBWlZ4MkpCeXd4OHd1TzcrenNlVEVoQTVzQmx4SUdxV1RqVXBk?=
 =?utf-8?B?SzRTdTBpWVpQRXdGeUp1UTNiVzh4QWIvUnFRZmE1WUNaRkRXNThMTjZpd2c4?=
 =?utf-8?B?aGwvMUxPVEtlTXJSSDJ0QWc1czdtQlpKUFNKR2luN1FlNHhSWDZzeEFaN3No?=
 =?utf-8?B?dmZKdG1sMFBBYXg5TlFBalFkRExScVJMdlNSbEpvMGFkU01aTnNtYmlvcGk5?=
 =?utf-8?B?Vk1WRkdFV0FHaEE1cSt5dXAvSTRtdGVaQVNWSTFJYmE5VGVTRzkzRVd0aVdS?=
 =?utf-8?B?WUpXUHU4ZlZLWTQzaWQzQkRTT1Ric0cxdWpLd2RaVk1kSXJ1M3FocmVDOUh0?=
 =?utf-8?B?MnBZc0FqZGpxc3dKdFRldjBZYnJsYWxLYXp3Ry9UUGFvcXNtMWUxTEcweFdH?=
 =?utf-8?B?bWdjcUZjTXZ1Snp5MTFOUFdvaVNucmZZWmJaSHd5b3NxUldMY29tVjIxV3BO?=
 =?utf-8?B?R3dqbW5lMDk0M3c0TGZEU0d4TkdES2RPMk9MckZ0SnJ1bzhPaXhQaUl3RUdx?=
 =?utf-8?B?aGVaWjRTYlFwL0xLZEh4cmsrSTU4TlNGbVQwOHFueFdvRU9Bc0tOd2JRTFVx?=
 =?utf-8?B?VDR1WXhiS1JlYmgwSjQ0TEFXcHR6LzFLdVNCZDdrMjVlbElvT2dWZ3hOSFVZ?=
 =?utf-8?B?ZHJoOHlxeUxMSytxRmlMMVpyL292azhlQ21ROVhxcytUaDZFOWZKdDY1T05D?=
 =?utf-8?B?L0Fhd1VSMVNxYU1GQUk5MFlFc1BzbllFUlBBekZiWFZMd1MwNzVnM2RCeTU2?=
 =?utf-8?B?eGJ6ZzEvS3JVQ0t2UXZmVXE2eFNoOEZDMEhSYzQySFZaMWRTdi9mRzJBdDVs?=
 =?utf-8?B?S25YVmx4OGdLWHN2SG9mZVhYdFd3Tm1RSWZXNzlKSGxUL3Q4M2hlWjM5WFoy?=
 =?utf-8?B?dW5kaWVOTThRd1V0dVFjVitvSG9IaGs0MmZpS2VXa2JIbWJuMkc3Q2FmRjc5?=
 =?utf-8?B?Qm56eHlnL3Q2UmpyaStCZGlvelZmQmFEZTdYdXVsT1h3VVVtcnJpejJSSnZZ?=
 =?utf-8?B?UCtPNlZzblJCKzV6Tm9vR0VLRkRkMEJzT0lBMUFQd0ZTck8zZXA0MG12bTBp?=
 =?utf-8?B?S0Y5dDc0SDh4NlBDdXByMVdlb0JJN1FFOVY1Tk9pZS9vc3M1MjlldUxhd09G?=
 =?utf-8?Q?AokQK3JnxNyKiSYTcyVMpzQJS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 685eadf2-0c7d-4744-c206-08db23bea986
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 12:30:00.2072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V9C9UIo2mjugIfl1biaB1Q8kjQ0fcgpDt1ZoaW2jVQ7lTGxRnc/jwbUyCLLw38s+xN2/k81f0MKVRTjzWN9h3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4091
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 12-Mar-23 8:24 PM, Peter Zijlstra wrote:
> On Thu, Mar 09, 2023 at 03:41:10PM +0530, Ravi Bangoria wrote:
>> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
>> index 8c45b198b62f..81d67b899371 100644
>> --- a/arch/x86/events/amd/core.c
>> +++ b/arch/x86/events/amd/core.c
>> @@ -371,10 +371,15 @@ static inline int amd_has_nb(struct cpu_hw_events *cpuc)
>>  static int amd_pmu_hw_config(struct perf_event *event)
>>  {
>>  	int ret;
>> +	u64 dummy;
>>  
>> -	/* pass precise event sampling to ibs: */
>> -	if (event->attr.precise_ip && get_ibs_caps())
>> -		return -ENOENT;
>> +	if (event->attr.precise_ip) {
>> +		/* pass precise event sampling to ibs by returning -ESRCH */
>> +		if (get_ibs_caps() && !ibs_core_pmu_event(event, &dummy))
>> +			return -ESRCH;
>> +		else
>> +			return -ENOENT;
>> +	}
>>  
>>  	if (has_branch_stack(event) && !x86_pmu.lbr_nr)
>>  		return -EOPNOTSUPP;
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index f79fd8b87f75..e990c71ba34a 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -11639,18 +11639,26 @@ static struct pmu *perf_init_event(struct perf_event *event)
>>  			goto again;
>>  		}
>>  
>> +		/*
>> +		 * pmu->event_init() should return -ESRCH only when it
>> +		 * wants to forward the event to other pmu.
>> +		 */
>> +		if (ret == -ESRCH)
>> +			goto try_all;
>> +
>>  		if (ret)
>>  			pmu = ERR_PTR(ret);
>>  
>>  		goto unlock;
>>  	}
>>  
>> +try_all:
>>  	list_for_each_entry_rcu(pmu, &pmus, entry, lockdep_is_held(&pmus_srcu)) {
>>  		ret = perf_try_init_event(pmu, event);
>>  		if (!ret)
>>  			goto unlock;
>>  
>> -		if (ret != -ENOENT) {
>> +		if (ret != -ENOENT && ret != -ESRCH) {
>>  			pmu = ERR_PTR(ret);
>>  			goto unlock;
>>  		}
> 
> Urgh.. So amd_pmu_hw_config() knows what PMU it should be but has no
> real way to communicate this, so you make it try all of them again.
> 
> Now, we already have a gruesome hack in there, and I'm thikning you
> should use that instead of adding yet another one. Note:
> 
> 		if (ret == -ENOENT && event->attr.type != type && !extended_type) {
> 			type = event->attr.type;
> 			goto again;
> 
> So if you have amd_pmu_hw_config() do:
> 
> 	event->attr.type = ibs_pmu.type;
> 	return -ENOENT;
> 
> it should all just work no?

IBS driver needs to convert RAW pmu config to IBS config, which it does
based on original event->attr.type. See perf_ibs_precise_event(). This
logic will fail with event->attr.type overwrite.

> 
> And now thinking about this, I'm thinking we can clean up the whole
> swevent mess too, a little something like the below perhaps... Then it
> might just be possible to remove that list_for_each_entry_rcu()
> entirely.
> 
> Hmm?

I'll check this and revert back.

> 
> 
> ---
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f79fd8b87f75..26130d1ca40b 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9951,6 +9951,9 @@ static void sw_perf_event_destroy(struct perf_event *event)
>  	swevent_hlist_put();
>  }
>  
> +static struct pmu perf_cpu_clock; /* fwd declaration */
> +static struct pmu perf_task_clock;
> +
>  static int perf_swevent_init(struct perf_event *event)
>  {
>  	u64 event_id = event->attr.config;
> @@ -9966,7 +9969,11 @@ static int perf_swevent_init(struct perf_event *event)
>  
>  	switch (event_id) {
>  	case PERF_COUNT_SW_CPU_CLOCK:
> +		event->attr.type = perf_cpu_clock.type;
> +		return -ENOENT;
> +
>  	case PERF_COUNT_SW_TASK_CLOCK:
> +		event->attr.type = perf_task_clock.type;
>  		return -ENOENT;
>  
>  	default:

Thanks,
Ravi
