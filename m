Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6717A65AE83
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 10:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjABJBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 04:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjABJBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 04:01:13 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78ABC1E9
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 01:01:12 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30290Zj6030661;
        Mon, 2 Jan 2023 03:00:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672650035;
        bh=Sfa9o0kdL5YsnLLCEDwGHRyigUI/UlPkkJoDS6qgMKI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=VIeoKP1qktpphB0/sTMLIYm+IKZVhDH3qZme5rr6HJBIks4bTkkltIfgfdiVdevS3
         vTvKWi3jB8vYAh8vsumR/LDpOTPQy/bE/mGsPl8xjEaf7O2Xs4h+gcZK7ra169cVkX
         vIZuHvqBhliSdZn/ELshNkXQZr+6U6iq5b+Z6/FY=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30290ZkC011689
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Jan 2023 03:00:35 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 2
 Jan 2023 03:00:34 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 2 Jan 2023 03:00:34 -0600
Received: from [172.24.223.105] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30290Tna071884;
        Mon, 2 Jan 2023 03:00:30 -0600
Message-ID: <dd505644-bbfb-ea3e-5282-ce750812e703@ti.com>
Date:   Mon, 2 Jan 2023 14:30:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 5/7] mtd: rawnand: sunxi: Fix the size of the last OOB
 region
To:     Samuel Holland <samuel@sholland.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
CC:     Boris Brezillon <bbrezillon@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>
References: <20221229181526.53766-1-samuel@sholland.org>
 <20221229181526.53766-6-samuel@sholland.org>
Content-Language: en-US
From:   "Gole, Dhruva" <d-gole@ti.com>
Organization: Texas Instruments Incorporated
In-Reply-To: <20221229181526.53766-6-samuel@sholland.org>
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


On 12/29/2022 11:45 PM, Samuel Holland wrote:
> The previous code assigned to the wrong structure member.
Good catch!
>
> Fixes: c66811e6d350 ("mtd: nand: sunxi: switch to mtd_ooblayout_ops")
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
Acked-By: Dhruva Gole <d-gole@ti.com>
>
>   drivers/mtd/nand/raw/sunxi_nand.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
> index 1ecf2cee343b..8e873f4fec9a 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
> @@ -1609,7 +1609,7 @@ static int sunxi_nand_ooblayout_free(struct mtd_info *mtd, int section,
>   	if (section < ecc->steps)
>   		oobregion->length = 4;
>   	else
> -		oobregion->offset = mtd->oobsize - oobregion->offset;
> +		oobregion->length = mtd->oobsize - oobregion->offset;
>   
>   	return 0;
>   }

-- 
Regards,
Dhruva Gole <d-gole@ti.com>

