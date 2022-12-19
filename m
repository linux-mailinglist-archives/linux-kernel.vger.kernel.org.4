Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C589D6514A4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 22:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbiLSVJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 16:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbiLSVJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 16:09:38 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71686CE25;
        Mon, 19 Dec 2022 13:09:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDGcIVZLr9qAxTKB/eWZM0qJpZhdvTSXUDuAE2WlxQYZEh5YwEVOnJFaRqVyOkLQ5QBgKcxX7DCNhoIerXPDkgpVGV6HzfePqkGoP871y7s3pa6e8oQfqkbHHPZeyw3l+Gj8iB4LTcEgR/Tg6heF4dumtLnPjpgJEdEnxH3spns9vj5vwyCTB5f9s2B1DkSA/qp3DGRzPEraN1Nzq4KDnrHrc8JqtI2l5N1aEbZXq7lo6ck+HmR7BClnNhvooYhy4JTBOMD+sFLsIYatBAHLLQict0CPWqdk4lOKOOW5CjYBjGqe74K47R90LPu1N/hrUAOG5/JQ22uUMYEjbuQsKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50AXk9ab+HdQufkcW6XD7PM0EvpC5t2fRMwOd17C+nQ=;
 b=ZHMWbyDneXzP8k2x2ARtpWMoglNdexAmewVWOWvQzvU2cGPxnwItKdt0ZxvewT3TrzTg32LZEX/VRNNIHnyAU0d04nASmz7a2qE9YrVkresj4eAqDbsf+sTcQQ789ZdSjSPN5RwJJof5m9FRW8/NdVAG8ohG2OAESaD0JlgKFczp+iRESwFrKqSpeeaOuEbNDGLmLTvukhDb8C9EG7UsZrUxWLxUeABl4A5IRqHN4T+pf+bJGUVUMqw3e0f9gjnomiCHpiIdqB+iJaRxUm7dGp1K6Mgk5Rpsre8iynGG6nQad6ibdreba1YUZZ5QYEWu5QB2h3auTXazj75FtJiOIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50AXk9ab+HdQufkcW6XD7PM0EvpC5t2fRMwOd17C+nQ=;
 b=bRV0cjduYPS4JjCT2pHeeV7LLos+RDHlFQiNDGVIKlwTSSNaLK/fudfTxw/GUSaBq2uqiNGXFE2daJjcrusKauZB2q/Iy4cCplsYMeTR3GmrTkNhJr69itfgSSi3GkLZJVUGEm9W22Vx1t2ci4I5Oea0Br+o3TrI6Zt/5IbgNa4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA0PR12MB4493.namprd12.prod.outlook.com (2603:10b6:806:72::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 21:09:35 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%4]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 21:09:35 +0000
Message-ID: <1ea5aa50-c02a-022e-644c-38add49ed07a@amd.com>
Date:   Mon, 19 Dec 2022 15:09:32 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v8 01/13] ACPI: CPPC: Add AMD pstate energy performance
 preference cppc control
Content-Language: en-US
To:     Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, wyes.karny@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221219064042.661122-1-perry.yuan@amd.com>
 <20221219064042.661122-2-perry.yuan@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221219064042.661122-2-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0025.prod.exchangelabs.com
 (2603:10b6:207:18::38) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA0PR12MB4493:EE_
X-MS-Office365-Filtering-Correlation-Id: dec7ef66-1c7c-4faa-e647-08dae20554de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MhMWcuKoCiHPmn9efXBDXwVCtB/SkDXhQhdCRGsfqBqRc+LPimfzOsEHB4aM3O/f5+DhAZa/Qa+pX3cuk8t6eYBW7UtZvPW3TljjOWobvHTdd+KGt58VTLYBc7uNVv7v5cQpjI53RXEY1jmvrqKKOhov6ECtCJC6ngoNN+pT/NsjCwxOlSsoSf0HSgR+Hj2I9HN1aSSrbJ91rp9pcL6wfQ+b83WoTgxx9ko5gP1wIjWUwgRkSK8yokBYbepSc2feGzBr29MM4k+c7rdyVlAQxHOW7j3tRuBz4AKZs82LUYH7JO1b4XVzExnByVVhhtF8gFbIN9hWZaO1wSwjqTvf9pNcHL3OL8E890W3J/CLF2r5r4RCxVtOAM0eySFKuDtug8DSYjoop4rm8KxgitHxLgMDPGC/D7uMBU27jH4tOvy+IIH8HYPKqhCDfnbBojdFKUsHcfJtcXyOCN7M1+vDlrHthNgMc0Bo+VytMwuljMff/qPk45siX8n11CAeDin1roVCgwx5W2sAZZ/xJCqn4HUEEHeP+B5FOL0yrMWbkK2ooBuQPZ7AMIL7D+CyoDT35QVs5aTJwgk6T5cHiH3T0//xNB2J8m9weCn7ghNF/PN/7cXxEkis/IONxUCuPDfvwPNdq0G2zZOLdlx2ws5oeEl2ECnA02JUkJwnda/gxFj73DTxa/2nbjB82JqQHuzZUx5xuBr7gOfd17ajrEIUlWw+JS6/43Iyfvpd5tbG9Ak=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199015)(53546011)(4326008)(8936002)(66476007)(8676002)(5660300002)(31686004)(66556008)(66946007)(6506007)(41300700001)(36756003)(2906002)(316002)(86362001)(31696002)(38100700002)(6666004)(478600001)(6486002)(6512007)(186003)(26005)(83380400001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WG0rNVhVaTFvYk50aDF2M3MxOGdyU3pnRlBmVkFCRUk1NXArSnJNcFJabVRE?=
 =?utf-8?B?ZGFBWVdyd2tJd2xVSmVBQzBrTHhxeFdyeDFrZC9pbmJpQ0FyUnVhenhWM1c3?=
 =?utf-8?B?RDBQMDg0dCt2THB2VCsydnVURXg0c3dwZzIrUnhRNDNHRDhrWEd1cjIyWHc3?=
 =?utf-8?B?b0t5eVNJcWZLQld2cXlBc0orUkVPY3pkeEN6THBqVWN1dytTbmNROWhGL1E5?=
 =?utf-8?B?R2pYT2Q3clBvZ3RlNFM1d1BrVHNRdnFST1pLL2pRT1dYYzhqSEtpUkJ0ZEda?=
 =?utf-8?B?bTQ4cFl1aWcrZUNyNjJFZUg0bXJWT0o5S2lURUhKNFE2bGZydENSL2x1VjVO?=
 =?utf-8?B?VVJ0YjNRTmppS2lCaUVxVDdwTEJSaUVWZlRzd0ZaNlBNYzFTVjVIeXJ1T2Y4?=
 =?utf-8?B?dDRTTjJBc1NMZjBIODhwYmN1QW01c3hzUXV6amFxMWlYSWRNZDkvUHhVcmVZ?=
 =?utf-8?B?MHBSVWJUK3NBZS9DMCtGcmpSSlJnS1lqZTNGN2dtNkVTQlBWL1dDVW1Gblor?=
 =?utf-8?B?ZGlYc3Nnd244cUVKdnpNQ3ZMeHNDWFoxUFZoVHBPOTZqTXJCdUF6QUtYd1dK?=
 =?utf-8?B?eVpxR2JQVmlvK3VOaGl2Ukp3bm5ScEVzYkdDZDc0OUl5eGRHWC9KU2twZkNW?=
 =?utf-8?B?ck8wOXRlcHRCNlpJZ0Fha3dZSkI1NVcvNlVsVzYxNWNVbDRVazBzelFheEZS?=
 =?utf-8?B?bm01SDZJclNoWldzbmx4L2YvTlBrdVNzaUtaUW5kSUw2QkFpWVNrbUd1Njg4?=
 =?utf-8?B?MG5OaFBJNm4wR0Y5UVFLYTRaQ1A1T0kwV0FDNDlKeURrckpwc2NBN1oxUzdh?=
 =?utf-8?B?SVdrbVVYTTN1RlVqTXcyemk5OFp4ZEdETVFLcytvcXo4bk1ldHh6ajFESklH?=
 =?utf-8?B?RExVZjJxZGxhL1VGVTBZZW4vazBYaVpTUTM1dHVQTlR5VGJLM1hUeTJ3S1Vm?=
 =?utf-8?B?UjNYTHpDSXZ5VmZwYVBxUGRmNGI2eVIvSUpCWDA4NkJDQkxIcFd1dWZacThx?=
 =?utf-8?B?a0h6bVFZZVlQT0U3QnBLd0Q4Vyt6VndYbWNIWnZtd1FGL2U0RTJDYmxrRTdK?=
 =?utf-8?B?dEs3V3B1MEVYaFFjaDZTR1dIb0FhZkpqYkRSbW5JRVR3NUxXT2doblNyUDlT?=
 =?utf-8?B?alBKQStMb3dnOHlOUWtkQ1RPcndEMGlPSml6UEU2R2JIWmpZa2ZMcklheXMx?=
 =?utf-8?B?bnU3UEdoQndySm9iL1ZBaWh2SFUwSXhnT3dJNkdTaTRvaXYxTHdPenpid0wy?=
 =?utf-8?B?ZFNqOHBqWjJlZjJueU5wWGh1UGdCbDNkTkFJNm9LMDJ1Wmw3T1NhTVhEWTNp?=
 =?utf-8?B?aHhQVHJKeU94VllKVFNscERjUWhkalE2Tkh3Sjc0M3l5R0MvbUc1UWRwRWRN?=
 =?utf-8?B?Y3p0YzZHc1Rvd3lneGlRM2VrKzduYTZvYjF6MjhxN25Mc2FzQ0NuKzZkbW5O?=
 =?utf-8?B?R0hReTdnWkR6MFNtU0xHb0xuZW5pOURJM0hVc2pxYjQzLzc2c0l1elhEMmx5?=
 =?utf-8?B?RUVpS2t2YW1yYm45R1FLMktyRERkR1dINzlsZWlaVmU0ZGFZQTZwVEtaZWVV?=
 =?utf-8?B?K3hHTDdiN2t2YTJsMjYwRTFNTkNtd2xjTmhTSzBrWUExNUVZS3UwVzkxY1ZT?=
 =?utf-8?B?VEYyOTlUekZ0T2RPTExCQ3FWRGFoRGNrRVVNc2FMOWIybWRrQkpUOVNMVE9o?=
 =?utf-8?B?TERRT2lydWhjWnRlaytQRmZ3RVRUNXBya05pRnJSN3dEKzBvb2JyT2pTclpZ?=
 =?utf-8?B?UHl4VjlKK1JGUmhJSURyQmVDZkU3QkRVNGNzNDBKcVpmNU5KT1ZqRHJ0bUFC?=
 =?utf-8?B?Y3E4WkNzUW9RV1NRT0xMTmNJU2dqNytINkNZUFB4UFZXbEFyc0o0MnVrU3hx?=
 =?utf-8?B?RVd0WXpzcUlpeXh5MklaRzd4TTRrRTFlZ2trbklmaGpCZy84UHh6WURoVEZD?=
 =?utf-8?B?QWZuVFJORlora1gvU3NDS1R1NTFob0dWYitBS1M5dklvYy9xVnJMVlRiMWph?=
 =?utf-8?B?Ym10VlpLNFF4anY5SGErR0RKZnBhanBtb210a1JqN0VvTnpsTE9aVkc4QUp0?=
 =?utf-8?B?Vy9QQWNWYXFUSy9QTmtkcUQvSmdTVWNkbnpGL0ZoYzh6U2piTzRXa2ltTmIw?=
 =?utf-8?Q?+B2UAM12TXEJ6RUIWnMkKFAiV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dec7ef66-1c7c-4faa-e647-08dae20554de
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 21:09:35.4047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YGCOi9mnaLzGH+MDm2mnAgUbDM3PrTXehhfbnwM6Hp9Mrvd4w357rFxqozC9lvXzXfWqCveWIbPJhHY9Omyyyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4493
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For this patch there's a few small nits you should fix for v9.
With those fixed:

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

On 12/19/2022 00:40, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> Add support for setting and querying EPP preferences to the generic
> CPPC driver.  This enables downstream drivers such as amd-pstate to discover
> and use these values

Missing a period here at end of the sentence.

> 
> Downstream drivers that want to use the new symbols cppc_get_epp_caps
> and cppc_set_epp_perf for querying and setting EPP preferences will need
> to call cppc_set_epp_perf to enable the EPP function firstly.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>   drivers/acpi/cppc_acpi.c | 76 +++++++++++++++++++++++++++++++++++++---
>   include/acpi/cppc_acpi.h | 12 +++++++
>   2 files changed, 83 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 093675b1a1ff..81081eb899ea 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1093,6 +1093,9 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
>   {
>   	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
>   	struct cpc_register_resource *reg;
> +	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
> +	struct cppc_pcc_data *pcc_ss_data = NULL;
> +	int ret = -EINVAL;
>   
>   	if (!cpc_desc) {
>   		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
> @@ -1102,10 +1105,6 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
>   	reg = &cpc_desc->cpc_regs[reg_idx];
>   
>   	if (CPC_IN_PCC(reg)) {
> -		int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
> -		struct cppc_pcc_data *pcc_ss_data = NULL;
> -		int ret = 0;
> -
>   		if (pcc_ss_id < 0)
>   			return -EIO;
>   
> @@ -1125,7 +1124,7 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
>   
>   	cpc_read(cpunum, reg, perf);
>   
> -	return 0;
> +	return ret;
>   }
>   
>   /**
> @@ -1153,6 +1152,19 @@ int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
>   	return cppc_get_perf(cpunum, NOMINAL_PERF, nominal_perf);
>   }
>   
> +/**
> + * cppc_get_epp_perf - Get the epp register value.
> + * @cpunum: CPU from which to get epp preference value.
> + * @epp_perf: Return address.
> + *
> + * Return: 0 for success, -EIO otherwise.
> + */
> +int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
> +{
> +	return cppc_get_perf(cpunum, ENERGY_PERF, epp_perf);
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_epp_perf);
> +
>   /**
>    * cppc_get_perf_caps - Get a CPU's performance capabilities.
>    * @cpunum: CPU from which to get capabilities info.
> @@ -1365,6 +1377,60 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
>   }
>   EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
>   
> +/*
> + * Set Energy Performance Preference Register value through
> + * Performance Controls Interface
> + */
> +int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
> +{
> +	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
> +	struct cpc_register_resource *epp_set_reg;
> +	struct cpc_register_resource *auto_sel_reg;
> +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> +	struct cppc_pcc_data *pcc_ss_data = NULL;
> +	int ret = -EINVAL;

AFAICT, you don't actually ever return -EINVAL in this function.
I think you should just avoid initializing this variable.

> +
> +	if (!cpc_desc) {
> +		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
> +		return -ENODEV;
> +	}
> +
> +	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
> +	epp_set_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
> +
> +	if (CPC_IN_PCC(epp_set_reg) || CPC_IN_PCC(auto_sel_reg)) {
> +		if (pcc_ss_id < 0) {
> +			pr_debug("Invalid pcc_ss_id\n");

Would it perhaps be useful to note the cpu # for this message?

> +			return -ENODEV;
> +		}
> +
> +		if (CPC_SUPPORTED(auto_sel_reg)) {
> +			ret = cpc_write(cpu, auto_sel_reg, enable);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		if (CPC_SUPPORTED(epp_set_reg)) {
> +			ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		pcc_ss_data = pcc_data[pcc_ss_id];
> +
> +		down_write(&pcc_ss_data->pcc_lock);
> +		/* after writing CPC, transfer the ownership of PCC to platform */
> +		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
> +		up_write(&pcc_ss_data->pcc_lock);
> +	} else {
> +		ret = -ENOTSUPP;
> +		pr_debug("_CPC in PCC is not supported\n");
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
> +
>   /**
>    * cppc_set_enable - Set to enable CPPC on the processor by writing the
>    * Continuous Performance Control package EnableRegister field.
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index c5614444031f..6b487a5bd638 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -108,12 +108,14 @@ struct cppc_perf_caps {
>   	u32 lowest_nonlinear_perf;
>   	u32 lowest_freq;
>   	u32 nominal_freq;
> +	u32 energy_perf;
>   };
>   
>   struct cppc_perf_ctrls {
>   	u32 max_perf;
>   	u32 min_perf;
>   	u32 desired_perf;
> +	u32 energy_perf;
>   };
>   
>   struct cppc_perf_fb_ctrs {
> @@ -149,6 +151,8 @@ extern bool cpc_ffh_supported(void);
>   extern bool cpc_supported_by_cpu(void);
>   extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
>   extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
> +extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
> +extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
>   #else /* !CONFIG_ACPI_CPPC_LIB */
>   static inline int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
>   {
> @@ -202,6 +206,14 @@ static inline int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
>   {
>   	return -ENOTSUPP;
>   }
> +static inline int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
> +{
> +	return -ENOTSUPP;
> +}
> +static inline int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
> +{
> +	return -ENOTSUPP;
> +}
>   #endif /* !CONFIG_ACPI_CPPC_LIB */
>   
>   #endif /* _CPPC_ACPI_H*/

