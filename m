Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988BF654ED5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 10:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbiLWJwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 04:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236238AbiLWJvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:51:17 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20623.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::623])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004C8532F9;
        Fri, 23 Dec 2022 01:46:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntEVMQhmTyuEE4aI7/95Pu7JCmTXOWhJO6PXrqHxd5QLknljh0dr7Q6qvJARe0RWWEvD6gdnFWkelr+AfdJEx4SfuLru8xS7gKR7vP8S+AESLgSJiKhTGyrfIj8goP6qycFkjrsQufTuXdj8k3XI3/D6ySN3NH4nR6ZGEOigIA1+jCMzSlJhKKNjdlXscYDI/+OcrjzseuOquTPF7oymAD9nF8DACw5XVARgXwsMJi9JdxEUCCeY+cspC4dOnJZxFphUPDDIudRqZIs6eEMhIXN55vuQVDLmJhkZPFiajFoCNbhCVcyniaS6X3og6NMEx6Fh3Iz9slMNCvgcgEx68Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RvGZfYD+G/FTQ8q/x7aHO2SJ7lH52wWIS3WHPY1Dz4=;
 b=MzxxpdTVD+9XDt/ArgHjSyAw/nYdjv3Up9Im1rZLDXpmNyTR15WM600TstQUpspuhnKZ10n0l3n0ggY58hq1vqvCANk0+0Q4xfqFr9tngJJeNC0dpKXKVyHYW6yayd/Yxa6nZLx5LYB3k5It9muE+dtxVYuHz1s0mc8OaYPC9jMHo9bYXjKrxsJEiwJoly9CLiS0KvT69S+76rlh4aJ0WLirE3VZagtPknolLLW63ijtCn9PLsOYWXPU87FcNqKeJ00Job2tU7K2erDL5x3JSnEoG9zrqWi+G/jSqyzqEabimxbqlZzZYJVhdmIfPn8r6VRSbNQSkRYUXQ32q7CIYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RvGZfYD+G/FTQ8q/x7aHO2SJ7lH52wWIS3WHPY1Dz4=;
 b=jK+pxbq5yY/fuRF/cQMqob9gM83fM4sJ8Ry9Y2U0A8gR6UiZty5Vm0bB6skDT4DN8Ox2UjD3xB4rArWYsTnkhJkxerbfrpB0QVi7+JgwsrINvLYZznhtJF+CrVhHK09llkdmh2g75DU13YzQbXdjhfzCsHn4fJgliEJofRxkFuA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by MN2PR12MB4238.namprd12.prod.outlook.com (2603:10b6:208:199::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Fri, 23 Dec
 2022 09:45:47 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::45ef:724b:4b64:b98]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::45ef:724b:4b64:b98%3]) with mapi id 15.20.5944.013; Fri, 23 Dec 2022
 09:45:36 +0000
Message-ID: <bce86f79-9757-530b-b34e-1d2a71281e75@amd.com>
Date:   Fri, 23 Dec 2022 15:15:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v8 05/13] cpufreq: amd-pstate: optimize driver working
 mode selection in amd_pstate_param()
Content-Language: en-US
To:     Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
        Mario.Limonciello@amd.com, ray.huang@amd.com,
        viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221219064042.661122-1-perry.yuan@amd.com>
 <20221219064042.661122-6-perry.yuan@amd.com>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <20221219064042.661122-6-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::7) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|MN2PR12MB4238:EE_
X-MS-Office365-Filtering-Correlation-Id: c3d25ea5-6f62-49ac-4b3c-08dae4ca7171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A55iuc+8Z4H4HPaMHFMBcfBiYRo9YLCQ8q0t2F1FDOF8zsQomqIfCQgsT+dvuEtsqF5DJBem1/tOT6zh586In3lbBlluHbtoGYG4AbzpBt3n9pcz+/8cE26Fdx+4Xv/ncZI/SFaHvsKb/Z5/QMwRZ862au/O8tJQ+gGXN2m5c1jBV5oeSbUDoD5YDGpEvEjd8sMUnJDv/pX5JkBYgDazaB7/mksA5cwTQ0THwPS9Y3TtLuDY7B6WhlOgfm2VfOxao5+dbsR2UhMS68H6qVVJWKLeB1SmTjs1DnJyDvnE57RXD5ldJ2D8qNM7O+sk0WP0mi4Q2twNFcYdhN5eKOxOhiPgLjUrvIdne1If52ALnx5+92qiCHLxgqt9LC07GpZUZ9X1qDZeJxi7Nwd0yOyjIEyfxJz8KiMRyV6o8CD2qDeYjg5VOoz12ZV1fPBJJsta1CB1xUT46w+bVnijm+QpHm/uyJrQQgyUl7MprpYjGvKOk4KvZ8dwQN5peeVIV6f2/5Ef9BVzXk1fKCO3aDNEKpkIoOxLH65dhcflE3CZ79LcnDnRPlEqs5gjkxAM+HK9yOHvRZmSqLO9qAxYGDsY/fx7Rzn+kSdkY7ApHRswXGynMNxkjOlmp5hFtYmOyYttkFaJEHOrJk9A3d3G/moFREO5eOPP+RuhiaDQELCO2VyYFQUxf/4nXk0uxCsoVYIEN+blAx6d3SR8iAkMlzia7Ogroh0BYWLeBKazYaprq/4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(451199015)(2906002)(44832011)(316002)(36756003)(86362001)(2616005)(83380400001)(6486002)(26005)(6666004)(31696002)(38100700002)(478600001)(186003)(6512007)(31686004)(4326008)(53546011)(8936002)(41300700001)(6506007)(66476007)(5660300002)(66556008)(8676002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjdvcTBVa0srYzNIUXRCU2hUc252dXBOaWRSV3FCSFJaeVpvOC9qVXpwQXZu?=
 =?utf-8?B?eXBvSVZidFg1cWM5Zm0rd1cvUit3L09jc3ltWXdFKzhubUdiRzlIOStmQito?=
 =?utf-8?B?RWFReFQwc3pRbTcrMnFLZENucjJCMWU3K0dBS3craUo5VExwUGZmcnc2U1RL?=
 =?utf-8?B?UFNtWTAvS0d6TFg5NnFPaWg3V1ZwVWh1KzJxZjhPTTd2amt2TDNneTFhQXRS?=
 =?utf-8?B?c3Z5L2t5aytEMDBxTTI1T2JYQXB2VUp6bU5lUUdaWEdOUE94eEJlTzNRSXRP?=
 =?utf-8?B?UlBKSXJwZ2lqc2NmS3RmOHF6aS83L2FVZXZlNkRiNEdmTVkrTFc4Y2dhemFB?=
 =?utf-8?B?M3RyT2FBMHpLcjE1bWczWFhnVUgyQnd4ejh6OWNPcmFqeFIyRmhVZ3BubkxJ?=
 =?utf-8?B?REdFZktOQzJlTjY3dm54Sm02Q1AwV2pwVlF6MitVL2M4eHdzY1VQQ2dMRDE0?=
 =?utf-8?B?NWk5dTdkRVVuZ1BMai9veWxicG5PNXhIdXJNamN5eUgvZEMwUWVOVTdkSm5S?=
 =?utf-8?B?WGVLZDJkU1cweTk5U0J3S2p2eDg3Y0NRaXFjak9OUDQ5M1JDY2lLLzY4dnZw?=
 =?utf-8?B?TWtVS1dKRG9PNmFDd3owRkNUQ0o5cldzUGpVZEVML2NjWlBVMjgxL3BmKytO?=
 =?utf-8?B?T2lrR0VwWWREcU16RGg0Uk8vN2FvOWU0SjJPRXMrUjJoVXVGa2NrZjRWVitN?=
 =?utf-8?B?WGNZcjNPUUZreWJDK0JQV1ZmMTdrY0pRUzBsTkwzTS9ncm44azNoMXZub3JN?=
 =?utf-8?B?cUhGSGt6eWc5aTVLT1gyTy9iSnExdlU3cWdQUkZER2N5WkRUSzFnMkw2Zm5Q?=
 =?utf-8?B?NUxtei8vY1ZXMEgrTzF1ZTk1N2crbXdnNjdOOWF4WnNHdUpHM3krRGNtMERE?=
 =?utf-8?B?QmZyYkM2cGlyMm40Z1BDM3E4RDlCUnkzMUpZOFFZMlQzQkkwL3V5WjlhTm1l?=
 =?utf-8?B?Tk54ems2Nm1NT3F6bitieCtKZEhUbUhKekVnWVlpRlAweE52d000N3B3MjIx?=
 =?utf-8?B?MkdRRCs1dmxuWmtSa2Vuc29xTkpUMVpNMVo4WGMvc2lsb3QxM0VEZVllaFU1?=
 =?utf-8?B?UlZwdU5VcTkrN2dhNmxzWHpsN3F4UUl6eWtWNE5tNVlNYUVocFZrRG14dUlw?=
 =?utf-8?B?U0JzR0pxMVc3VWsyTjFDbnVrMG9lYlZqR1NkN1JyWFdzbGVlN3lQUk5HVUZm?=
 =?utf-8?B?WXYyRURDeFF6d0M1dythOW9ubUdPaGFhUjdDMzJpaUd0RmltcDIyWVZBQWlj?=
 =?utf-8?B?cHRlNDQ1ZkM1MC9YdU41TUxscnNUejQzbHFGSVVSTlVhZ3ovNzF3V05meTRw?=
 =?utf-8?B?ZXJ3bzVtTlQ3RUJGZko2MGhId2hEQWJ2SXJINUJZcUg3SFlwbnczS0ljZ1hC?=
 =?utf-8?B?cVRNS1RoYStVYXB6M1RTUUo3bGJML1NjOVh1dXRDV1lnaGcxMmhkL0ZRNDZN?=
 =?utf-8?B?WG1ZZ0RkV3crU3dhTkorWFdqTERzSTBsSjdHWCsyVHhzS3ZhKzBZdzN0OE9H?=
 =?utf-8?B?R3Z2dFlxMXhNdGtGVjNjZEhnUW1tQ1JFalltYjFEcXBBMitnMTk5N2ZIZTRT?=
 =?utf-8?B?ZGM5cGtSRzFuWXpmVnptNngxYURQSXV2YXFZVXNSS3NyREZkYjUrOEVyMkJI?=
 =?utf-8?B?N2M3ODVOZjVFU3d2MVpJeTB3ZEE1cTRZaU82aTNlR29lMXF4bkdWa1Nxa1k3?=
 =?utf-8?B?ekhQbjZRRzhraDVCVEdJcllCUm9Xd1Y3RjJuK3MwYzRZSjY3d2g5aFRNaWJO?=
 =?utf-8?B?T3BUZitXVmVBdks2aHE3NUhUTjFqTG50bHJiM3QweUl2OWNxQTVYdVRaaFlK?=
 =?utf-8?B?QVFIQURkUUVyazRWbDhqdmw4TDhGY21ZSlBhV2Z0R0VWNGIxam5TQ0RqdzJY?=
 =?utf-8?B?L0pGZ29mQnZBVHlzYkMxdjIySzNZSm53QVM0L1loL0E2Wk1xWXZrcHpHTE1a?=
 =?utf-8?B?OUhFSmRGcVFPcnUxakRvZVR3dHhmRTFyQmxGdG80SWR3UkFpV3pLMy9FYTc2?=
 =?utf-8?B?YzR4ZUQyUGFBVGd5RGhwZzd3Uk1HUDZmVkIwbjJKa04wT2FlWnlTc2pwOFha?=
 =?utf-8?B?bGszYjlSNnBzRkNBVkdFblQyV2l5R3hEeFVqbDgwNTNnTmJUTnV4Wk5LS0VD?=
 =?utf-8?Q?Nh66oEm8f+aCRig5AvuSiskyq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d25ea5-6f62-49ac-4b3c-08dae4ca7171
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 09:45:36.7873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQ5Jw8zkwOzrAE2xtok1c7dO5rPFoSa/hzxnMY+TcygF91aA6w4zxmLDb/5JzLElv8h5evX2itG2EHyUxGuvYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4238
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/19/2022 12:10 PM, Perry Yuan wrote:
--------------------->8-----------------------------
>  
> +/**
> + * enum amd_pstate_mode - driver working mode of amd pstate
> + */
> +
> +enum amd_pstate_mode {
> +	/** @AMD_PSTATE_DISABLE: Driver mode is disabled */
> +	AMD_PSTATE_DISABLE = 0,
> +
> +	/** @AMD_PSTATE_PASSIVE: Drier mode is passive mode */
> +	AMD_PSTATE_PASSIVE = 1,
> +
> +	/** @AMD_PSTATE_ACTIVE: Driver mode is active mode */
> +	AMD_PSTATE_ACTIVE = 2,
> +
> +	/** @AMD_PSTATE_GUIDE: Driver mode is guided mode */
> +	AMD_PSTATE_GUIDE = 3,
> +
> +	/** @AMD_PSTATE_MAX */
> +	AMD_PSTATE_MAX = 4,
> +};

IMO the above enum is self explanatory we don't need to annotate.

what about below?

/**
 * enum amd_pstate_mode - driver working mode
 * All supported modes are explained in kernel-parameters.txt
 */
enum amd_pstate_mode {
	AMD_PSTATE_DISABLE = 0,
	AMD_PSTATE_PASSIVE,
	AMD_PSTATE_ACTIVE,
	AMD_PSTATE_MAX,
};

Plz remove GUIDED mode here because it allows user to pass "amd_pstate=guided"
in kernel cmdline. Therefore it breaks the driver flow without guided patches.
I can update the enum in my guided patch.

> +
> +static const char * const amd_pstate_mode_string[] = {
> +	[AMD_PSTATE_DISABLE]     = "disable",
> +	[AMD_PSTATE_PASSIVE]     = "passive",
> +	[AMD_PSTATE_ACTIVE]      = "active",
> +	[AMD_PSTATE_GUIDE]      = "guide",
> +	NULL,
> +};
> +
>  #endif /* _LINUX_AMD_PSTATE_H */

-- 
Thanks & Regards,
Wyes
