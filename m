Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4402F654F64
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 11:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbiLWK6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 05:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiLWK6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 05:58:44 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F443B401;
        Fri, 23 Dec 2022 02:58:42 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BNAwQ5R069200;
        Fri, 23 Dec 2022 04:58:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1671793106;
        bh=45OPl7Bj08ZVyfYP3E/yQDieU4oItwI+NG29HLaBmyY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=RwK2BPjYyNZ1OLL5KgYCMy0evnBNd9cPf2aXi5oZHHeCxrsFpfOUnZU0xy+PvDH5O
         VS32f4fciEP9mEnSUJgk1lj4wyBQTEuGqSsScZhtkQtk3VVG/Uoz2lcVzMg3y5MJwP
         3ABwJrQP8ERLgOAraSF2iTohFug9T9xekqwLbs18=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BNAwQuU081253
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 23 Dec 2022 04:58:26 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 23
 Dec 2022 04:58:26 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 23 Dec 2022 04:58:26 -0600
Received: from [10.24.69.114] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BNAwMbn057393;
        Fri, 23 Dec 2022 04:58:22 -0600
Message-ID: <73577808-b133-62d4-2c16-670d6a49b067@ti.com>
Date:   Fri, 23 Dec 2022 16:28:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v12 5/6] remoteproc: pru: Add pru_rproc_set_ctable()
 function
Content-Language: en-US
To:     MD Danish Anwar <danishanwar@ti.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Suman Anna <s-anna@ti.com>, Roger Quadros <rogerq@kernel.org>,
        "Andrew F . Davis" <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <srk@ti.com>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20221216053313.2974826-1-danishanwar@ti.com>
 <20221216053313.2974826-6-danishanwar@ti.com>
From:   Md Danish Anwar <a0501179@ti.com>
In-Reply-To: <20221216053313.2974826-6-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

Can you please review this patch.

Thanks,
Danish.

On 16/12/22 11:03, MD Danish Anwar wrote:
> From: Roger Quadros <rogerq@ti.com>
> 
> Some firmwares expect the OS drivers to configure the CTABLE
> entries publishing dynamically allocated memory regions. For
> example, the PRU Ethernet firmwares use the C28 and C30 entries
> for retrieving the Shared RAM and System SRAM (OCMC) areas
> allocated by the PRU Ethernet client driver.
> 
> Provide a way for users to do that through a new API,
> pru_rproc_set_ctable(). The API returns 0 on success and
> a negative value on error.
> 
> NOTE:
> The programmable CTABLE entries are typically re-programmed by
> the PRU firmwares when dealing with a certain block of memory
> during block processing. This API provides an interface to the
> PRU client drivers to publish a dynamically allocated memory
> block with the PRU firmware using a CTABLE entry instead of a
> negotiated address in shared memory. Additional synchronization
> may be needed between the PRU client drivers and firmwares if
> different addresses needs to be published at run-time reusing
> the same CTABLE entry.
> 
> CTABLE for stands for "constant table".
> Each CTable entry just holds the upper address bits so PRU can
> reference to external memory with larger address bits.
> 
> For use case please see
> prueth_sw_emac_config() in "drivers/net/ethernet/ti/prueth_switch.c"
> 
>             /* Set in constant table C28 of PRUn to ICSS Shared memory */
>              pru_rproc_set_ctable(prueth->pru0, PRU_C28, sharedramaddr);
>              pru_rproc_set_ctable(prueth->pru1, PRU_C28, sharedramaddr);
> 
>             /* Set in constant table C30 of PRUn to OCMC memory */
>              pru_rproc_set_ctable(prueth->pru0, PRU_C30, ocmcaddr);
>              pru_rproc_set_ctable(prueth->pru1, PRU_C30, ocmcaddr);
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  drivers/remoteproc/pru_rproc.c | 59 ++++++++++++++++++++++++++++++++++
>  include/linux/pruss.h          | 22 +++++++++++++
>  2 files changed, 81 insertions(+)
> 
> diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
> index 8e2fbe392ef3..176186882acf 100644
> --- a/drivers/remoteproc/pru_rproc.c
> +++ b/drivers/remoteproc/pru_rproc.c
> @@ -120,6 +120,7 @@ struct pru_private_data {
>   * @mapped_irq: virtual interrupt numbers of created fw specific mapping
>   * @pru_interrupt_map: pointer to interrupt mapping description (firmware)
>   * @pru_interrupt_map_sz: pru_interrupt_map size
> + * @rmw_lock: lock for read, modify, write operations on registers
>   * @dbg_single_step: debug state variable to set PRU into single step mode
>   * @dbg_continuous: debug state variable to restore PRU execution mode
>   * @evt_count: number of mapped events
> @@ -137,6 +138,7 @@ struct pru_rproc {
>  	unsigned int *mapped_irq;
>  	struct pru_irq_rsc *pru_interrupt_map;
>  	size_t pru_interrupt_map_sz;
> +	spinlock_t rmw_lock;
>  	u32 dbg_single_step;
>  	u32 dbg_continuous;
>  	u8 evt_count;
> @@ -153,6 +155,23 @@ void pru_control_write_reg(struct pru_rproc *pru, unsigned int reg, u32 val)
>  	writel_relaxed(val, pru->mem_regions[PRU_IOMEM_CTRL].va + reg);
>  }
>  
> +static inline
> +void pru_control_set_reg(struct pru_rproc *pru, unsigned int reg,
> +			 u32 mask, u32 set)
> +{
> +	u32 val;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&pru->rmw_lock, flags);
> +
> +	val = pru_control_read_reg(pru, reg);
> +	val &= ~mask;
> +	val |= (set & mask);
> +	pru_control_write_reg(pru, reg, val);
> +
> +	spin_unlock_irqrestore(&pru->rmw_lock, flags);
> +}
> +
>  static struct rproc *__pru_rproc_get(struct device_node *np, int index)
>  {
>  	struct rproc *rproc;
> @@ -269,6 +288,45 @@ void pru_rproc_put(struct rproc *rproc)
>  }
>  EXPORT_SYMBOL_GPL(pru_rproc_put);
>  
> +/**
> + * pru_rproc_set_ctable() - set the constant table index for the PRU
> + * @rproc: the rproc instance of the PRU
> + * @c: constant table index to set
> + * @addr: physical address to set it to
> + *
> + * Return: 0 on success, or errno in error case.
> + */
> +int pru_rproc_set_ctable(struct rproc *rproc, enum pru_ctable_idx c, u32 addr)
> +{
> +	struct pru_rproc *pru = rproc->priv;
> +	unsigned int reg;
> +	u32 mask, set;
> +	u16 idx;
> +	u16 idx_mask;
> +
> +	if (IS_ERR_OR_NULL(rproc))
> +		return -EINVAL;
> +
> +	if (!rproc->dev.parent || !is_pru_rproc(rproc->dev.parent))
> +		return -ENODEV;
> +
> +	/* pointer is 16 bit and index is 8-bit so mask out the rest */
> +	idx_mask = (c >= PRU_C28) ? 0xFFFF : 0xFF;
> +
> +	/* ctable uses bit 8 and upwards only */
> +	idx = (addr >> 8) & idx_mask;
> +
> +	/* configurable ctable (i.e. C24) starts at PRU_CTRL_CTBIR0 */
> +	reg = PRU_CTRL_CTBIR0 + 4 * (c >> 1);
> +	mask = idx_mask << (16 * (c & 1));
> +	set = idx << (16 * (c & 1));
> +
> +	pru_control_set_reg(pru, reg, mask, set);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pru_rproc_set_ctable);
> +
>  static inline u32 pru_debug_read_reg(struct pru_rproc *pru, unsigned int reg)
>  {
>  	return readl_relaxed(pru->mem_regions[PRU_IOMEM_DEBUG].va + reg);
> @@ -940,6 +998,7 @@ static int pru_rproc_probe(struct platform_device *pdev)
>  	pru->rproc = rproc;
>  	pru->fw_name = fw_name;
>  	pru->client_np = NULL;
> +	spin_lock_init(&pru->rmw_lock);
>  	mutex_init(&pru->lock);
>  
>  	for (i = 0; i < ARRAY_SIZE(mem_names); i++) {
> diff --git a/include/linux/pruss.h b/include/linux/pruss.h
> index 6ea737e995e9..a6bc3df92fee 100644
> --- a/include/linux/pruss.h
> +++ b/include/linux/pruss.h
> @@ -28,13 +28,29 @@ enum pruss_pru_id {
>  	PRUSS_NUM_PRUS,
>  };
>  
> +/*
> + * enum pru_ctable_idx - Configurable Constant table index identifiers
> + */
> +enum pru_ctable_idx {
> +	PRU_C24 = 0,
> +	PRU_C25,
> +	PRU_C26,
> +	PRU_C27,
> +	PRU_C28,
> +	PRU_C29,
> +	PRU_C30,
> +	PRU_C31,
> +};
> +
>  struct device_node;
> +struct rproc;
>  
>  #if IS_ENABLED(CONFIG_PRU_REMOTEPROC)
>  
>  struct rproc *pru_rproc_get(struct device_node *np, int index,
>  			    enum pruss_pru_id *pru_id);
>  void pru_rproc_put(struct rproc *rproc);
> +int pru_rproc_set_ctable(struct rproc *rproc, enum pru_ctable_idx c, u32 addr);
>  
>  #else
>  
> @@ -46,6 +62,12 @@ pru_rproc_get(struct device_node *np, int index, enum pruss_pru_id *pru_id)
>  
>  static inline void pru_rproc_put(struct rproc *rproc) { }
>  
> +static inline int pru_rproc_set_ctable(struct rproc *rproc,
> +				       enum pru_ctable_idx c, u32 addr)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  #endif /* CONFIG_PRU_REMOTEPROC */
>  
>  static inline bool is_pru_rproc(struct device *dev)
