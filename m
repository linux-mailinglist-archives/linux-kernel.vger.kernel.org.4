Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A45573702D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbjFTPSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjFTPSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:18:39 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D66DD;
        Tue, 20 Jun 2023 08:18:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0Enj7ElVHrRwWxIfuRNjvnf2ObhrJ7IZq1IV+mkGen+bFt8x9M4lU8Lvl9OqxyXH3Xp0d+czcAuaCUd+2KuProzPVR+0JH7Vi3R3WI+74F9A4yj983l2z0ErLi79G4Jz/MbHqxnwHNgjUIWQbaUkOQNqp2hZfEVmbOuAEeOgquta8bwM63sS+/FfUcgo51MomnWtwwyGR8/RqN3c1+HYkxbPGwTJx8UvY/IuesBWAlptebRXdx4MZHQstGe6heC03RQSQHpZRNVR5bYZNcaV50BrkAC4szVQSUnPrZ6PA63J7JWw5tG4gdMFdYXqIczURZ5h/RaQU6aWgnewc/F6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LvCVDv2HRfQvh68n1u9bP5eOxq7a/G33NJLunAFvttA=;
 b=DJafF8yYKqhz9uz4Fu6AhysxwVyJGtarFGrZi7B4lIMtNCLllPn3zo5jWnbLabBCOFU4LAIZpe7Hp6EeugO4cL46KSeb6/wZLQ9OXmDU7uURSVIhK1GTcHgSp4ZQxAX2GLMKc/xq7+D30ny5o9CM80GjU/VyvtXdYI7RBeSer9FyVJOPkm8i1jl0DaDoQNgg/J628k3VHljF5+O7NFTQU96riIOlR0LFojwP7b6wx3CqWs7VzvGieFA4dU15zGrjIsBZ0M/FbHIGyQLoOWk5zykqSBlHCN6sVe/DIoyhh+xHO+RJMVb6Px9lwuGeB5/gFWY6M/jRb6FGU6QbdSCmWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvCVDv2HRfQvh68n1u9bP5eOxq7a/G33NJLunAFvttA=;
 b=H1q8i6pw+wWRl+ljOS/vrSis7VYWJ/hOTMwzQyfnfP20/P/9cSl2AkFEPxUgGfcxglcIzAnzrpCbabW3/OK3dFJZirVelnwdeV0dcdx+by+lhbSFyV2XXcQ1y5ANuCwnAJ7YoPVNitlXuqAjuT39v9uMrH8suw82iUqApJaWiws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ1PR12MB6267.namprd12.prod.outlook.com (2603:10b6:a03:456::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 15:18:33 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6521.020; Tue, 20 Jun 2023
 15:18:33 +0000
Message-ID: <9e3577fa-2bd2-da2a-bc35-5e70f49e011d@amd.com>
Date:   Tue, 20 Jun 2023 10:18:30 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 2/4] cpufreq: amd-pstate: Set a fallback policy based
 on preferred_profile
Content-Language: en-US
To:     Huang Rui <ray.huang@amd.com>
Cc:     "Yuan, Perry" <Perry.Yuan@amd.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230615063225.4029929-1-perry.yuan@amd.com>
 <ZJG+Xhun1Ltw9ox/@amd.com> <bffb7ba1-c8cd-2653-94a6-e0b5cb52bc49@amd.com>
 <ZJHAatXe+iVzM/JS@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <ZJHAatXe+iVzM/JS@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:5:60::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ1PR12MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a1548df-d783-4aef-53e2-08db71a19c8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cy0eplkQcSGZLkHeJES6ICzgEip4J48Wq2Tgs/AObHRGK1jS8flLk6IZOWl1vRQxBgsLa1b2idjdrCVUQl6ILHAc5yVXcWNFGN2ThvvqgNIST8NLy39mvvDgjaUD0ZF8ZcQTNw9WcysTi7UEeIuHM1c/uKQHokhb8Dyt2/ZrIaHCK9Za/vOofIlmT37fmIkGrlDSCgPUfAHzlTaikxcv9oxne2vK3Aq0lFTbCGKyB4LWYF+lL4l/AImD8mpBB6aOs2nXDCydwxedS7Huk3dHvcFqtfyXg5swb3OAzvvHqwGMKsmEebqGgyfFZs8E4XNzvEDaXC3wp1aSHw2Xmq+EW8dhTGzfwYmymjI0s7Fp5rXiOQ6TOtL8dg65mpvO5eergZEdbgmJDZBVloTUD89qYgsxfR2KOm7UNADF9NZwmO/ssOuVHyVQyguQssQjrbZl+seeGf7gw9lR7SjnLgkbG1m8f9SwLpykU/1ITNPzdeNzCMBQmGFRmZ/zrOcbeavbVQZWN+eASwpf1/nZV6SKLNuJ2D0ywab2X4sx3kW3CBz/PhV7UXkHqVQVBbwTES+wIi19f5/AGuwFIXgKomDAUTNoAsWKpMlrTz9lsXsRze7xqlnJbR/GxLJ9fhcdfSiVHmToRbG6vhZCw5RPGT3tag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(451199021)(6862004)(31696002)(86362001)(41300700001)(8936002)(8676002)(5660300002)(66556008)(66476007)(66946007)(316002)(31686004)(2616005)(83380400001)(38100700002)(36756003)(186003)(54906003)(26005)(6512007)(6486002)(6506007)(53546011)(478600001)(4326008)(6636002)(37006003)(2906002)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmtLRFh4QzdtcjI0RGFSNms3anhab1NURko4UDJNZUlhd05tZHZwaktjUUZF?=
 =?utf-8?B?OTJhb1JrS0xKcFJuMDltREtnemNBazdWN2UyMWNsYlpDc3ZLNW5yeFZwR01t?=
 =?utf-8?B?VFpNUmVUai9ISzVpK0ZrQTRPNGFKM1JoNWE2LzFYOSs5V0tUZjFqU0o2Vm96?=
 =?utf-8?B?L3FnU2ZYOHQ2dWQzRUtsU0xscEJNbkdodk9vdktvb0M1Rk9pd0RQOGE0VGZl?=
 =?utf-8?B?ZGRRK2hMWW5BTkVFbEo1WFo0K2J2ODZjQ2ZsWk5UNy80bW1xN0Jka2U1ckR6?=
 =?utf-8?B?a1VLdG9uTGh3K0lKaFNBTUkwOUpwMHc0T1U4K3cvYjU4OG43UXJnWFhlSlVx?=
 =?utf-8?B?NGM3cndoMTJuRTV6SGNCa1NRUnhSV290T0wyU1VwR1Y0aG5XTE1QNG9nTFdw?=
 =?utf-8?B?WWJyN1lPUW00WjRJZ2x4aHdDWW5GRFNuVzdqVm9ZYklWY21ZanZ3ZTZ2cGpj?=
 =?utf-8?B?emdFN3QzSnZmVU10WTZJa3JiV015am1rYnJSZTFpVVp4a3lpZUFCUzdZQWEy?=
 =?utf-8?B?RTZjNHFPT1NtcFRpajRvdG00cGdCeWVSZ2V0YlBwZjBjWWs1YS9nS1dwb3ZX?=
 =?utf-8?B?NXptUGt4UDRDeUV0U0lRRXNmR09Za1ZMOVRocnJubE1KVm1BaWphSE1zZGFJ?=
 =?utf-8?B?K24zRXJwYkhGV3ZGKzJxWVVnMjE2U1Y2VHEzNnRyQlBtQzRuYkRqRHZzamRt?=
 =?utf-8?B?M1I4STBOSkZoemNKTHJHRk1vVFRZcHFmeHpEdWRrZUE2ekptaXpWeEFlTFVz?=
 =?utf-8?B?V1FCUkg4MEQ4UmF4dk45L3JXZ0t6cmtBcHpJQmdMVlBaVlp1bHZ2RnhGRmxT?=
 =?utf-8?B?Z1hKKzBDbUY5YXZ0YTFlUFo5RGhXeUxaV2ViVEpHN3QwZWovYTF6MWtTdlpQ?=
 =?utf-8?B?MWJEc0ZaaUl0SkpyTFgxL2I0RWhSNUZXOXhDeklvTjZERUxwRXdneFR6QVFY?=
 =?utf-8?B?RjA2eThETFNuTTdFK25TcUlxa2Z4TWdQRk5TTVRDR2NjN2V0N3R1eXJpVjJS?=
 =?utf-8?B?Ni9DNVo3QXRaUXpJV1hZdk1zdXhzK3FOY3JnNGJlUTgvNWp5QW5qdERMWnht?=
 =?utf-8?B?bkNnQURWSUgzRnV3OVMxVTFhV2phbHREcWxLZXErOTZzTnpOZXZVMms4NFZJ?=
 =?utf-8?B?WGwzTU1iNUptQXg3ZWFEeFZ2VS95VHNFanVJREpuUHAxSHlLUTdYSFZTYnpa?=
 =?utf-8?B?dWtYMmFFbHhmMXNTc1NTOHBueTFpc0kwWDNiTDl0QzNTYUZuOGtQWWlRUFdi?=
 =?utf-8?B?ZTR4NTNGSzJjVXdYS0IrWnllRGFqa2p2aDdOSXdwazVFUjIxQmtvQ3oxMjMy?=
 =?utf-8?B?ZmZoYlIwclcycm9jRFllTFMzODVJOFpZS2tidnY0VFY4ZEtqT3VlUnVoWUhN?=
 =?utf-8?B?cVNURXJlYkZZZ3ZoRjNpQ1N1T1dwMmZXNmxDUlNsZVRvRTJKeXJDUVNrTVcr?=
 =?utf-8?B?MGtRU1l0R293NEZxT2t1NXR6NERQZjQ4WUllSnNzRE1BNVZKalRCbnFGdzZI?=
 =?utf-8?B?WjVjaWZOZGlaNmV3cU5WdUFHQkh3Y05aTEl5QnNCSzRjWDIrK09uQ2VtZFFC?=
 =?utf-8?B?M0kxZnVsVWpYdUE0Y3oxd2JaYUExaS9vNGhmUW5FV3JsNEgrVENCQ1J2VFo0?=
 =?utf-8?B?d2h2dTBhN1NVVEtHUjVlNi9TdU5NMUxUa29YNDBTakdlS2lDbGN6RHphN0lH?=
 =?utf-8?B?WWlqdWJNaXMyRVhNSzBvY0IyRFlCRVJldzhmZkRYekhJaU5EOGNqbnNBVzB4?=
 =?utf-8?B?elJsOXJzK1luaVZXclpnZGVGQ2NPbFNITFlLK0VpRWxaT2Y1TXorelFOdXBP?=
 =?utf-8?B?aCtndUJsTHVuYmFKTFpPWDNsK0lPallZOU02d1RYNVowNnhoeGVsRXl3dWFi?=
 =?utf-8?B?SnE5bkcrUTVqWUFsMWJFdlJjcGdnL2o3MUhuc1Q4ZGFURno0VGNvaTEyQW10?=
 =?utf-8?B?UlVrakYzKzBDR09ZTlNIM2ZGRFRQNkFEWUVTUkNuTzhVc2xoNGxvY2tQK09t?=
 =?utf-8?B?TytYZFZhd0p6NTJoTUNZNVlPUDhEbWVackdmaGVFTis3amRIbXRid2luVWZK?=
 =?utf-8?B?UVRkNnp3L0NNZ3ZsazdhRXFycVVPVVVSWmdmZ2lUS3FvRU12R2phY2FsYWZo?=
 =?utf-8?Q?MM/oDSWfDA0lqr2Y5vHsXju7t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1548df-d783-4aef-53e2-08db71a19c8d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 15:18:33.4566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3+DA6zuyXy1u7Q26Vw814FF13jLtCxWT0IjJiiDpk4QLrglBELxyq0/NS9WUm8Yc+4dKcMBkw8PdOZcAh1j7tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6267
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/20/2023 10:06 AM, Huang Rui wrote:
> On Tue, Jun 20, 2023 at 11:02:00PM +0800, Limonciello, Mario wrote:
>> On 6/20/2023 9:58 AM, Huang Rui wrote:
>>> On Thu, Jun 15, 2023 at 02:32:25PM +0800, Yuan, Perry wrote:
>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>
>>>> If a user's configuration doesn't explicitly specify the cpufreq
>>>> scaling governor then the code currently explicitly falls back to
>>>> 'powersave'. This default is fine for notebooks and desktops, but
>>> May I know if the processor is powerful desktop such as threadripper,
>>> whether it will be default to 'performance' or 'powersave'?
>> It's currently defaulting to 'powersave' for desktops and
>> workstations.
>>
>> Do you think we should adopt performance for these?
> Yes, I didn't see any different use cases here between server and
> threadripper here. Or I missed anything?
Workstations and Desktops usually have to go through energy
consumption certifications.  Couldn't setting it to performance be
inappropriate for those?
> Do we have a way to separate them?

If Threadripper identified as

3 Workstation

I'd agree; but I'd think we're going to lump AM4/AM5 desktops
along with Threadripper.  So should we still set all those to performance?

>
> Thanks,
> Ray
>
>>> Thanks,
>>> Ray
>>>
>>>> servers and undefined machines should default to 'performance'.
>>>>
>>>> Look at the 'preferred_profile' field from the FADT to set this
>>>> policy accordingly.
>>>>
>>>> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/05_ACPI_Software_Programming_Model/ACPI_Software_Programming_Model.html#fixed-acpi-description-table-fadt
>>>> Suggested-by: Wyes Karny <Wyes.Karny@amd.com>
>>>> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>>    drivers/cpufreq/amd-pstate.c | 7 +++++--
>>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>>>> index ddd346a239e0..c9d296ebf81e 100644
>>>> --- a/drivers/cpufreq/amd-pstate.c
>>>> +++ b/drivers/cpufreq/amd-pstate.c
>>>> @@ -1102,10 +1102,13 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>>>>    	policy->max = policy->cpuinfo.max_freq;
>>>>    
>>>>    	/*
>>>> -	 * Set the policy to powersave to provide a valid fallback value in case
>>>> +	 * Set the policy to provide a valid fallback value in case
>>>>    	 * the default cpufreq governor is neither powersave nor performance.
>>>>    	 */
>>>> -	policy->policy = CPUFREQ_POLICY_POWERSAVE;
>>>> +	if (acpi_pm_profile_server() || acpi_pm_profile_undefined())
>>>> +		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
>>>> +	else
>>>> +		policy->policy = CPUFREQ_POLICY_POWERSAVE;
>>>>    
>>>>    	if (boot_cpu_has(X86_FEATURE_CPPC)) {
>>>>    		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
>>>> -- 
>>>> 2.34.1
>>>>
