Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75F3658767
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 23:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiL1Wy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 17:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiL1Wy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 17:54:26 -0500
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [5.144.164.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AAC14D36;
        Wed, 28 Dec 2022 14:54:24 -0800 (PST)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 1FB5F1F8BE;
        Wed, 28 Dec 2022 23:54:22 +0100 (CET)
Date:   Wed, 28 Dec 2022 23:54:10 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        agross@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2 RESEND] extcon: qcom-spmi: Switch to
 platform_get_irq_byname_optional
Message-ID: <20221228225410.dejid2ezu52xfzay@SoMainline.org>
References: <20221228133058.213886-1-bryan.odonoghue@linaro.org>
 <20221228133058.213886-3-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221228133058.213886-3-bryan.odonoghue@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-28 13:30:58, Bryan O'Donoghue wrote:
> Valid configurations for the extcon interrupt declarations are
> 
> - usb_id
> - usb_vbus
> - (usb_id | usb_vbus)
> 
> In the case of a standalone usb_id or usb_vbus failure to find one of the
> interrupts shouldn't generate a warning message. A warning is already in
> place if both IRQs are missing.
> 
> Switch to using platform_get_irq_byname_optional() in order to facilitate
> this behaviour.
> 
> Suggested-by: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

> ---
>  drivers/extcon/extcon-qcom-spmi-misc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-qcom-spmi-misc.c b/drivers/extcon/extcon-qcom-spmi-misc.c
> index eb02cb962b5e1..f72e90ceca53d 100644
> --- a/drivers/extcon/extcon-qcom-spmi-misc.c
> +++ b/drivers/extcon/extcon-qcom-spmi-misc.c
> @@ -123,7 +123,7 @@ static int qcom_usb_extcon_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	info->id_irq = platform_get_irq_byname(pdev, "usb_id");
> +	info->id_irq = platform_get_irq_byname_optional(pdev, "usb_id");
>  	if (info->id_irq > 0) {
>  		ret = devm_request_threaded_irq(dev, info->id_irq, NULL,
>  					qcom_usb_irq_handler,
> @@ -136,7 +136,7 @@ static int qcom_usb_extcon_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	info->vbus_irq = platform_get_irq_byname(pdev, "usb_vbus");
> +	info->vbus_irq = platform_get_irq_byname_optional(pdev, "usb_vbus");
>  	if (info->vbus_irq > 0) {
>  		ret = devm_request_threaded_irq(dev, info->vbus_irq, NULL,
>  					qcom_usb_irq_handler,
> -- 
> 2.34.1
> 
