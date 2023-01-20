Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E4C674AA0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjATEcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjATEbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:31:45 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553FFB2E4B
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 20:31:16 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30K4UDN0117944;
        Thu, 19 Jan 2023 22:30:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674189013;
        bh=iezSynNH5W1oFTWX7VE7fYRtxIVPYwi3S16nlZLNrIc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=p9/6wEPY16TKS1V4cFMywOK3klEnssGDfRunmqGvKUXBQImQaleB986h94DZ13CYR
         h1PPsT1URYRc2/FZC2XEco1Q3APXhHjIdgKTtH0KU0Eor4JUlQ0XzTQL0U75bUz0FU
         +WzvjJDPYc0FwFYXoY2WNHviv1DJvbdEkWXghdBM=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30K4UDOE094394
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Jan 2023 22:30:13 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 19
 Jan 2023 22:30:13 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 19 Jan 2023 22:30:13 -0600
Received: from [10.24.69.26] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30K4UAwc026047;
        Thu, 19 Jan 2023 22:30:10 -0600
Message-ID: <6a5f3395-8f1f-5bc3-29ce-205686ff704a@ti.com>
Date:   Fri, 20 Jan 2023 10:00:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] mtd: spinand: macronix: use scratch buffer for DMA
 operation
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     Mason Yang <masonccyang@mxic.com.tw>,
        Jianhui Zhao <zhaojh329@gmail.com>
References: <Y8i85zM0u4XdM46z@makrotopia.org>
From:   Dhruva Gole <d-gole@ti.com>
In-Reply-To: <Y8i85zM0u4XdM46z@makrotopia.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 19/01/23 09:15, Daniel Golle wrote:
> The mx35lf1ge4ab_get_eccsr() function uses an SPI DMA operation to
> read the eccsr, hence the buffer should not be on stack. Since commit
> 380583227c0c7f ("spi: spi-mem: Add extra sanity checks on the op param")
> the kernel emmits a warning and blocks such operations.

Good catch!

> 
> Use the scratch buffer to get eccsr instead of trying to directly read
> into a stack-allocated variable.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---

Reviewed-by: Dhruva Gole <d-gole@ti.com>

>   drivers/mtd/nand/spi/macronix.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
> index dce835132a1e2..722a9738ba370 100644
> --- a/drivers/mtd/nand/spi/macronix.c
> +++ b/drivers/mtd/nand/spi/macronix.c
> @@ -83,9 +83,10 @@ static int mx35lf1ge4ab_ecc_get_status(struct spinand_device *spinand,
>   		 * in order to avoid forcing the wear-leveling layer to move
>   		 * data around if it's not necessary.
>   		 */
> -		if (mx35lf1ge4ab_get_eccsr(spinand, &eccsr))
> +		if (mx35lf1ge4ab_get_eccsr(spinand, spinand->scratchbuf))
>   			return nanddev_get_ecc_conf(nand)->strength;
>   
> +		eccsr = *spinand->scratchbuf;
>   		if (WARN_ON(eccsr > nanddev_get_ecc_conf(nand)->strength ||
>   			    !eccsr))
>   			return nanddev_get_ecc_conf(nand)->strength;

-- 
Thanks and Regards,
Dhruva Gole
