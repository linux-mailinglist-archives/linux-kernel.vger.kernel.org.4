Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5048F60FBF5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbiJ0Pa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbiJ0PaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:30:24 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D10853007;
        Thu, 27 Oct 2022 08:30:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GK7Qk7PNO4fWXxV0jhsytf1O/N8sOOGOYfgp3RVBfl8jGBM03X3O5+uodLBm7SflZiIUOJwrCxHxIdcPb7jUcp5QtXr6DDcdaCteBmz0IgqUqCmChEA8b+ewFqX05Jgb32ykadX0384t0I2jVfPcd+U52NYquT4fCXUaPyrrjet9nm8ztZobyXfIFZBlCmWsGLqpiGxO8WlBLlta2KEnq9Yj9aIJIZyWBAqkUmlVEWCxIgtS8GX6VYtfKDyahZ6xqOdRfMRhlSjD+A9KE/VlmJ1KNM2SiwFW24FtWBhD1SP4ANQmMKbTgb4ESExlzb7r+teWFnGeA5O2eNykIM+hpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7SFzt4ixM5Cff7p1KcttGw+mDRdjCTEurmx7lOKufM=;
 b=IJuxgFtvzcn8BgJLMt5O/0wGVfoIbfK8FP0Bh/i1Akyv3wNeOmka6EKfFObgh99JJH6wjKSbl/HKxIWtQXh5geSAOKUJHUj49ee1o0WJm9t5I4hA7528+dY4SKdZAhsfL4qyyuRhRvR95BU5jWbB8b3RdFTou09+2FRcM2H5ih/U3KLdmWklZuUY3p//X+7pux3C5eA7+VGnax6S/IKQhkFXlgFmvWzjoirZeQpljmgcBd4i5pqPmHsm7eW8qEvkYKvahWKcNgLwttb1EQB6Z8c/c1CjPbOXwDFmda26pHRX24wpQrkQpui4u6b0SlNhw2S35mJW9qNeKzQgBEO2Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7SFzt4ixM5Cff7p1KcttGw+mDRdjCTEurmx7lOKufM=;
 b=g9VDwi6LSQjZ1yHt/cDRlm8GPei0OZ2nM+/Cv4zGclLPayykQNsxZbpgw9BI3USosibK7KhuydZrWcSqtvsl0tkGA5fSWkwPcdTwYD7B67h5gNDQ6WDB/RjKt+ZSPjQ2Jql6nIBE/INxK9dlhvUeECjM15TGpzpMEtHGKi5kgxs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by DM4PR12MB6448.namprd12.prod.outlook.com (2603:10b6:8:8a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.23; Thu, 27 Oct 2022 15:30:19 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::8bb9:f98:468a:c7a]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::8bb9:f98:468a:c7a%7]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 15:30:19 +0000
Message-ID: <fbb32df7-df49-7a51-67d8-a8abfe7e1c3f@amd.com>
Date:   Thu, 27 Oct 2022 10:30:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 05/12] x86/resctrl: Detect and configure Slow Memory
 Bandwidth allocation
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
        bagasdotme@gmail.com, eranian@google.com
References: <166604543832.5345.9696970469830919982.stgit@bmoger-ubuntu>
 <166604559954.5345.14619487558472213422.stgit@bmoger-ubuntu>
 <c999a7f8-b083-72a6-ff07-201369339c92@intel.com>
 <ef734fc1-8a51-4c60-f73f-2d71fcc54b30@amd.com>
 <e299ce70-ebca-a05f-a1f1-aed6386c379f@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <e299ce70-ebca-a05f-a1f1-aed6386c379f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0058.namprd03.prod.outlook.com
 (2603:10b6:610:b3::33) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|DM4PR12MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: bc7d56f2-d561-4492-2b49-08dab83027d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8CBrezUf8hJXmeE/qRz/YvKb+WEphznP5oWfqCyT/rtgWOyMCVxlzfI0rl/lWgEMdggXtZGOt+nU9Yndg4p561bdcMTk+Pln7jblg1BNJIbRKSk0HMozhvo5Tuxma9jbV2JQwwnEiF6JMjgu6ex8XRgLr6HTivCXa8coAKapEOjZeDErDaoNe7trhBE1mZeNBcyrpsvzcg/QA8Qt8g/tVHouwO8K+mGTBd64jl+Quj4oR7wHzatiBMQ1pQxIwMGN26hx91Q510PIVjiTr28zrxW2y/Q34JaeFPYGmSMimQn6D8wxMdloZ9yInCG5vuR/iPn9wBolg4DP/lzdzyavXI1TqUi7Ro1CvINRb7fzY+4L7C+Z4fQymAshu1vXPytCSoD9oQNwR6B6u4hReVr/CIjScD0wiOu6npBBpXMPDm8eNvru3zr8nk6NHsHtpjH6jkF71WxqWDDl41vOmFfxzhjFKeD8/6VuOqpVkyppmyBrsGE3nHBknYlOm9KL04E/4W2YCvIspjQHeyfn7hUG25YDUcL3QNrtp6dD4wmGNs527Z+U86O9VPMauOrGfNs60niR/QFXC8O2fvAoRB3Nw+aOUUwLcR7gc4lkE5IoCkG2E2KbjKo/WKfVhRYvJRWHsnILk7Jix5XHi7uL/tLK2obqAixHPcZQplX57xdaJ13ziSiHA2Ik8MfuL5ZAFdGU8OckI+4bJFzCYO7VM7Wszjg6douWytNTqAIrhZCeJwbtOU0eerDxw6mX9TGViXo0LJeghOzvgJn/9hqt6rKvM/bYSiZmmu0Zi+lW2Cw8qEI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199015)(2906002)(7416002)(26005)(6506007)(53546011)(6666004)(316002)(41300700001)(38100700002)(66556008)(66946007)(4326008)(8676002)(36756003)(478600001)(5660300002)(6486002)(6512007)(8936002)(83380400001)(86362001)(66476007)(31686004)(31696002)(3450700001)(186003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0g0R1FMcHJYYzZhTkFSZXNCZHZETi9kcFRCWUhYVVdWRENPUm41RlRpVGdp?=
 =?utf-8?B?REtxT2diMC9HazN3bDhCcHNRSVJCVW4wUi9uUnYyenVKL1ZMMkNXRVB0YVN2?=
 =?utf-8?B?Q01uY0k3bklmQzU1L3lqTGg5TXpTWVdrWWtrbm83aS9HRXJkODRSTnloblpq?=
 =?utf-8?B?dThHeGZJTTVTR01iMlplZWNaUGR1UU5BTEFKU01Cb1ZOZ3JWR2dmRUkrUnVx?=
 =?utf-8?B?YzRPZmhyeDBadlM2ZzdFQUIvZldrOGJxL0dHa25IM0w2T00yL3hFYVVZUVdj?=
 =?utf-8?B?RVUrbkk0cTU2VzgrVitsT0pRVTQxa1JBZlVaK2RVbnJaQlQ1T3dCcWl5S1Nw?=
 =?utf-8?B?YnlLcXB6NGJPTUcra283a1NjRkV6NnllNFptOFhVNlpBTkJ0YWowRnlQcWVp?=
 =?utf-8?B?bTg4YmZyR1ZiUnlLekN2K3E4b2tMT2tlTUZiNSt1bFlZc3BXU0FCUWlWYmRP?=
 =?utf-8?B?UGdhK09Oa2VCU2kxNEo4SU5kODZMSjV1Njc1ZzNBWURJU0NhVU16cXZXMUhp?=
 =?utf-8?B?aUdKeUdmdENaa0syQXVsRlF4UTRxd0xWYUpWeEg4aFc0L1J0RlhINWxJVis1?=
 =?utf-8?B?VC9OMlBUaGZ1NXdUdDBkekQrL3IxSTJvcFpGcWQ4bEdLZ0VRbUsvZ2lFbWsx?=
 =?utf-8?B?MjJmSXQ2UkxJa3BMVUd5UWp6aTBFTEh3R2JoVUJmTXdPTnRoZzN0ZkpKWmlH?=
 =?utf-8?B?Z05oMm9XdVM4RU1ZTS9kOC9GRWliRHM5S3NrdVRCbUtncjVFVGVzNlRJRzQr?=
 =?utf-8?B?aVZSNmdLSDRZTFJxcGNKVjZzc3MvWk9YbFN5aDdlZ2UyN0xZdEdkSVRqbDk3?=
 =?utf-8?B?SUc0NU0xMitwTk56UVFNTU9yOHo2VTIrQ0NZR0doK1NMMEVWVHM4SWwwdTM1?=
 =?utf-8?B?a2N2MkhORWh4bjZxYmlkOVk5QWF1azhOQ0MvL3g4QWViZ0dBMGVxLzROaFhL?=
 =?utf-8?B?bkdaQnRqalF3UFR1N0lrWmxEMzBGYnVFOXJjYVl5M3hqS3F0NW9BNndod3gv?=
 =?utf-8?B?R1hVNytSTWpiaDhxNlZGeWJaM1RLcUY3NEV2SXZ0WklWaVpqNy9QVVFVKy9M?=
 =?utf-8?B?NUVXb09hYy9SWDVzUlk2bjNaNExOWXpMUEJqdW1QNE9aY0s3dEtFcWk1RVV3?=
 =?utf-8?B?dTlnbWEzSldxYlNwMFovSjFwUnFqcmpnTEJaS2RZUWV5SjY1YXlsdU8xcWhL?=
 =?utf-8?B?UE5OMjF3c2NYSnVJaDkxZ3IwTjIrQ3VnR3RlVUN0SEZIb29lTFQ0aTdJcmQ1?=
 =?utf-8?B?VmdTUksxZ3Q0S3ZCL1Z1U09PckRQSERENk5Jc1VneTBPMjBoQTJtYnI1VUFl?=
 =?utf-8?B?RWNmM2dSWFl5YkhJcE40WEJJMUpqWmR6TThFOGxYVE1rMEVKVGV1QWRhK3JV?=
 =?utf-8?B?R09ON09Ldm5LTkg2UXlYQ0M0MkR1S25uSXhwTFQ2N21hYTFlbUJVeEJIYjdT?=
 =?utf-8?B?K1dDN3JhUlIvb21TMUV2NGlZRmZJbkFsNWJUSEFZU2hhNldVdlVJWjgzTkd6?=
 =?utf-8?B?bVArUzdFekJnTko3RHRrdUxTVUwwRG14L2cvaW5mNjRJZW04NVgzaUtKeUhV?=
 =?utf-8?B?Tld6OFJKNFl3K21iU0VYaEROdVpkUHVhSVpDNlJ2TG9PSzAvRkxuU3V1Y3Nx?=
 =?utf-8?B?VnFucjN4SWl0QXlwUWprL1dsT2dXeWo3L2xRTExqaHVIUWU4SVI2endNTU9h?=
 =?utf-8?B?ZWpxcG04YVVNSVB3TmtSWjFQblY0dm1ZMXNtYk5RT1hWT280VStWMElnbDhF?=
 =?utf-8?B?T2x1c3o5L1lHS0R5bG8velVqT0VwcVIweVc0L0ZXU3pLMDFydlgvcnBLVjVk?=
 =?utf-8?B?M2o4TmtrVnFSMTVmN2hkUzN1cW5wQ0hsWHFkbnd0ZnRHclVaK2x2eHV5T1BC?=
 =?utf-8?B?aWtrWTlUWXgxdXZtZkJMV0RyRjlQdW9icU50WUVmTXJaWjQzaEtsK1dYM0w4?=
 =?utf-8?B?RkxxOEY3NSt2d09WZE1DcjdrZTVzVUZkb0Q4cnJKdVB5MjZaZkZmSE9lblZE?=
 =?utf-8?B?aHhrTlJ1T0NxTUttaGhKZk8vaGFJRDVFNXh5eWo5RiswMGplZlFtb3FvTXcv?=
 =?utf-8?B?clVZaGozUktFOWVMMUV0aHZMR0lkVGJTam9XOWhmS2ZtWEwyUWl2dnl1RnNT?=
 =?utf-8?Q?nhnVOLXDsbDmPitDc7kMjcEA0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc7d56f2-d561-4492-2b49-08dab83027d3
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 15:30:19.4312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P+HVkk1Vk1INgtCWlnKkNPLUcUV2yDvHtWWk/TzrK1r/Z11gv7jQKkDr+/vI6Y8O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6448
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 10/26/22 15:23, Reinette Chatre wrote:
> Hi Babu,
>
> On 10/26/2022 12:07 PM, Moger, Babu wrote:
>> On 10/25/22 18:43, Reinette Chatre wrote:
>>> On 10/17/2022 3:26 PM, Babu Moger wrote:
>>>
>>> ...
>>>
>>>> @@ -2845,7 +2846,8 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
>>>>  
>>>>  	list_for_each_entry(s, &resctrl_schema_all, list) {
>>>>  		r = s->res;
>>>> -		if (r->rid == RDT_RESOURCE_MBA) {
>>>> +		if (r->rid == RDT_RESOURCE_MBA ||
>>>> +		    r->rid == RDT_RESOURCE_SMBA) {
>>>>  			rdtgroup_init_mba(r, rdtgrp->closid);
>>>>  			if (is_mba_sc(r))
>>>>  				continue;
>>> The above hunk and the ones that follow are unexpected.
>> I am thinking the above check is required, It is updating the
>> staged_config with default values. Right now, the default value for SMBA
>> is same as MBA default value. So, I used this code to initialize.
>>
>> Did I miss something?
> As I described in the following comments my concern is related to all the
> software controller code still executing for SMBA. Yes, in the above hunk
> SMBA would need (some of) rdtgroup_init_mba() ... but note that it contains
> software controller checks and in the above hunk its call is also followed
> by another software controller check.
>
> The software controller is just applicable to MBA and these checks have been
> isolated to the MBA resource. Using it for SMBA that does not support
> software controller at all is making the code harder to follow and sets this
> code up for future mistakes. I think it would make the code easier to understand
> if this is made very clear that software controller is not applicable to SMBA at
> all instead of repurposing these flows.

Yes. Understood.  How about this? I feel this is much more cleaner.

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index e5a48f05e787..d91a6a513681 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2845,16 +2845,18 @@ static int rdtgroup_init_alloc(struct rdtgroup
*rdtgrp)
 
        list_for_each_entry(s, &resctrl_schema_all, list) {
                r = s->res;
-               if (r->rid == RDT_RESOURCE_MBA) {
+               if (r->rid == RDT_RESOURCE_MBA ||
+                   r->rid == RDT_RESOURCE_SMBA) {
                        rdtgroup_init_mba(r, rdtgrp->closid);
-                       if (is_mba_sc(r))
-                               continue;
                } else {
                        ret = rdtgroup_init_cat(s, rdtgrp->closid);
                        if (ret < 0)
                                return ret;
                }
 
+               if (is_mba_sc(r))
+                       continue;
+
                ret = resctrl_arch_update_domains(r, rdtgrp->closid);
                if (ret < 0) {
                        rdt_last_cmd_puts("Failed to initialize
allocations\n");

Thanks

Babu

>
>>> Note that the software controller, when resctrl is mounted with "mba_MBps", is 
>>> only supported by RDT_RESOURCE_MBA. At this time this really is hard coded all
>>> over the place, for example:
>>>
>>> static int set_mba_sc(bool mba_sc)
>>> {
>>> 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
>>> 	...
>>>
>>> }
>>>
>>> Since SMBA hardcodes "delay_linear = false" I do not expect it to support the software
>>> controller ... but these hunks appear to treat SMBA as though it does. It is the "MBA software
>>> controller", not "SMBA software controller". Why does it check above if the MBA software
>>> controller is enabled on SMBA?
>> There is no plan to support SMBA software controller. Yes, I think below
>> checks are not required.
> Thank you for clarifying. Having the code reflect that clearly would make everything
> easier to understand and maintain.
>
> Reinette
>  

-- 
Thanks
Babu Moger

