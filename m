Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A0867E55A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbjA0MfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbjA0MfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:35:18 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1324779CAA
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:35:08 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id q5so4881858wrv.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9unmXBFY2LCpkLlGduWq9KiCNNGjxWEAC2OciASOX1E=;
        b=avi5dm/0cmJyqN+xxxHp+8Bk5+Z/0VmWOTRq0yiY4UmeaZbB0sEmpQsuzYzmUYEXYo
         rONGzpHRgMrboJ5S3CudmhmAMuLNiHxpFO7EXjH62ns3oequ5SnEmiYkv5jcinvLwnUh
         dnFxIgQpXeoHK2Sla/LF3Q22J4Xtjgk0zq+lzeGYGdLZBj2Ya/Dxl4vuysRRJSUqJH9n
         rBkp9eAd40blim6iByp/eDjLqHipBXv3Rh7L43sb/AbU+s/K11urQs6eAqz5L4ZrApHg
         NpQ6sAHjqDBcRUFZlLIXMiTGjpQYVVUNXAc67SGRcZclkpoz2B+LdpFPTXcr2nhIAXap
         3Gog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9unmXBFY2LCpkLlGduWq9KiCNNGjxWEAC2OciASOX1E=;
        b=1JVwamFQgawB0WmgSSKFi/nLtpSuDSObmLIvTORqyGfTFLCCZqfduzyapm0vyO1mV+
         t7OSkl+5HJDNj5KT2BB3xD1d9vUvyNDdd6rQ8V21bylw5He8txsdA22cC1aml58c8D64
         3WcB9KsvBfM27I6ANUtFbyyks70hI+RGNU1cLirrnVymEY8hAtXbygDAQtuJ4QlI/yKe
         9PR5jewn1qf0fMSa+oeSag8YNlbvJHYEB8dNqYI7rUSaOIvgXJgaXS0f/Kzd+7GlR1F8
         c3ZR0OdnqUwHVuYi3pLJ2gL1FTa808eiE/lAsY50N/R80ydi/cIV0n3LuPHlNrYuCHNQ
         dkJA==
X-Gm-Message-State: AO0yUKW/zd7nISShI2uuk2RYJiEU9TUrKF5U4CL3UF0iaiigos7ovgvb
        7PbZHJhP0NXjsv4D09e87YN77A==
X-Google-Smtp-Source: AK7set8kgl+UYZC1EZtugC3b1RYbe7/NubWbi3C5CSEFCXcerqdM+Mga7HQqn4rbU0NMZK0hYx3Xcw==
X-Received: by 2002:a05:6000:1204:b0:2bf:b33b:fb7d with SMTP id e4-20020a056000120400b002bfb33bfb7dmr11183611wrx.61.1674822906604;
        Fri, 27 Jan 2023 04:35:06 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d514d000000b002be2f18938csm3732984wrt.41.2023.01.27.04.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 04:35:06 -0800 (PST)
Date:   Fri, 27 Jan 2023 14:35:04 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: qcom,dwc3: allow required-opps
Message-ID: <Y9PE+Hli/kLHW2Ag@linaro.org>
References: <20230127121122.342191-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127121122.342191-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-27 13:11:22, Krzysztof Kozlowski wrote:
> Few Qualcomm SoCs require minimum performance level of power domain, so
> allow it:
> 
>   sm8550-mtp.dtb: usb@a6f8800: 'required-opps' does not match any of the regexes: '^usb@[0-9a-f]+$', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> 
> ---
> 
> Cc: Abel Vesa <abel.vesa@linaro.org>
> ---
>  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> index a3f8a3f49852..4875c5b7d5b5 100644
> --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> @@ -58,6 +58,9 @@ properties:
>      description: specifies a phandle to PM domain provider node
>      maxItems: 1
>  
> +  required-opps:
> +    maxItems: 1
> +
>    clocks:
>      description: |
>        Several clocks are used, depending on the variant. Typical ones are::
> -- 
> 2.34.1
> 
