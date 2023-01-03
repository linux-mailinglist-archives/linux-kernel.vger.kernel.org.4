Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A11B65BC95
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 09:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbjACI6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 03:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbjACI6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 03:58:07 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C3EE42;
        Tue,  3 Jan 2023 00:58:05 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3038vp7o028382;
        Tue, 3 Jan 2023 02:57:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672736271;
        bh=fvLcQsFoerdZp1NUVoU+fVtrbVImgnCozdSyZvf657M=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Ws9Cub/+7w0PKUQPemZMSjxO6nIE3aQwNakI9rlkq2TE7mFt0n1yJH4pbWvFWPOQN
         xpVq8l5E6wpl6tJ2hsLYYI6/ujth4H1eQf9iG1ZMYnIeM6yO+DcMD9WNYNhS+kOa8H
         ujThcf+BQDhms0GDaLV/DZFanIFiFzjoRI7r6SwA=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3038vppn017272
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Jan 2023 02:57:51 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 3
 Jan 2023 02:57:50 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 3 Jan 2023 02:57:50 -0600
Received: from [10.24.69.26] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3038vmhl060761;
        Tue, 3 Jan 2023 02:57:49 -0600
Message-ID: <e9be3f95-c33d-2e76-0ceb-17627973ec29@ti.com>
Date:   Tue, 3 Jan 2023 14:27:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] spi: pl022: Only use DT-specified DMA channels
Content-Language: en-US
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>
CC:     <kernel@axis.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230102160852.3090202-1-vincent.whitchurch@axis.com>
From:   Dhruva Gole <d-gole@ti.com>
In-Reply-To: <20230102160852.3090202-1-vincent.whitchurch@axis.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Vincent,

On 02/01/23 21:38, Vincent Whitchurch wrote:
> When a platform is booted with devicetree and does not provide a
> platform data structure, the driver creates one internally.  enable_dma
> should not be set in this structure when creating it; the probe function
> will set it later if DMA channels are specified via the devicetree.

Yeah, I agree.

> 
> Setting enable_dma = 1 when creating this internal platform data can
> lead to pl022_dma_probe() finding bogus DMA channels (since there is no
> channel filter specified) when no DMA channels are specified in the
> devicetree.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---

Acked-by: Dhruva Gole <d-gole@ti.com>

>   drivers/spi/spi-pl022.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index e4484ace584e..a17ff839117f 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -2091,7 +2091,6 @@ pl022_platform_data_dt_get(struct device *dev)
>   		return NULL;
>   
>   	pd->bus_id = -1;
> -	pd->enable_dma = 1;
>   	of_property_read_u32(np, "pl022,autosuspend-delay",
>   			     &pd->autosuspend_delay);
>   	pd->rt = of_property_read_bool(np, "pl022,rt");

-- 
Thanks and Regards,
Dhruva Gole
