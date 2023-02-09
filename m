Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F11368FF9B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 06:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjBIFEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 00:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjBIFEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 00:04:21 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CB523332;
        Wed,  8 Feb 2023 21:04:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MB7Hm33aFdCSfPO5EAp30o5D4TtR6HZrXXAjkMRFMhWkL7awv32rW+qcNfjqgVlQu5CKsll7aecoGq0C3OU0sHNHzavYIbLBjOnC+CVJROtRj7nhASuvg4E4f4eKXWPKllTZOBZpiiQbF+yXkArEHWsqm7KvWbTHCwUdGmBLu/n3r6LufXlC8Rbb+6x8aP/UHBWE6iF8Fny56c8J0PlUNmjOMM0PsW1w72cdANbXymTqUG4ETkQolTntYx/SOazaWOis9c5Sq7XRfmMDXqA5W2YG4lDpWh4xHune6av/nxRgdVvDEipDQicurSXiTn91MRtMOKT3tx/zPeEH2xCz8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tKlnkowQWviMlVNsSoWbtUa16Z60QCNas/6fiQTFGA=;
 b=Jj/PDzugyh74TD7gKGNOHjll2iJctsg4ztzKQ5l1+i/idgh7iRDJPR6SdPU7XXoTXT6xEfgaS8cAC5NNT3YJTrsMknNOGfvX8K4lwFGMR628qsu5+1Kp/hMwn5DQgO93iI6762NzWWddYsxabctRjbo6CGttd2gvDorBxXRWKCTUe9jSu2dYhhUtplsA/QD/t/LktbB56sBiPLto3FZTOFKjU/52QgLW1W4rYa2yDZMkBiojrotuHlUG7LnWCx4pqEDZGKP8BoH8DeNnUuxiRaOFHBKCPJQW9yuHGVhRWGeoyiAsF/o7zPfXHlbgtOpb4uoY7lLCZnYq2OevV5uR9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tKlnkowQWviMlVNsSoWbtUa16Z60QCNas/6fiQTFGA=;
 b=0xAfzHd3JUO7bF2LLlixUfCqP7frdxuXy3AHTV6hBPD1Jz+J2q80QvJ+a8+2Bc6rffgxmldIEdupPccxMW15mmU0PrfRpeYc7EmUCknnMsAZlTajaQGCUEuoii9lM22eDwglstqg4tfiC2F497jOYqka/ltQXfZWR2pa+yPwe9E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 IA1PR12MB6579.namprd12.prod.outlook.com (2603:10b6:208:3a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 9 Feb
 2023 05:04:15 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::93f9:c1df:8ca3:fc5b]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::93f9:c1df:8ca3:fc5b%7]) with mapi id 15.20.6064.034; Thu, 9 Feb 2023
 05:04:15 +0000
Date:   Thu, 9 Feb 2023 13:03:52 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Arnd Bergmann <arnd@arndb.de>, Jinzhou Su <Jinzhou.Su@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: amd-pstate: avoid uninitialized variable use
Message-ID: <Y+R+uNXkS/BPpdZc@amd.com>
References: <20230207161256.271613-1-arnd@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207161256.271613-1-arnd@kernel.org>
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|IA1PR12MB6579:EE_
X-MS-Office365-Filtering-Correlation-Id: 54eb7c65-a4ee-416f-4e31-08db0a5b1739
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x4H7XaoK/LCWq0vN3Z1CPJ83eIWnNZojF44OfnMwCi3G+erY32T2XrsSeHZTPj30Jvqt54haplggWcJwDaJHlJhmNNCiRh1MxszAWl6l3nkCDDiREeTXoceHwjr3/blA7GZ9oky506abbqN+SJT8CPWmGgDfSztxY4aBII9EClxuHyrMcMfZuzSJC5V5FbyHdOwH3RzhZYGCoIRLysE8NyGQ4D+X2frYM+vIgPh5QMkiHWfSSCOrXDtn2Gm1dsqDsR8QA6qRXxm83ZbiSQNCWw7meFe6rwxnkcpQVuYdsaREs74JO00j052uZgnKCzAFfHwW0aNHU/HnyTP1vUVXHW4/kf4TnDFsR5SB4v5cydHU8a51zGl3kqnaaH6kY9Ockim7F7vDkwq1VTLrmH+24nZKW0ciSFZyQCKCJkG8z5hOevswmkLnVsMYXDCfCW2xuCzm7XRB4jprcG4YkWFSxX0LmY4G2UDHE99uUzDhYZnbTLn1DDHEFz5oHdBu0hZAVnN0OQyI48tJBiv11KftoXCCOXi0kA9DIqu9jp17kY2/GLg5AtTp6H/XhOT0TxmM4+2dZBbSx+s1YvvUabo4kT3w0q+vKJY9WuNxKMArTTQd6MuctD0tsMSUu6m2HyrasxBZ30Bc6Pc/S3eZwN4DNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199018)(41300700001)(66556008)(66946007)(4326008)(6916009)(8676002)(66476007)(36756003)(2906002)(86362001)(38100700002)(5660300002)(8936002)(6486002)(26005)(6512007)(186003)(478600001)(6666004)(6506007)(2616005)(316002)(54906003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TZompnpQ6O/u4y27on+zIXpqIz5n01OnRHb4fG+oKZvzYSSkYTn4nxjUyRf+?=
 =?us-ascii?Q?NyZHPkZywSLkfO3OCc8bktF0N5HK/yYyx2fStp9okRE9fjusbFUgkfAn2RcC?=
 =?us-ascii?Q?UkjZTmEL+NkfT/9Exjd+W0WfIK5SI4qHgwI2wMtM0W7UvCUdz8voTzPDCASw?=
 =?us-ascii?Q?jzlah+o96VXFo8f3It30w7bLzuwscWmDhAgXSxyw41caMXdjYEkKq1MtlYN1?=
 =?us-ascii?Q?XuikP+cnbkVsoPU2K+Hl67HkxzQyPfvW33cKNOhms/goM+z8JgJQivk+59I4?=
 =?us-ascii?Q?XdXUZdk5x7EPYj8LZnJkeDfaIjaJpmNhlzDKwWWL0SGvjL5lc1qTYlU10VB9?=
 =?us-ascii?Q?g3QFt+AApMTbRlNbEoKV0Vih6TUAK7FtIBrBOdqhsKTgt7hb8Iq2mjwWq52C?=
 =?us-ascii?Q?RZg/p5UIDNWsOlqARhi3CL5Diz+P2u/VzY5qc8E4Ocws+PdiGvpxf2WlY99a?=
 =?us-ascii?Q?lYNKeqY/D4SL2NhD7ejabaOBFpXK/mw9dLNLuX0jCDPJrYr3NDKbCJuoV/5L?=
 =?us-ascii?Q?ahMNQ1l/NsrxBvDyTFwPqp62m7GSSDOacttOCaJVz7eD4IR86Pi1p8S0G6j3?=
 =?us-ascii?Q?OvslIWr5EK9Zqd0cefxiRdYU4X//LyTSoX1Ga8cO3dlc40iBMrgeADvZ6ogD?=
 =?us-ascii?Q?Fe+RjHjOkFBHGhNH6VRwGNnAE5qqlWebt0SbMr/NZ/AXsWxxQimPtXT4Vn0s?=
 =?us-ascii?Q?CiRrvQYCkqcXwkpmyDmEYSrjkFdep5hTaZ2J+ujv1ws+RcoQuASHC6X407YY?=
 =?us-ascii?Q?/rBcdjYne6ERNx91cTqgOlbsRNBax0TcSwv70tY1xt0B2ylJxZwFBvVjqMik?=
 =?us-ascii?Q?JrZj1jQpEYj482wNrJhG1DILKudaKl+XyqRXsSM4B96AGVJYpn2blgIMcNwS?=
 =?us-ascii?Q?fuy30LxqJUJGrnyvRdKd3wDELL8BbN4WszkvBYq0X3sZJ0J/cW3pu27ydQhS?=
 =?us-ascii?Q?bHqUGznT5z46xxSjRxklE9dPqG1K7kHRi35/n4XiWTMyNk7M9nU9CrdKLX1j?=
 =?us-ascii?Q?zlooE7Vw2XWpkZAFeefko6WZPxVXqJRWO1QcUditU/3l4iHrpwG4qHEUGU/2?=
 =?us-ascii?Q?rIX2lNFESM8zaXBvuEloHQ/lO8kDyiloDuovTUq27swFDOIglOTkmzLlyYtu?=
 =?us-ascii?Q?mJ5+FpqsPadlooMUwFseqmKTvdv7jAccbNn+II+ubb+riOtBLj3tNtO1IUyk?=
 =?us-ascii?Q?L8cRzQtx2/M+L5qkyYSn7MYiVypxRacc/so5NcSP2fqKzeOlGnEYzwyvfO64?=
 =?us-ascii?Q?BC8pWRmyRWuk8eg+5SQmK3xRIJCcC3UplPItEexVIS5z9tPy5lwgjcFhpBpL?=
 =?us-ascii?Q?DHQz3bpFNtWhnt6lT0tw71vV0zcuWpYylVOEQVRzK1yZqbHyAVmIbnWaVXWF?=
 =?us-ascii?Q?Q+8UaXJnnk50grVKibkBw/G1ugh4MDDIhH9OnEK3gQfkkoZNPB5Q/9JkleA5?=
 =?us-ascii?Q?HnU93oBbo40ustA6MHLLR/coxOrtz5SehzmDTYZdLg2Q4XEXZjvZPK1SREZ0?=
 =?us-ascii?Q?OK1swxHiuqruCg85raFZXZyFXEQSYwQd/lo9t50RiRN2esZxMRWSMkIf5naW?=
 =?us-ascii?Q?j/2Ozl5qnghy1YI3r8ScnN7sNXine9OfwcLXk6Jl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54eb7c65-a4ee-416f-4e31-08db0a5b1739
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 05:04:15.3021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HLbjgcD9NiZTL4mNwrMalU9ArwVjF/NDCvS+V4zsEMtgLRafUGAt/KTlIh5bsyXMpB+DN59c6f3Be/eZ9AQwIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6579
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 12:12:51AM +0800, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The new epp support causes warnings about three separate
> but related bugs:
> 
> 1) failing before allocation should just return an error:
> 
> drivers/cpufreq/amd-pstate.c:951:6: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>         if (!dev)
>             ^~~~
> drivers/cpufreq/amd-pstate.c:1018:9: note: uninitialized use occurs here
>         return ret;
>                ^~~
> 
> 2) wrong variable to store return code:
> 
> drivers/cpufreq/amd-pstate.c:963:6: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>         if (rc)
>             ^~
> drivers/cpufreq/amd-pstate.c:1019:9: note: uninitialized use occurs here
>         return ret;
>                ^~~
> drivers/cpufreq/amd-pstate.c:963:2: note: remove the 'if' if its condition is always false
>         if (rc)
>         ^~~~~~~
> 
> 3) calling amd_pstate_set_epp() in cleanup path after determining
> that it should not be called:
> 
> drivers/cpufreq/amd-pstate.c:1055:6: error: variable 'epp' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>         if (cpudata->epp_policy == cpudata->policy)
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/cpufreq/amd-pstate.c:1080:30: note: uninitialized use occurs here
>         amd_pstate_set_epp(cpudata, epp);
>                                     ^~~
> 
> All three are trivial to fix, but most likely there are additional bugs
> in this function when the error handling was not really tested.
> 
> Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks!

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 168a28bed6ee..847f5f31396d 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -940,7 +940,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
>  	struct amd_cpudata *cpudata;
>  	struct device *dev;
> -	int rc;
>  	u64 value;
>  
>  	/*
> @@ -950,7 +949,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	amd_perf_ctl_reset(policy->cpu);
>  	dev = get_cpu_device(policy->cpu);
>  	if (!dev)
> -		goto free_cpudata1;
> +		return -ENODEV;
>  
>  	cpudata = kzalloc(sizeof(*cpudata), GFP_KERNEL);
>  	if (!cpudata)
> @@ -959,8 +958,8 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	cpudata->cpu = policy->cpu;
>  	cpudata->epp_policy = 0;
>  
> -	rc = amd_pstate_init_perf(cpudata);
> -	if (rc)
> +	ret = amd_pstate_init_perf(cpudata);
> +	if (ret)
>  		goto free_cpudata1;
>  
>  	min_freq = amd_get_min_freq(cpudata);
> @@ -1076,9 +1075,9 @@ static void amd_pstate_epp_init(unsigned int cpu)
>  		value |= (u64)epp << 24;
>  	}
>  
> +	amd_pstate_set_epp(cpudata, epp);
>  skip_epp:
>  	WRITE_ONCE(cpudata->cppc_req_cached, value);
> -	amd_pstate_set_epp(cpudata, epp);
>  	cpufreq_cpu_put(policy);
>  }
>  
> -- 
> 2.39.1
> 
