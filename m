Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D1E65E51C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 06:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjAEFbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 00:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjAEFba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 00:31:30 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D92C37240;
        Wed,  4 Jan 2023 21:31:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSOGmjSTX11QYEQRYlSB/bStImgImzTI0Xv50qc5YljfbeAhuDLd7fnFiH52+jqDozD9mCFG0TqY7Cbuk6Yiqg1UTCWIKZuHIkAe8wmlnU5Md8/E5iuIDpdLriUJSEC6yqVqTop48gPyMdM0S+66+6yDLTEcSUQXsS9sieW3lxSbMREXioSTNwz0lQiCq76PRiJgAYUiCrq0H7Hw5lrPIeN1SwB0LQ+51BuURVAXCPszYyM+t3jrYNvRIOpm0Un3UeQA/tGPXVAUObpb3AwTzHEinaFTBJRDFt6MdN6mChp2bn5rguA9DAKRJ2S2g3K7Nt0Li45E/orD/8N8v1sAYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rLBcIQqJHMkgb74Onnii+M/9wHy8gxJcKLZMd9Ms/A=;
 b=cdjXUtMv9ztPr6DkKYs4gTY5yDTkwdoW7pputhyLZoW4uaiUMlDtW0jIxxTCniDCKrcxbXwQNQ9RN8jqoyRv+PryQw4VXj1pRWz2fy1Z31kv7Iuu5QjKrjZHqhGGr61QTQ9Ocz/dXfcNlxrUV2eOIzQIsuXa5m95EeL8H/2LCa/fZqhCh7oEzWDTXabC7Z+MUH/qfIr4Irs8PAbZN3df+Dl+zn0y2LkqHdMfnI+ZdKfbfsN5NGUUo37fa7GWTyrDqaAWtV9aFDt+n4zYtImTvNx8Z90dfKiS+iZtt3E+LkHAEzZgdfRO1rjW/lcrYw+s5UfMKiA94ev3zOExATHymg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rLBcIQqJHMkgb74Onnii+M/9wHy8gxJcKLZMd9Ms/A=;
 b=W0tBy5m73v+mxJ4uTnFVmPc18qQNGhsYWv3597f2oxeB7Xix5cCWIpJI3YPoUYkBiaP5/87iftdU/TR4Nrx9vhcnUE23APBYs8aoMEdAH3mB7jKcfvjAH5Yjtf1RIn6hVOMos9DVkX/2ychVYuaj9FjLPTpKk1wSgfwVuaVmTL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by DM4PR12MB5262.namprd12.prod.outlook.com (2603:10b6:5:399::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 05:31:27 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::45ef:724b:4b64:b98]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::45ef:724b:4b64:b98%3]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 05:31:27 +0000
Message-ID: <f274aef5-88f4-2f46-e2f7-b8581e38cac2@amd.com>
Date:   Thu, 5 Jan 2023 11:01:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v9 01/13] ACPI: CPPC: Add AMD pstate energy performance
 preference cppc control
Content-Language: en-US
To:     Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
        Mario.Limonciello@amd.com, ray.huang@amd.com,
        viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221225163442.2205660-1-perry.yuan@amd.com>
 <20221225163442.2205660-2-perry.yuan@amd.com>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <20221225163442.2205660-2-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0240.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::17) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|DM4PR12MB5262:EE_
X-MS-Office365-Filtering-Correlation-Id: 03af23a6-d3cb-493a-39f0-08daeede1765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j3ZEaNiZGR1DhH6tFNrU58YvNiIQzQeJ1WR8imAFtC4FEU8posJHpK9DPxgYasa40I8uKAEUnxRtS6FsJJgdX3DYcdquQ+rD95HaurGIhJ38anwobh5S+WOBxN8VGF+bZ0chcqq5J6TOU3oDzFuA3UmhV0h9IxR9JW4eKjUXdLmKxg1jbHSTyVoL2TwCaJuEenRDimaUnKVy9ofo7iOT3r6T/1y65PUhnykbyBJ7SyWrXJ5jnPndS9S1S/surwGlt78Q22IR2gYQ4SeK/pS3+n4A14ZEiesGxkkqNq3706T+4P0tyWFXo3m4PMVaEmmLOyNdovdmUby9FKzf65UiAM+E3l+rUg3HCmC+FDvRvtlCYKW017Dd7PoViGHl99a9X4UOCl7UdFmJ72UQG3sSyJMb7Oqqcgu7QjhAawXOrU6IW7clndC0Qlxah7Jr11XXBnSbrdzcgFRcpOauHLcp4bt/q0P1rLIsBbyJSEcQ3ZYMmYyTLh9MqUjI9Mj4ooDxafYwLsw4kaErdmvO98YPH/qtc1s7CMfb7IccV13jJGlgBkYRA8SJ6ZN2oWsPnv85uSAdojq7wolmJdfpli6ZyqkBORkH586HimVqgIeqTzLphouE703HzKa61pTymjuFYbjWYnLfkGhXPa3uXfGHcuyk4enjQ116PW9TMWgbqP7XNXNgHqljgMVgASL/ostb1ugMtFK/3xKdIsNkQis2R7qNa4suRIQIa+mvT+H4+jI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199015)(6512007)(26005)(83380400001)(186003)(2616005)(86362001)(31696002)(36756003)(44832011)(38100700002)(316002)(31686004)(2906002)(8676002)(41300700001)(8936002)(66556008)(66946007)(5660300002)(4326008)(66476007)(6666004)(478600001)(6486002)(53546011)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjNUVDdEYVRpRjVOZk9ueVozRXh1RjFUMjQzQXMrL2lIam9sRWxpeUs2Y1Q5?=
 =?utf-8?B?dTlPN09NNWlFODgxeC9QU1RCT3VWaW42dStyZE1rcjBNZExqTXlKVkdIRWor?=
 =?utf-8?B?cUFUNHFpSzM0WW5jTk9OQjB1OWlkaFJZVnZnWFd3blZ0bmE4RDhxN3djcUNj?=
 =?utf-8?B?RjJ6UkhQVnloZjE4RE8vanlLcmlMTTFnemlpdmczVUxVbDdTL3E4N09sbGhE?=
 =?utf-8?B?K29qVGV6VytwNXBIMnVCZ3BXWnZrU0t1eHFrMnAramNnNU9hR1JQOWh3QXRF?=
 =?utf-8?B?bDBianBiUGljbzZPTVZwM1lxVWJaWFU2T203WHRPWDlmSDJheXNnTjJraVJ0?=
 =?utf-8?B?cGNDS1gwNU1MN3ZTbEExazBjN05WVHpxMHRRMDZCdjNKbVYwdWh2SkpoTGY2?=
 =?utf-8?B?dVBYZUJBOFl6UmtTb0pjQkJsNTBzejNVbCtLZ09MZzhSTDJSMldwdXpMWDY0?=
 =?utf-8?B?ZVVlaTdOWUtjZ3dQNFhSVFNkR1Nvc05YNjR0ZDc2eFBmWDFna1oxY3crZk8x?=
 =?utf-8?B?WFBwZmZ5VGVjeTJoTTdqWTdIUTRpRFhnSHAycU1Fd3dHYnVYeXlnVDdDL3JR?=
 =?utf-8?B?QVJjUC8rd2ZPSWcxOElLYnhSVGVURnJRM3JRWjF1cDIvRmU4OWFjWXlnM0Zk?=
 =?utf-8?B?QVBKV3I4SnQyS2U1djg4SmtibDhJUkg2RXVMQ2xpVjYrQTc1RXFpRWxrTDdE?=
 =?utf-8?B?T2x1aERxVzNSY2tUaDVsMTIvYjZpSzI5aVBUTE9qMXZ6dFNDOThvZE96eVZI?=
 =?utf-8?B?TE0rUkVaaDJpNkxtelNKQzdJOVJBQnR5dXNjVmNRNzdyVFFvaENoWXZOY3hs?=
 =?utf-8?B?aUEzVGdnU0xlZVNQc1Awejd4K05FOXRPcldKdzE3QUFLcmRGdC84MTVlZW5N?=
 =?utf-8?B?NWVVT0NpZCsxOURjemVFRzZvTXdteVhjQ05PdnhXVGF1RnFmazZjei9IWFd0?=
 =?utf-8?B?am1IUlF1QU5TMEtOaEd1RkZpWW5lK3ZDcnZ2aWxnWG1ReDUrc3p6UGVlU0tI?=
 =?utf-8?B?TkVJd05ST0ppcmE3akQvclVjREtYS2FTdFhKQlEyalRCdU1sUDhxZGpEM3g3?=
 =?utf-8?B?c2djU0lIcHpZMVlWMlFhaDhvODd3V1gzMHUzOEhoTGhobUwzbmg4R2orRW8v?=
 =?utf-8?B?Q2pKMENETWxZOWU0RFNWbEZ6bUFoeFNtc2VTSXNiWnJGR0hMVmtZdHBMK21U?=
 =?utf-8?B?NGJJalVJc0lteHVJUW5aZU5zcWRpN1RjQ1Bkbjh6U1Y1V0N5NzFjaExUdnkz?=
 =?utf-8?B?Q29NTUN5TnRRd2FqeGxhZzQ2MXUzNEJUdGkybHBVRkJPNDF6SHBJcjAyUjB5?=
 =?utf-8?B?RkViY3lyTkdPYUd5OHNmQWtVVHRBVHJuY2dnTEhjOHNwN2VBMWdXcEZuRHNy?=
 =?utf-8?B?ek1iblRnMG40aDY0Sm91clFlKzZxYlA4c1hGdXRqaGlxczJsUWczaE9XRmJz?=
 =?utf-8?B?Q05FV015L3hNL2tnb3RTaStkTVpxQlNlOWlQdEY4UUlwZTB6SWsxQ2FHZ1lT?=
 =?utf-8?B?NWllT2dsTWVKeDE1WWNZRkJ0enhjVnhDVE9UbFFRd1JYT3VmTzVMUnRiT3lv?=
 =?utf-8?B?VFdocUdyNlJJN0lubUFXbFREOHN6OS9YV2pPWU90U2h6eWE2R1d1YldNSTB6?=
 =?utf-8?B?MmZnelFmaGtkZFU5ZURlcktLSmFDU0xwZkdUYkdMaFR0MUdPTnBrZy9YWC9N?=
 =?utf-8?B?bkcvZTRLMHNYOFlYRVl4U1Jzd0t0MDJHWnpuVnl4SVJncUs1eGd2V0ZzWDlq?=
 =?utf-8?B?amQvY21UMjhRS1pZM1U4NnBucERpNXFRMkYwbDJYc0lJV0RRbXZVNnplK1lC?=
 =?utf-8?B?WFNUSXlmRnlCMFNYWi9MZVFDT05QVERkSkNNQVZvNDJpUzFWWVUvazB5OGxB?=
 =?utf-8?B?S3hJcEFrb0s2ODBQRnZ2UzlYbWJMMWNZeDlLcFhGczBLc3k3YlJZallHZTUz?=
 =?utf-8?B?eG93dmppM0U2ZjNNMks5Y1VoWHQrNlVoK25MT2JVOExDai9VSzc1MnBnWXcr?=
 =?utf-8?B?QjBwVXdnSGNDM2F3RkdXWnRWRnRqT0VjZC91dG14Zkh2RERIZnBJOTlMUkFD?=
 =?utf-8?B?WUtsWWEyNkdROS91cSt0eEJjNjhkbDJsc1dzU2hMa2IxSnRBT1RIZnYwZ0pq?=
 =?utf-8?Q?rpGyBl+2Jt97cKCNEsH5Pfwbp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03af23a6-d3cb-493a-39f0-08daeede1765
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 05:31:27.2444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ek63kPaeecbpxILFuEqvm/nUoRRYus/BdkNRdMIoAwfv0uofQEFRCJJuzR9Pot8azQOvdeLDsj1ie9DIlPZrIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5262
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/25/2022 10:04 PM, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> Add support for setting and querying EPP preferences to the generic
> CPPC driver.  This enables downstream drivers such as amd-pstate to discover
> and use these values.
> 
> Downstream drivers that want to use the new symbols cppc_get_epp_caps
> and cppc_set_epp_perf for querying and setting EPP preferences will need
> to call cppc_set_epp_perf to enable the EPP function firstly.
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>

Reviewed-by: Wyes Karny <wyes.karny@amd.com>

> ---
>  drivers/acpi/cppc_acpi.c | 67 ++++++++++++++++++++++++++++++++++++++++
>  include/acpi/cppc_acpi.h | 12 +++++++
>  2 files changed, 79 insertions(+)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 093675b1a1ff..0ce6c55a76ca 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1153,6 +1153,19 @@ int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
>  	return cppc_get_perf(cpunum, NOMINAL_PERF, nominal_perf);
>  }
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
>  /**
>   * cppc_get_perf_caps - Get a CPU's performance capabilities.
>   * @cpunum: CPU from which to get capabilities info.
> @@ -1365,6 +1378,60 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
>  }
>  EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
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
> +	int ret;
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
> +			pr_debug("Invalid pcc_ss_id for CPU:%d\n", cpu);
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
>  /**
>   * cppc_set_enable - Set to enable CPPC on the processor by writing the
>   * Continuous Performance Control package EnableRegister field.
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index c5614444031f..6b487a5bd638 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -108,12 +108,14 @@ struct cppc_perf_caps {
>  	u32 lowest_nonlinear_perf;
>  	u32 lowest_freq;
>  	u32 nominal_freq;
> +	u32 energy_perf;
>  };
>  
>  struct cppc_perf_ctrls {
>  	u32 max_perf;
>  	u32 min_perf;
>  	u32 desired_perf;
> +	u32 energy_perf;
>  };
>  
>  struct cppc_perf_fb_ctrs {
> @@ -149,6 +151,8 @@ extern bool cpc_ffh_supported(void);
>  extern bool cpc_supported_by_cpu(void);
>  extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
>  extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
> +extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
> +extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
>  #else /* !CONFIG_ACPI_CPPC_LIB */
>  static inline int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
>  {
> @@ -202,6 +206,14 @@ static inline int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
>  {
>  	return -ENOTSUPP;
>  }
> +static inline int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
> +{
> +	return -ENOTSUPP;
> +}
> +static inline int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
> +{
> +	return -ENOTSUPP;
> +}
>  #endif /* !CONFIG_ACPI_CPPC_LIB */
>  
>  #endif /* _CPPC_ACPI_H*/

-- 
Thanks & Regards,
Wyes
