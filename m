Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28ACE7484DB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjGENWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjGENWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:22:06 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A83171C
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 06:22:04 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 9C47814B;
        Wed,  5 Jul 2023 15:22:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1688563321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RkmkIlJf0GjA86yR5StuTraBthXgR2TiG3EKV+pp7/8=;
        b=MIuToiibmRuNOsgyP95Q+/yln7OkbL8XaE0hNyTBLNl0clVQtFTR7u+cZ7iEhn1HnsVs4A
        ZAq8ptlaI1fphBqH7B4MjBqQjiGX1s3OisvMzmLQVxVzjKeY4lbXB4GtNwAwWYI1rTwHaZ
        uYLw7B5EEUWOBfR0qkX2Yzk7vX7DhABrMh0f37elMQm9rdkZZTjmVWkrDdDVOWM/HRQtA0
        S9cUM3ERcMNYV27GmNOLYQo+P4TMl+sxFcdDy6A519A8CzmGSETsCDcdeAz6qe64xj4qWr
        VQqgBRjAV059rn6TB8GkoQMlHW2SuCkVs+ENs7HWyE5L7GIf3fuJL7vRGbT/4g==
MIME-Version: 1.0
Date:   Wed, 05 Jul 2023 15:22:01 +0200
From:   Michael Walle <michael@walle.cc>
To:     Mamta Shukla <mamta.shukla@leica-geosystems.com>
Cc:     tudor.ambarus@linaro.org, pratyush@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        bsp-development.geo@leica-geosystems.com,
        Mamta Shukla <mamta.shukla@leica-geosystems.com>
Subject: Re: [PATCH] mtd: micron-st: enable lock/unlock for mt25qu512a
In-Reply-To: <20230705130010.2999839-1-mamta.shukla@leica-geosystems.com>
References: <20230705130010.2999839-1-mamta.shukla@leica-geosystems.com>
Message-ID: <419d80f252f12f091b9c555da0965c84@walle.cc>
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

Am 2023-07-05 15:00, schrieb Mamta Shukla:
> mt25qu512a[1] supports locking/unlocking through BP bits in SR.
> 
> Tested using mtd-utils- flash_lock/flash_unlock for MT25QU512ABB8E12.
> 

> [1] 
> https://media-www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/mt25q/die-rev-b/mt25q_qlkt_u_512_abb_0.pdf?rev=b259aadc3bea49ea8210a41c9ad58211

Link: tag please

> Signed-off-by: Mamta Shukla <mamta.shukla@leica-geosystems.com>
> ---
>  drivers/mtd/spi-nor/micron-st.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/micron-st.c 
> b/drivers/mtd/spi-nor/micron-st.c
> index 4b919756a205..5d1dc8e0bbba 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -218,6 +218,8 @@ static const struct flash_info st_nor_parts[] = {
>  		MFR_FLAGS(USE_FSR)
>  	},
>  	{ "mt25ql512a",  INFO6(0x20ba20, 0x104400, 64 * 1024, 1024)
> +		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
> +		      SPI_NOR_BP3_SR_BIT6)

With the changes above:

Reviewed-by: Michael Walle <michael@walle.cc>

Unrelated to this patch, but could you please dump the SFDP tables,
see [1].

FWIW, I noticed the difference between MT25QU and MT25QL here. But
I don't think we can do anything about it. It is just another example,
that the name is mostly irrelavant/cannot be trusted. Vendors tend to
reuse the id for different (software compatible probably) parts. Maybe
we can get rid of it entirely. Tudor, Pratyush?

-michael

[1] 
https://lore.kernel.org/all/4304e19f3399a0a6e856119d01ccabe0@walle.cc/
