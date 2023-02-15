Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867A5697BE9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 13:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbjBOMfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 07:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbjBOMfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 07:35:04 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A7337F15;
        Wed, 15 Feb 2023 04:35:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oD7fqzSbYISd6bKcuEDxPiaiMeSJbtkAKismtN3oLFOE1m9BM0bFAMKyUZzd4yiwOK/cKlaTlKO2WchHmcZfz1WoaOD+DRbX36NxT0yRSWXn9haUuaAjKZMbsZGe8p4qr/lu9WiP9xxUQM4fF29jMyi/1FZ4YJt7TnHZ0s58a5XE1uOmNbizsBVOGUYXimW08P3DbOG+fw2zu2eWG6RXviSXt0ppMBr0OThxMhsQ/APJIJdDosMdPDMyXYDEKbPrezFvCpptedRBjesU8l6l9lfrkxXYk9CRZ4Wo7TVC5XK0Vw2y1eTnJaTaO0IiC/jjWKOevPojfamhPxnpB9RxNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puwIUfbwAVdah5eI8xAORSytsbge5zoeaUM4S8PAWTI=;
 b=byP5JYY+9sZ+dvXn0l+1xRl+LEf4wp5cLHbC0g/IiFUHQXruZejb5nFEWH8IuhQdhQ4QDAlciQkVbMwJF2JhBJse2+5JN83m8SzgZzDwE8uEBD4P9xVUUFbORj5QKraUCo9ftYBjAdA8JPMVTnEFN/tWxJXEyhuy0D8gmH45x7S/R1pItmdYZ56zsVggBu0fQV/yWpIuvCm96fjLpmVBsglKtSO5nZIqIDrQtaI0GlzXwXvDM3rGGcPCh9gXlwXtyfoH8lKKd/AiXxLZ7ae8Sp6bI/VXAhM9t5gtivR5ZftSEGFsJGju0vdflojUi8dJO430DLLumJAOARxFfe/3HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=puwIUfbwAVdah5eI8xAORSytsbge5zoeaUM4S8PAWTI=;
 b=afamgl7BAjZgFy6hF+72xxrwEQ49dZBSWdwtGYDoTs02+cnYp8LQ83hKLrWoFITmf9dt/YOp0RUYnRXO2o1kvxjkdXP3mYvR/Q2R6WGOf3X35J/3j3jXj9vAeOnuDOkYcvc1Er2RSRrLjt34aInr2/jR289yZPpPGpaYC1s04Ac=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BL3PR12MB6593.namprd12.prod.outlook.com (2603:10b6:208:38c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Wed, 15 Feb
 2023 12:34:59 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::93f9:c1df:8ca3:fc5b]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::93f9:c1df:8ca3:fc5b%7]) with mapi id 15.20.6086.024; Wed, 15 Feb 2023
 12:34:59 +0000
Date:   Wed, 15 Feb 2023 20:34:37 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Karny, Wyes" <Wyes.Karny@amd.com>
Cc:     Rafael J Wysocki <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Yuan, Perry" <Perry.Yuan@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: amd_pstate: Fix invalid write to
 MSR_AMD_CPPC_REQ
Message-ID: <Y+zRXZ4nHdFOFRuN@amd.com>
References: <20230214075811.23644-1-wyes.karny@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214075811.23644-1-wyes.karny@amd.com>
X-ClientProxiedBy: SI2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::15) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|BL3PR12MB6593:EE_
X-MS-Office365-Filtering-Correlation-Id: c6a06fd9-9974-4997-3e43-08db0f510d38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x8C8wbNWuTj1W4lqvLIJ8kVJzD4eGJwZe1lIFjnI9cRsVFWK4IXd+OCxF8gheEYkVmKnwPf69wafW33EA7A6dfhHyIudJRtvR9NTZmFQvRxaey95BAoQwNVSmUdJwXfuNbw75bGQRzf3M8bGfaWyHW6DWtmyg4AAQdfMH1i4uBlgM+OoLc5pKHdFa6/rrZAR8bpw6bve05uZIdCg0s97rvzMWIJdYE1YKOwIfHqYpueg+BzecrRMPl1cbo0/sDkjjeVN5XHIhFcWNPWGO1NJBbE5Oi1ff9l1nU2qRjKtB9pIng/VE7fYf3lKS7bJZGkWjWZx5h0p5Y5kvjSy5jp6T+R/eltgjt3hWn0N+rriS1FGNvZSBz5B1AvkNYJhpt2Z+h7T4Ri5S1t826yOayDRghKCCI/CxKzbW6U8XDWF4hzUcJCfhaBONhT8XD/s7+6KNKa7JDK3jcfAdaiFUVl0fud5v5HBiSnNxXTFHe6CBS/eDjO+7A8qveG/o1GyemdQLhiBZ5uwmnQiCJU2wEmyeV+cZS8+tdRfEBe010iveIgYOC82rn+lkhwLj+v2yxal69CuZFFWIIcZKZjCBD3fW8ePcz6clx9/HsiO9TZOj1jTzNUrBH+qYIZNDHpTY7htuAif+UeWh04EMuydHJ+rnoiwR5FjPwCkCR0G7/Zx6u7KlY8RGMDvxmlk8w7Ws6D9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199018)(5660300002)(86362001)(26005)(186003)(6512007)(83380400001)(2906002)(38100700002)(36756003)(2616005)(66476007)(37006003)(66946007)(6636002)(54906003)(4326008)(316002)(6486002)(66556008)(478600001)(8676002)(8936002)(6862004)(6506007)(41300700001)(6666004)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1RGSonKUE47ww+U31bS4u7myZahrDRClwN4HJJYj7dM6CoWuLDk3958SgKvL?=
 =?us-ascii?Q?aRLcPDJ/zyfgqPpDvgszej/Zs3mkJ+5g6t77xVp0o1sc8bpP4v8hXuA4NiRi?=
 =?us-ascii?Q?ZIYXf0exnCmbTPtq2VMmqcXFyV3w/AsnkDl48UdxLgb6D9M910JegrgUeaq4?=
 =?us-ascii?Q?x7OH+MP9wtgRWQ955TlZgD87WBTnARvM+C9B3h1hFI7tZifb2XZIzkRIGxDT?=
 =?us-ascii?Q?IoOiD5eDhRSf/Uj3NDD1oVX8OURMqEyYA+kj6K9EbqSqdS2MdMdKUs0yTD9t?=
 =?us-ascii?Q?74EXDKATmTvu8lfdKxzKQk64R08vSPW1RJT41gAYXOivOcCNZ7wFzzXITevZ?=
 =?us-ascii?Q?UdKmhlwOFY4Ypss5DgokKG0Oe0n7rG6FKpvJrbV5+a5jxDOk1NsYNlXvBFyY?=
 =?us-ascii?Q?ayJzUf24yPdWaW8nrgWoW/6lKrzwERdMF+e1TwUUVwlaX/9qkyQJxreWa0SO?=
 =?us-ascii?Q?mRR8uGEuNKmCJ5yvcCLDsCXXUmxrvHhXJKE5QphCsFItOjA7S2OtCo3BKGBT?=
 =?us-ascii?Q?5SLVqsrlOUibLJkoxDUou0bdiixP3rC8GreTa7K/4N8Gg3iqBpQQpzQ4FXL0?=
 =?us-ascii?Q?nhfh/ICtIDPFEkuWV3nhEFJHz5Kybd1P/RBCYEwoO2glw7mcF4yns6vBai/p?=
 =?us-ascii?Q?W/75pOZ7ceehV4/guVvMoVbpRLM3TlnSGr4IAPI/2vASLzkxEjwp08h9lDMy?=
 =?us-ascii?Q?pONuZqVhmeirjJL2arXTExc8o+fqsJvxRb8e39/HsJfP7fBnd81UONp3UQcA?=
 =?us-ascii?Q?jurTzGHG3znDEI26opNjx4YyPx+WIu1i8riwmH058JrvXQmoCdQkc9nFY8Ar?=
 =?us-ascii?Q?cD+DBuIatf9zkzfOdKpcWNmC7+G5aFfCPU6fYXvhDLIPw1S+NdOyX0JOvxRT?=
 =?us-ascii?Q?BhNE1WEE0kiKHGdO9vSmjMmnghL5gaUZNI9vLm5VERgvf2FGVZFjxR5DSu+g?=
 =?us-ascii?Q?xcqDIt2Rw92wpoTY0SQ6xx5rV6o4+BbRANS6wKVZQD6Nr+ZAkO+t5OqFz06V?=
 =?us-ascii?Q?hQ9UIwA25D0YobINuq7onZ+IZi201nTpHLTxOhUibgZct+Sw/wRIGKG/mbXV?=
 =?us-ascii?Q?zVc66ImogKJQ1aS8v2m9j6EkeFF5w+42jRLaA0VkH29woA1iYrVh8n6Kt42Z?=
 =?us-ascii?Q?nnBxMAcc1E9lb3Oue9PQdHqr+3sagr5ZAfIMIZB4nImdkE8Z6Fna2U7aMZOI?=
 =?us-ascii?Q?+uGvEr6W5+qHvFPn3j0PpbryZx19gHI8oFEqHna4uxpMID+luZzKQ8C7JRts?=
 =?us-ascii?Q?n1iXFGyTHghx1A/qvdFj5VtbKi1tZMhUM5Be9SFTxo2JbhGHiDwiVVBaDYY1?=
 =?us-ascii?Q?2YeGh2Md1MX0+Uxls5Zwg4TvLqA9O9do/KHKvw3SOiWOQc4YcBoocAylTMVl?=
 =?us-ascii?Q?yLqL0xQ4SpISmRLRUA3Ei2NUbyINW6mRmONDXbO7LoPGrkbWW+OuNia10QB6?=
 =?us-ascii?Q?iFIddAHPwe/7YbRj+/PnbrSunRyCKV9qpXkTgfX8/EUlza/+itp1C2N5OPRN?=
 =?us-ascii?Q?cyc/D13tD4OOjj2og5u1leWbRhigoFEATFYdJPQKajT+V6BLTc2HZtNE73Cs?=
 =?us-ascii?Q?FIaY/L/ByG/6BWfS+5ZUXwNg/1D701nsgsd+Fk5h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a06fd9-9974-4997-3e43-08db0f510d38
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 12:34:59.3801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R1hq7DiUYXZHt8NAtGvfcxC4WFpmXJHMZTTGqHhIZIIKseqRfbaP/U8ydmlrs4Aof8UUcvvOFSEAnbRlHwE5pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6593
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 03:58:11PM +0800, Karny, Wyes wrote:
> `amd_pstate_set_epp` function uses `cppc_req_cached` and `epp` variable
> to update the MSR_AMD_CPPC_REQ register for AMD MSR systems. The recent
> commit 7cca9a9851a5 ("cpufreq: amd-pstate: avoid uninitialized variable
> use") changed the sequence of updating cppc_req_cached and writing the
> MSR_AMD_CPPC_REQ. Therefore while switching from powersave to
> performance governor and vice-versa in active mode MSR_AMD_CPPC_REQ is
> set with the previous cached value. To fix this: first update the
> `cppc_req_cached` variable and then call `amd_pstate_set_epp` function.
> 
> - Before commit 7cca9a9851a5 ("cpufreq: amd-pstate: avoid uninitialized
> variable use"):
> 
> With powersave governor:
> [    1.652743] amd_pstate_epp_init: writing to cppc_req_cached = 0x1eff
> [    1.652744] amd_pstate_set_epp: writing cppc_req_cached = 0x1eff
> [    1.652746] amd_pstate_set_epp: writing min_perf = 30, des_perf = 0, max_perf = 255, epp = 0
> 
> Changing to performance governor:
> [  300.493842] amd_pstate_epp_init: writing to cppc_req_cached = 0xffff
> [  300.493846] amd_pstate_set_epp: writing cppc_req_cached = 0xffff
> [  300.493847] amd_pstate_set_epp: writing min_perf = 255, des_perf = 0, max_perf = 255, epp = 0
> 
> - After commit 7cca9a9851a5 ("cpufreq: amd-pstate: avoid uninitialized
> variable use"):
> 
> With powersave governor:
> [    1.646037] amd_pstate_set_epp: writing cppc_req_cached = 0xffff
> [    1.646038] amd_pstate_set_epp: writing min_perf = 255, des_perf = 0, max_perf = 255, epp = 0
> [    1.646042] amd_pstate_epp_init: writing to cppc_req_cached = 0x1eff
> 
> Changing to performance governor:
> [  687.117401] amd_pstate_set_epp: writing cppc_req_cached = 0x1eff
> [  687.117405] amd_pstate_set_epp: writing min_perf = 30, des_perf = 0, max_perf = 255, epp = 0
> [  687.117419] amd_pstate_epp_init: writing to cppc_req_cached = 0xffff
> 
> - After this fix:
> 
> With powersave governor:
> [    2.525717] amd_pstate_epp_init: writing to cppc_req_cached = 0x1eff
> [    2.525720] amd_pstate_set_epp: writing cppc_req_cached = 0x1eff
> [    2.525722] amd_pstate_set_epp: writing min_perf = 30, des_perf = 0, max_perf = 255, epp = 0
> 
> Changing to performance governor:
> [ 3440.152468] amd_pstate_epp_init: writing to cppc_req_cached = 0xffff
> [ 3440.152473] amd_pstate_set_epp: writing cppc_req_cached = 0xffff
> [ 3440.152474] amd_pstate_set_epp: writing min_perf = 255, des_perf = 0, max_perf = 255, epp = 0
> 
> Fixes: 7cca9a9851a5 ("cpufreq: amd-pstate: avoid uninitialized variable use")
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>

That's really nice catch! Thanks Wyes.

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index b8862afef4e4..45c88894fd8e 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1057,27 +1057,28 @@ static void amd_pstate_epp_init(unsigned int cpu)
>  
>  	cpudata->epp_policy = cpudata->policy;
>  
> -	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
> -		epp = amd_pstate_get_epp(cpudata, value);
> -		if (epp < 0)
> -			goto skip_epp;
> -		/* force the epp value to be zero for performance policy */
> -		epp = 0;
> -	} else {
> -		/* Get BIOS pre-defined epp value */
> -		epp = amd_pstate_get_epp(cpudata, value);
> -		if (epp)
> -			goto skip_epp;
> +	/* Get BIOS pre-defined epp value */
> +	epp = amd_pstate_get_epp(cpudata, value);
> +	if (epp < 0) {
> +		/**
> +		 * This return value can only be negative for shared_memory
> +		 * systems where EPP register read/write not supported.
> +		 */
> +		goto skip_epp;
>  	}
> +
> +	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
> +		epp = 0;
> +
>  	/* Set initial EPP value */
>  	if (boot_cpu_has(X86_FEATURE_CPPC)) {
>  		value &= ~GENMASK_ULL(31, 24);
>  		value |= (u64)epp << 24;
>  	}
>  
> +	WRITE_ONCE(cpudata->cppc_req_cached, value);
>  	amd_pstate_set_epp(cpudata, epp);
>  skip_epp:
> -	WRITE_ONCE(cpudata->cppc_req_cached, value);
>  	cpufreq_cpu_put(policy);
>  }
>  
> -- 
> 2.34.1
> 
