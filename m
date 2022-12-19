Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EAB6516B7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 00:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbiLSX2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 18:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiLSX2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 18:28:17 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D3A654E;
        Mon, 19 Dec 2022 15:28:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+MFg2Iq0ng6y2sfv5zxoGcMUNKhfvFYqUTgnGN3C2pDVBOx/TgM4+awxeFcaJrFT66SQbmmriJ6IrGCUOiGn9WnyMTND3kUq4/GaUFGLTqVOKI/17+OR1ulopuoLNmTFd887NEy65E69KRaD+TT8gVR4op3v6ICYiS/Q0ZYH03KqiYDxnB8OUi96C6E18t+HgrENBsbB4xJ6KtdqhJeNEEWDh3wPnnkWhfuwXs6h4kW/2jFJkc+kOTaxojgso5N+JNvGLdvjwyuy9UdrCLu1J9EzJSjMxs2BqIxMnXqu2aU0ACNBJ3tsXeMR3ZUum209mP7wzfV/9yqBX1jthhtdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRkBLi/2VtuEpjqiZgUyxEI3atM+2MWnT2nS1cqZpuI=;
 b=NTb4zLD1Y9UT6Lacr2qEijhdqbcnJvbzIv5rEoH1bPR+ft4CJL7gIoeDQdA9ytRjVFGvjeeG5VYq03NzF4djRk6e/462dzoMzIkmNxoIUo8GElxMMiZ1UWHsmuG07w5uAx5nWCTy0fOdtUd9p8Ze7QpeX5HT1coW8nsqNkVPsVn9WGsBl78j0BwKMfysfDIb/Fb13MC4K9AbBc7SgNEsoQL3RtAWXrmV0vHIFAp5V1lqDDMZCjOeyq19Xodo602mitHJWxoo8q7aV9Myft7BKIRtxyd11VmCiOVKyMwkmL2zvLcp822wjGsUFM2p+O1nOa8Vr6SuYfOuaz/Q+UvioQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRkBLi/2VtuEpjqiZgUyxEI3atM+2MWnT2nS1cqZpuI=;
 b=K9Mx3HM+vt93XsjzMAwJJI1le1HXidzT5fFnCYxBt2hqpT4gJZy8VTGB3Jdf9K8HAJon8T4JeizuUU9pXGmv+uyciAFnhCbJFQ6nnlJnW+X63HKD5XwwSWtq1NrdxvnvFLzZODJJJeUzwtS2SsJxzUuWrfZNhsjQUaVtt6ysSc0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB7553.namprd12.prod.outlook.com (2603:10b6:208:43f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 23:28:14 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%4]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 23:28:14 +0000
Message-ID: <420e1f4d-90c1-1887-7d5d-7d2c4b38d2e0@amd.com>
Date:   Mon, 19 Dec 2022 17:28:11 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v8 10/13] Documentation: amd-pstate: add amd pstate driver
 mode introduction
Content-Language: en-US
To:     Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, wyes.karny@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221219064042.661122-1-perry.yuan@amd.com>
 <20221219064042.661122-11-perry.yuan@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221219064042.661122-11-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0048.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: fb172929-773f-420a-f88e-08dae218b315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2SN1xr6lsvQaSC4iimF4hSLx6XqwXxb1kh4xgeGEUNBFuXmobCCdIvWyRvQlASde/MgdiOz1SLLMzRUqQxBE50e3Vl3+jx7kintEufbvq6wIH4+96ONhsONgxsAFABEwdQ5nspp1GbiHJwxtZ1k72nYICI8f2htDoFJ5MG1wfkZ1jE1Uk2NFW1ufPYG3Q2qg31ihUVYgqL1xUQyvyJhb7oK53oSKn3LxauEpM7lsBFcmrdOFD7A3T4DHr9o/vBjpy1yXE36zth3otYkh6Cuk22rezMJUV2JirN1fr8qhpYPQj9RCnM904aLwyrvsT+qYEGdXa8j/SMgyfMsg3yaK7BCbgCRufjc/JQB9i6CYcQnQBrygY+gmbXRIbngCNQSalUwg1UyqUstClA58vRNqhVUUHQOsda/8m1mTdw0aUcdbP6HCQAvAlS5/IBQoMksMrxZGzHEF9GgRyg71zjUVMK4CjfUAtHdgwdVW0+U7IkGRspv2ctz0oOnMnFsEj0fTIxDu/2Ayv2kT8becMz2950/5FQGbqRSPo8/EPcu9pgebqKGrWYvEsGgJJObbw2u2uiI9e86Q5Bf2V4qbkW8uP4IXodcIhYM31Mlno5U/sLGuVcljp8fFL/tRavgoYX90+AjUmAZAaZE2v7HeL0Ex8QsrJSiv9l6y+rI2PqyF3QDV8s2jikm4WKz/2pDP4jTerHCkLjKsQ+DKV/JVq6FACFETvkLjhUbCU6FJ7zrEFJk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(451199015)(8936002)(6666004)(31686004)(5660300002)(83380400001)(186003)(6512007)(41300700001)(26005)(2906002)(316002)(478600001)(6486002)(6506007)(53546011)(36756003)(66946007)(86362001)(66556008)(66476007)(31696002)(2616005)(38100700002)(4326008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVI4UFJPZkM2VWZYNlhqbU5UME9FTTgrRWZXeVJzMFpCMFNsWkNTa1FrMmNM?=
 =?utf-8?B?NktQZ3lMQXMxVXlrMXJyYXBZVk82VWRNdUdibDYrTmNmTUpjV3ZSOXkvRGNM?=
 =?utf-8?B?OW03QlFlNFJFbUhNMC9kM3gzZHZocTBDdkgwY0RZeVloaHY1Q1JFWVBYeUpm?=
 =?utf-8?B?cW8wODBmVHRZUzVMd0Z0cTJwY09EbEtKTHBjbUIxMDZocE5zNTdLOFExODhP?=
 =?utf-8?B?RmE4VWkxL1JvU2xaZTkweWRBczVYbUVMNDUremZhb2toZGp0YUcwSzhSSzdF?=
 =?utf-8?B?RERNZk1mSWRQWTFVT1BENisvbGd4UjRhWHcvcVJQOTg4L0tYdFdzZVo5dFlh?=
 =?utf-8?B?aUs4dlAyRnIxR2MvV3pjWHBJamNNVVQ3Y3U2cEpkRmxMSS9KZDhxQ1NqamJQ?=
 =?utf-8?B?Tnh3QnAvb3IzMzkrVnhFRUVzNlA0VDVwallTckxQOXJpM25pby9nNUk3dXoz?=
 =?utf-8?B?cnFseE8rSGtwOVhTT0JPcURNV3c1SldKQTRTZmlWSElWM0tYM3dRVlFDVWdl?=
 =?utf-8?B?bHpqa2hsMmFCTStBRmw0VGphM0NrSGdtNHNzYUM0d0JVNE5WMlNuQ0V6Vm5i?=
 =?utf-8?B?bm5JZEU0ZWUvVUZ4RmFyZFhxNnpWU1RYbTBJUGdlcTNtK3hmeDVWSjF3Zndl?=
 =?utf-8?B?QlNRZlFmbWpLL2QxWEM0aGZHbnFCY3hRb2wzcHJjUFpRenNxMXB1eDNXK09W?=
 =?utf-8?B?YXRubkpvMTJscDM5UUdReFNxZG9RTjlndzF3cXI3V0hzQVhRWkl0RlZBN3Fj?=
 =?utf-8?B?Vm42VjhraFZVMGlHQ1VCODZ1cEUwN0ZyQ0dKVEtqK1FqTXd4ZS9BYlZTY2Fi?=
 =?utf-8?B?Z0hmdE91T2k4K2VYc2RtSjdQcDV1QzFZY3o0RVNOd3F1YXZ2MEJPSVRQUFkr?=
 =?utf-8?B?MksxMXlqYS9YdXg1Q29ZdUpYTmV4MHhna0lyRm1qVHR2NmROdk9JYW5la1gy?=
 =?utf-8?B?ZUIwUjY1V1liY3pIbjErZWcwM3hBbTRlVXR2aHRqOHB0Y0JrUEx6eXFKenN6?=
 =?utf-8?B?eUE2OEwrOEQrZFpKeWdDRTI5aWVTMHdyd2NpS0lzT0ErcUR6a2NnRldWc0Nk?=
 =?utf-8?B?RXNQYUI2a2I0MzhqRWV4aHJpdmVvdWRpWldKNzE3TEI2NllJdGdBYXBVemlq?=
 =?utf-8?B?Z3dDU09zYjR1c20yclNYYlpOTDJXSTEwcGNNdTRnZ0Y4VjFDbmVCRklUQXow?=
 =?utf-8?B?YzdYaWdmczRLaFVqdUR4R1VHeDE1bjBIVGRVTS9KRDRDTUUxdjdFdFU0Yk04?=
 =?utf-8?B?T1J4MWM3dTRMS3Q0NXpBKzdLWnRNMVNwdWQxV0dlMml3ZWZ3UG0zL2d6aGx5?=
 =?utf-8?B?dWEwWi96Yis0eUdhQm1halJjcFhkWW5rQkp4bEQ2Q2h1dFgyd2dBakNyUStz?=
 =?utf-8?B?NGoybXU3Znd1dGdIbXJrejlRR0ZWREVlZUZtcGF6SmMzZkI5TWdNRkVpWjZn?=
 =?utf-8?B?UFA2Wk9kVEloMXpRK3RxVGV5S3J2QUhVOXF2YjRTVnBibUlhTXV2dWk0VEU0?=
 =?utf-8?B?QUs1ZXNzbW8vTHV1Vi85KzV0eWg3MDE4VXlFbVFqQkpjU2VFNjJ3RnZ5TDE4?=
 =?utf-8?B?V2ErdEV1eG5rS2QvUVlsRnlZUUQxVkowVmFzT1NhZFBWaW9yY2dScFptTU5Z?=
 =?utf-8?B?Q3JQdldHOFBYQk5BNzFTUmk2VnRmbXRHN2VaVGZHVWlJUWdjMitGSW96U1Qz?=
 =?utf-8?B?Rm5zQlJycHNMVmd2Rkxma3B2c3lPUzdaM1Q3cHVlejlnQXRwWVZqbHBqTStX?=
 =?utf-8?B?MXpleDhSdW0rYVM3QUl3QytCMHIvdjkrYm9KVXluUlZxcDZIK0ZPNGx3VURx?=
 =?utf-8?B?YU1yMDJKRENQeG9mVUNWbllESWc1aU9GcElzRzJDTTFlNWhockdLV011d2FF?=
 =?utf-8?B?K3l1ak1OVFBDSDZqTnd1c3Y2aWZURUp4SnlPK3ZMSys0K0tSMWNnMmk1ZitD?=
 =?utf-8?B?aFkxakZBSk5RaGR4RHFyMUgwVEZpR2Z5c0ErTk84NkJPT2M4dkhxUEtTS3Ru?=
 =?utf-8?B?L2pzTHgzYjBEaWxFUWRqUDlUY1FpWTV0dUZvZHcrTWV6YkU3by9wME55Q1k1?=
 =?utf-8?B?ZEhqRjE1N1MrZEROQTZMRXh4UTF1WFBGaHA1Z01QMXlLN0FFbWh0NFlTSXlI?=
 =?utf-8?Q?puHQPE2B7wwHRMg9vwvkwiKMr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb172929-773f-420a-f88e-08dae218b315
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 23:28:14.0343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: liRhk2BzXQNJfh8LLXo6zirTvTIBP70zeWfWrYhTuRnkr009cCsKhWz2fzbxor1vQHDnnS2QdOVaE7YIWf7ofg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7553
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/2022 00:40, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> Introduce ``amd-pstate`` CPPC has two operation modes:

Drop the word Introduce.

> * CPPC Autonomous (active) mode
> * CPPC non-autonomous (passive) mode.
> active mode and passive mode can be chosen by different kernel parameters.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>

With nit fixed:

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   Documentation/admin-guide/pm/amd-pstate.rst | 26 +++++++++++++++++++--
>   1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 33ab8ec8fc2f..62744dae3c5f 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -299,8 +299,30 @@ module which supports the new AMD P-States mechanism on most of the future AMD
>   platforms. The AMD P-States mechanism is the more performance and energy
>   efficiency frequency management method on AMD processors.
>   
> -Kernel Module Options for ``amd-pstate``
> -=========================================
> +
> +AMD Pstate Driver Operation Modes
> +=================================
> +
> +``amd_pstate`` CPPC has two operation modes: CPPC Autonomous(active) mode and
> +CPPC non-autonomous(passive) mode.
> +active mode and passive mode can be chosen by different kernel parameters.
> +When in Autonomous mode, CPPC ignores requests done in the Desired Performance
> +Target register and takes into account only the values set to the Minimum requested
> +performance, Maximum requested performance, and Energy Performance Preference
> +registers. When Autonomous is disabled, it only considers the Desired Performance Target.
> +
> +Active Mode
> +------------
> +
> +``amd_pstate=active``
> +
> +This is the low-level firmware control mode which is implemented by ``amd_pstate_epp``
> +driver with ``amd_pstate=active`` passed to the kernel in the command line.
> +In this mode, ``amd_pstate_epp`` driver provides a hint to the hardware if software
> +wants to bias toward performance (0x0) or energy efficiency (0xff) to the CPPC firmware.
> +then CPPC power algorithm will calculate the runtime workload and adjust the realtime
> +cores frequency according to the power supply and thermal, core voltage and some other
> +hardware conditions.
>   
>   Passive Mode
>   ------------

