Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C13691018
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjBISMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjBISMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:12:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E8468AD7
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 10:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675966278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LZy+J+rcrOSfXTsdoDz1dXzhYCRm1QK50PABySNIrxc=;
        b=RSEjxD6QUTfnwL/fVwbKj1ipmjmnW5lco7nEAcOP5IoTOGj61LmnW/PT6QHr7Q3Du60JOD
        tbrhzWSV/ZD+X0F76x/dsRciijLP84wP2m8QtnCiBahpAytKVKmpn6X5eheNp+C+3L3Q8W
        HfVe/QcjqTlfjGxWakJg7I3oRRqE22E=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-595-KQR3dmxgMHyuKkhtmaZ5SQ-1; Thu, 09 Feb 2023 13:11:17 -0500
X-MC-Unique: KQR3dmxgMHyuKkhtmaZ5SQ-1
Received: by mail-qt1-f197.google.com with SMTP id he22-20020a05622a601600b003ba3c280fabso1560247qtb.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 10:11:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZy+J+rcrOSfXTsdoDz1dXzhYCRm1QK50PABySNIrxc=;
        b=pUsBBApzBpMhXO5WMiRHzsbb9LWmenPDvG75pUv+dqz5dj4U/OMlRVMYMwhrs+SPhw
         fFSOhMtZaAj48WAW3lIKVo7QbyY+gRBnRjP3be2oMNQL3l4BYHr1mY0oRfvql+43HtWR
         Ty9dGdclTlHalH7DVl/alrbZLjEgBnhXB8VsDXlCysT22NfMy/a0pUEQFSIvT3PhBgNe
         DwBYFKVy2gg98JOMQ3+QW2VlRAdTRUcMoKM+Rsh/C8tC5mVKHrMNBf6q7JhBLqom1Xgn
         K6RDF4lgBp9QDaXr4iB0ovrL6/0N9I5+ofCu95WhQAABLBE4//ZYSVt36fB0hTBaUIkB
         tbhg==
X-Gm-Message-State: AO0yUKUauIJXbx67yPhi2RsRH0+LnWlmYqxomb65/UIYT/L3ODLx2bh5
        EkRXVSgHxmLhPiuWJ9AwXHZ012Qfm2UyucUmH6ZuU/+1eJNO+BNNCE3BbbQEpedWl2PKzRjcLYm
        RQ1tbA9YN1t9TSbZOxQKQAMjT
X-Received: by 2002:a05:622a:349:b0:3b8:58d0:b4e4 with SMTP id r9-20020a05622a034900b003b858d0b4e4mr21727856qtw.33.1675966276645;
        Thu, 09 Feb 2023 10:11:16 -0800 (PST)
X-Google-Smtp-Source: AK7set+OtThhRwwq7+xgc2rtsbWPWeQFKBLmPTMOot/fBAxyKrqK+AJlVuJgSX3ij9R9UMJ/37TyrQ==
X-Received: by 2002:a05:622a:349:b0:3b8:58d0:b4e4 with SMTP id r9-20020a05622a034900b003b858d0b4e4mr21727825qtw.33.1675966276384;
        Thu, 09 Feb 2023 10:11:16 -0800 (PST)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id ca16-20020a05622a1f1000b003a7e38055c9sm1698977qtb.63.2023.02.09.10.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 10:11:15 -0800 (PST)
Date:   Thu, 9 Feb 2023 13:11:15 -0500
From:   Eric Chanudet <echanude@redhat.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Shawn Guo <shawnguo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RESEND PATCH] arm64: defconfig: enable drivers required by the
 Qualcomm SA8775P platform
Message-ID: <20230209181115.t5lhtdewe2k2zh7i@echanude>
References: <20230209103531.469809-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209103531.469809-1-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 11:35:31AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Enable the pinctrl, GCC clock and interconnect drivers in order to allow
> booting SA8775P boards. The drivers need to be built-in for QUPv3 and
> subsequently UART console to work.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> Resending with tags collected and this time Cc'ing linux-arm-msm
> 
>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Eric Chanudet <echanude@redhat.com>

> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 695c4e44d241..8e0ce9915f01 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -566,6 +566,7 @@ CONFIG_PINCTRL_QCM2290=y
>  CONFIG_PINCTRL_QCS404=y
>  CONFIG_PINCTRL_QDF2XXX=y
>  CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
> +CONFIG_PINCTRL_SA8775P=y
>  CONFIG_PINCTRL_SC7180=y
>  CONFIG_PINCTRL_SC7280=y
>  CONFIG_PINCTRL_SC8180X=y
> @@ -1378,6 +1379,7 @@ CONFIG_INTERCONNECT_QCOM_MSM8916=m
>  CONFIG_INTERCONNECT_QCOM_MSM8996=m
>  CONFIG_INTERCONNECT_QCOM_OSM_L3=m
>  CONFIG_INTERCONNECT_QCOM_QCS404=m
> +CONFIG_INTERCONNECT_QCOM_SA8775P=y
>  CONFIG_INTERCONNECT_QCOM_SC7180=y
>  CONFIG_INTERCONNECT_QCOM_SC7280=y
>  CONFIG_INTERCONNECT_QCOM_SC8180X=y
> -- 
> 2.37.2
> 

-- 
Eric Chanudet

