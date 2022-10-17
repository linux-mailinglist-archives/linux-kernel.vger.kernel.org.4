Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C98E601AD5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 23:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiJQVAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 17:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiJQVAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 17:00:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C9831211
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 14:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666040400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EygDVGyay5MzWnFDMTM7oi65lBsQCrO0TQPy2+eMMZk=;
        b=bcaOtOXWiPSC36r8d6I06h+N8tMmJ7iiI+IW2D9IprRwQmyhk0sMfjWwlQXuQuXOlBQd8s
        qX3o3ZvHP+QAF16GzemqupW2/rHMpFrc8cG/TciBHIss/w+0FKtZFIp9qWVoSrGx9ZYeIZ
        GrVr1wP9dfXW6sut4YkxXOPQ6ZfvtOg=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-623-OtOH4NvCOXmqXT_UssIeZg-1; Mon, 17 Oct 2022 16:59:59 -0400
X-MC-Unique: OtOH4NvCOXmqXT_UssIeZg-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1321b118ba0so4968034fac.19
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EygDVGyay5MzWnFDMTM7oi65lBsQCrO0TQPy2+eMMZk=;
        b=cEZcAEdddHzNWLIrIp/RlnJA5fRi7mA4d4szrpjSJPbhXKkvu0nmTDR2Bs9pHsDPTF
         evGolyUoDGVP9WJJUQF2OvcGZkecf+9XIhUW+/lxyzfYGRWG+G8ZJuEDTrHter0/jUB4
         21wPxM5cqfju00noXWZXEoXgnRa1MiPzDY8luqkB5oI9JzFaU/5D+WVI80sqgllVUK1g
         Hljxjt9G7K5ZpgMgk9mgm+INpv4FgMvAWmVxKjelqJL0RTOdVEVNTWRSKkfnIrQQI1ic
         jzrY+XjPGJVZur207I6L8Xx/okcUhu+OsCnqrhFy7fOeBK4zNlei+X4j83ChdhvmS0JK
         yyIg==
X-Gm-Message-State: ACrzQf2/og/F4RraW2qwp+nZjDeIyarNOk1Pa7UBBvpmB1c5fP/NXVOG
        DeP8ncX739dErhr50pgQ+X/7Czxu98n5KIFCyxmhVSl06HplX5TbnGgb3f0S3cbeLy7caXITv8W
        JGHZ9E3COn8MM8+fVNFDqCZxt
X-Received: by 2002:a05:6870:5713:b0:132:3552:43a2 with SMTP id k19-20020a056870571300b00132355243a2mr15953713oap.127.1666040398298;
        Mon, 17 Oct 2022 13:59:58 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6qh8GidqlmLIKsDCWTocvg6pBnU5dI+vEBmJGQGPA04e3wF/KsmRD2Mxs6+gOrSq54kDlekQ==
X-Received: by 2002:a05:6870:5713:b0:132:3552:43a2 with SMTP id k19-20020a056870571300b00132355243a2mr15953706oap.127.1666040398080;
        Mon, 17 Oct 2022 13:59:58 -0700 (PDT)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::21])
        by smtp.gmail.com with ESMTPSA id s4-20020a056870248400b00136cfb02a94sm5208998oaq.7.2022.10.17.13.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 13:59:57 -0700 (PDT)
Date:   Mon, 17 Oct 2022 15:59:55 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sc8280xp: fix USB PHY PCS registers
Message-ID: <20221017205955.7sd7zs6rr3rngwtt@halaney-x13s>
References: <20220919094454.1574-1-johan+linaro@kernel.org>
 <20220919094454.1574-4-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919094454.1574-4-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 11:44:53AM +0200, Johan Hovold wrote:
> With the current binding, the PCS register block (0x1400) needs to
> include the PCS_USB registers (0x1700).
> 
> Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 9667eb1b7c61..c734cac84719 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -1181,7 +1181,7 @@ usb_0_qmpphy: phy-wrapper@88ec000 {
>  			usb_0_ssphy: usb3-phy@88eb400 {
>  				reg = <0 0x088eb400 0 0x100>,
>  				      <0 0x088eb600 0 0x3ec>,
> -				      <0 0x088ec400 0 0x1f0>,
> +				      <0 0x088ec400 0 0x364>,
>  				      <0 0x088eba00 0 0x100>,
>  				      <0 0x088ebc00 0 0x3ec>,
>  				      <0 0x088ec200 0 0x18>;
> @@ -1243,7 +1243,7 @@ usb_1_qmpphy: phy-wrapper@8904000 {
>  			usb_1_ssphy: usb3-phy@8903400 {
>  				reg = <0 0x08903400 0 0x100>,
>  				      <0 0x08903600 0 0x3ec>,
> -				      <0 0x08904400 0 0x1f0>,
> +				      <0 0x08904400 0 0x364>,
>  				      <0 0x08903a00 0 0x100>,
>  				      <0 0x08903c00 0 0x3ec>,
>  				      <0 0x08904200 0 0x18>;
> -- 
> 2.35.1
> 

