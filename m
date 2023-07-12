Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7125774FFDA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 09:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjGLHFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 03:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjGLHFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 03:05:04 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20626B1;
        Wed, 12 Jul 2023 00:05:01 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id C9A2081A;
        Wed, 12 Jul 2023 09:04:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1689145496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C9iTjSBQ2cpJHR0/fytksLWYvIlt9SMZkZq0e9WtOSg=;
        b=vmi5gQZlxACiaeV0fWn2byFIQWIzZn2z/GpeBZChBrd+vzpmczq1+qYJ/8Ftm/xi5Aj13G
        8Y23dxmxM6RyGnDCAZC4XyUeRr1X6GHXWe8Hcn/4Oa5R2wBwz1PGRPdz4hgqXDGviTxSoZ
        C2GfLvpIlVxAe2Owj0/5cPSrgZyp4qWQ75iw6XoYePUGgGH6TUFHUl2iQ64VyyNnfdxx2R
        xo7ksN3xbUpriRIdg7tMWg1rNahN9X3VBYATJwNXxtSZSQkQoHcrxwo5b/9xRaNE8HZaP8
        N33ETMJThiD3AafqpHWV7wzIi3y2HvsHU+pXlsD8pM0UORn9sA+/8I4L7HnIQQ==
MIME-Version: 1.0
Date:   Wed, 12 Jul 2023 09:04:56 +0200
From:   Michael Walle <michael@walle.cc>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mtd: spi-nor: Correct flags for Winbond w25q128
In-Reply-To: <20230712-spi-nor-winbond-w25q128-v1-1-f78f3bb42a1c@linaro.org>
References: <20230712-spi-nor-winbond-w25q128-v1-1-f78f3bb42a1c@linaro.org>
Message-ID: <46d0846850df455901cf3d11c66c5a90@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Am 2023-07-12 00:02, schrieb Linus Walleij:
> The Winbond W25Q128 (actual vendor name W25Q128JV)

Not necessarily see below. Do you know what part numbers is
written on your flash?

> has exactly the same flags as the sibling device
> w25q128fw. The devices both require unlocking and
> support dual and quad SPI transport.
> 
> The actual product naming between devices:
> 
> 0xef4018: "w25q128"   W25Q128JV-IM/JM
> 0xef7018: "w25q128fw" W25Q128JV-IN/IQ/JQ

Where do you get that string? from winbond.c? Because,
then it's incorrect. For 0xef7018 its actually w25q128jv.

But that being said, Winbond is known to reuse the IDs among its
flashes. From a quick look at various datasheets:

0x60 seems to be DW, FW and NW(Q) series
0x70 seems to be JV(M)
0x80 seems to be NW(M)
0x40 seems to be BV, JV(Q), "V" (probably the first [1])

(Q) denotes the fixed quad enable bit.

Now 0x40 are the first ones who where added back in the days. I'm
not sure, what kind of winbond devices there were and if they
support dual/quad read.

Normally, you'd use a .fixups (see w25q256_fixups for example) to
dynamically detect the newer flash type and then refine the flags.
But because we don't know how the older flashes look like, that
would be just guessing :/ Although, I've once thought about
fingerprinting the SFDP tables eg. by some hash. But that would
assume the SFDP data is not changing a lot on a given device. Not
sure if that is the case, we just began to collect SFDP tables
of various devices.

If it turns out that only SPI_NOR_HAS_LOCK and SPI_NOR_HAS_TB
is needed, I'm leaning towards just adding these flags to the
w25q128 entry. According to [1] this was already supported
back in the days.

> The latter device, "w25q128fw" supports features
> named DTQ and QPI, otherwise it is the same.
> 
> Not having the right flags has the annoying side
> effect that write access does not work.

This should only apply to FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB).

I'd guess your flash supports SFDP, then the NO_SFDP_FLAGS should be
automatically detected. Could you please dump the SFDP tables
(described in [2])?

> After this patch I can write to the flash on the
> Inteno XG6846 router.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mtd/spi-nor/winbond.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/winbond.c 
> b/drivers/mtd/spi-nor/winbond.c
> index 834d6ba5ce70..a67e1d4206f3 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -121,7 +121,9 @@ static const struct flash_info winbond_nor_parts[] 
> = {
>  	{ "w25q80bl", INFO(0xef4014, 0, 64 * 1024,  16)
>  		NO_SFDP_FLAGS(SECT_4K) },
>  	{ "w25q128", INFO(0xef4018, 0, 64 * 1024, 256)
> -		NO_SFDP_FLAGS(SECT_4K) },
> +		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
> +		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
> +			      SPI_NOR_QUAD_READ) },

As mentioned above, could you try without the DUAL_READ/QUAD_READ flags.
You can have a look at the debugfs whether the detected capabilities
are still the same with and without these flags.

-michael

[1] https://www.elinux.org/images/f/f5/Winbond-w25q32.pdf
[2] 
https://lore.kernel.org/all/4304e19f3399a0a6e856119d01ccabe0@walle.cc/
