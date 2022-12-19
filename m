Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129C66516B9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 00:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbiLSX3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 18:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiLSX3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 18:29:40 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E943264E9;
        Mon, 19 Dec 2022 15:29:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPqP+46mG1heo8Cxr6NLxpN6Ps62CSPM1tnSUrqhrIaCcQlD7o8PvEFyU+wgaJXT1ejLwtHMzOzGXKw32cIu2wvjdEfvdqLhE6wKZH0IOcTQ3BUweIhKJTX17168KLwT+HqNcAARWZnsjbi90BdJdelko2NvPnyx2T9Uzzba1mEyTOxK5Hetkk2zmYburprWi2CesUL14XmEA6RRVbfjYWPCXcrvixubyLfQADqZl6sf769mMEGI02DR9HsoQG6uhFx80XM+hHoFIPUAqiOcVFqjIPCiBWckAJGPm+EfypBupn2WQKzCUTSEOuiUgWPXMLPxOJOdG1u/LPPtFbrBwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrtuFslP6BZK8CJq5DpubQSol6IckcCVlbfqqOWwkTc=;
 b=dzIwl1dcc0sLU6E1SDgHD9Y3peRRydoZ8s9P4cd4Jg0uWXzPwjooFXMTSHbQ/bKx5IXASF5H9EHZEFbxei+J8wGE3hgmaYIdZN9kuyXNBq6uV8xnmOoERRmPyFx4xO/XBgou9N/1cI+7OAu/GCyIowx+8TWRdLZncLHDzjlNyZsNfp+y9PKJJKb75CSvM6QEbnnBp3YDgst2bwBejHgIL38hDwQnQ+tAhNIrjMOavnx6cMo5CPTzoEZnZFBKP+g7Ns67Jpze0kUiIAw78anlRkJPyK3Wm3rdOhKxB33QbPIqpECjhaeGs7a2aUHrwNdipVNqmiOxvOiB/Jz44NNtQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrtuFslP6BZK8CJq5DpubQSol6IckcCVlbfqqOWwkTc=;
 b=LA2bkmB/N00a/3kKAy0BwfNlP/oWlLb4JFmR7siKDt80tEMoYCKVNAkq/1w5gcnRZ5Nb4YPU9tpSwUH58drrVsqC1zHRPCMWk4l+sLp0dwlt3s8mdjGdIP5V9ky7lc9UToLt63YdZXA8SQka7erTGwU9rl1TS8YrN61TKrFXiDc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB7553.namprd12.prod.outlook.com (2603:10b6:208:43f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 23:29:37 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%4]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 23:29:37 +0000
Message-ID: <01480f4e-9ca6-50bd-6a95-b2e61834d2e4@amd.com>
Date:   Mon, 19 Dec 2022 17:29:34 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v8 11/13] Documentation: introduce amd pstate active mode
 kernel command line options
Content-Language: en-US
To:     Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, wyes.karny@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221219064042.661122-1-perry.yuan@amd.com>
 <20221219064042.661122-12-perry.yuan@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221219064042.661122-12-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:610:b0::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bb0ef80-d3f9-4e4d-dd95-08dae218e4b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gH8p/PuzPeuQo2fb/XkvdUFHMnw+Z0UOwKzyjQDQxOCJQJG+tJ4zGhamAqfuWS41EynEkOWEzWLg/miZgzvVPe67P+IwBu5tr8A9DyGCHHuYDclRinv+0AbyuCBjVGvCb5FVJS0yJGxNNXpEk0jhJUB8I/LN4YaDRBXUoXgIIeamdgL+/1sjK7tbzCK2Buq632+r7LjYcxciF0VDdVuFz0pmH9t/8KKOLK6SnRLzrShbG/l8WAuiTuqdR62+ynQlKS0Yld0DPop6pPgJNgMkcdB9mPIGDpYWAp+2MkCjlIlTev4kbYkSozY2pnpV+insevTET1yTuXijmC0Azuuk5ceOEST95tRF9PEDc+uLvp8D+iKWvYQh33hkPYMx9A0l5Mz2LwhIfn9dSeoB/p70LhlfuiELw5/n26MJjKb/2d37YDfL0NJjp1LPcEhxxhqYFO+HgsB/XklLHG4BDwn/cWw0KQTzg9HSUiukfU0RbI42kV6WOoBGevlAHMupuI7xOXGen5vDC4LOjElcjyu3XZAZ3+u0v6faKwa+WuZ9u+dHFQWD3AInAZFZaAvzb1wZnCIlP1NeZJmsCuo1r4ikb9BnN2k+og+R6tGtcIfMsBVdGpQuDT1t5swUMNB4jmpVBqfmVs0WU4Brg+zFdeE82EnTYBZHHc5c8/gTmBjynPO7AzUBnW3N8B+zZHEV6MLMwRxt+0JYBd1+df2EvJre9MSx/HFXQCgLv/8e+tn7suk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(451199015)(8936002)(6666004)(31686004)(5660300002)(83380400001)(186003)(6512007)(41300700001)(26005)(2906002)(316002)(478600001)(6486002)(6506007)(53546011)(36756003)(66946007)(86362001)(66556008)(66476007)(31696002)(2616005)(38100700002)(4326008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3lKNVIzVGRzWEhiajN6Ynh4Y2U4U2x3YS8ybWFaYjRWMGZDWTZBMUFqT3BD?=
 =?utf-8?B?UDZNSDRPU25XbGZOK0V1eDFVdkVvbXRDNkV0Ujdic1RYYm1EaUdReW9lSXB3?=
 =?utf-8?B?THprQlAzYThudCtQbG5aMVMxNGZrdTBOREpkOEdpZi82RjRpWUlxNjFHMXA3?=
 =?utf-8?B?d041VVBnSG5Gc1p4VndLS1pORWoyRmw5RFFCVlhHZHVaaDFscXhqQ2NBT0t5?=
 =?utf-8?B?Z0o2dU5wRTdXMDBrUDQ1dVI0VmtrWTlMSEhVOWNlUkVxUUpRb0ZQUjBpdysr?=
 =?utf-8?B?clNiSTY3ZTJqbG91RytHTFZVQllTazZZMGhoL2lCMVhiQzh3WTJmSjgrVXJK?=
 =?utf-8?B?RzFsSFg2dzJSczRiVnlzUlVCYzdvbzF0VmgzTXFYbXZtRnFIbzFPK1FxclE5?=
 =?utf-8?B?UjU5UWMxNERNM1NtYmdwcEs1ZWhBSk9RREJwcHEwL0IxK0NjUy9yZUR6VWI5?=
 =?utf-8?B?aWd0V3lLM3Ntc2tuWlNwUzZKODNaV3FIYnBOUWJxdWJoWDBPOFpzMEZrdmZS?=
 =?utf-8?B?VWRKV2cvQURmUkE2bnpKVHlHM3pVczJHbk5Cd01aZ1Y5NXZBZmczWi9wQkRM?=
 =?utf-8?B?cGloZ3A3YVZ4MWF5RzlONFdEWHRkQjhCS1huOWh1QTMzWmRZa2Q0SGpPcWFn?=
 =?utf-8?B?eWdqZkl0cjZ4RUZkTnR5SlZqejZnVWY3ZnZ1NU5YUjdPbVdkS0s3Rit3R1I4?=
 =?utf-8?B?VXA3Nm5Na2xWSVd5VEhJVWtvZkIwSVVSZklac1Fac1hkMjFkMVp4ajR3MkMz?=
 =?utf-8?B?VEMwaWpoWW5uWTIwL01EZjZ1dzJZbXpiWjRwd3UxaXUxSU9GZHNnbHEvN2lU?=
 =?utf-8?B?dFdOREtpSHJzMnZjTmFuMkRmQUtNVGZrYjFyMDI5VXZFRjFudVlXV01hVlBw?=
 =?utf-8?B?UGs0MTdjT2hBeHByYnJkaWo5Sk8zNGNJUWRZbnl1SklqVnQ4MUFZdWJ2ZzY5?=
 =?utf-8?B?clh4RllQM1kzb3dQbVRnMzlaNDIxUndGM3UyQndHNGhzOUF6ZXgrNTlYTVRU?=
 =?utf-8?B?RzJGWWJsNzhiM0Y4YmlqTGlsTmhQWWtNUVFUY3hPN3hHV0xqWTR5Lzdydk9l?=
 =?utf-8?B?RW91ZWczZE05T3VOTkRIVmZKMHI4ZkhJZmQ4aU9NbWJGaWpRenhkZVA5d2Nj?=
 =?utf-8?B?QjJDVHJBVXp4NGNSN080WE82WUdVL2NzU2xobTc5OGdqMEFzS1N1bVZkVzJ5?=
 =?utf-8?B?WmRoSFl1NUE1enltTVBCaWo3V0dCRk10Y2g5VUkyUHd4N2xhZVcxUUMvN2pS?=
 =?utf-8?B?SUcyVW1sblE3WkNnR0N1cE4xeGJtR2ppRWcwQXlFZXhnWGJwNUgwUTJKQmJt?=
 =?utf-8?B?c3EzdXQvMCtUZjBMSUY5WC9LT3V0YjFxSk4xdWY4RUc4QmxkbFZvRnV0NHRl?=
 =?utf-8?B?NXl1UWdYdGFnQmgvb1pFcG9abmlTd1UrRG5BWDQ3ZktCOVNkRlQ2akxMK3RK?=
 =?utf-8?B?VUIwVEdOQTVKYjIzVGlVMnRqVjdEdnNHT0F2UHIveEF1VVVkT2RZT201VFpT?=
 =?utf-8?B?L3dsd0g4WVY3MjlKM2xGajJLeUl3VEFoNUhoRmh6N2tCU2J0UTBPM1dqTzla?=
 =?utf-8?B?V1R1MDNwbnliRG1nMi9WREZmZUFiR0FxT1NiOEZCV1BMQ29xUmhtNzF0WXha?=
 =?utf-8?B?dm1ETUxkZDB2TGRKb29sVk9xbWljbjlabDUybjQ0R1FZd3k1V2hPVzZiS08w?=
 =?utf-8?B?b0R0ZGRBZHRnUXR5Vy9WNG92SlJWcmIxWkxZSEhvV0EvUkJFL3NlYkx5OUQx?=
 =?utf-8?B?b0FmTXYxdWc3amRFcTRiUVpYZ2ZDbFJ1V0dYaEV0L054bDZRbU1EaHJQOTli?=
 =?utf-8?B?ZzFOTlhhUnQrNXJhRk5HRjRUN0EwTDE3aFUvZWJBTkJRWElnakwybUJmUTJE?=
 =?utf-8?B?NWRqdHcyNmcvaVpvcXdXVWN2dkMzOFM3aGd5R0NLb3Z5NHowY3ZuV3BFVHVQ?=
 =?utf-8?B?dWp2TkQ4VDBiYnZ2Q3Z3bklQQlNEdDRLVnZBd2ZGck9Jc0h2dXltQVRPcTY1?=
 =?utf-8?B?S1FTVDJHWWdlNTJheER1U3A2aktTOEk1SXRSVUJVUW9DL24reENSOXgrZjg3?=
 =?utf-8?B?QXlkVk5YZmpCRGFhTkNzUHJZWU5yeGlOWUlNck1VM05jMmo2cFFHWFA1akRO?=
 =?utf-8?Q?2gl6/Ss5qtGaoG8n5ro9+4ZsW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb0ef80-d3f9-4e4d-dd95-08dae218e4b3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 23:29:37.1213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WNQAEB89c5GfpUb5jw+ScRXigxu+QGCTa4bNzevvnaSf6WH5gLE2IAX0PRbekUkFejP7HS0sOHAI+eckg7Nwjg==
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
> AMD Pstate driver support another firmware based autonomous mode
> with "amd_pstate=active" added to the kernel command line.
> In autonomous mode SMU firmware decides frequencies at 1 ms timescale

This might be the case right now, but I don't know that it will always
be this timescale.  Suggest to drop drop "at 1ms timescale".

> based on workload utilization, usage in other IPs, infrastructure
> limits such as power, thermals and so on.
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>

With nit fixed:

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 42af9ca0127e..73a02816f6f8 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6970,3 +6970,10 @@
>   			  management firmware translates the requests into actual
>   			  hardware states (core frequency, data fabric and memory
>   			  clocks etc.)
> +			active
> +			  Use amd_pstate_epp driver instance as the scaling driver,
> +			  driver provides a hint to the hardware if software wants
> +			  to bias toward performance (0x0) or energy efficiency (0xff)
> +			  to the CPPC firmware. then CPPC power algorithm will
> +			  calculate the runtime workload and adjust the realtime cores
> +			  frequency.

