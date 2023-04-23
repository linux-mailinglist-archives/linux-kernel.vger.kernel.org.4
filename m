Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91B26EBE94
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 12:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjDWKZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 06:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjDWKZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 06:25:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183EA10D9;
        Sun, 23 Apr 2023 03:25:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D6C260BFB;
        Sun, 23 Apr 2023 10:25:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749C2C433D2;
        Sun, 23 Apr 2023 10:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682245508;
        bh=gG3wOI4KVNr5mKVsWvDDGnE0DJ0ZKHEcpo3Oos6yAIs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GbVfjDWzDbeehwM7nmxuQgsi7su8hdftFhBXHiznT8AuBcvqAddZliHhd22rK2Vt3
         iZ5Fe+p06byZ5ccyAA269Jdl7QYlW/W3c6PO5LoK0GEu6tGHYUyQCjDVbzIR6IYTCD
         FrG1Tu6Iuq+ym5p5LFK7Lzgowu6pVP3G7tL4S912WJ1gyGQ6bgxaGX/V7ZRCbqg4jF
         3U2aU1s7hskxJlyiWlj6lU0i6HJz5s5G8Hlp4Yg+TMQFnx+Tih4ACmXOAXey2Qpmjy
         xrHgSU2ppwxz/U+Zytaof8PxkE061EQq2A60Y+bUrVC2c3mOiA21Kj+qemkSuWclnX
         ZMJ/H8f8Ui5rw==
Date:   Sun, 23 Apr 2023 11:40:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jiakai Luo <jkluo@hust.edu.cn>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lee Jones <lee.jones@linaro.org>, Marek Vasut <marex@denx.de>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        hust-os-kernel-patches@googlegroups.com, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: mxs-lradc: fix the order of two cleanup
 operations
Message-ID: <20230423114043.72fe2891@jic23-huawei>
In-Reply-To: <20230422133407.72908-1-jkluo@hust.edu.cn>
References: <20230416132906.4ec56e47@jic23-huawei>
        <20230422133407.72908-1-jkluo@hust.edu.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Apr 2023 06:34:06 -0700
Jiakai Luo <jkluo@hust.edu.cn> wrote:

> Smatch reports:
> drivers/iio/adc/mxs-lradc-adc.c:766 mxs_lradc_adc_probe() warn:
> missing unwind goto?
> 
> the order of three init operation:
> 1.mxs_lradc_adc_trigger_init
> 2.iio_triggered_buffer_setup
> 3.mxs_lradc_adc_hw_init
> 
> thus, the order of three cleanup operation should be:
> 1.mxs_lradc_adc_hw_stop
> 2.iio_triggered_buffer_cleanup
> 3.mxs_lradc_adc_trigger_remove
> 
> we exchange the order of two cleanup operations,
> introducing the following differences:
> 1.if mxs_lradc_adc_trigger_init fails, returns directly;
> 2.if trigger_init succeeds but iio_triggered_buffer_setup fails,
> goto err_trig and remove the trigger.
> 
> In addition, we also reorder the unwind that goes on in the
> remove() callback to match the new ordering.
> 
> Fixes: 6dd112b9f85e ("iio: adc: mxs-lradc: Add support for ADC driver")
> Signed-off-by: Jiakai Luo <jkluo@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>

Applied to the fixes-togreg branch of iio.git and marked for backporting to
stable. At this stage I'll probably wait until around rc1 to send out a pull
request with this in.  

Thanks,

Jonathan

> ---
> The issue is found by static analysis and remains untested.
> ---
>  drivers/iio/adc/mxs-lradc-adc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
> index bca79a93cbe4..85882509b7d9 100644
> --- a/drivers/iio/adc/mxs-lradc-adc.c
> +++ b/drivers/iio/adc/mxs-lradc-adc.c
> @@ -757,13 +757,13 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
>  
>  	ret = mxs_lradc_adc_trigger_init(iio);
>  	if (ret)
> -		goto err_trig;
> +		return ret;
>  
>  	ret = iio_triggered_buffer_setup(iio, &iio_pollfunc_store_time,
>  					 &mxs_lradc_adc_trigger_handler,
>  					 &mxs_lradc_adc_buffer_ops);
>  	if (ret)
> -		return ret;
> +		goto err_trig;
>  
>  	adc->vref_mv = mxs_lradc_adc_vref_mv[lradc->soc];
>  
> @@ -801,9 +801,9 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
>  
>  err_dev:
>  	mxs_lradc_adc_hw_stop(adc);
> -	mxs_lradc_adc_trigger_remove(iio);
> -err_trig:
>  	iio_triggered_buffer_cleanup(iio);
> +err_trig:
> +	mxs_lradc_adc_trigger_remove(iio);
>  	return ret;
>  }
>  
> @@ -814,8 +814,8 @@ static int mxs_lradc_adc_remove(struct platform_device *pdev)
>  
>  	iio_device_unregister(iio);
>  	mxs_lradc_adc_hw_stop(adc);
> -	mxs_lradc_adc_trigger_remove(iio);
>  	iio_triggered_buffer_cleanup(iio);
> +	mxs_lradc_adc_trigger_remove(iio);
> 
>  	return 0;
>  }

