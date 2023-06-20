Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3CE736F85
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjFTO7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbjFTO72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:59:28 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20603.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::603])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8AB1726;
        Tue, 20 Jun 2023 07:59:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8qgPVdC/KjcKuNOfwH2omVDcZ6nGVOpKcWxBkMkNdqDUHJSG1O2z6ZN/Jq5ZfDjqSHxuRFjrTLl90JxzpXgLrsNxJANg2DjRca2B7cE6vBeCgWA6rIbX/bLNRlryIuvM6euKvQviAPGfRJIMZzzrZejiVJAg1HC+DwFplcEBKv4ns8O9L/oc6gtLgHh0upcaD/n6IfZAzzoStGQ7q4gSkGspTNWEybAEhNRRTDaERh5QLeYNtiKxKfFxMrmjtnl9Tk+7jg1v5X2suG4GdY6UuRpnR2adLTW0b/LuMBwo+gMhrYLisM2nLgs+aly6mPteeH3/5rhWHGXii1WhnWuNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lizlpu8P4g8KuBHEdxlGL67hc7WVqL8KK93wawM1BAU=;
 b=WlxCjC+ZsL7UUo6yaUcaZ+6qGfAdfK0teVFyD/FtXO5gKz330NdFLh17e0f14g7Joa1UtaeG1XCh9nGMxiNWoveFziYqSOexKgFKsj6X1+88L27d11n1TYH4hI3UaIR5GeTcKbifXXH+FLPS8pw7UfhM7vSF1Y/p0OI3/u8CadqAZTRqNmmo0/jaI5IYK61Fz/hISxQjAD0qrhCxbFpgW+TsBWq7FDo3mdztBFg/J/2KB8Snuu3+iGcnveVzVLa4iYYHqJQ41lT8jDSzcDE3ABrs6EJ3MIMyo6mIZAbzLmVsDred0j2GMYAvlrXYxZgiSrqAsmjsmQd769K2cVdHqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lizlpu8P4g8KuBHEdxlGL67hc7WVqL8KK93wawM1BAU=;
 b=VdNJk1JrUytCWmuBrdYDpZpTxT3QCzxCKPhM+zFuIIFXH7IsOzf5/7uCHbF+XGEU1OZZeoMKm0BmgYMmMcOzjSPamhglwcgd+he0QkraVKUs2t0BS7rrcBUaDrGpJk6QijoeM7M7r9B1Dy97zTgxqdl3QCeT46DX0a336tO17f0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 SJ2PR12MB7963.namprd12.prod.outlook.com (2603:10b6:a03:4c1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.37; Tue, 20 Jun 2023 14:58:39 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8a7:d4dc:7ac8:9017]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8a7:d4dc:7ac8:9017%5]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 14:58:39 +0000
Date:   Tue, 20 Jun 2023 22:58:14 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] cpufreq: amd-pstate: Set a fallback policy based
 on preferred_profile
Message-ID: <ZJG+Xhun1Ltw9ox/@amd.com>
References: <20230615063225.4029929-1-perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615063225.4029929-1-perry.yuan@amd.com>
X-ClientProxiedBy: SG2PR06CA0204.apcprd06.prod.outlook.com (2603:1096:4:1::36)
 To DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|SJ2PR12MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: 0680caab-c8f8-4506-d11c-08db719ed4da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /hgTTP6Me6xQW/F2xwrVxtE+4K+ER1JhFTvZwrrWAheo/Nys4JPGKyxzMxk5MkQsonfyvLbLb0PRoiHicZCGgNn/az3542qJNMHFdw2BMNPe+W7GeU6Ly/FiWuBEoWF43Rxi4OTXmbMfWAoOe3EKPI1hmUAKDuAv6MCBlATIU2rf/A/9cU+Ssi4Os4yTkn3cjbWH6T8+P4rq90Fje6ebi3etLRu39pELCmqzLcqPXeavW3C7zqj+D5bW5UDxUUrhKnxK2ece46xdrhvInHXTqlRO1UjKtkM8z0B6EBOuBE5XX2vnx8acJYY5ggO+qlOOvb7zcdXO5L1XnahU/FQaUs+q87hSHb7M97DXczO+8mqHHtpmgru+Dl5Uvt/XBUxUr4+8rUl0pYUZQsxiXgChzGk1eaOHFA028Q/mhf2Bx9B2HUObYALqS4EyippoHi2Rwf9nbhrNh2acu2Gb8BOKTnf/jnIAJyWQ8ELTlMIepLkRAiwOlNqQ9XESG5GV3A7L17x1gndVRlj9dlKRxdb5vfpJ2k8ebHWhSgTTbzpr15g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199021)(37006003)(54906003)(186003)(966005)(6666004)(6486002)(86362001)(26005)(6506007)(478600001)(6512007)(2616005)(38100700002)(316002)(83380400001)(66946007)(66476007)(66556008)(6636002)(4326008)(5660300002)(41300700001)(6862004)(8936002)(8676002)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?54n1QVrsK+i31x03jEeKsKGBCASLxiM1u3x+Ldxv/L8efYcWdOhHo1OcahWC?=
 =?us-ascii?Q?PopuzIDKNigLCftdSJ/XKxDMwofTD34JqNu5gcPGBd7pbW3Ak74fT0cE6aFT?=
 =?us-ascii?Q?4y4yNyCwk+kvVBzyQmR2FUgssIWIYOZ51kjdHky91yXbW1M/kQI/Q+GdGRUP?=
 =?us-ascii?Q?4Mn1f9okATJWzNOW9y73uvUAFAQL/16/NcNkrMvCa8WOnM3/F8ChlEQtJNnX?=
 =?us-ascii?Q?kFtlWJinztFmgZccU2UVHInldWNbv3jchzlAi511kT68wHiZpr2nyTyjVfks?=
 =?us-ascii?Q?gPZoxyHz5bjxiSbHm5ApubL28wBStrOlinhtylRvMZcR8mG44i8m/DjkfHmi?=
 =?us-ascii?Q?kGpkP9WBAfKweUlZlrVI0WlTLzT4dW3CHbnT8A1CE5AsNBBRZUGoN0slBI61?=
 =?us-ascii?Q?jo+IQrGIDbV0ekvZ9+/V9CEp+xQ+FOFg0D4qHOm5rrBc0R6rV0gIVJGEaKK9?=
 =?us-ascii?Q?C1SrYqmfCwNp86Lmr4USonZs/K3I11A4QIqY65q+nODsS1TVqcYTUQNk3aWg?=
 =?us-ascii?Q?VYlw2PXc8FvZ0plSvm1KAQqkctDT4pdnAnhmgtc7mp0xPrM9zzMC6WL2/wmG?=
 =?us-ascii?Q?ek+kLn5nUM+qqQDbAGFUf65MD/LFWJ3CUdznaHdaecPGpnaYC8KjbqVMw5/n?=
 =?us-ascii?Q?EBehqlCvnWaJBUQr4lJ8FJqJf0kfMChP7OEu+7M/SZE+nJwHIFviFbW6jO1d?=
 =?us-ascii?Q?7/twq/NGhqjA1wH6v9DmQQRmvu64pSi5uUIzy6Df37JogGMZ4WoT8VNwagxK?=
 =?us-ascii?Q?7FQh/vPbEUiRfuSTwqDGYgt+KG61EGjPaisCvn7F0FYhSoQ13YvRYHlVnziX?=
 =?us-ascii?Q?k044+ykYgSNwgep/OS8BfYIDs4wJe82HyIPL5vixc1PZ6Myhkpvi8Zl4ynBQ?=
 =?us-ascii?Q?vgZ3O56O078HNF5Cffh7gFRlz8WvHWQNQxg4M6QQOzbZD9Lsb4UF4i1FBEDs?=
 =?us-ascii?Q?nh+EEIj0isYYKCI/S6/Wdz1GR4qLwjdBYaVjAI8VyNWWcomLIRR3XatbvMNt?=
 =?us-ascii?Q?W9Z0JZI8KUxPdY3bCCNlwjLiYPxiC57fssEc627+815ikvgnS1nI0jLNGS5K?=
 =?us-ascii?Q?V83JrT9eXQ22ch3kRqdJ3t6aEfaJjaoBXAOKgK2wnCRQh1rU+CNGlNOjd5GF?=
 =?us-ascii?Q?+ggde4s+CyOK3XuquGMXWh56awiemEB78QBt+zk3Ke8hYgv2E6q0D/MQUK4Y?=
 =?us-ascii?Q?xjZDzOxY7u7Q6OFCXkhy0MgXGhVKeMUeIfyXA6YEVLgBUwb6lim//mZUHEnT?=
 =?us-ascii?Q?QwAcmIyrqyyh+DLdO9y46VaZ5kFSo/9yt1N+t6TxZKkHxhfjNThuPEnYjAMV?=
 =?us-ascii?Q?teAFR6evX3OQWbkZRGLlp+egzwx6YKqrcv06TDhQ5VIyYARG038WcFFnmi1o?=
 =?us-ascii?Q?BjoGXozvwBRFVmPtR3wBURvCkvX0cRpX3uOr9xsRyhcnq4Wmw71lKyK9ykym?=
 =?us-ascii?Q?z75/82QhxMIwXlh7+rZIZWuX7UqpHOvyF31V1mRI3At2DWkbVGHyQNwiutgv?=
 =?us-ascii?Q?+p0J7rl6SmQQD4KJtGbJHu/LDqdzaXXkVf+ntg1+xxgooKPMMNKShScJxmEk?=
 =?us-ascii?Q?ABNHG3u/6GYuZj0uUwYk8oA3QTV2ufrnJLUVpHk4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0680caab-c8f8-4506-d11c-08db719ed4da
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 14:58:39.4716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YRmxv6gMy/STHfurq0Cv3ucbtH3apUARGWnv4Cr3VUPcTCNCdCOrqkC+OyjTDQ1fSrq1YtA0jevQSZKWb4+Z/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7963
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 02:32:25PM +0800, Yuan, Perry wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> If a user's configuration doesn't explicitly specify the cpufreq
> scaling governor then the code currently explicitly falls back to
> 'powersave'. This default is fine for notebooks and desktops, but

May I know if the processor is powerful desktop such as threadripper,
whether it will be default to 'performance' or 'powersave'?

Thanks,
Ray

> servers and undefined machines should default to 'performance'.
> 
> Look at the 'preferred_profile' field from the FADT to set this
> policy accordingly.
> 
> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/05_ACPI_Software_Programming_Model/ACPI_Software_Programming_Model.html#fixed-acpi-description-table-fadt
> Suggested-by: Wyes Karny <Wyes.Karny@amd.com>
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index ddd346a239e0..c9d296ebf81e 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1102,10 +1102,13 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	policy->max = policy->cpuinfo.max_freq;
>  
>  	/*
> -	 * Set the policy to powersave to provide a valid fallback value in case
> +	 * Set the policy to provide a valid fallback value in case
>  	 * the default cpufreq governor is neither powersave nor performance.
>  	 */
> -	policy->policy = CPUFREQ_POLICY_POWERSAVE;
> +	if (acpi_pm_profile_server() || acpi_pm_profile_undefined())
> +		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
> +	else
> +		policy->policy = CPUFREQ_POLICY_POWERSAVE;
>  
>  	if (boot_cpu_has(X86_FEATURE_CPPC)) {
>  		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
> -- 
> 2.34.1
> 
