Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019B1603B52
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 10:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiJSIVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 04:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiJSIV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 04:21:27 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99C57B783
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 01:21:25 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 9E30D1285;
        Wed, 19 Oct 2022 10:21:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1666167683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TWQqtenUAFw0Ko7PUUjRTcIEu6B3uHvIJTcTD50lWXU=;
        b=dRjE/FPoLeRA44NjJS6xgDRvbA3rf67PjwK2YTv1USHxbA+fSZRez4cOMWgbkMXuM6JUw2
        a2TfjKaM1IhNr9LxYgzNZgvtQxPj0WF3PNIOjWs9swyP9RIdaJ6OuFVdwj2vh42qqYoPhO
        XK+RKHC9/70pthTxMYwK2OFbD/VpScKOjr1btD2OlHiFCPaHX/94LnlthiZrrH9QJl7y+F
        yLsGyIQN6/fabs9KyrP8We9nCaWSVyRPOUUAH0DELt8SPCKoVgCN8+V+c/yR/iCqq0qXkg
        P70WotRBU847x2fhzk6BSaNkH7ML4ZOBO7AYOxfWfJNIcwydlMf5p6ERidgisg==
MIME-Version: 1.0
Date:   Wed, 19 Oct 2022 10:21:23 +0200
From:   Michael Walle <michael@walle.cc>
To:     Eliav Farber <farbere@amazon.com>
Cc:     tudor.ambarus@microchip.com, pratyush@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        talel@amazon.com, jonnyc@amazon.com, hhhawa@amazon.com,
        hanochu@amazon.com, itamark@amazon.com, shellykz@amazon.com,
        amitlavi@amazon.com, dkl@amazon.com
Subject: Re: [PATCH v2 1/1] mtd: spi-nor: micron-st: Enable locking for
 n25q256ax1/mt25qu256a
In-Reply-To: <20221019071631.15191-1-farbere@amazon.com>
References: <20221019071631.15191-1-farbere@amazon.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <73bfa5ae90e2269387540019806c2839@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2022-10-19 09:16, schrieb Eliav Farber:
> n25q256ax1 [1] and mt25qu256a [2] (both have same jedec_id - 0x20bb19)
> use the 4 bit Block Protection scheme and support Top/Bottom protection
> via the BP and TB bits of the Status Register.
> BP3 is located in bit 6 of the Status Register.
> Tested on both n25q256ax1 and mt25qu256a.
> 
> [1] 
> https://www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/n25q/n25q_256mb_3v.pdf
> [2] 
> https://www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/mt25q/die-rev-a/mt25q_qljs_u_256_aba_0.pdf

If you respin, you can use a "Link:" tag for the URL above.

> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
> xxd -p
> /sys/devices/platform/soc/fd882000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp
> 53464450060101ff00060110300000ff84000102800000ffffffffffffff
> ffffffffffffffffffffffffffffffffffffe520fbffffffff0f29eb276b
> 273b27bbffffffffffff27bbffff29eb0c2010d80f520000244a99008b8e
> 03d4ac0127387a757a75fbbdd55c4a0f82ff81bd3d36ffffffffffffffff
> ffffffffffffffffffe7ffff21dcffff
> 
> md5sum
> /sys/devices/platform/soc/fd882000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp
> 5ea738216f68c9f98987bb3725699a32
> /sys/devices/platform/soc/fd882000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp
> 
> cat
> /sys/devices/platform/soc/fd882000.spi/spi_master/spi0/spi0.0/spi-nor/jedec_id
> 20bb19104400
> 
> cat
> /sys/devices/platform/soc/fd882000.spi/spi_master/spi0/spi0.0/spi-nor/partname
> mt25qu256a
> 
> cat
> /sys/devices/platform/soc/fd882000.spi/spi_master/spi0/spi0.0/spi-nor/manufacturer
> st

That's the mt25qu256a SFDP. What about the n25q256ax1?

Thanks!
-michael

> 
> v2 --> v1:
> - Enable locking also for mt25qu256a.
> - Dump the SFDP tables.
> 
>  drivers/mtd/spi-nor/micron-st.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/micron-st.c 
> b/drivers/mtd/spi-nor/micron-st.c
> index 3c9681a3f7a3..f4d0153a5b1b 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -201,11 +201,15 @@ static const struct flash_info st_nor_parts[] = {
>  		MFR_FLAGS(USE_FSR)
>  	},
>  	{ "mt25qu256a",  INFO6(0x20bb19, 0x104400, 64 * 1024,  512)
> +		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
> +		      SPI_NOR_BP3_SR_BIT6)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
>  		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
>  		MFR_FLAGS(USE_FSR)
>  	},
>  	{ "n25q256ax1",  INFO(0x20bb19, 0, 64 * 1024,  512)
> +		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
> +		      SPI_NOR_BP3_SR_BIT6)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ)
>  		MFR_FLAGS(USE_FSR)
>  	},
