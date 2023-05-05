Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDAE86F7FB1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjEEJQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjEEJQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:16:21 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763E518922;
        Fri,  5 May 2023 02:16:19 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3459GCfD087717;
        Fri, 5 May 2023 04:16:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683278172;
        bh=913PCdaWN+n0Ch38NTPAuWeCeU4rsJc5zjk3K+t6OUc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=AXHfs82LNZa25KqD2es95FIUCOdRQY72GNlHe0qA6j2PhUSDbwwT4NKZ3rqt/gLt/
         T+xOyjV2h8n5Wdvj6XqMv/C4cD7at1gJV7Y9qyP+uSC9g1JBC0GeO5rz7jgzUdRZkh
         JvoWD0BdXYZvO19akhRRZgvMqTA5ZhcEQi04M/TM=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3459GCIF088672
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 May 2023 04:16:12 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 May 2023 04:16:12 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 May 2023 04:16:12 -0500
Received: from [10.24.69.26] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3459GA8A078651;
        Fri, 5 May 2023 04:16:11 -0500
Message-ID: <0608e366-1b0e-d387-569a-9ed123bc4d69@ti.com>
Date:   Fri, 5 May 2023 14:46:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] spi: lpspi: disable lpspi module irq in DMA mode
Content-Language: en-US
To:     Clark Wang <xiaoning.wang@nxp.com>, <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230505063557.3962220-1-xiaoning.wang@nxp.com>
From:   Dhruva Gole <d-gole@ti.com>
In-Reply-To: <20230505063557.3962220-1-xiaoning.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/05/23 12:05, Clark Wang wrote:
> When all bits of IER are set to 0, we still can observe the lpspi irq events
> when using DMA mode to transfer data.
> 
> So disable irq to avoid the too much irq events.
> 
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> ---
>   drivers/spi/spi-fsl-lpspi.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> index f2341ab99556..4b70038ceb6b 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -910,9 +910,14 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
>   	ret = fsl_lpspi_dma_init(&pdev->dev, fsl_lpspi, controller);
>   	if (ret == -EPROBE_DEFER)
>   		goto out_pm_get;
> -

Any reason to delete this line?

>   	if (ret < 0)
>   		dev_err(&pdev->dev, "dma setup error %d, use pio\n", ret);
> +	else
> +		/*
> +		 * disable LPSPI module IRQ when enable DMA mode successfully,
> +		 * to prevent the unexpected LPSPI module IRQ events.
> +		 */
> +		disable_irq(irq);

Just wondering, have you actually seen any unexpected LPSPI module IRQ
events? If this was causing issues earlier then maybe add a fixes tag?

>   
>   	ret = devm_spi_register_controller(&pdev->dev, controller);
>   	if (ret < 0) {

-- 
Thanks and Regards,
Dhruva Gole
