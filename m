Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8BF5BE3B7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 12:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiITKrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 06:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiITKrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 06:47:15 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A253D5B8;
        Tue, 20 Sep 2022 03:47:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmFxhYNgN+JDzNL9f6f+MboMQzap7ZvgqtDT8by29Vk7yUHIre1CsO8g3XxHhd7PS7PWpOy4fjUIdRluTQ3cTYyVkbbsRAEGcBOmdzrPOy31iK6s15clsMYhPANAZ4Pj5uyd7h156YD5w4hfW4RcjezM4J3+kP0AsWsC/A+ADS+Vra5Sq1Vy+zRGsbqGzQ+G77z/D6wGsFKjmCVWPpO3KFJbm206tIbHMsRzNMEtm9KJMQWr3DhpoCkBc5ENqXKJQG7S3IukCIJyeSiqUvKQMlVJUnL75lyNm4JadnGKtXcssYV4I2JMioXn/TwCZ0fzvOC+QYwT1lLjnMtDhSB7QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07kN+lzHO4Q51J6haA7oN+WeVl6tJ3OKoJBC9k4CS7U=;
 b=Ls/s/pz0eopu+vPuNBPyu5BOdjWgevNiDgSCAo+Xx8JtHTzB7Apx4wtXdV5xj6QamtKw3EWc9EL0ND9pUqWdi48CBHqhuagyeDNrlMnMFzvVcrm9jT0aJLj3aNA5Fa80FucxQS6Lr1CrDPRnNwmEXDXwqDc+lY3//2wuSL7NHTlAYa6UamR+ESeHvvxY7WAatyLuS5n9dNIIEz3cc0WpY/9jsWPIsZQPuyRdq6K56wlR27q3TnHRHMHrXYJfgrylBreIAopq5XETh1XGq00r1P7Im+Ns6dtmg3+waP214zXwnMI/gQnJBXPj1+9bsNKfEQ8HRO7lU5LjunRvRSmk7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07kN+lzHO4Q51J6haA7oN+WeVl6tJ3OKoJBC9k4CS7U=;
 b=DKYxPBCTWf0+yRq1e8MyZQEp2alKKbXeKDz2lUmKhVXRllpwCXkFoO7eIYrh+OxGAY3owiZgMKC4H9GUohVbSwvdkxFvm8Onpq0XQtnb03CohRpj66+zk/uP8HmKcxsyZZbz7Sg66zRteyO54/ZTYQ49vH4QJhdn8VCoGK/mi+Y8AF5yQpNCo2l89f71567VsR+f7HnlAwTno4NGawtL3l7lS43B08CbWVkBHdAkXxI+ImFU8FLOBh5ttmyuV4WImbjhjMJUzHay0lCNSvZt7BAziTlefOhix3fjIsZn0RzLNDhA/BQ2xLzVx3liB7d/ez2SzFhxRZHdb/4HLJym4A==
Received: from BN7PR06CA0039.namprd06.prod.outlook.com (2603:10b6:408:34::16)
 by BL1PR12MB5922.namprd12.prod.outlook.com (2603:10b6:208:399::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Tue, 20 Sep
 2022 10:47:07 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::70) by BN7PR06CA0039.outlook.office365.com
 (2603:10b6:408:34::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14 via Frontend
 Transport; Tue, 20 Sep 2022 10:47:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Tue, 20 Sep 2022 10:47:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 20 Sep
 2022 03:46:56 -0700
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 20 Sep
 2022 03:46:53 -0700
Message-ID: <52d9339e-d9da-3813-fdbd-196c978d9c09@nvidia.com>
Date:   Tue, 20 Sep 2022 16:16:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [Patch] cpufreq: tegra239: Add support for T239
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <viresh.kumar@linaro.org>, <rafael@kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bbasu@nvidia.com>,
        <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>
References: <20220905155759.17743-1-sumitg@nvidia.com>
 <YyMYu9Y38OeaM1WS@orome>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <YyMYu9Y38OeaM1WS@orome>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT042:EE_|BL1PR12MB5922:EE_
X-MS-Office365-Filtering-Correlation-Id: eecd3eac-64f5-46da-b91e-08da9af576a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y3j0+n3QvOBg+KCP9iNWwGeD8AIzJh3GQcIX8pFjOB4Helg6Q4Tltti3s7UVQBQprovGTlEfTOPfO4gqmCKkiAnn/pRjnNMvuPaWFXJITLCLcYGN4i7rQBa6sdh0kB3qAtx0OEmUuLn8EojPAKHPq6hAaxzBHouO5tpu+2TQrbNuenYgy1n9LeF4a4oFW8zvKGQVGV06jDFMVe4ggVuN73fWcX2006L1hX3lmyAE2/1jnyqqVWvc3xuq0qC74oQWZcjmhQ+NgtybrX5mnCe7cmMmWugOdaBNp58SzJx14TAZ/3kj96HaF1k7CJ3iAXfmV02wOChZgomOCDhl/ymnmyKvb74PiP+ZXPIWHkpq3tJQX+kwVJlEQXH1EAJs3f95fLakwE9izP13EL7GN3nfQ5DFccj2fcvttfIIueRy1WwwMcu20pU58MfwVwplKUZfhCqCtYYm342VmUvkVNTQEBDmv8CR+m3dPPS4obh70Bhvp7H8LS4IrFcBp8XoecWGDiYaU3nDprmwHuzreOpvRFPRsfUCA1Kh/JJkVhS0sXg4aBKhZDKSMNozwxx2vghQ6p5Zh9f43wxtI3yg5+kE6MuuGa8iur0ag/LQc0xXHjhkG3k/VHhASpUb3M8t+KyrYO85hE25szHJv9hSvW81EbWIa6p4pcSFHEHg+gCPMee5x74o9yv4MiwFvNOU/kOqQeKePp7YNuLPzi741LlA9IBGBRfzIZDZFvP0kQCjUznQ75YHKq2IvoMCLHQY/O0QjYX1V/9kVaiodtAvjrcgCSZ3k3J2zlW8AFfJS97GXf4=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(316002)(16576012)(36860700001)(82310400005)(83380400001)(47076005)(426003)(4326008)(8676002)(36756003)(70586007)(70206006)(86362001)(31696002)(2906002)(40460700003)(7636003)(356005)(82740400003)(478600001)(31686004)(40480700001)(26005)(53546011)(2616005)(6916009)(54906003)(8936002)(16526019)(336012)(186003)(5660300002)(107886003)(41300700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 10:47:07.2749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eecd3eac-64f5-46da-b91e-08da9af576a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5922
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

Thankyou for the review.
I will do the change and send v2 soon.

Regards,
Sumit Gupta

On 15/09/22 17:51, Thierry Reding wrote:
> Subject:
> Re: [Patch] cpufreq: tegra239: Add support for T239
> From:
> Thierry Reding <thierry.reding@gmail.com>
> Date:
> 15/09/22, 17:51
> 
> To:
> Sumit Gupta <sumitg@nvidia.com>
> CC:
> viresh.kumar@linaro.org, rafael@kernel.org, treding@nvidia.com, 
> jonathanh@nvidia.com, linux-pm@vger.kernel.org, 
> linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
> bbasu@nvidia.com, sanjayc@nvidia.com, ksitaraman@nvidia.com
> 
> 
> External email: Use caution opening links or attachments
> 
> 
> ForwardedMessage.eml
> 
> Subject:
> Re: [Patch] cpufreq: tegra239: Add support for T239
> From:
> Thierry Reding <thierry.reding@gmail.com>
> Date:
> 15/09/22, 17:51
> 
> To:
> Sumit Gupta <sumitg@nvidia.com>
> CC:
> viresh.kumar@linaro.org, rafael@kernel.org, treding@nvidia.com, 
> jonathanh@nvidia.com, linux-pm@vger.kernel.org, 
> linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
> bbasu@nvidia.com, sanjayc@nvidia.com, ksitaraman@nvidia.com
> 
> 
> On Mon, Sep 05, 2022 at 09:27:59PM +0530, Sumit Gupta wrote:
>> Adding support for Tegra239 SoC which has eight cores in
>> a single cluster. Also, moving num_clusters to soc data
>> to avoid over allocating memory for four clusters always.
>>
>> Signed-off-by: Sumit Gupta<sumitg@nvidia.com>
>> ---
>>   drivers/cpufreq/tegra194-cpufreq.c | 29 +++++++++++++++--------------
>>   1 file changed, 15 insertions(+), 14 deletions(-)
> The subject is a little confusing. Typically the prefix refers to the
> driver, so it would be something like "cpufreq: tegra194: ".
> 
> Furthermore, please always spell out Tegra239 for consistency. This
> makes it easier to grep for.
> 
> Otherwise, looks good. So with the above fixed, this is:
> 
> Acked-by: Thierry Reding<treding@nvidia.com>
> 
>> diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
>> index 1216046cf4c2..f38a760da61b 100644
>> --- a/drivers/cpufreq/tegra194-cpufreq.c
>> +++ b/drivers/cpufreq/tegra194-cpufreq.c
>> @@ -38,14 +38,6 @@
>>   /* cpufreq transisition latency */
>>   #define TEGRA_CPUFREQ_TRANSITION_LATENCY (300 * 1000) /* unit in nanoseconds */
>>   
>> -enum cluster {
>> -	CLUSTER0,
>> -	CLUSTER1,
>> -	CLUSTER2,
>> -	CLUSTER3,
>> -	MAX_CLUSTERS,
>> -};
>> -
>>   struct tegra_cpu_ctr {
>>   	u32 cpu;
>>   	u32 coreclk_cnt, last_coreclk_cnt;
>> @@ -67,12 +59,12 @@ struct tegra_cpufreq_ops {
>>   struct tegra_cpufreq_soc {
>>   	struct tegra_cpufreq_ops *ops;
>>   	int maxcpus_per_cluster;
>> +	size_t num_clusters;
>>   	phys_addr_t actmon_cntr_base;
>>   };
>>   
>>   struct tegra194_cpufreq_data {
>>   	void __iomem *regs;
>> -	size_t num_clusters;
>>   	struct cpufreq_frequency_table **tables;
>>   	const struct tegra_cpufreq_soc *soc;
>>   };
>> @@ -166,6 +158,14 @@ static const struct tegra_cpufreq_soc tegra234_cpufreq_soc = {
>>   	.ops = &tegra234_cpufreq_ops,
>>   	.actmon_cntr_base = 0x9000,
>>   	.maxcpus_per_cluster = 4,
>> +	.num_clusters = 3,
>> +};
>> +
>> +const struct tegra_cpufreq_soc tegra239_cpufreq_soc = {
>> +	.ops = &tegra234_cpufreq_ops,
>> +	.actmon_cntr_base = 0x4000,
>> +	.maxcpus_per_cluster = 8,
>> +	.num_clusters = 1,
>>   };
>>   
>>   static void tegra194_get_cpu_cluster_id(u32 cpu, u32 *cpuid, u32 *clusterid)
>> @@ -382,7 +382,7 @@ static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
>>   
>>   	data->soc->ops->get_cpu_cluster_id(policy->cpu, NULL, &clusterid);
>>   
>> -	if (clusterid >= data->num_clusters || !data->tables[clusterid])
>> +	if (clusterid >= data->soc->num_clusters || !data->tables[clusterid])
>>   		return -EINVAL;
>>   
>>   	start_cpu = rounddown(policy->cpu, maxcpus_per_cluster);
>> @@ -433,6 +433,7 @@ static struct tegra_cpufreq_ops tegra194_cpufreq_ops = {
>>   static const struct tegra_cpufreq_soc tegra194_cpufreq_soc = {
>>   	.ops = &tegra194_cpufreq_ops,
>>   	.maxcpus_per_cluster = 2,
>> +	.num_clusters = 4,
>>   };
>>   
>>   static void tegra194_cpufreq_free_resources(void)
>> @@ -525,15 +526,14 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
>>   
>>   	soc = of_device_get_match_data(&pdev->dev);
>>   
>> -	if (soc->ops && soc->maxcpus_per_cluster) {
>> +	if (soc->ops && soc->maxcpus_per_cluster && soc->num_clusters) {
>>   		data->soc = soc;
>>   	} else {
>>   		dev_err(&pdev->dev, "soc data missing\n");
>>   		return -EINVAL;
>>   	}
>>   
>> -	data->num_clusters = MAX_CLUSTERS;
>> -	data->tables = devm_kcalloc(&pdev->dev, data->num_clusters,
>> +	data->tables = devm_kcalloc(&pdev->dev, data->soc->num_clusters,
>>   				    sizeof(*data->tables), GFP_KERNEL);
>>   	if (!data->tables)
>>   		return -ENOMEM;
>> @@ -558,7 +558,7 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
>>   		goto put_bpmp;
>>   	}
>>   
>> -	for (i = 0; i < data->num_clusters; i++) {
>> +	for (i = 0; i < data->soc->num_clusters; i++) {
>>   		data->tables[i] = init_freq_table(pdev, bpmp, i);
>>   		if (IS_ERR(data->tables[i])) {
>>   			err = PTR_ERR(data->tables[i]);
>> @@ -590,6 +590,7 @@ static int tegra194_cpufreq_remove(struct platform_device *pdev)
>>   static const struct of_device_id tegra194_cpufreq_of_match[] = {
>>   	{ .compatible = "nvidia,tegra194-ccplex", .data = &tegra194_cpufreq_soc },
>>   	{ .compatible = "nvidia,tegra234-ccplex-cluster", .data = &tegra234_cpufreq_soc },
>> +	{ .compatible = "nvidia,tegra239-ccplex-cluster", .data = &tegra239_cpufreq_soc },
>>   	{ /* sentinel */ }
>>   };
>>   
>> -- 
>> 2.17.1
>>
> Attachments:
> 
> ForwardedMessage.eml	10.5 KB
> 
