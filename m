Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABF473CE69
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 06:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjFYE1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 00:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjFYE1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 00:27:44 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B96E6E
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 21:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687667260; x=1719203260;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7itPG7Ie4RzGTaFE6LLnqG+xxyzZ6HWS/LZq0PagcE4=;
  b=PbkJgf8m3uDkk+TpTxXzkzqYgj35idejYbhX5mW66NTBf0M7VagVW0cM
   HsGhk9MHyM+ybp/iadpqI9ViX2fgz/XIbl9mn4poprZcPcFvi0AtHyT+Z
   RaX04F+8sQ0ZdL5OgjqItzDuI+nMuKUC0YR8sPFThFh/606WnU3A8KRVp
   66+b7F+Y+pgNGm+7sb+lHU/pGaLLJQZCfchJt3BR2qZkrFa5B255DtIQK
   5gzbPlKRz6zWdScfY5PNYglbFs0zdqm/3VX/gQsE6OPDNimRykOTHkpA/
   Uumfk/y2z5UiRO0CTFh3PB0wLa1fOjcv85l+NbjIDhZCwHTyhUO/zYUhI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="363572645"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="363572645"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2023 21:27:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="889887109"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="889887109"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga005.jf.intel.com with ESMTP; 24 Jun 2023 21:27:38 -0700
Date:   Sun, 25 Jun 2023 12:26:31 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, matthew.gerlach@linux.intel.com
Subject: Re: [PATCH 1/1] regmap: spi-avmm: Fix regmap_bus max_raw_write
Message-ID: <ZJfB9zXhizbqmIrm@yilunxu-OptiPlex-7050>
References: <20230620202824.380313-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620202824.380313-1-russell.h.weight@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-20 at 13:28:24 -0700, Russ Weight wrote:
> The max_raw_write member of the regmap_spi_avmm_bus structure is defined
> as:
> 	.max_raw_write = SPI_AVMM_VAL_SIZE * MAX_WRITE_CNT
> 
> SPI_AVMM_VAL_SIZE == 4 and MAX_WRITE_CNT == 1 so this results in a
> maximum write transfer size of 4 bytes which provides only enough space to
> transfer the address of the target register. It provides no space for the
> value to be transferred. This bug became an issue (divide-by-zero in
> _regmap_raw_write()) after the following was accepted into mainline:
> 
> commit 3981514180c9 ("regmap: Account for register length when chunking")

Sorry for late reply.

IIUC, max_raw_write/read is the max batch *DATA* size that could be
handled by the receiver. reg addr bytes are not counted in. I'm not 100%
sure this is obeyed by all drivers. But see several examples:

static const struct regmap_config ar9331_mdio_regmap_config = {
	.reg_bits = 32,
	.val_bits = 32,
	.reg_stride = 4,
	[...]
};

static struct regmap_bus ar9331_sw_bus = {
	[...]
	.max_raw_read = 4,
	.max_raw_write = 4,
};

Another one:

static struct regmap_config qca8k_regmap_config = {
	.reg_bits = 16,
	.val_bits = 32,
	.reg_stride = 4,
	[...]
	.max_raw_read = 32, /* mgmt eth can read/write up to 8 registers at time */
	.max_raw_write = 32,
}

And regmap-spi.c:

static const struct regmap_bus *regmap_get_spi_bus(struct spi_device *spi,
						   const struct regmap_config *config)
{
	size_t max_size = spi_max_transfer_size(spi);
	size_t max_msg_size, reg_reserve_size;
	struct regmap_bus *bus;

	if (max_size != SIZE_MAX) {
		bus = kmemdup(&regmap_spi, sizeof(*bus), GFP_KERNEL);
		if (!bus)
			return ERR_PTR(-ENOMEM);

		max_msg_size = spi_max_message_size(spi);
		reg_reserve_size = config->reg_bits / BITS_PER_BYTE
				 + config->pad_bits / BITS_PER_BYTE;
		if (max_size + reg_reserve_size > max_msg_size)
			max_size -= reg_reserve_size;

		bus->free_on_exit = true;
		bus->max_raw_read = max_size;
		bus->max_raw_write = max_size;

		return bus;
	}

	return &regmap_spi;
}

So I'm not sure if commit 3981514180c9 is actually necessary.

Thanks,
Yilun

> 
> Change max_raw_write to include space (4 additional bytes) for both the
> register address and value:
> 
> 	.max_raw_write = SPI_AVMM_REG_SIZE + SPI_AVMM_VAL_SIZE * MAX_WRITE_CNT


> 
> Fixes: 7f9fb67358a2 ("regmap: add Intel SPI Slave to AVMM Bus Bridge support")
> Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
>  drivers/base/regmap/regmap-spi-avmm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/regmap/regmap-spi-avmm.c b/drivers/base/regmap/regmap-spi-avmm.c
> index 4c2b94b3e30b..6af692844c19 100644
> --- a/drivers/base/regmap/regmap-spi-avmm.c
> +++ b/drivers/base/regmap/regmap-spi-avmm.c
> @@ -660,7 +660,7 @@ static const struct regmap_bus regmap_spi_avmm_bus = {
>  	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
>  	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
>  	.max_raw_read = SPI_AVMM_VAL_SIZE * MAX_READ_CNT,
> -	.max_raw_write = SPI_AVMM_VAL_SIZE * MAX_WRITE_CNT,
> +	.max_raw_write = SPI_AVMM_REG_SIZE + SPI_AVMM_VAL_SIZE * MAX_WRITE_CNT,
>  	.free_context = spi_avmm_bridge_ctx_free,
>  };
>  
> -- 
> 2.25.1
> 
