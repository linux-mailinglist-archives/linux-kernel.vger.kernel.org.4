Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C99067312D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 06:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjASF2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 00:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjASF17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 00:27:59 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354A11AE;
        Wed, 18 Jan 2023 21:27:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNuT6xYg5YwcUMsP8Zjso05sn3r2VzhsqjxizLm5Yf9Ef+R7QAP8oXwwKHEnrEclPfDvZ6G/oZLQjYII+Uxmvcl7rgLnZKKmlSO36rYDq98xlbnHR7CoLh7MBpQAq7lhjBf5WrxAoGxzYRykF2L6qZVlD696wtIt1Ss0FrGblsfFeWlrjla1yO8l11qVIZ6bwykO0EwST+VxlPmfVbmNJcGZLdbjwdJ1XBkAC1EIQss1sfkioeKsWmye8ng6NUgMzF/EWNhcsZlqxSuju1NbI4CTnjtx8xg8sUbLvLysALc0NgxGg7rL0yico7vjufmJAKetyH84nVRaBlIH2q8tYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qk2VqymRXBTVDlEUJoYUhFrvNFDS5Gw66SoJHNVM+sQ=;
 b=FCXvKl8sLGC0U/WHNoVtzg3nttq8Znamp59mAoKYeDej7uwyqyyQurWyXBfSRstigD5ZKQHIzdE+LBYElAVhkPkgTxiOVGA+rVzY3Ebw/nvL+Qdfz+xq39cmRAZRP39go80OSqcg7MSgyZDi8rwuexLEbjjbazu2bcln9fDAJ3uwPZfb3nXl//Q92fTJbCg6kJmHfhr4DAJVfo9VSev/u/sjnljM0zBPuIubClI8C7bjIUb3Atk8nFBlcfzdqiD5n5JbdpAo8GINhl+DbDoa92XcQoIIN9sJaDN/4NrsIYu934DxXjAbPeoYfMo2ZOMotRY25Y1AOb94HmKO9dADHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qk2VqymRXBTVDlEUJoYUhFrvNFDS5Gw66SoJHNVM+sQ=;
 b=I0COcN7PgvLgNmmwA6sn5uQo8AhmZ3+QtPn6h0otOPe5S2UQm9cHZccMs7f1MTMCsoSGM8tVpXiUIbxyf1eVbRaYZwXjp8jbcuYa6nfVkzB7HFvkyWGIlEffyC+I6Y8t1E3JmmepQVxGEDvIQof0EdaobbIUrvQIUOp7k5v2IzI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by PH7PR12MB5758.namprd12.prod.outlook.com (2603:10b6:510:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 05:27:56 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863%7]) with mapi id 15.20.5986.018; Thu, 19 Jan 2023
 05:27:56 +0000
Message-ID: <50040e9d-0d8a-e101-1332-542c7b564c99@amd.com>
Date:   Thu, 19 Jan 2023 10:57:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v11 05/11] cpufreq: amd-pstate: implement amd pstate cpu
 online and offline callback
Content-Language: en-US
To:     Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
        Mario.Limonciello@amd.com, ray.huang@amd.com,
        viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230118075210.447418-1-perry.yuan@amd.com>
 <20230118075210.447418-6-perry.yuan@amd.com>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <20230118075210.447418-6-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::22) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|PH7PR12MB5758:EE_
X-MS-Office365-Filtering-Correlation-Id: bc69ed97-630b-4d05-7664-08daf9ddeb54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l00dgt5A8Cx3dft6EgnuHaJE7y3ZI+pv+WcePwL4fjGUyNSimRKfYFgqTDyTcCo0XvtadPP2ZRry9isCHsMPCOV1GeLwurww1cmTpt5R8QbFg4UpP7656/E2fscxbNNHrzris+BUBkw/8DOvt3SYHGuEuSstiwb8fk+FE9EotWbB+dABYx6mo8ehq6YrZA+1u7GUAJgz3itNNqTWRXqhXJ7DvnO4eY/6kTcyWiir9xeq7jM2+rvzsgeUi75/h8ytHaqzEmjNCZuiKoeebOVygIwR7dPxiNSAf+Y13zKGSxz2OaRt4QnbZvj0o2EGwQWBGroVclnimH9gG6vJOy2qjFrS23Tfa62hop/qlA5aXeToCQtqACZ4watNaNeJlqk2R89hXLYDiwcqkESHfW/+QlddfRLc2MY6Hc7Vo0U1xta4htb+JQVw5C1gEvH0yjVFll2gA1YYLqhypKpsPIdPNKnVVPYjTtIU/a28Kmh6q6fpGEa9rWOYlKJK7zIJygH5ARcWIqAQneRfGeLMSAYj9lFfbAJCuhzaBWXT3JH9j3SCGf4M8eHsjA5vLE3EB3daqzAyPlwqSERo2jLGx0e1MlyEaYeYQctU8XyNOEbhxkYQTwrNhRuJwc5y+d5bFrTY9lyfunh9Ra1CGbW5W/mfU6dg84sbpJt/8l/WO59EY5BuFk1d46h/TARwzEOVy5TREPNPy8QPduJ1cJoSbuhEyisyfqmx/m5Jh0e1xlgZoVQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199015)(31686004)(36756003)(86362001)(44832011)(66476007)(2906002)(66946007)(66556008)(8936002)(5660300002)(31696002)(38100700002)(316002)(6666004)(53546011)(6486002)(6506007)(478600001)(8676002)(4326008)(41300700001)(186003)(83380400001)(26005)(6512007)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkRIdHlRRGN6VVdoUXgvRnZXS1FFZ0tSUUpERnNmakxLWVpBQSs1TGl5UHZO?=
 =?utf-8?B?QTlWY3IveDJjT2NGOFcrZXNuRlFBYnpYOVRKUjlPelBzbU04OEY3UnJ6QWpy?=
 =?utf-8?B?aEw2TXpmOFd1MVZtUnhHTWJSVTNOVzdnNFFyaWVaeERNcStBeXdiZmFaU0lV?=
 =?utf-8?B?eFBreUlnTjN6M3QyckhuZHorWStWUVZ2N1Jwc0swOXc3MzJZaXpmRHV1Zisw?=
 =?utf-8?B?R1NTN2ZZZFRZTjRqejcyRUQ3TEtNZWttR0tOZFl2ek55bTRZSHFRVkR0d2ZR?=
 =?utf-8?B?cXZCRjVvUC9EOHFqd2V1Z1RiNVdKR203T1N1TUtaRFdicDJ3eTJpYUVzOUlT?=
 =?utf-8?B?c2ZHNlRSTHBVemxONEJKeTJ6U1ZSc2dteUxFOXNuRVdremo3WThHNk1WVGZX?=
 =?utf-8?B?VDhqNC9nRTdkRlJITk14cXREWFdMQTE0WEM2VTJaVEdDUXlaUjJ5aTVsRFlx?=
 =?utf-8?B?SVA5UFU3TWhqMW9qTGNIcGFkMWh4cTJwdUI4aEIvT0R2K001RnpDRjUyeXRY?=
 =?utf-8?B?djZ1L2czbWN5RmRzVk0yYkJ5MW81TENaMU1mVExMYm5Bb0R0ZWtzcnNDeEs3?=
 =?utf-8?B?Ujh3OFF6aVdGVC9mczlIS0pYa1pZcDhidTM4SXpHQzZDVXNQSmc2WXd3aGNw?=
 =?utf-8?B?WEtqSWZJcUt4TldHTTVaZkZjMEtoK0IxcnQrN3I5RTZaK3BEenl6WEEwOWVF?=
 =?utf-8?B?OVI1SnUwOE9zRmZVdDFVMmpCZFoxUWdQbEdPRXNRWXFrSjBoRWVtYW9JRk03?=
 =?utf-8?B?RTlEeG05OEt4VDBsSUhNYjViMFhGSmYzbERHemlHUnhVRkthYVRsYjdjTHBy?=
 =?utf-8?B?UjJXMGZxWWpGR3dHVThWR2cvaStPeEQwRkpyYndmZXNkWmhrUVBYUG9YK3hG?=
 =?utf-8?B?UEpZbnBMc2NuY2R5L3BwWHYraGYxWVVpTVBWT3RtNGpHU3ZrTUUvWlExdjl0?=
 =?utf-8?B?U2pjT2d4Ny9DWGtzSzc1RFBGYWJGWng4am1kREdubGxjTk5MVFFDWGNkb3hj?=
 =?utf-8?B?U2hPNDdidDNWZDN3NnFCTDNZaTFmZFFjYk4zREVVcnhTTFl3OVlRcGUvcnE1?=
 =?utf-8?B?Y2RVMG5GTmtFYS9XajduUGFPTlVDYytGU2Y5TW5iRmxMWW1ZVFFsakdobnE0?=
 =?utf-8?B?cXdoMkpkR1FPMDRUYmVHWkZiQk9HbHZYYyt3VnptSTZkTjJUUDFkWmt4Skpq?=
 =?utf-8?B?Z3ArcHMxNkd6SGxUSWpINXVZVkVta0lqejl1OEFVM2IwRkhQUkpFcitFbzQ0?=
 =?utf-8?B?MG5rZDVHZjJCTWMzK1ByYmNtZFUvaEpHVFBTcU1COHdmNzFtall2azZ6M1RL?=
 =?utf-8?B?WlU2UUZ6VU9MaUdxSEdxeXdyRGxuR0NvKzhzM0JvNTl2ZHUrUXdtU3V1WkNJ?=
 =?utf-8?B?cFAwekhZMysrMmQraHFOSVBkRmZyR0dzWmxSblpqT1FIdVgwNUxaZzFYMWQr?=
 =?utf-8?B?bmlRYzFxQXh0RTcva3VrN2Q2QkFpKytmSEYxMGhOQk84RG5iRG9ra2RidjBp?=
 =?utf-8?B?ZUtUQTFySTR5Q25SbjRvcVVydGNMcXRXV0hFaWVTc0d3WlltdjZ6MlJIRWhk?=
 =?utf-8?B?REVVYXZROVVDNHNJaURYV1ZpRk0yeEdxM2RlUzI5OWVibHNuaWVPMEc3ZkZS?=
 =?utf-8?B?RzN5cEdTTWx4clpVUDdzUnBnTjdNbkxDdE1YQVN6WG5pNjFQOFNSN3UraXNw?=
 =?utf-8?B?NFIzYzhaYjRFS2tJa3o4aW53dG1zZ0dzR1o4K3UrdmV2QklxR0hSc0xNMllR?=
 =?utf-8?B?R05yWXNKVHg2djlhK2hRZkFQWDRYTFAwa3BRWG83TXFtTDUyRkszR3kyNktv?=
 =?utf-8?B?TTRvUUZSMjJMUGNmTVNmQTA5bWV4emQyWmhta2FvK3BsQnVXQkNsREM2dkp3?=
 =?utf-8?B?eStldTMzb3l5SFVZRVl2b01mT2FhNEMxVFV1c0hmbSs4SnJadUlralB0dGVW?=
 =?utf-8?B?TDJaK1dFV25YQ2Jod2N2VXFFU3NJRjNQSmh3STE5K0IrZDU2WUtkZmdGeXBu?=
 =?utf-8?B?T01kZFJRTTlrNG12cWRaZDAwSmhIcUpWMW9GTlovUHhOWTVGcU9tYytSZ2dv?=
 =?utf-8?B?RmhtTEdmOTZPODZCRndKeFFSNzFuck1iRDdwSUkveWwvbEI2K2F1TlhzUTFm?=
 =?utf-8?Q?7f0IXEYD7mG2Xs/lahJevw97K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc69ed97-630b-4d05-7664-08daf9ddeb54
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 05:27:56.0584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFpAzpP9Ksp7rLdhiVGjg9xs7I2YqIQan4nHzY1Vu5fBbiit32xHRh8PIPLxAzuviExgn+O4Z3kkn4C9W3lblQ==
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
> Adds online and offline driver callback support to allow cpu cores go
> offline and help to restore the previous working states when core goes
> back online later for EPP driver mode.
> 
> Acked-by: Huang Rui <ray.huang@amd.com>
> Tested-by: Wyes Karny <wyes.karny@amd.com>
> Reviewed-by: Mario Limonciello <Mario.Limonciello@amd.com>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 82 ++++++++++++++++++++++++++++++++++++
>  include/linux/amd-pstate.h   |  1 +
>  2 files changed, 83 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 2109ad3fdd42..1472a6382b29 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -958,6 +958,86 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>  	return 0;
>  }
>  
> +static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
> +{
> +	struct cppc_perf_ctrls perf_ctrls;
> +	u64 value, max_perf;
> +	int ret;
> +
> +	ret = amd_pstate_enable(true);
> +	if (ret)
> +		pr_err("failed to enable amd pstate during resume, return %d\n", ret);
> +
> +	value = READ_ONCE(cpudata->cppc_req_cached);
> +	max_perf = READ_ONCE(cpudata->highest_perf);
> +
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
> +	} else {
> +		perf_ctrls.max_perf = max_perf;
> +		perf_ctrls.energy_perf = AMD_CPPC_ENERGY_PERF_PREF(cpudata->epp_cached);
> +		cppc_set_perf(cpudata->cpu, &perf_ctrls);
> +	}
> +}
> +
> +static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +
> +	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
> +
> +	if (cppc_state == AMD_PSTATE_ACTIVE) {
> +		amd_pstate_epp_reenable(cpudata);
> +		cpudata->suspended = false;
> +	}
> +
> +	return 0;
> +}
> +
> +static void amd_pstate_epp_offline(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	struct cppc_perf_ctrls perf_ctrls;
> +	int min_perf;
> +	u64 value;
> +
> +	min_perf = READ_ONCE(cpudata->lowest_perf);
> +	value = READ_ONCE(cpudata->cppc_req_cached);
> +
> +	mutex_lock(&amd_pstate_limits_lock);
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		cpudata->epp_policy = CPUFREQ_POLICY_UNKNOWN;
> +
> +		/* Set max perf same as min perf */
> +		value &= ~AMD_CPPC_MAX_PERF(~0L);
> +		value |= AMD_CPPC_MAX_PERF(min_perf);
> +		value &= ~AMD_CPPC_MIN_PERF(~0L);
> +		value |= AMD_CPPC_MIN_PERF(min_perf);
> +		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
> +	} else {
> +		perf_ctrls.desired_perf = 0;
> +		perf_ctrls.max_perf = min_perf;
> +		perf_ctrls.energy_perf = AMD_CPPC_ENERGY_PERF_PREF(HWP_EPP_BALANCE_POWERSAVE);
> +		cppc_set_perf(cpudata->cpu, &perf_ctrls);
> +	}
> +	mutex_unlock(&amd_pstate_limits_lock);
> +}
> +
> +static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +
> +	pr_debug("AMD CPU Core %d going offline\n", cpudata->cpu);
> +
> +	if (cpudata->suspended)
> +		return 0;
> +
> +	if (cppc_state == AMD_PSTATE_ACTIVE)
> +		amd_pstate_epp_offline(policy);

Should we call `amd_pstate_enable(false)` here?

With this:
Reviewed-by: Wyes Karny <wyes.karny@amd.com>

> +
> +	return 0;
> +}
> +
>  static int amd_pstate_epp_verify_policy(struct cpufreq_policy_data *policy)
>  {
>  	cpufreq_verify_within_cpu_limits(policy);
> @@ -984,6 +1064,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
>  	.setpolicy	= amd_pstate_epp_set_policy,
>  	.init		= amd_pstate_epp_cpu_init,
>  	.exit		= amd_pstate_epp_cpu_exit,
> +	.offline	= amd_pstate_epp_cpu_offline,
> +	.online		= amd_pstate_epp_cpu_online,
>  	.name		= "amd_pstate_epp",
>  	.attr		= amd_pstate_epp_attr,
>  };
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index 9bfdabd9d930..e9e291b7c2f9 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -82,6 +82,7 @@ struct amd_cpudata {
>  	s16	epp_cached;
>  	u32	policy;
>  	u64	cppc_cap1_cached;
> +	bool	suspended;
>  };
>  
>  /*

-- 
Thanks & Regards,
Wyes
