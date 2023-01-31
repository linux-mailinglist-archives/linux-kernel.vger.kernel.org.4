Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC92682E49
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbjAaNpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbjAaNpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:45:35 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AAF269F;
        Tue, 31 Jan 2023 05:45:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITB6hgLkZFfgdtfSy/LMjXv69VrPt8FDt1v+lx6lnKUrZYGHz0JgG6CTHqZm3Rdd6bVtzctG3GVvxMXUGbwZi/EwwBxvWn0uJpryQLMFH/MZyrt7hjW5HY2UVoHmH3me9HzkN36+H9xR13dPeBZvBn/VUP/IXwjtgNyQbJuIAfWkJD08RfGE6lxt6SayKJU4IkfYfMLh5mnsjs3dGpxvU615hv7YGIrt0i8FxxUkvhqhy0zg9BC+3Zccpl2oVQWeah1B9ge9b5nNj8gN32x521x5dnxPMdY/HuEMx25adAOE1hSkYHgkXOoP96/qad5uI4J1AWKq3Ai4Kp/XEM77MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nccBz8KxqZozH7rewRRfIA7ohOl0tqXWxI9KsrmD1ls=;
 b=i0z/rZOd5SL/SPRoOThO2FiZ0stcGZ1SeAlB8RkApsbXF0xbYNnMNVeOaS95QkQVNc/aGSF2693zifDK0BJRkPy/JwQ32xzWC8SUINTZnYFe//FZdSijQpc/Qr0Fosd5o3hNUGdTt7xpF3u71i8QBjfGdEukQz01ASwjPMN3OSL91HxcVSg9kv0XFm6FZzV39KArgO7SnHBRL4uOEUWbxWqAAOslHZEkJ+6cE2VMACo2BXvP8wSV2KBzcMmnf3emP1G9E+Ao4eLDb1wXRYYLtDd7mdkKINn0H8V25Gqmw5OsJyVUgq9G59U/rISrufjJxLjEAdGGacmHTGQmySd+dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nccBz8KxqZozH7rewRRfIA7ohOl0tqXWxI9KsrmD1ls=;
 b=lDLVwdwcKcehviZtaebJrOGqYd8UUVySzYKowawIVihseSUfi3lYcsQWDD5wtcaC2g5uPw12Cap7sBOKi+MNxm0fsNv9ovjC56+7ABVpK5zEsZ9UVOsErg4nQnqzNoZgta4IzR96ni1xJnp7L3NzG9u94hxUETXb5u8OZ1XyMlY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH0PR12MB5281.namprd12.prod.outlook.com (2603:10b6:610:d4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 13:45:31 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%7]) with mapi id 15.20.6043.036; Tue, 31 Jan 2023
 13:45:30 +0000
Message-ID: <661a55c4-5703-ef84-728a-229997737416@amd.com>
Date:   Tue, 31 Jan 2023 07:45:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4 5/6] cpufreq: amd_pstate: Add guided mode control
 support via sysfs
Content-Language: en-US
To:     Wyes Karny <wyes.karny@amd.com>,
        Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>, Perry.Yuan@amd.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        santosh.shukla@amd.com, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Ananth Narayan <ananth.narayan@amd.com>,
        gautham.shenoy@amd.com, Tor Vic <torvic9@mailbox.org>
References: <20230131052141.96475-1-wyes.karny@amd.com>
 <20230131052141.96475-6-wyes.karny@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230131052141.96475-6-wyes.karny@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0016.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::8) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH0PR12MB5281:EE_
X-MS-Office365-Filtering-Correlation-Id: 20300c41-d4f5-42bb-0b9e-08db03916ad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ri5Aq0rscDRaIUwdt9BLKtiQzU5VXNVQzotIPF+5Q6Tg0VY2jf7xGALY7OPEUltEFvDOH3IQR3Kq3HSCi/Vnolfh4V/s78jQEyNEiHMVhYldsRXzbbY8yVvh9yDXIuNq0SeQwmad1Au1uJ7cQ1jBf4xv4mblVGqwOd/HlJxFJQKZYtG0bEo2lyMR4mg8LNAQlFpiwog/MCwKoGhn/V+RrX+L9ZouWxYO4w03qkhwgcp5zD3ayBMARKA7EcG6xwhI/Cd/R+6vWEEQQ59FGMnreMXauD1qeEkTpf2sq5wHx1VryY/apCsLPqOZ715j6unKycXCj/u6/pROdCBvE7jOvdR/p9FoaKXjNRH5gHq2bMC71xHX+hySSXCw1T52biV7QhtZdOTRHKjcjU50oB+usVB2yb/cc7WRb3VJlZev0Yr1p6NmngxrDJUwbbBJ0QZrZuDdJj+1b+Dskj3M9bPFl97d0kvPM1y60sSHjHDRIAXtUrJa+jehKpE6289r/UKiUcE9+vg8f2mDba+gslBAwKJfw70jR3OxMEbrwEOQfs2ZXcSAIHlgSB5OAYwcyC0ON9wUX100HigP487NfbOYJa0f790rhVi9RcEjdhKOLEFFkvlluGY4kYHlQzbBS+XjekeF3lwC1XYQ8UEUkjMNrfuQWd1A7iszT6ohzBgRP8WaqHaljliRnwljWYcrWSYeb2TIT13PRNfXJ6cze7xl4vVdldwFVIRg/T6Uw4fTQuw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(451199018)(8676002)(66556008)(66476007)(66946007)(2616005)(83380400001)(316002)(6636002)(110136005)(6506007)(478600001)(6666004)(6486002)(53546011)(54906003)(6512007)(186003)(36756003)(38100700002)(86362001)(31686004)(7416002)(2906002)(44832011)(31696002)(4326008)(5660300002)(8936002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzZwemhSdVU3NXY5RTNkSE84ajUyMzRJOTlHRGNsYldYLzNSVjFCVTNabktS?=
 =?utf-8?B?QzhmVDdqUWd0Ykk3NmtLVEYrVG1aL2VlalNNb0l0cUNHYjA3UFBrYy9FeHRw?=
 =?utf-8?B?RE5WeUs4SWZiVGhoUFNRemVNMjRtNWUxSnRiMkJNMUtiL0k0Q0wrRVdKVHJo?=
 =?utf-8?B?TXVIRHEzTHZOZUhOTUZkNEZ1NE1WWDFENlZsM3pkN2FwbWNFWi9kQnpUTmVU?=
 =?utf-8?B?bUNzYXZxWHdzWUdyRk1BV3ZiMTV4U25selZvZUs2dUJ4azFKWk1qbDg2b1Zw?=
 =?utf-8?B?VW81cnR3czkxVDF5KzluRnBBcWgwK0NNNzFEaFBNYmxYcUZacEM0N1F4d0FB?=
 =?utf-8?B?MnQ5cXl6M2NBV1RQT1R6bnkvWUlLdGtGbDJib29xd3ovNWxjclRQa3JKWXBC?=
 =?utf-8?B?aFNSeUNCNFE1UkZJaGlYRlJFTUFNZXh4K2taeTRqaVZnTWllb3VnQ0FhMUVh?=
 =?utf-8?B?VWRZVS9FUDBlL1VLRERBSEZDMDQ2S2IwcTJCemlWMHJXQStrZUJpY0RmeWQx?=
 =?utf-8?B?QjZYMWNPZ0ZvUHVyU0dKNlRDcjNvdDgrRVc2bjdBbnlmUzBJMGtjM2ZxTVI1?=
 =?utf-8?B?Qm9OaEIrc3ZmMDlrZkxobEFyeXhlMlZSUE43ckNFelo5L1ZXbTVKNlZYbTF2?=
 =?utf-8?B?WStPbmt5MmVNN0RQRWZDTmlSNTFTUkE0Zms0ZEltd1VBSHhSeGRINVpqUGRF?=
 =?utf-8?B?VHN1c0lzaDNqZUt4SEhEZGNOY2MxWm1LcmVUMzhJd3E3Sm5XODc5OXJqOEVh?=
 =?utf-8?B?TkJWeHEyQjAxZS93S3AwMkl6QXJIbkZYNEd2dnJKZmpjc2lKZ3dUNTgwdGZ4?=
 =?utf-8?B?MHZiZm91Wks0emZ4NTNPUHB0M1lVL0JTcHNNbHNBUk44eW53Y2RBa0Zidjh3?=
 =?utf-8?B?cm4wUlEzMmJ3b2FldDRGSTlGY1hhS3pHaitza0JLb0dJS2pKclB0Q2hoekNo?=
 =?utf-8?B?TGxrZUMvZHdtWWFOOTJhbVhTNDNuUURNZUg5R1BJcnd0OW5tYmxNVDFmNFhU?=
 =?utf-8?B?a2p0alBuaExzUysyRDZReHZHSzdRWUhhTE0rMzNQSDNlZ1UzSW5MQ0xxaXVw?=
 =?utf-8?B?WitGMkoremsvN2FlZ3NCKzdOcXYyMlRFdTJXY0w1VkZ1dHo5OGFJSFg2bUly?=
 =?utf-8?B?UHBZcm15Q0ljL2dzMkYzVHRkWERVWk03MkVtbUoyWGdWaHJ6QWJoRVdpcU4z?=
 =?utf-8?B?Y0R1bjVPL1hqdS9zQldzcVd0MEZ0M3ZMbGZOZVAxdlhGblk1b2FleEdvbGkx?=
 =?utf-8?B?akk2ZkxuVzlSaHV5VUlTRWRsdXlyeldwY3hPcDJsOFY1OFIyc2Y5VGVZbjNI?=
 =?utf-8?B?NEMyWVhYQllSaWIrWHRmZkFsVldrQldtRHRVdHBScVNTMXlPd1ArUVFvaUlu?=
 =?utf-8?B?b3dUekE5UmpZRnFnZDhFMjhseFVZWjNSZjNtY2NzendOV0pMU1d4ak5oTUhl?=
 =?utf-8?B?eWNpRzBKcDJSR1FuMVNPK3hoR0dINFpRV3VmVlBvSHlVb1hoVHhZekdZQTA4?=
 =?utf-8?B?aHNUdEtKWWtIZ3VuWXhidWozc0p5eTNYalhYYjREMWhFRUt1bUlwdkJrN1FO?=
 =?utf-8?B?MlBkc0xBSGRMZkdYWGkrMHNjZHc0cUx2M09IZzZSR211MHFXZlBCVTQ1cVRH?=
 =?utf-8?B?N1EvUG1lc21ub2VEcnFTSlRIMVNzR0JVYjdNNHhZZ3dXcmQwTjdFQy9NV2lY?=
 =?utf-8?B?SWdveFhQR013NUc5QXMrR2U5OFRoamcxN2JJRGovVTRSbG10RG9VMXN6ZXZZ?=
 =?utf-8?B?M2dvY1JLeExRVnpiZldna2VoRy9UendBaHIwaTg2VSs2N3B4WFYvd1hJN2da?=
 =?utf-8?B?dHZuR2x2N28yeTJGajJiV3RBa1BlLytYeXRiWnpDNEl0WnJ4c1hLQVNhUWtB?=
 =?utf-8?B?WjdzK1d6VmNqYm1kSDZESnhLcUNpdG4yZUltenJCVDBTSFRSNDZMQmdaUytT?=
 =?utf-8?B?bk9aVnJnM0I4dlVLMU5uaDcvYjhWakRLbDkxcjNNV2NuZm1ObHF4bDV6ZzZq?=
 =?utf-8?B?NC8zbWtRSUN3YTh6Q3VzMXZqWEMzeHlXeGNrdXVRZGMvTDlGaThzQWZmN1Rn?=
 =?utf-8?B?NFdpZHpMbmtXT0RHclRDRVdTaEFvWTJCbmh6ejEvTGljVGo1MXNERFVCM1J3?=
 =?utf-8?B?cmVURmk1ZFRlQ3Y2enJaMEl6bU9JQzdrNU55Z0Z2RE5jNHkwMWdNM1crTTg1?=
 =?utf-8?Q?41RXwyt/9U6xzJz/rftLl7IUwzTZX5vg1C6+60sz49Lo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20300c41-d4f5-42bb-0b9e-08db03916ad3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 13:45:30.2124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yNdgBAfv6pw1zMQka+rdggjQudtK4u+QLzjJpbtNjyWohoynHPVVwvag/PocDudWPuwxQVTkuJMmFjiIr1plGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5281
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/23 23:21, Wyes Karny wrote:
> amd_pstate driver's `status` sysfs entry helps to control the driver's
> mode dynamically by user. After the addition of guided mode the
> combinations of mode transitions have been increased (16 combinations).
> Therefore optimise the amd_pstate_update_status function by implementing
> a state transition table.
> 
> There are 4 states amd_pstate supports, namely: 'disable', 'passive',
> 'active', and 'guided'.  The transition from any state to any other
> state is possible after this change. Only if the state requested matches
> with the current state then -EBUSY value is returned.

I realized this after I finished reviewing doc patch, but you probably 
want to explain -EBUSY return code in documentation patch too.

> 
> Sysfs interface:
> 
> To disable amd_pstate driver:
>   # echo disable > /sys/devices/system/cpu/amd_pstate/status
> 
> To enable passive mode:
>   # echo passive > /sys/devices/system/cpu/amd_pstate/status
> 
> To change mode to active:
>   # echo active > /sys/devices/system/cpu/amd_pstate/status
> 
> To change mode to guided:
>   # echo guided > /sys/devices/system/cpu/amd_pstate/status
> 
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 150 +++++++++++++++++++++++++----------
>   1 file changed, 108 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 48ab4684c3a5..6c522dec6967 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -65,6 +65,8 @@ static struct cpufreq_driver amd_pstate_epp_driver;
>   static int cppc_state = AMD_PSTATE_DISABLE;
>   struct kobject *amd_pstate_kobj;
>   
> +typedef int (*cppc_mode_transition_fn)(int);
> +
>   static inline int get_mode_idx_from_str(const char *str, size_t size)
>   {
>   	int i;
> @@ -797,6 +799,105 @@ static ssize_t show_energy_performance_preference(
>   	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
>   }
>   
> +static void amd_pstate_driver_cleanup(void)
> +{
> +	amd_pstate_enable(false);
> +	cppc_state = AMD_PSTATE_DISABLE;
> +	current_pstate_driver = NULL;
> +}
> +
> +static int amd_pstate_register_driver(int mode)
> +{
> +	int ret;
> +
> +	if (mode == AMD_PSTATE_PASSIVE || mode == AMD_PSTATE_GUIDED)
> +		current_pstate_driver = &amd_pstate_driver;
> +	else if (mode == AMD_PSTATE_ACTIVE)
> +		current_pstate_driver = &amd_pstate_epp_driver;
> +	else
> +		return -EINVAL;
> +
> +	cppc_state = mode;
> +	ret = cpufreq_register_driver(current_pstate_driver);
> +	if (ret) {
> +		amd_pstate_driver_cleanup();
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +static int amd_pstate_unregister_driver(int dummy)
> +{
> +	int ret;
> +
> +	ret = cpufreq_unregister_driver(current_pstate_driver);
> +
> +	if (ret)
> +		return ret;
> +
> +	amd_pstate_driver_cleanup();
> +	return 0;
> +}
> +
> +static int amd_pstate_change_mode_without_dvr_change(int mode)
> +{
> +	int cpu = 0;
> +
> +	cppc_state = mode;
> +
> +	if (boot_cpu_has(X86_FEATURE_CPPC) || cppc_state == AMD_PSTATE_ACTIVE)
> +		return 0;
> +
> +	for_each_present_cpu(cpu) {
> +		cppc_set_auto_sel(cpu, (cppc_state == AMD_PSTATE_PASSIVE) ? 0 : 1);
> +	}
> +
> +	return 0;
> +}
> +
> +static int amd_pstate_change_driver_mode(int mode)
> +{
> +	int ret;
> +
> +	ret = amd_pstate_unregister_driver(0);
> +	if (ret)
> +		return ret;
> +
> +	ret = amd_pstate_register_driver(mode);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +/* Mode transition table */

This seems to be a pointless comment to me.

> +cppc_mode_transition_fn mode_state_machine[AMD_PSTATE_MAX][AMD_PSTATE_MAX] = {
> +	[AMD_PSTATE_DISABLE]         = {
> +		[AMD_PSTATE_DISABLE]     = NULL,
> +		[AMD_PSTATE_PASSIVE]     = amd_pstate_register_driver,
> +		[AMD_PSTATE_ACTIVE]      = amd_pstate_register_driver,
> +		[AMD_PSTATE_GUIDED]      = amd_pstate_register_driver,
> +	},
> +	[AMD_PSTATE_PASSIVE]         = {
> +		[AMD_PSTATE_DISABLE]     = amd_pstate_unregister_driver,
> +		[AMD_PSTATE_PASSIVE]     = NULL,
> +		[AMD_PSTATE_ACTIVE]      = amd_pstate_change_driver_mode,
> +		[AMD_PSTATE_GUIDED]      = amd_pstate_change_mode_without_dvr_change,
> +	},
> +	[AMD_PSTATE_ACTIVE]          = {
> +		[AMD_PSTATE_DISABLE]     = amd_pstate_unregister_driver,
> +		[AMD_PSTATE_PASSIVE]     = amd_pstate_change_driver_mode,
> +		[AMD_PSTATE_ACTIVE]      = NULL,
> +		[AMD_PSTATE_GUIDED]      = amd_pstate_change_driver_mode,
> +	},
> +	[AMD_PSTATE_GUIDED]          = {
> +		[AMD_PSTATE_DISABLE]     = amd_pstate_unregister_driver,
> +		[AMD_PSTATE_PASSIVE]     = amd_pstate_change_mode_without_dvr_change,
> +		[AMD_PSTATE_ACTIVE]      = amd_pstate_change_driver_mode,
> +		[AMD_PSTATE_GUIDED]      = NULL,
> +	},
> +};
> +
>   static ssize_t amd_pstate_show_status(char *buf)
>   {
>   	if (!current_pstate_driver)
> @@ -805,57 +906,22 @@ static ssize_t amd_pstate_show_status(char *buf)
>   	return sysfs_emit(buf, "%s\n", amd_pstate_mode_string[cppc_state]);
>   }
>   
> -static void amd_pstate_driver_cleanup(void)
> -{
> -	current_pstate_driver = NULL;
> -}
> -
>   static int amd_pstate_update_status(const char *buf, size_t size)
>   {
> -	int ret;
>   	int mode_idx;
>   
> -	if (size > 7 || size < 6)
> +	if (size > strlen("passive") || size < strlen("active"))
>   		return -EINVAL;
> -	mode_idx = get_mode_idx_from_str(buf, size);
>   
> -	switch(mode_idx) {
> -	case AMD_PSTATE_DISABLE:
> -		if (!current_pstate_driver)
> -			return -EINVAL;
> -		if (cppc_state == AMD_PSTATE_ACTIVE)
> -			return -EBUSY;
> -		ret = cpufreq_unregister_driver(current_pstate_driver);
> -		amd_pstate_driver_cleanup();
> -		break;
> -	case AMD_PSTATE_PASSIVE:
> -		if (current_pstate_driver) {
> -			if (current_pstate_driver == &amd_pstate_driver)
> -				return 0;
> -			cpufreq_unregister_driver(current_pstate_driver);
> -			cppc_state = AMD_PSTATE_PASSIVE;
> -			current_pstate_driver = &amd_pstate_driver;
> -		}
> +	mode_idx = get_mode_idx_from_str(buf, size);
>   
> -		ret = cpufreq_register_driver(current_pstate_driver);
> -		break;
> -	case AMD_PSTATE_ACTIVE:
> -		if (current_pstate_driver) {
> -			if (current_pstate_driver == &amd_pstate_epp_driver)
> -				return 0;
> -			cpufreq_unregister_driver(current_pstate_driver);
> -			current_pstate_driver = &amd_pstate_epp_driver;
> -			cppc_state = AMD_PSTATE_ACTIVE;
> -		}
> +	if (mode_idx < 0 || mode_idx >= AMD_PSTATE_MAX)
> +		return -EINVAL;
>   
> -		ret = cpufreq_register_driver(current_pstate_driver);
> -		break;
> -	default:
> -		ret = -EINVAL;
> -		break;
> -	}
> +	if (mode_state_machine[cppc_state][mode_idx])
> +		return mode_state_machine[cppc_state][mode_idx](mode_idx);
>   
> -	return ret;
> +	return -EBUSY;
>   }
>   
>   static ssize_t show_status(struct kobject *kobj,

With one nit fixed,

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
