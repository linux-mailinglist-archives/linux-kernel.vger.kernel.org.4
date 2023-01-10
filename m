Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F8466387D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 06:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjAJFKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 00:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjAJFKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 00:10:47 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8FA1C91C;
        Mon,  9 Jan 2023 21:10:46 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30A5AagC004343;
        Mon, 9 Jan 2023 23:10:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1673327436;
        bh=Xh6UOOhZ9yrqrA92Pig4ktQ5WlS0xDpOIpgKAYnACGM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=P5jmO7dc14Aw//CYvY4Lst93HkldQ+Eslpn1P8tlIyrN3SjOmOiCZxZAotubZKJks
         EMcgFDwiBnQ1ng9+DJVyDlWco99zEr224/KBtr7axM3K9//OjkGjh+SVSNR/Z7Ype5
         7TduKoeZGhzTtnkMtCzLb0gFw8JMluKsq6qjaf/Q=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30A5Aajh037906
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Jan 2023 23:10:36 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 9
 Jan 2023 23:10:35 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 9 Jan 2023 23:10:35 -0600
Received: from [10.24.69.141] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30A5AXwY006013;
        Mon, 9 Jan 2023 23:10:34 -0600
Message-ID: <3881d0e8-c2ec-1de7-a7d9-4eeb1565b0c1@ti.com>
Date:   Tue, 10 Jan 2023 10:40:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] spi: cadence-quadspi: use STIG mode for small reads
Content-Language: en-US
To:     Dhruva Gole <d-gole@ti.com>, <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh <vigneshr@ti.com>, Pratyush Yadav <pratyush@kernel.org>
References: <20230104062604.1556763-1-d-gole@ti.com>
 <20230104062604.1556763-3-d-gole@ti.com>
From:   Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <20230104062604.1556763-3-d-gole@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dhruva,

On 04/01/23 11:56, Dhruva Gole wrote:
> Fix the issue where some flash chips like cypress S25HS256T return the
> value of the same register over and over in DAC mode.
> 
> For example in the TI K3-AM62x Processors refer [0] Technical Reference
> Manual there is a layer of digital logic in front of the QSPI/OSPI
> Drive when used in DAC mode. This is part of the Flash Subsystem (FSS)
> which provides access to external Flash devices.
> 
> The FSS0_0_SYSCONFIG Register (Offset = 4h) has a BIT Field for
> OSPI_32B_DISABLE_MODE which has a Reset value = 0. This means, OSPI 32bit
> mode enabled by default.
> 
> Thus, by default controller operates in 32 bit mode causing it to always
> align all data to 4 bytes from a 4byte aligned address. In some flash
> chips like cypress for example if we try to read some regs in DAC mode
> then it keeps sending the value of the first register that was requested
> and inorder to read the next reg, we have to stop and re-initiate a new
> transaction.
> 
> This causes wrong register values to be read than what is desired when
> registers are read in DAC mode. Hence if the data.nbytes is very less
> then prefer STIG mode for such small reads.
> 
> [0] https://www.ti.com/lit/ug/spruiv7a/spruiv7a.pdf
> 
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>  drivers/spi/spi-cadence-quadspi.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index 8c7938776cfc..f5188dc52db6 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -1344,7 +1344,13 @@ static int cqspi_mem_process(struct spi_mem *mem, const struct spi_mem_op *op)
>  	cqspi_configure(f_pdata, mem->spi->max_speed_hz);
>  
>  	if (op->data.dir == SPI_MEM_DATA_IN && op->data.buf.in) {
> -		if (!op->addr.nbytes)
> +	/*
> +	 * Performing reads in DAC mode forces to read minimum 4 bytes
> +	 * which is unsupported on some flash devices during register
> +	 * reads, prefer STIG mode for such small reads.
> +	 */
> +		if (!op->addr.nbytes ||
> +		    op->data.nbytes <= CQSPI_STIG_DATA_LEN_MAX)
>  			return cqspi_command_read(f_pdata, op);
>  

I am seeing issues while testing after applying this series,

On J7200 EVM,
[    2.164655] spi-nor spi7.0: Failed to parse optional parameter table: ff81
[    2.171644] spi-nor spi7.0: s28hs512t (65536 Kbytes)

On J721E EVM,
[    5.565961] spi-nor spi7.0: mt35xu512aba (0 Kbytes)
[    5.732084] spi-nor spi8.0: mt25qu512a (81753 Kbytes)

In all the three cases above, the behavior is normal without these patches.

>  		return cqspi_read(f_pdata, op);

-- 
Regards,
Vaishnav
