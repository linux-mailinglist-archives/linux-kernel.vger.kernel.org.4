Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA97968098E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 10:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbjA3Jc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 04:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236312AbjA3Jch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:32:37 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033ED12F3C
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 01:30:41 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 248DB3BE;
        Mon, 30 Jan 2023 10:29:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1675070985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x2NVG7YDMSDNU+ofFZZvrPtVz7CsCGJovYbM5A6XIjY=;
        b=lKzfmsOZUqeuSgxgQ3ouQtAUobADm1fDWqv0fouLGPYVMbPOA1PI/Tp0ESutJGup+zum2c
        mVR5mmJpr7xfvKsec3YtbQduy7XID+2O7tP81leC+FRxaJqR7WIqTCQm1f29Y/O5mfO24F
        IJOv1+BE8aXptK9x7TkCqaXPks4UuO3vVY9DMVjdilqI5EldUWDCpKsV4hikD6eyMiZpSq
        5jtdUcaVQ07Ag5UQ0dO72xBrvb8H2LopO+iF/ODIwsOc89WH6z7ngK+sNfpo9Q+sVb2QmQ
        LIV0ObchNJhNvsLBujUGnTxLra2bMjAsHAUYMyoATMSp8l/37OEnTuYB6zkFCg==
MIME-Version: 1.0
Date:   Mon, 30 Jan 2023 10:29:44 +0100
From:   Michael Walle <michael@walle.cc>
To:     Heyi Guo <guoheyi@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH] drivers/spi-nor: add support for Winbond w25q01jv
In-Reply-To: <20230128033957.125853-1-guoheyi@linux.alibaba.com>
References: <20230128033957.125853-1-guoheyi@linux.alibaba.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <c7c3c4cf5dd477953e366053859df08f@walle.cc>
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

> Winbond W25Q01JV is a 128MB SPI-NOR flash chip.
> 
> Signed-off-by: Heyi Guo <guoheyi@linux.alibaba.com>
> 
> --
> Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Michael Walle <michael@walle.cc>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: linux-mtd@lists.infradead.org
> ---
>  drivers/mtd/spi-nor/winbond.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/winbond.c 
> b/drivers/mtd/spi-nor/winbond.c
> index ca39acf4112c8..0cd49f534bf8d 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -142,6 +142,9 @@ static const struct flash_info winbond_nor_parts[] 
> = {
>  	{ "w25q512jvq", INFO(0xef4020, 0, 64 * 1024, 1024)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>  			      SPI_NOR_QUAD_READ) },
> +	{ "w25q01jv", INFO(0xef4021, 0, 64 * 1024, 2048)
> +		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
> +			      SPI_NOR_QUAD_READ) },

I'd guess this flash has SFDP support, correct? In this case,
could you please try the latest next (or -rc) kernel without
this change? In the meantime we have a generic spi-nor driver [1]
so you don't need a new entry in most cases.

Apart from that, it would be nice if you could dump the
SFDP tables, see [2].

-michael

[1] 
https://elixir.bootlin.com/linux/v6.2-rc5/source/drivers/mtd/spi-nor/core.c#L1638
[2] https://lore.kernel.org/r/4304e19f3399a0a6e856119d01ccabe0@walle.cc/
