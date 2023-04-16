Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0106E37FA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 14:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjDPM3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 08:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDPM3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 08:29:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9050271B;
        Sun, 16 Apr 2023 05:29:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7528960BA0;
        Sun, 16 Apr 2023 12:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9049DC433EF;
        Sun, 16 Apr 2023 12:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681648145;
        bh=5PL0hkKXz5ojQm8kj6YRRLyZRbwnEHLHp0vxMogvW30=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DiF+ue7KxEntambN+egSr8hBnXyi2SApEZa7wjWOUtCyfAy7+91zOLnnNdmMNo/Rt
         qN5aVsrGXDceTxS7F256H2nFCum+rocx4KMfAalo46QKMomhMKO/Ah726FE6oeDgNL
         PefGfZDeJV++dA4nmUt0p48JkXvbPOZkC5rV3JYO5H4lscUOQVOgeOkFBN8Z0c4umT
         On8O6pydCQ0y9fmzlWtnGMCiIdRLGXBU7+paPv9mG3o9tPIcFsV3cY7Q8fgXZilZ99
         Uvblx9/Hj3dIsrueAIFpqt5LNGSReone9cD1sKTN1w/0eyD64DVW3qAJAYeSfTlQOI
         IGH+F7J/UiDrQ==
Date:   Sun, 16 Apr 2023 13:29:06 +0100
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
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: mxs-lradc: fix the order of two cleanup
 operations
Message-ID: <20230416132906.4ec56e47@jic23-huawei>
In-Reply-To: <20230416072157.57388-1-jkluo@hust.edu.cn>
References: <20230416072157.57388-1-jkluo@hust.edu.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
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

On Sun, 16 Apr 2023 00:21:57 -0700
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
> v1->v2: exchange the order of mxs_lradc_adc_trigger_remove()
> and iio_triggered_buffer_cleanup() in error handling labels
Move your change log to after the --- marking below.

We don't want to retain that level of detail in the commit logs in the
git tree.

Thanks,

Jonathan

> 
> Fixes: 6dd112b9f85e ("iio: adc: mxs-lradc: Add support for ADC driver")
> Signed-off-by: Jiakai Luo <jkluo@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>  drivers/iio/adc/mxs-lradc-adc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
> index bca79a93cbe4..d32e9b1d03ce 100644
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

