Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BAB649BD1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 11:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbiLLKPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 05:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiLLKP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 05:15:27 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B040D73;
        Mon, 12 Dec 2022 02:15:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLyNcg0u0FvP+kkRVHunFDS6tMrd8zB+IxsGhVo4Uwu6mHi70vgTTuJIYGznkJPKMI5uE/UBeB/3lQspAU88gWjdxEq6jJOK5J/59+DN+l5aNygLQZN9LXf0Xv9B6TZ0uGjco3FEb5pAE63/TM1YIlbaPbYZBkDXnHMAjRrUV6zM/t1SkyPq5fgy87uME2WM5wHQoB0/TuILPGuMKaI7TIFE3Movhll1R/Vh+/dThPV4lVw2k5cxCkbrUteAHiKcqew/4PSNbrLR7ujVIV0A5qi10TZAZZiz7ckWe50aRNm5iF9LtAfAZtblM0DPLUOI59XypFYBDo5n3mAJmliUbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8GNIdiAR81zvOBH1qxI3za4CzLsi14ADZ7qw8aQzR8=;
 b=oPNMMqZwfuzsPDUU3KBhHVGTlKIiwxILMAqix0d0MSdpqQis606yjVxRPhcaREs6FflezHdJFXoQ6GbmvOx9zEzS6y9r/nMBEd9t8TFfzCLNYruBgQheXm/nv02iBsP+9nVEBe+MhT8piz7SKuHOz6xxnJv9q77UVksuAC+5lefrqgBjUEedardudppLtJuR+p8EFdfaVdfJI3xJpxQwdKuVY6VnjMOLfyv+dOP7z2sa50x+eevfnYkKgbJlXGq0XEX0FzW/dgVAtDfPRBeUD1Bg+9uZC0USJLUjF+z4+lrR/z9yPNOXacHLKWW4GCJumCYFALURM2jnHnLIjUo/1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8GNIdiAR81zvOBH1qxI3za4CzLsi14ADZ7qw8aQzR8=;
 b=0hqiXSiTSu6pQ6hIppVF07CWNtsSyqV0dZ6ahsNK4RjksufoF/tqVVEA6FhAXhvBQXqgAuxweaGIb9eUGfZfdV5kmO79xtkT8sVdxbcu9BQLw1otb0+6QubbO02fRPrSI/46brVVZRtQWWg60igQlRG4FZmmOGNmMD3KXPd8PNQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 PH7PR12MB7379.namprd12.prod.outlook.com (2603:10b6:510:20e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 10:15:23 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc%6]) with mapi id 15.20.5857.023; Mon, 12 Dec 2022
 10:15:23 +0000
Date:   Mon, 12 Dec 2022 18:14:58 +0800
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
Subject: Re: [PATCH v7 08/13] cpufreq: amd-pstate: add frequency dynamic
 boost sysfs control
Message-ID: <Y5b/IvbeIq4d56nd@amd.com>
References: <20221208111852.386731-1-perry.yuan@amd.com>
 <20221208111852.386731-9-perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208111852.386731-9-perry.yuan@amd.com>
X-ClientProxiedBy: SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) To
 DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|PH7PR12MB7379:EE_
X-MS-Office365-Filtering-Correlation-Id: 12ad0991-4297-4e5d-ce99-08dadc29c7be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JfeuQJ2dv4zh7xxnf0qZW99o83TZo+LZSEFmu9KNh2hKQ7Q/shXemTVPSnBgg/KDnYYq+JGxg/ApIV0md7qpV/aefBLXyRemUt6Ev9Bp6jnAEdWzSwKJbJAW4ch8KIb3ezZqZVu3zd4YKx2kzhV3GVVCGASOUQZvUuE0dcYZ9lSAZL9k+/+9RHDTSKNIH+ayH0TsVpRhh6M2Kc7htuWg11z1A38JAQ21Ya1P1j2p4RDt8nRRuqpa4hIzZvaeD5aM7fAWWyhDdCTljsdrq5eOEkId9wUAnJbYZZ7NtslxYPOAAxO1zFxn9yxmLfAHt131oz6wvzkQW8P2w6jQYS4XdJEPuJMuYp7f0EKQ4rKU3pF8+yqT/OhtjC86LmF07JLm0Y+uTl6Z2MSRuRRkF/79hkhP00axngYR3jcbHsnn1oWXaSKx7UZfLpQUWnJbDHmbfkubDBrm8nrSNgfuN899tP7fWcfhKMaGXxHjUK4z+NdST2yiVHzYLgRQxQYdlVwFQK9xWs7c8wGPnkf2tT+WAmLrwbGfy6qECBBh1zSL21pTWrFb5jkFR/6+/D6N8TrXtVo2xuJZPvCYoxlHdVY1x58Tw7wHd0Gn0uIOanQZYejPuCm/Oak5dhb/9GfJoIazy5pvWfsvHme2D6pEtZLVGP4Oihoq7SN7BYiCFDnCqyNVETP6/pWnBPp2iuffXKIC2ThzHnT0jPmXlQGX9GYsQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(451199015)(36756003)(41300700001)(6666004)(8936002)(478600001)(6862004)(6486002)(38100700002)(86362001)(5660300002)(2616005)(316002)(6636002)(37006003)(66556008)(4326008)(8676002)(66946007)(66476007)(186003)(6512007)(6506007)(26005)(83380400001)(54906003)(2906002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/k6GY9tnTKZzlC+oRXB1TXO7r5HNgoYjENWFjoRXfvIPQJHIpTqbAOUZoPIz?=
 =?us-ascii?Q?iOqA4/IL8KMRusoKIVHAvEMNUEmzUlbftC7P9gIbqt+emvonMqrB+XFotD/I?=
 =?us-ascii?Q?R9bmqdUVndBXrssgQiztm9t8Wok5nchEDg7y67Nkm+au3RVHIevZExucMdL+?=
 =?us-ascii?Q?i1h44Th7TfafAegPToIkYn4BAGB6VYQl4f1duOBcgFdcsnDrWEwQcZ6bOOIH?=
 =?us-ascii?Q?zDPKQxvlTm5Hjk7JtzSooVfDMLOXml8i5vz6F6Fwu3VOvy3fxAzbIpsLndAG?=
 =?us-ascii?Q?ULiKJ34jHqOh42J1JNBBeYHhtg0F5qsoC/YrL8escRaQmJm41zr0Yq7u3Y9k?=
 =?us-ascii?Q?uuEwahNZm7vy2KKdjZ2akBi5/PyR6IJtt0zogwX56oQKnEh97kbrlEJeA63x?=
 =?us-ascii?Q?wbMqKPZjsTnVxchg3QYlW9grnqwvAcHTifHeguacHx6jadn6jqagL9J3OxmZ?=
 =?us-ascii?Q?4MYWDT073ciuuI7gQHSAnbPh4N8aqXUYeYbco8zhnV6AKKDp0ZWtB7E+Evlr?=
 =?us-ascii?Q?uPhmOlmL4UDRImCarAQsDrYTM2ouCXUBu3lKJtdHGVlIIsvjxdtGqp7C99Fl?=
 =?us-ascii?Q?8OlyWTivMnBFmHSepMFrYZiN+eAodnI3p9g2INtJoGniu4SI8Q53LWmhKKGF?=
 =?us-ascii?Q?yzihmF0HDy+DD0IMOjjXx1vz8yhwHZOJbwfgL4f9r7KuI+yoqRNiMs90lswL?=
 =?us-ascii?Q?TlZ8B7RFAzYj3Ln48EHXNbq95C4ocJxNPlpIPkRA+HboneSCqNpyUtm/mgrW?=
 =?us-ascii?Q?oLGGL0uqXjpAFmmzQ2loH45Kh/kJJGoY3MgyAHG8gFM2TziFtcKWjp8Gc8Wm?=
 =?us-ascii?Q?fskKGJoSb56l4ZNSMKxVgs2Kt+tZOflw4Sn3PxdAJbNrSqBB4Xc6Yo/ZOJZ2?=
 =?us-ascii?Q?xkOT85b33kBC1WF6k5XjKhNbNuh1oAywt5WOuppqxKiQynFer1n/DwK+gTub?=
 =?us-ascii?Q?avRHxf4IDV5QkUNxTu2mJZ07PauGQbMwEZ7brGSMeDcSz/I1zb8sy56CDMdq?=
 =?us-ascii?Q?+5lTa9DXcl+vc4Zgw/OH30CN1VLYmiMc5ulEavlg+cZjCUhfzyq6qSecN+xm?=
 =?us-ascii?Q?/He/1cWQ0p8cDDOu8mQwRd5T06YuGihQ3Mv7ygOVSMM6aYi54SeHzswjrtM2?=
 =?us-ascii?Q?bQqJSk2VH1DN82Vsx5/64VN2TC3eE0fyZXpcmFQatdnZrtLfMRxtg0Bt4eFV?=
 =?us-ascii?Q?iI8LShYC1QP3ekFGctxt5RJFAMut5Yk0L1lG2et58ow14Fz74fNkIC34T5ZB?=
 =?us-ascii?Q?FK1swbGFpsRlLIngqsHgKI9IubNudeVR3QrbQnOESV7cKTegw8ub1jcwdhEq?=
 =?us-ascii?Q?weMfYP3qYo8Rok1aTdy9p6OT6Brs8LJ7Mn1ozYYoE/Cvlqf0kcyNjR7oc/Tt?=
 =?us-ascii?Q?RLPz20crxBO6WlrcnL4OKT/2j3nOeLf+3vgDoLImjDCz2PaBVm1E5jQVpHUZ?=
 =?us-ascii?Q?ycasw5XnB3u5Tgy4rXG0vKsJxl2QtMm7wAzSRC6/1RkXY4XVzP31sb6W6pmo?=
 =?us-ascii?Q?xlY5AFnc5wnQKN1w4y8+kKJtnjqywh2ay+NMetIZkEjYIotZgdSCHaug8U+q?=
 =?us-ascii?Q?m/1z2FfXphAxMvofgupnx0S4UrEVdVPHQF6N/92F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ad0991-4297-4e5d-ce99-08dadc29c7be
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 10:15:23.3505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U2H4YptSeYgO47ujXbC17GQd8WgQPd4DnL457++nnZGiLjoexrhvMp49qXS0CY/407SDiOPdqWOsQ6UAK/cNzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7379
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 07:18:47PM +0800, Yuan, Perry wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> Add one sysfs entry to control the CPU cores frequency boost state
> The attribute file can allow user to set max performance boosted or
> keeping at normal perf level.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 67 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 65 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index ea9255bdc9ac..4cd53c010215 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -69,6 +69,7 @@ static struct amd_pstate_params global_params;
>  
>  static DEFINE_MUTEX(amd_pstate_limits_lock);
>  static DEFINE_MUTEX(amd_pstate_driver_lock);
> +struct kobject *amd_pstate_kobj;
>  
>  static bool cppc_boost __read_mostly;
>  
> @@ -768,12 +769,46 @@ static ssize_t show_energy_performance_preference(
>  	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
>  }
>  
> +static void amd_pstate_update_policies(void)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu)
> +		cpufreq_update_policy(cpu);
> +}
> +
> +static ssize_t show_cppc_dynamic_boost(struct kobject *kobj,
> +				struct kobj_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%u\n", cppc_boost);
> +}
> +
> +static ssize_t store_cppc_dynamic_boost(struct kobject *a,
> +				       struct kobj_attribute *b,
> +				       const char *buf, size_t count)
> +{
> +	bool new_state;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &new_state);
> +	if (ret)
> +		return -EINVAL;
> +
> +	mutex_lock(&amd_pstate_driver_lock);
> +	cppc_boost = !!new_state;
> +	amd_pstate_update_policies();
> +	mutex_unlock(&amd_pstate_driver_lock);

This patch should wait that after we confirm the iowait boost necessity for
amd-pstate.

Thanks,
Ray

> +
> +	return count;
> +}
> +
>  cpufreq_freq_attr_ro(amd_pstate_max_freq);
>  cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>  
>  cpufreq_freq_attr_ro(amd_pstate_highest_perf);
>  cpufreq_freq_attr_rw(energy_performance_preference);
>  cpufreq_freq_attr_ro(energy_performance_available_preferences);
> +define_one_global_rw(cppc_dynamic_boost);
>  
>  static struct freq_attr *amd_pstate_attr[] = {
>  	&amd_pstate_max_freq,
> @@ -791,6 +826,15 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
>  	NULL,
>  };
>  
> +static struct attribute *pstate_global_attributes[] = {
> +	&cppc_dynamic_boost.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group amd_pstate_global_attr_group = {
> +	.attrs = pstate_global_attributes,
> +};
> +
>  static inline void update_boost_state(void)
>  {
>  	u64 misc_en;
> @@ -1404,9 +1448,28 @@ static int __init amd_pstate_init(void)
>  
>  	ret = cpufreq_register_driver(default_pstate_driver);
>  	if (ret)
> -		pr_err("failed to register amd pstate driver with return %d\n",
> -		       ret);
> +		pr_err("failed to register driver with return %d\n", ret);
> +
> +	amd_pstate_kobj = kobject_create_and_add("amd-pstate", &cpu_subsys.dev_root->kobj);
> +	if (!amd_pstate_kobj) {
> +		ret = -EINVAL;
> +		pr_err("global sysfs registration failed.\n");
> +		goto kobject_free;
> +	}
> +
> +	ret = sysfs_create_group(amd_pstate_kobj, &amd_pstate_global_attr_group);
> +	if (ret) {
> +		pr_err("sysfs attribute export failed with error %d.\n", ret);
> +		goto global_attr_free;
> +	}
> +
> +	return ret;
>  
> +global_attr_free:
> +	kobject_put(amd_pstate_kobj);
> +kobject_free:
> +	cpufreq_unregister_driver(default_pstate_driver);
> +	kfree(cpudata);
>  	return ret;
>  }
>  device_initcall(amd_pstate_init);
> -- 
> 2.34.1
> 
