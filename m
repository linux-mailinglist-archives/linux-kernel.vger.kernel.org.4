Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0B16138F5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 15:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbiJaO2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 10:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbiJaO2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:28:51 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248D0108C;
        Mon, 31 Oct 2022 07:28:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+HwrpwjXenNlLan2SVYhgTVCnG7SFhBBmrJjaguv3gV0rFyPdeH+sbRjXFyxrGJ+nkpzsehU+dLcsZeGdvYHpCyXXAWezryNnAEZaDT3ClqaZcAm3/Ywe9SU18SU42Rn3v8YyVIsf+bVtW1bcnBIkscQ69UUvlGrqRu720qwGwb0VVGW5JdKzRqfC0dNxHJEk1ZF/6k8JvwhSOltJsV7XjC/gKy8Tf7zoxbOA8ckFVU90do7oesuwHkB5jp/PeedFiTxPvmn8wAW8/vMpqTWnTdTAE+mhrNB6PEp/cAGW58Myt7pWzdnLp2jhvnQawctuy1fBAyr3NAaRqwz8xpGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o19NxFTuPFeUi8BgTHzQsmJVxOfTZ+APnH5VfeVQV5o=;
 b=Dy52RIuhJMgKTzj3+hhjIXl6hgAhfyuIGKa8XN0DLqStJ8SzivcctJyCnNKQVUEQSGiVxlJwf5smH4P0HG3QC0O5vHWTOdgzisye3nzZMyaLhnGUewftY2MeV/PyzhPUOxbQRQYIdCmrZSgkGR5ptbSlOZ0/A5hESzhgozfXZmtoBFWScv+zSsmgbbfP5Ku5xqDcOwBw8g+Trj1zyxOv287wcJLxtYwcIwcVNAWvtU33PPqrSqbp8Wm//0bX/BwSMxz7munJgnViKZPsduRQD7ifTwwg1nLMg95b6hZxKdbB7nVZrn7Rbi8UGbw2rIecDLHaRz4dW9VoGwYlEvGYjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o19NxFTuPFeUi8BgTHzQsmJVxOfTZ+APnH5VfeVQV5o=;
 b=jPHRMmheT9UHr6jMQp1/SZobHY9PYphWpNll54Gk0UcqrD5AkfNvdgcIk6DvrYMbPyjJCwzQ3nzpvCGyB6sZr+6rDXCjEye0b67oJdBd5MNzb4xzALrVVveyqaxUvc0XEYFXCjxGw70a5gVeR8g4DAv/GfKVivELQ2diKmNiDW8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Mon, 31 Oct
 2022 14:28:47 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::a3b5:7bec:ebd7:b30c]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::a3b5:7bec:ebd7:b30c%5]) with mapi id 15.20.5769.016; Mon, 31 Oct 2022
 14:28:47 +0000
Message-ID: <a9677c3e-1f2b-a18f-97f5-9cc1a216ed9c@amd.com>
Date:   Mon, 31 Oct 2022 19:58:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] arch/x86/events/amd/core.c: Return -ENODEV when CPU does
 not have PERFCTL_CORE bit
To:     Peter Zijlstra <peterz@infradead.org>,
        Liang Yan <lyan@digitalocean.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221027133511.161922-1-lyan@digtalocean.com>
 <Y1/Gvs0xkk/W0Nro@hirez.programming.kicks-ass.net>
Content-Language: en-US
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <Y1/Gvs0xkk/W0Nro@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0210.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::19) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|DM6PR12MB4338:EE_
X-MS-Office365-Filtering-Correlation-Id: f1fe0971-ae24-413c-22e4-08dabb4c38dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S5+1SSMVtwGoZaTMLOe84AFATfyBFFr4ThKebEB54lpSVmgNbeTKHSzkaAqLLY8gfGBOAhenKl3ZJux/coS95QqJ7NToVUqOjZxTpiohYlgpoMR1vKna6Vvpu8S6eMNiLhf9lx5EGk9Sr386DbCloSoY+Bv/z3dUH06eSWUxf2ZEd7hHLrOCAfC1gDa7bErKTmnHY10x+rYcuYQmBPD7yRjhxuDeyxojCSHtwg0Qd9/NZ0wXyWLqVCn/DwEvkoVkWvXKjapSZaPPx/FqZbtw5uPVy+eEp0mDC7BT09/xKWMhBjhqabSGFVc+rCZ3FPPK7qnOkeoq4sPqGYhuCQVyYYQxmqlgY95PZzJ6YpYLwm9zTl+X3Y2lOg86+daxaYbdLtIQbMHDrAW3JTwlALnjDYyp3suq1BisEFwa3V+abA0ox1PzXpAmd18o7S+4PD3GoqJaUscp2AtlrLUP5aADAKqgZba4UKUT5bgrcttgrSAUp7scHrmqYSKuRIwfSZPRAM9oV6EjFs1iPWCmQH0t1DLtQpH9z4tQzk8rC2Fisb+dmVGKGvw4euIOZG+47BJaA/fuhPTZYcrmes3gQwYbcbY3FZj5mDwVWnGVjxmCakjrqz+iIXILyEwMzOCKpVCm80uabQMLQEv9pb1he/X38LYCtCZ7ZgxNtzhIaCohUUgZskNNsF8Ff33jTbJKyAdVn1vYPB+RbBpWTXD3EBTTF8mWZW3Qx4q1FMG93+VmJptvH3WftfIaTPMdxfzBmpyjBBVQqEvgdejumcaOehxjJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(451199015)(2616005)(6512007)(6666004)(44832011)(26005)(6506007)(53546011)(186003)(478600001)(83380400001)(2906002)(7416002)(54906003)(66946007)(6486002)(110136005)(4326008)(8676002)(5660300002)(66476007)(8936002)(41300700001)(66556008)(316002)(31696002)(86362001)(36756003)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHA1MkdaVlh1eVh6Z2c3MGtJOTZKTFNzRngrbFBsaERBbzBVOUlOcUdKcCsy?=
 =?utf-8?B?U1g5SXh3WlZFbnJ4emc2eEhZZHY0b0hSTDgxS2FZcHJpRHhHQ0J2SnI1Wk9h?=
 =?utf-8?B?VmFTL2JLd1JKb3lXOGNzakNubXF1R2VtSlhmM09Tb0VZbUY0ZEJDMlRzRSt3?=
 =?utf-8?B?OGIybGpOenJnN1Bxa2FNUm5XdWJRc2ZUUzBtMlAvS1VRdjJpMUhnZlRwYW1J?=
 =?utf-8?B?UjZVdjBPYzdnL3B0SG92WkJrQzhVS2FkcnZOVW5KU0RsS0hGNWZBemVEdFdt?=
 =?utf-8?B?LzNkeFpRdVlaSUtzVjduSlBIVENmR1hXRXdYS3dGa0dROFNKelZhS1hHZTZZ?=
 =?utf-8?B?ZmZiaHJCTEEySXhNR2NTL3Z0OVRIazBuNU9EV09NNzJqMmZJUE1lK3pHaW9Z?=
 =?utf-8?B?YmJ3bXc1d0FqbVYwSE1ORTBPQmhReW9XVElnQVd1UFFKelBrQU5TNUdXK2h2?=
 =?utf-8?B?Vk1vVlc3bHhDTHdPdEJRUE9oaW9uVHcwcmZhcTAvVWgrTWJSa01QVGorR0N5?=
 =?utf-8?B?K2ZSQi9EMXU5VCt3eUxnbFZpT0hSQzArNHc3WjhMWmZBSmxhT0ZpR0d2T3dS?=
 =?utf-8?B?cG1WMHNVSUM1b21DelBWYWhrNkNEQjFldjBBREFSSFViTTVQdGZZdXQxYWZ4?=
 =?utf-8?B?QmRYQ0tFVjkzRE8yMmd5eGI1L0hjTHo1c3E0UHF2dlRES0pzSEVjNWZsOUNa?=
 =?utf-8?B?b1VuaGJUOHJOWCtDSlp3MVNXVEJBek9MQVBBMkp3Uzd2Y2F2bGF2QlFtZCsz?=
 =?utf-8?B?QzdLb3J5eVk5SklHemdUc3VIdUlCTHZDMG1nSnhSODZIQmRpM1RuM2Q3SDQw?=
 =?utf-8?B?ZXJOZ3RlUU5sRTlHcTNEdVlOZkN5OE1yUTJGOVhreFZKSHk1c0hhOE11S2Jr?=
 =?utf-8?B?cjRhOUpDWkF0R2FKYVNGeFRsVDBBRTNZK21zUVJ4MTUzZlh2ZmlVaGlRWGta?=
 =?utf-8?B?d3pRdGZudCt2Y0VyT3RpS3d1YUZhSmZEbGFOS2VFV3lzZGRKdytPOWZ1MGZK?=
 =?utf-8?B?dTFmdEhDc1FXMzNIQ2piZDNCNWIwNVBNL2NpcVJBdWNPTTFCaGZmajIrSUFz?=
 =?utf-8?B?aFh0Qzg4UkNNU05GWHVRUWxIeHZpeXVjd1p1STFONXoyUkVHZmRZTG1qWnJ5?=
 =?utf-8?B?eTVhUnk2YXpnZFRuUjI0a3g3QmkveVdQbjNaNFJJaWFRR3R5eWlzZDIrSkZr?=
 =?utf-8?B?aE5mRDlBcFVWVUkrTjI2ZUpyN0Z1Q0ZyN09ZZzBvWG9hVDJqRkxmS2lPYktI?=
 =?utf-8?B?ZWVTYU4xYU9SR2Z2SHpFZEo5RlB5RHBOVi85QUt0WXNFeXNzQnpvOVZFRnI1?=
 =?utf-8?B?SnYzK1owY0JVMlZQVzN2OUR4dDduSStnOTF3ZC9yQWhwVFowQW9Telg2OEw2?=
 =?utf-8?B?U2k2dUh6MWVpb2hxU1RjU3d6QmhvcWRhbnYvRFhEdExmNklPZElFM0xCd1Bo?=
 =?utf-8?B?UWNkU1FEQlAyM2JBRmo5SHYwZ1Y5bXdIbW9FTlhOcXFVdmNkcU9VL0NVamRD?=
 =?utf-8?B?dndFNTJLT3Z3RGc1Vm5pTnJKdU5GOFpkWFhLRkVMM2pvN1lJZEI1dyt3VUtV?=
 =?utf-8?B?Qzh1Tm1IT2Q4QjBBTjhZblo1cWg4VUNXdlhZd21tZjhKYS9IY1lnZUlTN28x?=
 =?utf-8?B?dnRVM1Z4TUt5V3dyRkR5ZjVTMG9zYklhaCs2cnQ0SnBubFM1UU5sRExtTGV0?=
 =?utf-8?B?SGhqY2I1WGVZekR2TlBrNjVUNm94dWRneUJCcDk5MUcwSTdkSWpRaUduSHR3?=
 =?utf-8?B?RE9ES2F4Nms5VzJmTWM3eVlBQzJzSFpqeGx2cjR4NFJSUkkrempqMGZnWE01?=
 =?utf-8?B?cm41RVkyN0RydHN1eWJOQjR2Ly9nZTdrUXFOWGxUWHBoeGloOVFLTXd5cXFh?=
 =?utf-8?B?Z0FibU5zRXZXOUs1N2tvWFJPcnR5RnBIRzMrdUF4Q205QldPL2ErNnBXM1Zl?=
 =?utf-8?B?V1p3UDFBYlVMbTYrcHlIaU1ROEFBVi8wSkZKMG5qSVFoQmw1bzl2WmxwWVdv?=
 =?utf-8?B?ZHlCdXVyYjBmSEtzbFNva0dhZklJbjN2WGxxMTRsZ09KcnpUdmMxMFRxV21B?=
 =?utf-8?B?N0xmaWl6OU1KZks3VS9ZR0o4OE01TU9idmJWZk5Qem91bWNUTE5aWnFLZHFR?=
 =?utf-8?Q?ks0/e8InbuK12xB4AdoiyIAHG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1fe0971-ae24-413c-22e4-08dabb4c38dc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 14:28:47.6736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bSX4y4QBdScbgbUzKeL45Sw41fZWXRba/qpYFS4Ax8rkoBDzef7KgSsOJH7vzZoKuLLJwhNYxF3VA20ofV92lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liang, Peter,

On 10/31/2022 6:29 PM, Peter Zijlstra wrote:
> On Thu, Oct 27, 2022 at 09:35:11AM -0400, Liang Yan wrote:
>> After disabling cpu.perfctr_core in qemu, I noticed that the guest kernel
>> still loads the pmu driver while the cpuid does not have perfctl_core.
>>
>> The test is running on an EPYC Rome machine.
>> root@ubuntu-s-4vcpu-8gb-amd-nyc1-01:~# lscpu | grep perfctl
>> root@ubuntu-s-4vcpu-8gb-amd-nyc1-01:~#
>> root@ubuntu-s-4vcpu-8gb-amd-nyc1-01:~# dmesg | grep PMU
>> [    0.732097] Performance Events: AMD PMU driver.
>>
>> By further looking,
>>
>> ==> init_hw_perf_events
>>     ==> amd_pmu_init
>>         ==> amd_core_pmu_init
>>             ==>
>>                 if (!boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
>> 			return 0;
>>
>> With returning 0, it will bypass amd_pmu_init and return 0 to
>> init_hw_perf_events, and continue the initialization.
>>
>> I am not a perf expert and not sure if it is expected for AMD PMU,
>> otherwise, it would be nice to return -ENODEV instead.
>>
>> New output after the change:
>> root@ubuntu-s-4vcpu-8gb-amd-nyc1-01:~# dmesg | grep PMU
>> [    0.531609] Performance Events: no PMU driver, software events only.
>>
>> Signed-off-by: Liang Yan <lyan@digtalocean.com>
> 
> Looks about right, Ravi?
> 
>> ---
>>  arch/x86/events/amd/core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
>> index 8b70237c33f7..34d3d2944020 100644
>> --- a/arch/x86/events/amd/core.c
>> +++ b/arch/x86/events/amd/core.c
>> @@ -1335,7 +1335,7 @@ static int __init amd_core_pmu_init(void)
>>  	int i;
>>  
>>  	if (!boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
>> -		return 0;
>> +		return -ENODEV;
>>  

There are four legacy counters that are always available even when PERFCTR_CORE
is absent. This is why the code returns 0 here. I found this to be a bit confusing
as well during PerfMonV2 development so I wrote the following patch but forgot to
send it out.

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 262e39a85031..d3eb7b2f4dda 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1345,6 +1345,14 @@ static int __init amd_core_pmu_init(void)
 	u64 even_ctr_mask = 0ULL;
 	int i;
 
+	/*
+	 * All processors support four PMCs even when X86_FEATURE_PERFCTR_CORE
+	 * is unavailable. They are programmable via the PERF_LEGACY_CTLx and
+	 * PERF_LEGACY_CTRx registers which have the same address as that of
+	 * MSR_K7_EVNTSELx and MSR_K7_PERFCTRx. For Family 17h+, these are
+	 * legacy aliases of PERF_CTLx and PERF_CTRx respectively. Hence, not
+	 * returning -ENODEV here.
+	 */
 	if (!boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
 		return 0;


If this looks good to you, I will post it.

- Sandipan

