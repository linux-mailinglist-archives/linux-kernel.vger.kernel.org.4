Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69075F46A5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 17:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJDP1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 11:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJDP1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 11:27:16 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F711F9CF;
        Tue,  4 Oct 2022 08:27:15 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-132555b7121so7866086fac.2;
        Tue, 04 Oct 2022 08:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ck2o9rd8BgU07rhKbD6c75akrGPzA0cntwt4cHvyrWM=;
        b=X29nDWo6FUKzKODTPnHJczL4YASK7axbIpqN2FHh4/FK4qhhGEO/+zoDxFywsjvrZu
         vFEQELXqT+eNrChxIfJ1dT2g3WJXdD5DaI83hb8pHZYIsVa2uI46MJTFTgVnn2XD7ozF
         3huPoZ1p6i0XTDbtNF2N+4zG5e/3re4sA3eFtEf4gjPrtqddwlY8+0UTIcXg+RJsY0U7
         PjPgQjD9DEJh2LqrtWdx12gHnwR4ZM7RqB6QuhpZ9TlicdCrJcNwKa7dIPQE2YymfxmW
         K26CRQsg9r6a9ONvFbMRDMElvzVjBtzE0XgjHmoWb3SKbJOfhhpPPQK3e1kL9SQb5KaR
         3D0Q==
X-Gm-Message-State: ACrzQf1QjbNIVu3Ja4UXiyDWVtUnFM2WVoZJb1z29nrnDBl8wrKnU/rG
        T66L87SMI2KogAyfJxFNxkZ8DLpWXw==
X-Google-Smtp-Source: AMsMyM5LOSpjArMdZ/0DJaokVEv3tA1cOvTyNYQKcZZv4xm8Ee0hYifkvYgJ1+YxJbijcoDIwkhQHw==
X-Received: by 2002:a05:6870:f692:b0:131:e7b1:b699 with SMTP id el18-20020a056870f69200b00131e7b1b699mr153607oab.133.1664897234626;
        Tue, 04 Oct 2022 08:27:14 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f18-20020a9d5f12000000b00659579f505fsm3058836oti.64.2022.10.04.08.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 08:27:14 -0700 (PDT)
Received: (nullmailer pid 1525401 invoked by uid 1000);
        Tue, 04 Oct 2022 15:27:14 -0000
Date:   Tue, 4 Oct 2022 10:27:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     viresh.kumar@linaro.org, rafael@kernel.org, treding@nvidia.com,
        jonathanh@nvidia.com, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        bbasu@nvidia.com, sanjayc@nvidia.com, ksitaraman@nvidia.com
Subject: Re: [Patch v2] cpufreq: tegra194: Add support for Tegra239
Message-ID: <20221004152714.GA1524940-robh@kernel.org>
References: <20220920110646.27837-1-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920110646.27837-1-sumitg@nvidia.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 04:36:46PM +0530, Sumit Gupta wrote:
> Adding support for Tegra239 SoC which has eight cores in
> a single cluster. Also, moving num_clusters to SoC data
> to avoid over allocating memory for four clusters always.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
> v1 -> v2:
> - updated subject line and commit message.
> - changed type for 'num_clusters' from 'size_t' to 'unsigned int'.
> 
>  drivers/cpufreq/tegra194-cpufreq.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
> index 7e143c06972e..cfc1b225f811 100644
> --- a/drivers/cpufreq/tegra194-cpufreq.c
> +++ b/drivers/cpufreq/tegra194-cpufreq.c
> @@ -38,14 +38,6 @@
>  /* cpufreq transisition latency */
>  #define TEGRA_CPUFREQ_TRANSITION_LATENCY (300 * 1000) /* unit in nanoseconds */
>  
> -enum cluster {
> -	CLUSTER0,
> -	CLUSTER1,
> -	CLUSTER2,
> -	CLUSTER3,
> -	MAX_CLUSTERS,
> -};
> -
>  struct tegra_cpu_ctr {
>  	u32 cpu;
>  	u32 coreclk_cnt, last_coreclk_cnt;
> @@ -67,12 +59,12 @@ struct tegra_cpufreq_ops {
>  struct tegra_cpufreq_soc {
>  	struct tegra_cpufreq_ops *ops;
>  	int maxcpus_per_cluster;
> +	unsigned int num_clusters;
>  	phys_addr_t actmon_cntr_base;
>  };
>  
>  struct tegra194_cpufreq_data {
>  	void __iomem *regs;
> -	size_t num_clusters;
>  	struct cpufreq_frequency_table **tables;
>  	const struct tegra_cpufreq_soc *soc;
>  };
> @@ -166,6 +158,14 @@ static const struct tegra_cpufreq_soc tegra234_cpufreq_soc = {
>  	.ops = &tegra234_cpufreq_ops,
>  	.actmon_cntr_base = 0x9000,
>  	.maxcpus_per_cluster = 4,
> +	.num_clusters = 3,
> +};
> +
> +const struct tegra_cpufreq_soc tegra239_cpufreq_soc = {
> +	.ops = &tegra234_cpufreq_ops,
> +	.actmon_cntr_base = 0x4000,
> +	.maxcpus_per_cluster = 8,
> +	.num_clusters = 1,
>  };
>  
>  static void tegra194_get_cpu_cluster_id(u32 cpu, u32 *cpuid, u32 *clusterid)
> @@ -378,7 +378,7 @@ static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
>  
>  	data->soc->ops->get_cpu_cluster_id(policy->cpu, NULL, &clusterid);
>  
> -	if (clusterid >= data->num_clusters || !data->tables[clusterid])
> +	if (clusterid >= data->soc->num_clusters || !data->tables[clusterid])
>  		return -EINVAL;
>  
>  	start_cpu = rounddown(policy->cpu, maxcpus_per_cluster);
> @@ -429,6 +429,7 @@ static struct tegra_cpufreq_ops tegra194_cpufreq_ops = {
>  static const struct tegra_cpufreq_soc tegra194_cpufreq_soc = {
>  	.ops = &tegra194_cpufreq_ops,
>  	.maxcpus_per_cluster = 2,
> +	.num_clusters = 4,
>  };
>  
>  static void tegra194_cpufreq_free_resources(void)
> @@ -521,15 +522,14 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
>  
>  	soc = of_device_get_match_data(&pdev->dev);
>  
> -	if (soc->ops && soc->maxcpus_per_cluster) {
> +	if (soc->ops && soc->maxcpus_per_cluster && soc->num_clusters) {
>  		data->soc = soc;
>  	} else {
>  		dev_err(&pdev->dev, "soc data missing\n");
>  		return -EINVAL;
>  	}
>  
> -	data->num_clusters = MAX_CLUSTERS;
> -	data->tables = devm_kcalloc(&pdev->dev, data->num_clusters,
> +	data->tables = devm_kcalloc(&pdev->dev, data->soc->num_clusters,
>  				    sizeof(*data->tables), GFP_KERNEL);
>  	if (!data->tables)
>  		return -ENOMEM;
> @@ -554,7 +554,7 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
>  		goto put_bpmp;
>  	}
>  
> -	for (i = 0; i < data->num_clusters; i++) {
> +	for (i = 0; i < data->soc->num_clusters; i++) {
>  		data->tables[i] = init_freq_table(pdev, bpmp, i);
>  		if (IS_ERR(data->tables[i])) {
>  			err = PTR_ERR(data->tables[i]);
> @@ -586,6 +586,7 @@ static int tegra194_cpufreq_remove(struct platform_device *pdev)
>  static const struct of_device_id tegra194_cpufreq_of_match[] = {
>  	{ .compatible = "nvidia,tegra194-ccplex", .data = &tegra194_cpufreq_soc },
>  	{ .compatible = "nvidia,tegra234-ccplex-cluster", .data = &tegra234_cpufreq_soc },
> +	{ .compatible = "nvidia,tegra239-ccplex-cluster", .data = &tegra239_cpufreq_soc },

Not documented.

Rob
