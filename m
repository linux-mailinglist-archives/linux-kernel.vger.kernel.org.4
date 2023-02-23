Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCD36A03BC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 09:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbjBWIWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 03:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbjBWIWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 03:22:53 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5E94C35;
        Thu, 23 Feb 2023 00:22:52 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 31N8MdTj092504;
        Thu, 23 Feb 2023 02:22:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1677140559;
        bh=bbjFmqWgZLG2QiNlY4cBosekaW9FxOBGspuA7O0F4DY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=pyRI48om+ITil0PGUr8iM3wOMs4Zr7pS5yfgIfmM1RglIU7Ar1rQOeAn2kq9crrFM
         N1iD//abcUODOvkqfHAYGN6oRvqLqGC5h9GLRLoG0vJc0XeX1dqKiTVayQtgB4m0KU
         MadfXQpt2riH46ZAWY6ya2ywB11iDEJHQzOEUmDU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 31N8MdFF070558
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Feb 2023 02:22:39 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 23
 Feb 2023 02:22:39 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 23 Feb 2023 02:22:39 -0600
Received: from [10.24.69.26] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 31N8Mbom115443;
        Thu, 23 Feb 2023 02:22:37 -0600
Message-ID: <454a16ff-1492-d4c5-44b8-4631abe6ee58@ti.com>
Date:   Thu, 23 Feb 2023 13:52:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] spi: cadence-quadspi: Fix cancel the indirect read mask
Content-Language: en-US
To:     Hongbin Ji <jhb_ee@163.com>, <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230222092128.4237-1-jhb_ee@163.com>
From:   Dhruva Gole <d-gole@ti.com>
In-Reply-To: <20230222092128.4237-1-jhb_ee@163.com>
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

Hi Hongbin,

On 22/02/23 14:51, Hongbin Ji wrote:
> This is to cancel the indirect read transfer process,
> so should be use CQSPI_REG_INDIRECTRD_CANCEL_MASK

Good catch!
Both macros expand to BIT(1) so probably we did not face any issues so
far.

> 
> Signed-off-by: Hongbin Ji <jhb_ee@163.com>
> ---

Reviewed-by: Dhruva Gole <d-gole@ti.com>

>   drivers/spi/spi-cadence-quadspi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index 676313e1bdad..967cb8ec0eec 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -766,7 +766,7 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
>   	writel(0, reg_base + CQSPI_REG_IRQMASK);
>   
>   	/* Cancel the indirect read */
> -	writel(CQSPI_REG_INDIRECTWR_CANCEL_MASK,
> +	writel(CQSPI_REG_INDIRECTRD_CANCEL_MASK,
>   	       reg_base + CQSPI_REG_INDIRECTRD);
>   	return ret;
>   }

-- 
Thanks and Regards,
Dhruva Gole
