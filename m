Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716D466DFBB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjAQN6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjAQN5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:57:55 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E033CE32;
        Tue, 17 Jan 2023 05:57:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQQ4oGzWsgjCJDpbwPutBhItw0eGNd085kJ5amK0mCNachExcQQMeVH+UZXfB/R2qiZFX9Eou2joULE8TgUHlLu3E5GGwmqEVGfABBn8UuN0VIqPUIZJU+s2CxaKqzTPG9GlkIVj3qFftvHXWjwI55smwGiWfoM2BIONyVgppanZfZGUi7AA47AUdqAIxLdUScvHhw2EMHmyBBOvFdJQh0AKd73bObSpUpi3JGjWJijbjtTQNkK5OFR0YrlsVc9Cw7/YnDPHWQvdPCXQQHzn6aUerqencuQdxSs7PAuFYuOJmg20EMXFyRAPD0Wmh3gUWsQktwikaE27qUxmg/FLpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wg0F2rm0d5AV3mn+fHv4ghcVb2tFJnbS9qSW5UqiG1o=;
 b=CgH3yIfjumvdM5GIf6HAN/+Uep4V6fq5e2thti6MTsHJRhd2C1mu29ivSLK+J+qzLc+FcdBfo6lsRPZ1u4zcsq7DanyQ6nt2kczCjTJS9pSaS6RxJf3FDp/ool7TcJqSdSAD2xg2A492Mq/nexg42ElrMu6nhaqzza0L0+Bx5H+KwCimL76mT58KHmGPIofT5s59KCqKGZmSS2TV11eol9H29qga/niwZBuPg3eDqiwcTOq9P8p+zS/yM2bCFKcplAhLNX+0t9zZ7R8xwrTE+5HpODxO3z++tkVUqb0JoZTY3ALIHSPI+8tKaKojTDccL+BanLtscHElV38FcSNZMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wg0F2rm0d5AV3mn+fHv4ghcVb2tFJnbS9qSW5UqiG1o=;
 b=gHlwHGDXhAhfVniSXo5ian1ZIkAS4LrbCNOR/6eaqdnrJjnvc0XZwpT62mI3WpQ2wkT1w41RR8NrtART1NSkE03haMGjHCGCuoB1AYVAJv/k7LOAxIf0jYbeU6KX5XCNCcS05XhVD1Dape10d893tXoBHyQmtzTeT0kI+4zxJ0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 PH8PR12MB6699.namprd12.prod.outlook.com (2603:10b6:510:1ce::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.22; Tue, 17 Jan
 2023 13:57:10 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::d17b:f929:12fd:8ae]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::d17b:f929:12fd:8ae%4]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 13:57:10 +0000
Date:   Tue, 17 Jan 2023 21:56:48 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>
Cc:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 08/12] cpufreq: amd-pstate: add driver working mode
 switch support
Message-ID: <Y8apIMZ3b+dLrpA7@amd.com>
References: <20230106061420.95715-1-perry.yuan@amd.com>
 <20230106061420.95715-9-perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106061420.95715-9-perry.yuan@amd.com>
X-ClientProxiedBy: TYCPR01CA0129.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::16) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|PH8PR12MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: ff6eec30-e269-4581-f9d5-08daf892b9f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FXEInV5E/JCUYrzdr3wwDEjof1S3ElCsW8fUSYBKwPfcv2+oTcerKudIH1dMhM1NG/AjlEFsWo42HWcopRqesQ+5M3QuokZ6Q5RCCNsaxeVQX923XdBydfETHKEMOUYc4vhBfSdy/8RsMlqe3HTxeJ0Omqs1BPlMa5Bx6kyE1AoCMq4P8Q9fw35aOPx2TMEqW16c/RRLDDWAdJ2jph78sZzGd0/O5YVnBJM1Ms4nHnr2oIlrkdaFzoUjz1JU05deo2kuNXun21o9nW2YD1ORbr2NZoKg5TIUlGZkR+wy+OYDc9Yb5Ucs8S87KWPFQ2VbFGxCel96bcGXZ/h/gwsA+fzUUX2KLAIBDtBwKchqXdBffTRD/OiwcUJrmCKgD2MXLOvhkOJ5Uw4vpUnQKU6/0/jlB5t9MFCJbQjh4Zysz6INmRm7r1peYXBeXCmM6AyS44qypa32lE/Iix7MMJHlElICVzEyfH78qhvCg00UNRub4q38Z+AVhJx6kMB6AnciL0WQdxEFm1StqCj45Hl2FsoTfHA/0xTFikYzyIPRkRoJ9Ja7LsU9NI/E3Uvf3LAnyhC66xgOTe8R6HZBfivcH8aFfVEXYduB/aOfhfMhLosbm/y4xzgzqfJcPqeqSnES9ZRFulGgyibTWwXLTSPZGgmufVS3R2lF2hTXhBaRcfe9/LbjbZ6pA3LX3yvBNEQr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199015)(8936002)(478600001)(5660300002)(6486002)(4326008)(26005)(41300700001)(66476007)(66556008)(36756003)(66946007)(8676002)(2906002)(54906003)(86362001)(6636002)(110136005)(38100700002)(6666004)(186003)(6512007)(316002)(6506007)(2616005)(83380400001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vWaCoC6mPlThlsJVr8oK4hsYzzhQJF3PyvCVyzw5sx7NAOCEIyQi7bOVbklI?=
 =?us-ascii?Q?XX4s0hdevWGjOaJ0HnbNgKTcucvwReu87rplgK/UWsjUdpmzDUu2grmw2pyQ?=
 =?us-ascii?Q?TdO/OH1A1GAEQsvkXI7Is2TfpcAZr1aDP0uRc+4jHLRIXkVcPTJlMb9HqIUq?=
 =?us-ascii?Q?UEZPY7jBYs9MdrHRw49bbtDphTi+KlRQaS+ujZhv+771rGtLXqGnmX/jM3A9?=
 =?us-ascii?Q?s9QvV7wDb0uo2C7ziAcIFz9SVrq8JTnldnUW1lkdkVgflqLYcdhjvbzuC4vL?=
 =?us-ascii?Q?BZj9uD1GZ1Dnwgphu4cgaGXhjorFHIRGNEsAFRE4wPEVy4KzNfCvTuN3DkrH?=
 =?us-ascii?Q?BizDi0prZMlj766ceM6p0QmZmi2uXPPLSq1tAITZvA31mvz024Q6k3o4oqK8?=
 =?us-ascii?Q?YgS4OT9xQ60xdazpmIHgYBQLVZ2JHeDolwvYKm2nrbHvJneSabUAFl2N3BfW?=
 =?us-ascii?Q?b+WxFZiExml0qumsMErXU25cn8andROkLqn7anBCxulaoKCsMq+KgOZPhghK?=
 =?us-ascii?Q?UtQ9tvaxI6eM58Gm7ZbgXQFnSK6DmYp69AItTSuuIaj3mewRY9oZef15qwtR?=
 =?us-ascii?Q?3aBZfSmXfjsYCzBZYon2n8vqkhrt+44SM6HYFONklmoO326P5HuvNhQIVUSj?=
 =?us-ascii?Q?R+iTGDIv+KHHDXncK6uf4IN2YSP8nb9V4F2EKub3wuiRt044AHPAwkHzZIYI?=
 =?us-ascii?Q?yzzIhrMdLZPmbqGfOZp2JjPsE4NX/h3EZSrrTIzOrLyIec4BSBFOOFyTPBm0?=
 =?us-ascii?Q?hSW/wehcAtOxTeEQb4lc2U3vN8WZLkdWXX6yIZJ4wBzT6rO3+GLFdStQLMZW?=
 =?us-ascii?Q?Z0ZSscN+wjNEwxhH3KB0jrH+aDVGXO7Wz0Z077fnJqp7pxv1dbQ3kR7N6ccu?=
 =?us-ascii?Q?ZyaBUzggCAU25HxI/Uf/jHkAiT6vnYNtMPkbllfd3HUloy2h2CUJgMqoy6Q5?=
 =?us-ascii?Q?NH0wst1C7olhXOvdXbY7xqgz6HkNOYhUsJJTokQN8Z8gpAI8aGEmmiOkEIFC?=
 =?us-ascii?Q?tjsjKqllKCO0KuTySMzMb+Llq1MzztW6OCca1EbWHYUUz/wyAIKgbV3h4VNc?=
 =?us-ascii?Q?k1dFno7NCotqMFa0zeRFHrriXFQuHl3R7xn4DeDCidNU7rKn5AsqAhSs975L?=
 =?us-ascii?Q?LzmL9qedMD+wwidZiIRZ+12tWCwgVhPkioHKh0dcPLQwCfhz5g/F4sBx6tFD?=
 =?us-ascii?Q?Wksm0Z3mktwvCddBkc4e7c59AnGdk6BwdB4Srdev3Di84UESjf43kom46OuZ?=
 =?us-ascii?Q?aUr2U5yo/HUYU9OR+cIPYEdmbGZD1iC6LC1Vhla2YHPRAGyk30WLpSIFcQil?=
 =?us-ascii?Q?okGqpoFDezEuChakBo5QZZNM8MR+g4QaRp+mA8ZGbPzRR9Yh+HcDhbhEAqB/?=
 =?us-ascii?Q?LYGyPeoLq0JmgGogTCAx0zTIe8spNFodjWWEb3/+ltQQF6mmLPMEjHo7K7Pk?=
 =?us-ascii?Q?ZCP2Pz9uSlfRwPB+U8ZCQw4pvQCTczvEoQHOkZJi5kP1U9JKYeiTLBh10FME?=
 =?us-ascii?Q?F3SiUInLWnOx+6L+9te+DbX9DhuHeVKURU9BDvfqU3ywK8SoFkYYXthQwnaE?=
 =?us-ascii?Q?5hpAvgG2UjKe0jzQyDK+bHkP5ALaLMRummUv20Ye?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6eec30-e269-4581-f9d5-08daf892b9f4
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 13:57:09.7130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VlzaBlzc1sWUn4XO6qaL7sPWlkrwD4vMMeCuSz9Xno/jGMlMyzU4Q+EvQbhTjb5dQmXehKiVl1t9+UTcLUDAfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6699
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 02:14:16PM +0800, Yuan, Perry wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> While amd-pstate driver was loaded with specific driver mode, it will
> need to check which mode is enabled for the pstate driver,add this sysfs
> entry to show the current status
> 
> $ cat /sys/devices/system/cpu/amd-pstate/status
> active
> 
> Meanwhile, user can switch the pstate driver mode with writing mode
> string to sysfs entry as below.
> 
> Enable passive mode:
> $ sudo bash -c "echo passive >  /sys/devices/system/cpu/amd-pstate/status"
> 
> Enable active mode (EPP driver mode):
> $ sudo bash -c "echo active > /sys/devices/system/cpu/amd-pstate/status"
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>

Patch is Acked-by: Huang Rui <ray.huang@amd.com>

Wyes, may we have a ack or any comment from you of this patch, as you are
working on the new guided autonomous mode?

Thanks,
Ray

> ---
>  drivers/cpufreq/amd-pstate.c | 118 +++++++++++++++++++++++++++++++++++
>  1 file changed, 118 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 2c8b126cec5a..d3f4cdd803f3 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -63,6 +63,7 @@ static struct cpufreq_driver *current_pstate_driver;
>  static struct cpufreq_driver amd_pstate_driver;
>  static struct cpufreq_driver amd_pstate_epp_driver;
>  static int cppc_state = AMD_PSTATE_DISABLE;
> +struct kobject *amd_pstate_kobj;
>  
>  static inline int get_mode_idx_from_str(const char *str, size_t size)
>  {
> @@ -631,6 +632,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  	policy->driver_data = cpudata;
>  
>  	amd_pstate_boost_init(cpudata);
> +	if (!current_pstate_driver->adjust_perf)
> +		current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
>  
>  	return 0;
>  
> @@ -771,12 +774,99 @@ static ssize_t show_energy_performance_preference(
>  	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
>  }
>  
> +static ssize_t amd_pstate_show_status(char *buf)
> +{
> +	if (!current_pstate_driver)
> +		return sysfs_emit(buf, "disable\n");
> +
> +	return sysfs_emit(buf, "%s\n", amd_pstate_mode_string[cppc_state]);
> +}
> +
> +static void amd_pstate_driver_cleanup(void)
> +{
> +	current_pstate_driver = NULL;
> +}
> +
> +static int amd_pstate_update_status(const char *buf, size_t size)
> +{
> +	int ret;
> +	int mode_idx;
> +
> +	if (size > 7 || size < 6)
> +		return -EINVAL;
> +	mode_idx = get_mode_idx_from_str(buf, size);
> +
> +	switch(mode_idx) {
> +	case AMD_PSTATE_DISABLE:
> +		if (!current_pstate_driver)
> +			return -EINVAL;
> +		if (cppc_state == AMD_PSTATE_ACTIVE)
> +			return -EBUSY;
> +		ret = cpufreq_unregister_driver(current_pstate_driver);
> +		amd_pstate_driver_cleanup();
> +		break;
> +	case AMD_PSTATE_PASSIVE:
> +		if (current_pstate_driver) {
> +			if (current_pstate_driver == &amd_pstate_driver)
> +				return 0;
> +			cpufreq_unregister_driver(current_pstate_driver);
> +			cppc_state = AMD_PSTATE_PASSIVE;
> +			current_pstate_driver = &amd_pstate_driver;
> +		}
> +
> +		ret = cpufreq_register_driver(current_pstate_driver);
> +		break;
> +	case AMD_PSTATE_ACTIVE:
> +		if (current_pstate_driver) {
> +			if (current_pstate_driver == &amd_pstate_epp_driver)
> +				return 0;
> +			cpufreq_unregister_driver(current_pstate_driver);
> +			current_pstate_driver = &amd_pstate_epp_driver;
> +			cppc_state = AMD_PSTATE_ACTIVE;
> +		}
> +
> +		ret = cpufreq_register_driver(current_pstate_driver);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static ssize_t show_status(struct kobject *kobj,
> +			   struct kobj_attribute *attr, char *buf)
> +{
> +	ssize_t ret;
> +
> +	mutex_lock(&amd_pstate_driver_lock);
> +	ret = amd_pstate_show_status(buf);
> +	mutex_unlock(&amd_pstate_driver_lock);
> +
> +	return ret;
> +}
> +
> +static ssize_t store_status(struct kobject *a, struct kobj_attribute *b,
> +			    const char *buf, size_t count)
> +{
> +	char *p = memchr(buf, '\n', count);
> +	int ret;
> +
> +	mutex_lock(&amd_pstate_driver_lock);
> +	ret = amd_pstate_update_status(buf, p ? p - buf : count);
> +	mutex_unlock(&amd_pstate_driver_lock);
> +
> +	return ret < 0 ? ret : count;
> +}
> +
>  cpufreq_freq_attr_ro(amd_pstate_max_freq);
>  cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>  
>  cpufreq_freq_attr_ro(amd_pstate_highest_perf);
>  cpufreq_freq_attr_rw(energy_performance_preference);
>  cpufreq_freq_attr_ro(energy_performance_available_preferences);
> +define_one_global_rw(status);
>  
>  static struct freq_attr *amd_pstate_attr[] = {
>  	&amd_pstate_max_freq,
> @@ -794,6 +884,15 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
>  	NULL,
>  };
>  
> +static struct attribute *pstate_global_attributes[] = {
> +	&status.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group amd_pstate_global_attr_group = {
> +	.attrs = pstate_global_attributes,
> +};
> +
>  static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  {
>  	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> @@ -1153,6 +1252,25 @@ static int __init amd_pstate_init(void)
>  	if (ret)
>  		pr_err("failed to register with return %d\n", ret);
>  
> +	amd_pstate_kobj = kobject_create_and_add("amd_pstate", &cpu_subsys.dev_root->kobj);
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
> +
> +global_attr_free:
> +	kobject_put(amd_pstate_kobj);
> +kobject_free:
> +	cpufreq_unregister_driver(current_pstate_driver);
>  	return ret;
>  }
>  device_initcall(amd_pstate_init);
> -- 
> 2.34.1
> 
