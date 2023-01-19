Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F532673134
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 06:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjASFbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 00:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjASFbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 00:31:38 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602521AE;
        Wed, 18 Jan 2023 21:31:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=inMhMfjKtCvCH+bkzcRGaE5B5aUd7OkhghaliFv+hDD7/0qAVuMeQ6AUaVoWUEv3kKGtopaVtktLO2xM7j7dXtusC7gJjX+e7GAFxMWfvSwteprt6gSeVNLeRRF9UQ7GRPaNdgpDSwz2Awunx8K4ZlogaJc5PuaQZao1Xlr9Eru/eGaXPZgCTaRSjWd+cPjRDqOsR/1fayCWoyx1mfM2gJxREcAtaCdRWRkkQxaeVbqGaIe+gUEkMBIc8thA9YQ0LgbMG6VqzpMx9iH6uR7mYtpcjJGYOsz3uDCyOQRWxt4ykXpUwbXkLQgpUw1j6tOmUE8ixGsw/1DngaoWUcVR3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXHWVZwd65EtILhu/vjxr1moIK3d46OjWEf0YLmcVAg=;
 b=TFuY2kntpFKBF9Id7x7KTRlGPc0WfokWBVPeNPeGmTl2NfYX7D4eKkEPM3HTLx7uGL0Vkm+ERRtkTlHwje8JHmd4+fPsEyN+IG9DXbPmz0vaOD+FyAS6/8r69JfCN3oVrpCVLvZhu/ApgZ81hDlgKwqUvLGmhVy1LU0Un706aPVq+tUWmN9p3RlkV+HpAS9xXZAd6HVyNF/cmUbwPEqzkTch+yaFrGMutXwCkTy+CWizX7ozszH6o7YA6rUPEVn7Ts/H5KafmQoArVXVz2Bgx8S5IgePb2HHl9G5oer7yACWbbLhlI2j2WdOr1axFQtm095DF0AKpFPFyYYdpvTVOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXHWVZwd65EtILhu/vjxr1moIK3d46OjWEf0YLmcVAg=;
 b=T/grrDzj9mtooUwNzUCMj0QdfaSP/hICQeRojEMRU646yUbc6uMyh9oBdqzc0oGltsvZNXoj6miomXyTkjbF6uDv2ShUsMDh7wdrtZBq+EIZLnsmyHNOupZnjzKZco0/XFboaMynxrMMm5qSPfQVlhK04tfzZvqKQsH7iqk5QV8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by PH7PR12MB5758.namprd12.prod.outlook.com (2603:10b6:510:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 05:31:34 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863%7]) with mapi id 15.20.5986.018; Thu, 19 Jan 2023
 05:31:34 +0000
Message-ID: <59daf0e1-8148-7f5b-e1df-58c000b3a098@amd.com>
Date:   Thu, 19 Jan 2023 11:01:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v11 06/11] cpufreq: amd-pstate: implement suspend and
 resume callbacks
Content-Language: en-US
To:     Perry Yuan <perry.yuan@amd.com>
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        Mario.Limonciello@amd.com, viresh.kumar@linaro.org,
        ray.huang@amd.com
References: <20230118075210.447418-1-perry.yuan@amd.com>
 <20230118075210.447418-7-perry.yuan@amd.com>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <20230118075210.447418-7-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0139.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::24) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|PH7PR12MB5758:EE_
X-MS-Office365-Filtering-Correlation-Id: c6bef62f-7d3a-4ad8-421e-08daf9de6190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dyVeAggX6mU/Uy0ShMsJHCqZWv8JkWfDN9Aada28Rjum/903hAPDu24/5gkpbvVzhwTAwpCWRt6YlkWS6OZ+qFjLTwUoJqHAaHoWwpLdq/q6wWBbY4hDmek8jIlxrfE7qXTO7Vc7oMM93EQGk5xCaLwUSY6VAED7QQQtxSkZLK5kWFM8GU/x/nz/pqZY6F3ikCGi9ut5dQd4VitSfenZFPIydi/HVLaUSvvTE07cGKbz66+JkNNl/xw+xvLz4o3S3pSqg9SbJfQClwLsifwzxFHH/QwfiqsaFE508n/z+B8OCqy1BbEczeRtMD/z6WwZk3lYfS3aYSerfEpn+b3dsQiqSgxa/Mc/dGkkdnXY5BdXby6Jf432j82uHQuixcPGG7bIuNvePKQJQCRYtYGMA+Isc7qof1phyBCK4qgTPwW1e3n5Ss4oJUu8c9PnFhkgW7YnpATz5jgLxkHkCL4ivasJmwTm2CLIpuSGKW5d/Q4k/5Qfn6ZTjf/WVz8q2A+S7GcZAG3H2BZejVH9qOsUuNICseIfigbhvX+3ENCWDJ8TFkL3Jr1W0pT653xlp62IV+y6ts7jTyk3anAeSSzyxs1YdDD4k2cbHpsI4OTfgrSK1QiklL+pjUhRi36clQxagm3hE7pl/AWprR+Jp587wWhHH7ImiAs6iLED6Uiw5+11YzsfU2LuSC2wKi4U74OMoCXhQpkqQIxzjnvVonBhGYux1iaWGGN3nPPtJeiGhzc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199015)(31686004)(36756003)(86362001)(44832011)(66476007)(15650500001)(2906002)(66946007)(66556008)(8936002)(5660300002)(6862004)(31696002)(38100700002)(316002)(6666004)(37006003)(6636002)(53546011)(6486002)(6506007)(478600001)(8676002)(4326008)(41300700001)(186003)(83380400001)(26005)(6512007)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alp0ak9VN2pRdkk3MWtmVHhvYnpwVHRTNFdIYmFsWEZ3bkxsKyt6UEd1Rml6?=
 =?utf-8?B?RVMzaE5GOTZIZ2JqeFJlWEo0ZDdWZVNiN1lxdlBqbms4aTM0TUEzSFVXYXNr?=
 =?utf-8?B?U0RPMFMzVWdScXEwelprRjJVVE51c00zRmozay9iQVoxajJZOUdtSUNtR0JN?=
 =?utf-8?B?M214aGYxR2tGS1NOU3ZYOXNiU1U1OGZzRFF3R0NCUVJFTUg2UjNTU3Qzb21G?=
 =?utf-8?B?SnJZTFpKQ1E0blVGelR6emkrK1E5Wnc0VVNXSDJEdEdKUWNtZnZsd2tEZXVa?=
 =?utf-8?B?aDJCTTI0UnVTejV4RFdpMGtiV3BXRko0endlMkRJd3pNWTdWUGFhY1FxVnJV?=
 =?utf-8?B?dnlweEJNak1JWjNKejVhaTBUdXZTa3FubWVwRzdFa0FhNThZRDFyN0hZeDhj?=
 =?utf-8?B?QXUvWGdqU3dza2F1Um9kcnB6T2JuaERUWDdBRXJlRnFGMmJPNGl3bFNGUjRa?=
 =?utf-8?B?ZWZGQ0RMYzl6eGlyYnRxWStCanJ4amM0T1FhUVE4eHB3UVZRWkpFRm9YMC9B?=
 =?utf-8?B?Q041NytRV3c1THZnSEpPR2J0UHJtTmVPdEpod1BqM3Fyc1pwUy9FSUhlRnVv?=
 =?utf-8?B?VFFYWlFMaEhtcFVwWHRZZythUk5JdUNtMjNPMjV6bEFyVE5iNmZYMTRmeUpv?=
 =?utf-8?B?UlN5YkdDZFQ3enN5a3oyWXU2aWxVTW1scUQvWndNVDdFTUVhRzJIcG9EL01G?=
 =?utf-8?B?VkNIK3B2Y21DcERFYlpKcTBMcklVMFlrODJkRUU0Nzk2ZUVUcFZCSG9LYm1B?=
 =?utf-8?B?YXpvTzNHUUFCODZwV1RHOWY5TjBVWDRGV3o0dytDM25kWlJ1QzgzbmJUUzJr?=
 =?utf-8?B?b1RrK1EyNlBqZnFJbzFwaG5zcVhPTEhrNVZESEFNZWIzSXVlRlBNbjVGanVq?=
 =?utf-8?B?YW1BbjVFMHRlSlhIakM2Tm5jZkVXTlJDeXhsSEZmNCsvSUZqSTlJNjlYTm9o?=
 =?utf-8?B?cGhMcnUrUXQzU3lRY2NSYlN5SFR1ZnVHWldFdjVpZmpRNkY1L3Yxb2tibU94?=
 =?utf-8?B?cEZkRnFuNVppTmlDK3prZXlubWd0MTFkcTdHTHg0TWsxNW5lOUdJcnh1SEtK?=
 =?utf-8?B?U1RscmxBcWZRb3FDWVRwK2F4YUZvZ0pHL3AwNkM1NHR3NTlPcU0wM0o1Rits?=
 =?utf-8?B?NVR4UkVVbEVnanFBVDFrQXBBVWRlNmZJSE9YTXpEendSTFRaNndtZ2xtTndE?=
 =?utf-8?B?MGp6MDY3RW1nUzJNUFloN05URFk2aW13SENnMjk4dFJqWDZDQXlzUVFodUZR?=
 =?utf-8?B?a1lCNU9OU2NEUWhaMFJiMWkxcWloVVpXdlUvU3JjdkNZK21DakxuYWQxTXpM?=
 =?utf-8?B?MW5Jd2dvT1N3eXg4b2ZiOEp0VWNvWFZObFBrcWFESXAxQVFjRWZwVUh1OTJL?=
 =?utf-8?B?SUJSK1IvQTltaFE3TXNVakVNYjBTVXhkVFg4N3doWlBpcjAzTG14MFJTaW91?=
 =?utf-8?B?Z3dHcFBlMTBlTFI0WEVkb3hOdzcyaWcyRmVacWQ0Z1FRZVRnTXczVU1rU2d5?=
 =?utf-8?B?VjRGZms5M0dMNXhBVUlqcVpQL0toNjV1NlZJWmVMZjg4cGkydlNQVnkraE9m?=
 =?utf-8?B?V1F4YjdtRG1SUlVMT0xoRjN6a1hzVVUrZ2JmTzZIQU43MGEyV3ZISkp5Vkxv?=
 =?utf-8?B?elRNN0xNL3pUbzAwMnZhQmJSR3BldG1JWHpmZ0dsNjdtVUhSNVhhOVF4ZW1w?=
 =?utf-8?B?aWxkNGF0QnNtMWc4SjRDZjVzb1FURktzdGhYd25DVThQTG92dXp4U3FLVkd4?=
 =?utf-8?B?aEFRUnZwQ3FEQ3dnbnVrUFo1bURHSzFSU1UxRk0zelRHZ1NDbmF1YXJjYmtO?=
 =?utf-8?B?ai8rOFVZY25EeWNNdGVBWnlGZDB3bUUvVnJqMHlKbzF4SDBUR3BNY25BZWNJ?=
 =?utf-8?B?eURTTGdyclJlZzc2ODU0UWl1UFZ4ZUdxRlMrU0ZDaFRxc3ArSWpiTTBwWHdh?=
 =?utf-8?B?RWpVRG0xeFVpL3dSOFBrclp2WFNOa0U3RXV2c0dIVDQxa1FmZWovQUhKSEJ4?=
 =?utf-8?B?eHJNbngzR0FVMWdRVEJRc09BY2U1QnEwUU96OFIyTXFvOEJrdGRJSnFrdzMr?=
 =?utf-8?B?TU9XUkpUWi9ITm9SazJKQkt0a0tZYkhjeXp6bCtHL0MyVFBHeW42UlJSZVNt?=
 =?utf-8?Q?KdtSZyade4mz2tm+f47PDCZSv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6bef62f-7d3a-4ad8-421e-08daf9de6190
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 05:31:33.7639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EzvMfyy59cp4o6exQMigQs8D8Rl1JE32Gk9hpS3eKFQUDdxRXVxoQRQ0zCRHSKLPPiN205X8lDRp2hE2DGv7sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5758
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
> add suspend and resume support for the AMD processors by amd_pstate_epp
> driver instance.
> 
> When the CPPC is suspended, EPP driver will set EPP profile to 'power'
> profile and set max/min perf to lowest perf value.
> When resume happens, it will restore the MSR registers with
> previous cached value.
> 
> Acked-by: Huang Rui <ray.huang@amd.com>
> Tested-by: Wyes Karny <wyes.karny@amd.com>
> Reviewed-by: Mario Limonciello <Mario.Limonciello@amd.com>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>

Reviewed-by: <wyes.karny@amd.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 40 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 1472a6382b29..9e1bee060597 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1045,6 +1045,44 @@ static int amd_pstate_epp_verify_policy(struct cpufreq_policy_data *policy)
>  	return 0;
>  }
>  
> +static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	int ret;
> +
> +	/* avoid suspending when EPP is not enabled */
> +	if (cppc_state != AMD_PSTATE_ACTIVE)
> +		return 0;
> +
> +	/* set this flag to avoid setting core offline*/
> +	cpudata->suspended = true;
> +
> +	/* disable CPPC in lowlevel firmware */
> +	ret = amd_pstate_enable(false);
> +	if (ret)
> +		pr_err("failed to suspend, return %d\n", ret);
> +
> +	return 0;
> +}
> +
> +static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +
> +	if (cpudata->suspended) {
> +		mutex_lock(&amd_pstate_limits_lock);
> +
> +		/* enable amd pstate from suspend state*/
> +		amd_pstate_epp_reenable(cpudata);
> +
> +		mutex_unlock(&amd_pstate_limits_lock);
> +
> +		cpudata->suspended = false;
> +	}
> +
> +	return 0;
> +}
> +
>  static struct cpufreq_driver amd_pstate_driver = {
>  	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
>  	.verify		= amd_pstate_verify,
> @@ -1066,6 +1104,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
>  	.exit		= amd_pstate_epp_cpu_exit,
>  	.offline	= amd_pstate_epp_cpu_offline,
>  	.online		= amd_pstate_epp_cpu_online,
> +	.suspend	= amd_pstate_epp_suspend,
> +	.resume		= amd_pstate_epp_resume,
>  	.name		= "amd_pstate_epp",
>  	.attr		= amd_pstate_epp_attr,
>  };

-- 
Thanks & Regards,
Wyes
