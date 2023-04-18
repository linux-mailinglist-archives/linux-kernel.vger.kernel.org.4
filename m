Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189E16E5CA4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjDRIzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjDRIyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:54:53 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89AA6591
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 01:54:51 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 1146C87;
        Tue, 18 Apr 2023 10:54:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1681808089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wbaEuI9r2qcBF9wK/9C0l/3woe8iimbkV5mcnK1qhLs=;
        b=lgm+DWx5aE2IXCf5e4v0z3Q4iclLnqNixGRYodS236GWl0oSryvxsvLxtBJNghcQiteJ8A
        ZB+CydcnA3aXDtSS6G2btSLCssJ809oMtujTAPOCxQml8wM88OTKXsEwnS6noGOsNr3blP
        xx4tYFmSanpQ32KQH7DrZ1YsPTa5Y2TU4aa2lqvAV2RLts6AOfJzAOxsG642vkBxpdZ4sk
        jHiowLMQV72ivMry1ItxyCGPXMbTHYBgENbRgtkogcqlqSIzUKumqweru5CPlQbvjmhe8A
        y3WIT8A2rz6V5IoEIm7VsMbV9PX6MF37ohBD0oRQSbHrekQouId3iICDCRMVXQ==
MIME-Version: 1.0
Date:   Tue, 18 Apr 2023 10:54:47 +0200
From:   Michael Walle <michael@walle.cc>
To:     niravkumar.l.rabara@intel.com
Cc:     tudor.ambarus@linaro.org, pratyush@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: issi: add support for IS25WP01G
In-Reply-To: <20230417125304.1968382-1-niravkumar.l.rabara@intel.com>
References: <20230417125304.1968382-1-niravkumar.l.rabara@intel.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <9ba43cf93ede8ba7934a4461f2f7a640@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> 
> Tested on Intel N5X socdk board,
> random data write, erase, read - verified erase operations
> random data write, read and compare - verified write/read operations
> 
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> 
> ---
> root@n5x:~# cat /sys/devices/platform/soc/ff8d2000.spi/spi_master/
> spi0/spi0.0/spi-nor/jedec_id
> 9d701b
> root@n5x:~# cat /sys/devices/platform/soc/ff8d2000.spi/spi_master/
> spi0/spi0.0/spi-nor/manufacturer
> issi
> root@n5x:~# cat /sys/devices/platform/soc/ff8d2000.spi/spi_master/
> spi0/spi0.0/spi-nor/partname
> is25wp01g
> root@n5x:~# hexdump /sys/devices/platform/soc/ff8d2000.spi/spi_master
> /spi0/spi0.0/spi-nor/sfdp
> 0000000 4653 5044 0106 ff01 0600 1001 0030 ff00
> 0000010 0084 0201 0080 ff00 ffff ffff ffff ffff
> 0000020 ffff ffff ffff ffff ffff ffff ffff ffff
> 0000030 20e5 fffb ffff 3fff eb44 6b08 3b08 bb80
> 0000040 fffe ffff ffff ff00 ffff eb44 200c 520f
> 0000050 d810 ff00 4262 00a9 6482 d302 8dec 4c69
> 0000060 757a 757a a4f7 5cd5 c24a ff2c 30e1 a9fa
> 0000070 ffff ffff ffff ffff ffff ffff ffff ffff
> 0000080 eeff ffff 5c21 ffdc
> 0000088
> root@n5x:~# md5sum /sys/devices/platform/soc/ff8d2000.spi/spi_master/
> spi0/spi0.0/spi-nor/sfdp
> 83440c0ff8676fe5292d207788693900  /sys/devices/platform/soc/ff8d2000.
> spi/spi_master/spi0/spi0.0/spi-nor/sfdp

Thanks for the dump!

> ---
>  drivers/mtd/spi-nor/issi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
> index 400e2b42f45a..79132267cf0d 100644
> --- a/drivers/mtd/spi-nor/issi.c
> +++ b/drivers/mtd/spi-nor/issi.c
> @@ -64,6 +64,8 @@ static const struct flash_info issi_nor_parts[] = {
>  		PARSE_SFDP
>  		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
>  		.fixups = &is25lp256_fixups },
> +	{ "is25wp01g",  INFO(0x9d701b, 0, 256 * 1024,  512)
> +		PARSE_SFDP },

There are no special flags, thus this flash should just work with the
generic SPI-NOR driver [1]. No patch needed.

-michael

>  	{ "is25wp032",  INFO(0x9d7016, 0, 64 * 1024,  64)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  	{ "is25wp064",  INFO(0x9d7017, 0, 64 * 1024, 128)

[1] 
https://elixir.bootlin.com/linux/v6.3-rc7/source/drivers/mtd/spi-nor/core.c#L1637
