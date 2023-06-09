Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0787572A576
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 23:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbjFIVmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 17:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjFIVm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 17:42:28 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BDE210E;
        Fri,  9 Jun 2023 14:42:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRlXdZutnIgg5yeJasPfvf+pibElhj+m7d2olXKCs7p1ixFOSltaq5uhqWyZMpfOCtg5Vau+HhNb8ee4FF3iHxKUyg2TfLczDWLUFnhj3Kb4xHk3Y48YpZ27ng5HpoaoibZt2ozTWi+6Rcl1YMl6z19GDCAPqEuXWmNtiMrcFz1gbqXqZZaZAFxBsqWl86dUKqE7IomV7HYkRQNT6i7RrO3g8CTMdYXrsBDmLz9PlD83xUSkO6IdCJiZKJ26NodhXWSJSuIdCw2ROhrYreF4B46+yTMNTmTv30os7C2aqzaW1pKFLTxx+etb91ctqM8k8cH3yQeCbkTCUXWQPOUPbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mZ/lHDNYu1dq7Yp/J9HZmjygw4cWS5U+hgXxzhqA7Q=;
 b=cDP3j8DRR63b6RobgduY2XfB5mjx2RT1bej0jFEXSmuSeJlZy25Z6bEhQNzSwp+G3c61SPGLcMl5oivE2HW1CTOjx0LLyff19SXxVoFpB6p3Pd4UT/7FnvN7s999IMrTaDBO6G/tz+4osowLa6qsng5GOVDMHYg0TIpc9KJFNAgHuZqG5eoyvyYNLlgu2ZXVrPuczfGGNHpMBcGXwFOkpEpomWKZ15s8W657P6fjXzhmmL3zkP2HUWTgBYjkIVTAzM4cmIZVyr+LtLMD1P+JVq+NqbvgiimaMu3tkeq+WHV0uAm7bXvJW1xpJMdEIRkgzsdwsemDEosmbJF60QmQJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mZ/lHDNYu1dq7Yp/J9HZmjygw4cWS5U+hgXxzhqA7Q=;
 b=hcz78jLirgrNxanrX730fOH6CXSX6ChSI5xWlPr4b8yydDXotAp1DfAyvvCl2EaEtY7qOG9eJRSGf4kBmKoaei/d15HrhHobd2eLmkTvLWyXd74kTZa0nA0g5jJIBzNRqQFhEj7ycFNkQflOG3cs07jpubhSpF1zPd6nv7XNOqQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) by
 BY5PR12MB4162.namprd12.prod.outlook.com (2603:10b6:a03:201::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Fri, 9 Jun
 2023 21:42:24 +0000
Received: from DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::1a81:77c7:9126:e215]) by DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::1a81:77c7:9126:e215%4]) with mapi id 15.20.6455.037; Fri, 9 Jun 2023
 21:42:24 +0000
Message-ID: <30ff8a49-d3ab-63b7-1c9d-fbbea7a4b565@amd.com>
Date:   Fri, 9 Jun 2023 17:42:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] cpufreq: amd-pstate: Set default governor to schedutil
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        perry.yuan@amd.com, Ray.Huang@amd.com, Wyes.Karny@amd.com,
        gautham.shenoy@amd.com
References: <20230608095358.30548-1-mario.limonciello@amd.com>
From:   Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20230608095358.30548-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0120.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::20) To DM4PR12MB5311.namprd12.prod.outlook.com
 (2603:10b6:5:39f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5311:EE_|BY5PR12MB4162:EE_
X-MS-Office365-Filtering-Correlation-Id: d537376a-40a5-473b-5150-08db6932695b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NWoozBii1mVruld8p7xz6WY7bVJPr7uMbf4zSv51v3B1lmDJDs2NCF28AtTurTjR6nvHDlhebHlJZIC3pIv5rG4ehB1vWRPvWp5ekR0QC1/RBBrm5C4+M5+3l/adDK5gaP13p7DbmdKl8y/OCZjn1ZuMYGnoZz/jtlr6W4zpgxk+iInO2o21ymf7XlWbE2uJsicAlhD1Vmkv5UWjIQ9nuhxF2mqPErK2zWESN0Vb0U4auQ/RemXfkBKWUT47Ql4rGi0io1Hl8cjYMEKhtdmNbeC32sodt/r0bQMdKIrXz2mleCQHaTq2O5Cy5n8/e3+DUACyDKNXnabyApyA7HL+nfnQ69+8o3zV6SZdvNDT/R9N4NQZQr3lY8YRywUyPWxvx+9JDQqbkts1G/4lCmKoW6bXHHN+Mk1F2b8igbQNQA2Dg1lbjEquzA+c8jLfRk37YkIiNeSuHDZbbVHThQpVNIIZy03MZaq961QGCj5Z1FPpt7wwdEaZspb0nsS6maa8RdZOekEXFvliQYFryT0HMwocBNEZeXKIP9TomovS81psdC1U+tjc8vOcAImnZzGpy5wSi5mjXg9ObOrQan0dpPFMMHgSyVmWz08wI00mvhakOgIHbTwglRaIMVvw/Q5JssiD+AYS0yZaIkpiMe3JBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5311.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199021)(31686004)(66556008)(66476007)(66946007)(8676002)(5660300002)(8936002)(36756003)(4326008)(6666004)(478600001)(41300700001)(316002)(6486002)(38100700002)(6512007)(53546011)(26005)(6506007)(186003)(2616005)(83380400001)(86362001)(31696002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1ZXdkNNVmp6Zi9FbFlTdkhVOURzR3AyNFJmN2ZEK3l2UWNSVUl0ZGw2OUow?=
 =?utf-8?B?SnhRNEtuYWFnYzBKSktZK0NUUWhBd25renplMHhWSXk5RjQrQWJNcUVCSHZj?=
 =?utf-8?B?SnRGSzAvcVJyNTdoNGo1VDNicWxlL2MzQjB1OWJiOE1GdUJreFlnUUxkRVhx?=
 =?utf-8?B?TDY4MDBIaTBkUlp6RWNyVG4rYklvNytxMjZQc0hKWDFhYWxOT3Yxb2FPZG5D?=
 =?utf-8?B?dnhKZVplenRhbGxFcVRMYThqZ0ZHMHJRcXc0RExvYUs4TzZYU0ZkRmJQdzBJ?=
 =?utf-8?B?QWhsbGtWWTlmY1lkbWpycThSNU1iSXcyN0dtYzR0WFNGZDQrUkhjWjJoWll4?=
 =?utf-8?B?cnF4Ymd5SXFPa21lU0FFdWNFSnkxMjF6SEU3ajdrZnRYU1dPaVJNeHZEMjlj?=
 =?utf-8?B?NWsxazI0M2ZvVzFHMjI5M1cwZnV5TFJWY3FwM1E2Um5vUngrQ0xOdWhtZ2hs?=
 =?utf-8?B?c0gxbkhIVlZLQnBTYjhEU3poOUd5KzJHVCtxUnlUdkt3a3o2NjNOVm90eEQw?=
 =?utf-8?B?Z0NpRDZ6dWdiNzViZGxCZlVOME5tWTVJWHNOQkdjOU9HR3lsTU9jWUxRanF2?=
 =?utf-8?B?a1BtOEgzcGF3cE1MK0xKVnp0TVBTMy9BVlp4TWh5R1JneWYxSEFORVNUVWY2?=
 =?utf-8?B?UThMMkxYb1JVMUdRSWtFL1lCb0Y4V0kwTkJzelIwM3JHcGxKQ2NJNHNOVlgy?=
 =?utf-8?B?MUdrMmtSSUxyank3UFpOdnlGeVg4MmVDa3dmcVMzSjhFamZPZTFuZFJwV09N?=
 =?utf-8?B?Q3lBaU5OWmZMMDNSOVpSOXhvOWsvamJReG9Ec3FvV3QxSi9VMXFJcitRTXRN?=
 =?utf-8?B?dFdlb1lBVDFldGpUZWxFY043NE9NL0lwOFEydE9Za2dsdGM1MEtBQ3h1NUVv?=
 =?utf-8?B?dHlXQzdOMHAxc0RiY2Vkd0NEaGErNG9uc1FyOVJLTm4veFJmTWVtODd3NDB6?=
 =?utf-8?B?QmtzTlkvc0M4T3FLS1dhYWVRaTRFY05TVnBGQW8zaFhodHNsbVFiOVBydWl1?=
 =?utf-8?B?am95TXZWL0NNbHlzZkpTdk5WbEtHRGpQbWlHM291T0FXRkVuUXUrdFkzRjN2?=
 =?utf-8?B?elh5cERGUzJlbGo3S1R1dlhJNzF4NWFzS1FaR1hSbU1qakpjejFoRnZZQzNi?=
 =?utf-8?B?Rkdjc0ZGakdHMG1rcGdZWDZzWjBkWWdJUkU4NkxaajEwOTdhYm5UT2REUGJH?=
 =?utf-8?B?ZDlFRVNrMkNVb0dkSWhsZ3E3VmZldVVLQWNSdjFodVE0SXBiazRWRC9IQUJ4?=
 =?utf-8?B?aWx1Qlk1SkUyd2J3bXhLOGtiMkRQa1ErR0pGTS9GWXZFaC9yd3lMUklIeUtP?=
 =?utf-8?B?WGdWSXc0ZlA5bFR1K0pRNTdPdGJpd3ZiallJWmdGTWV3QldHTVkxOXpxWUxT?=
 =?utf-8?B?MEkwc3FZZVlMV0JBZUZoOSs1QU1IRlNIY3VUc05UOXpqd0lEMWYvM1FvZ0kw?=
 =?utf-8?B?NkFOeVpZSDNWQXVMb1ZGbHBZRWVtaS8vUUNXSjZvYmxFNGorTTFZQlhtcHV2?=
 =?utf-8?B?ZU5BbXl3cUh1TVlBWUJyU21LNTd5UFVRRlNISENkb3ZvMUV5RmNaMjBpdURr?=
 =?utf-8?B?ZjBkQkE1djVLdnUwTzN3ZmRGMzcwMkRBbCtxZG5Jd2FyYXdxOGgvdEkzRUhJ?=
 =?utf-8?B?TGVuNmhwWlpYZ25XVW95YUJmN0FBOXdreTdrVmRxOEZiTk9YZGpqd1pacUZY?=
 =?utf-8?B?WGV5RHp1dTRmUk05eUJMMWNvMDNtL3JINkdFL2MzcERTUWlmOC9mMUFJMEor?=
 =?utf-8?B?Q0Jxbzd1Ty9IUmtBbkw5ZmJiUmpyTzJ5MzBaUzlSR205M2J3dnFqcVBzSmJy?=
 =?utf-8?B?R21mQVpSaVMwdllXT2ZqK2VPSkNlMmdIZWhaWXVoQWlGRWloNmdHS3U3WEFy?=
 =?utf-8?B?MUpNbEtTZXZLVkFtN0xSY3F6cDFMcWZPUTNqT0lXMnEzUkkrOWdyV3BKNHF2?=
 =?utf-8?B?YktiMHhQaDB1MjMvVStuaGRpdFB2akFkd01PUnBLZjFyMEFVUjlteFBWQXJH?=
 =?utf-8?B?T2VVZHludStjd1B5d1BhMytoaW83eHp6YzcxWlpMUFI1dzVwdWw3L1FlM09O?=
 =?utf-8?B?SDk3YWY4c1I5MDJKWXdWMWFTM2tmSXdGV09NUWJla0xLZmhya2RGWWJYUWF0?=
 =?utf-8?Q?EW8fmTAwpF2ubXHJuN4YiYUBf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d537376a-40a5-473b-5150-08db6932695b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 21:42:24.3269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UokAsCMXmpRcF/z22NK6ahIVyHOWwseVIUORn1LDZVzOzXiAZXaO+mPd+kQXydKA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4162
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



On 6/8/23 05:53, Mario Limonciello wrote:
> The Kconfig currently defaults the governor to schedutil on x86_64
> only when intel-pstate and SMP have been selected.
> 
> If the kernel is built only with amd-pstate, the default governor
> should also be schedutil.
> 
> Cc: Sun Peng (Leo) Li <sunpeng.li@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Leo Li <sunpeng.li@amd.com>

Thanks!

> ---
>   drivers/cpufreq/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 2c839bd2b051..a1c51abddbc5 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -38,7 +38,7 @@ choice
>   	prompt "Default CPUFreq governor"
>   	default CPU_FREQ_DEFAULT_GOV_USERSPACE if ARM_SA1110_CPUFREQ
>   	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if ARM64 || ARM
> -	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if X86_INTEL_PSTATE && SMP
> +	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if (X86_INTEL_PSTATE || X86_AMD_PSTATE) && SMP
>   	default CPU_FREQ_DEFAULT_GOV_PERFORMANCE
>   	help
>   	  This option sets which CPUFreq governor shall be loaded at
