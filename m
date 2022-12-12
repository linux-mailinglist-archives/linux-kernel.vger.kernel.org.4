Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341FD649AA1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 10:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbiLLJFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 04:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbiLLJFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 04:05:21 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5286F2DC4;
        Mon, 12 Dec 2022 01:05:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcviVB5zJDklJcJKIaK1QyxkjgVgYyG35OAuUQM7XsuDOEIhHG+HU9ftL9b53Y4vMv37KE+uNtS1j5QMjIyTvOLMs+RUdB2fWBk65W00Kb39IfY+L26/Zr1/vuQhrQlz4srJLYAnsHsxLZwpDnGKwsr5yaqwli91aGDHbQH0c28lL0l64+RjhCXlWkWFEQQxc0V/ePHwCcWHHe7jmgeGZ0wHXCIuAtuxa+RmrbS6dW2Vszu2nMxT8qA2XnYTYF/rVQbq2Ds1l4IMPCkzO/K1GlkwMaBxAlglsjNPUu722YY18Vah23QnkXuHeHjj/ekeBAQ63wKO+veQ5m4U4A2wgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Lj+2N+uVoM9B3ZzI11e2ITzx4UCP6AJ9n67tqpLgCs=;
 b=Pc/8vvG+tRMxedD9DMDvxKOJuDLvLdY+SjUXqbg8uRIIZmUKkhDD89c1/Wa7NSaZ12hixXNdcACMoqjdBmewW39T7SP7JiK+PLkU5oj9zhjn1iPCslucVth+rNjfyDw/Z/GTtemr4SAMQyKqT7/IdDHgpwnkoijdGQOYdcyqpSR9y6HaVd/8haa91V/7eo04xoa2zA6B4iokBaM4Tkjy5ErZZ0cU2oZGiZvs3zC/UyGm5idFwT4PgOs56OeXKwaruTh+vvFlUe0m0/83f2aKM6I1nZIuIqq8qSP5TXIXSviPIG0dXgi99rOcQYevFJrSW1KO6aa32AE7yVzlT7KAQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Lj+2N+uVoM9B3ZzI11e2ITzx4UCP6AJ9n67tqpLgCs=;
 b=vEc8g3/GIoaWuOUtHPosNYiEKwWxyFI5t6+DQg58dwKvncWZQMZDF5XMe2sxmgutn+joBG+U6wTjF3Nw45kaA/eIXrRp52lj4TFEEZtFbmcpyZS+EiNYMKaG0Y9qZ92unWoJnZff2NCCjTCJQSuNzM9aWRbki1nvdOFx1boYcDg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 SN7PR12MB6957.namprd12.prod.outlook.com (2603:10b6:806:263::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 09:05:17 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc%6]) with mapi id 15.20.5857.023; Mon, 12 Dec 2022
 09:05:17 +0000
Date:   Mon, 12 Dec 2022 17:04:52 +0800
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
Subject: Re: [PATCH v7 07/13] cpufreq: amd-pstate: implement suspend and
 resume callbacks
Message-ID: <Y5butE2biSRddti+@amd.com>
References: <20221208111852.386731-1-perry.yuan@amd.com>
 <20221208111852.386731-8-perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208111852.386731-8-perry.yuan@amd.com>
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|SN7PR12MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: 33de95a5-4b6e-445f-e5e2-08dadc1ffce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r5jJPMMGsjHWZ45fWtVEbTyUZ4QgAxCuHOYt9Xz9XMclpuqqFIpfmt1UFHnTYSN/eti61B1dDntQS5PiBkOoh3Jkpy+H2PZMoWGu0yN5V4VWQqhLIXrBRWHfU9QwctGQ/j+jVhjHN0JPpV07thNHvx6GllW8MdGnJESI89XLokxXxgvgoVUwaMr7fVQqCL86iHsFdfVZYnrwc1D183ULzLTZ5NUdM28CbMdcnIr3DyuoyZ00cPLJJE5aV65VpFnUihsu4dkDtlwM5Gt2EGvT2MD7+gdECxC2nSF62U/Fpu5etk9VOsKqxSjBqPvfSPuTohNge58+Mb+MxNvcldSDglkendwsgYLpf9S+PgrrA40jH6AXVP59OO9pf6Bq45RKi8h9X500JkInA0B+818cw+ZtpagLlZNpD0KwlCLN+xMYgmsgWJuNuG1hoKRaaC0h29UMDUNUWdI+wNH/TnmBFOnV2hUaMpcCDWeUtHgkBZ9lsb6LPid3ZVG/d0f69YvF6yaGAc7JfU/KWwpuQg7mxeJZnfeXZIUvHMBrRrMdmcb5R9GjY+3z50YjcASywoq7y0QeeeubHuyGWb/wamCgMWRAVLQXzDrvlBHdtAm+rgG+sNvmadjH9LP4eqYmFHW6jSGBW0FXqTr1fM5kCQKRXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199015)(36756003)(38100700002)(8676002)(15650500001)(66556008)(66476007)(66946007)(4326008)(2906002)(5660300002)(6862004)(8936002)(86362001)(83380400001)(478600001)(186003)(6636002)(54906003)(316002)(37006003)(6486002)(26005)(41300700001)(2616005)(6506007)(6666004)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hv91WBf87AOS0IUlh2g22R1h6neaLnaZqAvCZgYKoTd37O1+wL/BgqYV148m?=
 =?us-ascii?Q?3/P2HH3AGC6HcmSzwKHTdUJDYrT8NnGoa2UOXFoBdQhw3gMWUTUR3vSpMH8P?=
 =?us-ascii?Q?4vnsYOyo9gvSXSAiANnM/qSkqMUHvjBoQidwGhYS2Er8/06fngeFq/h9BRiw?=
 =?us-ascii?Q?YjLu0z0nmNpcDA1kNp2XOyUwFTP4geaCTgvDevSwh2T9pLwvNDVnuB7N45gy?=
 =?us-ascii?Q?er+8y7wt7XUlwhbDQnNd/vHeBIW6DP0ni5dUETWVU+vlCcXwE3gasy6H08Pf?=
 =?us-ascii?Q?KvVXWO8nmO3UtU32vn70BWJsMOpE5QrhfidVyyFSrzOMnqzll9MQ+huHZWtD?=
 =?us-ascii?Q?bKq3GvdMJztYYzz3yyXiAc6pc8fi/sDODHP02liTtrhngfU6LUrmwBDZ9eCI?=
 =?us-ascii?Q?ExBkhimXB69ZvlKour3OzbhAF85hkKYwNLTihZbOpTzF4b/mc4sTvJIy1d3r?=
 =?us-ascii?Q?+1bkY4M+uV1vlJH8B9klhJ4gucaj6wTMq7iLkmhkPjh9vHnRYYZ67AK4ocif?=
 =?us-ascii?Q?EIJuYLqFx6lsMtak42V2SH0zxwVHbrpX4SqTGmgAKwGbCbYfXiP9BhYATqZN?=
 =?us-ascii?Q?sUmueptZGZ0ZlgvkYJvhVidAg47Jni/Aa7qCaBoYGNJU0ghJZ7sOrZkD3Uy2?=
 =?us-ascii?Q?wqZMeKS0d/aaMIds1ix80cSEcYvVE4BILDSnbGokcDPid4d0fyTJGH+kEjpj?=
 =?us-ascii?Q?rmAe0kiTsb65+rUeOXcJhcT2IO6IP8So7OQdEdeNOvACV4ZsAvoYq4kQnhek?=
 =?us-ascii?Q?H42Zw8SPDBzoKug47m1Gg+trsWGZP+vJQU1WUIbD8GqJEHplu+Zk9ChcHgcl?=
 =?us-ascii?Q?CmDy5CK/x3aftBVaRcnuyZNQqxjJirUbvjF07EEU3CJcCFmHWuTw4k9ZM5bY?=
 =?us-ascii?Q?mk7QLE2zq8/h7MYjMGgLh2N4rRGz8DR0HxZclB3rzYxfOuXiu88Ow6H+x6oU?=
 =?us-ascii?Q?5V+H5q3jtNu4BWdkPLTIUah35uoffIAOoW1w09NGzmuJjV64HdsUpglLRweh?=
 =?us-ascii?Q?gOC4U6/EnPnLIPI+qti9KdpyUlGTLLG56q4BZP10U2zf/G41rpxX/QEAvG9c?=
 =?us-ascii?Q?9g+CMEOkwRTHPKdiW7/g3emCNXafDI7N/rpBa+TSbJ6wap9CxC68fXXyxwSc?=
 =?us-ascii?Q?JQNo+timtw9vPiNOa42YLUv5LiMnXYdYLW+uSu5c8c7Fnd+KBeED/lmEB1q9?=
 =?us-ascii?Q?ybuogHnLy777UlWfWnr9Vd3GE60yT6vTTMtNHJr6AHWxxVf0DgYY65dHbtcA?=
 =?us-ascii?Q?CosOjZo6foKGY+RU/AZGnXFZjusCqFJKoBiKOMl2BuP7R4/CDnnB3/rPtEou?=
 =?us-ascii?Q?w7Tk273d1jaSbSGngniUPzmleT1j336QtgEfcGbDEXckh/QoF0Qaj2lq0aPh?=
 =?us-ascii?Q?WR857WKRAp8LdESonhQsdA3RjyMyNj04Uc03R2qgPLxLGd8cf5pGFTAcE8HW?=
 =?us-ascii?Q?RIKXmx2tf5EXt1kfzQAlrp2gmk3AlxMegakl7lLEBz6LC3sxrfAaokGd3tvt?=
 =?us-ascii?Q?D3adTsxP7b1RFWvwMpR8Zx29uZiQtiwOVMK0dcobaEPrb6vDgUP8akkzdIpa?=
 =?us-ascii?Q?9+bXTxD6Ah+sqeZkSVOUMFVV9upcMOVVXc8Pt8fA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33de95a5-4b6e-445f-e5e2-08dadc1ffce3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 09:05:17.2487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03yog/pL7WQTgcP2+Qu1+ZUfXZiCbfZsoJVhzwcl4XDRl56CqEH22wFZxgIJa8AOISxKrdjcC1aAAzcXljr51A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6957
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 07:18:46PM +0800, Yuan, Perry wrote:
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
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 40 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 412accab7bda..ea9255bdc9ac 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1273,6 +1273,44 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
>  	return amd_pstate_cpu_offline(policy);
>  }
>  
> +static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata = all_cpu_data[policy->cpu];
> +	int ret;
> +
> +	/* avoid suspending when EPP is not enabled */
> +	if (!cppc_active)
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
> +	struct amd_cpudata *cpudata = all_cpu_data[policy->cpu];
> +
> +	if (cpudata->suspended) {
> +		mutex_lock(&amd_pstate_limits_lock);
> +
> +		/* enable amd pstate from suspend state*/
> +		amd_pstate_epp_reenable(cpudata);

The same comment, could you please double confirm whether the perfo_ctrls
registers will be cleared while we execute a round of S3 suspend/resume?

> +
> +		mutex_unlock(&amd_pstate_limits_lock);
> +
> +		cpudata->suspended = false;
> +	}
> +
> +	return 0;
> +}
> +
>  static void amd_pstate_verify_cpu_policy(struct amd_cpudata *cpudata,
>  					   struct cpufreq_policy_data *policy)
>  {
> @@ -1309,6 +1347,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
>  	.update_limits	= amd_pstate_epp_update_limits,
>  	.offline	= amd_pstate_epp_cpu_offline,
>  	.online		= amd_pstate_epp_cpu_online,
> +	.suspend	= amd_pstate_epp_suspend,
> +	.resume		= amd_pstate_epp_resume,
>  	.name		= "amd_pstate_epp",
>  	.attr		= amd_pstate_epp_attr,
>  };
> -- 
> 2.34.1
> 
