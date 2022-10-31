Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BC7613930
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 15:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiJaOnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 10:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiJaOnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:43:31 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94248FD30;
        Mon, 31 Oct 2022 07:43:30 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29VEh2LZ002087;
        Mon, 31 Oct 2022 09:43:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667227382;
        bh=xKMheBe6+tALckGCgXRgq0Nenx9e5EqobLOp//FbZXY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=EEEOmiorUFfhlYJP4Kmp+Tqf3wLsmqWR8VoUSQQuL9bG3CnyXcDGVfEXzItcJDkYw
         /zH1whRx6xA+3ul9TnsKgSdght7iimEz4LkD5hcW9igiQVVPxru4JLh1ECQzz3/diM
         sOjEbNeTiSRneF9jkWzMR23AZX2EESkSBVTSKoUY=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29VEh299006573
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Oct 2022 09:43:02 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 31
 Oct 2022 09:43:02 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 31 Oct 2022 09:43:02 -0500
Received: from [10.250.234.171] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29VEgu2P021939;
        Mon, 31 Oct 2022 09:42:57 -0500
Message-ID: <ceaf4036-12f8-0cfe-9cdc-37d2ef96bd76@ti.com>
Date:   Mon, 31 Oct 2022 20:12:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [EXTERNAL] [PATCH] mtd: spi-nor: Fix the number of bytes for the
 dummy cycles
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mtd@lists.infradead.org>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Bayi Cheng <bayi.cheng@mediatek.com>
References: <20221031124633.13189-1-allen-kh.cheng@mediatek.com>
Content-Language: en-US
From:   Dhruva Gole <d-gole@ti.com>
In-Reply-To: <20221031124633.13189-1-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/22 18:16, Allen-KH Cheng wrote:
> The number of bytes used by spi_nor_spimem_check_readop() may be
> incorrect for the dummy cycles. Since nor->read_dummy is not initialized
> before spi_nor_spimem_adjust_hwcaps().
>
> We use both mode and wait state clock cycles instead of nor->read_dummy.
>
> Fixes: 0e30f47232ab ("mtd: spi-nor: add support for DTR protocol")
> Co-developed-by: Bayi Cheng <bayi.cheng@mediatek.com>
> Signed-off-by: Bayi Cheng <bayi.cheng@mediatek.com>
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---

Tested-by: Dhruva Gole <d-gole@ti.com>

>   drivers/mtd/spi-nor/core.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 6c921eb3fadb..8b9c318a0ad4 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -1914,7 +1914,8 @@ static int spi_nor_spimem_check_readop(struct spi_nor *nor,
>   	spi_nor_spimem_setup_op(nor, &op, read->proto);
>   
>   	/* convert the dummy cycles to the number of bytes */
> -	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
> +	op.dummy.nbytes = (read->num_mode_clocks + read->num_wait_states) *
> +			  op.dummy.buswidth / 8;
>   	if (spi_nor_protocol_is_dtr(nor->read_proto))
>   		op.dummy.nbytes *= 2;
>   
Tested on my AM625 SK EVM having spi nor flash and no obvious 
regressions observed :)

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

