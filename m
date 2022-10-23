Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3585960929D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 14:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiJWMV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 08:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiJWMVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 08:21:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9728A68CC9;
        Sun, 23 Oct 2022 05:21:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77E6BB80D19;
        Sun, 23 Oct 2022 12:21:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6DDC433D6;
        Sun, 23 Oct 2022 12:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666527678;
        bh=+5uXa3urVH8Y3LmmLBi1OXbL0u8nSudPdsZY/o5A++M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qECakmbBgIDaoN4se6GIBoWsMCU1cIiEqJW6V+wQdQ/OIbtxNcVWJcnwth5ka1ueo
         ZMZ/6y/JYIiwdF34L3ozHOTJxWhB/u+0e2M8cGSJgy85zAuzkxVe4pcoaKAk48Gr5o
         uAhHt/OrvRsNSoMamBlCCo9Z3eXdoI28fgFPNsE/V0RX17wUkdCL/KM+FMvgmfSSjD
         UBQhs5kzO0aZdlEcJmG1O2/FAB6GJUydFr08+xRCpkG4irAflNnJDJ4AxlKewDQQUF
         MoYXu8UnhI6j2jftrHTJXHSQeLCP0leoimcQ7Q6gbpbUD09DMiyD8/rOnMJ/cYgC4l
         V8Bp2MKwSyr0Q==
Date:   Sun, 23 Oct 2022 13:21:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     <eugen.hristev@microchip.com>, <lars@metafoo.de>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: at91-sama5d2_adc: get rid of 5 degrees
 Celsius adjustment
Message-ID: <20221023132152.3d1dcedf@jic23-huawei>
In-Reply-To: <20221020102705.3639204-1-claudiu.beznea@microchip.com>
References: <20221020102705.3639204-1-claudiu.beznea@microchip.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Oct 2022 13:27:05 +0300
Claudiu Beznea <claudiu.beznea@microchip.com> wrote:

> On SAMA7G5 final chip version there is no need for 5 degrees Celsius
> adjustment when computing junction temperature, thus, remove it.
> 
> Fixes: 5ab38b81895c ("iio: adc: at91-sama5d2_adc: add support for temperature sensor")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan

> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 33e251552214..870f4cb60923 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -2307,11 +2307,9 @@ static int at91_adc_temp_sensor_init(struct at91_adc_state *st,
>  	clb->p6 = buf[AT91_ADC_TS_CLB_IDX_P6];
>  
>  	/*
> -	 * We prepare here the conversion to milli and also add constant
> -	 * factor (5 degrees Celsius) to p1 here to avoid doing it on
> -	 * hotpath.
> +	 * We prepare here the conversion to milli to avoid doing it on hotpath.
>  	 */
> -	clb->p1 = clb->p1 * 1000 + 5000;
> +	clb->p1 = clb->p1 * 1000;
>  
>  free_buf:
>  	kfree(buf);

