Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A6565159E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 23:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiLSWhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 17:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLSWhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 17:37:48 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D79125D2;
        Mon, 19 Dec 2022 14:37:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3FnqttQOfakEUfdvQGgtgOzJLGAgYpE7XEbdI91AmMwz7TNnpzuxAJxJN9Uvb/mKdKYmQiui/bE1nJvCtCzu7I4ta4ng+pCvSwYjo+nCArzzDb1hf/a7ktRu3vnP/sVhd/IxJSJXmHp5J3N781cEMwC1Fp8aAw5p7uGDZcGnEJW2nBMmLGKOO2YEWtQSh1bUP+Mk9TvyD0u8umF05QwjyWl47M4ndmonG1dhwV0ydJnxg8jOg2+nCKo2mzOLkzhLEu/qOeq9icmrqN/mNh1Zwc9lQH7gkCJUSt7HhkMLWvRx/0uhaqZviopoTwArZWcmbqXaE36chnyc7WmDWXopg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/sYTjIqaEQbiacMOYdTtWVq7hUmoc9jVBsKVLF30FE0=;
 b=MyyXPSist/aBpiA1c0xuGFs96/lzpwP4IKFo1S/L/GGMU527PWTp8o7l3DD4+ygC5juU3WYGvDKlAErgdxyNkQkqJI6lieAZaFhJtZSVy+LQm7IEga/YW9/J3dNjFlCWQ4Ybe7NSFTknTNwb6AKyg81ksI15AaHs4/5gD/i7hxJ5AsAyEaHM81Db239fXpkC55566csHCDjX9HyNqw2QZCJdDLSW0YVLTmH/atnjjJO3VBzqURzQ1rquy3xVK9xQA3TZlcrzXTHU8wE2rK92N9eP6OPCdQt3fuguhrB/guGcMub8oDZLrQK5vcHNYuFFYDYG/k+aBYMWlZQmo+NO6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sYTjIqaEQbiacMOYdTtWVq7hUmoc9jVBsKVLF30FE0=;
 b=uoLTREhTKihrfiAqHikidMKe6dpLmAKEZP5pqUm8fd69O4JcEDprlgkwYMCrH2gR+HedFMCTcFLjqDJzt3PJK0coTVIIv8cTOZCnX05mSgbPbZ/lQ+DRSB4htzzKTlssXT33ixNbZQC8IPizv5lLmHi9FsyOpY5M7+K88Sf6iVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL0PR12MB4851.namprd12.prod.outlook.com (2603:10b6:208:1c1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 22:37:43 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%4]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 22:37:43 +0000
Message-ID: <26c77388-83cc-291c-4205-e1f6fc071875@amd.com>
Date:   Mon, 19 Dec 2022 16:37:40 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v8 02/13] Documentation: amd-pstate: add EPP profiles
 introduction
Content-Language: en-US
To:     Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, wyes.karny@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221219064042.661122-1-perry.yuan@amd.com>
 <20221219064042.661122-3-perry.yuan@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221219064042.661122-3-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR22CA0008.namprd22.prod.outlook.com
 (2603:10b6:208:238::13) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL0PR12MB4851:EE_
X-MS-Office365-Filtering-Correlation-Id: 33d4251a-f7f3-42c8-854b-08dae211a4be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q62bmWj6Ecryn/XJljx6thmwf7hiC95ayPgLuaS76qyob18BNX1YVVmc2N9jlAEecJ9JAp4DCQnCn1Tx3WNoF8hEgNqhw7sdB32tLHzRFsDA3ju54xnczli9jdzDxy93zQqA5OlM4yW6WtK/SDm5Wz8jBqMogHa6dJ8YNVetABLnqs5HRGY0nVqjw1sOJGxLxRPw/zvl66Apge6Bh832SBVHMdRzcJya6NZwjuBM8jMjYWnaz48iZVVITPxJe24BEPi4DoS0edRc15A6+vZKjjnEVeh9DcLzsVPWuT/AWoQ5otJQpDwsvVG0k+ckTQZjOqx0qTqCmv1ADJgN3b5NXBAf2hXK8b2NJg1KW60WYBE2NKqT0P6/gtJHf3AmD7PCVN5KH0ucGL48s9ThAsVI3L+3n4us2JDSr07zWGA3A/fBhMTjkpeRi3l4nr6C7/9fcqwbx1dk41yYhjCeAYKrwtbYjewSroU9MdQwy7yi0PFdyeqWu87sVHyiFIBGxkv38fnwCIY64wmBp6RpRTSlUO+H28GxT0Hbir74EK3xVnrpymkbc2rMSvE5P7mremFa5PBlu5FBc4N2WyZt9k71bCydE9iROn4BD+Bml68M/+STDVankbh50Or+ZVT5mHK4uOoMmKkWIudzzcsi9mQml0yzzFwUJ2e9+BF01vfCTUXy6ytiWn6ipwi8LvnkgGL2wPFvqz4aIARZ++0BQ9FIjyimmDtVkP3fJAygXowTDog=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199015)(83380400001)(38100700002)(31696002)(86362001)(66556008)(2906002)(5660300002)(66476007)(4326008)(8676002)(66946007)(41300700001)(8936002)(26005)(186003)(6512007)(53546011)(6506007)(2616005)(316002)(478600001)(6486002)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUNWTjlQMENqMnhHTjV1VGhiR2gzaGxaR1hkbzgxQ093Q0paS0NpM3k5bDQx?=
 =?utf-8?B?QWxSU0RxOVY4RHo5eitqdDZRUXFPazhWZlRvNGx0QUljakExMm0rSFZxYmFj?=
 =?utf-8?B?MWtwTTMyRVhjOVIvaGJ5bjdvSysrdmtsN0lJaVZaNFBtYkpRM3VJQ29UOGhY?=
 =?utf-8?B?VmRXQ0oxSHp2b3VnOTNMWnljS0g4R1lMQmM0anJyRHRmZXVRMm5oUnNZL1k2?=
 =?utf-8?B?MFJFVXNXdldENGtZL1hneUI4QU9vUi9wRm81Rko1eGltVnNjNk50ZU5mcndP?=
 =?utf-8?B?UFUzSmdFT2YxeXBVYnpxY0dxQU9PZGFCRzVvcERNUTdxdDk5RWRSL1htd2tH?=
 =?utf-8?B?L3Q1UjJFQ3VyVVo5cWdjWkJMRk16eGJUUkJzRDU4M0dXVEliUzBLRXI5ZDcz?=
 =?utf-8?B?d3J5eFB5bHp4N3lOKzNsaGZCVWwrdlo2QlJnSktlek1ZeUJVL0FEcHE5SHBp?=
 =?utf-8?B?SnpuMWpvTmd3a0tkYm9HbHdWaDdZSW5MM1V2NjJpaW1sRTZVSkhqZnBLMUxF?=
 =?utf-8?B?Q2tsZ3FTU21Delp0Qit2dGxpY2JSN20zSWFkbmpyV292djA0bCtGM1NnWUps?=
 =?utf-8?B?ZzE1UFVsTjlSSDNHS3dkNXJVK01LVW1FTkxXenNZTEVENUY2L0JDdU82TFEw?=
 =?utf-8?B?WGkyRiszalhpUitWK1laTWdzNUMwa2dNSWVnUjc1ZHlNNnlxZ3JxNGhZRTJO?=
 =?utf-8?B?dk9GalpqQTVDVEk3bk1zQ2xsd3FYbWFDWnVvWFNJUENBejc2VXdnWUhMNGVR?=
 =?utf-8?B?YW1PY0dNME5VelhtdUdyVmlRM2RNNHR0d015RVNaV0xDRUY1QmdEV3pNY3hJ?=
 =?utf-8?B?dlNuUDdNdjRzbDJKRWtrSUorWGVOd3BLYjlOanlGVWdwb0htUUt5VkRqRjdT?=
 =?utf-8?B?UUJQSDQ0eXhFL3VaOWZpSmovcnltRkxxR2gzNzdHNHVYaGJTUVc3M2VGaXFO?=
 =?utf-8?B?RDFqM1Y1ZDJhRmNwS3pHT2p3MnlkeG13SFlJVDBEMUVaSWg5aWxSSms5ZnNU?=
 =?utf-8?B?a1dTYVZQMTkyQ29nTkRKL2JVQ3FCVFN6dWpOdUlWVktNR3pNN05EcFcvTmQ0?=
 =?utf-8?B?RDhxN1B0QWduSDNSZmF4WGd6bWZCeDY4RERDSHBOd2w4b25pSjB1RVZZYWdo?=
 =?utf-8?B?UmxNZ0hKMVd4TUU2NDkzMzkyTi9wR21zR1JkMjEwVlpFVFVnUlZrUSt2WExC?=
 =?utf-8?B?K1BydVFJZ1RCZHBEN1hYVEZBRXlDSGgvQmpFQ053bDdOcUx4Mk9EWG94dlIz?=
 =?utf-8?B?UE5QSXFSN0VOeTBRME9KTU1PaEJueEQ3cDJnRU82d2lEdlpGQjBNdG80ZkR4?=
 =?utf-8?B?ZC9qalpnOVZVK3JjdG1BdWRLcHZBejFWeW1YNm85OVMwOExuRGRlL2grdUZO?=
 =?utf-8?B?YjJvS1lTTVRLU0sxNUZqcXJNZXhxYjIrbm9rdDl1cGc2TVlwMjcxcE0xQ2VJ?=
 =?utf-8?B?N0o0YzNFM3ZvU1V6Ti94c1hRMlJLbVRMamx5U0J0aUpVcnRGemt2enBuWTZt?=
 =?utf-8?B?ZHlDZW9wNHBDWlk4YnQ3OTk0ZVV0T254Z2c4WVNjd1prK3ZZaU10OTBGc09j?=
 =?utf-8?B?aGxxN3E4cHYrcmpKWFRjdmNUbXp2MUZFNUFRNHhRNmJ0cjBXdHh2MHFmZm1D?=
 =?utf-8?B?MWwweW9kOGZCbGZ2YVJ2bXAzMmp2bXdsVFJrdHIwczlPbUFZdUxzTVArNCtF?=
 =?utf-8?B?VzNLZnZYQWt2KzFNcTdWb2VudHl3YndUaWxXaERIQldnRjNzZUFuVm9WVXZP?=
 =?utf-8?B?MmFXZHlCSnJoRVdyTlF1RWJzZy9WbkNWbXNWVkY3cTM3dXB5Z3ZrNWxZMlFk?=
 =?utf-8?B?TkQzK3lNelplNVhqMGJNR3ZhZU95ZThSVERpci95bGpuWUEwdUplODlEdUVD?=
 =?utf-8?B?YW94T3VHdUVYaUNBU1JTT0ttZEgzcitMa3pVNXJDdE9qT1pUUVB1R0hXbWVn?=
 =?utf-8?B?ZHdhZ1BLWkRyQUltVzhxWlhtUTI1dkhVOW45NjQ5a2xGODIyL1ArK1ZvbS9X?=
 =?utf-8?B?QWdBQzErVkV6Um9GWCtwNisvQkFLRUlvZzQySUNJUTlJV1N3bktiSDNTRlRL?=
 =?utf-8?B?eFBtT3EvV29mMDlHRVF6TnFrLzRrN0FlVEVwR0k3VFVPdHZOMmkyQlJvTWFO?=
 =?utf-8?Q?tcFcScu/e7KpCrduw/b5sApmf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d4251a-f7f3-42c8-854b-08dae211a4be
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 22:37:43.4179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7ZWQ+2HpASOyLkgUUx74nFpJvrf0VWMe7W1UzNAm7KbjVpa5FilSqHykXTYC9tYh5Y7i1HXFN+aZxEgE5KKbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4851
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
> The patch add AMD pstate EPP feature introduction and what EPP
> preference supported for AMD processors.

Don't use "the patch" or "this patch" in the commit message.

I would propose something like this:

> 
> User can get supported list from
> energy_performance_available_preferences attribute file, or update
> current profile to energy_performance_preference file


The amd-pstate driver supports a feature called energy performance
preference (EPP). Add information to the documentation to explain
how users can interact with the sysfs files for this feature.

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
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>   Documentation/admin-guide/pm/amd-pstate.rst | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 06e23538f79c..33ab8ec8fc2f 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -262,6 +262,25 @@ lowest non-linear performance in `AMD CPPC Performance Capability
>   <perf_cap_>`_.)
>   This attribute is read-only.
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
>   Other performance and frequency values can be read back from
>   ``/sys/devices/system/cpu/cpuX/acpi_cppc/``, see :ref:`cppc_sysfs`.
>   

