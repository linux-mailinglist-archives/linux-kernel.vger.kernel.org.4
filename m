Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D07C721660
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 13:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjFDLeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 07:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFDLeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 07:34:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1D6AB;
        Sun,  4 Jun 2023 04:34:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A46E60ABA;
        Sun,  4 Jun 2023 11:34:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7063C433EF;
        Sun,  4 Jun 2023 11:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685878443;
        bh=TmYqv90JV/5RVpr86a0jBcnJ3Xnh4Xrw9tDBzgCEmFc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kAlAIVxr+BiLocZSjB4NES51dsI5kXEd1DyM2SDr3U+kIJIysG2C0cQU9aONoz4tW
         Ms/ozLlZ29/ERxEujzNxbNabmboSUKjY50OVnRjp7Kdvf0IcX9ISDHYGvI7XwVYVgq
         L/x9AsoAqr6ir0N/2mzuVR0THGTOewPJRbzasEu7GiV8zxk+Svh/KQoJ+ZhRiXUe44
         JQ7O/pO/2J1GFmxVmW2PQWmGIUJ+ExTxmbWI+yYSPrDdNXv8vH0/fLR0LdLBgX8AHn
         6HdXBM1dttEyT7lGW4pdtdJslv4YMCYzOYiTTgJeHDQZUDa8XanPPR2pK5aT9xYk+w
         f4Zq7OLenhSFA==
Date:   Sun, 4 Jun 2023 12:33:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     fl.scratchpad@gmail.com
Cc:     Alexandru Tachici <alexandru.tachici@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nuno Sa <nuno.sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 2/5] iio: adc: ad7192: Fix internal/external clock
 selection
Message-ID: <20230604123359.228cf043@jic23-huawei>
In-Reply-To: <20230530075311.400686-3-fl.scratchpad@gmail.com>
References: <20230530075311.400686-1-fl.scratchpad@gmail.com>
        <20230530075311.400686-3-fl.scratchpad@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2023 09:53:08 +0200
fl.scratchpad@gmail.com wrote:

> From: Fabrizio Lamarque <fl.scratchpad@gmail.com>
> 
> Fix wrong selection of internal clock when mclk is defined.
> 
> Resolve a logical inversion introduced in c9ec2cb328e3.
> 
> Fixes: c9ec2cb328e3 ("iio: adc: ad7192: use devm_clk_get_optional() for mclk")
> Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7192.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 94a9cf34a255..5a9c8898f8af 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -367,7 +367,7 @@ static int ad7192_of_clock_select(struct ad7192_state *st)
>  	clock_sel = AD7192_CLK_INT;
>  
>  	/* use internal clock */
> -	if (st->mclk) {
> +	if (!st->mclk) {
>  		if (of_property_read_bool(np, "adi,int-clock-output-enable"))
>  			clock_sel = AD7192_CLK_INT_CO;
>  	} else {

