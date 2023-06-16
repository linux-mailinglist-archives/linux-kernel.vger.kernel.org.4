Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C51733527
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjFPPtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjFPPtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:49:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6BD8295C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 08:49:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F2291FB;
        Fri, 16 Jun 2023 08:50:00 -0700 (PDT)
Received: from [10.57.85.251] (unknown [10.57.85.251])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1404F3F71E;
        Fri, 16 Jun 2023 08:49:14 -0700 (PDT)
Message-ID: <84a7b27a-8a46-5f9c-105d-e00f066131e0@arm.com>
Date:   Fri, 16 Jun 2023 16:49:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/8] ethosu: Add Arm Ethos-U driver
Content-Language: en-GB
To:     Alison Wang <alison.wang@nxp.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     leoyang.li@nxp.com, xuelin.shi@nxp.com, xiaofeng.ren@nxp.com,
        feng.guo@nxp.com
References: <20230616055913.2360-1-alison.wang@nxp.com>
 <20230616055913.2360-2-alison.wang@nxp.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230616055913.2360-2-alison.wang@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-16 06:59, Alison Wang wrote:
[...]
> +/*
> + * The 'dma-ranges' device tree property for shared dma memory does not seem
> + * to be fully supported for coherent memory. Therefor we apply the DMA range
> + * offset ourselves.
> + */

NAK - if there's a bug in the core code, that wants to be fixed, not 
bodged around by individual drivers. However from the look of the code 
here, the driver appears to be misusing the property in an incorrect 
manner anyway. But of course there's no devicetree binding here, so we 
don't even really know what it thinks it expects... :/

I'd also agree with Greg that this is definitely not a firmware driver. 
IIUC it's not so much a driver for the Ethos-U NPU itself, but one for 
this particular subsystem configuration where requests to the NPU are 
proxied through a dedicated Cortex-M core. As such, if you don't think 
it belongs in drivers/accel, then drivers/remoteproc might be the next 
most relevant choice. Also, is there a more specific name for this 
particular subsystem, or is there a general expectation that this is the 
only way an Ethos-U should ever be exposed to Linux, and it should never 
have direct access to the hardware (as it would with an Ethos-N), and 
thus there's no chance of ending up with multiple different "Ethos-U" 
drivers in future?

Thanks,
Robin.

> +static dma_addr_t ethosu_buffer_dma_ranges(struct device *dev,
> +					   dma_addr_t dma_addr,
> +					   size_t dma_buf_size)
> +{
> +	struct device_node *node = dev->of_node;
> +	const __be32 *ranges;
> +	int len;
> +	int naddr;
> +	int nsize;
> +	int inc;
> +	int i;
> +
> +	if (!node)
> +		return dma_addr;
> +
> +	/* Get the #address-cells and #size-cells properties */
> +	naddr = of_n_addr_cells(node);
> +	nsize = of_n_size_cells(node);
> +
> +	/* Read the 'dma-ranges' property */
> +	ranges = of_get_property(node, "dma-ranges", &len);
> +	if (!ranges || len <= 0)
> +		return dma_addr;
> +
> +	dev_dbg(dev, "ranges=%p, len=%d, naddr=%d, nsize=%d\n",
> +		ranges, len, naddr, nsize);
> +
> +	len /= sizeof(*ranges);
> +	inc = naddr + naddr + nsize;
> +
> +	for (i = 0; (i + inc) <= len; i += inc) {
> +		dma_addr_t daddr;
> +		dma_addr_t paddr;
> +		dma_addr_t size;
> +
> +		daddr = of_read_number(&ranges[i], naddr);
> +		paddr = of_read_number(&ranges[i + naddr], naddr);
> +		size = of_read_number(&ranges[i + naddr + naddr], nsize);
> +
> +		dev_dbg(dev, "daddr=0x%llx, paddr=0x%llx, size=0x%llx\n",
> +			daddr, paddr, size);
> +
> +		if (dma_addr >= paddr &&
> +		    (dma_addr + dma_buf_size) < (paddr + size))
> +			return dma_addr + daddr - paddr;
> +	}
> +
> +	return dma_addr;
> +}
