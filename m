Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE71F67777B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 10:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjAWJfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 04:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjAWJfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 04:35:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B72915C8F;
        Mon, 23 Jan 2023 01:35:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1686E60DEF;
        Mon, 23 Jan 2023 09:35:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3505C433EF;
        Mon, 23 Jan 2023 09:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674466551;
        bh=tC5u7WR8rBH0BR8LfZqsr5ySCjeVILLvKkXLo/zpAkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2RBHwufh+FL/iZ7Zcdjwa19fEb5T53MHB6nvJxKPyxI20s6NUKL1ZrgqKTOPQiRdH
         LLQV8duvET9KHZO3UDZwM4JiYJJvQw+dCtAdF+2hWEr0VUz2A+3hkERvZq6N925DjK
         YaI9hynwM/+3+Ce2elFYRlohF9Q1qoesuZnpQg8c=
Date:   Mon, 23 Jan 2023 10:35:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: qcom: enable vbus override when in OTG dr-mode
Message-ID: <Y85U9HSD6TIXFkg0@kroah.com>
References: <20230123-topic-sm8550-upstream-dwc3-qcom-otg-v1-1-e287a418aa5f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123-topic-sm8550-upstream-dwc3-qcom-otg-v1-1-e287a418aa5f@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 10:01:25AM +0100, Neil Armstrong wrote:
> With vbus override enabled when in OTG dr_mode, Host<->Peripheral
> switch now works on SM8550, otherwise the DWC3 seems to be stuck
> in Host mode only.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index b0a0351d2d8b..959fc925ca7c 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -901,7 +901,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>  	qcom->mode = usb_get_dr_mode(&qcom->dwc3->dev);
>  
>  	/* enable vbus override for device mode */
> -	if (qcom->mode == USB_DR_MODE_PERIPHERAL)
> +	if (qcom->mode != USB_DR_MODE_HOST)
>  		dwc3_qcom_vbus_override_enable(qcom, true);
>  
>  	/* register extcon to override sw_vbus on Vbus change later */
> 
> ---

What commit does this fix?  Should it go to stable kernels?

thanks,

greg k-h
