Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DBF733932
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245369AbjFPTFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245744AbjFPTF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:05:27 -0400
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760BB2D5F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 12:05:26 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id AEl3qsN0azGOZAEl3qbxZO; Fri, 16 Jun 2023 21:05:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1686942324;
        bh=/1NDZljZnmXw+wvMypf9in+CWgaJ6Ha7fof+KMEWXkA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=L1UHQQdov53KIZubtn8++RpOhsQ336Ta3YPRBhRuX+L5tPvyLagPQfB5+mOFL66hO
         ZdKc16v0XbvRm3X8+bPz6G2+CG7tdKOqAmJh2pT9xIRa959Pw4eXeNRGbn3lQ4yjPj
         dp7ttXFUrwPSQJF08JZflCBCFkXtuUO1Wj01VGMcDfBwI8F5evSGqQDsx490s3tPPx
         CcWi/aIYBk7nWVuCyg+R1RY3I+/R0XZJ3hQvAZFNpdjJsDFy08URyIiitMJw58wNZD
         qY6d6yPcosQpXXPf/3sf+1e8wlXlYN0U0Bf55QZAaBuukY4Bt2T3APgG+WFl4IYl9o
         0jtudusahc8SA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 16 Jun 2023 21:05:24 +0200
X-ME-IP: 86.243.2.178
Message-ID: <ae77d0ce-9a54-d779-daa2-c429631c8bb7@wanadoo.fr>
Date:   Fri, 16 Jun 2023 21:05:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] soc: sifive: Add SiFive private L2 cache PMU driver
Content-Language: fr
To:     Eric Lin <eric.lin@sifive.com>, conor@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, maz@kernel.org, chenhuacai@kernel.org,
        baolu.lu@linux.intel.com, will@kernel.org,
        kan.liang@linux.intel.com, nnac123@linux.ibm.com,
        pierre.gondois@arm.com, huangguangbin2@huawei.com, jgross@suse.com,
        chao.gao@intel.com, maobibo@loongson.cn,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dslin1010@gmail.com
Cc:     Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>, Nick Hu <nick.hu@sifive.com>
References: <20230616063210.19063-1-eric.lin@sifive.com>
 <20230616063210.19063-3-eric.lin@sifive.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230616063210.19063-3-eric.lin@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 16/06/2023 à 08:32, Eric Lin a écrit :
> From: Greentime Hu <greentime.hu@sifive.com>
> 
> This adds SiFive private L2 cache PMU driver. User
> can use perf tool to profile by event name and event id.
> 
> Example:
> $ perf stat -C 0 -e /sifive_pl2_pmu/inner_acquire_block_btot/
>                  -e /sifive_pl2_pmu/inner_acquire_block_ntob/
>                  -e /sifive_pl2_pmu/inner_acquire_block_ntot/ ls
> 
>   Performance counter stats for 'CPU(s) 0':
> 
>                 300      sifive_pl2_pmu/inner_acquire_block_btot/
>               17801      sifive_pl2_pmu/inner_acquire_block_ntob/
>                5253      sifive_pl2_pmu/inner_acquire_block_ntot/
> 
>         0.088917326 seconds time elapsed
> 
> $ perf stat -C 0 -e /sifive_pl2_pmu/event=0x10001/
>                  -e /sifive_pl2_pmu/event=0x4001/
>                  -e /sifive_pl2_pmu/event=0x8001/ ls
> 
>   Performance counter stats for 'CPU(s) 0':
> 
>                 251      sifive_pl2_pmu/event=0x10001/
>                2620      sifive_pl2_pmu/event=0x4001/
>                 644      sifive_pl2_pmu/event=0x8001/
> 
>         0.092827110 seconds time elapsed
> 
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> Signed-off-by: Eric Lin <eric.lin@sifive.com>
> Reviewed-by: Zong Li <zong.li@sifive.com>
> Reviewed-by: Nick Hu <nick.hu@sifive.com>
> ---

[...]

> +int sifive_pl2_pmu_probe(struct device_node	*pl2_node,
> +			 void __iomem *pl2_base, int cpu)
> +{
> +	struct sifive_pl2_pmu_event *ptr = per_cpu_ptr(&sifive_pl2_pmu_event, cpu);
> +	int ret = -EINVAL;

Nit: no need to init

> +
> +	/* Get counter numbers. */
> +	ret = of_property_read_u32(pl2_node, "sifive,perfmon-counters", &ptr->counters);
> +	if (ret) {
> +		pr_err("Not found sifive,perfmon-counters property\n");
> +		goto early_err;
> +	}
> +	pr_info("perfmon-counters: %d for CPU %d\n", ptr->counters, cpu);
> +
> +	/* Allocate perf_event. */
> +	ptr->events = kcalloc(ptr->counters, sizeof(struct perf_event), GFP_KERNEL);
> +	if (!ptr->events)
> +		return -ENOMEM;
> +
> +	ptr->event_select_base = pl2_base + SIFIVE_PL2_SELECT_BASE_OFFSET;
> +	ptr->event_counter_base = pl2_base + SIFIVE_PL2_COUNTER_BASE_OFFSET;
> +
> +	if (!pl2pmu_init_done) {
> +		ret = perf_pmu_register(sifive_pl2_pmu.pmu, sifive_pl2_pmu.pmu->name, -1);
> +		if (ret) {
> +			cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_SIFIVE_PL2_PMU_ONLINE,
> +						    &sifive_pl2_pmu.node);
> +			pr_err("Failed to register sifive_pl2_pmu.pmu: %d\n", ret);
> +		}
> +		sifive_pl2_pmu_pm_init();
> +		pl2pmu_init_done = true;
> +	}
> +
> +	return 0;
> +
> +early_err:
> +	return ret;
> +}
> +
> +int sifive_pl2_pmu_init(void)
> +{
> +	int ret = 0;

Nit: no need to init

> +
> +	ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_RISCV_SIFIVE_PL2_PMU_ONLINE,
> +				      "perf/sifive/pl2pmu:online",
> +				      sifive_pl2_pmu_online_cpu,
> +				      sifive_pl2_pmu_offline_cpu);
> +	if (ret)
> +		pr_err("Failed to register CPU hotplug notifier %d\n", ret);
> +
> +	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_SIFIVE_PL2_PMU_ONLINE,
> +				       &sifive_pl2_pmu.node);
> +	if (ret)
> +		pr_err("Failed to add hotplug instance: %d\n", ret);
> +
> +	return ret;

Nit: return 0;

> +}

[...]

