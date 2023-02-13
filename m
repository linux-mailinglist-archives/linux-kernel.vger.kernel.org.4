Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E6F693DF1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 06:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjBMFwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 00:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjBMFw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 00:52:29 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6568DEC58
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 21:52:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbMjJ9M/FLmn7102Y4R8KCr8uaNzK7y59uiV04vxoUfEB8/iXTencGt1Hw+WnzjsX+P2Oka3kzlxzaGisWmSBwTAa3bdsvP4fnHafpImATZsAMCc1De3mwkdw7bEjPEQFTGCjdgnGKmB058LJDY6spOb1B7Uhvaeaya4x38srKI5hCShzYXVX1ZQuc0n1fwTh7LS6E+JLISaQsIFqok8rg3CA7iNjcnxIz1o40i1Z0buyi9AWlYaxUrlj36UdmKPz6TSuKK+ut9XcLNuj998YVOj7JobethUK9+eUKx0cfpvhK38ZbjNCn+DOtaHGNMsJdHQk/87kCP5ItiwE6Yg4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzgFNsU6OZAu5yGz5fJ7JaHrZB61W4Bg9nGfoP8g/yo=;
 b=W4ccG6w544UnDMv+2X7MerTOdflJ84zewfM/nsHrfARj6yEvnwoT5D7lu41lvPFL6Rcd6Q3/YBmnbGSYGzmV1xD/yAdVwbyAkTkXp10aljZEhZ+fqxF3WodycVjsYdhrac3MsWrxWGZIyhVEAV4lBIpryJJsFKAV/ogJ1xkhXBWgC8UOQsmC3E/oMwIOzZjyfvV2Y0+WgkFzKH+BcxuwBTIhN1Wj9o1/rJJ9OEIOr/0AtVBdO6Rplf0acBPfF12ep4sA+sv28kwNi6OR49p+wEOCn8TBZSJz7dDGRdIlQsUtRIHXHWwlK/Prr4I3aeqcnVoRNbsP20irVZ3f9yPH6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzgFNsU6OZAu5yGz5fJ7JaHrZB61W4Bg9nGfoP8g/yo=;
 b=u0hGXBDt8G39OubDm/pOgStbV20oTmuaUOJIhrmWps3Lcfx9sA9jzEbYPd+55H0vOr0Q1FZTKp5FM+sftYPzSSxX8J5ZOLk5I4pcvtiKeiqd6nvezY/ntj4yjJbKFZqZ9fmT8XcWUpEcZ/6LTBr8LvGUl4RcxcTy2AM8roqojtU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by MW6PR12MB8758.namprd12.prod.outlook.com (2603:10b6:303:23d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 05:52:25 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::422f:19e8:faa4:eb05]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::422f:19e8:faa4:eb05%9]) with mapi id 15.20.6086.024; Mon, 13 Feb 2023
 05:52:25 +0000
Message-ID: <72b6ec8b-f141-3807-d7f2-f853b0f0b76c@amd.com>
Date:   Mon, 13 Feb 2023 11:22:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 0/5] Memory access profiler(IBS) driven NUMA balancing
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, mgorman@suse.de,
        peterz@infradead.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, tglx@linutronix.de,
        yue.li@memverge.com, Ravikumar.Bangoria@amd.com
References: <20230208073533.715-1-bharata@amd.com>
 <878rh2b5zt.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <878rh2b5zt.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0213.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::7) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|MW6PR12MB8758:EE_
X-MS-Office365-Filtering-Correlation-Id: ee135fba-79a1-4d6e-e42e-08db0d867aec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9NcsVLoMfaKhBHXcqMX7dFgWT/bFQs44uScaCF6KGnS8C2CEhgRmBe38PwhMhI6cffSkczhjmmBFPjtq6EhjO3BP92+4VhG/XhQxLLJbQVVwQJjXvCgpLKWOWRiNoXfUwZMsT/m7EmzsgqLayUEtLuYAoBEicQfkeEDIJuT7r2eSIkJsUPa/7M+KlXz0UE3ScyYt2oIaUEOhR3OjbGWlMHQFzFYUh9ksunDXCMuyB2YBbKi+GVVNG5bHNFdNeTHxd9sGd0yv2eTfmbd3DSM/reMwwMAw9Rfdtn87wGzIW37QyShHEXcaZbnsfzAqwiaK2YYpzAmzDoeNieAAgpGNulFN5zbIR3dSLtJMacEchi6Zc1wroHzWlWXPDFzO8v++l5JIRhiHE3OLIRccpgF2H0tv077HdfmP05VELNsqVUUrBfdz89qjg5CuSQQwLdKxNz/jAJQQaPwj3Cm1rwvJhCYSNL/VkBRxM7rU1mFPM58UBpNrqD4GMVTeEW+OBKyIV/xTg8gxwpvi7ODo1KLlgR/Oqbac2qgxaw+H+B00OYgaGp27AzLTxUpHgZAoRicxUCvQWdPxXRMIDV4JQnEdzSr/qFXLy7hlvKFJlP4mPDgEd9hJ2U4gDICSsf7odMU9SJaW4j5pTVhXlcqJ4WmKIxLwU0s+2KFDB+kdWI4ssu0HZx1dr/ohYrdhnq5kX0l85LwIdhhFrZswHTjmof0ST0mG6iwgI0zm8BBBXZC2kM4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199018)(8936002)(41300700001)(36756003)(2906002)(38100700002)(7416002)(5660300002)(83380400001)(26005)(86362001)(6512007)(186003)(31686004)(6506007)(478600001)(53546011)(6486002)(31696002)(66556008)(66946007)(66476007)(8676002)(2616005)(6916009)(6666004)(4326008)(316002)(66899018)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkRQcm5nNDF2aWJEaGl0NG45KzlnOGJwSUdhNk5sbWhwVWE5RkkybVdlRmEv?=
 =?utf-8?B?b01JU05TTCtrd0dRdmdza3dKaGxXSHBib3RkQUUzbjB1d0kzaGxtb2FzSVFh?=
 =?utf-8?B?dHMyTGZWa2t3K3JveVBSSXN4STdTUTc5NnpDRS9ZTkFPWEppbUg5eDMyTE52?=
 =?utf-8?B?MlE3dStCUUxLUUlWaGYxT0MvTVJZVTZHVTVEZkVhLzJBTUhkZ29CN0RJNmli?=
 =?utf-8?B?TW1jYVFKeFFsVnp6eFBmRnpTa3dqVjc0SWRlL1ZvMmtuYVhlalhUWUF5RklH?=
 =?utf-8?B?cjI4bE5aNVBhZWhIWjVBOU85WlNRNndJaHdyaGhHZUx5OS8xWVpva1FlckIy?=
 =?utf-8?B?MVFGcWtpYUtWWVVwcGFFd1NpalhlVzZadEtYZVNtdWdDNjREbnZUOUVIL2Ja?=
 =?utf-8?B?ZzRmdHFUcnhoeGY0S0puMHlLNG5OdzB6QWNnYVk4QUVEcm9odGE2Nzl6MDl1?=
 =?utf-8?B?K3g4QjJ5Z051bndnWEVOYVU1UnVRR2FxelhwOFZhcVRmU2JtaGpNVU5vTUIx?=
 =?utf-8?B?ZGM3eGtpYUVBRDZ3bCtWWGZ5MmtaejQ3WVhlL0JyNUJsRk5ZUi8zN2lQejlj?=
 =?utf-8?B?S1V4YXFoNGd6dXpmU3dsTm1scHNoRXp0SWxUNW9OaytrOFNYOHo2bWRFbnNB?=
 =?utf-8?B?S1VSYTZWRnpLaGxEUWlQc25oVmZSZVlCRGRRVS9vZXdwMzQxYlJDaDduaHhv?=
 =?utf-8?B?US91U0V2ZXMrMTV0aG9SOUJsRm83d29KN2UyUHNtMGVLQlowblhBaVhQc1VK?=
 =?utf-8?B?NWEwN3FsdEZRNm1VTEN6anBxeEY2Z1Y5bVV0Wk1lMmRoSWZ6UUhBcDY3UmdK?=
 =?utf-8?B?eHVBeGQ1alR6SnN3YXVKZkNaTmlWejBGWFUxUzBhUVhNaGlEWXFoS2RDVTVm?=
 =?utf-8?B?OFVydC9NZ25mWncrcjNEVXpBMFhBYmVPM1crL29SZWd5bW5TUUR0N3ZhSHpS?=
 =?utf-8?B?NSt0R3RFc3F5RUp5VGJRM2N5LzkyT2dNbXVYQndza3NEdlJhaG05bG5oVTly?=
 =?utf-8?B?Mlk5aEdFeXc2TkVsQjBLeW9KQm9IdDV0VnVxeHhhd3V5YTB1VkhwMEVCaHVh?=
 =?utf-8?B?Mm1DTGN5SkQ0RUFQU1RQZnZaSDkrSzllQXNvbHZwZ2RTSVF2aFlQZmN3L1dK?=
 =?utf-8?B?c3RhcWhraGlReEJVZ2hlZEpwQlE0WWlISmdxNkVndG1pblRBUERCVmw0TE9N?=
 =?utf-8?B?Y21sSkZGUTkyMUNFQnZEVFh1N3ByOTBoT0RWVmNTUzVpaDlNME1xT3lOK2hm?=
 =?utf-8?B?YUpKb2UxcjZIUTZia0lHMEhhMTB0M1pHTEc2ay80TTVaUE5sRU9OY1hKK0JR?=
 =?utf-8?B?TGc0Ni9KeW80RzdzSEdraGFGbXhjS3l1a1ViQTRpZE9sdDdKTC9ZV2lSUGh3?=
 =?utf-8?B?LzBzRFFtSi9JS2l2SzY3V2cxZVpIMk5HQkpITUJVZTIrRE82cE83cEtYWWgx?=
 =?utf-8?B?N1p5VkE0aHBSY0NobUJMTnd2bHVPZFJSZTBFS0NtWEtvdlhhd2gxMkI4TzRj?=
 =?utf-8?B?YnB2eEc1VnpSUXViSVBMOHR6c014Q0pGdm90NTkyUnZPeXFSMi9PVE4wdmlC?=
 =?utf-8?B?YXh4V0RhNjNkdFdORHBGZWlZV3QyYkdGZDBoQW9hbDl5NGh3RVRJbWZqS2Ir?=
 =?utf-8?B?ZHRhUTdROFZOV200VjE2QUxWMTJ5RGdOMHJINjRJNmZiTVFGOE0rMVluSkh1?=
 =?utf-8?B?RFl3U0RLb1Ztc2xhWVZlcGMrZnFYUmZNeUdtbzltRm5JdVhMSXdHT2pUMW1R?=
 =?utf-8?B?ZWNieEFKY3V1MWVtN0VGcHUzWWd3YXRZRzBGczQyNC8wTVF0WTBnRFNLb1Nj?=
 =?utf-8?B?TVVCa2g3TVl1OE1Ic3pMckE1dm5SN3h4cmNEWUR4eHhObm1mY3NLZktPZmVJ?=
 =?utf-8?B?dTZFSUFnL1lGVzMveUI0czliTTNVbXB5VTVhOFY1TjdjcUc0VGFtOGFNbUV4?=
 =?utf-8?B?SFBQbXVNK3k0bnVtREtrNkdvSXpnc1ZVbWpGQVZkRlF1bTI0NS85WHlrVCtm?=
 =?utf-8?B?L0gyalNoNlBpcEc4cnZrcmZpNlhqa0cxM2dTeTF2bStYbFJTTmQ4alZxemM5?=
 =?utf-8?B?RnltbEdwRGtmRXNEaTlaSkd3V21WK2MzY0VGcTlyT2EvRUV0MUhMRmx2ZFll?=
 =?utf-8?Q?ZfP60HKlJHVMKzgM+CQ/TtFb3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee135fba-79a1-4d6e-e42e-08db0d867aec
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 05:52:24.5006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9rOOnAC+E5Nn7il1o9sGxYeHFSkeR/g8OaM3gAShG6YhPNwuC74GfooQP7WmWlmEIo+kIUU7AlDEFr7kbYAEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8758
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/2023 8:56 AM, Huang, Ying wrote:
> Bharata B Rao <bharata@amd.com> writes:
> 
>> Hi,
>>
>> Some hardware platforms can provide information about memory accesses
>> that can be used to do optimal page and task placement on NUMA
>> systems. AMD processors have a hardware facility called Instruction-
>> Based Sampling (IBS) that can be used to gather specific metrics
>> related to instruction fetch and execution activity. This facility
>> can be used to perform memory access profiling based on statistical
>> sampling.
>>
>> This RFC is a proof-of-concept implementation where the access
>> information obtained from the hardware is used to drive NUMA balancing.
>> With this it is no longer necessary to scan the address space and
>> introduce NUMA hint faults to build task-to-page association. Hence
>> the approach taken here is to replace the address space scanning plus
>> hint faults with the access information provided by the hardware.
> 
> You method can avoid the address space scanning, but cannot avoid memory
> access fault in fact.  PMU will raise NMI and then task_work to process
> the sampled memory accesses.  The overhead depends on the frequency of
> the memory access sampling.  Please measure the overhead of your method
> in details.

Yes, the address space scanning is avoided. I will measure the overhead
of hint fault vs NMI handling path. The actual processing of the access
from task_work context is pretty much similar to the stats processing
from hint faults. As you note the overhead depends on the frequency of
sampling. In this current approach, the sampling period is per-task
and it varies based on the same logic that NUMA balancing uses to
vary the scan period.

> 
>> The access samples obtained from hardware are fed to NUMA balancing
>> as fault-equivalents. The rest of the NUMA balancing logic that
>> collects/aggregates the shared/private/local/remote faults and does
>> pages/task migrations based on the faults is retained except that
>> accesses replace faults.
>>
>> This early implementation is an attempt to get a working solution
>> only and as such a lot of TODOs exist:
>>
>> - Perf uses IBS and we are using the same IBS for access profiling here.
>>   There needs to be a proper way to make the use mutually exclusive.
>> - Is tying this up with NUMA balancing a reasonable approach or
>>   should we look at a completely new approach?
>> - When accesses replace faults in NUMA balancing, a few things have
>>   to be tuned differently. All such decision points need to be
>>   identified and appropriate tuning needs to be done.
>> - Hardware provided access information could be very useful for driving
>>   hot page promotion in tiered memory systems. Need to check if this
>>   requires different tuning/heuristics apart from what NUMA balancing
>>   already does.
>> - Some of the values used to program the IBS counters like the sampling
>>   period etc may not be the optimal or ideal values. The sample period
>>   adjustment follows the same logic as scan period modification which
>>   may not be ideal. More experimentation is required to fine-tune all
>>   these aspects.
>> - Currently I am acting (i,e., attempt to migrate a page) on each sampled
>>   access. Need to check if it makes sense to delay it and do batched page
>>   migration.
> 
> You current implementation is tied with AMD IBS.  You will need a
> architecture/vendor independent framework for upstreaming.

I have tried to keep it vendor and arch neutral as far
as possible, will re-look into this of course to make the
interfaces more robust and useful.

I have defined a static key (hw_access_hints=false) which will be
set only by the platform driver when it detects the hardware
capability to provide memory access information. NUMA balancing
code skips the address space scanning when it sees this capability.
The platform driver (access fault handler) will call into the NUMA
balancing API with linear and physical address information of the
accessed sample. Hence any equivalent hardware functionality could
plug into this scheme in its current form. There are checks for this
static key in the NUMA balancing logic at a few points to decide if
it should work based on access faults or hint faults.

> 
> BTW: can IBS sampling memory writing too?  Or just memory reading?

IBS can tag both store and load operations.

> 
>> This RFC is mainly about showing how hardware provided access
>> information could be used for NUMA balancing but I have run a
>> few basic benchmarks from mmtests to check if this is any severe
>> regression/overhead to any of those. Some benchmarks show some
>> improvement, some show no significant change and a few regress.
>> I am hopeful that with more appropriate tuning there is scope for
>> futher improvement here especially for workloads for which NUMA
>> matters.
> 
> What's your expected improvement of the PMU based NUMA balancing?  It
> should come from reduced overhead?  higher accuracy?  Quicker response?
> I think that it may be better to prove that with appropriate statistics
> for at least one workload.

Just to clarify, unlike PEBS, IBS works independently of PMU.

I believe the improvement will come from reduced overhead due to
sampling of relevant accesses only.

I have a microbenchmark where two sets of threads bound to two 
NUMA nodes access the two different halves of memory which is
initially allocated on the 1st node.

On a two node Zen4 system, with 64 threads in each set accessing
8G of memory each from the initial allocation of 16G, I see that
IBS driven NUMA balancing (i,e., this patchset) takes 50% less time
to complete a fixed number of memory accesses. This could well
be the best case and real workloads/benchmarks may not get this much
uplift, but it does show the potential gain to be had.

Thanks for your inputs.

Regards,
Bharata.
