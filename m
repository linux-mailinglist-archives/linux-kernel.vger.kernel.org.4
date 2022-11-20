Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3F06314CD
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 16:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiKTPMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 10:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiKTPMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 10:12:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F08B2D1D4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 07:12:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A98B7B8092B
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 15:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028D8C433C1;
        Sun, 20 Nov 2022 15:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668957122;
        bh=OptdsyuD6uPrHmZmntrSB3Cvr0WP7pXgeP/BVx5u/Vg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HHrpSSsgJCRQ591jzNDSzvLB79e8nznwNyikVfZSlsGpo6X7nE/qL2kzMvwQqJBse
         A9W+ADwVfvTzecF7bKDckTKMVCyX5HSKsDrajyrg8cekLXIfWhKB4EVHf0zSVVOkcx
         xSc5wnD+3HZbOaEZFCMsoNvSF/2TX0moPW19usXdMasK3q8s8A/s8HMNsJJZHg19v6
         jyvWAYmby6hzPThn9F+I+aNHYQJ/tJpU9wWlTEorHdkgC+rTNo9K1IowYo6o8Qeyir
         gjr7LHsfC/KWZKHCKp2ikb9bpRGWjTFRK+/bhMOANuCjNuvKvN2ILzD+EKqyOqQXnd
         6Ev0syqsk1AJw==
Date:   Sun, 20 Nov 2022 16:11:58 +0100
From:   Pratyush Yadav <pratyush@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-mtd@lists.infradead.org, tudor.ambarus@microchip.com,
        michael@walle.cc, linux-kernel@vger.kernel.org,
        Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
Subject: Re: [PATCHv2] mtd: spi-nor: macronix: Add support for mx66u1g45g
Message-ID: <20221120151158.p5jukj7r6yj5t7sm@yadavpratyush.com>
References: <20221111164015.165581-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111164015.165581-1-dinguyen@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/22 10:40AM, Dinh Nguyen wrote:
> The MX66U1G45G is the smaller sibling (128MB) of the MX66U2G45G (256MB)
> that is already supported.
> 
> Tested on Intel N5X socdk board,
>   - random data write, erase, read   - verified erase operations
>   - random data write, read and compare  - verified write/read operations
> 
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
> v2: fixed compile error by removing , after PARSE_SFDP
> ---
>  drivers/mtd/spi-nor/macronix.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
> index d81a4cb2812b..07ace9da74b7 100644
> --- a/drivers/mtd/spi-nor/macronix.c
> +++ b/drivers/mtd/spi-nor/macronix.c
> @@ -97,6 +97,10 @@ static const struct flash_info macronix_nor_parts[] = {
>  			      SPI_NOR_QUAD_READ) },
>  	{ "mx66l1g55g",  INFO(0xc2261b, 0, 64 * 1024, 2048)
>  		NO_SFDP_FLAGS(SPI_NOR_QUAD_READ) },
> +	{ "mx66u1g45g",  INFO(0xc2253b, 0, 64 * 1024, 2048)
> +		PARSE_SFDP
> +		FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
> +		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },

Why do you need these extra flags? Can't they be discovered by parsing 
the SFDP? If they can't, then you should explain in your commit message 
why that is so.

I would suspect they can be, so perhaps you should try using your flash 
with just PARSE_SFDP and see if it works.

>  	{ "mx66u2g45g",	 INFO(0xc2253c, 0, 64 * 1024, 4096)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
>  		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
> -- 
> 2.25.1
> 

-- 
Regards,
Pratyush Yadav
