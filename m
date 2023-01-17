Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B87D66DD01
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236946AbjAQL6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236811AbjAQL5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:57:42 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C207E166CB;
        Tue, 17 Jan 2023 03:57:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LETJw7ord5Fpd2UgntOEpqWqNVF8dJWHylcWUPL3OYVjHYD+z9v1T+h4/oLTnmSogAO5biwpIs1G+KIrDtzEUU8pPvlyV5rpC4hPWa/CUG1bpM9nChro5IhSqr7E2zlhqJ/A+KMl9GrjYySNB9A0cvqOoo4572kC+HEeheHi0gR83w2lkfH5fk3qBl7b7MVmt3YQXRCN2qwOqjg37uFpku8NZckoqMseP+WJb0x6M+PeEFoY8Z3Mv3UvR1mwL8d+qJg9FQOF7l4Lc8W0u9p9WRcsr5Rb/RFLzCkm/Ow0t0Z+gZY6AIqj0x+hP7LmmGPVagRRw3dOrIzhFBMuIgDxMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9Jem7D/Vh9jL2MmsbwrMuUOAnAYSfRuqu1n0nInXrI=;
 b=MbFTkW5sZlTz+gSVa3nUgtWFPAWpif5vdWgfiHdhcvN6779QcDeqRLTtPnu9W/Eiz6NpwlGlr4CZbade6hmBcQ4uzEAibX9Bp9HqZvrNoinLsc9OEcEqUbcGZbNPlgWBHxAUFeQB965wp+aMY+yo2YdyMOHKW8baYMWSkLyGh5/Pi/FuQl9gF97kG7e9mCRGfSOH/50wLf5pQcL3blwgMOuu4uxaZEriQ2QRRmI1OGN60RGqlcNSca9qAZ/OBRDyRc7ao9dNG9TGt5mIbVIKBeBbRJDIMglulkWxrefDNHtf3l3W1SZ6luyIwovgBUqtxktUXnmkDwqGFdIAt3UCKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9Jem7D/Vh9jL2MmsbwrMuUOAnAYSfRuqu1n0nInXrI=;
 b=pMh3QaSkqN5fBjr7TsTnlPGoNS6tvetOMAwAETlL9/u/dcNvYj/wWjmyvQEumRq/c9rG4UXQBBDdj+w0GLjfG8b5laEqfUV1kJXdH42KKN7MV1rw8HBnaasjOdGQYneBlh8nryqVwW16eaSk6hKy3bBJ0aUIccyDo87oJhBXnEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 17 Jan
 2023 11:57:37 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::d17b:f929:12fd:8ae]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::d17b:f929:12fd:8ae%4]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 11:57:37 +0000
Date:   Tue, 17 Jan 2023 19:57:12 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 04/12] cpufreq: amd-pstate: optimize driver working
 mode selection in amd_pstate_param()
Message-ID: <Y8aNGDOMUbeFK/cE@amd.com>
References: <20230106061420.95715-1-perry.yuan@amd.com>
 <20230106061420.95715-5-perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106061420.95715-5-perry.yuan@amd.com>
X-ClientProxiedBy: SG2PR03CA0124.apcprd03.prod.outlook.com
 (2603:1096:4:91::28) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|IA1PR12MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: 4842733c-b9d1-475b-c49f-08daf88206c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y7SeuM76uJSyQ1cPL7EaRiiPnmclqS1PsilmQg4pSWUqOgj5NyTbClz88i4ARJxWP2OdfQCDBz0HzwUJM6fHgvwp08LXFjWiqm5jrlUv+BALbyKg1/jX9bzdBlsDtmhs96Itgg8QAcidXl+ZUTJPr4GPXGFR08Z4ADx+iC6wE104pEMF9KLyviQ+/r01R8VLhUE/6C7RU5DoOrmcUktG0NJgDKqKBRZVnexD8oL2Zwd3skiexIrpDXVPfR2b+o03AZOMwhDLcXm7k6cakVPVjjZVKqXnTviNn8l++/ke4bbIIBTPt1G97/sA2wNTO3EWzNsHzinYo6nsOWkUrR2y4f/ZvdP7D83LqgUoBs5qbb5rJ8F72MHdvQTSp1zap8sJV427XR49Xi0szin+EKINrKaw5LlGNMA+2HhVCME6wlHDfYjFoLR76XdMQzhhcIz59BbziOy3VesrKq/cGmiTw7htnQtotroQhhIah4S7gAX7WZda4M4vel2W/XoKqDxIi5e9fnomflk3M8W+PYlZ80Nh1nt5zqCewsucsPnD3I1daeMf/V3YyDaZ7nJ25B4yDPCnYDoGdR/IeuM9nXuKS11/No2Ot/RFUVD6JtA68P/HxdLJ4yGqXKqb5nu5eN1GdF8znzHoCSK3D/Qc4mzWhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199015)(6506007)(54906003)(186003)(2616005)(6512007)(6666004)(66946007)(4326008)(86362001)(36756003)(5660300002)(66556008)(66476007)(478600001)(6862004)(8676002)(38100700002)(2906002)(6636002)(37006003)(26005)(316002)(41300700001)(8936002)(83380400001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sgLTzDhq00HlJAtad36PSa3R68dfb0xn55Tu81tfwtoWmHampRlhPK4NhhIc?=
 =?us-ascii?Q?+oibkA3C4vD7PPAhfnNPatQI7lxZpWee3KQjDme/NMWFRk/3DFJpCkq1BGRT?=
 =?us-ascii?Q?idJnbc3L7mdzizERJUkuSRpJC87pstO5DtIKW5HtR7u4HX4m3SS7mFF2qCga?=
 =?us-ascii?Q?MpxzJlSJPgsOxCmANcX8MEjyr2Iw6Pmy98sQljrmgZHeJ8xlf5iOrkgYAKIU?=
 =?us-ascii?Q?QH9qIPYpy2izQJoJrm8vdAHIydcwKHWTQ+1Cd4H7t2ryPjWiVfNQfdkLMfyF?=
 =?us-ascii?Q?GjVZSK8Ojm23DuhyTYTvawee2hkCHPbMqBDHZ+2lNpVBzgeBuqedABM+2+4L?=
 =?us-ascii?Q?GmXbvGWAi6ImGULXAcfgtTzJ72263rT1WEZuQ5906QFms/gN/+rADONwqiU9?=
 =?us-ascii?Q?1nSLzu1gH3ggbDcgVwx5rOj8v30qmShEhC52W+w+CBP800tH/gTroOfrBfyn?=
 =?us-ascii?Q?a0FMZfzTgYXjCR/GDEi/S23C4qJ8nFqq/2sR/ULqB9BgoIMNKA7i64uRyJck?=
 =?us-ascii?Q?jPFEI2vbBHzFbXRaRWJkDWJ/CDVvzYo0MC/gwVbiDV/H+OB2EZ2HzjPEMBvf?=
 =?us-ascii?Q?d137uZvruzWocE9cJT33d50p16Osw6D3vg9wkKlECOaVXx3ykWGBovKZE5Gv?=
 =?us-ascii?Q?PF4AxkY6JT4p/wo1oxTorl6R6Hy6AwX9VgcBpb8fp1QbPBKgbB5skpxuQOdl?=
 =?us-ascii?Q?S5LdCTNdZDeAWMAOw45qwE1vcDJ/E4VsfMyEfmFiNpqtISQi4EnVDIeA/gPz?=
 =?us-ascii?Q?uurMoAoD4CspmIoXlMVrq7+z53+Mmpoc01TncrTez/G4u2RTLltDflt9Iu/J?=
 =?us-ascii?Q?LYKsY2x7R2RN2y0VUZKxxazGsSri2iILORW9ytrtEUJDMYrgreYV16ZLLKB4?=
 =?us-ascii?Q?UpFmOh/tw4Bu3DU+s2xIaZ5Ega0OWSMDEcZN1Q2kQjwCLyYY4SSyacRD/p1V?=
 =?us-ascii?Q?2uquTJrkvaXK7ECwRoppQWEf+O+2mn2Wnnty0uJmUVPfkG5rp7aY7yrOcvpq?=
 =?us-ascii?Q?DCjvNaiuua0HMBSQ6TUE2BVk8aTWrKN9Q0NRfLkhq57/JT6PxxgahM1Cv+AI?=
 =?us-ascii?Q?R0tgOx9f2lzZQQKJOrWk1dOa9Cbkoz91HPc7TX7jY4qK4wezZ6MVq2uTxpi/?=
 =?us-ascii?Q?63AlY+sC8bTrAPwGSWV1eFEeMq2t5VLD86IVJp0rSz+nnm3I/HGpI1q1mutM?=
 =?us-ascii?Q?UaVY6AqNmLoAJpFxg6ZGmeqcPU8lhnAIi33sbAx2jVHNpXX6cMuIugaM+OHi?=
 =?us-ascii?Q?BW+SV4Bg6PcCaFUCDx87el6T/1ahwiZuRh+0HkfnlMDLRta+n6NxDIsUPAoE?=
 =?us-ascii?Q?z6ef9mk6kKrjCzMZ5THHD1SZTGmGm69n+di1oWqAD/C4ayrsE/ewEqkbdhb6?=
 =?us-ascii?Q?O5VZRulOwYzCU6qkx/g+YgZG4ziD/TeoyK9FzRtez6uCTe/11UnWmqu0/G4n?=
 =?us-ascii?Q?IpRUXg48RU72uxHHVoTJlwmkQQPiwuB7j/jg2sPTTzSG2kscTPo5hEv7HSIq?=
 =?us-ascii?Q?6kLsUQZX+WjnyLDBwNMIONARpX1Bwvqono2oRcbfsi0c5kr2Gup62Sxgu8nj?=
 =?us-ascii?Q?LdMUNRSNi+JUnoKIapQK3NFDlq48nhDrQGm+1gRS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4842733c-b9d1-475b-c49f-08daf88206c8
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 11:57:37.1791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qU7S1VVobTAz1zLImqQuO5dSZKKg/9VpCE2BpdYVuJdIXE4dB8LeZ7Re91yo9e121oj87fBgvA4uI1JSQbHUYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6628
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 02:14:12PM +0800, Yuan, Perry wrote:
> From: Wyes Karny <wyes.karny@amd.com>
> 
> The amd-pstate driver may support multiple working modes.
> Introduce a variable to keep track of which mode is currently enabled.
> Here we use cppc_state var to indicate which mode is enabled.
> This change will help to simplify the the amd_pstate_param() to choose
> which mode used for the following driver registration.
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 39 +++++++++++++++++++++++++++---------
>  include/linux/amd-pstate.h   | 17 ++++++++++++++++
>  2 files changed, 46 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 204e39006dda..1a8b31277620 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -60,7 +60,18 @@
>   * module parameter to be able to enable it manually for debugging.
>   */
>  static struct cpufreq_driver amd_pstate_driver;
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
>  static inline int pstate_enable(bool enable)
>  {
> @@ -625,10 +636,10 @@ static int __init amd_pstate_init(void)
>  	/*
>  	 * by default the pstate driver is disabled to load
>  	 * enable the amd_pstate passive mode driver explicitly
> -	 * with amd_pstate=passive in kernel command line
> +	 * with amd_pstate=passive or other modes in kernel command line
>  	 */
> -	if (!cppc_load) {
> -		pr_debug("driver load is disabled, boot with amd_pstate=passive to enable this\n");
> +	if (cppc_state == AMD_PSTATE_DISABLE) {
> +		pr_debug("driver load is disabled, boot with specific mode to enable this\n");
>  		return -ENODEV;
>  	}
>  
> @@ -670,16 +681,24 @@ device_initcall(amd_pstate_init);
>  
>  static int __init amd_pstate_param(char *str)
>  {
> +	size_t size;
> +	int mode_idx;
> +
>  	if (!str)
>  		return -EINVAL;
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
>  }
>  early_param("amd_pstate", amd_pstate_param);
>  
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index 1c4b8659f171..dae2ce0f6735 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -74,4 +74,21 @@ struct amd_cpudata {
>  	bool	boost_supported;
>  };
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
>  #endif /* _LINUX_AMD_PSTATE_H */
> -- 
> 2.34.1
> 
