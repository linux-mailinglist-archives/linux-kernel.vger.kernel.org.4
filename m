Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC8A5E663B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbiIVOzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiIVOzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:55:35 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF00D74C0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 07:55:34 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 2613D1D4A;
        Thu, 22 Sep 2022 16:55:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1663858532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hOWRDOnllpNwbanrF29Aqs2hVKHR42wg1rNwmpJb/xQ=;
        b=mu1g4rLkNWR9+D0ehFJ1fSNC3kQx8uuzlWeGr0dZegssaD2KkhnWdyDahKcgHUZajVsvpT
        VYAZHhnV8DOBiXEKX49vwhuuV7XFynFKlsUjLQPmcmGzsA3V5sAQu6xFoywCsT71uIll4n
        Y3LdLBM7tIgT9ySefC3ValDCWQ9khV75Zb2piNbCH7g6LJkcPkl6vVUfqy7ugd6A3TCycj
        24HU1N90YFkth+VB+PtZefWlnL+im1+/4rc9NkJUY1e5KwNdY+evDk9b1E9BBiv6ShioVq
        pN5ec6Z711vt8dZecxcffgn1Cu4H2rnVLc/buLTq6Gl0VgFmg7ALxX0AXrRA2g==
MIME-Version: 1.0
Date:   Thu, 22 Sep 2022 16:55:32 +0200
From:   Michael Walle <michael@walle.cc>
To:     niravkumar.l.rabara@intel.com
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: spi-nor: macronix: Add support for mx66u1g45g
In-Reply-To: <20220917111640.977243-1-niravkumar.l.rabara@intel.com>
References: <20220916082215.883184-1-niravkumar.l.rabara@intel.com>
 <20220917111640.977243-1-niravkumar.l.rabara@intel.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <c09cd1c3c74582e90e3fe8633da2aaa0@walle.cc>
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

Am 2022-09-17 13:16, schrieb niravkumar.l.rabara@intel.com:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> 
> The MX66U1G45G is the smaller sibling (128MB) of the MX66U2G45G (256MB)
> that is already supported.
> 
> Tested on Intel N5X socdk board,
> - random data write, erase, read   - verified erase operations
> - random data write, read and compare  - verified write/read operations
> 
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> ---
> root@n5x:~# find / -iname spi-nor
> /sys/kernel/debug/spi-nor
> /sys/devices/platform/soc/ff8d2000.spi/spi_master/spi0/spi0.0/spi-nor
> /sys/bus/spi/drivers/spi-nor
> root@n5x:~# ls -al
> /sys/devices/platform/soc/ff8d2000.spi/spi_master/spi0/spi0.0/spi-nor/
> drwxr-xr-x    2 root     root             0 Dec 16 17:26 .
> drwxr-xr-x    6 root     root             0 Dec 16 17:25 ..
> -r--r--r--    1 root     root          4096 Dec 16 17:26 jedec_id
> -r--r--r--    1 root     root          4096 Dec 16 17:26 manufacturer
> -r--r--r--    1 root     root          4096 Dec 16 17:26 partname
> -r--r--r--    1 root     root             0 Dec 16 17:26 sfdp
> root@n5x:~#  cat
> /sys/devices/platform/soc/ff8d2000.spi/spi_master/spi0/spi0.0/spi-nor/jedec_id
> c2253b
> root@n5x:~# cat
> /sys/devices/platform/soc/ff8d2000.spi/spi_master/spi0/spi0.0/spi-nor/manufacturer
> macronix
> root@n5x:~# cat
> /sys/devices/platform/soc/ff8d2000.spi/spi_master/spi0/spi0.0/spi-nor/partname
> mx66u1g45g
> root@n5x:~# cat
> /sys/devices/platform/soc/ff8d2000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp
> > mx66u1g45g-sfdp
> root@n5x:~# hexdump mx66u1g45g-sfdp
> 0000000 4653 5044 0106 ff02 0600 1001 0030 ff00
> 0000010 00c2 0401 0110 ff00 0084 0201 00c0 ff00
> 0000020 ffff ffff ffff ffff ffff ffff ffff ffff
> 0000030 20e5 fffb ffff 3fff eb44 6b08 3b08 bb04
> 0000040 fffe ffff ffff ff00 ffff eb44 200c 520f
> 0000050 d810 ff00 4987 00b5 d282 e204 0344 3867
> 0000060 b030 b030 bdf7 5cd5 9e4a ff29 50f0 85f9
> 0000070 ffff ffff ffff ffff ffff ffff ffff ffff
> *
> 00000c0 8f7f ffff 5c21 ffdc ffff ffff ffff ffff
> 00000d0 ffff ffff ffff ffff ffff ffff ffff ffff
> *
> 0000110 2000 1600 f99d 64c0 cb85 ffff ffff ffff
> 0000120

md5sum of this is missing.

> ---
>  drivers/mtd/spi-nor/macronix.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/macronix.c 
> b/drivers/mtd/spi-nor/macronix.c
> index d81a4cb2812b..07ace9da74b7 100644
> --- a/drivers/mtd/spi-nor/macronix.c
> +++ b/drivers/mtd/spi-nor/macronix.c
> @@ -97,6 +97,10 @@ static const struct flash_info macronix_nor_parts[] 
> = {
>  			      SPI_NOR_QUAD_READ) },
>  	{ "mx66l1g55g",  INFO(0xc2261b, 0, 64 * 1024, 2048)
>  		NO_SFDP_FLAGS(SPI_NOR_QUAD_READ) },
> +	{ "mx66u1g45g",  INFO(0xc2253b, 0, 64 * 1024, 2048)
> +		PARSE_SFDP
> +		FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)

With PARSE_SFDP this shouldn't be needed.

Also, could you try with INFO(0xc2253b, 0, 0, 0), this information
should come from the SFDP, too.

-michael

> +		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
>  	{ "mx66u2g45g",	 INFO(0xc2253c, 0, 64 * 1024, 4096)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
>  		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
