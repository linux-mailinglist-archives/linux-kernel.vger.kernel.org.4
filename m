Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D825707A99
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 09:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjERHIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 03:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjERHIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 03:08:46 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7874310CE
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:08:44 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-534696e4e0aso389387a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684393723; x=1686985723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UKiFSFjw8xYqHUe/pnmCRs0RBOFFEkd0OAe3p31QXng=;
        b=DoUpcNhJ4bYMR3s7xogVTR65VqfSH/jmTUk1M6WaXCZkceEV8HQ201/L9wE7GifLah
         i1stjicgfq9p3WPqzCtFFY4r+0f2TnSTm2E2zQ7Yq6HlxL9XSEGTk+0bK4lYkTCx3J4x
         8/c1z9NGuryVOB2YGTj6m3yOJGYcvVa5rmk0vT+FBXQdF6dzWIiwagM7V//MELgHtBFV
         hdbZZF4CiEuefvym6h9K64EybAmMof+VnMNEXCbKAbtX5btJWZg9OPhyAVqf3z7n3tgw
         QM/Bfo7S/Ml6qK+dEMcvagXBxo1Ri6RLOtc7vT9Y0G4CVC7JyAhl5CU7Zz6sAvFsqepE
         7T6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684393723; x=1686985723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKiFSFjw8xYqHUe/pnmCRs0RBOFFEkd0OAe3p31QXng=;
        b=KqBDozr/++bA+ZWT+KvhR9pOKo77B9bAjEDytaAS4Xl1m9hQY/PDYWppOLDNibV334
         Tkltchw04+S62CbOz76Ll4TTZ/f2uqjTLHIe9PCgEWywsqElT7MvD0fjlhLBoAS8ksVd
         88KWyy2s3GHq2M9cNClro7ujTZNcb7mIQsJTShmEIghm1B3NHQ0B9WMrAwLvraBiWa7T
         mOtzMExAPgjQ2fIPP5C3NUEBQZP/PcC9rk+ddNtAVio4RqTgyyrSFA+56rchovJYrIm+
         JkXk1RLnpGEq5AYpfA/PXcwgO5RwfBhVv6wGVi3FlCvVrR7kLAgCKJnUhAUvbxmYesMn
         SkNg==
X-Gm-Message-State: AC+VfDxVA2fm79LCD5lqANHyr07umRadcDxtAov128y3tqImLnYlYkvM
        EZGu3jnh/VcxIsy68wkBTAi0IA==
X-Google-Smtp-Source: ACHHUZ4AyLxxmlBDPza1bFAGnuxcsdIL1k3HTxyy3cRqsoS/sae9kGdUBJfSKQlqLLUCImua0EBJOw==
X-Received: by 2002:a17:902:c086:b0:1ae:56ff:758 with SMTP id j6-20020a170902c08600b001ae56ff0758mr1653056pld.19.1684393723521;
        Thu, 18 May 2023 00:08:43 -0700 (PDT)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id j21-20020a170902c3d500b001a0567811fbsm599565plj.127.2023.05.18.00.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 00:08:41 -0700 (PDT)
Date:   Thu, 18 May 2023 15:08:30 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Vladislav Efanov <VEfanov@ispras.ru>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] usb: dwc3: qcom: Fix potential memory leak
Message-ID: <20230518070830.GA1182568@dragon>
References: <20230517172518.442591-1-VEfanov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517172518.442591-1-VEfanov@ispras.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 08:25:18PM +0300, Vladislav Efanov wrote:
> Function dwc3_qcom_probe() allocates memory for resource structure
> which is pointed by parent_res pointer. This memory is not
> freed. This leads to memory leak. Use stack memory to prevent
> memory leak.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 2bc02355f8ba ("usb: dwc3: qcom: Add support for booting with ACPI")
> Signed-off-by: Vladislav Efanov <VEfanov@ispras.ru>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 959fc925ca7c..f52241883694 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -791,6 +791,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>  	struct device		*dev = &pdev->dev;
>  	struct dwc3_qcom	*qcom;
>  	struct resource		*res, *parent_res = NULL;
> +	struct resource		local_res;
>  	int			ret, i;
>  	bool			ignore_pipe_clk;
>  	bool			wakeup_source;
> @@ -842,9 +843,8 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>  	if (np) {
>  		parent_res = res;
>  	} else {
> -		parent_res = kmemdup(res, sizeof(struct resource), GFP_KERNEL);
> -		if (!parent_res)
> -			return -ENOMEM;
> +		memcpy(&local_res, res, sizeof(struct resource));
> +		parent_res = &local_res;
>  
>  		parent_res->start = res->start +
>  			qcom->acpi_pdata->qscratch_base_offset;
> -- 
> 2.34.1
> 
