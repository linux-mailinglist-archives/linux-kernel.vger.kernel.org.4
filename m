Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A213743968
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 12:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjF3Kds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 06:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjF3Kdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 06:33:44 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB3C30C5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 03:33:42 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qss9C4y4NzqV2n;
        Fri, 30 Jun 2023 18:33:19 +0800 (CST)
Received: from [10.174.185.210] (10.174.185.210) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 18:33:38 +0800
Subject: Re: [PATCH] irqchip/gic-v4.1: Properly lock VPEs when doing a
 directLPI invalidation
To:     Marc Zyngier <maz@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Zenghui Yu <yuzenghui@huawei.com>, <wanghaibin.wang@huawei.com>
References: <20230617073242.3199746-1-maz@kernel.org>
From:   Kunkun Jiang <jiangkunkun@huawei.com>
Message-ID: <b33ea949-a53e-2c81-27fe-31067c94dc76@huawei.com>
Date:   Fri, 30 Jun 2023 18:33:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20230617073242.3199746-1-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.185.210]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2023/6/17 15:32, Marc Zyngier wrote:
> We normally rely on the irq_to_cpuid_[un]lock() primitives to make
> sure nothing will change col->idx while performing a LPI invalidation.
>
> However, these primitives do not cover VPE doorbells, and we have
> some open-coded locking for that. Unfortunately, this locking is
> pretty bogus.
>
> Instead, extend the above primitives to cover VPE doorbells and
> convert the whole thing to it.
I've tested this patch 20+ times with a multi-core VM, which has
pass-through devices (netwrok card and SSD) and GICv4 or GICv4.1
enabled. Both Guest and Host found no exception.

Tested-by: Kunkun Jiang <jiangkunkun@huawei.com>
>
> Fixes: f3a059219bc7 ("irqchip/gic-v4.1: Ensure mutual exclusion between vPE affinity change and RD access")
> Reported-by: Kunkun Jiang <jiangkunkun@huawei.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Zenghui Yu <yuzenghui@huawei.com>
> Cc: wanghaibin.wang@huawei.com
> ---
>   drivers/irqchip/irq-gic-v3-its.c | 75 ++++++++++++++++++++------------
>   1 file changed, 46 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 0ec2b1e1df75..c5cb2830e853 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -273,13 +273,23 @@ static void vpe_to_cpuid_unlock(struct its_vpe *vpe, unsigned long flags)
>   	raw_spin_unlock_irqrestore(&vpe->vpe_lock, flags);
>   }
>   
> +static struct irq_chip its_vpe_irq_chip;
> +
>   static int irq_to_cpuid_lock(struct irq_data *d, unsigned long *flags)
>   {
> -	struct its_vlpi_map *map = get_vlpi_map(d);
> +	struct its_vpe *vpe = NULL;
>   	int cpu;
>   
> -	if (map) {
> -		cpu = vpe_to_cpuid_lock(map->vpe, flags);
> +	if (d->chip == &its_vpe_irq_chip) {
> +		vpe = irq_data_get_irq_chip_data(d);
> +	} else {
> +		struct its_vlpi_map *map = get_vlpi_map(d);
> +		if (map)
> +			vpe = map->vpe;
> +	}
> +
> +	if (vpe) {
> +		cpu = vpe_to_cpuid_lock(vpe, flags);
>   	} else {
>   		/* Physical LPIs are already locked via the irq_desc lock */
>   		struct its_device *its_dev = irq_data_get_irq_chip_data(d);
> @@ -293,10 +303,18 @@ static int irq_to_cpuid_lock(struct irq_data *d, unsigned long *flags)
>   
>   static void irq_to_cpuid_unlock(struct irq_data *d, unsigned long flags)
>   {
> -	struct its_vlpi_map *map = get_vlpi_map(d);
> +	struct its_vpe *vpe = NULL;
> +
> +	if (d->chip == &its_vpe_irq_chip) {
> +		vpe = irq_data_get_irq_chip_data(d);
> +	} else {
> +		struct its_vlpi_map *map = get_vlpi_map(d);
> +		if (map)
> +			vpe = map->vpe;
> +	}
>   
> -	if (map)
> -		vpe_to_cpuid_unlock(map->vpe, flags);
> +	if (vpe)
> +		vpe_to_cpuid_unlock(vpe, flags);
>   }
>   
>   static struct its_collection *valid_col(struct its_collection *col)
> @@ -1433,14 +1451,29 @@ static void wait_for_syncr(void __iomem *rdbase)
>   		cpu_relax();
>   }
>   
> -static void direct_lpi_inv(struct irq_data *d)
> +static void __direct_lpi_inv(struct irq_data *d, u64 val)
>   {
> -	struct its_vlpi_map *map = get_vlpi_map(d);
>   	void __iomem *rdbase;
>   	unsigned long flags;
> -	u64 val;
>   	int cpu;
>   
> +	/* Target the redistributor this LPI is currently routed to */
> +	cpu = irq_to_cpuid_lock(d, &flags);
> +	raw_spin_lock(&gic_data_rdist_cpu(cpu)->rd_lock);
> +
> +	rdbase = per_cpu_ptr(gic_rdists->rdist, cpu)->rd_base;
> +	gic_write_lpir(val, rdbase + GICR_INVLPIR);
> +	wait_for_syncr(rdbase);
> +
> +	raw_spin_unlock(&gic_data_rdist_cpu(cpu)->rd_lock);
> +	irq_to_cpuid_unlock(d, flags);
> +}
> +
> +static void direct_lpi_inv(struct irq_data *d)
> +{
> +	struct its_vlpi_map *map = get_vlpi_map(d);
> +	u64 val;
> +
>   	if (map) {
>   		struct its_device *its_dev = irq_data_get_irq_chip_data(d);
>   
> @@ -1453,15 +1486,7 @@ static void direct_lpi_inv(struct irq_data *d)
>   		val = d->hwirq;
>   	}
>   
> -	/* Target the redistributor this LPI is currently routed to */
> -	cpu = irq_to_cpuid_lock(d, &flags);
> -	raw_spin_lock(&gic_data_rdist_cpu(cpu)->rd_lock);
> -	rdbase = per_cpu_ptr(gic_rdists->rdist, cpu)->rd_base;
> -	gic_write_lpir(val, rdbase + GICR_INVLPIR);
> -
> -	wait_for_syncr(rdbase);
> -	raw_spin_unlock(&gic_data_rdist_cpu(cpu)->rd_lock);
> -	irq_to_cpuid_unlock(d, flags);
> +	__direct_lpi_inv(d, val);
>   }
>   
>   static void lpi_update_config(struct irq_data *d, u8 clr, u8 set)
> @@ -3952,18 +3977,10 @@ static void its_vpe_send_inv(struct irq_data *d)
>   {
>   	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
>   
> -	if (gic_rdists->has_direct_lpi) {
> -		void __iomem *rdbase;
> -
> -		/* Target the redistributor this VPE is currently known on */
> -		raw_spin_lock(&gic_data_rdist_cpu(vpe->col_idx)->rd_lock);
> -		rdbase = per_cpu_ptr(gic_rdists->rdist, vpe->col_idx)->rd_base;
> -		gic_write_lpir(d->parent_data->hwirq, rdbase + GICR_INVLPIR);
> -		wait_for_syncr(rdbase);
> -		raw_spin_unlock(&gic_data_rdist_cpu(vpe->col_idx)->rd_lock);
> -	} else {
> +	if (gic_rdists->has_direct_lpi)
> +		__direct_lpi_inv(d, d->parent_data->hwirq);
> +	else
>   		its_vpe_send_cmd(vpe, its_send_inv);
> -	}
>   }
>   
>   static void its_vpe_mask_irq(struct irq_data *d)
