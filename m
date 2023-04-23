Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFFA6EBEA1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 12:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjDWKfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 06:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDWKfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 06:35:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B237C2;
        Sun, 23 Apr 2023 03:35:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 257E860ECF;
        Sun, 23 Apr 2023 10:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004EFC433D2;
        Sun, 23 Apr 2023 10:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682246114;
        bh=/t2IHSC/v+053Pgf7JS+Fm0t1B1+XJZH42S5TetJxk4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aEv+vF3LLleJJP9IwbJK6UCwbGMm/EbstqE67Xs9MNhegUpT9ftAZ6APYLFskY8X3
         1wDhfB8+9001+TSiRNMlcKTE3hBNBshgnoATkqEIUJmeEoqRBAzPsAygQafyN+1gM6
         Pur/d214Upa9AEMebPhgvuRrPhNxHCXYbpnB7ODNmrEtdOtGcA5XQpVqYO0cz3hUeX
         6+mKRIejfAlKmfVXA3IM+xfnqXYNP0cH639tpY8R+bmFZ4vYPwHfFmE2RmOLZa69N0
         29+H2g5iYblJ5GBCuLiNrHtEXUjwLod6CTIAaBCaAy0CqW5menJ/Og8wFT63cW4PDT
         HBUm7yhmyMCAQ==
Date:   Sun, 23 Apr 2023 11:50:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jiakai Luo <jkluo@hust.edu.cn>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, Marek Vasut <marex@denx.de>,
        hust-os-kernel-patches@googlegroups.com, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: mxs-lradc: fix the order of two cleanup
 operations
Message-ID: <20230423115049.1c73600f@jic23-huawei>
In-Reply-To: <20230417024745.59614-1-jkluo@hust.edu.cn>
References: <20230417024745.59614-1-jkluo@hust.edu.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Apr 2023 19:47:45 -0700
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
If resending please state why.  I'm guessing on this occasion it was because
you realised a fresh thread is expected for a new patch.

Also, even if you are just amending the patch description, please increase
the version number so that we can be sure we are looking at latest version.

I already picked it from the earlier posting and this appears unchanged
so all's well that ends well!

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

