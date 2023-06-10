Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED7272AAEC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 12:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbjFJKkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 06:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjFJKkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 06:40:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B06335B6;
        Sat, 10 Jun 2023 03:40:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFC2860A24;
        Sat, 10 Jun 2023 10:40:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03EEC433D2;
        Sat, 10 Jun 2023 10:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686393602;
        bh=r8AP7uSarwpq7WnXRU2o6hNIb1YSsBuKkaXUnHKOXCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XtToDoekY0U7TcT2sl67IYf4iNg7zioYwonvnwVxParKKBjYD+3tVoUX/9ye+Haqw
         fCJy68rXb+Y3kOEGB11QqOgtfGHBoxk5QkPz/SL9ek7Ns8//zR5qdRBdS6rblhrC1V
         seZ8rg21oVANEilNrCEaZZm4Yodgy7WNk+RLrfroKJg7y24700zchPVIc2wjji9ZL+
         9MlARA1OK2+PgjlrFm4bTlirXEV/vXkpIgHfYZ9awo7Zg2tpS4UIseBazGlsngxq06
         c7aKp2KYrhNzBXkrSE2VHu8j8+xTPfInEs4Nk3zAgkp4fk6iS7zZ2EQXTdrm9Rmhuy
         8UFnd67i8oHbA==
Date:   Sat, 10 Jun 2023 12:39:58 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Abraham <thomas.abraham@linaro.org>,
        Kukjin Kim <kgene.kim@samsung.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/2] tty: serial: samsung_tty: Fix a memory leak in
 s3c24xx_serial_getclk() when iterating clk
Message-ID: <20230610103958.jwfe45zm52ehiovn@intel.intel>
References: <e4359d5ef206f5b349c1d15a515a1205e78dda55.1686285892.git.christophe.jaillet@wanadoo.fr>
 <93bf8f574310256fcea50e5c5a62b5c37e20bb14.1686285892.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93bf8f574310256fcea50e5c5a62b5c37e20bb14.1686285892.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Fri, Jun 09, 2023 at 06:45:39AM +0200, Christophe JAILLET wrote:
> When the best clk is searched, we iterate over all possible clk.
> 
> If we find a better match, the previous one, if any, needs to be freed.
> If a better match has already been found, we still need to free the new
> one, otherwise it leaks.
> 
> Fixes: 5f5a7a5578c5 ("serial: samsung: switch to clkdev based clock lookup")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is speculative. Review with care.
> 
> I think that some clk_put() are also missing somewhere else in the driver
> but won't be able to investigate further.
> ---
>  drivers/tty/serial/samsung_tty.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index dd751e7010e3..c07877dd25fa 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -1488,10 +1488,18 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
>  			calc_deviation = -calc_deviation;
>  
>  		if (calc_deviation < deviation) {
> +			/*
> +			 * If we find a better clk, release the previous one, if
> +			 * any.
> +			 */
> +			if (!IS_ERR(*best_clk))

what is the case when *best_clk has an error in it?

Andi

> +				clk_put(*best_clk);
>  			*best_clk = clk;
>  			best_quot = quot;
>  			*clk_num = cnt;
>  			deviation = calc_deviation;
> +		} else {
> +			clk_put(clk);
>  		}
>  	}
>  
> -- 
> 2.34.1
> 
