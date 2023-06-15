Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D0B7322D5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjFOWkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjFOWkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:40:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9DF271C;
        Thu, 15 Jun 2023 15:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=rTef7a63KNQH6q3WD5RtrkA98bSlXC3sIaMOsAmrFcM=; b=fXXB40CfrwyBYWYox5xSovHXoe
        LcKMGnUyhm1wkcZWzwApUEuC9vh02ZegJBPhftlYhJJTXS7SIoZ7jR5orti08KYMIcuY2bEH1RMha
        7OzXOLhFAcq9S8499kMlpv7WXjZAgggpBrh+1zTpTRzurWgxjz/2xM+MRrYWi0Sz0PM+/VnXMqdW3
        /1usV3MYBG1eZ4jQmvABGF9ntB/uCXBzR+bKD3LW/ggL9yixwC6pdA6Nei6yRkosiZbW9b8EmNJdn
        gAlVOI8LcCcTRt2V4LnsNumb77nzyN+I9Z5CYaLrJ2vUppow2w2ZhYR3koSTj0+6U/XJ6wsRNkoov
        I0s3u84Q==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q9vdJ-00GGRx-2x;
        Thu, 15 Jun 2023 22:40:01 +0000
Message-ID: <9ebb9a5a-7bc8-da67-529f-5193b9352b23@infradead.org>
Date:   Thu, 15 Jun 2023 15:40:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] remoteproc: stm32: use correct format strings on 64-bit
To:     Arnd Bergmann <arnd@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ben Levinsky <ben.levinsky@amd.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <20230609120546.3937821-1-arnd@kernel.org>
Content-Language: en-US
In-Reply-To: <20230609120546.3937821-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/9/23 05:05, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> With CONFIG_ARCH_STM32 making it into arch/arm64, a couple of format
> strings no longer work, since they rely on size_t being compatible
> with %x, or they print an 'int' using %z:
> 
> drivers/remoteproc/stm32_rproc.c: In function 'stm32_rproc_mem_alloc':
> drivers/remoteproc/stm32_rproc.c:122:22: error: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'size_t' {aka 'long unsigned int'} [-Werror=format=]
> drivers/remoteproc/stm32_rproc.c:122:40: note: format string is defined here
>   122 |         dev_dbg(dev, "map memory: %pa+%x\n", &mem->dma, mem->len);
>       |                                       ~^
>       |                                        |
>       |                                        unsigned int
>       |                                       %lx
> drivers/remoteproc/stm32_rproc.c:125:30: error: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'size_t' {aka 'long unsigned int'} [-Werror=format=]
> drivers/remoteproc/stm32_rproc.c:125:65: note: format string is defined here
>   125 |                 dev_err(dev, "Unable to map memory region: %pa+%x\n",
>       |                                                                ~^
>       |                                                                 |
>       |                                                                 unsigned int
>       |                                                                %lx
> drivers/remoteproc/stm32_rproc.c: In function 'stm32_rproc_get_loaded_rsc_table':
> drivers/remoteproc/stm32_rproc.c:646:30: error: format '%zx' expects argument of type 'size_t', but argument 4 has type 'int' [-Werror=format=]
> drivers/remoteproc/stm32_rproc.c:646:66: note: format string is defined here
>   646 |                 dev_err(dev, "Unable to map memory region: %pa+%zx\n",
>       |                                                                ~~^
>       |                                                                  |
>       |                                                                  long unsigned int
>       |                                                                %x
> 
> Fix up all three instances to work across architectures, and enable
> compile testing for this driver to ensure it builds everywhere.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  drivers/remoteproc/Kconfig       | 2 +-
>  drivers/remoteproc/stm32_rproc.c | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index a850e9f486dd6..48845dc8fa852 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -313,7 +313,7 @@ config ST_SLIM_REMOTEPROC
>  
>  config STM32_RPROC
>  	tristate "STM32 remoteproc support"
> -	depends on ARCH_STM32
> +	depends on ARCH_STM32 || COMPILE_TEST
>  	depends on REMOTEPROC
>  	select MAILBOX
>  	help
> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
> index a7457777aae43..cf073bac79f73 100644
> --- a/drivers/remoteproc/stm32_rproc.c
> +++ b/drivers/remoteproc/stm32_rproc.c
> @@ -119,10 +119,10 @@ static int stm32_rproc_mem_alloc(struct rproc *rproc,
>  	struct device *dev = rproc->dev.parent;
>  	void *va;
>  
> -	dev_dbg(dev, "map memory: %pa+%x\n", &mem->dma, mem->len);
> +	dev_dbg(dev, "map memory: %pad+%zx\n", &mem->dma, mem->len);
>  	va = ioremap_wc(mem->dma, mem->len);
>  	if (IS_ERR_OR_NULL(va)) {
> -		dev_err(dev, "Unable to map memory region: %pa+%x\n",
> +		dev_err(dev, "Unable to map memory region: %pad+0x%zx\n",
>  			&mem->dma, mem->len);
>  		return -ENOMEM;
>  	}
> @@ -643,7 +643,7 @@ stm32_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz)
>  
>  	ddata->rsc_va = devm_ioremap_wc(dev, rsc_pa, RSC_TBL_SIZE);
>  	if (IS_ERR_OR_NULL(ddata->rsc_va)) {
> -		dev_err(dev, "Unable to map memory region: %pa+%zx\n",
> +		dev_err(dev, "Unable to map memory region: %pa+%x\n",
>  			&rsc_pa, RSC_TBL_SIZE);
>  		ddata->rsc_va = NULL;
>  		return ERR_PTR(-ENOMEM);

-- 
~Randy
