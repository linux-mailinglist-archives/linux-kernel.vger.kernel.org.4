Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D1F5FFB01
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 17:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiJOP2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 11:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJOP2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 11:28:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D7A2B607;
        Sat, 15 Oct 2022 08:28:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09BE3B80AB7;
        Sat, 15 Oct 2022 15:28:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C34AC433C1;
        Sat, 15 Oct 2022 15:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665847706;
        bh=c8zDD16u0UeTtw8y1M51RhSks9u63jjVO4qm0EUYk3g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r3UTHZDEqxigZqO+1j8feScOW6Egf7LnpUamZalzfTVvh1TvKB+gzv/uZDHYmY2l8
         ubKfkyaOyd6LSXAkc09EOVOu//1AeHmNnHCc2qnyBrakav38Lr1qPI+hAOrUujcnnF
         4UuRFTZQXuaXPsZM+306z9dvoUPsKxor1q0lRHQ9g6wtVq5shMBfpJNq82RjtsaZ4d
         SIqKW6yUYN8FvbiF4SVy5mlFqBu5Mz2CibBmXrsoDmIqX4C6k7KawLa9tqt5zMjPOv
         mKl254xMWUJ50jpeHHi055bXDsaaHgoUi8+F/gzkA9x0puIlx6eRvMOOFPm+3j5gkN
         crOsk8TXN4p7g==
Date:   Sat, 15 Oct 2022 16:28:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: mcp3911: use correct id bits
Message-ID: <20221015162852.74d936fd@jic23-huawei>
In-Reply-To: <20221010194641.676484-1-marcus.folkesson@gmail.com>
References: <20221010194641.676484-1-marcus.folkesson@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Oct 2022 21:46:41 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> The device ID should be shifted 6 bits to left according to datasheet.
> 
> Fixes: 3a89b289df5d ("iio: adc: add support for mcp3911")
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Applied to the the fixes-togreg branch of iio.git.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/mcp3911.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> index e55db02c534f..2c1af11a621f 100644
> --- a/drivers/iio/adc/mcp3911.c
> +++ b/drivers/iio/adc/mcp3911.c
> @@ -57,8 +57,8 @@
>  /* Internal voltage reference in mV */
>  #define MCP3911_INT_VREF_MV		1200
>  
> -#define MCP3911_REG_READ(reg, id)	((((reg) << 1) | ((id) << 5) | (1 << 0)) & 0xff)
> -#define MCP3911_REG_WRITE(reg, id)	((((reg) << 1) | ((id) << 5) | (0 << 0)) & 0xff)
> +#define MCP3911_REG_READ(reg, id)	((((reg) << 1) | ((id) << 6) | (1 << 0)) & 0xff)
> +#define MCP3911_REG_WRITE(reg, id)	((((reg) << 1) | ((id) << 6) | (0 << 0)) & 0xff)
>  
>  #define MCP3911_NUM_CHANNELS		2
>  #define MCP3911_NUM_SCALES		6

