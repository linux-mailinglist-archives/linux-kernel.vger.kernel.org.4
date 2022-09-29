Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384AD5EF732
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 16:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbiI2OIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 10:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiI2OIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:08:18 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B311B3493;
        Thu, 29 Sep 2022 07:08:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L18ovSRHitiS5TJ2Ygx9epEzT1NlZ04y4rNZ3ngHdx/DVNMF+iPl6xmWQx8V+JqRQohZgN5WEyfZUNP1DQDhzAgeh+Y0Ny7TWJqq9wBJG/LPzobFvO4uxjkDA0p4zXK3/WwUwEyUgR52j7W5RsLdmJjo86J4BQviln/sKVX+U4YkVOiI4s08li7kY/SnbbwJtWNrXmZFCp1b/e/yBUppOyGswR4IqHmdcVYxr/lVoBEeOmpT9BAlr3bAeLH4ZirP8s/7VmBx/N+DUaGQgW4lvjh9OlnpMeI9iJ5m50enXhy+3Vqzn8dAaH/ka4cisFAzxwpx0sKS77w2sdfN9NgL1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Pf1tF14KTjvpLsXVBJyaImhKRfYnAGROV4RGZMZQFg=;
 b=ffU3lWFL8UItWS6Y6kkyGKLjA+hOUbLyZ1FTag9S+SE6FNjk1LX9BDYxQC0MAjvTcotJSLHUme+zHuOTODWny/UWIhrBbKB3AaWA8sTqp6FBX/CisqQlX30WUZ+0FmkP3+TaWy/fh2ZXKPn8vCMA9L8nAVlvCKrdeaq8tY3B1J7m1GGQpGuikov7PnLDCk5DSbLKU1Vq1k2o3JVkVj+KD9sxvJRQgm+htysz5rqhwYCkbE4v4P2D9Ob1/BUSRUoiSJMWHGDhgBPrIMcqKi/8wAfX2jZrrxMTTCDfnRiTReVmUNvJd5L0d3izzPna8ZBgmj2BPF2hvz1kp1RYUpkolQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Pf1tF14KTjvpLsXVBJyaImhKRfYnAGROV4RGZMZQFg=;
 b=U9aiC9AsvrIiNDBU6tlODRjCWBtvZ4f+iSPaOiEzEvde4q/hXiHhjCG1/uuNsPUkeocBT1gQDQHRc3cAUdf4k+LYEYcGSdPMIDtui7T9oY+GbIGLh9I980yQM+D/gmGd1HqghzKdjVdORId5nZreYgb6Mtj+FzWHXojqkB3p92U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by CY5PR12MB6478.namprd12.prod.outlook.com (2603:10b6:930:35::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Thu, 29 Sep
 2022 14:08:13 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::a02:442a:25ab:c5ea]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::a02:442a:25ab:c5ea%8]) with mapi id 15.20.5654.025; Thu, 29 Sep 2022
 14:08:12 +0000
Message-ID: <a2ac526b-477d-277c-07ce-2b05c35b643d@amd.com>
Date:   Thu, 29 Sep 2022 09:08:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/7] cpufreq: amd_pstate: add AMD pstate EPP support for
 shared memory type processor
Content-Language: en-US
To:     "Yuan, Perry" <Perry.Yuan@amd.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
Cc:     "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220909164534.71864-1-Perry.Yuan@amd.com>
 <20220909164534.71864-5-Perry.Yuan@amd.com>
 <a21bdd7d-3ade-4a54-1a7f-42831ce8e83a@amd.com>
 <DM4PR12MB5278639EB4E0FD416653743A9C539@DM4PR12MB5278.namprd12.prod.outlook.com>
From:   Nathan Fontenot <nathan.fontenot@amd.com>
In-Reply-To: <DM4PR12MB5278639EB4E0FD416653743A9C539@DM4PR12MB5278.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:208:32b::20) To MN0PR12MB6222.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6222:EE_|CY5PR12MB6478:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fca4ccc-feb1-4a01-0c02-08daa2240bb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HvYGvgok+bZBoUVlWxYXVWyqttc/AJA14NDqUZ/gP/QB3BZ4zj19++WmZyoHD++WLZwq2vmCkYmgl9QwdAhX7DfD+vI5JYBBy65uhMYSrXCifRqDpq2K0eE+18jkqxdU1/aDtkD7ZUm6uxj23APLY84pQmciEdKnIAaXa55iu435sEAEjuSX96JNsiuUQLbscXexfa2n2TMf5MGhd+aHt10mQLtXzkoXpnNNcs+bhtksjpFUz/kK1/QMZT0GUX1Dfx03HvwmMzVCXmaV+sVsi4/58ZkaI0cU6fSLwznbI/Iw/OE1puK1dYP5nAZM2G9FqWu5hK6UcIfnH+jaVts80HdRoDRWfER87143MjUCVDXiGTcyOAGLIh9hrhAKAWKO7B5J0IH/Wb+y4Ofbp8dzbivZCoqkOEQ+asLXlEOTtIza5sRpr1hML9H+loLTyBnKH3f5YcHtYn7MADqL575Ap+tluzjVFR5NkNtpf+5y9Q/bqZQ9/I8N+EjE12Ak91LDGv1BCKp+IxZH88/TTrfIqQidi6UzLlOxdmERtIpyq4mUj8h4ibUuptGheh/MNF7vwh3y+Xl5klKqr7KqIKnwPYsY9xXl2+7xlDEK+i3n5502Osmi3TmpFGoF8OuITFQzfMNmCqiJf2LX84p62W3lLKvKNcziqbiDmRxAPaUT0qmy+/JXLfoDISbMbnkonh/t6LXjVMd8ieDNeAH5yg/Kj67oeE3BmfsEH911rKQd0hNgj6rugWjUOQPo/9/mzfPlpMMEZwXtAgNgUY3ZXswMgtPY7e8V6NyZKjVLeBcK1ns=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(451199015)(31686004)(110136005)(36756003)(54906003)(41300700001)(86362001)(5660300002)(8936002)(26005)(6512007)(2616005)(31696002)(4326008)(66476007)(6486002)(316002)(53546011)(478600001)(38100700002)(66946007)(8676002)(2906002)(186003)(44832011)(66556008)(6506007)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STNxRnZjR2RBMnZmdTh1dnY3Ui9iVU1CUURPZERkWEhKM21UZXhkT0dlUzJ3?=
 =?utf-8?B?cHY2MDhmbU91Lyt4NWMzUDV6MjUxeFZvb0g5QlZRWWt6OE9FZ1A4NUNxRzFN?=
 =?utf-8?B?MnArVjVXUzAyVFdRZEwvN3gvSEY1clR0RG52MVUvYmVZK01ybEVRTWRDL3FW?=
 =?utf-8?B?eG83S0R5d0R2aTJ0ZXpDaXg3VE85bnkrb21ESDlDUEJkeWdQcWk4R1pWSTZa?=
 =?utf-8?B?SUdVcnNBak1sSmxUVFpPYmdFcTFhVXJUWlROU3FiK096dlV6MFNycy9qTmlm?=
 =?utf-8?B?U0sxUWZvR3ZEOXYyVm9PNDN5ZjBpc0lwUENBc1Zxc05hSmgrOXBSdmNPYmhs?=
 =?utf-8?B?YzRSYnBqR0h1T1VHZG5XYVhXd2dzVHFyRkxKcDhQak5wUnZtdXdKVmlRTHBY?=
 =?utf-8?B?bXNmWU1qMXpqS1N6NXZVWTlGUUNHdUFWV0VOb05xd1BwYVJ4OXVQR1VGY1dx?=
 =?utf-8?B?Y3dxbktHRlhxMEpoR1IvR01VclFTS3RmU0JwNHVJUmNwV2ZiZE0yemRraFdw?=
 =?utf-8?B?SGNIM2V3QkFiT3A5WjZHZHpQWHBuN09tWUxHaHpwN1NFalJuRXJMYlRRVkFR?=
 =?utf-8?B?V2YwbVFjakZxVVovY3hTcGsxUmloZi9YUmZ0emVSREVuMkpQRE84Y0EvaWs1?=
 =?utf-8?B?TXphcVk0Ync2YnBqQmMzclBmcEhwVjJyUlZoemgwb2p1MXlmcGI5RE95V2lH?=
 =?utf-8?B?N2hsVndhZkVORkRKbFdMZy8xVHhpNEVERUdmSTdLSDA2OVJZMXBJdkxQYWls?=
 =?utf-8?B?Ry9KZWJCNGNhcEpNVEh4aHdoZW1pbjZoSHhZL1kxNnpZaXJpTEJFMVEyVW00?=
 =?utf-8?B?RFN4TmhCS2xlQVJ1Z2J3WFNuQzFyRDg2ckxCYitHQzF1dWJMekFaTTBpNCtL?=
 =?utf-8?B?Tk9tUG5kaFR1UGF6ZXc1L2tRajB2U1pVemZYZ1BEQVhMTXdQT2FGb2ptbkly?=
 =?utf-8?B?UGM2WXpCbFE4aDZyZk02aE9UY3JPczM1ejhsd3BkSHZDMVB3R1dsTVpiVTBJ?=
 =?utf-8?B?eDhFNVNGaVVGazJsMnNDbjJobGFmTFBnbnNwNlNDcm41RCt1eUl3dVREVnZJ?=
 =?utf-8?B?dmhIenQ2a2pTNENDMjdKeCthdXBtWG16ZlM2RFE4NGRBb1gwdE9WTXFYUXox?=
 =?utf-8?B?TXVURWNxWThGK3pBcVh2UG1Fd2dJaVczZEZwR1RaK0tTTUJsUS96eFBjV25s?=
 =?utf-8?B?KzQra2xSdkFvVGtsMWMwOCt3RW5qVDd0Y1VsREJYWU5tRjZKWVdhRDh1Q2hO?=
 =?utf-8?B?Tjh1RVR5ak9IQWZieGIrQnRHemQzNmZ1anJRTisxdCtxR3pBTW12L0M0WFJj?=
 =?utf-8?B?dzZjVDFydmJYdnErZFA3OGxwVGt1UGx0NDQrWjRsT1pPNEJsc1pvc2VqY0FX?=
 =?utf-8?B?UEh0U2xSQTkramI1SWQwUXgyWFdqaEI1RnF6b2RKTktBUmxsMThuMC9uVWNL?=
 =?utf-8?B?ditUSGZ1T250Vmw2ZUVBSTBrcG5xbEFHb0NPWVlzREdldU5nUU1zRkxPWWk3?=
 =?utf-8?B?T09PbzlxSjE2eSthdEZrb2l3TEJLMW4ralRMSmhLdlgwajVuY29JR2d0M25q?=
 =?utf-8?B?WU43WUY1WUpsajg2czVQRWVueEFtNVZSaHZoS3JvTnF0Z3hiUFZUUEE3T0Fl?=
 =?utf-8?B?dFlwMjNkVnNFbzFsaHhjRms2NEhab296cnRldy9mMkt5aUVUTXBPOUxOM0Y4?=
 =?utf-8?B?all2Tlk1Znh4VU51UjdrUG1Gb2RaR0hqN2E2ZE4zOHI1MThGdGJ1eStWRFlD?=
 =?utf-8?B?TzZ6ZjdBSElYVitDZmdDRzlTdjBhVUpHUjdVNjBZR2hzQlE5ZGhabzFlOVZI?=
 =?utf-8?B?a2FOQWk5SllpOUhSQmF3RytDMHFWUE1DMnNKQy9UL1pZanordS9CWC9uRVpo?=
 =?utf-8?B?bkVDTUpSM0QybnAwc2YxdWVoWlRHeW4zSmRlTzFQM2dFVEVuM1BOR2QyN0Q3?=
 =?utf-8?B?b3NLUmI0b1dtbmtYUFJXRDd5MWQxUVRmT2h2N0Z5TSttdGE3ZE92R1dIbWJl?=
 =?utf-8?B?VEVKOVltTmt0ejFzcGdFRGJ5TzNPS1h4UXJlTjYyNzRwNVl0M1pZODNNQjBI?=
 =?utf-8?B?WUhldXl5UDhXRERwL25OZlJTYzd5UWUvZThLTmozSHdjTFBQOUpuZmh5ZUFG?=
 =?utf-8?Q?jjHwAnxNLBl8NkkPrSTIkQO4H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fca4ccc-feb1-4a01-0c02-08daa2240bb6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 14:08:12.7067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bt27C6rkXQfkn04ydNMc9cYVIYJkSSOn7m2/iYVEFvlkS0lTiMPf6ilbSM3r5sYUohVi1zKi69F3a/spxjQepQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6478
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/22 07:23, Yuan, Perry wrote:
> [AMD Official Use Only - General]
> 
> Hi Nathan.
> 
> 
>> -----Original Message-----
>> From: Fontenot, Nathan <Nathan.Fontenot@amd.com>
>> Sent: Friday, September 16, 2022 12:24 AM
>> To: Yuan, Perry <Perry.Yuan@amd.com>; rafael.j.wysocki@intel.com; Huang,
>> Ray <Ray.Huang@amd.com>; viresh.kumar@linaro.org
>> Cc: Sharma, Deepak <Deepak.Sharma@amd.com>; Limonciello, Mario
>> <Mario.Limonciello@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Su, Jinzhou (Joe) <Jinzhou.Su@amd.com>;
>> Huang, Shimmer <Shimmer.Huang@amd.com>; Du, Xiaojian
>> <Xiaojian.Du@amd.com>; Meng, Li (Jassmine) <Li.Meng@amd.com>; linux-
>> pm@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH 4/7] cpufreq: amd_pstate: add AMD pstate EPP support
>> for shared memory type processor
>>
>> On 9/9/22 11:45, Perry Yuan wrote:
>>> Add Energy Performance Preference support for AMD SOCs which only
>>> support the shared memory interface that implemented on Zen2 and Zen3
>>> processors, because this type CPU has no MSR supported, it will use
>>> ACPI PCC channel to enable EPP and reset desired perf to be zero.
>>>
>>> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
>>> ---
>>>  drivers/cpufreq/amd-pstate.c | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/cpufreq/amd-pstate.c
>>> b/drivers/cpufreq/amd-pstate.c index 451295284a26..fff298744a8e 100644
>>> --- a/drivers/cpufreq/amd-pstate.c
>>> +++ b/drivers/cpufreq/amd-pstate.c
>>> @@ -133,12 +133,24 @@ static inline int pstate_enable(bool enable)
>>>
>>>  static int cppc_enable(bool enable)
>>>  {
>>> +	struct cppc_perf_ctrls perf_ctrls;
>>>  	int cpu, ret = 0;
>>>
>>>  	for_each_present_cpu(cpu) {
>>>  		ret = cppc_set_enable(cpu, enable);
>>>  		if (ret)
>>>  			return ret;
>>> +
>>> +	/* Enable active mode for EPP */
>>> +	ret = cppc_set_auto_epp(cpu, enable);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	/* Set zero to desired perf to enable EPP control*/
>>> +	perf_ctrls.desired_perf = 0;
>>> +	ret = cppc_set_perf(cpu, &perf_ctrls);
>>> +	if (ret)
>>> +		return ret;
>>
>> Shouldn't this entire block be indented one additional tab over since its part
>> of the for_each_present_cpu() loop?
>>
>> -Nathan
> 
> Yes, I can see the indent in my local vscode editor, I do not know why the patch didn`t show that.
> Is it correct as below ?
> 
> 	for_each_present_cpu(cpu) {
> 		ret = cppc_set_enable(cpu, enable);
> 		if (ret)
> 			return ret;
> 
> 		if (epp_enabled) {
> 			/* Enable autonomous mode for EPP */
> 			ret = cppc_set_auto_epp(cpu, enable);
> 			if (ret)
> 				return ret;
> 
> 			/* Set zero to desired perf to allow EPP firmware control*/
> 			perf_ctrls.desired_perf = 0;
> 			ret = cppc_set_perf(cpu, &perf_ctrls);
> 			if (ret)
> 				return ret;
> 		}
> 	}
> 
> Perry. 

That looks much better.

-Nathan

> 
>>
>>>  	}
>>>
>>>  	return ret;
