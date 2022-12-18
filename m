Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D6E64FE9D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 12:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiLRLNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 06:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiLRLNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 06:13:23 -0500
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D10BC34
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 03:13:21 -0800 (PST)
Received: from [192.168.2.144] (adsl-d248.84-47-10.t-com.sk [84.47.10.248])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id D0C773EE52;
        Sun, 18 Dec 2022 12:13:18 +0100 (CET)
Date:   Sun, 18 Dec 2022 12:13:13 +0100
From:   Martin Botka <martin.botka@somainline.org>
Subject: Re: [PATCH] thermal: qcom-spmi-adc5: Suppress probe-deferral error
 message
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Robert Marko <robimarko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nuno =?iso-8859-1?b?U+E=?= <nuno.sa@analog.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <1633NR.JIUCB2Y1JAXI3@somainline.org>
In-Reply-To: <20221216190945.902754-1-marijn.suijten@somainline.org>
References: <20221216190945.902754-1-marijn.suijten@somainline.org>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,RCVD_IN_SORBS_HTTP,
        RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, Dec 16 2022 at 08:09:45 PM +01:00:00, Marijn Suijten 
<marijn.suijten@somainline.org> wrote:
> Much like 807efb7102e8 ("thermal: qcom-spmi-adc-tm5: suppress
> probe-deferral error message") the ADC5 driver also spams a similar
> probe-deferral error on startup when a channel is not yet available:
> 
>     [    0.343136] qcom-spmi-adc-tm5 1c40000.spmi:pmic@0:adc-tm@3500: 
> get dt data failed: -517
> 
> Suppress it by using dev_err_probe instead, which also takes care of
> storing the message as reason for deferring.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  drivers/iio/adc/qcom-spmi-adc5.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c 
> b/drivers/iio/adc/qcom-spmi-adc5.c
> index 821fee60a765..69cc36004b5a 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> @@ -894,10 +894,8 @@ static int adc5_probe(struct platform_device 
> *pdev)
>  	mutex_init(&adc->lock);
> 
>  	ret = adc5_get_fw_data(adc);
> -	if (ret) {
> -		dev_err(dev, "adc get dt data failed\n");
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "adc get dt data failed\n");
> 
Reviewed-by: Martin Botka <martin.botka@somainline.org>

-Martin
>  	irq_eoc = platform_get_irq(pdev, 0);
>  	if (irq_eoc < 0) {
> --
> 2.39.0
> 


