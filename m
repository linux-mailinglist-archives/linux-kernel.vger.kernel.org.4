Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D23465CAED
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 01:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238749AbjADAde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 19:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238750AbjADAcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 19:32:50 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2087.outbound.protection.outlook.com [40.107.95.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466791659E;
        Tue,  3 Jan 2023 16:32:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkWagZraM4kgj54m7xmiV85Vl0jjZnb2GKxEZXBfYtmwyhlCCl4gxscWC8DabxebHC4l7PdqZ+o778k9KfGkuNbX15zTc5gu8wuI4IfL4AvU70BCsWDkU14pgPj8IHeKUMuVI29Ulewx3BfsllM9VqffiQvWG4KcJpLbOML/w+2/xDVPD5iMfV3tPhG9ef62vxeC9yFYrVkt+vj6aWhnTIFch8AJS+JjujTw54AnMpRiLiUPnwZKcnY3rxmIWunsbhIxSutr4/U/diV3Nydq0YaL9K5HGAeIgQMYqfMC1mw6sR38D/1WnlWQa34RCS5GG1gdQMikqp5AMhaZfVUxTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13UJV6hFCc4WXAMzbAW9P4i5oD7c9OVNm9dQade+QM0=;
 b=Lwd3QTKENMMFZwMhUyXxdDu2f+a8U56RkaLu/yruZ7zdME/jn8/tUGIYJG7s8J/HKBTXWwQ6HhvzsgqFk7714WHaDV0dkxXeUsmutojPMn1kUB+efztw9NOFRSwkmwqq7/0O76QCGhVk3EVwml3mIrWvizk0gBf+aWx9VQ6M4in+KPk7DyEgJBWb2TDzHOdz+5g5T345zwWDXBLC9mJT8ohAUyNGHukO59JfUpX/c/2LW5b5162Xp6HAJ1G/DRXnx9oa1PkfwRVR8ytK+gCyIXTN+jCYKeBP6nVYkMHlzI9QZBQwJm890otDRqTHYIW60JYIv+l8BYg3VJF/o9WeNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13UJV6hFCc4WXAMzbAW9P4i5oD7c9OVNm9dQade+QM0=;
 b=gsBuzxFCUtKi1cpKyW5+l2sTEAqx/8eH/3rIC7kFij4RijkNgIMA5G4/FIKQoheriSPpsXqka9nH6yRnmhps3jTCf2x7G3dLKxOUnw89xDHOrp8e6B65w1Q/WaiKGLe67Zgzwfqpm7sy5m573gWvqmztfbKwuBLebtu0VNBhcHQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4358.namprd12.prod.outlook.com (2603:10b6:208:24f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 00:32:47 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%6]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 00:32:47 +0000
Message-ID: <a7f2de22-811c-1df3-eafa-a6a1f4b85a99@amd.com>
Date:   Tue, 3 Jan 2023 18:32:45 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v9 05/13] cpufreq: amd-pstate: optimize driver working
 mode selection in amd_pstate_param()
Content-Language: en-US
To:     Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, wyes.karny@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221225163442.2205660-1-perry.yuan@amd.com>
 <20221225163442.2205660-6-perry.yuan@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221225163442.2205660-6-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0142.namprd03.prod.outlook.com
 (2603:10b6:208:32e::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4358:EE_
X-MS-Office365-Filtering-Correlation-Id: 73567933-8c95-441e-1d45-08daedeb342b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UjRZvEtI45HbX/ijqgFunT+J+rmQXXGnTSt+WOw2+TNWfEb9W9FtGp08U4VOdgGnJM0XcnI03kCvHQdpAHG3NkQmdzh6ieyvX6cbbzP9Dvpj4eVZJ9Nc2htX3Tv1ZaY5jk1eqZVT3TzBDsGqxfGXVl97eb5umtWa4NoaMopMvvgj2s7U5TM6ZgmZwndVFVBlyg38zIK+9so9F2YnUS54R7VCjw7JW1Zf3XBmggrlXB3I9MlSpp8F7X2EEWKoVF0F7KHKa5p/BTpJ4dJysrUtaMKcELP/eugiXLh6Ziftna6YzXw0jaGUiZTzk/pshDgSdmZXs3fMHXXf9CH//wr9OwHRrqIIeRcE3+uQu7T++mi6uVka1/l7x3tAYDDlvichou2F2en0oZV8V7KuyKhpaO/rabz5v/KTVu4VVXeMj85KuhxUR2hWNso0IH3ZrXf+8faTo53hfTcBkx7PLbE5LsLExrZ1yk6lnIfu+8oGFsxVi3wK/CJkmWLINS6kb2EjCRK04uV8gspnmP1VXBHsbKpMnL7ntwuyAoS3YXDY/53hCJQXUZfOhu4D05D+kiwoTzGF5YxwEfeLdoGsGvd4BkEfNQiOFNMnjTitQ9zXxkpf7vHgh+29KBGZDS/5ErNr1wWsshXK8heTZlIR6iLAIVFjZAsxCbZZO0fGlThczF4BrETZ95q4whJ7x6EJUngLBnmUzFEHRQRHKgJoy4Pe+O2ztdFlTd3RIyDn4qt0zk4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199015)(36756003)(2906002)(38100700002)(8936002)(5660300002)(41300700001)(83380400001)(86362001)(31696002)(66556008)(31686004)(6486002)(66946007)(6506007)(53546011)(66476007)(478600001)(8676002)(4326008)(2616005)(6512007)(186003)(26005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVF6K0I3WHhWdXVRbHBieDhOU1pVa0I4ZGdOWDMrSmtPVnNaa2N0eDdseTFH?=
 =?utf-8?B?UDJRODJzbVZaN0M5Sm5DcXN6OE9RNkJlZDU3cWltdzZaNmpLR2h1QWNsVXdw?=
 =?utf-8?B?SkF5eFF2SHcrK1FqNHhZZyt5aVpPNjhtZjFjbi9tYTlwTWp3ZFZETEtSOXNT?=
 =?utf-8?B?Y2FVNWpkcjd1VDRqeUh2NXJlRnp1b0FWakVLWWhrNTdHNXRsc29pU2liYkM3?=
 =?utf-8?B?K1l3ajFEM203cjlIZWV3M29nQllheVhMdGFJNlozUmlTNWhNMVNxaDFuMnFL?=
 =?utf-8?B?QTVZTmhuQmhGREJqakVmNXdTVmYyWHlIMmJ0L0Mzam5EUTY3YWk0SkZhWEpT?=
 =?utf-8?B?MHQrOE9pQkpUdVBzYkIzUjVrSkQ4V3NMSFZucDNzS2toamVlYXVXNVY3bEhj?=
 =?utf-8?B?b3VRVVRDeG5WS0dJbjFLcU95YnJxR1laaWRuVFA1bVJ0ZmFHY2Q4Vm9tMXFp?=
 =?utf-8?B?RCtqT0dDYy96NE9EOWpFK1dHeERpY0V5R3BGTjdTcG9zRHlCTVlHQ2ZERUVZ?=
 =?utf-8?B?UGlRVndGcTE2RHN2NGJHWk4vNHVxZ1Nkby92UXIzS0lJbklVK0pQRjdYQjJz?=
 =?utf-8?B?WE4vZDhoNlJiMDJtZVdiSHRqbHhjemdQbHJiaHlUK1J3MVAwQWdRVTdma3FY?=
 =?utf-8?B?SUFza2pwQlBFck5rWGx2alQ2cjdLQWQvYjRjc1c1eDlyTkZOeC9iUWFaN2Na?=
 =?utf-8?B?cG51ZVlyczY2TStGSEFYR2dNOWlnL2t4dWZkb1o1SmhFRHg2SGgxMG9zWlZw?=
 =?utf-8?B?cHJQVGpnbUFHdXUremJZZGluL2I5TTV2S1VrWStIanR1TTZLM1FsclNRVGNH?=
 =?utf-8?B?T1VBblR4elY0QlJyMVZTQ04xUU1KK1FJUHVGQ1R5UGU2V3hpdzR5ZDhuQ0NZ?=
 =?utf-8?B?VzVaTjRyM3o2eklvMnU5YTBMb291S3FDYmoxLy8wcktMclh5NkJ1bUVqaUlI?=
 =?utf-8?B?bVltUyt3TFdyUElvMEduenFERDBjc005M3ZhY2pZWlR2Q05yZlhqeUxIRzFF?=
 =?utf-8?B?U1Jzb0U3ODhjZnpTWWpNSmpvOE9qRXJoZThBM1hTbkQ5RStsa2UwclQzWTdX?=
 =?utf-8?B?M21HSUFxVmJUL0JjTjJKU0xJMjk5ZU1vRGwvckdxRVh4TzNmYW5PNlhkMmox?=
 =?utf-8?B?NDVBcnUyTFhBMjI4OU1mK1ViVUI0VWJOZEIzZER0V09DekVwNHRYazRQN01w?=
 =?utf-8?B?UnA2eUpPY2M3dnY5YUY4UmdnN1FPd3Q1T3JYZHh5TzNPTkFSazh0VlVId2Zp?=
 =?utf-8?B?akJJTk9EdDUzQ0doQ0Z4ZTViZnA3dTVHNnVjQU9LeVZxZTBaQTZaQUdwUzRr?=
 =?utf-8?B?cFdXNHE5Y051Vm5tOFQ0ZlcrVkJrbDhubjE4ZFhkYmo2TzZVbUhLM3BNSFVT?=
 =?utf-8?B?ajlqOFFabzNRVEkvTnZNbDE1UWtsdU81REFBTUZzdGdLb0lrZktiTGhBanN4?=
 =?utf-8?B?MW8yQVQxcUJic1puMkNKRDNrb3pYK2tkMzJPWTdnaDZqSHpNeCt2WjBkVk4w?=
 =?utf-8?B?dGhXb1l2elY3djlSem0xWWhUelhPb3JnSWxyNWh5N1RmbksrbFY1TXZXTGth?=
 =?utf-8?B?bWdZYytDSFRISnNpZzR5aEhOQjNHdFljQzBybnRBN0ljSlpNaGtxS01tREFn?=
 =?utf-8?B?MUNwSlhrTmZ3Y1phYUdWWWhaOWtiYksyc3EzZUQzU3RZenZBdE1nbGplRHpt?=
 =?utf-8?B?TWZRa1ZtRzBQT3hBMDNxT3MvVmt5aXlyQVJ0YmQzTi9HODkreTg1akxodFhV?=
 =?utf-8?B?VlhwZnFFdTN6Rk1CVzV6ai9QSTN3amk3YlJUWHlhbjZQcEVEN1pNR0xsdTZj?=
 =?utf-8?B?R3NmY2UzdGZMalZKNlpQbHJJY1JmSHl0VXd4ajRZajZJYThnbzZmUTV0R3FM?=
 =?utf-8?B?OWZ2V3l6eFFYMzJnaEpuTzRPRE9FSThxOUNWOWwxN0IvYVJqL1kyb3FXd2pF?=
 =?utf-8?B?cGQ5b1o5NXZCaFQyQzZFKzI1OGliSTFHK3VNbXQyVE9YSDVCTWZVTGdYM1k1?=
 =?utf-8?B?YW5HYzJUeVdlNDJMaUlnV2RCZzRTaVU5cFdhcUY4VVovbERuUitpZlNIbGht?=
 =?utf-8?B?S2pGZisyeEFqRm84TDZURlFDdURtRjRYM3hIMFRNeUZsMHJsZjRzN0x4UWFx?=
 =?utf-8?Q?idFza72fByXi7fteQUc/BeHD0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73567933-8c95-441e-1d45-08daedeb342b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 00:32:47.5622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wdHlE/UxvJo2SVaWZ5oKYaE+IDs8ABIKJCifTYuKBFWq+aBFSmgLRwRrspR3KjaMijYEg0V+IIinekg4whCKIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/25/2022 10:34, Perry Yuan wrote:
> From: Wyes Karny <wyes.karny@amd.com>
> 
> The amd-pstate driver may support multiple working modes.
> Introduce a variable to keep track of which mode is currently enabled.
> Here we use cppc_state var to indicate which mode is enabled.
> This change will help to simplify the the amd_pstate_param() to choose
> which mode used for the following driver registration.
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/cpufreq/amd-pstate.c | 39 +++++++++++++++++++++++++++---------
>   include/linux/amd-pstate.h   | 17 ++++++++++++++++
>   2 files changed, 46 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index c17bd845f5fc..65c16edbbb20 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -60,7 +60,18 @@
>    * module parameter to be able to enable it manually for debugging.
>    */
>   static struct cpufreq_driver amd_pstate_driver;
> -static int cppc_load __initdata;
> +static int cppc_state = AMD_PSTATE_DISABLE;
> +
> +static inline int get_mode_idx_from_str(const char *str, size_t size)
> +{
> +	int i;
> +
> +	for (i=0; i < AMD_PSTATE_MAX; i++) {
> +		if (!strncmp(str, amd_pstate_mode_string[i], size))
> +			return i;
> +	}
> +	return -EINVAL;
> +}
>   
>   static inline int pstate_enable(bool enable)
>   {
> @@ -626,10 +637,10 @@ static int __init amd_pstate_init(void)
>   	/*
>   	 * by default the pstate driver is disabled to load
>   	 * enable the amd_pstate passive mode driver explicitly
> -	 * with amd_pstate=passive in kernel command line
> +	 * with amd_pstate=passive or other modes in kernel command line
>   	 */
> -	if (!cppc_load) {
> -		pr_debug("driver load is disabled, boot with amd_pstate=passive to enable this\n");
> +	if (cppc_state == AMD_PSTATE_DISABLE) {
> +		pr_debug("driver load is disabled, boot with specific mode to enable this\n");
>   		return -ENODEV;
>   	}
>   
> @@ -671,16 +682,24 @@ device_initcall(amd_pstate_init);
>   
>   static int __init amd_pstate_param(char *str)
>   {
> +	size_t size;
> +	int mode_idx;
> +
>   	if (!str)
>   		return -EINVAL;
>   
> -	if (!strcmp(str, "disable")) {
> -		cppc_load = 0;
> -		pr_info("driver is explicitly disabled\n");
> -	} else if (!strcmp(str, "passive"))
> -		cppc_load = 1;
> +	size = strlen(str);
> +	mode_idx = get_mode_idx_from_str(str, size);
>   
> -	return 0;
> +	if (mode_idx >= AMD_PSTATE_DISABLE && mode_idx < AMD_PSTATE_MAX) {
> +		cppc_state = mode_idx;
> +		if (cppc_state == AMD_PSTATE_DISABLE)
> +			pr_info("driver is explicitly disabled\n");
> +
> +		return 0;
> +	}
> +
> +	return -EINVAL;
>   }
>   early_param("amd_pstate", amd_pstate_param);
>   
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index 1c4b8659f171..dae2ce0f6735 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -74,4 +74,21 @@ struct amd_cpudata {
>   	bool	boost_supported;
>   };
>   
> +/*
> + * enum amd_pstate_mode - driver working mode of amd pstate
> + */
> +enum amd_pstate_mode {
> +	AMD_PSTATE_DISABLE = 0,
> +	AMD_PSTATE_PASSIVE,
> +	AMD_PSTATE_ACTIVE,
> +	AMD_PSTATE_MAX,
> +};
> +
> +static const char * const amd_pstate_mode_string[] = {
> +	[AMD_PSTATE_DISABLE]     = "disable",
> +	[AMD_PSTATE_PASSIVE]     = "passive",
> +	[AMD_PSTATE_ACTIVE]      = "active",
> +	NULL,
> +};
> +
>   #endif /* _LINUX_AMD_PSTATE_H */

