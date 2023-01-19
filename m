Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DFC673118
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 06:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjASFSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 00:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjASFRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 00:17:51 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCA5123;
        Wed, 18 Jan 2023 21:17:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdeZuO64QtIH2UFanbUS24ZunCt29esgX7+1cPm2Kk5l/ZvzaI5bY2nIoor6L+Sg9UyDhRVzjkV118ZSO4I37LtuOKGq6q73tnnKZt68j31wZTuYD/06zQnZ47B+iMkkDb+/AchU+VM15/N+oOFHrirGdg+Ol42+JeumiMLJxDsnPI+mVukN+vUz1IB5a0oaYpzF0cATePm0CYtxg1OaKnR6j/fDglYDofyREJZM4M26EoAvJARmWQUigNfGUv13wb2Mu1zS2pJ4Z9zcCTVNgZppz8/566tom7M6Z/2AF0eislvN0o7wxoVAevRQyaHtYg6r6hs9RQ+eaDXn1in0cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+S+X1XIkXnMUecaxamTiOkRZVlR2xxspqaG/THNPlI=;
 b=hI8bTeiyVCtLNlucr4Umkoq42g4/C7VbeVy/Q7dLKGLiczlbhdWz76/Hamj+WhjtUmcq/2O3obuMHZWYWaYePCMBHZA8p5aRZLonLUHwvxSs+GHWNZxaPlvn2GNQJwZKySgfDN61BytRl7sioeydDh2oMJQKqB3PWuUlAgbeivCDJXulOVrwpIq95A0O6AunYqLIXbkVyvJ17xwpwQETAlhDC0DW6rFsPIGPxPlUpox5+hr8TMNEIOeFWjpnbxcoh/wl2TP72HWd71pQmd5QhNDMUOK9eIGioeCy5Lza0SbJ37+5Mm+dTaHV6a7R4ltFzoVEjlMGVx9gE9ZDqvSbnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+S+X1XIkXnMUecaxamTiOkRZVlR2xxspqaG/THNPlI=;
 b=bubuGmu/Fb2Slt3QMH6E2SVX1Wmu3nSxTKOcinRtM8SsbYVlZ2SREoACnfrjRXy+Gcl9cE70q/RB+JYIwiOGkBMfRnQve8wyfCfmL8JjOScuLGEHy+BcPBFV1sDlmpZQA7RHwlKXpNpyLBPfztAU0L4OajGYKtaNSfC+R7DSWgs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by CY5PR12MB6321.namprd12.prod.outlook.com (2603:10b6:930:22::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 05:17:47 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863%7]) with mapi id 15.20.5986.018; Thu, 19 Jan 2023
 05:17:47 +0000
Message-ID: <883d1df3-a7d8-45bf-a4a1-91352f958f1a@amd.com>
Date:   Thu, 19 Jan 2023 10:47:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v11 02/11] Documentation: amd-pstate: add EPP profiles
 introduction
Content-Language: en-US
To:     Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
        Mario.Limonciello@amd.com, ray.huang@amd.com,
        viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230118075210.447418-1-perry.yuan@amd.com>
 <20230118075210.447418-3-perry.yuan@amd.com>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <20230118075210.447418-3-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0064.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::21) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|CY5PR12MB6321:EE_
X-MS-Office365-Filtering-Correlation-Id: d5602d52-52e1-47aa-f9b3-08daf9dc807d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VBhvHM2xGSiPeuTPhKOPiELM6feZmjbAn2Q9JK3t4TE/2M4rr8soDJYC2IA1mjrr9sTmHnP9Knzb/sWKx2x1w0ApQ7aUpwEY8WR+OtOKdTryfkMBvbELciqMxWDwJ8jkSI6gs3UZCwAHYnHz6GLJ8qQxEpFFfEMDG4RpFIdjBb4D3yCYjzZiqGf8QFq04Gjv56B1uNKwwBTP8Wb0KHkGDdgE8d24B11RlEZMxKBrLsKPSh5bM6ZJsbKWxYb0c7HBj4mLi8Pmf3/buDmqfpy/v3JlWE0Vlnh4xQBLnXRZvmqmW+XfDR5ktQLpNTazfoW2y3p5aFyucI9FEP7RWkRdAmEAw1CROkrqdVs6A9XzWBt0osKhKgL550oZvVreMmocwVTBsEuPkxsH67dncRg3sWRtfL6JfnRP6gLQgwPvMtOHgqfVHST1rLD5qyGTZTrs6FCii6TOem/s/pbTa5aVdxwpbgImm49GSu3Em1CD7grmjAp1JEKzyacoQBxbxzOJEM8eZzc0vVs5EkPiv+at/VvdL0qPVG7X/KURoZkDh7tkXzokZcHf4fNTgWr/UUjxuD6nPA+EJT0SDsc9grAGM6IK8rBJXVqVcHZhuPVcGQBOjW90oxECNWg13ARxzTKimTqurTQLEkkbIUYMhg1ed9VVhDd/GShXD+G3v4GgliTFTg/9m5Vvn2dO7DX/FPgFgEhyVuHSSFpP6X3p/l+tp0Bs312nYP2D46X8mZ/MkvY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199015)(83380400001)(38100700002)(86362001)(31696002)(8936002)(2906002)(5660300002)(44832011)(41300700001)(6666004)(6506007)(53546011)(478600001)(186003)(6486002)(2616005)(26005)(316002)(6512007)(66946007)(66476007)(8676002)(66556008)(4326008)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnRRVU5VQzhBMHAwRTdndGJDWmR2QzVYc2NDZWpMTy9kT3Zpb2JZU3hSQ3lz?=
 =?utf-8?B?YXFTTDk1ZVU5Yjc4cm1VMzdXeFBUNDl4OGx1QndBVDZ4NUlxOWFUbjlWM0Mw?=
 =?utf-8?B?a01vZzdselh3RUtmcU16M1V0N3NmTVBPbnBmU2NoL29NOEZXb21TazByb0sw?=
 =?utf-8?B?dHRUSmxDQ1VwbVlnYlh2TUpvb0YvcklOdGV3SHZic25lRkdSZU1DaXhUSGZs?=
 =?utf-8?B?cE9qaVNOS1hJbVo4eFVSRWVOdVFkK0N5aW43dWFjb2FINDlQTHJCeEE3dCtR?=
 =?utf-8?B?YmxlTnkrZmRWTGpzWjc3TktqdjcvbzBnRE5vdHUvSWNnaXlCUnplejJDYXZn?=
 =?utf-8?B?RS8ydUNQdStQdnZKdVV6RGp1VldRbzZlWDBUbHRka29kQjMzNnhyNjRWK05x?=
 =?utf-8?B?VmhiNUxRUjNWZU9jUWN6d1hKZVFNZ0U0TjN1cU5SSTRhb2ZPS2JsZXV4cHdF?=
 =?utf-8?B?WnpHUnluWlhydldHend6eFdFd1JFanNYcTNUK2ZYK2laVGc2emJEY0dxeW42?=
 =?utf-8?B?VFRKdk5LU3JHTHZwS1V6S3d0TEREZExBUVl5SEVadGRNeVFBTWFBVUZ1VHBK?=
 =?utf-8?B?SjFCSlBXblFGOUZRMEdxeCtFTGhFa0FwZzNLMWFMRk9UMjdDdDh2bi9ybEpL?=
 =?utf-8?B?N3BQUjhZclhoaDJrV0xUZmluTlRiUmFWK0ZEL3pWMWIwTkdweGpDZ2N2TG1M?=
 =?utf-8?B?azBmTTczMTl0eGdJMnFNdHV0b09RWU55Nmd5UUJmbVBQbmk5TnJMdHRwWHRY?=
 =?utf-8?B?TXpSR0FUOUdaMm1sK0xIN1c1dllhN3RldlVZRUUwTTUvY1JWUC9kTXQycHdY?=
 =?utf-8?B?MnJ4WjlWNnpSN2o0MDdIME9GVHU0S0o1UTliMGlDbDVlVDd3ZXl4cTdLWXZj?=
 =?utf-8?B?VTkxNzFWOTBVWXltOEg2aFN2WHFRcFNXcU5UcTJRVSt1dWJENU1JNFN4Qjk4?=
 =?utf-8?B?RHVUWDhMREtVSVVHMVBnZytEa2JDaVplT2ZPN0JNbzgzcVFQUmNVa1IzT1Zl?=
 =?utf-8?B?L29yZEVQTkNWM1l1VFBrMFVLWEFVR29OT3lpeWZMS2VPSjFsRkkxOGk5RTRp?=
 =?utf-8?B?ajlnczdTV21EalBRaytwWnlUSVR5UXordno3NGdZc2lKV1JKVER3MWlhRGpM?=
 =?utf-8?B?NE52bkVEaEtDUlhjekwycWtacng4QVQxUFdReWtJTk5oSHl3UFZhUkVNaXdt?=
 =?utf-8?B?bmdwdHoyNzRWV2F3a3dIYzJOOWFZZEtMQzlqMkY3bVRPVFR3d2xTTldUTUtD?=
 =?utf-8?B?SUdsOU5rWnptSnovOERXOFBKVmNET2lPLzBEOGlEcDQwZmRLdFo2eSszZXZT?=
 =?utf-8?B?cHVUMEREbXZ6N1lzOUVtS0NvZTNySGc2QXZXUzJrMTNZaGw3eTNQaDBDRFN2?=
 =?utf-8?B?VHVWa1o0Q2NLZE5mOTlXSWJxTmlxS0NNV1FQNmsrQlJxV0FNSCtOaVJMT1lQ?=
 =?utf-8?B?czFaV2hpaWwzbGV1VlM5K0Y2dGgzQjRxQ3ZMdWVSTWFpaklNNzdoV1hPTHdJ?=
 =?utf-8?B?dmNqYWtUR2dPRG9aeVpYaFJINFRxWkZOeG5DZzNyK1ZIejR6YWdzY0J6ck8z?=
 =?utf-8?B?Sk1DY1RuUHY3QmZ6a0lqL0lvRnlxYlp6eFBhLzR3bWh2WVNBbjc2S2tSOFV4?=
 =?utf-8?B?RHJVUnUwbUhxSmo5VGd5WEVTWmZQcFlkZlRiUHhJTmtvYVdBYUhFc0NuZXVs?=
 =?utf-8?B?b1ZMOG9oWGFTN1RFSGozTFRtelNCRi96RTlTSTBISEtYMkN6VTdITXpHNXkx?=
 =?utf-8?B?QW9RTVBpdmxhQkRrSEtpYUQ4NXN2WlRYTjd6M2VnVEdza3JYT0N2M0h6dGY2?=
 =?utf-8?B?cjdVQkYzcXNSeUlpTkVYWWFZVGVzZnpRSFcveUJJTnYzSHhxM2dBazFkWEtP?=
 =?utf-8?B?Z3pjaGRXZDY0ZFl5enVxSFFpL3lnSHRHTytINDBvVDdlN2dHQTh5bjNWMDRk?=
 =?utf-8?B?eGl0MHd4TXRBQnFkbTBIWEIxcUI1YVhhMm9kcEJNY252TWdaU0Q2Y0NocTF4?=
 =?utf-8?B?TmpxbTc2QTFZa2Rnd0dHN3NRR1JBZ0NtS05JZHFScDg0OTAxL2h1MUhOS3Y4?=
 =?utf-8?B?ZGR0T1JxUnp4WjZSa1M5SlJlaHY2Ulp1TVg1cFN2MEgwbnpFcmU3OVVEN3lY?=
 =?utf-8?Q?FzMwIlcL9QWzz7AFzZFfHub1G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5602d52-52e1-47aa-f9b3-08daf9dc807d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 05:17:47.2394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54m9jR8jMwj4/uCYM7scmdev28kUuMU0ZgD+++gyU2S/2EWmzFnijJuHWCFpQu3bMzHwuMGqK8IaEg25pTTMAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6321
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/2023 1:22 PM, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> The amd-pstate driver supports a feature called energy performance
> preference (EPP). Add information to the documentation to explain
> how users can interact with the sysfs files for this feature.
> 
> 1) See all EPP profiles
> $ sudo cat /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_available_preferences
> default performance balance_performance balance_power power
> 
> 2) Check current EPP profile
> $ sudo cat /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference
> performance
> 
> 3) Set new EPP profile
> $ sudo bash -c "echo power > /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference"
> 
> Acked-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Wyes Karny <wyes.karny@amd.com>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>

> ---
>  Documentation/admin-guide/pm/amd-pstate.rst | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 5376d53faaa8..98a2bb44f80c 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -262,6 +262,25 @@ lowest non-linear performance in `AMD CPPC Performance Capability
>  <perf_cap_>`_.)
>  This attribute is read-only.
>  
> +``energy_performance_available_preferences``
> +
> +A list of all the supported EPP preferences that could be used for
> +``energy_performance_preference`` on this system.
> +These profiles represent different hints that are provided
> +to the low-level firmware about the user's desired energy vs efficiency
> +tradeoff.  ``default`` represents the epp value is set by platform
> +firmware. This attribute is read-only.
> +
> +``energy_performance_preference``
> +
> +The current energy performance preference can be read from this attribute.
> +and user can change current preference according to energy or performance needs
> +Please get all support profiles list from
> +``energy_performance_available_preferences`` attribute, all the profiles are
> +integer values defined between 0 to 255 when EPP feature is enabled by platform
> +firmware, if EPP feature is disabled, driver will ignore the written value
> +This attribute is read-write.
> +
>  Other performance and frequency values can be read back from
>  ``/sys/devices/system/cpu/cpuX/acpi_cppc/``, see :ref:`cppc_sysfs`.
>  

-- 
Thanks & Regards,
Wyes
